Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3F2912C0EE
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 07:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfL2Gma (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 01:42:30 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:36604 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfL2Gma (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 01:42:30 -0500
Received: by mail-io1-f66.google.com with SMTP id r13so18971301ioa.3
        for <linux-api@vger.kernel.org>; Sat, 28 Dec 2019 22:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0Z0dzWXfYmv1MZISl995szlypcV1JN5XmeCvDe3UI4=;
        b=qDEKzvfwEtvUK1sZj0kol39+WvM1y4QJiY6qATq9nnFWKEdLrqBWOLergWtnox4apg
         7VFa3MBZVBLaTy0z+PahHElPhxHTlr+SQuF/KCafBoV6icyAkB5+MRcoMOwkjfG7/xSW
         lzpqXEfbcRFi1TgEduRi7/jyz89okZaPd0lBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0Z0dzWXfYmv1MZISl995szlypcV1JN5XmeCvDe3UI4=;
        b=qSOb0xXXWMmdzy4Wq+QUQfpOTAsqJjIUX5g+jkFTyLafQblMtk23RBRh28lGFcJCFs
         FMTpX9/InEtm0fedFcKQjb78s8Wy/DoQdBc5cI1BnHkjbr+eDZWgmi4QLLJfUguUDNwP
         c+aZJy3T8SxBCQSBi5UeN/sVjLaBCrZC0HZ8JKAlDW4EnoBzERz1m3hili3IWS6knZRK
         mys6imFiElswI29LpQCqkgqL+QgvZJBTET01lQGbB5Dz4XET/OQLEE0ovgYanPAiz2qO
         A/IRXaKLtVjSFmTuc9RNwyDCJJro9/d8gfhQeXdEEYR8QB+nWe54tJhxEFmaoGgJSh7U
         vy9w==
X-Gm-Message-State: APjAAAWkxBXCAVQCee08GioynWg97OV1Q2v/ikLs8PN2/9RtxEsnBDPH
        UfURYHrfSmVG4fOy4sqvaDI6iw==
X-Google-Smtp-Source: APXvYqyrvzDtn4z6wePqUb6+sIbFSYCnxY7w57QNc0seB6BT9Oezi+8gsVtIaVBAbxTx3+58YhxWCQ==
X-Received: by 2002:a5d:97c3:: with SMTP id k3mr23684707ios.38.1577601749431;
        Sat, 28 Dec 2019 22:42:29 -0800 (PST)
Received: from ubuntu.netflix.com ([75.104.68.239])
        by smtp.gmail.com with ESMTPSA id y11sm15112053ilp.46.2019.12.28.22.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 22:42:28 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH v3 1/3] samples, selftests/seccomp: Zero out seccomp_notif
Date:   Sat, 28 Dec 2019 22:24:49 -0800
Message-Id: <20191229062451.9467-1-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The seccomp_notif structure should be zeroed out prior to calling the
SECCOMP_IOCTL_NOTIF_RECV ioctl. Previously, the kernel did not check
whether these structures were zeroed out or not, so these worked.

This patch zeroes out the seccomp_notif data structure prior to calling
the ioctl.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
---
 samples/seccomp/user-trap.c                   | 2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/samples/seccomp/user-trap.c b/samples/seccomp/user-trap.c
index 6d0125ca8af7..3e31ec0cf4a5 100644
--- a/samples/seccomp/user-trap.c
+++ b/samples/seccomp/user-trap.c
@@ -298,7 +298,6 @@ int main(void)
 		req = malloc(sizes.seccomp_notif);
 		if (!req)
 			goto out_close;
-		memset(req, 0, sizeof(*req));
 
 		resp = malloc(sizes.seccomp_notif_resp);
 		if (!resp)
@@ -306,6 +305,7 @@ int main(void)
 		memset(resp, 0, sizeof(*resp));
 
 		while (1) {
+			memset(req, 0, sizeof(*req));
 			if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
 				perror("ioctl recv");
 				goto out_resp;
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 6944b898bb53..f53f14971bff 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3278,6 +3278,7 @@ TEST(user_notification_signal)
 
 	close(sk_pair[1]);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	EXPECT_EQ(kill(pid, SIGUSR1), 0);
@@ -3296,6 +3297,7 @@ TEST(user_notification_signal)
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), -1);
 	EXPECT_EQ(errno, ENOENT);
 
+	memset(&req, 0, sizeof(req));
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 
 	resp.id = req.id;
-- 
2.20.1

