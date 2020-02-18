Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78895162B78
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2020 18:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgBRRGv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Feb 2020 12:06:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40933 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726648AbgBRRGu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Feb 2020 12:06:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582045608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QLmP4agybmxaChV1BKDubZNXZ4ufUp4XPINJP3dy2sA=;
        b=a3efGTp1eSsJ31N9Tn27E9k0nq/xq8rOrqnOFNmVPZWsyyb61+1bTYv0f1qhWHpndxkt6C
        bRrX3Vut+tEBx8ZvpTymqGkqwUhj6EzAD6dA6FGPs71kDwzZY/wBGvM72vr5ZbTw5FFAGa
        InwJea6G88erZdN5314zGq/gmmfXPso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-FYGvLeCiOv6WgZkr1L2kDQ-1; Tue, 18 Feb 2020 12:06:40 -0500
X-MC-Unique: FYGvLeCiOv6WgZkr1L2kDQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A127A100550E;
        Tue, 18 Feb 2020 17:06:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-122-163.rdu2.redhat.com [10.10.122.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02CA85C13B;
        Tue, 18 Feb 2020 17:06:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 13/19] vfs: Add a mount-notification facility [ver #16]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, mszeredi@redhat.com,
        christian@brauner.io, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 18 Feb 2020 17:06:36 +0000
Message-ID: <158204559631.3299825.5358385352169781990.stgit@warthog.procyon.org.uk>
In-Reply-To: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
References: <158204549488.3299825.3783690177353088425.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Add a mount notification facility whereby notifications about changes in
mount topology and configuration can be received.  Note that this only
covers vfsmount topology changes and not superblock events.  A separate
facility will be added for that.

Firstly, an event queue needs to be created:

	fd = open("/dev/event_queue", O_RDWR);
	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, page_size << n);

