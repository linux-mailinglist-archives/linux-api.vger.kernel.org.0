Return-Path: <linux-api+bounces-6527-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vN+aI+SzIGqT6wAAu9opvQ
	(envelope-from <linux-api+bounces-6527-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 01:08:20 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0700363BBE0
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 01:08:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gSo1igrI;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6527-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6527-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584DD3028EDF
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 23:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE4F4DC532;
	Wed,  3 Jun 2026 23:01:30 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E164DC523
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 23:01:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780527690; cv=none; b=T3qndEKPNErRwO7onE0kQLPjEm/i/3CRjlbXvI9IOmZNnMJEl1dzlFJPOz2GwvTTHfN0VOlemdIZ75/8v7E5B2HMjlMTpkHxxILxoYtSrXynpwjNGMG5cdywhi5aCL+U+RKHwHb/ukfD4j1sVe6mZPUkmDp4oT7yqkiC9ZOx0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780527690; c=relaxed/simple;
	bh=kjRfpHBz6N1AcpGrp9EdxI0+Sil4adZV+IHhFHCAUwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/NpGfzuPzulJ2XYeez9NkN4BVCg4yfxGrCArobewY5DPw6mWFsBUsviTO537H9H6vgAESzwIhQTqiV6+B88YFzzAdjYjJIkB7mdHsIN9/AQbDy7Dbs6rO5PbPBKrd6wXukqqGT1UDXls+aCpL5oJ+XptzhuVdARAzT/GqDPZs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSo1igrI; arc=none smtp.client-ip=209.85.221.41
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ef41adbc1so41323f8f.0
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 16:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780527687; x=1781132487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1JUsgVJ7d9U2h7quy8Vg4SoAkC431+Nv0NzGMCDYE0=;
        b=gSo1igrI1wL5kJ6UndiT5O9wUnbR1ViIc5P0v+f/a9cvwzfdZslrpvEaunbWa67vIe
         31TaaKNtbR+VHWyYehfJqdyRei6AVCW6mqotiAtD2VVx7+q/JglzSRcMdF/851mR8Q7n
         RNov+1+1zmXH5Csbf5l04SQ4cD+quEhLfsYisaAIg3ABL6f8tB/yGzgW+b8/mkebpG6G
         b1D/6AytXXY2hZX48piRkZoX2hmOfWlu095Yk7C8kKj1U20o2xzi9U5otCA7VKv0sMtH
         Y3clBaKa707v8cLN95oQbwUdTCGQea0rw3AraP1GVr0WTrlwgFoGb5TJHEyu0C3YyuCh
         KbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780527687; x=1781132487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b1JUsgVJ7d9U2h7quy8Vg4SoAkC431+Nv0NzGMCDYE0=;
        b=Is8DWJYkAOpzzBBYEX9L4mjJq6R2d+3KGCCpjdSftHVRANFNnlp9Dh4Asb0ArLJ6gZ
         YM2CDlWTf1ADkMBfJaxkq15S75z+sc0paTj/955X+74mSRraGVlDyfNFdBHj79m4P84Z
         Uf73w/CS+VbjZnaWVTiwYi4s7WrNVTM4kRmWNv3+Ia9DC1elihBjRYz+/hjocpQXHfBx
         HlOpEiDy3j51eUjG+Sp/svDOxlmuyC7uEWdiA+3OIW3wvhwz55BwvY732id82/3qDELc
         tPMwJt1tMFwx8a2Q6XmmCduaC54ANrftQoq37cUsja8FH9aN/xtSd3ivs0N1HaZksqic
         WC7A==
X-Forwarded-Encrypted: i=1; AFNElJ8vliKrxxY7gnX1d6cEbpe48BRmxjHPSMPsA1XntLNXWThrtFWf6Xl58ut8FEj00vq4poKaxensjec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5z3oiSiHLLlLKagx63bjdkJcbbZho5N52pAMm7mD4HxvzsNFm
	vhGEx2LG+U48V9w3AnIWTA5Dt7a/8htJgDN4MUxNwFk4kW5T71OR5qda
X-Gm-Gg: Acq92OFB3J0Y0MK3TJ4Rlqrn6+MipDv4NbsNvxQMJ/hOhwAAaJFwwa+Cpp+RpBtbj5J
	k5qwJQSfC16hJWRzg83ms9GdN9Pv5C+ojNZKVw7q8qIacnFjj6WPpZvQ1vQ9mlPo6AmnK3igQkZ
	KprckmFglsFVAJHUe853eYgBklKEAAC3wRkOQiAzeQGsetNViLFGuELihIEvZFXOcBuJ4o9MUWL
	L7ScQECSckHrFv+BAGbSVBTJEPLwBWm+69PrpcnyJJ/1W5TwES9LsR73NIQSYNW9dvLUXi3TRQ3
	D/yj9kWSmvo2+39r6sBaBRtJKSEOfvNudRg3DxkFSJhROc/ACBTJz0Z7fnzZboiR3THi7EIvWHM
	JIPQliO2wDpRBPmh9T66YcCJyfLt1oXInViyHe5KcVirKGP9gXZP3mYrrrGsNr/EaPK2LbfNL2r
	Ka0nSltkX6yDpLlicyyThsCI1gslYF2A==
X-Received: by 2002:a05:600c:4043:b0:490:b2a6:8c2a with SMTP id 5b1f17b1804b1-490b5e748e3mr51931455e9.5.1780527687138;
        Wed, 03 Jun 2026 16:01:27 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-490b7e6c6a4sm45890145e9.2.2026.06.03.16.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 16:01:26 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: luto@amacapital.net
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	david@kernel.org,
	dhowells@redhat.com,
	hch@infradead.org,
	jack@suse.cz,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
Date: Thu,  4 Jun 2026 02:00:25 +0300
Message-ID: <20260603230122.851517-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
References: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-6527-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,gmail.com,zeniv.linux.org.uk];
	FORGED_SENDER(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:safinaskar@gmail.com,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[safinaskar@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amacapital.net:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0700363BBE0

Andy Lutomirski <luto@amacapital.net>:
> On Wed, Jun 3, 2026 at 3:43 PM Askar Safin <safinaskar@gmail.com> wrote:
> > Finally, we can degrade tee(2) to copy, and hopefully this will
> > allow us to always be sure that pipe buffers are not shared with anything.
> > This is possible future direction.
> 
> I'm a bit nervous that, if I've read the code correctly (a big if),
> then iscsi and nvme will still send *shared* buffers via
> MSG_SPLICE_PAGES, but that normal user code will not be able to do
> this, and that something will bitrot.

As well as I understand you correctly, you mean that if we remove
tee(2), then there still will be subsystems, which will be able to
send shared pages.

Yes, I totally agree.

So, if we remove tee(2), then we will probably need to remove all
non-standard implementations of pipe_buf_operations.

-- 
Askar Safin

