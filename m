Return-Path: <linux-api+bounces-6497-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CqelGjBcH2o4lAAAu9opvQ
	(envelope-from <linux-api+bounces-6497-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 00:41:52 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D1632820
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 00:41:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kkmq6f9i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e8gJMoYO;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kkmq6f9i;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=e8gJMoYO;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6497-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6497-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22A6A3042907
	for <lists+linux-api@lfdr.de>; Tue,  2 Jun 2026 22:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BA33C13EE;
	Tue,  2 Jun 2026 22:41:46 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1AF3C73DD
	for <linux-api@vger.kernel.org>; Tue,  2 Jun 2026 22:41:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440106; cv=none; b=VYp6RmHHOUMyi/IPdOWhpYwA1/7yOqqeff60I6BOAL24TW5RKfxN5n3aspAS354PeIKNGjF19Lg08enYjsp4Xk3e101prqbB2OCVRs72FRfn9xDNbvKUoQoNhfxqAfUzNIZwNmQNyOJkhZ2U1WE6hrkFhvlTB5UTr/PWxswcmZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440106; c=relaxed/simple;
	bh=sbjnbD6ERB+J0p+IG7/cOkT8z0ehA1CaN9y0MYeGsA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX4J1RfBLujJaf09OsfejCsHX3KxVHA25hAPMcMuCACkj3k/LJVfNDpse4wix7aAY+CCM58PxPIaVZzkdAmBk+MLpK1HaJyqVLW1JzOv2bLKotuNahdQLZvC0NBKg79yHU/f4Tknj+1Md8Ax4B41dyCaUZlyeplsA2/YHWYk0xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kkmq6f9i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e8gJMoYO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kkmq6f9i; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=e8gJMoYO; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 266236A8A7;
	Tue,  2 Jun 2026 22:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780440103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4sAf9CWdWRBvdOC/VGUxmfAjIcDMPecq5z6keRuBsA=;
	b=kkmq6f9ix4swGXyI4aIvlOQLaRMo0MKVHP3WZluLcWY353S0mj+eBxx2i2GLMdV+G2nwUp
	DWhx+D/Vb5I46792pYDwOAqnjBt2cwOwdzUEhtD4QENdlGwfkfHMCpR0lnDXia84H/lgFG
	t9VDMQqZX3R5apQ5/iHUPKzmN7eLI90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780440103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4sAf9CWdWRBvdOC/VGUxmfAjIcDMPecq5z6keRuBsA=;
	b=e8gJMoYOEr/U8OOqmLZ51N4lmMQG8SgKb1tCa5m4kViL8ToOpbb/JNnx+hBTISHjRkglpe
	0Pivw3kxEVYE6kBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780440103; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4sAf9CWdWRBvdOC/VGUxmfAjIcDMPecq5z6keRuBsA=;
	b=kkmq6f9ix4swGXyI4aIvlOQLaRMo0MKVHP3WZluLcWY353S0mj+eBxx2i2GLMdV+G2nwUp
	DWhx+D/Vb5I46792pYDwOAqnjBt2cwOwdzUEhtD4QENdlGwfkfHMCpR0lnDXia84H/lgFG
	t9VDMQqZX3R5apQ5/iHUPKzmN7eLI90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780440103;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z4sAf9CWdWRBvdOC/VGUxmfAjIcDMPecq5z6keRuBsA=;
	b=e8gJMoYOEr/U8OOqmLZ51N4lmMQG8SgKb1tCa5m4kViL8ToOpbb/JNnx+hBTISHjRkglpe
	0Pivw3kxEVYE6kBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8A4C779A7;
	Tue,  2 Jun 2026 22:41:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pw7/MCVcH2o1QwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Jun 2026 22:41:41 +0000
Date: Tue, 2 Jun 2026 23:41:40 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
	Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <ah9Yle5pd6mD9Ugr@pedro-suse.lan>
References: <ahv16ogY8Zx3Rtox@pedro-suse.lan>
 <20260602211242.13870-1-safinaskar@gmail.com>
 <ah9LaPQayJ6tBE53@pedro-suse.lan>
 <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.30
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6497-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_TO(0.00)[linux-foundation.org,gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:dkim,suse.de:from_mime,suse.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D43D1632820

On Tue, Jun 02, 2026 at 03:06:07PM -0700, Linus Torvalds wrote:
> On Tue, 2 Jun 2026 at 14:37, Pedro Falcato <pfalcato@suse.de> wrote:
> >
> > Well, that's most definitely part of my patch. Also, you cannot outright
> > remove splice() functionality
> 
> That isn't what Askar's patch ever did.
> 
> You apparently didn't even read it.
 
Well, I was replying to Askar's new idea to remove pagecache-to-pipe splice,
which is what he suggested. And directly intersects with my sysctl-to-disable-splice
patch.

> Honestly, I think you are the one out of line here.
> 
> Askar did something I suggested years ago, and didn't remove any functionality.
> 
> It just changes vmsplice to be a copying model (one of the directions
> already was). It doesn't change regular splice at all.
> 
> And yes, it has the potential to be a visible behavior difference - if
> some insane user uses vmsplice and then modifies the buffer
> *afterwards*, then that would be semantically different between a
> zero-copy and a normal copy.
> 
> But that would be insane behavior, and was never really reliable
> anyway even with zero-copy (ie subsequent writes to user space buffers
> would potentially do COW breaking based purely on timing and memory
> pressure etc, so anybody who relied on it being visible wasn't goign
> to get it realiably anyway)
> 
> Perhaps more importantly, it has the potential to change performance -
> zero-copy *can* be a performance win, although typically it really
> doesn't tend to be (looking up the page mapping is often slower than
> copying).
> 
> I would expect it to be very clear in trivial benchmarks that aren't
> actually real loads. And probably not visible anywhere else.

Yes, vmsplice() sucks, and we know it. Hopefully no one else will see the
difference. I don't think we can say the same for splice(), though.

> Trying to make it look like Askar is the problem is only making you look worse.

To be clear, I don't think Askar is the (or a) problem. I'm glad he's
contributing, and getting rid of bad kernel interfaces is always nice. I was
just a little frustrated with a parallel splice-related-unscrew patch.

(Askar, if I was too hostile, I do sincerely apologize.)

-- 
Pedro