then a notification can be set up to report notifications via that queue:

	struct watch_notification_filter filter = {
		.nr_filters = 1,
		.filters = {
			[0] = {
				.type = WATCH_TYPE_MOUNT_NOTIFY,
				.subtype_filter[0] = UINT_MAX,
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
	watch_mount(AT_FDCWD, "/", 0, fd, 0x02);

In this case, it would let me monitor the mount topology subtree rooted at
"/" for events.  Mount notifications propagate up the tree towards the
root, so a watch will catch all of the events happening in the subtree
rooted at the watch.

After setting the watch, records will be placed into the queue when, for
example, as superblock switches between read-write and read-only.  Records
are of the following format:

	struct mount_notification {
		struct watch_notification watch;
		__u32	triggered_on;
		__u32	changed_mount;
	} *n;

Where:

	n->watch.type will be WATCH_TYPE_MOUNT_NOTIFY.

	n->watch.subtype will indicate the type of event, such as
	NOTIFY_MOUNT_NEW_MOUNT.

	n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
	record.

	n->watch.info & WATCH_INFO_ID will be the fifth argument to
	watch_mount(), shifted.

	n->watch.info & NOTIFY_MOUNT_IN_SUBTREE if true indicates that the
	notifcation was generated in the mount subtree rooted at the watch,
	and not actually in the watch itself.

	n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true indicates that
	the notifcation was generated by an event (eg. SETATTR) that was
	applied recursively.  The notification is only generated for the
	object that initially triggered it.

	n->watch.info & NOTIFY_MOUNT_IS_NOW_RO will be used for
	NOTIFY_MOUNT_READONLY, being set if the superblock becomes R/O, and
	being cleared otherwise, and for NOTIFY_MOUNT_NEW_MOUNT, being set
	if the new mount is a submount (e.g. an automount).

	n->watch.info & NOTIFY_MOUNT_IS_SUBMOUNT if true indicates that the
	NOTIFY_MOUNT_NEW_MOUNT notification is in response to a mount
	performed by the kernel (e.g. an automount).

	n->triggered_on indicates the ID of the mount on which the watch
	was installed.

	n->changed_mount indicates the ID of the mount that was affected.

The mount IDs can be retrieved with the fsinfo() syscall, using the
fsinfo_mount_info and fsinfo_mount_child attributes.  There are change
notification counters there too for when a buffer overrun occurs, thereby
allowing the mount tree to be quickly rescanned.

Note that it is permissible for event records to be of variable length -
or, at least, the length may be dependent on the subtype.  Note also that
the queue can be shared between multiple notifications of various types.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/alpha/kernel/syscalls/syscall.tbl      |    1 
 arch/arm/tools/syscall.tbl                  |    1 
 arch/ia64/kernel/syscalls/syscall.tbl       |    1 
 arch/m68k/kernel/syscalls/syscall.tbl       |    1 
 arch/microblaze/kernel/syscalls/syscall.tbl |    1 
 arch/mips/kernel/syscalls/syscall_n32.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_n64.tbl   |    1 
 arch/mips/kernel/syscalls/syscall_o32.tbl   |    1 
 arch/parisc/kernel/syscalls/syscall.tbl     |    1 
 arch/powerpc/kernel/syscalls/syscall.tbl    |    1 
 arch/s390/kernel/syscalls/syscall.tbl       |    1 
 arch/sh/kernel/syscalls/syscall.tbl         |    1 
 arch/sparc/kernel/syscalls/syscall.tbl      |    1 
 arch/x86/entry/syscalls/syscall_32.tbl      |    1 
 arch/x86/entry/syscalls/syscall_64.tbl      |    1 
 arch/xtensa/kernel/syscalls/syscall.tbl     |    1 
 fs/Kconfig                                  |    9 +
 fs/Makefile                                 |    1 
 fs/mount.h                                  |   33 +++--
 fs/mount_notify.c                           |  188 +++++++++++++++++++++++++++
 fs/namespace.c                              |   17 ++
 include/linux/dcache.h                      |    1 
 include/linux/syscalls.h                    |    2 
 include/uapi/asm-generic/unistd.h           |    4 -
 include/uapi/linux/watch_queue.h            |   32 ++++-
 kernel/sys_ni.c                             |    1 
 26 files changed, 287 insertions(+), 17 deletions(-)
 create mode 100644 fs/mount_notify.c

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 961750417ef2..72bc7b33c59d 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -478,3 +478,4 @@
 547	common	openat2				sys_openat2
 548	common	pidfd_getfd			sys_pidfd_getfd
 549	common	fsinfo				sys_fsinfo
+550	common	watch_mount			sys_watch_mount
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index e6b9dfe01471..67777fd0b19e 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -452,3 +452,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 9018a3a6b067..cd18dc112902 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -359,3 +359,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 10172bb6ba1f..de5c7303899f 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -439,3 +439,4 @@
 438	common	pidfd_getfd			sys_pidfd_getfd
 # 435 reserved for clone3
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 58665073c1f0..7387a44767c3 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -444,3 +444,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 1f07a89473c3..e2c76157a580 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -377,3 +377,4 @@
 437	n32	openat2				sys_openat2
 438	n32	pidfd_getfd			sys_pidfd_getfd
 439	n32	fsinfo				sys_fsinfo
+440	n32	watch_mount			sys_watch_mount
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 3c853ca54901..e5da9a13b074 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -353,3 +353,4 @@
 437	n64	openat2				sys_openat2
 438	n64	pidfd_getfd			sys_pidfd_getfd
 439	n64	fsinfo				sys_fsinfo
+440	n64	watch_mount			sys_watch_mount
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 727f54542bf4..fe135759d2a8 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -426,3 +426,4 @@
 437	o32	openat2				sys_openat2
 438	o32	pidfd_getfd			sys_pidfd_getfd
 439	o32	fsinfo				sys_fsinfo
+440	o32	watch_mount			sys_watch_mount
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 2e9576638d80..5ac7a58af305 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -436,3 +436,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 397190734ca7..c77a1cf377ec 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -520,3 +520,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index e9340d712dcd..d81d30d02aaf 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 437  common	openat2			sys_openat2			sys_openat2
 438  common	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
 439  common	fsinfo			sys_fsinfo			sys_fsinfo
+440	common	watch_mount		sys_watch_mount			sys_watch_mount
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 7bb5ec284fbb..dcdc747fa430 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index a902b757ace2..b4f82e5a08bf 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -484,3 +484,4 @@
 437	common	openat2			sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index b7817acb154b..07572644779d 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -443,3 +443,4 @@
 437	i386	openat2			sys_openat2			__ia32_sys_openat2
 438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
 439	i386	fsinfo			sys_fsinfo			__ia32_sys_fsinfo
+440	i386	watch_mount		sys_watch_mount			__ia32_sys_watch_mount
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 3a45ed6d28cb..1b51791fe104 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -360,6 +360,7 @@
 437	common	openat2			__x64_sys_openat2
 438	common	pidfd_getfd		__x64_sys_pidfd_getfd
 439	common	fsinfo			__x64_sys_fsinfo
+440	common	watch_mount		__x64_sys_watch_mount
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index f82702a7ab38..dfcdd3036d3e 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -409,3 +409,4 @@
 437	common	openat2				sys_openat2
 438	common	pidfd_getfd			sys_pidfd_getfd
 439	common	fsinfo				sys_fsinfo
+440	common	watch_mount			sys_watch_mount
diff --git a/fs/Kconfig b/fs/Kconfig
index 1d1b48059ec9..76224bc015cb 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -124,6 +124,15 @@ source "fs/verity/Kconfig"
 
 source "fs/notify/Kconfig"
 
+config MOUNT_NOTIFICATIONS
+	bool "Mount topology change notifications"
+	select WATCH_QUEUE
+	help
+	  This option provides support for getting change notifications on the
+	  mount tree topology.  This makes use of the /dev/watch_queue misc
+	  device to handle the notification buffer and provides the
+	  mount_notify() system call to enable/disable watchpoints.
+
 source "fs/quota/Kconfig"
 
 source "fs/autofs/Kconfig"
diff --git a/fs/Makefile b/fs/Makefile
index b5cc9bcd17a4..b6bf2424c7f7 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -22,6 +22,7 @@ obj-y +=	no-block.o
 endif
 
 obj-$(CONFIG_PROC_FS) += proc_namespace.o
+obj-$(CONFIG_MOUNT_NOTIFICATIONS) += mount_notify.o
 
 obj-y				+= notify/
 obj-$(CONFIG_EPOLL)		+= eventpoll.o
diff --git a/fs/mount.h b/fs/mount.h
index a1625924fe81..fc791d8b274c 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -4,6 +4,7 @@
 #include <linux/poll.h>
 #include <linux/ns_common.h>
 #include <linux/fs_pin.h>
+#include <linux/watch_queue.h>
 
 struct mnt_namespace {
 	atomic_t		count;
@@ -70,9 +71,13 @@ struct mount {
 	int mnt_id;			/* mount identifier */
 	int mnt_group_id;		/* peer group identifier */
 	int mnt_expiry_mark;		/* true if marked for expiry */
+	int mnt_nr_watchers;		/* The number of subtree watches tracking this */
 	struct hlist_head mnt_pins;
 	struct hlist_head mnt_stuck_children;
 	atomic_t mnt_change_counter;	/* Number of changed applied */
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	struct watch_list *mnt_watchers; /* Watches on dentries within this mount */
+#endif
 } __randomize_layout;
 
 #define MNT_NS_INTERNAL ERR_PTR(-EINVAL) /* distinct from any mnt_namespace */
@@ -155,18 +160,8 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 	return ns->seq == 0;
 }
 
-/*
- * Type of mount topology change notification.
- */
-enum mount_notification_subtype {
-	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
-	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
-	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
-	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
-	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
-	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
-	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
-};
+extern void post_mount_notification(struct mount *changed,
+				    struct mount_notification *notify);
 
 static inline void notify_mount(struct mount *changed,
 				struct mount *aux,
@@ -174,4 +169,18 @@ static inline void notify_mount(struct mount *changed,
 				u32 info_flags)
 {
 	atomic_inc(&changed->mnt_change_counter);
+
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	{
+		struct mount_notification n = {
+			.watch.type	= WATCH_TYPE_MOUNT_NOTIFY,
+			.watch.subtype	= subtype,
+			.watch.info	= info_flags | watch_sizeof(n),
+			.triggered_on	= changed->mnt_id,
+			.changed_mount	= aux ? aux->mnt_id : 0,
+		};
+
+		post_mount_notification(changed, &n);
+	}
+#endif
 }
diff --git a/fs/mount_notify.c b/fs/mount_notify.c
new file mode 100644
index 000000000000..20644544802a
--- /dev/null
+++ b/fs/mount_notify.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Provide mount topology/attribute change notifications.
+ *
+ * Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/syscalls.h>
+#include <linux/slab.h>
+#include <linux/security.h>
+#include "mount.h"
+
+/*
+ * Post mount notifications to all watches going rootwards along the tree.
+ *
+ * Must be called with the mount_lock held.
+ */
+void post_mount_notification(struct mount *changed,
+			     struct mount_notification *notify)
+{
+	const struct cred *cred = current_cred();
+	struct path cursor;
+	struct mount *mnt;
+	unsigned seq;
+
+	seq = 0;
+	rcu_read_lock();
+restart:
+	cursor.mnt = &changed->mnt;
+	cursor.dentry = changed->mnt.mnt_root;
+	mnt = real_mount(cursor.mnt);
+	notify->watch.info &= ~NOTIFY_MOUNT_IN_SUBTREE;
+
+	read_seqbegin_or_lock(&rename_lock, &seq);
+	for (;;) {
+		if (mnt->mnt_watchers &&
+		    !hlist_empty(&mnt->mnt_watchers->watchers)) {
+			if (cursor.dentry->d_flags & DCACHE_MOUNT_WATCH)
+				post_watch_notification(mnt->mnt_watchers,
+							&notify->watch, cred,
+							(unsigned long)cursor.dentry);
+		} else {
+			cursor.dentry = mnt->mnt.mnt_root;
+		}
+		notify->watch.info |= NOTIFY_MOUNT_IN_SUBTREE;
+
+		if (cursor.dentry == cursor.mnt->mnt_root ||
+		    IS_ROOT(cursor.dentry)) {
+			struct mount *parent = READ_ONCE(mnt->mnt_parent);
+
+			/* Escaped? */
+			if (cursor.dentry != cursor.mnt->mnt_root)
+				break;
+
+			/* Global root? */
+			if (mnt == parent)
+				break;
+
+			cursor.dentry = READ_ONCE(mnt->mnt_mountpoint);
+			mnt = parent;
+			cursor.mnt = &mnt->mnt;
+		} else {
+			cursor.dentry = cursor.dentry->d_parent;
+		}
+	}
+
+	if (need_seqretry(&rename_lock, seq)) {
+		seq = 1;
+		goto restart;
+	}
+
+	done_seqretry(&rename_lock, seq);
+	rcu_read_unlock();
+}
+
+static void release_mount_watch(struct watch *watch)
+{
+	struct dentry *dentry = (struct dentry *)(unsigned long)watch->id;
+
+	dput(dentry);
+}
+
+/**
+ * sys_watch_mount - Watch for mount topology/attribute changes
+ * @dfd: Base directory to pathwalk from or fd referring to mount.
+ * @filename: Path to mount to place the watch upon
+ * @at_flags: Pathwalk control flags
+ * @watch_fd: The watch queue to send notifications to.
+ * @watch_id: The watch ID to be placed in the notification (-1 to remove watch)
+ */
+SYSCALL_DEFINE5(watch_mount,
+		int, dfd,
+		const char __user *, filename,
+		unsigned int, at_flags,
+		int, watch_fd,
+		int, watch_id)
+{
+	struct watch_queue *wqueue;
+	struct watch_list *wlist = NULL;
+	struct watch *watch = NULL;
+	struct mount *m;
+	struct path path;
+	unsigned int lookup_flags =
+		LOOKUP_DIRECTORY | LOOKUP_FOLLOW | LOOKUP_AUTOMOUNT;
+	int ret;
+
+	if (watch_id < -1 || watch_id > 0xff)
+		return -EINVAL;
+	if ((at_flags & ~(AT_NO_AUTOMOUNT | AT_EMPTY_PATH)) != 0)
+		return -EINVAL;
+	if (at_flags & AT_NO_AUTOMOUNT)
+		lookup_flags &= ~LOOKUP_AUTOMOUNT;
+	if (at_flags & AT_EMPTY_PATH)
+		lookup_flags |= LOOKUP_EMPTY;
+
+	ret = user_path_at(dfd, filename, lookup_flags, &path);
+	if (ret)
+		return ret;
+
+	ret = inode_permission(path.dentry->d_inode, MAY_EXEC);
+	if (ret)
+		goto err_path;
+
+	wqueue = get_watch_queue(watch_fd);
+	if (IS_ERR(wqueue))
+		goto err_path;
+
+	m = real_mount(path.mnt);
+
+	if (watch_id >= 0) {
+		ret = -ENOMEM;
+		if (!m->mnt_watchers) {
+			wlist = kzalloc(sizeof(*wlist), GFP_KERNEL);
+			if (!wlist)
+				goto err_wqueue;
+			init_watch_list(wlist, release_mount_watch);
+		}
+
+		watch = kzalloc(sizeof(*watch), GFP_KERNEL);
+		if (!watch)
+			goto err_wlist;
+
+		init_watch(watch, wqueue);
+		watch->id		= (unsigned long)path.dentry;
+		watch->info_id		= (u32)watch_id << 24;
+
+		ret = security_watch_mount(watch, &path);
+		if (ret < 0)
+			goto err_watch;
+
+		down_write(&m->mnt.mnt_sb->s_umount);
+		if (!m->mnt_watchers) {
+			m->mnt_watchers = wlist;
+			wlist = NULL;
+		}
+
+		ret = add_watch_to_object(watch, m->mnt_watchers);
+		if (ret == 0) {
+			spin_lock(&path.dentry->d_lock);
+			path.dentry->d_flags |= DCACHE_MOUNT_WATCH;
+			spin_unlock(&path.dentry->d_lock);
+			dget(path.dentry);
+			watch = NULL;
+		}
+		up_write(&m->mnt.mnt_sb->s_umount);
+	} else {
+		ret = -EBADSLT;
+		if (m->mnt_watchers) {
+			down_write(&m->mnt.mnt_sb->s_umount);
+			ret = remove_watch_from_object(m->mnt_watchers, wqueue,
+						       (unsigned long)path.dentry,
+						       false);
+			up_write(&m->mnt.mnt_sb->s_umount);
+		}
+	}
+
+err_watch:
+	kfree(watch);
+err_wlist:
+	kfree(wlist);
+err_wqueue:
+	put_watch_queue(wqueue);
+err_path:
+	path_put(&path);
+	return ret;
+}
diff --git a/fs/namespace.c b/fs/namespace.c
index 184c1aaf669a..bbfd6cd5c501 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -510,7 +510,8 @@ static int mnt_make_readonly(struct mount *mnt)
 	mnt->mnt.mnt_flags &= ~MNT_WRITE_HOLD;
 	unlock_mount_hash();
 	if (ret == 0)
-		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY, 0x10000);
+		notify_mount(mnt, NULL, NOTIFY_MOUNT_READONLY,
+			     NOTIFY_MOUNT_IS_NOW_RO);
 	return ret;
 }
 
@@ -1176,6 +1177,11 @@ static void mntput_no_expire(struct mount *mnt)
 	mnt->mnt.mnt_flags |= MNT_DOOMED;
 	rcu_read_unlock();
 
+#ifdef CONFIG_MOUNT_NOTIFICATIONS
+	if (mnt->mnt_watchers)
+		remove_watch_list(mnt->mnt_watchers, mnt->mnt_id);
+#endif
+
 	list_del(&mnt->mnt_instance);
 
 	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
@@ -2108,7 +2114,11 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 			list_del_init(&source_mnt->mnt_ns->list);
 		}
 		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
-		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT, 0);
+		notify_mount(dest_mnt, source_mnt, NOTIFY_MOUNT_NEW_MOUNT,
+			     (source_mnt->mnt.mnt_sb->s_flags & SB_RDONLY ?
+			      NOTIFY_MOUNT_IS_NOW_RO : 0) |
+			     (source_mnt->mnt.mnt_sb->s_flags & SB_SUBMOUNT ?
+			      NOTIFY_MOUNT_IS_SUBMOUNT : 0));
 		commit_tree(source_mnt);
 	}
 
