Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2783FE0D1
	for <lists+linux-api@lfdr.de>; Wed,  1 Sep 2021 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345692AbhIARDB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Sep 2021 13:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345708AbhIARC6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Sep 2021 13:02:58 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF69C0617A8
        for <linux-api@vger.kernel.org>; Wed,  1 Sep 2021 10:02:00 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id e7so36028plh.8
        for <linux-api@vger.kernel.org>; Wed, 01 Sep 2021 10:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwHxj9Xi4C+TLgPi3wh17jEDX38Lnf/lJiqq6WOKjQM=;
        b=w7H1P9HAcx3zdp1J6fPWSTpNeTUMutz1B3HKXqUfwHoKZeRC+e0h/jCFf7f6Uq1NRs
         ZoxVKSJsQZ7HB40WMDuJsCgEZyYM0eoK4koUGR4M2T/Wj4lUdiO2UVDSz36DFBkNUg2O
         clop2ni3b7k/2+/Z1EbDxZsRdW+yKaYAhESzrLiFvQcE+hMboPzRhUqsyX8KVKOXLL+f
         mpnp0Ppt0KiGhgNEVWHzVX3xz8b5bBf+Esz7TvbUawkjEtqiPr40LmZmt7r2ekXze6vl
         vnmpDOQaEEd+a53l4qzOJdd72im72AwINdZUuf50hVn72eH453pgp0RrFtarECBmv3M3
         KxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwHxj9Xi4C+TLgPi3wh17jEDX38Lnf/lJiqq6WOKjQM=;
        b=s7Irg6NywWiGc2tJ9Z7IhmF87/TPx8pnfEen1aToki3BDQTFw1TlWP8Fe/WmcZszPe
         Rn+AzYR8rSkCuPqQrYwuJoDuFkQfItgrqrH/PORreMfTmLmT4TuCjyUDTGPfN7Wrxaqb
         W2AfB8aqzlIyiHA8Brzhr3q/GJmyM863jiQkmR7xUN5Sxz85ZwsVTOux/ybfFa5ePNg2
         ev8Ga92AjM5C1csYTmM4ct2/SGlnIqM7yWaMHY0GW0tgJ+1pkctpnh2FXPcpSEuEraTr
         vxB0luTpV4OroWN6/ImyHo5hneblZEl595bZc4d1hZHL4xICovooQqNVBoToXrOkzNGP
         Vtyw==
X-Gm-Message-State: AOAM530hp6hAhD74YN0UY28CySA5avvM5xsqGDYSaRekSjvGA0L68W0J
        aNqWXSg5ZEzXDaW/8iBhY7qpQw==
X-Google-Smtp-Source: ABdhPJwIxwKF/i6oX/dqFWQ0qVq/xqTxo0A6v6IuAKMjXEtz8X/N4yoBP/v0z7+222lFGg6OCd6z+Q==
X-Received: by 2002:a17:90a:d595:: with SMTP id v21mr343100pju.50.1630515719723;
        Wed, 01 Sep 2021 10:01:59 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:a2b2])
        by smtp.gmail.com with ESMTPSA id y7sm58642pff.206.2021.09.01.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 10:01:59 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH v11 07/10] btrfs-progs: receive: process fallocate commands
Date:   Wed,  1 Sep 2021 10:01:16 -0700
Message-Id: <d37fc365eda31317abe6ef89be534d6b5effc0b7.1630515568.git.osandov@fb.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1630514529.git.osandov@fb.com>
References: <cover.1630514529.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Boris Burkov <boris@bur.io>

Send stream v2 can emit fallocate commands, so receive must support them
as well. The implementation simply passes along the arguments to the
syscall. Note that mode is encoded as a u32 in send stream but fallocate
takes an int, so there is a unsigned->signed conversion there.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 cmds/receive-dump.c  |  9 +++++++++
 cmds/receive.c       | 25 +++++++++++++++++++++++++
 common/send-stream.c |  9 +++++++++
 common/send-stream.h |  2 ++
 4 files changed, 45 insertions(+)

