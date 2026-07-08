Return-Path: <linux-api+bounces-6784-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iqdsKtUfTmq3DgIAu9opvQ
	(envelope-from <linux-api+bounces-6784-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 12:00:53 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52500723F79
	for <lists+linux-api@lfdr.de>; Wed, 08 Jul 2026 12:00:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=A02jEJa+;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6784-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6784-lists+linux-api=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F11C4301A900
	for <lists+linux-api@lfdr.de>; Wed,  8 Jul 2026 09:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0CC371885;
	Wed,  8 Jul 2026 09:58:43 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0436A35A
	for <linux-api@vger.kernel.org>; Wed,  8 Jul 2026 09:58:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504723; cv=none; b=q/3u0BiFPll0H2gqi3FL2Mo9g9DNlIOvjN32FqrDqUF8X+NbH1QD4zryPVhaJGX/xEngeCJ8wva1e4FEmi/ab5EJQ+NzyfrpPrkWyq6yPmnTiFYR6MA1sJFCFUWP72zmVVbXKdk8Ng/2HFohq1NPY6mI593zDt7PV9mlmi05iNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504723; c=relaxed/simple;
	bh=/wAUWkaNE01l4+TRGwZM+zR+NeYwJ5BVxZgAgA4c2MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojS5qneLsodCE9Z0+QMs2E10zC5gyMWOYkIqeZsMrQOa/eHuAfevwJnuleLWvoPohZe2rbaRAO/nbUJa+7xs6GAliSRSfBp30OcrX6nepNncTJrZ+kZTfyDqldd1vxHNNovn3rEq+j/P2FIBWQ9z3kUmloMypHsagpggUU3sXA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A02jEJa+; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783504721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/Pb7T40sp5Zfecee5q6cuu1COB/2oXuHTJhfkZkM4d4=;
	b=A02jEJa+RUIZGWIMsQoqyaIMmCq639Rfa4Ea9PI4Bp2UW6vtLGcrvduInv9WgQj+TzDxFX
	ei/62bxmqrEYbbxUGneQ2ZjDvksECIYaa6+WIePSYb3n/j8zuZygeAlhsVV4i1JUEIhL4a
	2OdlhlrmubrY9dAxI64zgwlr87+FF6g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-fcV8IzkiOSeYkyibnBOAfg-1; Wed,
 08 Jul 2026 05:58:39 -0400
X-MC-Unique: fcV8IzkiOSeYkyibnBOAfg-1
X-Mimecast-MFC-AGG-ID: fcV8IzkiOSeYkyibnBOAfg_1783504718
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 926D51955EB2;
	Wed,  8 Jul 2026 09:58:38 +0000 (UTC)
Received: from oxygen.redhat.com (unknown [10.44.33.242])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E6AC930A8;
	Wed,  8 Jul 2026 09:58:36 +0000 (UTC)
From: Giuseppe Scrivano <gscrivan@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: [PATCH] ovl: add ioctls to retrieve layer file descriptors
Date: Wed,  8 Jul 2026 11:58:31 +0200
Message-ID: <20260708095831.3381978-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS(0.00)[m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6784-lists,linux-api=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gscrivan@redhat.com,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[gscrivan@redhat.com:query timed out];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52500723F79

Add two ioctls to overlay filesystem to allow userspace to retrieve
information about the overlay layers:

OVL_IOC_OPEN_LAYER:     return an O_PATH fd to the root of a layer.
                        arg == 0 returns the upper layer (-ENOENT if
                        no upper is configured), arg >= 1 returns
                        lower layers (-ENOENT if index is out of
                        range).
OVL_IOC_GET_LAYERS_INFO: copy a struct ovl_layers_info to userspace
                        with numlower, numlowerdata, and has_upper.

The ioctls work on any overlayfs file or directory and require
CAP_SYS_ADMIN in the mounter's user namespace.

The UAPI constants and struct are defined in include/uapi/linux/overlay.h.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 MAINTAINERS                  |  1 +
 fs/overlayfs/file.c          |  2 ++
 fs/overlayfs/overlayfs.h     |  4 +++
 fs/overlayfs/ovl_entry.h     |  2 ++
 fs/overlayfs/params.c        | 10 ++++++
 fs/overlayfs/params.h        |  1 +
 fs/overlayfs/readdir.c       |  2 ++
 fs/overlayfs/super.c         | 70 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/overlay.h | 30 ++++++++++++++++
 9 files changed, 122 insertions(+)
 create mode 100644 include/uapi/linux/overlay.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 25453040dffb..b64c696686e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20368,6 +20368,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git
 F:	Documentation/filesystems/overlayfs.rst
 F:	fs/overlayfs/
+F:	include/uapi/linux/overlay.h
 
 P54 WIRELESS DRIVER
 M:	Christian Lamparter <chunkeey@googlemail.com>
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 27cc07738f33..fc9c448c5959 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -649,4 +649,6 @@ const struct file_operations ovl_file_operations = {
 	.copy_file_range	= ovl_copy_file_range,
 	.remap_file_range	= ovl_remap_file_range,
 	.setlease		= generic_setlease,
+	.unlocked_ioctl		= ovl_ioctl,
+	.compat_ioctl		= compat_ptr_ioctl,
 };
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index b75df37f70ac..10f7ef8cb78c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -8,6 +8,7 @@
 #include <linux/uuid.h>
 #include <linux/fs.h>
 #include <linux/fsverity.h>
+#include <uapi/linux/overlay.h>
 #include <linux/namei.h>
 #include <linux/posix_acl.h>
 #include <linux/posix_acl_xattr.h>
@@ -908,6 +909,9 @@ void ovl_tempname(char name[OVL_TEMPNAME_SIZE]);
 struct dentry *ovl_create_temp(struct ovl_fs *ofs, struct dentry *workdir,
 			       struct ovl_cattr *attr);
 
+/* super.c */
+long ovl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
+
 /* file.c */
 extern const struct file_operations ovl_file_operations;
 int ovl_real_fileattr_get(const struct path *realpath, struct file_kattr *fa);
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 80cad4ea96a3..b8f4bca89a27 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -35,6 +35,8 @@ struct ovl_layer {
 	struct vfsmount *mnt;
 	/* Trap in ovl inode cache */
 	struct inode *trap;
+	/* Keeps the original fsmount file alive for OVL_IOC_OPEN_LAYER */
+	struct file *origin;
 	struct ovl_sb *fs;
 	/* Index of this layer in fs root (upper idx == 0) */
 	int idx;
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index c93fcaa45d4a..92d1a56178f2 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -482,6 +482,11 @@ static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
 			return PTR_ERR(layer_name);
 
 		err = ovl_do_parse_layer(fc, layer_name, &layer_path, layer);
+		if (!err && !is_upper_layer(layer)) {
+			struct ovl_fs_context *ctx = fc->fs_private;
+
+			ctx->lower[ctx->nr - 1].origin = get_file(param->file);
+		}
 		break;
 	}
 	default:
@@ -504,6 +509,9 @@ static void ovl_reset_lowerdirs(struct ovl_fs_context *ctx)
 		path_put(&l->path);
 		kfree(l->name);
 		l->name = NULL;
+		if (l->origin)
+			fput(l->origin);
+		l->origin = NULL;
 	}
 	ctx->nr = 0;
 	ctx->nr_data = 0;
@@ -856,6 +864,8 @@ void ovl_free_fs(struct ovl_fs *ofs)
 	mounts = (struct vfsmount **) ofs->config.lowerdirs;
 	for (i = 0; i < ofs->numlayer; i++) {
 		iput(ofs->layers[i].trap);
+		if (ofs->layers[i].origin)
+			fput(ofs->layers[i].origin);
 		kfree(ofs->config.lowerdirs[i]);
 		mounts[i] = ofs->layers[i].mnt;
 	}
diff --git a/fs/overlayfs/params.h b/fs/overlayfs/params.h
index ffd53cdd8482..1d8fe8fbaca2 100644
--- a/fs/overlayfs/params.h
+++ b/fs/overlayfs/params.h
@@ -22,6 +22,7 @@ struct ovl_opt_set {
 struct ovl_fs_context_layer {
 	char *name;
 	struct path path;
+	struct file *origin;
 };
 
 struct ovl_fs_context {
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index e7fe29cb6028..7bab71c8bcc2 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1069,6 +1069,8 @@ const struct file_operations ovl_dir_operations = {
 	.iterate_shared	= shared_ovl_iterate,
 	.llseek		= ovl_dir_llseek,
 	.fsync		= ovl_dir_fsync,
+	.unlocked_ioctl	= ovl_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.release	= ovl_dir_release,
 	.setlease	= generic_setlease,
 };
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 60f0b7ceef0a..d143002e74b2 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1107,6 +1107,8 @@ static int ovl_get_layers(struct super_block *sb, struct ovl_fs *ofs,
 		 */
 		mnt->mnt_flags |= MNT_READONLY | MNT_NOATIME;
 
+		layers[ofs->numlayer].origin = l->origin;
+		l->origin = NULL;
 		layers[ofs->numlayer].trap = trap;
 		layers[ofs->numlayer].mnt = mnt;
 		layers[ofs->numlayer].idx = ofs->numlayer;
@@ -1568,6 +1570,74 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	return err;
 }
 
+static long ovl_ioctl_open_layer(struct file *filp, unsigned long arg)
+{
+	struct super_block *sb = file_inode(filp)->i_sb;
+	struct ovl_fs *ofs = OVL_FS(sb);
+	struct path root;
+	struct file *f;
+	int fd;
+
+	if (arg >= ofs->numlayer)
+		return -ENOENT;
+	if (arg == 0 && !ovl_upper_mnt(ofs))
+		return -ENOENT;
+	if (!ofs->layers[arg].origin)
+		return -EOPNOTSUPP;
+
+	root.mnt = mntget(ofs->layers[arg].origin->f_path.mnt);
+	root.dentry = dget(root.mnt->mnt_root);
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		path_put(&root);
+		return fd;
+	}
+
+	f = dentry_open(&root, O_PATH | O_NOFOLLOW, current_cred());
+	path_put(&root);
+	if (IS_ERR(f)) {
+		put_unused_fd(fd);
+		return PTR_ERR(f);
+	}
+
+	fd_install(fd, f);
+	return fd;
+}
+
+static long ovl_ioctl_get_layers_info(struct file *filp, unsigned long arg)
+{
+	struct super_block *sb = file_inode(filp)->i_sb;
+	struct ovl_fs *ofs = OVL_FS(sb);
+	struct ovl_layers_info info = {
+		.numlower = ofs->numlayer - 1,
+		.numlowerdata = ofs->numdatalayer,
+		.has_upper = !!ovl_upper_mnt(ofs),
+	};
+
+	if (copy_to_user((void __user *)arg, &info, sizeof(info)))
+		return -EFAULT;
+
+	return 0;
+}
+
+long ovl_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct ovl_fs *ofs = OVL_FS(file_inode(filp)->i_sb);
+
+	if (!ns_capable(ofs->creator_cred->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	switch (cmd) {
+	case OVL_IOC_OPEN_LAYER:
+		return ovl_ioctl_open_layer(filp, arg);
+	case OVL_IOC_GET_LAYERS_INFO:
+		return ovl_ioctl_get_layers_info(filp, arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
 struct file_system_type ovl_fs_type = {
 	.owner			= THIS_MODULE,
 	.name			= "overlay",
diff --git a/include/uapi/linux/overlay.h b/include/uapi/linux/overlay.h
new file mode 100644
index 000000000000..c92ccecd9e21
--- /dev/null
+++ b/include/uapi/linux/overlay.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_OVERLAY_H
+#define _UAPI_LINUX_OVERLAY_H
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/**
+ * struct ovl_layers_info - overlay layer configuration summary
+ * @numlower:     number of lower (metadata) layers
+ * @numlowerdata: number of data-only lower layers
+ * @has_upper:    1 if an upper layer is configured, 0 otherwise
+ */
+struct ovl_layers_info {
+	__u32 numlower;
+	__u32 numlowerdata;
+	__u32 has_upper;
+};
+
+/*
+ * Return an O_PATH fd to the root of the specified overlay layer.
+ * arg == 0: upper layer (returns -ENOENT if no upper is configured)
+ * arg >= 1: lower layers (returns -ENOENT if index is out of range)
+ */
+#define OVL_IOC_OPEN_LAYER	_IO('O', 1)
+
+/* Retrieve overlay layer configuration into struct ovl_layers_info. */
+#define OVL_IOC_GET_LAYERS_INFO	_IOR('O', 2, struct ovl_layers_info)
+
+#endif /* _UAPI_LINUX_OVERLAY_H */
-- 
2.55.0


