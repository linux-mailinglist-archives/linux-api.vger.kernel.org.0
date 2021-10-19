Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA0D432ACC
	for <lists+linux-api@lfdr.de>; Tue, 19 Oct 2021 02:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhJSAEy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 18 Oct 2021 20:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbhJSAEx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 18 Oct 2021 20:04:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E1C06161C;
        Mon, 18 Oct 2021 17:02:41 -0700 (PDT)
Received: from localhost (unknown [IPv6:2804:14c:124:8a08::1007])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: krisman)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B470A1F411B7;
        Tue, 19 Oct 2021 01:02:39 +0100 (BST)
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     jack@suse.com, amir73il@gmail.com
Cc:     djwong@kernel.org, tytso@mit.edu, david@fromorbit.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-api@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Jan Kara <jack@suse.cz>
Subject: [PATCH v8 17/32] fsnotify: Support FS_ERROR event type
Date:   Mon, 18 Oct 2021 21:00:00 -0300
Message-Id: <20211019000015.1666608-18-krisman@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019000015.1666608-1-krisman@collabora.com>
References: <20211019000015.1666608-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Expose a new type of fsnotify event for filesystems to report errors for
userspace monitoring tools.  fanotify will send this type of
notification for FAN_FS_ERROR events.  This also introduce a helper for
generating the new event.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v6:
  - Add fsnotify_data_error_report

Changes since v5:
  - pass sb inside data field (jan)
Changes since v3:
  - Squash patch ("fsnotify: Introduce helpers to send error_events")
  - Drop reviewed-bys!

Changes since v2:
  - FAN_ERROR->FAN_FS_ERROR (Amir)

Changes since v1:
  - Overload FS_ERROR with FS_IN_IGNORED
  - Implement support for this type on fsnotify_data_inode (Amir)
---
 include/linux/fsnotify.h         | 13 +++++++++++++
 include/linux/fsnotify_backend.h | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 1e5f7435a4b5..787545e87eeb 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -339,4 +339,17 @@ static inline void fsnotify_change(struct dentry *dentry, unsigned int ia_valid)
 		fsnotify_dentry(dentry, mask);
 }
 
+static inline int fsnotify_sb_error(struct super_block *sb, struct inode *inode,
+				    int error)
+{
+	struct fs_error_report report = {
+		.error = error,
+		.inode = inode,
+		.sb = sb,
+	};
+
+	return fsnotify(FS_ERROR, &report, FSNOTIFY_EVENT_ERROR,
+			NULL, NULL, NULL, 0);
+}
+
 #endif	/* _LINUX_FS_NOTIFY_H */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1e69e9fe45c9..a378a314e309 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -42,6 +42,12 @@
 
 #define FS_UNMOUNT		0x00002000	/* inode on umount fs */
 #define FS_Q_OVERFLOW		0x00004000	/* Event queued overflowed */
+#define FS_ERROR		0x00008000	/* Filesystem Error (fanotify) */
+
+/*
+ * FS_IN_IGNORED overloads FS_ERROR.  It is only used internally by inotify
+ * which does not support FS_ERROR.
+ */
 #define FS_IN_IGNORED		0x00008000	/* last inotify event here */
 
 #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
@@ -95,7 +101,8 @@
 #define ALL_FSNOTIFY_EVENTS (ALL_FSNOTIFY_DIRENT_EVENTS | \
 			     FS_EVENTS_POSS_ON_CHILD | \
 			     FS_DELETE_SELF | FS_MOVE_SELF | FS_DN_RENAME | \
-			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED)
+			     FS_UNMOUNT | FS_Q_OVERFLOW | FS_IN_IGNORED | \
+			     FS_ERROR)
 
 /* Extra flags that may be reported with event or control handling of events */
 #define ALL_FSNOTIFY_FLAGS  (FS_EXCL_UNLINK | FS_ISDIR | FS_IN_ONESHOT | \
@@ -249,6 +256,13 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_PATH,
 	FSNOTIFY_EVENT_INODE,
 	FSNOTIFY_EVENT_DENTRY,
+	FSNOTIFY_EVENT_ERROR,
+};
+
+struct fs_error_report {
+	int error;
+	struct inode *inode;
+	struct super_block *sb;
 };
 
 static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
@@ -260,6 +274,8 @@ static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 		return d_inode(data);
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
+	case FSNOTIFY_EVENT_ERROR:
+		return ((struct fs_error_report *)data)->inode;
 	default:
 		return NULL;
 	}
@@ -299,6 +315,20 @@ static inline struct super_block *fsnotify_data_sb(const void *data,
 		return ((struct dentry *)data)->d_sb;
 	case FSNOTIFY_EVENT_PATH:
 		return ((const struct path *)data)->dentry->d_sb;
+	case FSNOTIFY_EVENT_ERROR:
+		return ((struct fs_error_report *) data)->sb;
+	default:
+		return NULL;
+	}
+}
+
+static inline struct fs_error_report *fsnotify_data_error_report(
+							const void *data,
+							int data_type)
+{
+	switch (data_type) {
+	case FSNOTIFY_EVENT_ERROR:
+		return (struct fs_error_report *) data;
 	default:
 		return NULL;
 	}
-- 
2.33.0