@@ -2486,7 +2496,8 @@ static void set_mount_attributes(struct mount *mnt, unsigned int mnt_flags)
 	mnt->mnt.mnt_flags = mnt_flags;
 	touch_mnt_namespace(mnt->mnt_ns);
 	unlock_mount_hash();
-	notify_mount(mnt, NULL, NOTIFY_MOUNT_SETATTR, 0);
+	notify_mount(mnt, NULL, NOTIFY_MOUNT_SETATTR,
+		     (mnt_flags & SB_RDONLY ? NOTIFY_MOUNT_IS_NOW_RO : 0));
 }
 
 static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *mnt)
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index c1488cc84fd9..7b194d778155 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -217,6 +217,7 @@ struct dentry_operations {
 #define DCACHE_PAR_LOOKUP		0x10000000 /* being looked up (with parent locked shared) */
 #define DCACHE_DENTRY_CURSOR		0x20000000
 #define DCACHE_NORCU			0x40000000 /* No RCU delay for freeing */
+#define DCACHE_MOUNT_WATCH		0x80000000 /* There's a mount watch here */
 
 extern seqlock_t rename_lock;
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 6c3157e46e7c..1687e064751d 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1007,6 +1007,8 @@ asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
 asmlinkage long sys_fsinfo(int dfd, const char __user *pathname,
 			   struct fsinfo_params __user *params,
 			   void __user *buffer, size_t buf_size);
+asmlinkage long sys_watch_mount(int dfd, const char __user *path,
+				unsigned int at_flags, int watch_fd, int watch_id);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 9d00098a3f1b..d6b6c45ad31a 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
 __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
 #define __NR_fsinfo 439
 __SYSCALL(__NR_fsinfo, sys_fsinfo)
+#define __NR_watch_mount 440
+__SYSCALL(__NR_watch_mount, sys_watch_mount)
 
 #undef __NR_syscalls
-#define __NR_syscalls 440
+#define __NR_syscalls 441
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/watch_queue.h b/include/uapi/linux/watch_queue.h
index c3d8320b5d3a..b0f35cf51394 100644
--- a/include/uapi/linux/watch_queue.h
+++ b/include/uapi/linux/watch_queue.h
@@ -14,7 +14,8 @@
 enum watch_notification_type {
 	WATCH_TYPE_META		= 0,	/* Special record */
 	WATCH_TYPE_KEY_NOTIFY	= 1,	/* Key change event notification */
-	WATCH_TYPE__NR		= 2
+	WATCH_TYPE_MOUNT_NOTIFY	= 2,	/* Mount topology change notification */
+	WATCH_TYPE___NR		= 3
 };
 
 enum watch_meta_notification_subtype {
@@ -101,4 +102,33 @@ struct key_notification {
 	__u32	aux;		/* Per-type auxiliary data */
 };
 
+/*
+ * Type of mount topology change notification.
+ */
+enum mount_notification_subtype {
+	NOTIFY_MOUNT_NEW_MOUNT	= 0, /* New mount added */
+	NOTIFY_MOUNT_UNMOUNT	= 1, /* Mount removed manually */
+	NOTIFY_MOUNT_EXPIRY	= 2, /* Automount expired */
+	NOTIFY_MOUNT_READONLY	= 3, /* Mount R/O state changed */
+	NOTIFY_MOUNT_SETATTR	= 4, /* Mount attributes changed */
+	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
+	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */
+};
+
+#define NOTIFY_MOUNT_IN_SUBTREE		WATCH_INFO_FLAG_0 /* Event not actually at watched dentry */
+#define NOTIFY_MOUNT_IS_RECURSIVE	WATCH_INFO_FLAG_1 /* Change applied recursively */
+#define NOTIFY_MOUNT_IS_NOW_RO		WATCH_INFO_FLAG_2 /* Mount changed to R/O */
+#define NOTIFY_MOUNT_IS_SUBMOUNT	WATCH_INFO_FLAG_3 /* New mount is submount */
+
+/*
+ * Mount topology/configuration change notification record.
+ * - watch.type = WATCH_TYPE_MOUNT_NOTIFY
+ * - watch.subtype = enum mount_notification_subtype
+ */
+struct mount_notification {
+	struct watch_notification watch; /* WATCH_TYPE_MOUNT_NOTIFY */
+	__u32	triggered_on;		/* The mount that the notify was on */
+	__u32	changed_mount;		/* The mount that got changed */
+};
+
 #endif /* _UAPI_LINUX_WATCH_QUEUE_H */
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 58246e6b5603..1a1eb7b61914 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -52,6 +52,7 @@ COND_SYSCALL(io_uring_setup);
 COND_SYSCALL(io_uring_enter);
 COND_SYSCALL(io_uring_register);
 COND_SYSCALL(fsinfo);
+COND_SYSCALL(watch_mount);
 
 /* fs/xattr.c */
 


