Return-Path: <linux-api+bounces-6350-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGWTGMRcC2ppGAUAu9opvQ
	(envelope-from <linux-api+bounces-6350-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 20:39:00 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F05725FF
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 20:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A1B71300608B
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805C638655E;
	Mon, 18 May 2026 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT7WobiW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292138AC85
	for <linux-api@vger.kernel.org>; Mon, 18 May 2026 18:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779129531; cv=none; b=nIw/pd8KNJOxge0EqhrTSxTw36FeK+VuVvsTkoUtajwUWJ086NrXQ2lZ+3mC4pPLdo/cl154hyHLgizJorWlDem6n/am9u+sq/s7CFeQfAZCNCcIHzxi88TfkvTFCAR+NuORyuJvmSN8ZKwLAJXj9uGW9GxIUUVfMnRgUkQ2pMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779129531; c=relaxed/simple;
	bh=IwA2YanYwRN8XyQecT4CfF6plWT3UXIXj2n+n0QmXOM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skTgkdn1MbsBjtK55fibI6UOtsP52qsytVW85xDXNyyBVTpmdbvFtXlGhfRHflsMH1+6I/LrufuyjTOMnlElnOblfaDt8lKZ+4dKxlwx+sVWud+mbj2Wnhw4B9P1Bpf3tvM0T6o/FGL7frQvxZ65odcdlx0lwsG8OxCHb0uMPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IT7WobiW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44e5624c053so1571025f8f.2
        for <linux-api@vger.kernel.org>; Mon, 18 May 2026 11:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779129526; x=1779734326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOt/t70tyLkQtU4DfTJKh7Bvg0l44HHd46RsE6w5vr0=;
        b=IT7WobiWu5iOv4wHgoqdS9LdESfPyb2jcKtPbOn0Hm6ksJfEt2QHLyusmORw3X1wtX
         cnZ6EFEfNQJpY//5XKJpd5f4cpEgQpHpBXNONF5zi8AnKzGUurJzxWtI0xXd2w/Rb0Ai
         6PILiVypN1gD7bQmfugmS7g21eiUvfBt0R6JnPGvOgb1tZUrhpeZtHwhFP1WzEkLULu4
         neoD4gBpLe+xTrfoNDnlo09/jPiY1sRBACuxjbMWbJ9FObfk6eWEpHhOxg4TTC2WXiGZ
         J7KLmSj7BlDcEqNaCxjO6kmVH4KN3co/VlSxLraPoiF7Q6lAHFWL4thzROmd1fXolHY+
         /rqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779129526; x=1779734326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MOt/t70tyLkQtU4DfTJKh7Bvg0l44HHd46RsE6w5vr0=;
        b=fTigJbGRCX83qYnTvJwZoeUEHr+V1w6BTr7BlfhmAAyhMssYhL3eyxTZ+ZQPP+g9cx
         kGeu6YzFJOJX9GSzSxGwkiZTdE92R2lNMg4YUnEmvIse5ZvNWK5YY4UjWrgRX89/8XRX
         TpOcT9spy+yOVDURw+3xumh7HXeKXD6Ymm+vA0OPNuZ0QDH6uzLmPJ1Ek/RP98leUsXC
         W0FN7EUs4aKBd1MG1T6aM0Loz0HnFYlv1ovhKDURjQ72WHsUmtPdDobF0HIYCmbRz4ox
         Xvtcpt9pm8zHNjnpkPZN2fkPzN5vUp64pEz0j/bhJ6dX31KAIIbh0vOmX5/sbvtC0JfG
         xfFQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PfLmqNmTRJ2EISXiG7/+Xaa+fnPJJi+E4texsAmF71V9kv4Zf1W+lpYdVurBh1p7NUijA3dauzTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW7GHxe8a28mle3H/wmEnR/bwUgnrHeXE4yk/6O1VjcjPf1sjN
	FFO1fHCanXcKS+wZR1boVqVaQOH73JLDRbLb6wS7AQ/Fz8riESI3qhwi
X-Gm-Gg: Acq92OG0fpUfHhqJexieK2lMbOUSbywUV8wnXKQAEmZgVM5VwxJpZR1bl97KRY9M/KO
	WAmPFwJHh+hE1drw48fiuD62ORFiwBQUxjnXnDFwkMM82IrTUV8pF2thAs8aNZgNLa8pg2flBwP
	MFW5Ek1OHMtYJd0zm6dTjzxy5T1Mx+8J567fE2aCuZVlpaMPquaJsVA9vcW1k4lU+78Pv9ESjyR
	uz3EjsSchHWJ8zy6EK4ceUUgLufBAS1ynBHsLJVuQE+EnVDVrloIIegnGPi9e3PEJWASpkjdfae
	JB3QxVSf0zpeqV4jMOC8S0tgcrNytvCn2E+dC21FalU1CFZCIUFzR4lkZdyCa3z7+R8FwEUyUx1
	ZSUrETUBukqHls+h+tixxCn86sWtZtSQxBxeLok25j4/hDMAbBR+cZgUzIm96SrOHlhTfsjjXO/
	sgLt6zi20h5vQklzFqRpE10E/53rTvAVeHKHycZ/cGeXnRhIj3zj5CiWY2lli9uVv7
X-Received: by 2002:a05:6000:2305:b0:44f:d9f8:c0e7 with SMTP id ffacd0b85a97d-45e5c58fe85mr27071250f8f.5.1779129525728;
        Mon, 18 May 2026 11:38:45 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9e768072sm38782922f8f.5.2026.05.18.11.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:38:45 -0700 (PDT)
Date: Mon, 18 May 2026 19:38:43 +0100
From: David Laight <david.laight.linux@gmail.com>
To: =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <kees@kernel.org>, Shuah Khan
 <shuah@kernel.org>, willy@infradead.org, mathieu.desnoyers@efficios.com,
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com,
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org,
 linux-api@vger.kernel.org
Subject: Re: [PATCH 3/6] string: Introduce strtostr() for safe and
 performance string copies
Message-ID: <20260518193843.7bde8d53@pumpkin>
In-Reply-To: <d4d6cf61-568e-478e-88d6-01b769d7eded@igalia.com>
References: <20260517-tonyk-long_name-v1-0-3c282eaa91e2@igalia.com>
	<20260517-tonyk-long_name-v1-3-3c282eaa91e2@igalia.com>
	<20260517223419.3262de7c@pumpkin>
	<d4d6cf61-568e-478e-88d6-01b769d7eded@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6350-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,godbolt.org:url]
