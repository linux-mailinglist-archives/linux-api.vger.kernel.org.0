Return-Path: <linux-api+bounces-5820-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLrZF68SjGkXgAAAu9opvQ
	(envelope-from <linux-api+bounces-5820-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 06:25:03 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA27D12156A
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 06:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6496830AF04C
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 05:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AB334EF06;
	Wed, 11 Feb 2026 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTzOtXD6"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF14234D926;
	Wed, 11 Feb 2026 05:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770787104; cv=none; b=NNT4U+ISk96wtnIk6Cyug7ZDNROQHwJQSeSRnPf50FM31B7yi6HvU7vTYZo/29H+vicTaxvWX+RnTbvceGtxfqPQ+8O4roP+jbii9Xe7zcu5jLD3BGVMDlXj8awPd1kh7BqBoRuHb5GPIIQB/KO9aYUrMIvouefkJqjgvAFdc2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770787104; c=relaxed/simple;
	bh=Pskl427gWPDagJF7z85JNfrUYZz4g083sn0tWVlxPQI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p5ZJ1T75fL/7/HENZdh5nGf4rQBNr15E4qwUmbCahKEB05WV+feBVWjpFGrLIRNTGHS1JekP1aeC//KNLMt03Ez6xnopC4w6Q879LjSrleMyaT1Nad7QWAQW/Tq2zhZJMXRxnb8FeIevk5K3pJLQFrNrN6k6B3JYBihTs+Pbm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTzOtXD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E82C4CEF7;
	Wed, 11 Feb 2026 05:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770787104;
	bh=Pskl427gWPDagJF7z85JNfrUYZz4g083sn0tWVlxPQI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UTzOtXD6WASz5wZb3BsYEMklCB18KIVgf+X7kROybeOB+gbI27sghzY4kBn6Ke2hb
	 +ravEBg8rrdIkke892VD3HiAd7Z7szft44jzGcl5s6rIQm8hOR/mZ9xCCe62c4IUCO
	 8+vf/OBZChDBZKREZvJg1LCWfhbO8B8DayZtVGLArnbEYTik1fNH0Ey3L+UQlvrItT
	 RnQDVZkzms/xFx3KxJafB/rY2bF6/rsALcjGhl6q9M4ugLOujCHc28ANOAuVNwyEYd
	 SkaocTFRpPCT+UF6qJBc182Z9rsfaWXMKtv8+QIKh85+23OCAvt+6o4ID4DEjXY5bh
	 tblYjtyYjYTJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B24B380AA50;
	Wed, 11 Feb 2026 05:18:21 +0000 (UTC)
Subject: Re: [GIT PULL] asm-generic header updates for 7.0
From: pr-tracker-bot@kernel.org
In-Reply-To: <836fc2ce-751f-4eb0-bdb4-f43f83401b89@app.fastmail.com>
References: <836fc2ce-751f-4eb0-bdb4-f43f83401b89@app.fastmail.com>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <836fc2ce-751f-4eb0-bdb4-f43f83401b89@app.fastmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-7.0
X-PR-Tracked-Commit-Id: adbbd9714f8058730f93c8df5c5bf1679456424b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b398c05625a158e24da00887bbba284e9dab0b0
Message-Id: <177078709955.18664.17571306693160215494.pr-tracker-bot@kernel.org>
Date: Wed, 11 Feb 2026 05:18:19 +0000
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-api@vger.kernel.org, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5820-lists,linux-api=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA27D12156A
X-Rspamd-Action: no action

The pull request you sent on Tue, 10 Feb 2026 18:02:40 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git tags/asm-generic-7.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b398c05625a158e24da00887bbba284e9dab0b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

