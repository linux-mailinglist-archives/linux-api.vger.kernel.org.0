Return-Path: <linux-api+bounces-6640-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m5w3NHh2NWr6wwYAu9opvQ
	(envelope-from <linux-api+bounces-6640-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 19 Jun 2026 19:03:52 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DDEF6A72C7
	for <lists+linux-api@lfdr.de>; Fri, 19 Jun 2026 19:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=Vjbdv5Jn;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6640-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6640-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44F2A30285F5
	for <lists+linux-api@lfdr.de>; Fri, 19 Jun 2026 17:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED33B960F;
	Fri, 19 Jun 2026 17:03:49 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E3331EA7;
	Fri, 19 Jun 2026 17:03:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781888629; cv=none; b=glsuDTAX4jUBiyXCT8VtUL4/GeAuISqIuR7sLzI+LULlMUQh2Zhh40I70fR1Z9RgG06cT2frp9779+WnLrNrCpKCv/5neCn/ouLQEYkO5ZjqO3Y0h8UztmJMmSzrK29uIH81fIs2osxKLhGojelc+SvaLY45VxDSbsSYCHQLGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781888629; c=relaxed/simple;
	bh=v8PxMbaiMwCJUKGdaAKzHWMJfeJnRRzS6bHv+pRLCFU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6sjlVCODxDeVzD19+HKQpeI2Waxud8b5qpV01b8XjWr2szVC9Q7Il7KAjMkl98rRjX1QexzMFsBBOsj8MvF8i1AprFNoMfqb6+n8KIWefv/u9P9+bI0Td5IiOzgBHSIHAVa0/6k2IviRqSaVeLBJYBCmOfS6rZxm1+XBPZXg8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Vjbdv5Jn; arc=none smtp.client-ip=52.34.181.151
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781888627; x=1813424627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mepCyamqQZfDcmw2jhkUZr/9vR/rYt1RSxhN5Wz6AGQ=;
  b=Vjbdv5JnnrzUP2P9Vlgp2mAEw6XxPVy8C6MVQcC1Nu78tsP12zJB0jVl
   avYptFv/maeso9FANi37Bm3bUr5KlV8ClHppqInIMIeaToT2zgCwY12wL
   XU93i5IFbf5jUdRObjoS4O2AXX8PLASPX681Gl7x+MpjT+MWV0Y9eWqZA
   KxMsAkLUbXj7+bdP8EKxB+YnBH1h6Pv4KEJpdeqvL+blKKZ1Vrq8UeaZQ
   /korjp53BxgtDWpUixESHeOS0oqWRzzE4IHAsUJI+5gLrszbep9on9CxT
   j8d0/alrevUF/N5euCG1eGgh3OFDXURacbOgDWHQZCpVFkFbyFzygLNXT
   A==;
X-CSE-ConnectionGUID: Xfgai+1kRI6il4Tx+Ruz5A==
X-CSE-MsgGUID: vK5bOs3wTmKp3C8LjFHB2Q==
X-IronPort-AV: E=Sophos;i="6.24,213,1774310400"; 
   d="scan'208";a="22090330"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 17:03:46 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.48:3040]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.233:2525] with esmtp (Farcaster)
 id 460ae2e6-5eed-4017-b37a-8d8c3dc7ff5c; Fri, 19 Jun 2026 17:03:46 +0000 (UTC)
X-Farcaster-Flow-ID: 460ae2e6-5eed-4017-b37a-8d8c3dc7ff5c
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 19 Jun 2026 17:03:46 +0000
Received: from dev-dsk-jamz-1e-e35f4cd9.us-east-1.amazon.com (10.189.35.140)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 19 Jun 2026 17:03:45 +0000
From: Jimmy Zuber <jamz@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 1/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
Date: Fri, 19 Jun 2026 17:02:50 +0000
Message-ID: <20260619170251.1154562-2-jamz@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260619170251.1154562-1-jamz@amazon.com>
References: <20260616151909.916667-1-jamz@amazon.com>
 <20260619170251.1154562-1-jamz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6640-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8DDEF6A72C7

