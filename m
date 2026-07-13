Return-Path: <linux-api+bounces-6834-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dmcRMVXyVGoXhwAAu9opvQ
	(envelope-from <linux-api+bounces-6834-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2026 16:12:37 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D9E74C327
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2026 16:12:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amazon.com header.s=amazoncorp2 header.b="dOk/anWG";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6834-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6834-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amazon.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6A7673024406
	for <lists+linux-api@lfdr.de>; Mon, 13 Jul 2026 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A3E3812E1;
	Mon, 13 Jul 2026 14:12:17 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.68.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4E2D47FF;
	Mon, 13 Jul 2026 14:12:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951937; cv=none; b=P68gKiSPKTbsFIEtIGdP1zslzOJpaEFlZovILE3WhpQqwMW41uNe9hh2KD5gucEKb68KcMgMJuv21Yfz6NOe+R6JQNCm5PaO8Sa4KmfJAKWKrP/2IzH1Yfod1GDBGFqfR4aDWT9hd+aHRNm34zWSzgCrYO+PW7ep01jJhGZ4wiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951937; c=relaxed/simple;
	bh=sVvVU7SZrOByNfcvMhp2k29M+KzZ2+Lij7PMj5z9cbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7E2MwuJxiYIZ8dypVjvZFxd2wPBTddv6Ua1J2BCZirxxHzE2ZCH+4ok06yxDqlFt/RLZtJDcgnUSqX4gyKC1pb3GDKR9tX+FVLvI0XEIXc42Zmlgh3Skd072MdDExBuEOa3OjTbbpKmab2hm4/Vik3x6JOCPN626DfX4UxfstU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=dOk/anWG; arc=none smtp.client-ip=44.246.68.102
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1783951936; x=1815487936;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sVvVU7SZrOByNfcvMhp2k29M+KzZ2+Lij7PMj5z9cbw=;
  b=dOk/anWG/07l8259+PUICxZ8I3KttOuKI9HlDDAs4kD9TgpvRUwanBCA
   COBdKh8p/5HLFyJQ8kBrjoqoON0TIE/nb1cBkSFO6r935BPqJWQTtdWlJ
   JkZPEpNs2oXC+fg2g8nukU0qdUsQQBFCXneQqukNETd/z7FS62OEXBVum
   kjhXfdALFkTx0YEjOgQwQx6jnbvZ3hgk1O+Cx/am1yH5ql4SLEaBP+nGU
   Bj6HmaiOqf5iz7lH9LMjN1blClq8VBJ54u2erT+u188zeAjJGOu7a+4nI
   g+0Dh7gkTljDcC5aBk29oRZoYHglOeOUDmjNVV07ByZKKlqKQxM22xyAw
   w==;
X-CSE-ConnectionGUID: UFazFn6eR7quOZEhmGcc/Q==
X-CSE-MsgGUID: r6LDZvdeRWCy1vn7rAru8g==
X-IronPort-AV: E=Sophos;i="6.25,154,1779148800"; 
   d="scan'208";a="23589592"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-003.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 14:12:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:6927]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.51.175:2525] with esmtp (Farcaster)
 id 0907596a-dae2-48ee-8b8a-e7f622515fba; Mon, 13 Jul 2026 14:12:15 +0000 (UTC)
X-Farcaster-Flow-ID: 0907596a-dae2-48ee-8b8a-e7f622515fba
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 13 Jul 2026 14:12:15 +0000
Received: from dev-dsk-jamz-1e-e35f4cd9.us-east-1.amazon.com (10.189.35.140)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.43;
 Mon, 13 Jul 2026 14:12:14 +0000
From: Jimmy Zuber <jamz@amazon.com>
To: Miklos Szeredi <miklos@szeredi.hu>
CC: <fuse-devel@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-api@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] fuse: allow FUSE_SYNCFS for privileged userspace servers
Date: Mon, 13 Jul 2026 14:12:03 +0000
Message-ID: <20260713141203.2838402-1-jamz@amazon.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260619170251.1154562-1-jamz@amazon.com>
References: <20260619170251.1154562-1-jamz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[amazon.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6834-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jamz@amazon.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 23D9E74C327

Hi Miklos,

Gentle ping on v2 - I've added CAP_SYS_ADMIN checks at /dev/fuse open
time. I hope this addresses your concerns. Let me know if there's
anything else you'd like changed.

Thank you,
Jimmy

