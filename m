Return-Path: <linux-api+bounces-6363-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJHGKNWFDWo8ygUAu9opvQ
	(envelope-from <linux-api+bounces-6363-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2026 11:58:45 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD07C58B377
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2026 11:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 771A1300148B
	for <lists+linux-api@lfdr.de>; Wed, 20 May 2026 09:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81DE3D170E;
	Wed, 20 May 2026 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkbLfZpU"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE93D16F9
	for <linux-api@vger.kernel.org>; Wed, 20 May 2026 09:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779270820; cv=none; b=q47bAMxuxGJz/zhtIkjS1dHj11ZTy2gJ1GXEVEnKLgVTYi0xGDufuD++NqzUdyJk8kcHJ9VWTa+VeY+piu9HgC0x6J8P58Wb5J/rqXrQuFdxNjYZnmsVVNAu3JAataq3kGu7v5IAHnCpm81ChsCHB2me6dkz2z65XhYUtxhoxpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779270820; c=relaxed/simple;
	bh=puwkhZDm861AvWUlAH9JiXA9DMy67Y7J2D2J6BRnHbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJCXbxa/wePQstO77lTYNrSCq7g15tb+eoslFQAMSoE+GWIkirLIOhGz1qPEOcJt6k0ajbma76rWzwVVjeWFTrutCEJW+TI3JoZwyq/EByKesN6yTcC9gsUuCKYj7+Vmo+//xbI0hGrFlWV7kwol9yP+b5JE8Esd+tIhnxY58nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkbLfZpU; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so2735278f8f.2
        for <linux-api@vger.kernel.org>; Wed, 20 May 2026 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779270817; x=1779875617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ebYrN+Cy1jpS7On8dq1CN3DpE7snkr/MnVsVyf9e2g=;
        b=FkbLfZpU4o+Lc7k1qcE4HifYzNABddpp2vwKjN+tsbfhFEuFe/osJHvYRPMlp5ICQ5
         6b8ac03ZsUBd1yQ17b0KzsOU03Niz3jDyHuCTcvpMHk6tzWAGH7kdY/JaaSUMt/PqIWG
         0jOX3ARaMh3YpnB/CTX7nZAF43EXtPhYSe+WpshbB/Y4o//xVymBssuRrBzNiN2t+6zb
         672v4PkKo1WdnPqY/SdaFMV8KRvhnLi8pS1jULooFwWqaXzOHWv/z1MMsxa8fIUjrFvl
         mBDUBUu09PnQ+e/CdBOQtMmtfuvoVKvDje7LRBR3nI9MA9f2wvWbp3NPrQaXxrP+3f5g
         4/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779270817; x=1779875617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ebYrN+Cy1jpS7On8dq1CN3DpE7snkr/MnVsVyf9e2g=;
        b=BA/1kPjROHydaoXld66qVQ4fpy4xNSs/dvnkKVNkCCjLnaLznxYia+SsRbI9vqSwwb
         sUV7UuU5jULtU89w9xXWu6RYEhG/iTdrUReWJJHNJ/YFQLg9NEqOy1oBlYZf81GNTfzl
         7S1TPmjkmdjIlYk0qZKpGjc0qdTfL/CWkWlyJEJ3iXOLtpjiBMQ1XmntzNN1hJfCIy/n
         MriT7rlSMA/vyqpYPhQQQIh2u3KFo98L8BxJvNPYH5DpohsoQyx1GGXiAzdesqH23KD4
         r64onUrNfayyuCN9atvvfF9tIFF2tWyJkxMh9iaOKfU10HWe8i198POf4KT2wnd6TTa8
         2cTA==
X-Forwarded-Encrypted: i=1; AFNElJ8iwe7MaBoSx/H/XvGNVYxhrBu+TLklKKd5Ll2W3p9+Rp5T6bN95xMD8vjlcB7Lz/3sbO8S3EJZuOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5vgBm5yQNaj1FTAstpTbfu1m66vyaksuOwv+RUsfxBF5AULf
	YYxTahBCW6gNdbDU+VWye49JquSbDUQmnY/2x+Bs18xjtVlyUIoQXD7S
X-Gm-Gg: Acq92OEBfBHI5IfOPl+YucmxGm+tesYfNzoY19NPcF7/Vf0JobQLuN9yJUzACIdRw9S
	xCDk4ECQCDsi9TepJWLvNi9NIY3gpC2xvUOgZIgaXsdp8iDbxlaR4PlS7hmBuqLJSzFnoC601K5
	MeOvOIAetPXh+wwOiPtoWNQ0onGjKgC0z0LfxAs8HS6H1p9i320XG14R4HkD+1addOGxHSvg2/o
	HWwrjfXCymywLQSw6qkuwVrp5ANrWaXj05+3IrCuXw00Vf7dNyeqJRDdDeu9HFCmDFV/oKGpSQg
	V3eEtNCzqIMAxHZHLy5lpByuT7z2ATa6RjY8ozQqvEFvp8OtMhla/h3SUfcYkBRpnKmSVa87aju
	NvRL8spMRaSQhKaOv7HKRE60g8RKMyZJnonkxg83XA+ECml70Ucfs9we+gh9dEpK++q73uTuX7F
	UvsejjH1FZRy2h87Z+eIW8xclqVoQxraCyrcNA1zMlWKEBwQ9QN84TgrGu899lN6NoHNaTFt9bh
	nc=
X-Received: by 2002:a05:6000:186c:b0:44a:aa3c:5927 with SMTP id ffacd0b85a97d-45e5c5957b9mr38170692f8f.29.1779270817325;
        Wed, 20 May 2026 02:53:37 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe0fecsm48645755f8f.26.2026.05.20.02.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 02:53:36 -0700 (PDT)
Date: Wed, 20 May 2026 10:53:35 +0100
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
Message-ID: <20260520105335.1970fc23@pumpkin>
In-Reply-To: <471b5b42-974c-441a-9afb-13e1baba5c44@igalia.com>
References: <20260517-tonyk-long_name-v1-0-3c282eaa91e2@igalia.com>
	<20260517-tonyk-long_name-v1-3-3c282eaa91e2@igalia.com>
	<20260517223419.3262de7c@pumpkin>
	<d4d6cf61-568e-478e-88d6-01b769d7eded@igalia.com>
	<20260518193843.7bde8d53@pumpkin>
	<471b5b42-974c-441a-9afb-13e1baba5c44@igalia.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6363-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:email]
