Return-Path: <linux-api+bounces-5645-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B31D29773
	for <lists+linux-api@lfdr.de>; Fri, 16 Jan 2026 01:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 356653049088
	for <lists+linux-api@lfdr.de>; Fri, 16 Jan 2026 00:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380CB311C2E;
	Fri, 16 Jan 2026 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwgZtkyD"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF672405E1
	for <linux-api@vger.kernel.org>; Fri, 16 Jan 2026 00:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524879; cv=pass; b=rN3tx25BvGk6Fo81BRDt9IkQ11yfndl8cqzOd2bQE8PGW18sI0OsGErGGdHk/odw0762sC+SfpcOY7ndR7lnd5DDhXvuif6B+aaoTgGt1JwsYCO+CNMb+0ARNZADc+XiC+ifb5pUuL6lVuGT9hTUHhBU1aFLf8slGB4ZweDkM/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524879; c=relaxed/simple;
	bh=oeS3pd4PScIcoH3d4d6z3CMgUN6iKFWAVcj4dEp5IQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aEmf7JWi6aMf4zmKcqBM9AbdsldXZxy/CNpgcvDoeEhf7TXtYOrK0mavXxVZvsTrrzaA5LvstkLMUuO9ZJXiRM/E7L9x2MJw6JxiVDvgBhZQi+C0M35PPPemNVQabFERkrwC8Ufx1hQ4136qcYdx/5sKXq/2kOJe1Ajbi3sTn/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwgZtkyD; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso737695a91.3
        for <linux-api@vger.kernel.org>; Thu, 15 Jan 2026 16:54:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768524875; cv=none;
        d=google.com; s=arc-20240605;
        b=iBbB/z0HdBiaq+eiThC43n0EKdwahrz2a75hphH3JdgvmVAw3BWRyL383a7RW73q1D
         n2nXruy+2pe+hwOZ7RQlq9Pa7QSu0IYxjgSwGaBvJFeIICUAj9jiwvXg2QsKmDqIfmmO
         if7I9rQwRFY+6J19A+zp0z2hFUKnpjcslqNN2CeKSkcjxGqvjJDkvFORJv2a2ZOy/0zw
         8ROfTRVveoBAAm7tTSyYgpvEIoenUYS5PnSadOgzY5QkE2Haj6yrTtmb7m6ngfap38iZ
         FblUYdbsfnMj2MGTG6VdvCj++i5Kwaiy1xFwiuGYxSnLeBqEaw5lOwFEC1dZdPFUqZOV
         UERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nay0t5T4cL2oSExOSHeUkpJWbolMH7qmguyCKsNgb3Q=;
        fh=x/jGHXhupBYZBYG7oWVva5f3c1v6dLrpaV0lEx73OMk=;
        b=T5/MoT+uTMJwugO4krallh0Xq8FtvdzoavdYq5GbAJYQVCt+SxOqsYjrSDJLewDyLo
         mOFc+KcNepR34G1snuSxAm62weidQdQsmM2wz1jb2nnD2y1/33ErHp/139uImS1o0B59
         7qhPXibVbiSuSMa39JgP2ZGm1zQUT+IWVVocxlblYMWub0dopeFz/Ald1ajqrEG3CMel
         /4c8CEyFlymcYzzEEWH42RTi4ElhpTB++Bb5h11FdqlLk8OLu2ML7DO0virIlQfqVEFk
         BAXkY1zgi0KNRbi6oLrmLDuf1W0+VRhgeLcAi0FJ0ISHXexTOh/oZ0ltncVkhJ9VgIaJ
         4kdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768524875; x=1769129675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nay0t5T4cL2oSExOSHeUkpJWbolMH7qmguyCKsNgb3Q=;
        b=SwgZtkyD0QFNe+nEPMmNykduOXAWDAKWMNufsbs65SIKsG+3+qL9065BH38eBWCkyz
         qPJq+JTDv02pcTC0XdtAqNfQ8BrYXM9rj+fAk/JYwLrB+JIdAfQc4r/nVdcYJlzdh6qP
         bcNagU+Km7CmgHMuKABTqNPnY0WTthvm1XZj46mLDcUcwJzalW4L+jICfF8ULZrOIM62
         9PRPXFHNGhbzG98H2QYSfLAcNegZQyN2vfivslGP//lyjtr7qdrfCQAqL8LqeJZUaCbS
         7/O8nS3TtcC1BuZRzptVcfPi0hOEHXJ/x5J2WrHPQoUFpc5YnubMPUB4tkJ4GK/UrUiz
         ci4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524875; x=1769129675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nay0t5T4cL2oSExOSHeUkpJWbolMH7qmguyCKsNgb3Q=;
        b=JGyr1pUahiR20ZrG6pzqn2AQ3Q3qMAL3QKZkp4IxwKAo+q0cCSgaD4RQyuZ2u5jMQw
         SuQtDxlBYh+M6im1JOVp/bFQdHlhyxOAyZufxXEEIQICL2eKtyDHzjgDURHo9OxDmZv/
         WDnY6pEE3rAVyTATHQV/j9wKP4kgDOLNyJ7yJrV76iaZB19XUstyf+Ky7uj5jg6TAuel
         7Patayt5+LFB6oLXHSFu2nZIqV2me46u9ic1l3eQ7mwiGG/JAFscnT6VQJryiah57vrj
         V4rhSTPVUZNW+7Z9LigBucp34ZYyJYUPgQfTDeEVrcPIA78UgTW2p63+r6AEEyqiLG2y
         G00A==
