Return-Path: <linux-api+bounces-6619-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VJzYGlBrMWp3iwUAu9opvQ
	(envelope-from <linux-api+bounces-6619-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 17:27:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B39691094
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 17:27:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=tzgoBjDa;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6619-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6619-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D78131308E6
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 15:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6911943E4B2;
	Tue, 16 Jun 2026 15:19:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4186743E484;
	Tue, 16 Jun 2026 15:19:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623166; cv=none; b=aPkUq6FjYchraCcMwZYY4XeNJigOGwIrUHT6Wc+LqJ4H0P7zQNzu0ELhPsrum6q3tjeTs988dNYHYLLB2WsLQZAieisTuax0sZrzQrUrqPiGQ/q3Yz4IghBZ9oAlPKiFunzjSRnDTMUNievDVyGvHTYwZtAf46ERF4R4e0OaZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623166; c=relaxed/simple;
	bh=IyuOPwnmSb/fVTCH/e1N0mn2W7SKPp8fj8S+qLFAPk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvTh2/yRmiEDUKEqz/O74kosmT9jCJBqlG5gxBfLqbWytARu70CG/7ybqA1eS875G7nyQujExhmjarjtsOf2OnODfLI8CnbiraAEIaaYe01GTMiGgFBeDFDVZeUBqTASEzgI3xPG5kPJ+piLtmkgukhoYJCFFT4TJJTDMfjIM70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=tzgoBjDa; arc=none smtp.client-ip=35.155.198.111
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781623165; x=1813159165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tT9ViwbeGZOmHpTUMJe4+1N7IXhmgG+37I0SsksN/z0=;
  b=tzgoBjDaLJsh6gyc3vOK2xQ/XJbkKjAONWtTHYHTjYQ2QXJgjBTDtCDD
   sVwjA2Ovo3GFQCUDeXY8hU9TJ/WhajsFJJRni/1BIufQh7mQ4gSs89aG7
   RmAB/8fZhq0t2FbdD7+HkQxFlFF1ML+jgVz7a4R8YDnFxTr4YE6gXoVBs
   9aQ76j6FHflYDy8k8+MsSfLXBkVIgfpC44T6e10AfTmBALJfgPveifRk4
   f7ME3616FrGFVVbkwDq9F2ygEWqrEoH0sbu5q57YoSoe/mFRIP5jC1k+l
   SK6BHSpNuU4v6XHvGPeg6wF7dReaiOJ1kAkWT87/35lIjgbklm32BA55l
   w==;
X-CSE-ConnectionGUID: G0EU5j04RqGWcfC39FMyUA==
X-CSE-MsgGUID: 0q2HeqPqRLSwa8yrfFJlRw==
X-IronPort-AV: E=Sophos;i="6.24,208,1774310400"; 
   d="scan'208";a="21753083"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 15:19:24 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:10731]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.253:2525] with esmtp (Farcaster)
 id 75061158-3cff-453b-9b7f-4c209f66b456; Tue, 16 Jun 2026 15:19:24 +0000 (UTC)
X-Farcaster-Flow-ID: 75061158-3cff-453b-9b7f-4c209f66b456
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 16 Jun 2026 15:19:24 +0000
Received: from dev-dsk-jamz-1e-e35f4cd9.us-east-1.amazon.com (10.189.35.140)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 16 Jun 2026 15:19:23 +0000
From: Jimmy Zuber <jamz@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH 0/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
Date: Tue, 16 Jun 2026 15:19:07 +0000
Message-ID: <20260616151909.916667-1-jamz@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6619-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8B39691094

FUSE_SYNCFS (propagating syncfs()/sync() to the server) is currently
enabled only for virtiofs and fuseblk, since an untrusted server can stall
sync().  But any FUSE filesystem may buffer data in the server that should
reach storage on sync(); the only thing that should gate it is whether the
mount was set up with host privilege.  This series lets a plain /dev/fuse
server opt in via a new FUSE_HAS_SYNCFS INIT flag, honored only for mounts
owned by the initial user namespace.  Patch 1 has the full rationale and
the security argument.

  Patch 1: the kernel change (UAPI flag + gating in process_init_reply()).
  Patch 2: a selftest that speaks the raw FUSE protocol over /dev/fuse, so
           it can withhold the flag and directly observe whether the
           FUSE_SYNCFS opcode is forwarded -- covering the privileged,
           opt-out, and unprivileged-userns cases.

A matching libfuse change (FUSE_CAP_SYNCFS negotiation) will be sent to the
libfuse project once the UAPI flag here is settled.

Testing: built and booted under QEMU (x86_64).  The selftest passes all
three cases.  A separate end-to-end check on a FUSE_WRITEBACK_CACHE mount
confirmed the point of the change: after write() the server had received 0
bytes (data dirty in the page cache), and after syncfs() it received the
full buffered payload followed by FUSE_SYNCFS -- i.e. syncfs() flushes
cached data to the server on a privileged mount.

Jimmy Zuber (2):
  fuse: allow FUSE_SYNCFS for privileged userspace servers
  selftests/fuse: add test for FUSE_HAS_SYNCFS privilege gating

 fs/fuse/inode.c                               |  16 +
 include/uapi/linux/fuse.h                     |  11 +-
 .../selftests/filesystems/fuse/.gitignore     |   1 +
 .../selftests/filesystems/fuse/Makefile       |   2 +-
 .../selftests/filesystems/fuse/test_syncfs.c  | 318 ++++++++++++++++++
 5 files changed, 346 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/fuse/test_syncfs.c


base-commit: 7d87a5a284bb34edb3f4e7e312ef403b3385a7b7
-- 
2.50.1


