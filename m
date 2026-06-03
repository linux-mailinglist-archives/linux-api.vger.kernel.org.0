Return-Path: <linux-api+bounces-6510-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oiJZCBZuIGpd3QAAu9opvQ
	(envelope-from <linux-api+bounces-6510-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 20:10:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B30E63A6A9
	for <lists+linux-api@lfdr.de>; Wed, 03 Jun 2026 20:10:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=Ycii7cT0;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6510-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6510-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EC86E3008E1A
	for <lists+linux-api@lfdr.de>; Wed,  3 Jun 2026 18:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B651384CD6;
	Wed,  3 Jun 2026 18:10:25 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763D38BF9C
	for <linux-api@vger.kernel.org>; Wed,  3 Jun 2026 18:10:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510225; cv=pass; b=H9XmS1O/ujvJvRIV4U9VtKfWxcSjzdDbSKEEMN+7Sro5uAnZT742CF51xYk4RTaMPFHMCB31HAXUGgPimp/TwiMqqFC7l107N9tFuYKWnZvNDox5UNMfZIwcjXyEE9Ap9gP3BmVvRhES2jlY7GCg+1w1fKreHGUfa6fwk+QQmXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510225; c=relaxed/simple;
	bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmBEbdEGE/LyUF15/wbsEtENVKTV78MKdFmKWE5/4CCscvNoitqpL+GXIxn3XYIFc2PIQqMJyUQgZRXTMO5Ru+HVcwbIRk5Fr/DDiwOD2S0b6p6MkIzAHl+q5zDZKEhlHa71HwGH/WRi78caMc7n10Js79FHQkJIPwNwbMozaFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Ycii7cT0; arc=pass smtp.client-ip=209.85.167.45
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa61e3d3f3so4524207e87.0
        for <linux-api@vger.kernel.org>; Wed, 03 Jun 2026 11:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780510220; cv=none;
        d=google.com; s=arc-20240605;
        b=L9wxd2Re8AmIeHA8D6x7iIjphP6Ur+oXjIsQcbA1UhY0hX4bGEp+uCPGHEu3jsIftD
         fu2Lsch6HYV19ikJ3kLIyxxr4a0L99E2Gw1UWnFAls/NFRHlX50dJAgIovrhQX2reMnm
         TRkzVPyuwusJSpvVdQ4qNJMnRjkx3M7tHcmWWhDMCyCmkyVYUdUwGHV1R5EL/c9gaiA0
         nEivZ/jdesRz4nP+5QKquQgL4pAVLXqnMJWgGZKmdOep51Qoy2u2VNLu+tCEpgwT/aJC
         U6V3BEihdyD/nDVrTzIvYdKCl5pZobtk2yk0gytee87x50tMa/WvJqB+E8xVZPqaSb6s
         bWbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
        fh=AxPcVzxtJ5MbLHVqssUlNWFlpiMkFAfWQYnT/Kzm34Q=;
        b=VfDarpz/VTukg+wZ5P85BDagyHrfekkQG7oJZJTyH9eZPGzR7FkHgYxfBl6NfxC/jd
         NN7x6wnnezJQwmQHmbmw52oW7LLqjX0PI1Ly5LRJj+zycQVJutGFPuKNB6F0nCdBmIXC
         ZyjeN9OAxTvrTla/G0h68ng0AyT/93oZGxylE28PDJBKqjdLmstBOA9uIt3/wKa1iavC
         vacg7my3JEdOr/NvxRKDYfAboxZ6dbEaY6eRcDwOl/RNa6dJtW+5VET18fEd8DriQZpY
         W3PEOyfDKkTHAIfb7SJCaGzaBykx3d1pBXubO01dzGQ7EsCf2LsE5ZZ0DPL94ZzsdLH3
         8Udg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780510220; x=1781115020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
        b=Ycii7cT0JXbZoT1HegxGgvqaSMKThW4bkvG6TukTUJa8mzOrUCAQZbykUj6hte7pHj
         V5Tpr7d5OOSZ1Xvg/Tb/VCzN3xB1zWnN0XRM5eav+EI12K7sidrRvdKt/muCEahtB5pt
         +FG5pFvtxbd7AdNGJby6pbXRb8ot3BuqBAhZPKLoBILX87RO8EtOO74dehQUXMLayloW
         brJyPG8l0TFxADH6C4EkozCNfKLInRFAAgVV5TesPbAhUryU0++NrA59NPahO4rDy200
         StpKVms/jc6L2u/Rozww7BNqylkR1Uz25oTiAEd2X6TD38LTPETCHMt927slju0MYu0l
         i7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510220; x=1781115020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
        b=A+FRMcmiNEV2QMCZ9CiAl8hG+x156dRZN9+2ZUe+a/FSK8TgYYI5fmnNagvUE/zzfx
         ti09lBXLq+0goeSyL2+Q7adUMjBY60adHKWrNmjhuYXxzDv1mshQvYLoDhSwpqDRGuu2
         c25Gee9rIpNlKKRVKvBF6e8E4ls+cThoXnxK1AN/4bxK3XUDMGN7+9QYPVI5yU6wstnE
         YgycNgmHuI03SbGQQTGocS/gRyyrwDJHqwRdd9shw78BpK/d2zWb+m0TEWUwaVwiymXw
         +Z8uAzzkkvmCtEBmgQDZVxaItekuHSy6Q7yLktZnVQP3LuZ1fK6a47lDShtzyYI9+c6D
         1Ylg==
X-Forwarded-Encrypted: i=1; AFNElJ9gkWalw2RWNC6FJaTqWF7R79Cx+XUtuz42O/yTTBfgTg3sfUIMs9PjnBt3W1PU5e0i8lI3xvFfRZk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7aJo4YOOIp27PsAv2bXYOcZzWt3Fc5ON/SFcut+BMHQlCebS
	zFk28h3mKF/O3xOqs5LGRUzt2KLKrAkpXojWsiuABXMmGaei9IbjvKViygHnTfwMYc4dauf78u6
	ira0JRq9HdPf4P4KucbouSWF5CagZgt9LwhZ1nusY
X-Gm-Gg: Acq92OE5dPnT+psKp90xBj1lhe89k8dTkMnWNPFglJeoWiiaL47tPHZfIhdwbX1kc4J
	aq2hCLjCRYQVk4cOo28oz6NWm53nlQNDqCx8GSPP/6XDx24Wu4r7GuTzkqDzzJ/hpmGXHfA7lCP
	6yvl33xYiOm6YtLbSJpmYpWreJrP6Kum0RdUREfmEH/sr6wQ6uHEtB3UO6Z156SqI724bhvC6An
	FBOCUJQLqSCPfvN21q9aKeHdOHEPhduL5LEbV2zPG/kBWckr1f5502qL5B8ZxjQodmDgoYtIHZ6
	O0YvKhN/Lc8LojQfNhk=
X-Received: by 2002:a05:6512:1316:b0:5aa:6917:da62 with SMTP id
 2adb3069b0e04-5aa7c0feb48mr1695669e87.22.1780510220289; Wed, 03 Jun 2026
 11:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com> <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
In-Reply-To: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 11:10:07 -0700
X-Gm-Features: AVHnY4I8xlGMoYvHWadfAyp7JPxqtCaCokQuJfO8Z8xN2WDEFYt6TSKYy0-h7os
Message-ID: <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6510-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B30E63A6A9

> On Jun 2, 2026, at 9:20=E2=80=AFPM, Linus Torvalds <torvalds@linux-founda=
tion.org> wrote:
>
> =EF=BB=BFOn Tue, 2 Jun 2026 at 20:51, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>>
>> Am I understanding correctly that this will completely break zerocopy
>> sendfile?
>
> Very much, yes.
>
> And it's worth making it very very clear that ABSOLUTELY NONE of the
> recent big security bugs were in splice.
>
> They were all in the networking and crypto code that just didn't deal
> with shared data correctly.
>
> So in that sense, it's a bit sad to discuss castrating splice.
>
> But it's probably still the right thing to at least try.
>
> I've seen very impressive benchmark numbers over the years, but
> they've often smelled more like benchmarketing than actual real work.
>
> There's also a real possibility that a lot of the sendfile / splice
> advantage has little to do with zero-copy, and more to do with the
> cost of mapping and maintaining buffers in user space.
>
> If you are sending file data using plain reads and writes, it's not
> just the "copy from user space to socket data structures".
>
> There's also the cost of populating user space in the first place:
> page faults for mmap made *that* historical copy avoidance basically a
> fairy tale.
>
> And not using mmap means that you have the cost of double caching in
> the kernel _and_ user space etc.
>
> So sendfile() as a concept (whether you use combinations of splice()
> system calls or the sendfile system call itsefl) isn't necessarily
> only about the zero-copy, it's really also about avoiding the user
> space memory management.

So maybe we should make sure that, if we go down the route of
disabling all the splice magic, that we leave an API, maybe the
existing sendfile or maybe something else, that does an optimized copy
from one fd to another and that is at least capable of sending from a
file to the network with at most one CPU-side copy.

Even if we=E2=80=99re just doing that, I continue to find it strange that w=
e
require that a pipe be involved. What=E2=80=99s so special about pipes that=
 we
allow splicing from file to pipe and then pipe to socket (this
requiring that the pipe retain a reference to the file=E2=80=99s page cache
structures to avoid *two* copies), but we can=E2=80=99t splice straight fro=
m
file to socket. Heck, even sendfile is implemented under the hood as a
pair of splices!