X-Forwarded-Encrypted: i=1; AJvYcCVPo2HCucTNnrBnVHpbhApPiP59qw5AnPRKTPEveWlBjWAFQUJy6UydwVm8AUtfsMan0ZXt0yoXvqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8pgg5/MryyMqd1piOy3QUnqVWZAiL/xrBSacBCZ5SpJV6beY
	Da/ShdIEk11jQh6GV4K/izRQmebZ8pv1uLrp//ztjeD/lI+IzpHd4tMec0ctq5BxFHgPvmm0g6C
	ecKmyeQd+EZcKG6jYL4XlLKaVNPk8TmQ=
X-Gm-Gg: AY/fxX4KwZqmffN4Inj/FuZEG+mhYVz+zNRd7jQ42F4uvjQzPA/GxSbDORGuXV2Py1a
	ah5L/gGauE3ktHpou+86N7elV+uIbYYP9JXbiIeGQeuL9eF61GIFCC5l1fd33yDm+TI1lL7MbFS
	9qfxUmLAiQX/1qAGHcPHYx7HbaPCh0fp6KVvlXB9Gx49IFy8ElhnZoqHrABJSatnN5KrSOf52Ol
	ObMiphx6UI8EoMqFiQlli5qNMuMD135OZdip3kptIPVu1DIPCCkayEnr8dM19CpB5Qexe0Mp9pW
	MN5b+7Vh
X-Received: by 2002:a17:90b:2f45:b0:34e:5516:3fe3 with SMTP id
 98e67ed59e1d1-35272ee1c8bmr989693a91.11.1768524874635; Thu, 15 Jan 2026
 16:54:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-5-leon.hwang@linux.dev>
In-Reply-To: <20260112145616.44195-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 16:54:21 -0800
X-Gm-Features: AZwV_QgEDyBTV1rBmwgvFCqTetxY1gptMuOZxPzb9k8dRkyCkG_1Ej0bF21H380
Message-ID: <CAEf4BzZbcA2T8+OR1_68sxq9Chukmh8beyz+018O22U=SsafrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Add syscall common attributes
 support for prog_load
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

On Mon, Jan 12, 2026 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> The log buffer of common attributes would be confusing with the one in
> 'union bpf_attr' for BPF_PROG_LOAD.
>
> In order to clarify the usage of these two log buffers, they both can be
> used for logging if:
>
> * They are same, including 'log_buf', 'log_level' and 'log_size'.
> * One of them is missing, then another one will be used for logging.
>
> If they both have 'log_buf' but they are not same totally, return -EUSERS=
.

why use this special error code that we don't seem to use in BPF
subsystem at all? What's wrong with -EINVAL. This shouldn't be an easy
mistake to do, tbh.

>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  4 +++-
>  kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
>  kernel/bpf/syscall.c         |  9 ++++++---
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4c9632c40059..da2d37ca60e7 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -637,9 +637,11 @@ struct bpf_log_attr {
>         u32 log_level;
>         struct bpf_attrs *attrs;
>         u32 offsetof_log_true_size;
> +       struct bpf_attrs *attrs_common;
>  };
>
> -int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bp=
f_attrs *attrs);
> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct bp=
f_attrs *attrs,
> +                               struct bpf_attrs *attrs_common);
>  int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_veri=
fier_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 457b724c4176..eba60a13e244 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *env,=
 const struct bpf_verifier_st
>  }
>
>  static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bpf_a=
ttrs *attrs, u64 log_buf,
> -                            u32 log_size, u32 log_level, int offsetof_lo=
g_true_size)
> +                            u32 log_size, u32 log_level, int offsetof_lo=
g_true_size,
> +                            struct bpf_attrs *attrs_common)
>  {
> +       const struct bpf_common_attr *common_attr =3D attrs_common ? attr=
s_common->attr : NULL;
> +

There is something to be said about naming choices here :) it's easy
to get lost in attrs_common being actually bpf_attrs, which contains
attr field, which is actually of bpf_common_attr type... It's a bit
disorienting. :)

>         memset(log_attr, 0, sizeof(*log_attr));
>         log_attr->log_buf =3D log_buf;
>         log_attr->log_size =3D log_size;
>         log_attr->log_level =3D log_level;
>         log_attr->attrs =3D attrs;
>         log_attr->offsetof_log_true_size =3D offsetof_log_true_size;
> +       log_attr->attrs_common =3D attrs_common;
> +
> +       if (log_buf && common_attr && common_attr->log_buf &&
> +               (log_buf !=3D common_attr->log_buf ||
> +                log_size !=3D common_attr->log_size ||
> +                log_level !=3D common_attr->log_level))
> +               return -EUSERS;
> +
> +       if (!log_buf && common_attr && common_attr->log_buf) {
> +               log_attr->log_buf =3D common_attr->log_buf;
> +               log_attr->log_size =3D common_attr->log_size;
> +               log_attr->log_level =3D common_attr->log_level;
> +       }
> +
>         return 0;
>  }
>

[...]

