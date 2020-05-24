Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4301E03E8
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2020 01:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbgEXXju (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 May 2020 19:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbgEXXjt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 May 2020 19:39:49 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DCDC061A0E
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:49 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so853812pjb.5
        for <linux-api@vger.kernel.org>; Sun, 24 May 2020 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xTPagZOTK2S3jx+U1S0sGHfFCrpHZOdN2FHjkt5W9h0=;
        b=rONxcso2Qpa31SDJFqeSUaNb156ofU+GfeVBBF+GldVsK9lgC0ia8mzKU+9jw5POyg
         HF7tm01nWoK0wZxoM5plbkrLAjjC24jjlVQXKvvjsULJoXQIvNGI/4O4OG1ciF9VGvuO
         OIqKD+VXmCxXJnoPOt6SPHX8rfh8h/84NhRU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xTPagZOTK2S3jx+U1S0sGHfFCrpHZOdN2FHjkt5W9h0=;
        b=KGTuMzREc1VpJVZC7AqUV0ENsfFm7jFDU8MFDv+tpkeJxwq860ihigWKIrreOFvc36
         CPGSgB0GMtMTZVXmLqfytzbOKJi9+D2RIrXzRnUDf6Bw7nnsyKEvPuLlMBry7EGXo12A
         gLbJxn92BeJrsiyXFGj6S4UPGPmOeIbmIsQ00dtQtFX3wR1ZcElB1Y62iA+A10G4gt0+
         Z/MzAz34F0SD3FrC0qWrjfmCX6rZJ56R8W5pW4NzvSvGIws4bjGqR2/A8w91iAqy0g49
         EvRr4c7PCucvg0ndCZ+F/lBGN6Bunk7Olor+ByR+WepKv8i/nzZ5tssPMUfGypLlx9lE
         Hh6g==
X-Gm-Message-State: AOAM533baQerhLrYLVNu4CX1Juhj27xVOaA+Ui11TjsvbhZzcf0EcPbI
        MI6/KudI+xS1QG2MkUjfBQFHzQ==
X-Google-Smtp-Source: ABdhPJzWtL7TuXdqTlb6leuvmop1VO5g7a6qozueRELbYccAIsIIHTbQxZr15Zr5JaWx+cGm7cv7TA==
X-Received: by 2002:a17:90a:a588:: with SMTP id b8mr13701654pjq.100.1590363588694;
        Sun, 24 May 2020 16:39:48 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b16sm11633177pfi.74.2020.05.24.16.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:39:48 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        tycho@tycho.ws, keescook@chromium.org, cyphar@cyphar.com,
        Jeffrey Vander Stoep <jeffv@google.com>, jannh@google.com,
        rsesek@google.com, palmer@google.com,
        Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH 1/5] seccomp: Add find_notification helper
Date:   Sun, 24 May 2020 16:39:38 -0700
Message-Id: <20200524233942.8702-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524233942.8702-1-sargun@sargun.me>
References: <20200524233942.8702-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds a helper which can iterate through a seccomp_filter to
find a notification matching an ID. It removes several replicated
chunks of code.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Matt Denton <mpdenton@google.com>
Cc: Kees Cook <keescook@google.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Robert Sesek <rsesek@google.com>,
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Tycho Andersen <tycho@tycho.ws>
---
 kernel/seccomp.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..f6ce94b7a167 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1021,10 +1021,25 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/* must be called with notif_lock held */
+static inline struct seccomp_knotif *
+find_notification(struct seccomp_filter *filter, u64 id)
+{
+	struct seccomp_knotif *cur;
+
+	list_for_each_entry(cur, &filter->notif->notifications, list) {
+		if (cur->id == id)
+			return cur;
+	}
+
+	return NULL;
+}
+
+
 static long seccomp_notify_recv(struct seccomp_filter *filter,
 				void __user *buf)
 {
-	struct seccomp_knotif *knotif = NULL, *cur;
+	struct seccomp_knotif *knotif, *cur;
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
@@ -1078,14 +1093,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		 * may have died when we released the lock, so we need to make
 		 * sure it's still around.
 		 */
-		knotif = NULL;
 		mutex_lock(&filter->notify_lock);
-		list_for_each_entry(cur, &filter->notif->notifications, list) {
-			if (cur->id == unotif.id) {
-				knotif = cur;
-				break;
-			}
-		}
+		knotif = find_notification(filter, unotif.id);
 
 		if (knotif) {
 			knotif->state = SECCOMP_NOTIFY_INIT;
@@ -1150,7 +1159,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 				    void __user *buf)
 {
-	struct seccomp_knotif *knotif = NULL;
+	struct seccomp_knotif *knotif;
 	u64 id;
 	long ret;
 
@@ -1162,15 +1171,10 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 		return ret;
 
 	ret = -ENOENT;
-	list_for_each_entry(knotif, &filter->notif->notifications, list) {
-		if (knotif->id == id) {
-			if (knotif->state == SECCOMP_NOTIFY_SENT)
-				ret = 0;
-			goto out;
-		}
-	}
+	knotif = find_notification(filter, id);
+	if (knotif && knotif->state == SECCOMP_NOTIFY_SENT)
+		ret = 0;
 
-out:
 	mutex_unlock(&filter->notify_lock);
 	return ret;
 }
-- 
2.25.1

