Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AD659F2F
	for <lists+linux-api@lfdr.de>; Fri, 28 Jun 2019 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfF1PpC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Jun 2019 11:45:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1PpC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 28 Jun 2019 11:45:02 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D8B2A81F25;
        Fri, 28 Jun 2019 15:44:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-219.rdu2.redhat.com [10.10.120.219])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38CE326DF0;
        Fri, 28 Jun 2019 15:44:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 06/11] fsinfo: Implement retrieval of LSM parameters with
 fsinfo() [ver #15]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jun 2019 16:44:54 +0100
Message-ID: <156173669444.14042.13687450924553725037.stgit@warthog.procyon.org.uk>
In-Reply-To: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
References: <156173661696.14042.17822154531324224780.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 28 Jun 2019 15:45:01 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Implement LSM parameter value retrieval with fsinfo() - akin to parsing
/proc/mounts. This allows all the LSM parameters to be retrieved in one go
with:

	struct fsinfo_params params = {
		.request        = FSINFO_ATTR_LSM_PARAMETER,
	};

The format is a blob containing pairs of length-prefixed strings to avoid
the need to escape commas and suchlike in the values.  This is the same as
for FSINFO_ATTR_PARAMETER.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fsinfo.c                 |   21 +++++++++++++++------
 include/linux/lsm_hooks.h   |   13 +++++++++++++
 include/linux/security.h    |   11 +++++++++++
 include/uapi/linux/fsinfo.h |    1 +
 samples/vfs/test-fsinfo.c   |    6 +++++-
 security/security.c         |   12 ++++++++++++
 6 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/fs/fsinfo.c b/fs/fsinfo.c
index 92906a3f4010..45bfb10eb8d9 100644
--- a/fs/fsinfo.c
+++ b/fs/fsinfo.c
@@ -368,7 +368,8 @@ static int vfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 	int (*fsinfo)(struct path *, struct fsinfo_kparams *);
 	int ret;
 
-	if (params->request == FSINFO_ATTR_FSINFO) {
+	switch (params->request) {
+	case FSINFO_ATTR_FSINFO: {
 		struct fsinfo_fsinfo *info = params->buffer;
 
 		info->max_attr	= FSINFO_ATTR__NR;
@@ -376,11 +377,18 @@ static int vfs_fsinfo(struct path *path, struct fsinfo_kparams *params)
 		return sizeof(*info);
 	}
 
-	fsinfo = dentry->d_sb->s_op->fsinfo;
-	if (!fsinfo) {
-		if (!dentry->d_sb->s_op->statfs)
-			return -EOPNOTSUPP;
-		fsinfo = generic_fsinfo;
+	case FSINFO_ATTR_LSM_PARAMETERS:
+		fsinfo = security_sb_fsinfo;
+		break;
+
+	default:
+		fsinfo = dentry->d_sb->s_op->fsinfo;
+		if (!fsinfo) {
+			if (!dentry->d_sb->s_op->statfs)
+				return -EOPNOTSUPP;
+			fsinfo = generic_fsinfo;
+		}
+		break;
 	}
 
 	ret = security_sb_statfs(dentry);
@@ -573,6 +581,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 	FSINFO_OPAQUE		(PARAMETERS),
+	FSINFO_OPAQUE		(LSM_PARAMETERS),
 };
 
 /**
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 47f58cfb6a19..2474c3f785ca 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -108,6 +108,13 @@
  *	mountpoint.
  *	@dentry is a handle on the superblock for the filesystem.
  *	Return 0 if permission is granted.
+ * @sb_fsinfo:
+ *	Query LSM information for a filesystem.
+ *	@path is a handle on the superblock for the filesystem.
+ *	@params is the fsinfo parameter and buffer block.
+ *	 - Currently, params->request can only be FSINFO_ATTR_LSM_PARAMETERS.
+ *	Return the length of the data in the buffer (and can return -ENODATA to
+ *      indicate no value under certain circumstances).
  * @sb_mount:
  *	Check permission before an object specified by @dev_name is mounted on
  *	the mount point named by @nd.  For an ordinary mount, @dev_name
@@ -1492,6 +1499,9 @@ union security_list_options {
 	int (*sb_kern_mount)(struct super_block *sb);
 	int (*sb_show_options)(struct seq_file *m, struct super_block *sb);
 	int (*sb_statfs)(struct dentry *dentry);
+#ifdef CONFIG_FSINFO
+	int (*sb_fsinfo)(struct path *path, struct fsinfo_kparams *params);
+#endif
 	int (*sb_mount)(const char *dev_name, const struct path *path,
 			const char *type, unsigned long flags, void *data);
 	int (*sb_umount)(struct vfsmount *mnt, int flags);
@@ -1838,6 +1848,9 @@ struct security_hook_heads {
 	struct hlist_head sb_kern_mount;
 	struct hlist_head sb_show_options;
 	struct hlist_head sb_statfs;
+#ifdef CONFIG_FSINFO
+	struct hlist_head sb_fsinfo;
+#endif
 	struct hlist_head sb_mount;
 	struct hlist_head sb_umount;
 	struct hlist_head sb_pivotroot;
diff --git a/include/linux/security.h b/include/linux/security.h
index 659071c2e57c..23c8b602c0ab 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -57,6 +57,7 @@ struct mm_struct;
 struct fs_context;
 struct fs_parameter;
 enum fs_value_type;
+struct fsinfo_kparams;
 
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
@@ -237,6 +238,9 @@ int security_sb_remount(struct super_block *sb, void *mnt_opts);
 int security_sb_kern_mount(struct super_block *sb);
 int security_sb_show_options(struct seq_file *m, struct super_block *sb);
 int security_sb_statfs(struct dentry *dentry);
+#ifdef CONFIG_FSINFO
+int security_sb_fsinfo(struct path *path, struct fsinfo_kparams *params);
+#endif
 int security_sb_mount(const char *dev_name, const struct path *path,
 		      const char *type, unsigned long flags, void *data);
 int security_sb_umount(struct vfsmount *mnt, int flags);
@@ -575,6 +579,13 @@ static inline int security_sb_statfs(struct dentry *dentry)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+static inline int security_sb_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	return 0;
+}
+#endif
+
 static inline int security_sb_mount(const char *dev_name, const struct path *path,
 				    const char *type, unsigned long flags,
 				    void *data)
diff --git a/include/uapi/linux/fsinfo.h b/include/uapi/linux/fsinfo.h
index 11c4a74638b0..0d57d37311fc 100644
--- a/include/uapi/linux/fsinfo.h
+++ b/include/uapi/linux/fsinfo.h
@@ -31,6 +31,7 @@ enum fsinfo_attribute {
 	FSINFO_ATTR_PARAM_SPECIFICATION	= 13,	/* Nth parameter specification */
 	FSINFO_ATTR_PARAM_ENUM		= 14,	/* Nth enum-to-val */
 	FSINFO_ATTR_PARAMETERS		= 15,	/* Mount parameters (large string) */
+	FSINFO_ATTR_LSM_PARAMETERS	= 16,	/* LSM Mount parameters (large string) */
 	FSINFO_ATTR__NR
 };
 
diff --git a/samples/vfs/test-fsinfo.c b/samples/vfs/test-fsinfo.c
index 8cf5b02e333a..f865bc1af16f 100644
--- a/samples/vfs/test-fsinfo.c
+++ b/samples/vfs/test-fsinfo.c
@@ -82,6 +82,7 @@ static const struct fsinfo_attr_info fsinfo_buffer_info[FSINFO_ATTR__NR] = {
 	FSINFO_STRUCT_N		(PARAM_SPECIFICATION,	param_specification),
 	FSINFO_STRUCT_N		(PARAM_ENUM,		param_enum),
 	FSINFO_OVERLARGE	(PARAMETERS,		-),
+	FSINFO_OVERLARGE	(LSM_PARAMETERS,	-),
 };
 
 #define FSINFO_NAME(X,Y) [FSINFO_ATTR_##X] = #Y
@@ -102,6 +103,7 @@ static const char *fsinfo_attr_names[FSINFO_ATTR__NR] = {
 	FSINFO_NAME		(PARAM_SPECIFICATION,	param_specification),
 	FSINFO_NAME		(PARAM_ENUM,		param_enum),
 	FSINFO_NAME		(PARAMETERS,		parameters),
+	FSINFO_NAME		(LSM_PARAMETERS,	lsm_parameters),
 };
 
 union reply {
@@ -459,6 +461,7 @@ static int try_one(const char *file, struct fsinfo_params *params, bool raw)
 
 	switch (params->request) {
 	case FSINFO_ATTR_PARAMETERS:
+	case FSINFO_ATTR_LSM_PARAMETERS:
 		if (ret == 0)
 			return 0;
 	}
@@ -505,7 +508,8 @@ static int try_one(const char *file, struct fsinfo_params *params, bool raw)
 		return 0;
 
 	case __FSINFO_OVER:
-		if (params->request == FSINFO_ATTR_PARAMETERS)
+		if (params->request == FSINFO_ATTR_PARAMETERS ||
+		    params->request == FSINFO_ATTR_LSM_PARAMETERS)
 			dump_params(about, r, ret);
 		return 0;
 
diff --git a/security/security.c b/security/security.c
index 613a5c00e602..3af886e8fced 100644
--- a/security/security.c
+++ b/security/security.c
@@ -25,6 +25,7 @@
 #include <linux/ima.h>
 #include <linux/evm.h>
 #include <linux/fsnotify.h>
+#include <linux/fsinfo.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
 #include <linux/personality.h>
@@ -821,6 +822,17 @@ int security_sb_statfs(struct dentry *dentry)
 	return call_int_hook(sb_statfs, 0, dentry);
 }
 
+#ifdef CONFIG_FSINFO
+int security_sb_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	int ret = -ENODATA;
+
+	if (params->request == FSINFO_ATTR_LSM_PARAMETERS)
+		ret = 0; /* This is cumulative amongst all LSMs */
+	return call_int_hook(sb_fsinfo, ret, path, params);
+}
+#endif
+
 int security_sb_mount(const char *dev_name, const struct path *path,
                        const char *type, unsigned long flags, void *data)
 {

