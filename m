Return-Path: <linux-api+bounces-6512-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iZrAL0tvIGqx3QAAu9opvQ
	(envelope-from <linux-api+bounces-6512-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 20:15:39 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD1463A75D
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 20:15:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=EYt4jGOF;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6512-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6512-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F0EFA3008696
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C290D38C2D0;
	Wed,  3 Jun 2026 18:14:55 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EB32C92D;
	Wed,  3 Jun 2026 18:14:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510495; cv=none; b=ppOa62NLkb0Am8ureoxY5cHNxMDnxEjWTsXwWdiPBRVOFB3QE4u1EJQIGFMcHG/QCLSDS+ph4VHYctCC0+1xyv9cO7emRoveHemx70XldCUGXk1YmHeYWjkjhRdted5Ubl32oaSUFp3NCAAVrm4lahRT7AharSnCrfRaz38fjJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510495; c=relaxed/simple;
	bh=Zh3bOPf3WGGGuDpapVApizEvYFMTNyzllD1587uNksE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SslGmAuJUZIUi15KVeH9QK2rkWRAO/yjdCxOmt03UlA/VTdswZWzjAZ0ZfgjL2YzFC5aOPaq1gI+ZHdCpnmK63IbWkgazeowoubD+CmqWX8opJ14xAQEHtsEwwjEdVdVp8oa7lE7/5tlYrZ0XqdE20l74cS7+Y+mKaXWLYgidjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EYt4jGOF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922DF1F0089B;
	Wed,  3 Jun 2026 18:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780510494;
	bh=6WrRoXO8ws2YpgPqY1eyvviLf48IBcpkEZY8IYp2NLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EYt4jGOFf5LyezMTLV9dtf2WymLahWZzOV9zIlsR/s0qVRxpHXAAirSEbS46iArUz
	 3jFo9xc18HpY/AIlMplWvxVe2GOAw49DmR+mT+asEMqWykbJ3kaGZxjmXlhW4c8Ors
	 EW/vIn7AffpcwBX08cwjSweCluQTp3Sevfta9TJlQ7MM6F7ZVYwEsQy2HTUikfeGFa
	 xQZRg7I4AP/QtUfwHSQZfCZmhKiph4Mdhz2KEt6agP6Meih8rA58vz+GsKjWNqY2AQ
	 pEIH9ry/aBOAEjUXK0Ra/KnN1Fh7TD8mTUn2t3uUQKfwGWOkiN7vTRf9U+IHj5k+B0
	 fFWYzzBA9yA4Q==
Date: Wed, 3 Jun 2026 11:14:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andy Lutomirski <luto@amacapital.net>, Linus Torvalds
 <torvalds@linux-foundation.org>, Askar Safin <safinaskar@gmail.com>,
 akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org,
 david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz,
 linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu,
 netdev@vger.kernel.org, patches@lists.linux.dev, viro@zeniv.linux.org.uk,
 willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260603111452.7e7bb17c@kernel.org>
In-Reply-To: <aiAREqlHK1llOw_y@pedro-suse.lan>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
	<20260602225426.122258-1-safinaskar@gmail.com>
	<CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
	<CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
	<aiAREqlHK1llOw_y@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6512-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pfalcato@suse.de,m:luto@amacapital.net,m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[amacapital.net,linux-foundation.org,gmail.com,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,zeniv.linux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ACD1463A75D

On Wed, 3 Jun 2026 12:43:54 +0100 Pedro Falcato wrote:
> > Am I understanding correctly that this will completely break zerocopy
> > sendfile?  sendfile is, internally, splice-to-a-secret-per-task-pipe
> > and then splice to the socket.  How much to people care?  These days,
> > a lot of high-bandwidth network senders are sending encrypted data,
> > which is not zerocopy frompagecache.  But there are surely some users  
> 
> You can do zerocopy from the page cache, even with TLS on top, by having
> your (fancy) NIC do TLS offloading for you. See https://people.freebsd.org/~gallatin/talks/euro2019-ktls.pdf.
> Linux works similarly. Slide 26 is particularly interesting.
> (No KTLS I assume is using simple sendmsg()'s from user memory, SW TLS
> and NIC KTLS are both sendfile(), per the slides)

FTR this datapoint should come with the caveat that kTLS _offload_ does
not support TLS 1.3 today. So how much that configuration is used in
practice is unclear.

