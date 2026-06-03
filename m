Return-Path: <linux-api+bounces-6507-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id G68NOa8TIGomvgAAu9opvQ
	(envelope-from <linux-api+bounces-6507-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 13:44:47 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767E6372EF
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 13:44:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e9TruHKb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L+5Da9hO;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=e9TruHKb;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L+5Da9hO;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6507-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-api+bounces-6507-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A384301D96C
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E904657F3;
	Wed,  3 Jun 2026 11:44:01 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF644BC87
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 11:43:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780487041; cv=none; b=SzMEukpe+acE2AjsF/KdyHfoFQRx9TnW0YQhnF1nXTuppEjy5kWsWHDW4HQ4IfAr/gE/1jOc6LOUIJSa0NYyYL3N33zWvqg4BVzPZU/kqoNw6PvJpCXmwjBrclh4X5xNMdw9tThSnJWZbrAblQ8d+bPklChB+J94lBlpg9/GZV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780487041; c=relaxed/simple;
	bh=cB5IzueyNAgldHyPvG5KG9AuTk1cmqYL6BsojGI83KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acI/TraWpV+GasguaIjSGoUeaX4WL+yRs64FwUJA7baF+4uSFkmCMSW9KwFMu+78WHdlqX9ibYdoW0EDQBYME5en+i2hAbf+w96cviUglN1t5c+KvOttJ0ZYX7d/Yi7B0lpV+nDTIHvVLkIfDMVsdZdDTkhwvHACCtootTH2S3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e9TruHKb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L+5Da9hO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=e9TruHKb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L+5Da9hO; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8A7067559;
	Wed,  3 Jun 2026 11:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780487037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0eCuaAhCxqMdNJLOaVe8WqPBMsrJRRf6/0fkCn++oY=;
	b=e9TruHKba2Aw8j5znNs7wuEBN6ABAIt9lPHHNKWc10ifZhfTD8lU+Amkj6FyF3IwnwqsOn
	ZJSB/bau0jk/KeED2ljIJWWGmrp4+0ZNlP/gz4LWSh0lEAZqj2+Lm+WHhG7wDQUsUCBo76
	tZ2EMza79/ZhFb4kLqIaWpmw8RG6E6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780487037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0eCuaAhCxqMdNJLOaVe8WqPBMsrJRRf6/0fkCn++oY=;
	b=L+5Da9hOM6Rn3I3fgd338xAE9ha2lU5C4Va8OfuLmzgu2gRs0ZCE33NMTcTqxRbWVALAl9
	NTF3zlbpIv+RVfCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780487037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0eCuaAhCxqMdNJLOaVe8WqPBMsrJRRf6/0fkCn++oY=;
	b=e9TruHKba2Aw8j5znNs7wuEBN6ABAIt9lPHHNKWc10ifZhfTD8lU+Amkj6FyF3IwnwqsOn
	ZJSB/bau0jk/KeED2ljIJWWGmrp4+0ZNlP/gz4LWSh0lEAZqj2+Lm+WHhG7wDQUsUCBo76
	tZ2EMza79/ZhFb4kLqIaWpmw8RG6E6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780487037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0eCuaAhCxqMdNJLOaVe8WqPBMsrJRRf6/0fkCn++oY=;
	b=L+5Da9hOM6Rn3I3fgd338xAE9ha2lU5C4Va8OfuLmzgu2gRs0ZCE33NMTcTqxRbWVALAl9
	NTF3zlbpIv+RVfCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84DC4779A7;
	Wed,  3 Jun 2026 11:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GOpGHXwTIGqNXAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 03 Jun 2026 11:43:56 +0000
Date: Wed, 3 Jun 2026 12:43:54 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, viro@zeniv.linux.org.uk, willy@infradead.org
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <aiAREqlHK1llOw_y@pedro-suse.lan>
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com>
 <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6507-lists,linux-api=lfdr.de];
	FREEMAIL_CC(0.00)[linux-foundation.org,gmail.com,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,zeniv.linux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pfalcato@suse.de,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:luto@amacapital.net,m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:from_mime,suse.de:dkim,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5767E6372EF

On Tue, Jun 02, 2026 at 08:51:03PM -0700, Andy Lutomirski wrote:
> On Tue, Jun 2, 2026 at 5:12 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 2 Jun 2026 at 15:54, Askar Safin <safinaskar@gmail.com> wrote:
> > >
> > > Pedro is talking here not about this vmsplice patch, but about
> > > my future hypothetical patch, which will remove splice-pagecache-to-pipe.
> >
> > That absolutely would be my suggested next step.
> >
> > Something like the attached - get rid of filemap_splice_read()
> > entirely, and just replace it with copy_splice_read().
> 
> Am I understanding correctly that this will completely break zerocopy
> sendfile?  sendfile is, internally, splice-to-a-secret-per-task-pipe
> and then splice to the socket.  How much to people care?  These days,
> a lot of high-bandwidth network senders are sending encrypted data,
> which is not zerocopy frompagecache.  But there are surely some users

You can do zerocopy from the page cache, even with TLS on top, by having
your (fancy) NIC do TLS offloading for you. See https://people.freebsd.org/~gallatin/talks/euro2019-ktls.pdf.
Linux works similarly. Slide 26 is particularly interesting.
(No KTLS I assume is using simple sendmsg()'s from user memory, SW TLS
and NIC KTLS are both sendfile(), per the slides)

TL;DR I really do think it matters.

> 
> Now maybe someone cares about a different path?  Splice from socket to
> pipe to file?  Splice from socket to pipe to other socket?  Does
> anyone do any of this?  One can, of course, recv() directly to an
> mmapped file, but then you pay for page faults, so that probably a bad
> idea in most cases.  At least all of these cases don't have spliced
> buffers that refer to a potentially read-only file.
> 
> 
> But I'm a little concerned that zerocopy sends from files to network
> are actually important.
> 
> --Andy

-- 
Pedro

