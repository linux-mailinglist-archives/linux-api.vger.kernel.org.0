Return-Path: <linux-api+bounces-6782-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1RY3OhEaTmoWDQIAu9opvQ
	(envelope-from <linux-api+bounces-6782-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 11:36:17 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B5C723CAF
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 11:36:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=iD81Yika;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6782-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6782-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C996930285C7
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF15419313;
	Wed,  8 Jul 2026 09:35:01 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952933F8231
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 09:34:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783503300; cv=none; b=tWv4D1355KGaqUHVkgnEe/Ft9Bpz7mV55NbCkviYLpq/LwbCde8bW2dz+diuKHm0kyEpZ5cu91c0THZmMio7miR+SuLGHY7hhRSGG12mUCiekHJO8hJtRIJypsiQXXIlKTXuFRoDPn9WRp7dJU3r5JSmFvt3DJE400EIe7IABKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783503300; c=relaxed/simple;
	bh=WY65FZp5xgPsf5dPtrbZYNcqyY4fbRjboVxgRvDOWUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=emB5jUpZCS0Y50C/GcHQtQoCSpjvfig/Iz6lPpe2MwjbJ8+swcxiFYfE11UJkAvnHl6EEmpLPwr0KAPYFqW4+XEuX+TYPtJGrh2BwKlU3KuqBqbKZ1Er4oqmqFhw1A85lyDgVIb1sBw18d1pZwGIUTbFJXwEokazVO8XPxnv3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iD81Yika; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783503296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W8ArRWsRiz74um4VX+cF6VY0Yq/5FxxLKqrkr4Kch6M=;
	b=iD81Yika2ToasJtukpTeu/zPbAYzitIlm1DoEtu/SxkgmQpxKbBRNL4nHUqsWagYBh14Yh
	eVH3P2rg6bpprh07iah0vlCMq6dXWZumZLcXyqM+GBdCdZnFSDyJLHlM7Jut7fohDyQGzz
	oSb19CVErKCdONwp8cuxxjdOe95phqk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-tT1Y3egvOZWD-oh3xDqXmw-1; Wed,
 08 Jul 2026 05:34:53 -0400
X-MC-Unique: tT1Y3egvOZWD-oh3xDqXmw-1
X-Mimecast-MFC-AGG-ID: tT1Y3egvOZWD-oh3xDqXmw_1783503292
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AEB51955F7C;
	Wed,  8 Jul 2026 09:34:52 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0352F1955F43;
	Wed,  8 Jul 2026 09:34:50 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-erofs@lists.ozlabs.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH 1/2] erofs: accept source file descriptor via fsconfig
Date: Wed,  8 Jul 2026 11:34:26 +0200
Message-ID: <20260708093446.3370200-2-gscrivan@redhat.com>
In-Reply-To: <20260708093446.3370200-1-gscrivan@redhat.com>
References: <20260708093446.3370200-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS(0.00)[m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6782-lists,linux-api=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81B5C723CAF

Add fsparam_fd("source") so that userspace can pass an already-opened
file descriptor instead of a path string.  When the fd is provided via
fsconfig(FSCONFIG_SET_FD, "source", NULL, fd), it is stored directly
in sbi->dif0.file and erofs_fc_get_tree() skips the filp_open() call.

This is useful for mount namespaces where the backing file may not be
reachable by path, and for tools that already hold an fd to the image
(e.g. composefs reusing an erofs mount's backing file).

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 fs/erofs/super.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 86fa5c6a0c70..8ad1689f74b2 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_info *sbi)
 enum {
 	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
 	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
+	Opt_source_fd,
 };
 
 static const struct constant_table erofs_param_cache_strategy[] = {
@@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parameters[] = {
 	fsparam_flag_no("directio",	Opt_directio),
 	fsparam_u64("fsoffset",		Opt_fsoffset),
 	fsparam_flag("inode_share",	Opt_inode_share),
+	fsparam_fd("source",		Opt_source_fd),
 	{}
 };
 
@@ -524,6 +526,15 @@ static int erofs_fc_parse_param(struct fs_context *fc,
 		else
 			set_opt(&sbi->opt, INODE_SHARE);
 		break;
+	case Opt_source_fd:
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE)) {
+			errorfc(fc, "source fd option not supported");
+			return -EINVAL;
+		}
+		if (sbi->dif0.file)
+			fput(sbi->dif0.file);
+		sbi->dif0.file = get_file(param->file);
+		break;
 	}
 	return 0;
 }
@@ -752,14 +763,18 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 static int erofs_fc_get_tree(struct fs_context *fc)
 {
-	int ret;
+	struct erofs_sb_info *sbi = fc->s_fs_info;
 
-	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
-		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
-			GET_TREE_BDEV_QUIET_LOOKUP : 0);
-	if (IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) && ret == -ENOTBLK) {
-		struct erofs_sb_info *sbi = fc->s_fs_info;
+	if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) || !sbi->dif0.file) {
 		struct file *file;
+		int ret;
+
+		ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
+			IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
+				GET_TREE_BDEV_QUIET_LOOKUP : 0);
+		if (!IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ||
+		    ret != -ENOTBLK)
+			return ret;
 
 		if (!fc->source)
 			return invalf(fc, "No source specified");
@@ -767,12 +782,11 @@ static int erofs_fc_get_tree(struct fs_context *fc)
 		if (IS_ERR(file))
 			return PTR_ERR(file);
 		sbi->dif0.file = file;
-
-		if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
-		    sbi->dif0.file->f_mapping->a_ops->read_folio)
-			return get_tree_nodev(fc, erofs_fc_fill_super);
 	}
-	return ret;
+	if (S_ISREG(file_inode(sbi->dif0.file)->i_mode) &&
+	    sbi->dif0.file->f_mapping->a_ops->read_folio)
+		return get_tree_nodev(fc, erofs_fc_fill_super);
+	return -EINVAL;
 }
 
 static int erofs_fc_reconfigure(struct fs_context *fc)
-- 
2.55.0