X-Rspamd-Queue-Id: 203F05725FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 18 May 2026 11:36:49 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Hi David, thanks for the feedback!
>=20
> Em 17/05/2026 18:34, David Laight escreveu:
> > On Sun, 17 May 2026 15:36:13 -0300
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> >  =20
> >> Some parts of the kernel uses memcpy() instead of strscpy() because th=
ey
> >> are performance sensitive and doesn't care about the return value of
> >> strscpy(). One such common case is to copy current->comm to a different
> >> buffer.
> >>
> >> As the command name is guaranteed to be NUL-terminated in the range of
> >> TASK_COMM_LEN, this is safe enough and doesn't create unterminated
> >> strings. However, in order to expand the size of current->comm, this
> >> expectation will be broken and those memcpy() could create such strings
> >> without trailing NUL byte.
> >>
> >> In order to support a fast and safe string copy, create strtostr(), to=
 copy
> >> a NUL-terminated string to a new string buffer. If the destination buf=
fer
> >> is bigger than the source, no pad is applied, but the string is
> >> NUL-terminated. If the destination buffer is smaller, the string is
> >> truncated. The last byte of the destination is always set to NUL for s=
afety.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >> ---
> [...]>> +/**
> >> + * strtostr - Copy NUL-terminanted string to NUL-terminate string
> >> + *
> >> + * @dest: Pointer of destination string
> >> + * @src: Pointer to NUL-terminates string
> >> + *
> >> + * This is a replacement for strcpy() where the caller doesn't care a=
bout the
> >> + * return value and if the string is going to be truncated, albeit it=
 needs
> >> + * to mark sure that it will be NUL-terminated. Intended for performa=
nce
> >> + * sensitive cases, such as tracing. =20
> >=20
> > If you care about performance, and the destination isn't smaller (espec=
ially
> > if the sizes are the same) then just use memcpy().
> >    =20
>=20
> The problem is that as I'm expanding current->comm, the source buffer=20
> might be bigger than destination, and when we truncate the string, it=20
> won't have the termination NUL byte. So we need an extra dest[len-1] =3D=
=20
> \0 after the memcpy.

It depends on other access to the destination.
If it might be being concurrently read it is vital that it is always
terminated.
So you can't even temporarily have a non-zero byte at the end.

>=20
> >> + *
> >> + * If the destination is bigger than the source, no padding happens. =
It it's
> >> + * smaller the strings gets truncated.
> >> + *
> >> + * Both arguments needs to be arrays with lengths discoverable by the=
 compiler.
> >> + */
> >> +#define strtostr(dest, src)	do {					\
> >> +	const size_t _dest_len =3D __must_be_cstr(dest) +			\
> >> +				 ARRAY_SIZE(dest);			\
> >> +	const size_t _src_len =3D __must_be_cstr(src) +			\
> >> +				__builtin_object_size(src, 1);		\
> >> +									\
> >> +	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
> >> +		     _dest_len =3D=3D (size_t)-1);				\
> >> +	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
> >> +	dest[_dest_len - 1] =3D '\0';						\
> >> +} while (0) =20
> >=20
> > That doesn't work (for all sorts of reasons).
> > _dest_len can be the size of a pointer - no array check.
> > You need to use __is_array() and sizeof () for both dest and src.
> > You might have meant to check that _src_len is constant, not _dest_len.
> > You must not leave the destination unterminated.
> >=20
> > __builtin_object_size(x->y,1) is also entirely useless!
> > If you have a pointer to a structure that ends in an array then the
> > object size of that array is SIZE_MAX (as if the array continues past
> > the end of the structure).
> > See https://godbolt.org/z/csenjfvxe (which I happened to prepare earlie=
r today).
> >=20
> > __builtin_object_size(x->y,0) also seems to always return SIZE_MAX.
> > You do get a sane answer for (x->y,3) on recent clang - but nowhere els=
e.
> >  =20
>=20
> Oops, you are right, thanks for pointing that out. This is how it would=20
> look like checking that both args are arrays and using sizeof to get=20
> their length, if it sounds good I can apply for the v2:
>=20
> #define strtostr(dest, src)	do {				\
> 	const size_t _dest_len =3D __must_be_array(dest) +	\
> 				 sizeof(dest);			\
> 	const size_t _src_len =3D __must_be_array(src) +		\
> 				sizeof(src);			\
> 								\
> 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||	\
> 		     _dest_len =3D=3D (size_t)-1);			\

