Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0546D10C9
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 16:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJIOGM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 10:06:12 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47104 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOGL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Oct 2019 10:06:11 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iICbH-0002Ll-NT; Wed, 09 Oct 2019 14:05:59 +0000
Date:   Wed, 9 Oct 2019 15:05:59 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Waiman Long <longman@redhat.com>,
        Andi Kleen <ak@linux.intel.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH] off-by-one in get_mempolicy(2)
Message-ID: <20191009140559.GY26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

	get_mempolicy(2) and related syscalls have always passed
1 + number of bits in nodemask as maxnodes argument - see e.g.
copy_nodes_to_user() and get_nodes().  Or libnuma, for the userland
side -
static void getpol(int *oldpolicy, struct bitmask *bmp)
{
        if (get_mempolicy(oldpolicy, bmp->maskp, bmp->size + 1, 0, 0) < 0)
                numa_error("get_mempolicy");
}
and similar for other syscalls.  However, the check for insufficient
destination size in get_mempolicy(2) used to be
        if (nmask != NULL && maxnode < MAX_NUMNODES)
                return -EINVAL;
IOW, maxnode == MAX_NUMNODES (representing "MAX_NUMNODES - 1 bits")
had been accepted.  The reason why that hadn't messed libnuma
logics used to determine the required bitmap size is that
MAX_NUMNODES is always a power of 2 and the loop in libnuma
is
                nodemask_sz = 16;
                do {
                        nodemask_sz <<= 1;
                        mask = realloc(mask, nodemask_sz / 8);
                        if (!mask)
                                return;
                } while (get_mempolicy(&pol, mask, nodemask_sz + 1, 0, 0) < 0 && errno == EINVAL &&
                                nodemask_sz < 4096*8);
I.e. it's been passing 33, 65, 127, etc. until it got it large enough.
That sidesteps the boundary case - we never try to pass exactly
MAX_NUMNODES there.

However, that has changed recently, when get_mempolicy() switched
to 
        if (nmask != NULL && maxnode < nr_node_ids)
                return -EINVAL;
_That_ can trigger.  Consider a box with nr_node_ids == 65.
The first call in libnuma:set_nodemask_size() loop will
pass 33 and fail, then we'll raise nodemask_sz to 64,
allocate a 64bit mask and call get_mempolicy(&pol, mask, 65, 0, 0),
which will succeed.  OK, so we decide to use 64bit bitmaps, and
subsequent getpol() will be passing 65 to get_mempolicy(2).  Which
is not a good idea, since kernel-side we'll get
	copy_nodes_to_user(nmask, 65, &nodes)
And that will copy only 8 bytes out of kernel-side bitmap with
65 bits in it...

IOW, that check always should had been <=, not <; it didn't matter
until commit 050c17f239fd ("numa: change get_mempolicy() to use
nr_node_ids instead of MAX_NUMNODES") this year.  The fix is trivial
- we need to make that check consistent with the code that does
actual copyin/copyout.

Fixes: 050c17f239fd ("numa: change get_mempolicy() to use nr_node_ids instead of MAX_NUMNODES")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967bcf954..e184df7633b0 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1561,7 +1561,7 @@ static int kernel_get_mempolicy(int __user *policy,
 
 	addr = untagged_addr(addr);
 
-	if (nmask != NULL && maxnode < nr_node_ids)
+	if (nmask != NULL && maxnode <= nr_node_ids)
 		return -EINVAL;
 
 	err = do_get_mempolicy(&pval, &nodes, addr, flags);
