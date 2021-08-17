Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1243EF498
	for <lists+linux-api@lfdr.de>; Tue, 17 Aug 2021 23:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhHQVI2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Aug 2021 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbhHQVIS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Aug 2021 17:08:18 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D5C0612A8
        for <linux-api@vger.kernel.org>; Tue, 17 Aug 2021 14:07:45 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id om1-20020a17090b3a8100b0017941c44ce4so7425998pjb.3
        for <linux-api@vger.kernel.org>; Tue, 17 Aug 2021 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zZ+1/axy7qv+PVrBVRMrTkWPiAafdEfyg1/moKYjPII=;
        b=iVP0txPhTIuW77nYZkbYwEEGpNCXhalYXoUfgNXlG2mtSlXF4m6Wby1zzzdZImIjF/
         GTAD2Mfabsjl4IYWKrr/hSxywrbNv6VIS6gzMqRPqeHiz7dXdLpm5768kmPnSLB3CGDG
         DDPqx3XUoDFW3ARelcrDJUqvAGxmcqwCfJPjyWvSMuyCniU7hs3LDfG/FzlKoyZPii+y
         oAGfCHeDVApMOaubtTpsxiCK29xJIwHZtERelcxjY7GPbIBqAushmeFSRB9eN3leAA71
         L9Nvh0nhb6eN03sQ+zu78hxzVFCEMtGv8j2pih+n7mXfpPkEm7p2lGDHhTjW0x4nTc+w
         tvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zZ+1/axy7qv+PVrBVRMrTkWPiAafdEfyg1/moKYjPII=;
        b=j4ida2tt41cTc84ZrAkJkd8DZ3sqyDsP8DEdTvXw9LuOjRL4IdGGs+nHcHQanhf/4N
         YLSdhlRSGMIa2bNRJtvxUMAHpE8dG6kkIbehl+5BpNV8WKMsmxzmzGaQiV3CJ6pZsLP3
         XsMLiOGmQ3oZQ3VWDJBxfiGArg6QKUdL17VbHuBEmkBho6DM+xIY0hxZsaOc8ui2toUn
         75z/uElW4mXZoMDNgHOCj+zR0/xsNhPGeV0/lidfEpaS3yH2MIHzsa46mEAWTJ8zxfb1
         /ly5S0h3KENi3U2AP02Um2dXcbpPwk1qgAK7AdXtEamK4U9zFaA2JeENhtRS0xFIXj7m
         J+OA==
X-Gm-Message-State: AOAM531NjJDY1vEFuPQzO766SnEPL3Tyy/bnD3Iaa9FEvSjl0H+GBCOR
        hpMZ97TK8ebAJlC00se9ztBnGw==
X-Google-Smtp-Source: ABdhPJwsnEv/08PabcgE2EZwKkJ8vi4jwSrY1CMWaTFbAqV21+lt94BJGXCoLxQ5/hXY6f/ZIrzowA==
X-Received: by 2002:a63:e208:: with SMTP id q8mr5345424pgh.282.1629234464677;
        Tue, 17 Aug 2021 14:07:44 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:df70])
        by smtp.gmail.com with ESMTPSA id c9sm4205194pgq.58.2021.08.17.14.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 14:07:44 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-btrfs@vger.kernel.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: [PATCH v10 07/10] btrfs-progs: receive: process fallocate commands
Date:   Tue, 17 Aug 2021 14:06:53 -0700
Message-Id: <692c57e5ed25c419c78dc1e0ed395c4690da171b.1629234282.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1629234193.git.osandov@fb.com>
References: <cover.1629234193.git.osandov@fb.com>
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
index 7506f992..dd27af95 100644
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
2.32.0