Propagating syncfs()/sync() to a FUSE server via FUSE_SYNCFS lets the
server flush its own cached or intermediate state when userspace asks the
filesystem to sync.  This is currently enabled only for virtiofs and
fuseblk, because an untrusted server can use it to stall sync()
indefinitely (see commit 2d82ab251ef0 ("virtiofs: propagate sync() to file
server"), and commit d3906d8f3cee ("fuse: enable FUSE_SYNCFS for all
fuseblk servers")).  Both of those mount types require host privilege to
set up, so the server is trusted not to abuse it.

There is nothing virtiofs- or block-specific about wanting to handle
syncfs(), though.  A plain /dev/fuse server is just as entitled to
participate in the sync() path -- so that data it has buffered reaches
stable storage when the user asks for it -- provided it is equally
trusted.

The trust property that virtiofs and fuseblk satisfy is that neither can
be mounted without CAP_SYS_ADMIN in the initial user namespace (neither
sets FS_USERNS_MOUNT).  A plain fuse mount does set FS_USERNS_MOUNT, so its
existence guarantees no such privilege; the privilege has to be checked
rather than assumed.

Add an opt-in INIT flag, FUSE_HAS_SYNCFS, and honor it only when the
server opened /dev/fuse with CAP_SYS_ADMIN in the initial user namespace,
recorded at mount time via file_ns_capable().  This is the same privilege
that mounting virtiofs or fuseblk requires, applied to the process that
actually services (and could stall) the connection.  Checking the device
opener's capability -- rather than the mount's user namespace -- avoids
treating an unprivileged server that merely happens to run in the initial
user namespace (e.g. a normal sshfs mount) as trusted.

The flag is only advertised to servers that pass this check, so an
unprivileged server is never invited to opt in (and is ignored by
fuse_syncfs_enable() if it sets the flag anyway).

Signed-off-by: Jimmy Zuber <jamz@amazon.com>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 fs/fuse/fuse_i.h          |  9 +++++++++
 fs/fuse/inode.c           | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h | 12 +++++++++++-
 3 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 85f738c53122..3fbe4957e839 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -391,6 +391,7 @@ struct fuse_fs_context {
 	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
+	bool syncfs_capable:1;
 	enum fuse_dax_mode dax_mode;
 	unsigned int max_read;
 	unsigned int blksize;
@@ -675,6 +676,14 @@ struct fuse_conn {
 	/** @sync_fs: Propagate syncfs() to server */
 	unsigned int sync_fs:1;
 
+	/**
+	 * @syncfs_capable: the privilege required to honor FUSE_HAS_SYNCFS was
+	 * present when /dev/fuse was opened (CAP_SYS_ADMIN in the initial user
+	 * namespace), i.e. the same privilege that mounting virtiofs/fuseblk
+	 * requires.
+	 */
+	unsigned int syncfs_capable:1;
+
 	/** @init_security: Initialize security xattrs when creating a new inode */
 	unsigned int init_security:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d975073c6029..ba7506b539ae 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -800,6 +800,15 @@ static int fuse_opt_fd(struct fs_context *fsc, struct file *file)
 	if (file->f_cred->user_ns != fsc->user_ns)
 		return invalfc(fsc, "wrong user namespace for fuse device");
 
+	/*
+	 * Record whether the server opened /dev/fuse with CAP_SYS_ADMIN in the
+	 * initial user namespace -- the same privilege that mounting virtiofs
+	 * or fuseblk requires.  Only such servers are trusted to receive
+	 * FUSE_SYNCFS (see fuse_syncfs_enable()).
+	 */
+	ctx->syncfs_capable = file_ns_capable(file, &init_user_ns,
+					      CAP_SYS_ADMIN);
+
 	ctx->fud = fuse_dev_grab(file);
 
 	return 0;
@@ -1266,6 +1275,16 @@ struct fuse_init_args {
 	struct fuse_mount *fm;
 };
 
+/*
+ * A server can stall syncfs()/sync(), so only honor FUSE_HAS_SYNCFS for
+ * servers that opened /dev/fuse with CAP_SYS_ADMIN in the initial user
+ * namespace -- the same privilege required to mount virtiofs or fuseblk.
+ */
+static bool fuse_syncfs_enable(struct fuse_conn *fc, u64 flags)
+{
+	return (flags & FUSE_HAS_SYNCFS) && fc->syncfs_capable;
+}
+
 static void process_init_reply(struct fuse_args *args, int error)
 {
 	struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
@@ -1406,6 +1425,9 @@ static void process_init_reply(struct fuse_args *args, int error)
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if (fuse_syncfs_enable(fc, flags))
+				fc->sync_fs = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1473,6 +1495,11 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		flags |= FUSE_SUBMOUNTS;
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		flags |= FUSE_PASSTHROUGH;
+	/* Only offered to sufficiently privileged servers; see
+	 * fuse_syncfs_enable().
+	 */
+	if (fm->fc->syncfs_capable)
+		flags |= FUSE_HAS_SYNCFS;
 
 	/*
 	 * This is just an information flag for fuse server. No need to check
@@ -1766,6 +1793,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	fc->default_permissions = ctx->default_permissions;
 	fc->allow_other = ctx->allow_other;
+	fc->syncfs_capable = ctx->syncfs_capable;
 	fc->user_id = ctx->user_id;
 	fc->group_id = ctx->group_id;
 	fc->legacy_opts_show = ctx->legacy_opts_show;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..c078c5f0f94e 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,9 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.46
+ *  - add FUSE_HAS_SYNCFS opt-in flag for privileged userspace servers
  */
 
 #ifndef _LINUX_FUSE_H
@@ -275,7 +278,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 45
+#define FUSE_KERNEL_MINOR_VERSION 46
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
@@ -448,6 +451,12 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_HAS_SYNCFS: server requests that syncfs()/sync() be propagated as
+ *		FUSE_SYNCFS requests.  Since an untrusted server can use this
+ *		to stall sync(), it is only honored when /dev/fuse was opened
+ *		with CAP_SYS_ADMIN in the initial user namespace (the same
+ *		privilege that mounting virtiofs or fuseblk requires).
+ *		Insufficiently privileged servers ignore it.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -495,6 +504,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_HAS_SYNCFS		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.50.1