X-Rspamd-Queue-Id: BD07C58B377
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 16:47:05 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> Em 18/05/2026 15:38, David Laight escreveu:
> > On Mon, 18 May 2026 11:36:49 -0300
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> >  =20
> >> Hi David, thanks for the feedback!
> >>
> >> Em 17/05/2026 18:34, David Laight escreveu: =20
> >>> On Sun, 17 May 2026 15:36:13 -0300
> >>> Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> >>>     =20
> >>>> Some parts of the kernel uses memcpy() instead of strscpy() because =
they
> >>>> are performance sensitive and doesn't care about the return value of
> >>>> strscpy(). One such common case is to copy current->comm to a differ=
ent
> >>>> buffer.
> >>>>
> >>>> As the command name is guaranteed to be NUL-terminated in the range =
of
> >>>> TASK_COMM_LEN, this is safe enough and doesn't create unterminated
> >>>> strings. However, in order to expand the size of current->comm, this
> >>>> expectation will be broken and those memcpy() could create such stri=
ngs
> >>>> without trailing NUL byte.
> >>>>
> >>>> In order to support a fast and safe string copy, create strtostr(), =
to copy
> >>>> a NUL-terminated string to a new string buffer. If the destination b=
uffer
> >>>> is bigger than the source, no pad is applied, but the string is
> >>>> NUL-terminated. If the destination buffer is smaller, the string is
> >>>> truncated. The last byte of the destination is always set to NUL for=
 safety.
