Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2405E1C2EC1
	for <lists+linux-api@lfdr.de>; Sun,  3 May 2020 21:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgECT0A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 3 May 2020 15:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728843AbgECT0A (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 3 May 2020 15:26:00 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5578C061A0E
        for <linux-api@vger.kernel.org>; Sun,  3 May 2020 12:25:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVKFP-000FSq-46; Sun, 03 May 2020 19:25:55 +0000
Date:   Sun, 3 May 2020 20:25:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-api@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: [RFC] get_mempolicy(2) behaviour
Message-ID: <20200503192555.GT23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

	Behaviour of get_mempolicy(2) with nmask != NULL is
bloody weird.  It doesn't match the manpage (and never had) _and_
it doesn't match the behaviour of compat variant.

	For native (both 32bit and 64bit host) there are two cases
when it fails with -EINVAL - namely, maxnode being less than the
actual number of nodes and maxnode being greater than PAGE_SIZE * 8 + 1.
Otherwise, it stores ((maxnode - 1) rounded up to 64) bits, with
the actual bitmap in the beginning and zeroes padding it.  So far,
so good, except that
	* having maxnode = 64k + 1 equal to actual number of nodes
will quietly lose the last bit of bitmap.
	* manpage says "maxnode specifies the number of node IDs
that can be stored into nodemask --- that is, the maximum node ID plus one.
The value specified by maxnode is always rounded to a multiple of
sizeof(unsigned long)*8".  It's actually rounded to a multiple
of 64, whether we are on 32bit or on a 64bit host.

	Compat is different.  While the first case where native would've
failed with -EINVAL (maxnode less than the actual number of nodes) still
gives the same error, the second case (maxnode being huge) does not fail
at all.

	Worse, the amount we actually store is
((maxnode - 1) rounded up to 8) bits if maxnode greater than the actual
number of nodes *and* ((maxnode - 1) rounded up to 32) bits if
maxnode is equal to the actual number of bits.  And the case of quietly
lost bit is also slightly different from the native one - it's still
"maxnode is equal to the actual number of nodes", but here it needs
to be 1 + multiple of 32.

	At the very least, compat behaviour ought to match what the native
syscall wouldn't done on 32bit host.  And having the manpage match
the reality would be nice as well.  Should we do something about the
cases when the data gets quietly lost?

	Comments?
