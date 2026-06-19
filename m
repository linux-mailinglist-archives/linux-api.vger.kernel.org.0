Return-Path: <linux-api+bounces-6638-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WI0qNntvNWo+wQYAu9opvQ
	(envelope-from <linux-api+bounces-6638-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 19 Jun 2026 18:34:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6686A7117
	for <lists+linux-api@lfdr.de>; Fri, 19 Jun 2026 18:34:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b=LXjRT5L+;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6638-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6638-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB6E30214F8
	for <lists+linux-api@lfdr.de>; Fri, 19 Jun 2026 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2993BED7B;
	Fri, 19 Jun 2026 16:33:52 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858C13BF684;
	Fri, 19 Jun 2026 16:33:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781886832; cv=none; b=amfTKDOtoih5EwCQb9v1eNeNDJdeej4K6M4IhTxgf/UU89QiqSY62hxVv/NCgmkkCGY0iJJrbA5ymQvQ6l0q5PPSdjynQstOy/Ukab07XkMxOZTmEKlWl0X0YrV8zJB3X0zSWuzVSWBnNY2yS2N+yV+4akg9bRYVXNC/GLzhBEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781886832; c=relaxed/simple;
	bh=nsYDrZsp+vTvJMJIN2MK7K49oYAN0yKaEKNmvUHt4MA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K+ZfRJiMrMV9ZU09azTYLzwkHVtLbjMcLpf/gYvOcMbBqiZ1QMsozAn+J4DgSATC6TCuE1x5CMNgW+6uluxhUhALiAQCI+8JU7qzrdzyyYWtM0p1cOGavAnGCvEONuXvUn8jXDfAXYeeIb5oHD8fAhi3RUclxkWqQMaZvXYdw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=LXjRT5L+; arc=none smtp.client-ip=44.246.68.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1781886831; x=1813422831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eTy2HClp4WtsxdcO75RB9LPq5/NgSBBoO+lN2r4o+9o=;
  b=LXjRT5L+AAK+eTc1ygIJ0oIxpftrMOiqk2P36vUuKkqd65Om8eQ1/KMW
   mTDNyD6AesTOtwIW3BjwtsgAStDpN+v1VBT5xjg47a7AnJzLgw517gGcj
   ViuO7NJHnShqq8M/qYX5qMWtj4Irz0m53bNjc02Ow7IXdgG49jkGPoZsm
   MaIbm0T9aCsLHDL7tKW6oz/xlG31HqvAB/iBz2vjWP2AYrOzzh6KeHZR9
   Ohem3admgMIpqNiO5GR/bRx4oSz+LdU+XmpxW8DtbaljnOMG3qzq14kxc
   kU3iHHMDyOGjUjJMbBOpT4orMn+5nHZYPHuw5m+TCI/3AWykyK/tLNg+k
   Q==;
X-CSE-ConnectionGUID: Xy+2LSxBR9uNhExcDqWGHA==
X-CSE-MsgGUID: JkEu7JaxQv6rpds8WdiU1g==
X-IronPort-AV: E=Sophos;i="6.24,213,1774310400"; 
   d="scan'208";a="22119099"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2026 16:33:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.104:7419]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.253:2525] with esmtp (Farcaster)
 id 9b85b132-0966-4946-ba69-c66757288e4d; Fri, 19 Jun 2026 16:33:50 +0000 (UTC)
X-Farcaster-Flow-ID: 9b85b132-0966-4946-ba69-c66757288e4d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 19 Jun 2026 16:33:50 +0000
Received: from dev-dsk-jamz-1e-e35f4cd9.us-east-1.amazon.com (10.189.35.140)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Fri, 19 Jun 2026 16:33:49 +0000
From: Jimmy Zuber <jamz@amazon.com>
To: <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <jamz@amazon.com>,
	<linux-api@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<shuah@kernel.org>
Subject: Re: [PATCH 1/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
Date: Fri, 19 Jun 2026 16:33:37 +0000
Message-ID: <20260619163337.1138220-1-jamz@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAJfpeguaa4U6Tsxh5opeaLeYQQxP6MQsRMu_JATJwwgj=OBt3Q@mail.gmail.com>
References: <CAJfpeguaa4U6Tsxh5opeaLeYQQxP6MQsRMu_JATJwwgj=OBt3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6638-lists,linux-api=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:jamz@amazon.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:shuah@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,szeredi.hu:email,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B6686A7117

On Mon, 16 Jun 2026, Miklos Szeredi <miklos@szeredi.hu> wrote:
> Sounds really easy to trick: start the server in the initial user ns,
> then clone the mounter with a new user/mount namespace.   The
> init_user_ns test will pass happily, since the server is running in
> the initial namespace.

Ah, the intention was to limit sync to sufficiently privileged FUSE
setups.  I missed that the initial user namespace is not equivalent to
elevated permissions.  I am thinking instead it would make sense to
assert that the opener of /dev/fuse has CAP_SYS_ADMIN in the initial
user namespace.  They could then hand off the fd to a less privileged
server, but that is the prerogative of that privileged user, so I think
it satisfies the spirit of the DoS prevention requirement.

I will follow up shortly with a new version.

Thank you!

Jimmy

