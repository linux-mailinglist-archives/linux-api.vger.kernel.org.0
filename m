Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EEB1EA81C
	for <lists+linux-api@lfdr.de>; Mon,  1 Jun 2020 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgFARFN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Jun 2020 13:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgFARFM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Jun 2020 13:05:12 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07E0C03E97C
        for <linux-api@vger.kernel.org>; Mon,  1 Jun 2020 10:05:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id s88so94831pjb.5
        for <linux-api@vger.kernel.org>; Mon, 01 Jun 2020 10:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCNZoB5OxQ7hnqTLfie1dXM/QF4pMxzLCuwCLG5Qfss=;
        b=vegupm7j++bcQ7i5qomamK4/m4XhO1MABSaGH10ckRBmWq+grPaIgDahZjbqzvDWYc
         3yf8QRVv7J4Y+Ud2phWybNxSOCMB67r+b6JJeBn8xlqsCQQZEVUmM5tSdFhJirSL/hOc
         Z8jCKNVR1wYBwqZACg2XqcaZOwqyEKYiJ6nls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RCNZoB5OxQ7hnqTLfie1dXM/QF4pMxzLCuwCLG5Qfss=;
        b=sK/avyuoB876K+hcRvHLhiIaRtAV05xwIPT1/wc+5eI0MUgQppyzn4BRs900BPiuBk
         Mrp5tfeKZVtdEMtR4BCwoJ4HeRnMIPJ/GvOQL+3wpqF3LOZv5V+swTzsuDw2MD1cqXu5
         u8RC9TnSuWvCI8Xl3c71m+jxjVHbz8hCEjOVlzZ1h/xAaCr8rNXjBPoGezBCwU1tUMPW
         BUiucgeRBwtpqncwH7lfCNO5FQ5ZvCmoQ7g8/+7fR44+AjjUwVGAOIKjQdFniLiEq/0b
         cXT+qBkyMnoNk9kRcLuengXP0JYVOWuWhywP6Gao7F7vdk22Le7ikHxZ/vdby6Oc2keP
         Oyfw==
X-Gm-Message-State: AOAM530fqe+bl/F2vAwQvNP/XFOyDz+JZAN2L0JCSrfk5pXZz1DqIhjd
        HVM04RzorQqZ8thU0eF6eX0/iA==
X-Google-Smtp-Source: ABdhPJznLtUa4LZ7g35GyCI7/xjwaHcB435LJsAY3C3ioqnx7kNkFoy3Z7n3o6gr2EPy9nrmnWQAvA==
X-Received: by 2002:a17:90b:806:: with SMTP id bk6mr425484pjb.122.1591031109833;
        Mon, 01 Jun 2020 10:05:09 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m5sm12080pjn.56.2020.06.01.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:05:09 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     containers@lists.linux-foundation.org, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sargun Dhillon <sargun@sargun.me>, viro@zeniv.linux.org.uk,
        christian.brauner@ubuntu.com, cyphar@cyphar.com, jannh@google.com,
        jeffv@google.com, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH v3] seccomp: Add find_notification helper
Date:   Mon,  1 Jun 2020 04:25:32 -0700
Message-Id: <20200601112532.150158-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
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
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Tycho Andersen <tycho@tycho.ws>
Cc: Matt Denton <mpdenton@google.com>
Cc: Kees Cook <keescook@google.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Robert Sesek <rsesek@google.com>,
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Tycho Andersen <tycho@tycho.ws>
---
 kernel/seccomp.c | 55 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..cc6b47173a95 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -41,6 +41,7 @@
 #include <linux/tracehook.h>
 #include <linux/uaccess.h>
 #include <linux/anon_inodes.h>
+#include <linux/lockdep.h>
 
 enum notify_state {
 	SECCOMP_NOTIFY_INIT,
@@ -1021,10 +1022,27 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/* must be called with notif_lock held */
+static inline struct seccomp_knotif *
+find_notification(struct seccomp_filter *filter, u64 id)
+{
+	struct seccomp_knotif *cur;
+
+	lockdep_assert_held(&filter->notify_lock);
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
 
@@ -1078,15 +1096,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
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
-
+		knotif = find_notification(filter, unotif.id);
 		if (knotif) {
 			knotif->state = SECCOMP_NOTIFY_INIT;
 			up(&filter->notif->request);
@@ -1101,7 +1112,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 				void __user *buf)
 {
 	struct seccomp_notif_resp resp = {};
-	struct seccomp_knotif *knotif = NULL, *cur;
+	struct seccomp_knotif *knotif;
 	long ret;
 
 	if (copy_from_user(&resp, buf, sizeof(resp)))
@@ -1118,13 +1129,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 	if (ret < 0)
 		return ret;
 
-	list_for_each_entry(cur, &filter->notif->notifications, list) {
-		if (cur->id == resp.id) {
-			knotif = cur;
-			break;
-		}
-	}
-
+	knotif = find_notification(filter, resp.id);
 	if (!knotif) {
 		ret = -ENOENT;
 		goto out;
@@ -1150,7 +1155,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 				    void __user *buf)
 {
-	struct seccomp_knotif *knotif = NULL;
+	struct seccomp_knotif *knotif;
 	u64 id;
 	long ret;
 
@@ -1161,16 +1166,12 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	if (ret < 0)
 		return ret;
 
-	ret = -ENOENT;
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
+	else
+		ret = -ENOENT;
 
-out:
 	mutex_unlock(&filter->notify_lock);
 	return ret;
 }
-- 
2.25.1

