Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3123DBAA9
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbhG3Oeb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jul 2021 10:34:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239226AbhG3Oea (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 30 Jul 2021 10:34:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2B2860F01;
        Fri, 30 Jul 2021 14:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627655665;
        bh=4DbDZVvUc+dbG0q9uR6ZqemnYmAhCvAn9+VRYxBJhvI=;
        h=From:To:Cc:Subject:Date:From;
        b=jZShBguZ6BrdR0jEvzi2jvnkksMWgh+zXosfmgZiqUARHrTF6kfh8PMj0TK2WaEuX
         eHQRWFgkOQIpv2JaOd+83Y8KBuhUgeYRezWyaDdS/vTcUljIFrrPBLEZYojy0RCbzy
         mN0DJXZQ0dnGCZsjcQpIAP6Am2CkLWc4W8Wq9AUrjHzQ4n4UdLAefDvAePtEUX0dWT
         SBP1k1zeZfvbY9KsdrthXqjB09OP50cSuTqvCPyAbADj6lH4DvFd/RYS+O9OtcmnmS
         gdQbAxdhHCDg4oZwZNI4tPZqNyoO/+nrqCv+PikfvRuQZZeKDKXMGscu7ve4CAFhSa
         G2E9rUn+kcyxg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-mm@kvack.org, kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Hocko <mhocko@suse.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Feng Tang <feng.tang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fixup! mm: simplify compat numa syscalls
Date:   Fri, 30 Jul 2021 16:19:46 +0200
Message-Id: <20210730143417.3700653-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When compat user space asks for more data than the kernel
has in its nodemask, get_mempolicy() now either leaks kernel
stack data to user space or, if either VMAP_STACK or KASAN
are enabled, causes a crash like

Unable to handle kernel pointer dereference in virtual kernel address space
Failing address: 0000038003e7c000 TEID: 0000038003e7c803
Fault in home space mode while using kernel ASCE.
AS:00000001fb388007 R3:000000008021c007 S:0000000082142000 P:0000000000000400
Oops: 0011 ilc:3 [#1] SMP
CPU: 0 PID: 1017495 Comm: get_mempolicy Tainted: G           OE     5.14.0-20210730.rc3.git0.4ccc9e2db7ac.300.fc34.s390x+next #1
Hardware name: IBM 2827 H66 708 (LPAR)
Krnl PSW : 0704e00180000000 00000001f9f11000 (compat_put_bitmap+0x48/0xd0)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
Krnl GPRS: 0000000000810000 0000000000000000 000000007d9df1c0 0000038003e7c008
           0000000000000004 000000007d9df1c4 0000038003e7be40 0000000000010000
           0000000000008000 0000000000000000 0000000000000390 00000000000001c8
           000000020d6ea000 000002aa00401a48 00000001fa0a85fa 0000038003e7bd50
Krnl Code: 00000001f9f10ff4: a7bb0001            aghi    %r11,1
           00000001f9f10ff8: 41303008            la      %r3,8(%r3)
          #00000001f9f10ffc: 41502004            la      %r5,4(%r2)
          >00000001f9f11000: e3103ff8ff04        lg      %r1,-8(%r3)
           00000001f9f11006: 5010f0a4            st      %r1,164(%r15)
           00000001f9f1100a: a50e0081            llilh   %r0,129
           00000001f9f1100e: c8402000f0a4        mvcos   0(%r2),164(%r15),%r4
           00000001f9f11014: 1799                xr      %r9,%r9
Call Trace:
 [<00000001f9f11000>] compat_put_bitmap+0x48/0xd0
 [<00000001fa0a85fa>] kernel_get_mempolicy+0x102/0x178
 [<00000001fa0a86b0>] __s390_sys_get_mempolicy+0x40/0x50
 [<00000001fa92be30>] __do_syscall+0x1c0/0x1e8
 [<00000001fa939148>] system_call+0x78/0xa0
Last Breaking-Event-Address:
 [<0000038003e7bc00>] 0x38003e7bc00
Kernel panic - not syncing: Fatal exception: panic_on_oops

Fix it by copying the correct size in compat mode again.

Cc: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/lkml/YQPLG20V3dmOfq3a@osiris/
Fixes: (mmotm) mm: simplify compat numa syscalls
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4fabf2dddbc0..0d1f3be32723 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1438,6 +1438,7 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
 			return -EFAULT;
 		copy = nbytes;
+		maxnode = nr_node_ids;
 	}
 
 	if (compat)
-- 
2.29.2