That test can never fail.

> 	memcpy(dest, src, min(_src_len, _dest_len)));		\
> 	dest[_dest_len - 1] =3D '\0';				\

You are expending 'dest' twice.
Where it (p++)->array then the two values would be different and the final
value of 'p' incorrect.
Much better to assign both pointers to local variables.
Here you can use their required types to get type checking (I wouldn't both=
er
about the extra checks that _must_be_cstr() does).

I'd also create function that is explicitly for copying process names.
(Or replace the one that is already there - saves a lot of churn.)
then you know (and can check) the sizes are the expected ones.

It might even be worth making the #define (needed to get the array sizes)
call out to different functions for the different cases.

Thinks more...
On 64bit the 16 byte copy can be 'load; store; load; mask; store' provided
the buffer is aligned (copying u64 on 32bit will work the same).
But that requires that all the buffers be aligned.
So you'd need to check _Alignof(dest) >=3D _Alignof(u64) as well.
(Probably with a fallback to get things to compile.)

Whether that is best for the longer 64 byte copy is anybodies guess.

I also suspect it would be best to zero fill when copying a 16 byte
name into a 64 byte buffer.
(If you zero fill first then you can just copy 16 bytes over.)

-- David

> } while (0)
>=20
>=20
> > -- David
> >=20
> >  =20
>=20


