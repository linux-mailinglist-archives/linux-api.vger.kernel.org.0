Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 597954FB44
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 13:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfFWL2C (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 23 Jun 2019 07:28:02 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:39540 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWL2C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 23 Jun 2019 07:28:02 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 93EAC72CC6C;
        Sun, 23 Jun 2019 14:28:00 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 893797CCE2E; Sun, 23 Jun 2019 14:28:00 +0300 (MSK)
Date:   Sun, 23 Jun 2019 14:28:00 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] samples: make pidfd-metadata fail gracefully on older
 kernels
Message-ID: <20190623112800.GB20697@altlinux.org>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
 <20190623112717.GA20697@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190623112717.GA20697@altlinux.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Initialize pidfd to an invalid descriptor, to fail gracefully on
those kernels that do not implement CLONE_PIDFD and leave pidfd
unchanged.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 samples/pidfd/pidfd-metadata.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/pidfd/pidfd-metadata.c b/samples/pidfd/pidfd-metadata.c
index 14b454448429..c459155daf9a 100644
--- a/samples/pidfd/pidfd-metadata.c
+++ b/samples/pidfd/pidfd-metadata.c
@@ -83,7 +83,7 @@ static int pidfd_metadata_fd(pid_t pid, int pidfd)
 
 int main(int argc, char *argv[])
 {
-	int pidfd = 0, ret = EXIT_FAILURE;
+	int pidfd = -1, ret = EXIT_FAILURE;
 	char buf[4096] = { 0 };
 	pid_t pid;
 	int procfd, statusfd;
@@ -91,7 +91,11 @@ int main(int argc, char *argv[])
 
 	pid = pidfd_clone(CLONE_PIDFD, &pidfd);
 	if (pid < 0)
-		exit(ret);
+		err(ret, "CLONE_PIDFD");
+	if (pidfd == -1) {
+		warnx("CLONE_PIDFD is not supported by the kernel");
+		goto out;
+	}
 
 	procfd = pidfd_metadata_fd(pid, pidfd);
 	close(pidfd);
-- 
ldv