> >>>>
> >>>> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> >>>> ---
> >> [...]>> +/**
> >>>> + * strtostr - Copy NUL-terminanted string to NUL-terminate string
> >>>> + *
> >>>> + * @dest: Pointer of destination string
> >>>> + * @src: Pointer to NUL-terminates string
> >>>> + *
> >>>> + * This is a replacement for strcpy() where the caller doesn't care=
 about the
> >>>> + * return value and if the string is going to be truncated, albeit =
it needs
> >>>> + * to mark sure that it will be NUL-terminated. Intended for perfor=
mance
> >>>> + * sensitive cases, such as tracing. =20
> >>>
> >>> If you care about performance, and the destination isn't smaller (esp=
ecially
> >>> if the sizes are the same) then just use memcpy().
> >>>       =20
> >>
> >> The problem is that as I'm expanding current->comm, the source buffer
> >> might be bigger than destination, and when we truncate the string, it
> >> won't have the termination NUL byte. So we need an extra dest[len-1] =
=3D
> >> \0 after the memcpy. =20
> >=20
> > It depends on other access to the destination.
> > If it might be being concurrently read it is vital that it is always
> > terminated.
> > So you can't even temporarily have a non-zero byte at the end.
> >  =20
>=20
> I don't think this is the case here, as far as I can tell all the=20
> callers of strtostr will wait the end of the copy before using it.

It's not the callers, it is other threads.
The comm[] string in the process structure can be read write it is being
updated.
It doesn't matter if the reader gets a mix of the old and new strings,
but it must see the terminating '\0'.

...
> > I'd also create function that is explicitly for copying process names.
> > (Or replace the one that is already there - saves a lot of churn.)
> > then you know (and can check) the sizes are the expected ones.
> >  =20
>=20
> I don't have strong feeling about get_task_comm(), but Linus said that=20
> "I'd rather aim to get rid of get_task_comm() entirely"[1] so for me=20
> it's fine to get a new function for that.
>=20
> [1]=20
> https://lore.kernel.org/all/CAHk-=3Dwi5c=3D_-FBGo_88CowJd_F-Gi6Ud9d=3DTAL=
m65ReN7YjrMw@mail.gmail.com/
>=20

You could probably justify a rewritten get_task_comm() without all the bagg=
age.

It might end up being a wrapper for strscpy_pad() or some other (to be writ=
ten
function).
Maybe the body gets get extracted out later for other uses...

The advantage of a wrapper is that you can change the implementation
without having to change all the call sites.

Another (untested) wrapper:
#define copy_task_com(dst, src) do { \
	size_t _dst_len =3D sizeof(dst) + __must_be_array(dst); \
	size_t _src_len =3D sizeof(src); \
	const char *src =3D _src; \
	char *_dst =3D dst; \
\
	if (__is_array(src) && _src_len <=3D _dst_len) { \
		memcpy(_dst, _src, _src_len) \
	}else if (_Alignof(dst) < _Alignof(u64) || _Alignof(src) < _Alignof(u64) |=
| \
			!__is_array(src) || _dst_len !=3D 16 || _src_len < 16) { \
		strscpy_pad(_dst, _src, _dst_len); \
	} else { \
		((u64 *)_dst)[0] =3D ((u64 *)src)[0]; \
		((u64 *)_dst)[1] =3D ((u64 *)src)[1] & ~le64toh(0xff); \
	} \
} while (0);

Although (annoyingly) neither _Alignof() nor alignof() gives the value you =
want.
I don't think you can fix the alignment of a structure member.

-- David


> > It might even be worth making the #define (needed to get the array size=
s)
> > call out to different functions for the different cases.
> >=20
> > Thinks more...
> > On 64bit the 16 byte copy can be 'load; store; load; mask; store' provi=
ded
> > the buffer is aligned (copying u64 on 32bit will work the same).
> > But that requires that all the buffers be aligned.
> > So you'd need to check _Alignof(dest) >=3D _Alignof(u64) as well.
> > (Probably with a fallback to get things to compile.)
> >=20
> > Whether that is best for the longer 64 byte copy is anybodies guess.
> >=20
> > I also suspect it would be best to zero fill when copying a 16 byte
> > name into a 64 byte buffer.
> > (If you zero fill first then you can just copy 16 bytes over.)
> >=20
> > -- David
> >  =20
> >> } while (0)
> >>
> >> =20
> >>> -- David
> >>>
> >>>     =20
> >> =20
> >  =20
>=20
>=20


