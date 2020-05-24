Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236701E03EF
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388645AbgEXXkA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388638AbgEXXj7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:39:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE74C061A0E
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id s69so7799627pjb.4
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkFh/ltuSCZKIpIsO7Tn/NDZKFXDGHYiyontlywtpfI=;
        b=B/rL+GXXoD44Y6uC2o+7L7Oll3ncoP77DkflU7CuMOMuhPAZaZciH9ThUWMLEvGGBG
         x4ETO+xogPGVns5rOqi3OHrxKqd38kf21jjmtBh6zLTkl2r4PFT3l1IXWk2LKVFC0z/s
         H7UPaMvZIqV81Wc9A9E3woy/X5pPxB5bGHHSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkFh/ltuSCZKIpIsO7Tn/NDZKFXDGHYiyontlywtpfI=;
        b=LL5+EqDsQWSU3u1jlwAaclq4hs2xmup4+7YmRbjdUW1N1EUD8J4NHqC7YcvFT24kKA
         GarVcafDzhMwIZ/qSZFUhEBr7DFcdUAM6F9Ew0tpS4VFAq35ahgsJYVu2/I29EUZ2Q0F
         7XkaMBNOFynLNXyxaCI+WcV1GxFO6TGfmc7CM0jLTf5bm/mEVfsg7uNB66aqKj84MZZx
         yb8rnN9Dj7v43tKpA0hL56M/c8+Ligm1PebAgxuV1F5Zi2TAX/2NivMQEuhR5aZjUQ2G
         AJSI3+5+zxBRF/0etUOzYuULckD97xBt+CqHKMVh8CiHufRPA5EBt4Go9IEr4Cj7rBMV
         d3yA==
X-Gm-Message-State: AOAM533GZQb6mQcUok0nD67Q9J4/5ynXwLS1tbpn2jDf0QS51GxS6j7h
        QCjz18MWz4SabrKy8j3nID9hHg==
X-Google-Smtp-Source: ABdhPJwBufPMMSq2FzfVicuZKcyjLpKWsnUxla7t5SgLM6ZIGnT0jxlSJEN6fWz3vHMbU2n/z5+rnw==
X-Received: by 2002:a17:902:c3ca:: with SMTP id j10mr25898350plj.242.1590363598683;
        Sun, 24 May 2020 16:39:58 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b16sm11633177pfi.74.2020.05.24.16.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:39:58 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH 5/5] selftests/seccomp: Add test for addfd move semantics
Date:   Sun, 24 May 2020 16:39:42 -0700
Message-Id: <20200524233942.8702-6-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524233942.8702-1-sargun@sargun.me>
References: <20200524233942.8702-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This introduces another call to addfd, in which the move flag is set. It
may make sense to setup a cgroup v1 hierarchy, and check that the
netprioidx is changed.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Matt Denton <mpdenton@google.com>
Cc: Kees Cook <keescook@google.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Robert Sesek <rsesek@google.com>,
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 1ec43fef2b93..f4b50cbbde42 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -188,6 +188,8 @@ struct seccomp_metadata {
 
 /* valid flags for seccomp_notif_addfd */
 #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
+#define SECCOMP_ADDFD_FLAG_MOVE		(1UL << 1)
+
 
 struct seccomp_notif {
 	__u64 id;
@@ -3756,6 +3758,12 @@ TEST(user_notification_sendfd)
 	EXPECT_GE(ret, 0);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, ret), 0);
 
+	/* Move the FD */
+	addfd.flags = SECCOMP_ADDFD_FLAG_MOVE;
+	ret = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+	EXPECT_GE(ret, 0);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, ret), 0);
+
 	/* Verify we can set a specific remote fd */
 	addfd.remote_fd = 42;
 	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
-- 
2.25.1

