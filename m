Return-Path: <linux-api+bounces-6620-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gtUsKoJrMWqHiwUAu9opvQ
	(envelope-from <linux-api+bounces-6620-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 17:28:02 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FA76910C8
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 17:28:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=R3F0fLoS;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6620-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6620-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D007B3217D32
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416DA44BC9A;
	Tue, 16 Jun 2026 15:20:03 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EEF44B69C;
	Tue, 16 Jun 2026 15:20:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623203; cv=none; b=LexkZci727UcSd2Iir4//wPQZnz9lU3tHH1Iy7DUOBnwwo92XmnjPRbtASPcL5NWhjwZdUK4gtEeo0zadGO0JybB2z2blIX2G2Oh4pOCnFYGoD4KsETExjt3Lho9dAxVfZwFnR7HcQps0jHSm2N65nBfmw2ZD1OGUEF38GAdPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623203; c=relaxed/simple;
	bh=F4E8+dUvsy0Eq1XA3iSkET8r/qtfriv8PeIxiEmgYRk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDwem0fla6YDNLJMN0SjlWG81fgJPTwrQdROdwI2ZNtT2JUC9qC9sNu84eNBsaYxzKG1QdKTFP0lVrU8Lz8IMpVDFcunPLRYF8SvoZxHlFJfaJh517e8Tpdq2NN+xdMtpBYHI+SKYa+sNRWXG6xVRTd+2gEOdTa76I/0dwp60x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=R3F0fLoS; arc=none smtp.client-ip=44.245.243.92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781623200; x=1813159200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZFTUUIDmKFkKHw+FVxZp3xDm5LElKqYkS9vDfP+n8E4=;
  b=R3F0fLoSTPFnTQ/hs25zU9yQPU56BZyB5CMnPfU2c9QupUNnjzSyhYrC
   ovjdEFdFTH4jkj+Z2V/yypMQhIevJOhhop3W5CTbqicK5GdQn0lYk0KCR
   Q7xWNMrZO9aHf3WhMUUw8GZpdZ60c9RGuQXUuJV9RoolfmxDxkFpF4QHe
   o2DZ4o2eJVrqfzimsczFaheFKoD/RU6aLP8SzsdjTx0SIv8yRnlPLr/0f
   BubN7QCLrYLjrBUURVNwAIPkjznE9Zt0WvYw3FYlrC5vndFjssVKjw4tJ
   N2Kzw2/eCq/nQap/JnHR5w9TnxlhyX3gkWW4b6ZmrjT5JGmCCTKrMfQkv
   A==;
X-CSE-ConnectionGUID: xZnqeHAEReKGn+dmVqicNg==
X-CSE-MsgGUID: 1PtQ6QZFQxCTzPJZ2Dma5A==
X-IronPort-AV: E=Sophos;i="6.24,208,1774310400"; 
   d="scan'208";a="21375125"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 15:19:58 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:7184]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.143:2525] with esmtp (Farcaster)
 id abb6b843-7777-4a7a-9576-2c070f6e98b8; Tue, 16 Jun 2026 15:19:58 +0000 (UTC)
X-Farcaster-Flow-ID: abb6b843-7777-4a7a-9576-2c070f6e98b8
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 16 Jun 2026 15:19:57 +0000
Received: from dev-dsk-jamz-1e-e35f4cd9.us-east-1.amazon.com (10.189.35.140)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 16 Jun 2026 15:19:56 +0000
From: Jimmy Zuber <jamz@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH 1/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
Date: Tue, 16 Jun 2026 15:19:08 +0000
Message-ID: <20260616151909.916667-2-jamz@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260616151909.916667-1-jamz@amazon.com>
References: <20260616151909.916667-1-jamz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB002.ant.amazon.com (10.13.138.121) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6620-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28FA76910C8

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
trusted.  The relevant trust boundary is whether the mount was set up with
host privilege.

Add an opt-in INIT flag, FUSE_HAS_SYNCFS, and enable propagation only when
both:

  - the server sets FUSE_HAS_SYNCFS in its INIT reply, and
  - the mount is owned by the initial user namespace
    (fc->user_ns == &init_user_ns).

The user namespace check is the key restriction.  A regular fuse mount is
mountable from a non-initial user namespace (FS_USERNS_MOUNT), where the
server is untrusted; the VFS already marks such mounts with
SB_I_UNTRUSTED_MOUNTER.  Restricting FUSE_SYNCFS to init_user_ns mounts
preserves the original DoS protection for unprivileged servers in full,
while mirroring how virtiofs and fuseblk earn syncfs by construction
(neither is mountable from a non-initial user namespace).

The flag is only advertised to servers whose mount is owned by the initial
user namespace, so an unprivileged server is never invited to opt in (and
is ignored by fuse_syncfs_enable() if it sets the flag anyway).

Signed-off-by: Jimmy Zuber <jamz@amazon.com>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 fs/fuse/inode.c           | 16 ++++++++++++++++
 include/uapi/linux/fuse.h | 11 ++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d975073c6029..d0005a373729 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1266,6 +1266,16 @@ struct fuse_init_args {
 	struct fuse_mount *fm;
 };
 
+/*
+ * A server can stall syncfs()/sync(), so only honor FUSE_HAS_SYNCFS for
+ * mounts owned by the initial user namespace, i.e. set up with host
+ * privilege (like virtiofs and fuseblk).
+ */
+static bool fuse_syncfs_enable(struct fuse_conn *fc, u64 flags)
+{
+	return (flags & FUSE_HAS_SYNCFS) && fc->user_ns == &init_user_ns;
+}
+
 static void process_init_reply(struct fuse_args *args, int error)
 {
 	struct fuse_init_args *ia = container_of(args, typeof(*ia), args);
@@ -1406,6 +1416,9 @@ static void process_init_reply(struct fuse_args *args, int error)
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
+
+			if (fuse_syncfs_enable(fc, flags))
+				fc->sync_fs = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
 			fc->no_lock = 1;
@@ -1473,6 +1486,9 @@ static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
 		flags |= FUSE_SUBMOUNTS;
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		flags |= FUSE_PASSTHROUGH;
+	/* Only offered to host-privileged mounts; see fuse_syncfs_enable(). */
+	if (fm->fc->user_ns == &init_user_ns)
+		flags |= FUSE_HAS_SYNCFS;
 
 	/*
 	 * This is just an information flag for fuse server. No need to check
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..de1002063ca2 100644
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
@@ -448,6 +451,11 @@ struct fuse_file_lock {
  * FUSE_OVER_IO_URING: Indicate that client supports io-uring
  * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
  *			 init_out.request_timeout contains the timeout (in secs)
+ * FUSE_HAS_SYNCFS: server requests that syncfs()/sync() be propagated as
+ *		FUSE_SYNCFS requests.  Only honored by the kernel for mounts
+ *		owned by the initial user namespace (i.e. set up with real
+ *		host privilege), since an untrusted server can use this to
+ *		stall sync().  Unprivileged (user namespace) mounts ignore it.
  */
 #define FUSE_ASYNC_READ		(1 << 0)
 #define FUSE_POSIX_LOCKS	(1 << 1)
@@ -495,6 +503,7 @@ struct fuse_file_lock {
 #define FUSE_ALLOW_IDMAP	(1ULL << 40)
 #define FUSE_OVER_IO_URING	(1ULL << 41)
 #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
+#define FUSE_HAS_SYNCFS		(1ULL << 43)
 
 /**
  * CUSE INIT request/reply flags
-- 
2.50.1


