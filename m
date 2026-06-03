Return-Path: <linux-api+bounces-6509-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M6OcHRFUIGrM1AAAu9opvQ
	(envelope-from <linux-api+bounces-6509-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 18:19:29 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 750D9639A41
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 18:19:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux-foundation.org header.s=google header.b=Xrz9rfgF;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6509-lists+linux-api=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-api+bounces-6509-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A860031F9D1A
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042543B8945;
	Wed,  3 Jun 2026 15:27:03 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEED3AE1AD
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 15:27:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780500422; cv=none; b=fUobaij4uJg5GPP2Rszkwg4rcphwB8IFICvG7vzq2wf2TzmN/QPogHLeYfgCB90lMKQiJTpJ57RDIkAboRZbQMTpddfUw3i7BGenfvj0SM6C9q5mHxehfhhE2i8GKrWKo6nffsa7KiS0TY78D4lJ0w+Jd/eKBHRfdsMPz4bopS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780500422; c=relaxed/simple;
	bh=5wR6ldRtC07oE2OfAwKn+DBv+oDO9pj5vEPnyj7TnCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0YkDlr2+V5ZgYGBn3uYIc5LwEfWcrVRc0B42kM8sYboCih0mWy1GKR4so1fh5btZFGBoFWC97l7c8w417FFQHQmCsSTmqek9RCdS06MU0yxmo7RPhsz1P2sTqYhKh+KUohdN1ncfw9ZFCIP9sKBnbYOWom2lgeCxm5NFIV6JaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xrz9rfgF; arc=none smtp.client-ip=209.85.218.43
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bed2195323cso556738966b.1
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780500420; x=1781105220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdBrjWRKLAumno5vFkve2ATlSCQiBIWYVQeSXYhWLKg=;
        b=Xrz9rfgFnBH39nBBsI/xPayILE3f+iSp0Zb6KY+/QGopwL9T9dbuXilbvzTpx8ITx+
         5I5lIdP/TYDACfyf0RToVmUXadSx4QMCGSKekLFyd/jorvjjvWFyULINYqmdHFuOYde6
         b5JV6DbKYyyEvbJj7KoEfIrjQuwcb9L933fnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780500420; x=1781105220;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EdBrjWRKLAumno5vFkve2ATlSCQiBIWYVQeSXYhWLKg=;
        b=DvHfSDDbbxgXsz2zh8ishVDzESZ47ukZYU4s3zmZMi/tEQg+DtJzxkiFUM/I1yvVMN
         Zu4coR3RVx3tzY1axnaQyYKPP1niAW+sbnpEKvhTLquE+GHDz6KMVjSU6lJpaluhmIHn
         dn8tAvRkSLbC0KhCpvoUJk4uPS+27/y5Tuy0NPy/7yz6z5L9b7Kjio0vgOgZ+bDzupAM
         F70jP4AAVI0yT83f9MldS6wj18ATNpzG/leNYNxseIC/IisOyZr5Oxld+X69wv2k04Gt
         x4P2g1XExCG/3ThwsO8m0erw8jDKP3/cXL8hiH3I/wmd/dywZ3ZU2ppng16uWqLE/qgF
         Or7w==
X-Forwarded-Encrypted: i=1; AFNElJ/6hqL52NcyxIZxod61MoHQ6huxL1alyowJP2llnBbNsT69qf3L6gNkY0BHkT+opDLvh5HvWTVlgMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaH52wzriSl979ThQ0WA/Hek674YGiB57e1WVllli6aCVpCQzJ
	3QK2ZIVXlm8gLecYHLIQUgFjAS/ijGZw6CYHpvD14yNsYdSVkZw82j6MST3ySzyCtoZP933upgs
	osmMyYiHEHg==
X-Gm-Gg: Acq92OHfd5T8NsFlFKoVMjY9/sWGzogMZNJdQawHP6hG8bPMep8DsqPRSeWmdOONZDe
	plvPYL20mg1EEmdAFJYp5UEkGvH0HoDRHkGfTA6N+CUlEKQMbBn4byyiW8g63OI5PDF/f7U7iO+
	FerDlFBvaS4B6Mip4NcCtHDqy6HUZP19cGJ4REBZWeMBP93eQDkF5v9Hqprp/eU4qMH2rHR0WLX
	z/OgIUxsB4fyP4OyQ9oXdW1jw+GEOft1vfspsifmXFCDfWu5ry8ox1YdDjUaI9BNEnldDmgwPvb
	uoSeE2dLWsYThfDy91MSMq29lfgKVjb+6vJZXnn6wsMM4vxpCyBHl5XU1SSQCN4Xylr8zp1+wTq
	jY5tzUers1qvSUCDlkYYf+51syQgLrfLY3gurp4f9QIn4pq4ZCBEXjrddfKVJEFGw9G9M+Gq+4M
	uGRb1Spj17S7UCfhTEaVGKr5IKco8ilzsQK87pvTmz7xssO9d6x+aUICtYLJE6uxk5Id3ETyUEP
	RzLMnuBxio=
X-Received: by 2002:a17:907:7288:b0:bec:18d5:ddee with SMTP id a640c23a62f3a-bf0ac512c24mr203402266b.4.1780500419220;
        Wed, 03 Jun 2026 08:26:59 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e03716sm174657766b.34.2026.06.03.08.26.58
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 08:26:59 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bec405a6ea5so638983766b.0
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 08:26:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8VdHiYUcKyFw5a5BCiRleBQfKIvvW3uf4sq4xC3PT9uC1tOue9Ig5KnjIAKZeKyGIYjqWWrpCnM7o=@vger.kernel.org
X-Received: by 2002:a17:907:3f0e:b0:bed:19af:f8aa with SMTP id
 a640c23a62f3a-bf0acf0f958mr176902766b.13.1780500418629; Wed, 03 Jun 2026
 08:26:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <20260603-navigieren-pleite-stilvoll-60e6da66b1d4@brauner> <20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner>
In-Reply-To: <20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 3 Jun 2026 08:26:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com>
X-Gm-Features: AVHnY4Kj73Z8AasW6cIfq1Oi-uE8PGC_0Rj2_P-0GPM116OFy2hMKOC9XAw-q3o
Message-ID: <CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, 
	axboe@kernel.dk, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6509-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:luto@amacapital.net,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[amacapital.net,gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid,linux-foundation.org:from_mime,linux-foundation.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 750D9639A41

On Wed, 3 Jun 2026 at 06:40, Christian Brauner <brauner@kernel.org> wrote:
>
> Prior to the change add_to_pipe() returns -EAGAIN the moment the pipe is
> full. So iter_to_pipe stops and returns a partial count capped at pipe
> capacity. For a 128K buffer over a 64K pipe the first call returns 64K,
> the test drains it, call 2 returns the remaining 64K. Done.
>
> After this change do_writev(... flags & SPLICE_F_NONBLOCK ? RWF_NOWAIT :
> 0) then calls pipe_write which does not stop when the pipe fills. It
> blocks until the entire iovec is consumed.
>
> I kinda think we need to preserve similar semantics.

Ack. We definitely do need to keep the old semantics.

Looking at the patch again, I think it's that

    (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0

thing that is broken. I think splice_to_pipe is *always* nowait - but
has the special conditional _initial_ wait.

So I think the RWF_NOWAIT should be unconditional to the do_writev(),
and instead the code should do something like

        ret = wait_for_space(pipe, flags);
        if (!ret) do_writev(...RWF_NOWAIT);

but admittedly I did not think very much about the details, so I might
miss something.

Which also then probably measn that we should just keep the legacy
wrapper in fs/splice.c and we'd just need to make do_writev() and
do_readv() non-static.

Because I'd rather keep wait_for_space() internal to splice (or
alternatively we'd move it to pipe.c, rename it to
"pipe_wait_for_space()", and change the 'flags' argument to be a
boolean to not make it use that splice-specific flags etc).

            Linus

