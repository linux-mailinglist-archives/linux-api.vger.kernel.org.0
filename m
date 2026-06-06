Return-Path: <linux-api+bounces-6574-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n7PqA27lI2on0AEAu9opvQ
	(envelope-from <linux-api+bounces-6574-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sat, 06 Jun 2026 11:16:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E2E64CFAA
	for <lists+linux-api@lfdr.de>; Sat, 06 Jun 2026 11:16:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Ir9xp+Rf;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6574-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6574-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 444073018768
	for <lists+linux-api@lfdr.de>; Sat,  6 Jun 2026 09:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6183148C5;
	Sat,  6 Jun 2026 09:16:26 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C172874E6
	for <linux-api@vger.kernel.org>; Sat,  6 Jun 2026 09:16:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737386; cv=none; b=f1D12WBEY415BPanyt42npECuBSg+OkeM4j0W9z6BsvAxOpzkk/R31SDAy/hDSDm1y+HJlNT9wyR9K9LmzGcbeHAspieRaimQriC0T/kVCELOEjJ7F64gmBUG3BWhkb1Qn0bzWOyZCs10QTbk8yZVJDe4CUTNizVVLyQcXFEL/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737386; c=relaxed/simple;
	bh=CpQdRBzECz1cjWSW+VoW6/cj4i4cip2V9Z6XLkYrqQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHmVkhWxzyXf81NiOkrW9UlnIsGPMlmxB6wuhYdR+i9BTXuV6cmk2HlsKU/DtWj0V/5Ftnl9XZLjQi7nOL0+UC+x65zRBBiZW2Gr6gvzW29nfIEpNHGgkbs8O+rLoo5IUFDLWqw0mh46fJxbqQHJwnChhSo0WtBCMi1mREKuX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ir9xp+Rf; arc=none smtp.client-ip=209.85.128.47
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490b64c8311so30649495e9.3
        for <linux-api@vger.kernel.org>; Sat, 06 Jun 2026 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780737383; x=1781342183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SxOH3sBqh56WyqC7iKaRtAkj2hv0SNo09/WoL7JuhE=;
        b=Ir9xp+RfW7zEfhlmHWN4cKq4EtLbS6jnYjUT+aoOTb4FcEuqF5HOl85ypGKR1nXorh
         Sps2ILrf5DTgYLbvMPtc72+zJ5YzSLcJhI7qiQVRN8au+vPQVPJtO7cqqxDBES9Pq2C3
         zJXYBsd06ojJkLJ2bZRiFV+BIssT9CvlIGPnjE74nfj1gV/Bvo1BfHZL5vPNBaPCI5RE
         GcuTqEqf9pFd+z2tDdK/Dpy5iV0eqG1q6SjyWiWQoleNeVnpMbPU8fnqrAFfGhoCegZc
         S9JvwNEGltkYKAdUu86r+XJK9bR4+ra4xPdJewTmDRDKYaHgcIPpjsAcV8WQ4lPKWg/Q
         KNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780737383; x=1781342183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SxOH3sBqh56WyqC7iKaRtAkj2hv0SNo09/WoL7JuhE=;
        b=LjJMQLfdB56JN7dXVoaQQQfYLqOmrWReTbEg6NgdAU1hQEZURYvFzlleOsN54GC8yK
         JFt1Sj6sk+wb5sAS2Q3riwoZZZz4vYNHp0rtap5nZHIp/fiK3Id8OEVTESNki2RTGf7M
         5tZQt8OuvvRsKaMRBBZZl6q65Gc5FXlqhJ0Rp9xc7PaGa0gklx9QTNjxglLeQiNei0Rg
         Yctrbm3+PBSJKTdDHOcvhA2iT9B+kqbKa2Kkvvo8AqAj689XaswCD0cA8dztO+eaDWUb
         bRJYSQRN0DzrtwzeEAqCMQrr2UxenFXJ/VW8TrPAGXeEi3fLeucMoVORgnHpZOEx8pWS
         hP4Q==
X-Forwarded-Encrypted: i=1; AFNElJ+SLsUoCuV5JWGhSZsfWBZ/H3D4yVpNiX6hbnYLAgV8FXV8/vwNRHrhk4kna9IMSvyM7Nz9thIv3z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiaMEONQvMhoGXG+TCRLmr3tBPf4AWV+bMS2su1C45JpWsdlfn
	bIApr8jJRfxypv7ORYJVYEyWH2CH5zs4YLoPHyCE5U2/9LrtFqHDZsCa
X-Gm-Gg: Acq92OFRtLeA/aatdniJtyjT5KuHdhy5hGi8UNq7pRdHc+VKC8QYsBfyfE5p9LsgZco
	/2oxFbcyoKaqZYrSsJMMAiHU4p17kHRtIK/rfMQHy/nx6tug9aw+fYh6yc1s8BNlilD0o5VNcs7
	VE8YcfuKMPg3L0eRDOWcgVZ1NQAhksf7UVW1uxJHVftQ4w4dBZEQjHYvpWhvYeh+lBpJJ5fba+M
	N+4KqaXJxNWgNtAE6AADpuwjACX9AWHUf35k1gEDBQzHS+LUdMhhFZ2NII9E81P4O3MweNPjt5l
	fqbocXJ6QyG24eN8N65BWQ5uK4cMdUyEp0tyalVIZOnt+9/nuig+pw/pJ1BtnwkABSODy08cgGH
	eHOJs+389ooOj0ZKZ5yZkxkvHy6E5gyjyhlqNg1FXpgCzDM6+JdAnyTeYQ3X28Pmmybqd6w122s
	ONtMU4CPC0o7eDATWFP6cJOfyvzk4hOySsGz90wB5K+qX0mJ3Ajz6BRB7pVFVmN4hdHrJAngA=
X-Received: by 2002:a05:600c:83c3:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490c25a21a9mr135656445e9.9.1780737383320;
        Sat, 06 Jun 2026 02:16:23 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd663sm247272215e9.10.2026.06.06.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 02:16:23 -0700 (PDT)
Date: Sat, 6 Jun 2026 10:16:20 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Florian Weimer <fweimer@redhat.com>, Askar Safin <safinaskar@gmail.com>,
 metze@samba.org, akpm@linux-foundation.org, axboe@kernel.dk,
 brauner@kernel.org, david@kernel.org, dhowells@redhat.com,
 hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org,
 patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 willy@infradead.org
Subject: Re: [PATCH 2/3] vmsplice: make vmsplice a trivial wrapper for
 preadv2/pwritev2
Message-ID: <20260606101620.602ed92d@pumpkin>
In-Reply-To: <CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
References: <f919874c-065e-48be-ac5b-300c4ab86d4e@samba.org>
	<20260603211736.755139-1-safinaskar@gmail.com>
	<20260604100609.6b37f500@pumpkin>
	<CAHk-=wjvb56qo27-axALOKCY-CjLsj9_294zeBovPVJaYm14dA@mail.gmail.com>
	<20260604183829.63c35fd9@pumpkin>
	<CAHk-=wip3mwLOHOYJ9TtjDxOaq9YUXmuCg2AycyASGgeY6qqUw@mail.gmail.com>
	<20260604223216.73468830@pumpkin>
	<CAHk-=wh1Avi8FGbWkt9k0Z-KXWB0spo5mQyowO8PB2sJ3unbkw@mail.gmail.com>
	<87se71jps4.fsf@oldenburg.str.redhat.com>
	<CAHk-=wjkZSAhxykvG6tQM5DnBoS30_XCKkYpCsQwEGcxJb=i3Q@mail.gmail.com>
	<87wlwdhrvr.fsf@oldenburg.str.redhat.com>
	<CAHk-=wiTQr4YYYUH38srGvWAq3_UpDeAPR+qZWVyf-ZU7z8Hzw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6574-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:fweimer@redhat.com,m:safinaskar@gmail.com,m:metze@samba.org,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,samba.org,linux-foundation.org,kernel.dk,kernel.org,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pumpkin:mid,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70E2E64CFAA

On Fri, 5 Jun 2026 10:12:05 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, 5 Jun 2026 at 09:30, Florian Weimer <fweimer@redhat.com> wrote:
> >  
> > > Uhhuh. But that is only specific to 'bool', right?  
> >
> > Also char and short.  
> 
> That sounds like a complete ABI violation as far as I can tell.
> 
> Scary. Because I would not be surprised if we have code that assumes otherwise.
> 
> Now, the kernel *seldom* uses char/short types, and since compilers
> are typically at least self-consistent in those cases and we don't
> interact directly with untrusted sources.

There are plenty of places where char/short are used for function call
parameters/results (and not for single characters or similar).

I'm sure some people (even some who should really know better) think
the smaller type will save space.

I've always worried about whether the calling or called code is responsible
for ensuring the unused bits are zero (or maybe the sign extension of a
signed value).
Clearly the compiler should obey its own rules - so mostly it is just
extra instruction to do the masking.
But for interactions with asm code, and possibly code that gets mixed
between gcc and clang (maybe for out of tree modules) it does matter.

You also don't really want to be doing maths of char/short (and there
are quite a of of those as well). I think it is only m86 and m68k that
actually have 8/16 bits maths instructions (is s390 old enough?)
everywhere else the compiler has to explicitly mask the high bits.

Maybe it is time to 'nuke' all the 'short' locals/parameters/results
(eg from htons()) as well as all the 'long' for values than aren't
dependant on 32/64 bit builds.

-- David


