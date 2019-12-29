Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD2112C0F2
	for <lists+linux-api@lfdr.de>; Sun, 29 Dec 2019 07:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfL2Gmz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 29 Dec 2019 01:42:55 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33946 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfL2Gmz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 29 Dec 2019 01:42:55 -0500
Received: by mail-il1-f196.google.com with SMTP id s15so25597794iln.1
        for <linux-api@vger.kernel.org>; Sat, 28 Dec 2019 22:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bjv6BKmHq7jafW5njryuF9SNoXnHToQ8eDKjbZ/26wg=;
        b=Cwv3pV7nJDx/EkUC5nl4IfPMY+aLsaQqK3divT+i7fyLPimlHU5TMp9Enfu9GG0rSa
         1fUMsgJWKvegTwR8hlcLFSZXymsaw/5UHGwOR9+2QOELzBKRVqCrz1cnW1nwB2MtorqE
         aaFpvqOQO0hrwxfhfPnTQMZOOiiN1YYvOTxQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bjv6BKmHq7jafW5njryuF9SNoXnHToQ8eDKjbZ/26wg=;
        b=a62dFbPrO83ijt1m33gp46DtbgqHwcoh6W+VA0JiKBr6jCqfLJX6kojaGNGyv/J0ae
         fecCfnRytsTCP9Hc9ViaqX09aBsIqiOpF2g25t2wdrExuQEQx6fFehCQ1SP1x0fC39+n
         33XoSE3bJXSBV5/efT/UQwyCT9GpccZxYYxP8tTzFLG33O9w3GX43Nq7HBHwtDi2+0Tk
         z1IiGv6V5g8y6UNaVoB2pndc6SlNG+JcYX/gkB2EKRdOebe8a/9d9LSohabygEjNQVS3
         Mjs8/EXVlGYEdnz/r5O0I3viKhPnCaIkwYYinbMI+rwskvUBemB69+nE6wUCwsGHPrsQ
         Y0nA==
X-Gm-Message-State: APjAAAXdHUhllNIlWXRTh/qOZqUlAepX4uzUkbtf9mT8QaMKxdxj40cR
        SOTsAkkNXNRO+0bVI/BOON9eGLRbMjqNwg==
X-Google-Smtp-Source: APXvYqxWxEN3dlFMkquUlSmmjp7WmwS69IxBWHajCkhjfVYSlUAbJP/ndC/DxkVIZxgM8IDuqvbWXA==
X-Received: by 2002:a92:d451:: with SMTP id r17mr51402716ilm.201.1577601774268;
        Sat, 28 Dec 2019 22:42:54 -0800 (PST)
Received: from ubuntu.netflix.com ([75.104.68.239])
        by smtp.gmail.com with ESMTPSA id y11sm15112053ilp.46.2019.12.28.22.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 22:42:53 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on SECCOMP_IOCTL_NOTIF_RECV
Date:   Sat, 28 Dec 2019 22:24:51 -0800
Message-Id: <20191229062451.9467-3-sargun@sargun.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191229062451.9467-1-sargun@sargun.me>
References: <20191229062451.9467-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a self-test to make sure that the kernel returns EINVAL, if any
of the fields in seccomp_notif are set to non-null.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index f53f14971bff..379391a7fa41 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3601,6 +3601,29 @@ TEST(user_notification_continue)
 	}
 }
 
+TEST(user_notification_garbage)
+{
+	/*
+	 * intentionally set pid to a garbage value to make sure the kernel
+	 * catches it
+	 */
+	struct seccomp_notif req = {
+		.pid	= 1,
+	};
+	int ret, listener;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_trap_syscall(__NR_dup, SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	EXPECT_EQ(-1, ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req));
+	EXPECT_EQ(EINVAL, errno);
+}
+
 /*
  * TODO:
  * - add microbenchmarks
-- 
2.20.1

