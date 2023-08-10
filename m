Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7B5777398
	for <lists+linux-api@lfdr.de>; Thu, 10 Aug 2023 11:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjHJJA5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Aug 2023 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjHJJAu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Aug 2023 05:00:50 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90E7212E
        for <linux-api@vger.kernel.org>; Thu, 10 Aug 2023 02:00:49 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5899ed05210so8370707b3.3
        for <linux-api@vger.kernel.org>; Thu, 10 Aug 2023 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google; t=1691658049; x=1692262849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhCwChUdW+kQSsQMPFv0FkCeW3f89FoYStWBaJ2lFDw=;
        b=ejt1WRXT7sjbs/F4PWX12TpHeCBzvmZNTiji01GRoAf6p8OfbmoNb03PAbbBN/RLCQ
         VBYnNI84L4OFthSqaNge4vLFjBAuxNTlVmqf6V8U0YE3IDL3ZNXO8wRf4251cHAWHgpx
         dNUTQ+gTdkT8PD0qLlRmwako1iqQmFp+9SC1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658049; x=1692262849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhCwChUdW+kQSsQMPFv0FkCeW3f89FoYStWBaJ2lFDw=;
        b=EGIDs4nea9nndr1CWba3dS4UAW3281rhubK545Qwn7cmbFR2Zq3J2hd6jVKg1BLDRQ
         TdIX19ZXyIwbHZaoDF3SK54W43rQcv81lSoRWqtiSyJ7Ey88nkGgtXxthkzzVGZ7GTq7
         wE1+n23T/iYmvflAu+FgNunJ+dvcKPX7JxXLehErRatDdBb79sbL6Ud7klhZXkDHr22Y
         GupdDYz6ycCmeSpkRpySwCT3XCG4DCQFaDgQIPbybJmTqH/htaYrIYzlurZhOInTjM6H
         CbdJjz5cTxbPgxBavPxArvNWGQHGtZ9xS3hkqF+ssXNhiwPW+HoQgb6Q6M7RSTyDBQGo
         0nkw==
X-Gm-Message-State: AOJu0YxsnkF15mimHRgMoZlLktlpUpiAGeeC8S06doG64HWvze2F8RJl
        9lr1iQ69uF5fGJKgI+n7vgkoHw==
X-Google-Smtp-Source: AGHT+IEzO4K5faVNFigcDyW6hll/UVc7um7t3yi3jJ4R3UygLeWV+/6P2JT4hnOiSx37vE28TI8m4A==
X-Received: by 2002:a0d:ef82:0:b0:56d:5272:d540 with SMTP id y124-20020a0def82000000b0056d5272d540mr1798917ywe.46.1691658048803;
        Thu, 10 Aug 2023 02:00:48 -0700 (PDT)
Received: from localhost (fwdproxy-frc-006.fbsv.net. [2a03:2880:21ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id j125-20020a819283000000b00586ba973bddsm233884ywg.110.2023.08.10.02.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:00:48 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH 3/3] selftests/mount_setattr: Add tests for mount locking API
Date:   Thu, 10 Aug 2023 02:00:44 -0700
Message-Id: <20230810090044.1252084-3-sargun@sargun.me>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230810090044.1252084-1-sargun@sargun.me>
References: <20230810090044.1252084-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This adds tests to lock specific flags in place, and verifies that
the expected rules hold.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/include/uapi/linux/mount.h              |  1 +
 .../mount_setattr/mount_setattr_test.c        | 42 +++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 4d93967f8aea..66f302019373 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -135,5 +135,6 @@ struct mount_attr {
 
 /* List of all mount_attr versions. */
 #define MOUNT_ATTR_SIZE_VER0	32 /* sizeof first published struct */
+#define MOUNT_ATTR_SIZE_VER1	40
 
 #endif /* _UAPI_LINUX_MOUNT_H */
diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index 2aaa4aae41f5..3411fe17400b 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1551,4 +1551,46 @@ TEST_F(mount_setattr, mount_attr_lock)
 	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
 }
 
+TEST_F(mount_setattr, mount_attr_do_lock)
+{
+	struct mount_attr attr = {};
+
+	attr.attr_lock = MOUNT_ATTR_NODIRATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	attr.attr_lock = MOUNT_ATTR__ATIME;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Do not allow locking unset locks */
+	attr.attr_lock = MOUNT_ATTR_NOEXEC;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Set and lock at the same time */
+	attr.attr_set = MOUNT_ATTR_NOEXEC;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
+	ASSERT_EQ(errno, EINVAL);
+
+	memset(&attr, 0, sizeof(attr));
+	/* Make sure we can't clear noexec now (that locking worked) */
+	attr.attr_clr = MOUNT_ATTR_NOEXEC;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_set = MOUNT_ATTR_NODEV;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
+
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_lock = MOUNT_ATTR_NODEV;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), 0);
+
+	/* Make sure we can't clear MOUNT_ATTR_NODEV */
+	memset(&attr, 0, sizeof(attr));
+	attr.attr_clr = MOUNT_ATTR_NODEV;
+	ASSERT_EQ(sys_mount_setattr(-1, "/tmp/C", 0, &attr, sizeof(attr)), -1);
+	ASSERT_EQ(errno, EPERM);
+}
 TEST_HARNESS_MAIN
-- 
2.39.3

