Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5704FB42
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 13:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfFWL1V (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 23 Jun 2019 07:27:21 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:38974 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWL1U (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 23 Jun 2019 07:27:20 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A6F4F72CC6C;
        Sun, 23 Jun 2019 14:27:17 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 91AC37CCE2E; Sun, 23 Jun 2019 14:27:17 +0300 (MSK)
Date:   Sun, 23 Jun 2019 14:27:17 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] CLONE_PIDFD: do not use the value pointed by
 parent_tidptr
Message-ID: <20190623112717.GA20697@altlinux.org>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Userspace needs a cheap and reliable way to tell whether CLONE_PIDFD
is supported by the kernel or not.

While older kernels without CLONE_PIDFD support just leave unchanged
the value pointed by parent_tidptr, current implementation fails with
EINVAL if that value is non-zero.

If CLONE_PIDFD is supported and fd 0 is closed, then mandatory pidfd == 0
pointed by parent_tidptr also remains unchanged, which effectively
means that userspace must either check CLONE_PIDFD support beforehand
or ensure that fd 0 is not closed when invoking CLONE_PIDFD.

The check for pidfd == 0 was introduced during v5.2 release cycle
by commit b3e583825266 ("clone: add CLONE_PIDFD") to ensure that
CLONE_PIDFD could be potentially extended by passing in flags through
the return argument.

However, that extension would look horrendous, and with introduction of
clone3 syscall in v5.3 there is no need to extend legacy clone syscall
this way.

So remove the pidfd == 0 check.  Userspace that needs to be portable
to kernels without CLONE_PIDFD support is advised to initialize pidfd
with -1 and check the pidfd value returned by CLONE_PIDFD.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 kernel/fork.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6df..39a3adaa4ad1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1822,8 +1822,6 @@ static __latent_entropy struct task_struct *copy_process(
 	}
 
 	if (clone_flags & CLONE_PIDFD) {
-		int reserved;
-
 		/*
 		 * - CLONE_PARENT_SETTID is useless for pidfds and also
 		 *   parent_tidptr is used to return pidfds.
@@ -1834,16 +1832,6 @@ static __latent_entropy struct task_struct *copy_process(
 		if (clone_flags &
 		    (CLONE_DETACHED | CLONE_PARENT_SETTID | CLONE_THREAD))
 			return ERR_PTR(-EINVAL);
-
-		/*
-		 * Verify that parent_tidptr is sane so we can potentially
-		 * reuse it later.
-		 */
-		if (get_user(reserved, parent_tidptr))
-			return ERR_PTR(-EFAULT);
-
-		if (reserved != 0)
-			return ERR_PTR(-EINVAL);
 	}
 
 	/*
-- 
ldv
