Return-Path: <linux-api+bounces-4729-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC4AB49FD0
	for <lists+linux-api@lfdr.de>; Tue,  9 Sep 2025 05:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2634E4E2F
	for <lists+linux-api@lfdr.de>; Tue,  9 Sep 2025 03:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF36263F40;
	Tue,  9 Sep 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIr4dcmw"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72634D515;
	Tue,  9 Sep 2025 03:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757387751; cv=none; b=IISvuYuK6fu5+QwD9vnXJoZ+IcxFNyN1wnvl62Rh80i//Vpah2et+UNewzgyhzw4qNMPSDql+9g/muMGUqLr9VHydvuaCd21YyDLGKZbBOk5ebk0F/hKLnekPlha30vp0tnzpUe2RsRUhJknO40nutnsPdya46KssbP+g5hplgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757387751; c=relaxed/simple;
	bh=Em9j3bhCiPFenVEJinrsdXyI/7gV2Mevt9vg2PwMYaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lRw+St4I9eS99kEhzlPh6WTTfWe43t2rGYehEEkpui1Imb4ccnPSEGhuhLQy3ls3HvSsvrMdss+0/UIhSNLILsflSlAMhCBuNPSq3vp0TKvavBR/G9hKTY3WIHSM508j90pScA7uo0vuD6tRxjM8ObAH8/i7yfq9EOy2ohEXeR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIr4dcmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D7B3C4CEF5;
	Tue,  9 Sep 2025 03:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757387751;
	bh=Em9j3bhCiPFenVEJinrsdXyI/7gV2Mevt9vg2PwMYaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VIr4dcmw9V01qZOa2gJg8sZzkngYEMcJp++Z+LSRIqfzurH+dgYR+Qoctx1nKjItz
	 3WPT+znMQ+v2Cj3xp/rcXxqHml/PKbBlMWviTNpcfV2/Tt/cDOKinMwVpikfmDC/x8
	 i9yKtEKQeXiId83lIUW/UbonG3JqLXn3lbt12TkFhwqWRl8qEuOaBCXfOlR9O37WQo
	 oHac9zi3g0PIUpFPCq2VdTt9yFBRuULHlY74OD5zhFSGyta9MWl7CO/a3XRN9S7xO/
	 /bLcdsU+v0CyGnjQ6lakRb01XGI86Aqd8fIXZ4DQe8FxPoIs+1btj8ma69KqyLkyAW
	 b+pALS/2g27og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3A6CAC581;
	Tue,  9 Sep 2025 03:15:51 +0000 (UTC)
From: Theodore Ts'o via B4 Relay <devnull+tytso.mit.edu@kernel.org>
Date: Mon, 08 Sep 2025 23:15:48 -0400
Subject: [PATCH 1/3] ext4: avoid potential buffer over-read in
 parse_apply_sb_mount_options()
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-tune2fs-v1-1-e3a6929f3355@mit.edu>
References: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
In-Reply-To: <20250908-tune2fs-v1-0-e3a6929f3355@mit.edu>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1761; i=tytso@mit.edu;
 h=from:subject:message-id;
 bh=Zik1NfPQHpKrfWfZaCNq+zMCfiMzKhxquLerrhs7sjY=;
 b=owEBbQGS/pANAwAIAfL5WVaVDYGjAcsmYgBov5vlGPsmxg25/2936QiBXqo5LrbMzsXx5+eTP
 uM64RrRXHyJATMEAAEIAB0WIQQrablU2/4IeSiBN8ny+VlWlQ2BowUCaL+b5QAKCRDy+VlWlQ2B
 o74GB/9YF05zTZk+194F0WaTldpxSdRjWm0g1Yq7A6t3+KGENWzoMP48LSQX+/txWWQ5jFYdDaA
 9Tmwrb92gkRrS9RpxjaVXkUgpGXOfnfjDsYKE4iDu2VMNj2Z01jt5IsgbzjCYP76YkSw//wN66z
 cRE97ehAowM9rPrrLpQiVkXTio0J+7W7kEEt0Tp5+r56o0/n38Ocn/RYXflt76YaoV596gC0k4n
 eNq8sM2iVmeteuMqIk6z0vPutHZN3TEiumEUVTXBSAw9zM8kQ9MBBhL8JP+9lMnJODTdwv+GXpy
 aiCUnGUQUO8q+EN+1AMYUw1NH5VtlINJRIXvamoB0AdfbEFp
X-Developer-Key: i=tytso@mit.edu; a=openpgp;
 fpr=3AB057B7E78D945C8C5591FBD36F769BC11804F0
X-Endpoint-Received: by B4 Relay for tytso@mit.edu/default with auth_id=517
X-Original-From: Theodore Ts'o <tytso@mit.edu>
Reply-To: tytso@mit.edu

From: Theodore Ts'o <tytso@mit.edu>

Unlike other strings in the ext4 superblock, we rely on tune2fs to
make sure s_mount_opts is NUL terminated.  Harden
parse_apply_sb_mount_options() by treating s_mount_opts as a potential
__nonstring.

Cc: stable@vger.kernel.org
Fixes: 8b67f04ab9de ("ext4: Add mount options in superblock")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/super.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 699c15db28a82f26809bf68533454a242596f0fd..94c98446c84f9a4614971d246ca7f001de610a8a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2460,7 +2460,7 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 					struct ext4_fs_context *m_ctx)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *s_mount_opts = NULL;
+	char s_mount_opts[65];
 	struct ext4_fs_context *s_ctx = NULL;
 	struct fs_context *fc = NULL;
 	int ret = -ENOMEM;
@@ -2468,15 +2468,11 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	if (!sbi->s_es->s_mount_opts[0])
 		return 0;
 
-	s_mount_opts = kstrndup(sbi->s_es->s_mount_opts,
-				sizeof(sbi->s_es->s_mount_opts),
-				GFP_KERNEL);
-	if (!s_mount_opts)
-		return ret;
+	strscpy_pad(s_mount_opts, sbi->s_es->s_mount_opts);
 
 	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL);
 	if (!fc)
-		goto out_free;
+		return -ENOMEM;
 
 	s_ctx = kzalloc(sizeof(struct ext4_fs_context), GFP_KERNEL);
 	if (!s_ctx)
@@ -2508,11 +2504,8 @@ static int parse_apply_sb_mount_options(struct super_block *sb,
 	ret = 0;
 
 out_free:
-	if (fc) {
-		ext4_fc_free(fc);
-		kfree(fc);
-	}
-	kfree(s_mount_opts);
+	ext4_fc_free(fc);
+	kfree(fc);
 	return ret;
 }
 

-- 
2.51.0



