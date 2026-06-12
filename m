Return-Path: <linux-api+bounces-6609-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nls7K7RVLGpQPgQAu9opvQ
	(envelope-from <linux-api+bounces-6609-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2026 20:53:40 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE80E67BDEB
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2026 20:53:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XughLwb+;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6609-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6609-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31E43003BD2
	for <lists+linux-api@lfdr.de>; Fri, 12 Jun 2026 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5E5377039;
	Fri, 12 Jun 2026 18:53:35 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C01F875A
	for <linux-api@vger.kernel.org>; Fri, 12 Jun 2026 18:53:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781290415; cv=none; b=u6WK9KKp9KUiOJodgVhrMmT7KUPEFBCROR7F6s5cqBd44M+24hv4bqDLaByTigcD9TBZRTP/1rHhfpMlmU9xdlupTGWRzxu77N8Ekx3a9f0Hw+H86mMjB39gAW0gWorJBf5BwCRy1UP3ZxnCXP9WttNK6r7ocqUNyqEb9g3IkZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781290415; c=relaxed/simple;
	bh=EnU1mmSugKyvT3f45kASsQfDqSHL4+wuMjzLJSGRqlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WzBmX/JEDgmn8yDNAilBkey12eXviX0z4WB1xURcr6K0ExGQk7JL0X6xGqKlz+hTvee7D0OjQjG8Y+cZWlGGBRZ+sJkBVELOTl6kll3Usdso7SIYDzFaLlwkq3jgvQUV0+3aWICNxjKoTutWSAPxc26XENPdjziczpQzIbp6f24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XughLwb+; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-45eedcdaeaaso892857f8f.3
        for <linux-api@vger.kernel.org>; Fri, 12 Jun 2026 11:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781290412; x=1781895212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CB3wwilAFNqCSPIrYprWyBx0bbSlAUAXEXzKdqsS5I8=;
        b=XughLwb+sdbkRB7dhKh6x7WdR64/e8/m8+XqSoHgSWMo23uU7Di1Q57AvXRip0lgU/
         wVIkTjt8QtTCVBFx88FxweI8zRP18oCs6NbORpI995WKWQPdz9NkJAdStiryYqpviQrR
         xV3DzYrUlzakmGRURGwBlPg83lbTJhlH4PgKmqiysJw/Nq2/iyRtkbPYyBWLdPDNtqFG
         HE7dg5NDkRtrcQL7I73l/nSdf626HyGWGJOZMyMPxR5RsVX9CTwYIFUfRdTbJqZH6Sw0
         nfrGxjcHXsViRABP0N7Z7piVP9H9jU98NwyitduTN5QXXaUNDM8rX1TH/Pyi7J8c7m0w
         Aaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781290412; x=1781895212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CB3wwilAFNqCSPIrYprWyBx0bbSlAUAXEXzKdqsS5I8=;
        b=sbtYLSmHbNnsaOc2F7EGVpi+l/JT1swpZmkWLI3M3APnxuhWlzy5PU0ikclrDbOoYw
         6nUND4uemRKtaqyBZWW7Xli8pT+GOYQ3dU81AMUX1bi4dloFfA4/NexNWX4jFOURrpQx
         NYwMrs09BCzP8UJ9IIO2GpwOTbEdHJAjeZiezYZIiom2lOyq4bU2P6usRwmW7DJ7qkv1
         JVlrULBPj04VpbKS1+g6Q6e9F/nhd25YLa7Yl5LBZ/O3FvCIOp9xNpTIg63MUwXFqoWp
         62Jnep8b3BZqABMBrX/JQPYT8CqvX8sOGcEECMJlxkWy1qpuhVjEvoAFj2jloR4LECFP
         ZLDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LJeMsZNS/d9h9hlvmMUWpZFrvLfCIn3/a5LAeOYUSjKbg3zMihppYFx/41oE2bZtQGs31KdEyAkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyam4ofvf67NQspqHIJhbEyR3Y4e2lASiXYQzqFcvxDi0IX7imL
	oB6ptrBVoVBC18uQOWHGWqXv+7Zg3DMDSkBi1hMsG1oxyVKEPTSaCYuO
X-Gm-Gg: Acq92OETetr0srLVD39JcEewVsmBBnklpvIwevHFw5ygKCmxt1BkrnUKinVY1btjZxr
	AoxPSYexp0bRBOoyrpKsV6DMtwHKrL4j90Ni/6t8TjHhYcwijOhZwK2UwnuB/87+Y1AIaWjKP3V
	GkLzpeM7Ss6yZfesGDgybOd782ygF5nQoiqS1pBmF04R1J5EvzV3xxOO6EeJ2Bqb8KFM4kJ4O99
	mMZXo79UAEO3ensfptv7MHuApRQHCh5jfPDdggfAFAAnFzv/y8gbbec5XbBN2CGnFIrm8FMNvYL
	8QOkbPcQXqFja+gj6KMteCyncIsuoFq2rz0l7aSO4Xyn7I1p8SAbLYLCmBK5qubgFDUwLniR93D
	NXfUpRd/4XZD2L8RxLuM1ucjWpPi0IT7Dk8/GzcDZuGJlrV9Us096XT8HtgUyrdbZwIxjHA3Naa
	F99nBC+nq5Rnm1NCYWWnFKNDx5aJfjXwF+to/0Frg8tlhKO1Y5uV7m7Zpg54sP
X-Received: by 2002:a05:6000:4312:b0:460:70ae:f1a2 with SMTP id ffacd0b85a97d-46070aef2b6mr5433215f8f.17.1781290411899;
        Fri, 12 Jun 2026 11:53:31 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f20e77asm8584369f8f.0.2026.06.12.11.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:53:31 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:53:30 +0100
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
Subject: Re: [PATCH v3 3/7] treewide: Replace memcpy(..., current->comm)
 with copy_task_comm()
Message-ID: <20260612195330.1653d041@pumpkin>
In-Reply-To: <20260612-tonyk-long_name-v3-3-7989b66e8a99@igalia.com>
References: <20260612-tonyk-long_name-v3-0-7989b66e8a99@igalia.com>
	<20260612-tonyk-long_name-v3-3-7989b66e8a99@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6609-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrealmeid@igalia.com,m:peterz@infradead.org,m:juri.lelli@redhat.com,m:vincent.guittot@linaro.org,m:rostedt@goodmis.org,m:brauner@kernel.org,m:kees@kernel.org,m:shuah@kernel.org,m:willy@infradead.org,m:mathieu.desnoyers@efficios.com,m:torvalds@linux-foundation.org,m:akpm@linux-foundation.org,m:laoar.shao@gmail.com,m:andrii.nakryiko@gmail.com,m:arnaldo.melo@gmail.com,m:pmladek@suse.com,m:linux-kernel@vger.kernel.org,m:kernel-dev@igalia.com,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:laoarshao@gmail.com,m:andriinakryiko@gmail.com,m:arnaldomelo@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE80E67BDEB

On Fri, 12 Jun 2026 13:20:16 -0300
Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:

> In order to increase the size of current->comm[] and to avoid breaking any
> existing code, replace memcpy() with copy_task_comm(). This new function
> makes sure that the copy is NUL terminated. This is crucial given that the
> source buffer might be larger than the destination buffer and could
> truncate the NUL character out of it.

Aren't you re-inventing get_task_comm() that the previous patch removed?

...
> +/*
> + * Copy task name to a buffer. Final result is always a NUL-terminated s=
tring.
> + */
> +#define copy_task_comm(dst, tsk, len)						\
> +{										\
> +	const char *_src =3D (tsk)->comm;						\
> +	size_t _dst_len =3D len + __must_be_array(dst),

If you are using __must_be_array() then why not use sizeof to get the _dst_=
len?

> +                     _src_len =3D sizeof(_src);	\

Isn't sizeof(_src) just the size of a pointer?
You need to use sizeof (tsk)->comm

> +	char *_dst =3D dst;							\
> +										\
> +	if (_dst_len <=3D _src_len) {						\
> +		memcpy(_dst, _src, _dst_len);					\
> +		dst[_dst_len - 1] =3D '\0';					\

If the lengths are equal you don't need to write the '\0'.
(and they should really both be compile time constants.)

> +	} else {								\
> +		strscpy_pad(_dst, _src, _dst_len);				\
> +	}									\

If you do the memcpy() the bytes after the first '\0' aren't guaranteed to
be '\0' - then can be random (usually part of an old version of the task na=
me).

So I'm not sure the strscpy_pad() path is needed.
The most you might want to do is memset() the extra bytes.
But are there ever any????

There will be code that copies the task->comm to a short buffer, but are
there any places where it actually gets copied to a longer one - if so why?

	David

