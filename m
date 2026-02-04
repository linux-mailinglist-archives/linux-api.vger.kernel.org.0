Return-Path: <linux-api+bounces-5801-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDN6OtOig2kLqQMAu9opvQ
	(envelope-from <linux-api+bounces-5801-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:49:39 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C971AEC3CA
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DA005300D373
	for <lists+linux-api@lfdr.de>; Wed,  4 Feb 2026 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A6D142882D;
	Wed,  4 Feb 2026 19:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHBjjc7i"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B96F3ED13A
	for <linux-api@vger.kernel.org>; Wed,  4 Feb 2026 19:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234544; cv=pass; b=TLWshUMlV0xghKnV2o5JGqYyOiIEzEBN//Y6lEEh/8sUBzXxEFzv0P8OSwgERhQf1n5xUvu8wNdXLMLKvYxuarHVQU0oPcrq2o3/Dc98wv6I0ZLR0AsaWFrVQlRHvMpRyoNu9g/kZntMhJJ2ZLfO6orsfJLjLzqTic62/9AL+4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234544; c=relaxed/simple;
	bh=P4RccTdALVk7KXo5G3kL+D6XbgyLZgvTIID4CJSA/Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cgVuc2HUZ69elvvz+2JQEl0TzQ/lheOCH4vbN2ci0tjkKffCYWNQHucAtoA5ZKOdQmJF/0260tzYUlmrcHqoULYYyuyDKoDpp+V6faieAnZ+4M/ZbWb+Fm0hXIE+rE2bNI01yxG7RxEHYCqGNZrYOLGZZ0J1iQHWUORANmRYuiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHBjjc7i; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-29f30233d8aso1481345ad.0
        for <linux-api@vger.kernel.org>; Wed, 04 Feb 2026 11:49:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234543; cv=none;
        d=google.com; s=arc-20240605;
        b=XlKwqZr0CkehUFe3Xj4IvLK18M7ik93/VDZM7hgfb/INGYzPaEI4O8ZbIf+FN93aCx
         Nfrl7THJ/+4wKAXuniItWQQ/GJsnBi2LSKqbr3jDdo5AvXGQntoIiPtJcO2t5o+COPDp
         L9pLWTcx+KqE/zrkD8GqzWTNurFkczFPyBlQHSZkkzIjA62F/klfX9YlTO928pvRxqIk
         q9L4K5L4Md6vMKlaMXWMcCdIo53qgFo0Fjobhr7KmGDASZEUmRR8WWBlCQxMGYyVmcxE
         pjILvDMpVO9EwBirtW6doYq4H4WGnRfMe2GFkfp7LGEtLGF1Y/HHw3aEyydjZj/fIfW2
         ovwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h+M8Htr9ti73Lf5CZxUjPKlAeSUlxTCFeqOWZih+5WY=;
        fh=8XWvP+qOAnN4+u9oqFHYLCQ/9b8k7Pa5oWjyauhkDOc=;
        b=KRXBrKXKCrJ30Ov2xf8xllWje9sjqVgni3yFWQp7FxpkBM1g544GWvumM9/GIw5v53
         qiMu9eK9UvzNR1y8HDeqw5qxQk6n4APATns1FP52FJV8PxmM6wdYn/vUqw2Oc2AfkQJ4
         FauOxFoehQMm1ONh6ET0ADKift94ROim2rtMXUBJSXswumO1KIlta7sx67JAACq8XMph
         Z34pvhrDNPiW5lEvUESeJpJzngddEbiWRagJYxI09/mKP8tAitPQXMq4/g5c45HtK9Xj
         FBXdGG3H8ucSAZ2ka/4xW8YjJV203bpquThs9WPUy8dv7a3nZA/CA0APYV9PrA97VFjt
         z/yA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234543; x=1770839343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+M8Htr9ti73Lf5CZxUjPKlAeSUlxTCFeqOWZih+5WY=;
        b=cHBjjc7iLYz5ndTbkY8fkF0/MP5ECbbQnxbQkJFDBaodpp7nubmlOhd1roRx4JfggI
         LYeEo3jTuisOAmtfVhP+h/cLQirxjv/XE0aWSXUm0B/6IzFeGJ3uqwbxB7thJxEBsT7T
         V2PnsMVf/p9zg1Cb893QKi6hHGCLIaARhuyi6f2/WR64mJY63H+6/6uP7rfAmB4bgj9q
         BpmFgM4YhZvcMBQ2wrcUUz6H5gaxv6aj0y6zd0SDro63l5nmVxIiIpdxuWt//XvQqLEQ
         TvtjQqHY0iq8DTNqaa0DfLGIChMAXL1RUGbjPMOFAy1u4N82ig9WFLlFQSzmRAJh5kdz
         +Xag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234543; x=1770839343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h+M8Htr9ti73Lf5CZxUjPKlAeSUlxTCFeqOWZih+5WY=;
        b=Sz+w6v5aU/uC9QZHwXIaeem4i72bh14+8wMEp5cuOIDwnp3HXKoFUkGzEpSd3SGTwN
         XjjEPWiTbxiMkVHG3f//+YQEcjUNMCayw6CxALlw8l+XRZNTSN+xgsPXgTO+kkKG05zZ
         5nklfc5HqtgJE6P5n7Bp4M8wpchieHM0/Tke9VIjv5hmLES34XJbfEjm5ZFY5+opIi0X
         dw1pp2TpTY/37CQBZ1D4zF/s0oCMB7QbBRHgthxHvmFqUXIp1F4/ZIo5M70G/dR7/wR4
         x92OETK9iKLipLEktvFEg477m3V9jr8s5JLegmkdXSRwLjIQG3kKtelNOjL8NssP8Zq/
         n17A==
X-Forwarded-Encrypted: i=1; AJvYcCV1rVTH98uVxkmauciPEbDHZkzUuOsVnp/WVraKCOjvJxcf8NqVqKg1dIzhKTTbjmJgm1iJZD9eXa4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTcQRzQGjx5uGLwPvUvkVaWWeCNmfSAj+g1eALC5G/mmUpu97Z
	zGkRqttxFdVEPrm9mWtIKmyXmj9zmS9mVR8X3BusxD4657XNLGfdh6P0vwAqIGpgZMIo2esyQ6o
	of00mhpY9gQIQjHDDQcnPoWU/PrRg+Sw=
X-Gm-Gg: AZuq6aL14oQqdhbo5AIYY6dK0oFHBiViP7JrORqSHfH+gsuPrIhLKDqHCC7cyScpaZb
	gThpMcnvbjuBtQKuYq6c0F0HomeUN7e523WiSn1kzDoW1JIDPc171rwBRTf26bZbIonotscv5+h
	vdrAVl+k/cFsxfBADpUgvFgn5FOdkZ+APLgWkr7j7A0wS27bMBXKbrYiPfh6FfHIoDSSzL2GAJd
	j5YGf0D6YTY+qKphrfuEd9Vekn1A7/8zce7Xf+UoRb4yubuAkfnB8Kuy73h61K5DOUiqxwauHJT
	fHOmaWipS1w=
X-Received: by 2002:a17:902:e88d:b0:295:560a:e499 with SMTP id
 d9443c01a7336-2a933bc9b8amr48387865ad.5.1770234543336; Wed, 04 Feb 2026
 11:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-5-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:48 -0800
X-Gm-Features: AZwV_QjUlT_cWqgjztt8E7bGlgaHJ3gG7CwUG4HZmCNdazdNONiDcafxsvfD97M
Message-ID: <CAEf4Bza-PM9ExqJS=Q_oj7Cqc5dvmbN_Zv9-4UnJNtsZU28FoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 4/9] bpf: Add syscall common attributes
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5801-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C971AEC3CA
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:42=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> BPF_PROG_LOAD can now provide log parameters through both union bpf_attr
> and struct bpf_common_attr. Define clear conflict and precedence rules:
>
> - if both are provided and log_buf/log_size/log_level match, use them;
> - if only one side provides a log buffer, use that one;
> - if both provide log buffers but differ, return -EINVAL.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/log.c             | 24 ++++++++++++++++++++++--
>  kernel/bpf/syscall.c         |  3 ++-
>  3 files changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index c805b85b6f7a..0d106fddbbc5 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -638,7 +638,8 @@ struct bpf_log_attr {
>  };
>
>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> -                               bpfptr_t uattr, u32 size);
> +                               bpfptr_t uattr, u32 size, struct bpf_comm=
on_attr *attr_common,
> +                               bpfptr_t uattr_common, u32 size_common);
>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index ff579fcba36f..345005ba98dd 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -873,10 +873,30 @@ static void bpf_log_attr_init(struct bpf_log_attr *=
attr_log, int offsetof_true_s
>         attr_log->uattr =3D uattr;
>  }
>
> +static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_b=
uf, u32 log_size,
> +                              u32 log_level)
> +{
> +       return log_buf && common->log_buf && (log_buf !=3D common->log_bu=
f ||
> +                                             log_size !=3D common->log_s=
ize ||
> +                                             log_level !=3D common->log_=
level);

let's validate (unless we do this somewhere else) that if log_buf is
set, then log_size and log_level (? not sure, maybe zero is fine) are
set, or all three are not set. Same for common->log* fields...


> +}
> +
>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> -                               bpfptr_t uattr, u32 size)
> +                               bpfptr_t uattr, u32 size, struct bpf_comm=
on_attr *attr_common,
> +                               bpfptr_t uattr_common, u32 size_common)
>  {
> -       bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_siz=
e), uattr, size);
> +       if (bpf_log_attrs_diff(attr_common, attr->log_buf, attr->log_size=
, attr->log_level))
> +               return -EINVAL;
> +
> +       if (!attr->log_buf && attr_common->log_buf) {
> +               attr->log_buf =3D attr_common->log_buf;
> +               attr->log_size =3D attr_common->log_size;
> +               attr->log_level =3D attr_common->log_level;

why are we setting this? Do we still have code that can access
attr->log_buf even though we pass attr_log everywhere? If yes, should
we still have that "split brain" code?

If we don't have this assignment, then I think we don't need to have
bpf_prog_load-specific and btf_load-specific log_attr_init() helpers.
They can be unified into generic log_attr_init, where for
bpf_prog_load you'll pass offsetof(log_true_size) +
attr->log_{buf,size,level}, and for btf_load you'll pass different
offset of and btf-specific attr->btf_log*

This helper will just be making decision whether to use common_attr's
log fields or passed directly command-specific ones.

Or what am I missing?


> +               bpf_log_attr_init(attr_log, offsetof(struct bpf_common_at=
tr, log_true_size),
> +                                 uattr_common, size_common);
> +       } else {
> +               bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_=
true_size), uattr, size);
> +       }
>         return 0;
>  }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e81199361241..7125ea445c6c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6232,7 +6232,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size,
>                 err =3D map_freeze(&attr);
>                 break;
>         case BPF_PROG_LOAD:
> -               err =3D bpf_prog_load_log_attr_init(&attr_log, &attr, uat=
tr, size);
> +               err =3D bpf_prog_load_log_attr_init(&attr_log, &attr, uat=
tr, size, &attr_common,
> +                                                 uattr_common, size_comm=
on);
>                 err =3D err ?: bpf_prog_load(&attr, uattr, &attr_log);
>                 break;
>         case BPF_OBJ_PIN:
> --
> 2.52.0
>

