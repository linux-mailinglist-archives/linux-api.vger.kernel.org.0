Return-Path: <linux-api+bounces-5799-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJPgCraig2kLqQMAu9opvQ
	(envelope-from <linux-api+bounces-5799-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:49:10 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BE6EC39E
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0C0E13010785
	for <lists+linux-api@lfdr.de>; Wed,  4 Feb 2026 19:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FCA3D7D9D;
	Wed,  4 Feb 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnHVWCsR"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736E34D38A
	for <linux-api@vger.kernel.org>; Wed,  4 Feb 2026 19:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234535; cv=pass; b=ZaxDfI6YGAU7KjRVtXjvfv6GO3SVxCsZIucZHdzBCsgAlYrcAPZUrCHF+BjiCnP4KErqauaCZ6VtazLqi0MlM6Kly+oal6vau8rk6QjMT0GYyuz7bH42Yp5+3Yg80DktJOWXCBxsDWmJQQ9RbRgjmFghgBnPvi4YK6rSv+Ef6KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234535; c=relaxed/simple;
	bh=bSIrMjvVryS3QuF3cPDJgDoly4qpEwj7FUTfJRKsTHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5YtRnT0v9KfWjI8RTvtt14ijsItqJCXWbl9WTd9INDzuGz+UgdJhpdX2PfHYfx/XxvNmPNvnOAmuuogzgkj+RaE6AoS5ATgJY3mRQuwQ+1S3a6nuQNfl8d+g5wr9dc9QJYXb8AeVXTia4nDVeJ+xB3IuoVltypyXtUyhWadxLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TnHVWCsR; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34f2a0c4574so62111a91.1
        for <linux-api@vger.kernel.org>; Wed, 04 Feb 2026 11:48:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234535; cv=none;
        d=google.com; s=arc-20240605;
        b=Sip4QdVZuTBIasClCoU8W+K52iyQ3Eo/OSqTpXjlqYuGwKcfnTjU9NUGj3b7urxVn4
         XvEF+qnuMWVMpWz/cz5Qvl6O5YnjEoviNXvfFge3rpl12q3dKeJHDmIWFTP9n2fdxaWq
         w7lOZQpMSPW/JrcY4ymNaR3ovJiTjCir0bQkbiTXiT9d6YXL4e7h6uVHT5krAc3r027H
         n2g18fDsSp0rDGn9Fh9p0uu5BoxmiiCyQmpInX7KdRpS8g477+nNML3DzHwME0VzcuNU
         /kxmEsD/EhSuXvug1PLXUb3YZNyefkD32xGlkobFmu6bBxfAWP7/wM+hVpKpzdNBz/Lj
         bwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MhxIQ4idA8yZgMj8bntXp33AUjuSpj6i0GkwuCvW47c=;
        fh=ywY371ZaYMpaq3W8LgKec8J3W0flujHp+u4nMwxtr7Y=;
        b=hyW8Yl1F4NfWxNA4Tbb9t2lPAQvZn4HvRSnIrRZStCbS+zZmGBkfjWL6PSZYNK2ICq
         /A/dz3cqa/pha9A73rnlrWAOjdtu6U4a+k6Rpwrvx2jt7A44nbkpIUReKvdzX92TBfEW
         zRGr5e71K5zDec20EtaGuUwdlytoVupw+xLBaqLf1aJ0Qbhw37sMm1dLBClN8AiG8OqX
         7J0NLdpq54emubOE3lpLgv/8iShfrb6FIfmbfRTtzC10Fja6GD0xQI3SF+aR8fNrXbwW
         iWtAhRCPDN73NwAJlDMMxyyO39STyXASolW6KYHUtF4usILGJBGvWhwYes0H3Za8a67Q
         CPnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234535; x=1770839335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MhxIQ4idA8yZgMj8bntXp33AUjuSpj6i0GkwuCvW47c=;
        b=TnHVWCsRX5CuO4JStAQwX9v1LRMLvYS4IZ0izbBLMbh08SU0RpvFQ30w4lAnaiS04H
         gpWmHtyvk2ZSPTKJV5k0FWbOZwbL2aEWRWMWRrdKbJw/WvtVMxunDgQ184sqPyeVAfqF
         NpYlL41FpyFwtnFq2HIADB7oYkA0iLNEBEbNmgNEm9II6NH0nMSMzOuXy0ifosmoUoQs
         0OZAaCKfD4F/XY1dTLgGtoP7nlZtjnEYjsJEkNDlpHB37DAK8Hok+zdZK+CX4DVNWWNw
         zkNXLw/VLiHk3i+Qx6Ysd1raLdeR1kQr6eQ0D0C+zwoqm/i48nQ3hYou1Px5f63qdrnx
         bWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234535; x=1770839335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MhxIQ4idA8yZgMj8bntXp33AUjuSpj6i0GkwuCvW47c=;
        b=PUeZBx3Y8AkgoO6dvX55ndpWhlATA4xplqm2qJ6/6ui6vDl1K4SR50vOajhVcvnKZR
         CLBn/E9kxSmPs3d//cgHU8lLqrCSd3A+A0/vzWFVIpBAp11OlJpfSJzXdu2kojs/omve
         Yw+wyuXQqXIKbFY73J8N3Nwr8nF0iA/3j8o+4g+OfyhD4iu30rxTrjI7B/7aEh0B26S6
         OOJDrY1esdere8oBTBzHw8v3nFnPd/OXi/ICk0bsgD1DdIQTE3A/Ei8fHLz0r2kaGrgS
         qJ1VrZF6L/VH6NeovJPyz4Z5o3uZwHSrNC/86HXUhjyCZeLxRXa68NGeevF7oUDNk2+B
         vy5g==
X-Forwarded-Encrypted: i=1; AJvYcCXjmQ2w+Pm4xkbX3gN9DtOWH4CgDRAgO78KmHJL4cZjLaxFCSerqFlFTCIhnFEzsNyYFj9xX5mEPS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9jCf1uujWKugLxV/Z0bqZyWHiG6bPJcCYI+jZ/Kd89tSll+NE
	zauxsSs1IsYfBp+2v2519FG5ZQ47aqhPM6mMDdwZHOih9a7R38QPiCCRg+i27mDu7svAHZhH2WX
	nGbJJtOWcdd8gj8vw/OQOzqF6GaZdJNc=
X-Gm-Gg: AZuq6aKnEERoECNYJTDztUJs5fkI1VsPmrGGbT8f+UswsJyvEGRFDvvusBfZvEcwZE0
	fajAYv0xnADiQhvBI9IFe3mF+p0rRnugq3e44mYR6Gb9JpGZZxUkv1Is+HRsz9U0IifO5jRzK3O
	SpZIckEcTDQXgb9S7tE5c5NC14aO3aev0nDFVROjCAYDbZYDaceK6YUS169SWMPUE/1Yf9mJ3NW
	tjnljggN2/EkZhPbzqeYXdRWk0zklguxG02NgXAWtxTDR2TSSRDjm4H35UpKx4ClHypOR8D80tT
	KmIgmHvsvq4=
X-Received: by 2002:a17:90b:3f45:b0:340:a1a8:eb87 with SMTP id
 98e67ed59e1d1-354871f13dfmr3876158a91.35.1770234535011; Wed, 04 Feb 2026
 11:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-3-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:39 -0800
X-Gm-Features: AZwV_QidYTjvoEYC0f1oARTkbpeV2p90PM7rVpmH2nsmMkKOPAJuwbUzYyRsbSk
Message-ID: <CAEf4BzZ7Sa2dAUyw5kjaLiwtr7q4_H97uTpb2bsbqFuiy153fg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 2/9] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5799-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C5BE6EC39E
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:41=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> To support the extended BPF syscall introduced in the previous commit,
> introduce the following internal APIs:
>
> * 'sys_bpf_ext()'
> * 'sys_bpf_ext_fd()'
>   They wrap the raw 'syscall()' interface to support passing extended
>   attributes.
> * 'probe_sys_bpf_ext()'
>   Check whether current kernel supports the BPF syscall common attributes=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 36 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/features.c        |  8 ++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  3 files changed, 47 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

