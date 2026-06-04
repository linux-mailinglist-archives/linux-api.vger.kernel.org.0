Return-Path: <linux-api+bounces-6536-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DnV0EFujIWrEKQEAu9opvQ
	(envelope-from <linux-api+bounces-6536-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 18:10:03 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3025D641B60
	for <lists+linux-api@lfdr.de>; Thu, 04 Jun 2026 18:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=1wt.eu header.s=mail header.b=aaJG32qR;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6536-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6536-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=1wt.eu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA5DE300B297
	for <lists+linux-api@lfdr.de>; Thu,  4 Jun 2026 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B32D39DBE0;
	Thu,  4 Jun 2026 15:53:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188E7397E8B;
	Thu,  4 Jun 2026 15:53:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588422; cv=none; b=XLxEvbaxhQJXxqDQfkPGXmQ7+R6vb2mGZGXAVP7DeSwgbv4NSsh4MnVR6x+DgTwgo65EltTBXUjtZslwiQtgrWkbNWymjInkTTx0NKhBcbrhE5AI4LimTReoR1REyR4XE/D7O4tvToouv00ltGLk246Lokrwkw4rIfKxqdlGtRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588422; c=relaxed/simple;
	bh=qus+D5rLRk/7MKk5teLiNXO3sJG3ntMUblD9VoM4MYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lph+Axw0PppB2d1vzIt/UfKM/KsCNyGcYjYzLeu1WmqNHH2AQ+xz6VToAefxmA2Sg5KtqdQ2RvGGuOM5VM3nLpoiO9IcYeYxAIdQhPSn4f8ECLxZq+9+zytPU0y/KWxJSWIcN1kwUj79UcHyLQ8/N96KrHJ70C3RPIKfh3XKi8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=aaJG32qR; arc=none smtp.client-ip=51.159.59.229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1780588418; bh=juT3AhUSnv3+LEExiQBNIpyMhKj+7Ht6/Ub5bBjOybo=;
	h=From:Message-ID:From;
	b=aaJG32qRMUOIDg915/7kh3rDdW4vh2IvOB/PNr31yOeigP7OiDM0YHIhZoiZp8UMr
	 NjXu6O405jBSx5uIwefKURTQZonCG1DnK7RxtvWKkjkUveM2Rqq1sV+8PrM60xISZy
	 s80aAPevr1LZI2sSO5N94ajr5iCOo4kiSDrTDoDw=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 4A2D1C0ABE;
	Thu, 04 Jun 2026 17:53:38 +0200 (CEST)
Date: Thu, 4 Jun 2026 17:53:37 +0200
From: Willy Tarreau <w@1wt.eu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, netdev@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
        Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <aiGfgRch99l_5z11@1wt.eu>
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV>
 <20260601160455.2c187574@gandalf.local.home>
 <20260601172825.a51a588ec1c32617a0e12d78@linux-foundation.org>
 <aiEb8CTM-ovMIq7-@1wt.eu>
 <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiQB-j53cTs9kM4UeXoXPaFj78aJe3D6Yp1Fohg7i4tWA@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[1wt.eu,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[1wt.eu:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6536-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:rostedt@goodmis.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[w@1wt.eu,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,goodmis.org,zeniv.linux.org.uk,kernel.org,gmail.com,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,suse.de,szeredi.hu,lists.linux.dev,suse.cz];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[w@1wt.eu,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[1wt.eu:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,1wt.eu:mid,1wt.eu:dkim,1wt.eu:from_mime,1wt.eu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3025D641B60

On Thu, Jun 04, 2026 at 07:31:30AM -0700, Linus Torvalds wrote:
> On Wed, 3 Jun 2026 at 23:32, Willy Tarreau <w@1wt.eu> wrote:
> >
> > I'm using vmsplice() + tee() + splice() in high-performance applications,
> > load generators to be precise, and soon a cache. This is super convenient
> > and extremely efficient:
> >
> >   - vmsplice() is used to prepare a "master" pipe with data to be sent
> >     over TCP or kTLS
> >   - then for each request, we do tee() from this master pipe to per-request
> >     pipes.
> >   - the per-request pipes are those that are used to deliver the data to
> >     the socket via splice().
> 
> So most of those would actually not be affected by any of the existing
> patches: the pipe->socket splice would remain, the tee() code would
> still just take a ref to the page count.

OK!

> The vmsplice() would change,

OK but for this use case it's not dramatic (it could be more annyoing
for the cache where I'd like this zero-copy from memory to the wire
though).

> but looking at your haterm.c sources, it
> looks like it's mostly a fairly small thing ("common_response[]" being
> 16kB).

In this one it's indeed a 16kB block that is repeated into the
same pipe by simplicity, in its ancestor it was 64kB. We try to
make as large a pipe as we can, but that's all.

> That is typically *faster* to just copy than look up pages.
> 
> HOWEVER.
> 
> It looks like you're actually doing exactly the thing that I thought
> was crazy and wouldn't even work reliably: you change the
> common_response[] contents dynamically *after* the vmsplice, and
> depend on the fact that changing it in user space changes the buffer
> in the pipe too.

No no, it's definitely not doing that (or it's a bug, but it's not
supposed to happen). I'm perfectly aware that one must definitely not
do that, and it's a guarantee the user of vmsplice() must provide.

> So that would break *entirely* with the vmsplice() changes if I read
> the code right (which I might not do) simply because that looks like
> it really does require that "wrutably shared buffer after the fact".

We agree that this would deliver complete garbage an I'm not interested
in such a "feature" at all.

> Interesting.  Because the vmsplice() code uses get_user_pages_fast(),
> and honestly, it never pinned the page reliably to the original source
> - it breaks COW randomly in one direction or the other after fork()

I must confess I never knew how it deals with pages shared over a
fork(), and have been wondering if two processes could create a
shared memory area on the fly just by using vmsplice() on each side
and end up with the same pages (I don't need this but it could have
very nice use cases).

> (and I thouht even after a page-out, but thinking more about it the
> swap cache may have made it work for that case).
> 
> Uhhuh. That does look like it makes the vmsplice() changes untenable.

No no don't worry, I'm not seeing any value in changing data after
vmsplice() and that would just be a bug. My goal here is only to
pre-fill a buffer with a pattern then prepare the pipe with that
pattern, nothing less, nothing more.

> But I may be reading your haproxy code entirely wrong.

I think so, but I wouldn't be the one blaming you for this ;-)

Thanks for the clarifications!
Willy

