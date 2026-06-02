Return-Path: <linux-api+bounces-6495-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /UtuOj1NH2pzjwAAu9opvQ
	(envelope-from <linux-api+bounces-6495-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 02 Jun 2026 23:38:05 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D546321E3
	for <lists+linux-api@lfdr.de>; Tue, 02 Jun 2026 23:38:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=M8lWh5+g;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cGUK5jrQ;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="ei+a51m/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LvWaNZL3;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6495-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6495-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE9B2300E32D
	for <lists+linux-api@lfdr.de>; Tue,  2 Jun 2026 21:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C723A7F40;
	Tue,  2 Jun 2026 21:37:58 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F723A5E65
	for <linux-api@vger.kernel.org>; Tue,  2 Jun 2026 21:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780436278; cv=none; b=trATIKnVlHUTTvUhnLIAFOd+BRz5R3DoPeqimci8FrHl/PPO1XxG+QLoQ+YZidBDD6AVN2KdyvmnvAGQnRylpCjo1SPxX3dWdvvVFW80UHWzLbbrsstUDBjFvYyjFWmpgoJm9KZ1AlEqQkWT3VYBTNapcQPuxK08DI42xJalh64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780436278; c=relaxed/simple;
	bh=xhYpWUENoTR0OZggrGjOnTgCpp/+GiC/7NyKD0OO7MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH1VvwDrqxghV6umNbJgvBQNa+rgIs0Z6jwsBfmKUsDxy2NcZeAwDTnX35IuFFUdLfoYpwYC6VlopcRssKAWjcX4BjPYrlMzKFnenlSlh1Fizckl22/h8PQM0M//BtRxKbmZcCuqFFv9K7nFje+vH+fEzP1cIUrzSOgSIT2jly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M8lWh5+g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cGUK5jrQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ei+a51m/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LvWaNZL3; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74D596ABFF;
	Tue,  2 Jun 2026 21:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780436275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSF02Sys3oVPf3cWJGRWD+ZLq8fEyAUMeudt9t44hp0=;
	b=M8lWh5+gTYn+cX72Ntq1+YGiMGcx6YZmz1dmG9Wrx9B/274KkcNZp5X/tS8oulRC2FmIg7
	xdojLIred0QPr9SZY+H/crZU7e/BuSRXZZQXbbkSafomj0Ybe8clQLVJXRznCwHMZhgyYh
	yCtmpnSWs675bUrW7Cx9JmU87Di+rPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780436275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSF02Sys3oVPf3cWJGRWD+ZLq8fEyAUMeudt9t44hp0=;
	b=cGUK5jrQZioFApFgCcvA2bgc35fJD9djwlafuGa9Hn74YwjeZeQcfOklZ7tTfptgjcVcd0
	Yqa098xA+NDP2PDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780436271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSF02Sys3oVPf3cWJGRWD+ZLq8fEyAUMeudt9t44hp0=;
	b=ei+a51m/ruJ9TbtcRdBQqkNkuhAFbXg/qwTdVkjG41yfbFcn04w4R2kjvNru6yEevyLYql
	L0QWalNPOCu17ke+5l08d8jgRto1iF/1mC4xoqBaAAIdxgJpAHl+jXDVPO2i8wzzrDHIN0
	mXhzzJVGXNvsZdROmv7jSZrE+R4GGe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780436271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSF02Sys3oVPf3cWJGRWD+ZLq8fEyAUMeudt9t44hp0=;
	b=LvWaNZL33lAkRhyyL80fTL5EWeSVk0ezIztFD6kqOYSfa+FvCYHDzo2ljQiJvY8No3/fyg
	v5GNFqyrx+YbcnBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43128779A7;
	Tue,  2 Jun 2026 21:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id o9UKDS5NH2rCCQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Jun 2026 21:37:50 +0000
Date: Tue, 2 Jun 2026 22:37:48 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <ah9LaPQayJ6tBE53@pedro-suse.lan>
References: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
 <20260602211242.13870-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602211242.13870-1-safinaskar@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6495-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pfalcato@suse.de,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:from_mime,suse.de:email,vger.kernel.org:from_smtp,pedro-suse.lan:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E7D546321E3

On Wed, Jun 03, 2026 at 12:12:42AM +0300, Askar Safin wrote:
> Pedro Falcato <pfalcato@suse.de>:
> > On Sun, May 31, 2026 at 01:01:04AM +0000, Askar Safin wrote:
> > > See recent discussion here:
> > > https://lore.kernel.org/all/20260516182126.530498-1-pfalcato@suse.de/T/#u
> > 
> > So, you took an ongoing discussion with an ongoing RFC patchset, and you
> > decided to reimplement part of the idea on your own, as a concurrent patchset.
> > 
> > Riiiiiight.... I don't think I have to NAK this, do I?
> 
> Okay, possibly this was indeed inappropriate.
> 
> So this time I'm asking explicitly: is it okay to post new patchset?
> 
> I want to post patchset, which will remove pagecache-to-pipe splice.

Well, that's most definitely part of my patch. Also, you cannot outright
remove splice() functionality, it's pretty important (besides people doing
funky pipe business, it can also used for stuff like "take these pages that
we just got on a socket, put them on a pipe and then ship them off to an
actual file" with minimal copying; doing stuff like sendfile() also uses
splice() internally).

So, I guess I'll be sending the v2 soon.

-- 
Pedro