diff --git a/cmds/receive-dump.c b/cmds/receive-dump.c
index 20ec2b70..acc0ba32 100644
--- a/cmds/receive-dump.c
+++ b/cmds/receive-dump.c
@@ -329,6 +329,14 @@ static int print_encoded_write(const char *path, const void *data, u64 offset,
 			  unencoded_offset, compression, encryption);
 }
 
+static int print_fallocate(const char *path, int mode, u64 offset, u64 len,
+			   void *user)
+{
+	return PRINT_DUMP(user, path, "fallocate",
+			  "mode=%d offset=%llu len=%llu",
+			  mode, offset, len);
+}
+
 struct btrfs_send_ops btrfs_print_send_ops = {
 	.subvol = print_subvol,
 	.snapshot = print_snapshot,
@@ -352,4 +360,5 @@ struct btrfs_send_ops btrfs_print_send_ops = {
 	.utimes = print_utimes,
 	.update_extent = print_update_extent,
 	.encoded_write = print_encoded_write,
+	.fallocate = print_fallocate,
 };
diff --git a/cmds/receive.c b/cmds/receive.c
index 2eebcfd1..953d7217 100644
--- a/cmds/receive.c
+++ b/cmds/receive.c
@@ -1264,6 +1264,30 @@ static int process_encoded_write(const char *path, const void *data, u64 offset,
 				    compression);
 }
 
+static int process_fallocate(const char *path, int mode, u64 offset, u64 len,
+			     void *user)
+{
+	int ret;
+	struct btrfs_receive *rctx = user;
+	char full_path[PATH_MAX];
+
+	ret = path_cat_out(full_path, rctx->full_subvol_path, path);
+	if (ret < 0) {
+		error("fallocate: path invalid: %s", path);
+		return ret;
+	}
+	ret = open_inode_for_write(rctx, full_path);
+	if (ret < 0)
+		return ret;
+	ret = fallocate(rctx->write_fd, mode, offset, len);
+	if (ret < 0) {
+		ret = -errno;
+		error("fallocate: fallocate on %s failed: %m", path);
+		return ret;
+	}
+	return 0;
+}
+
 static struct btrfs_send_ops send_ops = {
 	.subvol = process_subvol,
 	.snapshot = process_snapshot,
@@ -1287,6 +1311,7 @@ static struct btrfs_send_ops send_ops = {
 	.utimes = process_utimes,
 	.update_extent = process_update_extent,
 	.encoded_write = process_encoded_write,
+	.fallocate = process_fallocate,
 };
 
 static int do_receive(struct btrfs_receive *rctx, const char *tomnt,
diff --git a/common/send-stream.c b/common/send-stream.c
index 044e101b..bc41396e 100644
--- a/common/send-stream.c
+++ b/common/send-stream.c
@@ -369,6 +369,7 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	u64 unencoded_offset;
 	int len;
 	int xattr_len;
+	int fallocate_mode;
 
 	ret = read_cmd(sctx);
 	if (ret)
@@ -514,6 +515,14 @@ static int read_and_process_cmd(struct btrfs_send_stream *sctx)
 	case BTRFS_SEND_C_END:
 		ret = 1;
 		break;
+	case BTRFS_SEND_C_FALLOCATE:
+		TLV_GET_STRING(sctx, BTRFS_SEND_A_PATH, &path);
+		TLV_GET_U32(sctx, BTRFS_SEND_A_FALLOCATE_MODE, &fallocate_mode);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, &offset);
+		TLV_GET_U64(sctx, BTRFS_SEND_A_SIZE, &tmp);
+		ret = sctx->ops->fallocate(path, fallocate_mode, offset, tmp,
+					   sctx->user);
+		break;
 	}
 
 tlv_get_failed:
diff --git a/common/send-stream.h b/common/send-stream.h
index 607bc007..a58739bb 100644
--- a/common/send-stream.h
+++ b/common/send-stream.h
@@ -70,6 +70,8 @@ struct btrfs_send_ops {
 			     u64 len, u64 unencoded_file_len, u64 unencoded_len,
 			     u64 unencoded_offset, u32 compression,
 			     u32 encryption, void *user);
+	int (*fallocate)(const char *path, int mode, u64 offset, u64 len,
+			 void *user);
 };
 
 int btrfs_read_and_process_send_stream(int fd,
-- 
2.33.0

