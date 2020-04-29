Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E381BDD7D
	for <lists+linux-api@lfdr.de>; Wed, 29 Apr 2020 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgD2NYE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Apr 2020 09:24:04 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgD2NYD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Apr 2020 09:24:03 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MDv1A-1jM2us3zwy-009zpL; Wed, 29 Apr 2020 15:23:55 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH] [v2] ARM: oabi-compat: fix epoll_ctl build failure
Date:   Wed, 29 Apr 2020 15:23:24 +0200
Message-Id: <20200429132349.1294904-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YesVeQBh9Q/IA+uNWz/5JCdSN2u4hoTMC5shuvSJ4yxM1Q6iwui
 wXUQ5wEe7ndWD4fD5QG/iF3Y8iVx9+DoiTgHcTG3Zt64TuTyLiawqer+CYnMad2oEvSXwMI
 2/lferA/lpp5qT7D4jF7OFcvNkdsovgGrDcKxXLycrOrO6KrgW7Et+inVFPWiWkeSGciNNC
 JwsBwNoMFhx1RLcB8D5wA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oM3nSM6auHQ=:YMn63bge2D4TN2BuE+kKP0
 JrAZ/FMokb4p0ZyrHUM4qR0NA28gOEyw9/frW6jIeZT9ZFzUTawj2+BG78WMhpuK+40T/RSSi
 nNPR+JiuYxNF2J4vY+3fAd51EFTWauTu5xMoGWOVySj3WOoLr1TLsr1kfC/bMNNZQVbL2AgJw
 bx2vYWsjclCyCUq1jqykhL/t9/Cc3GiMiq4qKUpW+1N524zStvlFqfR1yT6S7tiO4viaeK+iW
 60LSU6yk/eR2RMtxXOFAwYh6ufSwp1wNRYnXByk/0rzo7Fc4ObZLWMwS31G13se7u66vX1DuD
 Yc0usPp7QFqq16Tw25wwEc6SD8vmVrxo08WIO/S4qJx4LYMA8u2OH4lZfbpLbsRjyvAXjdopb
 LtQ3tGT8dmx5BhhIHIyjNLC+CN9eRy7Swp33GF9+A6cq+TpY8nZZdd6Cc/16i6I+NGjVE5YlQ
 hvOeF8fZr0al6jqNcfZP75cwdEFDINBNT/CsVRIADuORToS0JJRutEoPjf1cBQ8/x9/mfPFCo
 75mrVhTY792ttYUO+IpdlAA3CN7npw7CvbxsGwYNdomtrepM7ZyDTeJXyo4LD51gjqSz7yKAP
 NXUYYaQliD7yVdZMKhk/akMo0fmTLNHvFXpxqMQ5gYKH6VJimNzGDQJRuDK/qZmWCkY9UTOJn
 W9g1yj2Y3kHglEvm9g18lAN1lgDAfE4uC4XCxEKXSn7kiKtdNvqX4tuIeeFnV1A6P+IZ+6C5/
 6T2KeFyMhQ0NuMvcKWmwGzHAuOyOsW7az6PZcsNoNpFFmz1aK9wArASmf6BSOGjuhMGivRGTx
 wcVEG1X2v99IGprRPFLEIinmJsYOld7tuS1C17jp6XpwTgDyfM=
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Two functions are not declared or defined when CONFIG_EPOLL is
disabled:

arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_ctl':
arch/arm/kernel/sys_oabi-compat.c:258:6: error: implicit declaration of function 'ep_op_has_event' [-Werror=implicit-function-declaration]
  258 |  if (ep_op_has_event(op) &&
      |      ^~~~~~~~~~~~~~~
arch/arm/kernel/sys_oabi-compat.c:265:9: error: implicit declaration of function 'do_epoll_ctl'; did you mean 'sys_epoll_ctl'? [-Werror=implicit-function-declaration]
  265 |  return do_epoll_ctl(epfd, op, fd, &kernel, false);
      |         ^~~~~~~~~~~~
      |         sys_epoll_ctl

Replace the function with the sys_ni_syscall stub in this case.

Fixes: c281634c8652 ("ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: use sys_ni_syscall() instead of removing the function body
---
 arch/arm/kernel/sys_oabi-compat.c | 2 ++
 kernel/sys_ni.c                   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 85a1e95341d8..2488c69242cf 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -249,6 +249,7 @@ struct oabi_epoll_event {
 	__u64 data;
 } __attribute__ ((packed,aligned(4)));
 
+#ifdef CONFIG_EPOLL
 asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 				   struct oabi_epoll_event __user *event)
 {
@@ -264,6 +265,7 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 
 	return do_epoll_ctl(epfd, op, fd, &kernel, false);
 }
+#endif
 
 asmlinkage long sys_oabi_epoll_wait(int epfd,
 				    struct oabi_epoll_event __user *events,
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 42ce28c460f6..9ee6a46b1795 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -68,6 +68,7 @@ COND_SYSCALL(epoll_create1);
 COND_SYSCALL(epoll_ctl);
 COND_SYSCALL(epoll_pwait);
 COND_SYSCALL_COMPAT(epoll_pwait);
+COND_SYSCALL(oabi_epoll_ctl); /* ARM OABI specific */
 
 /* fs/fcntl.c */
 
-- 
2.26.0

