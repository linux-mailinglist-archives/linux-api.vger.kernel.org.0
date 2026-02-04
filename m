Return-Path: <linux-api+bounces-5798-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKFfLamig2kLqQMAu9opvQ
	(envelope-from <linux-api+bounces-5798-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:48:57 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC30EEC380
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A98113002F6D
	for <lists+linux-api@lfdr.de>; Wed,  4 Feb 2026 19:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D78388867;
	Wed,  4 Feb 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZSCuhXh"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279C35BDD5
	for <linux-api@vger.kernel.org>; Wed,  4 Feb 2026 19:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234530; cv=pass; b=lzkYnQc61zHxV9VXIFBZI7anB3532uwjKgG6zKh9TxLFORNqdL1gSNcQy7arN7OCW3/YNuBmNkepbMElWJ57mWc51e2hURig+vR8sRsxn4d7lWh7iGuqV8eAVM7jcvTDAi5bFjc2TpwSf34uZ47kl8vasc6ClV/Yb1+93sCRZ84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234530; c=relaxed/simple;
	bh=JSaxY0XhGcOSeu31HU5l9vEV9baQLzqFjwH/9t5p01Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTm3mLLzsSjLAcZD5V14OA0N1MovQN3ZWJkcY2R7NIdVzmd5jVpLMGtOQsHQduoAhLCiHF4HMoZj/GjH91255wDJNrhqSzwmh7JUYA5tRxTiSiRXg+m/PvQMKOm4DuCeWKd5p3bsn8ACQQxgPqX1kxnDg/qQ0C+s1+ZscxwM2WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZSCuhXh; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3541fd9dacdso105140a91.1
        for <linux-api@vger.kernel.org>; Wed, 04 Feb 2026 11:48:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234529; cv=none;
        d=google.com; s=arc-20240605;
        b=cSVy4ifrRZPXCfk87SlIuoGWYBqIx3KXjjZFLm9VJUnLJMSXDoI4yT5Z8kiZJgHcRR
         rPLq6Fvp8GHNass8Ev4Hd1wa+0VWqml9lQH3YJhdzXr+i8WoY+BAv60i8gj9ahsyYV1D
         zYXz6zOGnK8WdphnwEDnsZM1g1P+gb+gHKmayndUqMUbkX/u2c2m9d34A64zoqhuMgIN
         NTnUfaT/CAUK/Q3EgvS9oxACxX3mClfUDNokoPP4X3rFNNK6qVJn0OicROeqFkxqC6Z+
         TH9MNmq2EUo/ipcDS6t8R4A/FkV197jn83/hhQk2MsLsxtNHG0a5L1pZ/DmrQhTqL8tw
         dsIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BqaY+jlyASjji0VRhimoxVMsJ9WH26mRw0zvhRsW3No=;
        fh=O04IBk/LtGyjGIagHj0k/Eq8KQOqD2qk//KXQiiQOoM=;
        b=d/I335yQCoHGsZxg0wf0t3sG0DphMhGbQpU7m16ts03jkr6atcMhQbj8hayDRpO2OU
         sS2UOtUjBRZM7dA7Bz6Pad6raoH6X3w/mvglieTCg/fWx+rGUiC++fYwm7blVk7wR6fl
         W034l8dot4k74bY9PtdbpC++KD/DGX5ICegDCot8b6yh3AZertDmpx81AM8qwMgmlTKX
         rffVn4tpcIoqSaPyS66MgGn+beMscQllR3RxB90etMQYyMR2tkWOTuIDjSS7dMULKTRO
         MZGjgXqYW/Ev0j/mBhpolZqMUJHlwMWdE8EuzPLNlD2ZCxduqFA1mwURhjqYFUn8FQOn
         M5gA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234529; x=1770839329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqaY+jlyASjji0VRhimoxVMsJ9WH26mRw0zvhRsW3No=;
        b=cZSCuhXhrLuGSUtbz2sXoaUexxUrdVT5NLcOZSxKfRSXz2r40fpreN8Uyr0IpV6SA4
         s0f+W3L3Spda6QeznSPfysNNysYSlHtXFyhK+RtrsPQCEgQKDz+EnqgAlp4iuYLFeLvy
         uN8nvfj9kIkn1C0RrONtWHbIeOZGRLbl/J2RDyl94fHK6K/CB5ZDz0dZQf8TDU6dTHqc
         6ksOOv8UlMzrOh/4yJN7X+zKB/0EPBMml9cjCYp0cpZMpOHxVLU3mV+MDcA9/IBxQC/0
         e2+QdyWUkeHwzoUuqFOvoy+veth0Tv5a2zLDvFgsStpVT+iN/KxCuBYvD5pjlIc7NaUA
         Kxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234529; x=1770839329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BqaY+jlyASjji0VRhimoxVMsJ9WH26mRw0zvhRsW3No=;
        b=j9W8O1m4S93u7+jFWi6jKm7c4/HneXnJ7BzJZODDaiKscTHr9aCuyM2wGILEnJ3tIa
         e47Hlabtccn/mmugDkp+JiOshUKDBQlhJQx0mzGlhMaHd0gCEeKGfIHAjTgMBKLC0lqw
         Som5u8VH40hnlYe3t1BuYucwc6llI10lQY3AqHvCSaOiVoBdOonl5bu4rXpPb8JrfIZm
         foiZG7a3sxrWfPCEpK+KueKDpYt8KFNggEKpGCXuLTlV1L9GGuj+T0MkfH/tnjRQ3Iom
         QtaKs12/aDESvUIRK2SZ+pLVXZ3kmj2hGIvs1GeRQyOJ51tcKXK3mh5NBYNEaOR1dNlM
         NcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUx6lPd5FD5PgqKjJ0SegBX6Tea4UFjyq0RwYmrMO7bZdYb/42/2NnIbOHCSIzV8GDk+uyA1kAg3ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjZVJEiQosMyB8T8b1eUTaFNkPrcCoPXWSootQuU6BcTn6GER7
	tz0oXtbL7pJVJSv4flr+iG77h6TszPIXb7HkltX7uhdsal0zOpIjtoE4IuGZdsisDbl3Ptd8MhG
	2ox65/hVFcro++9Z6+3HTnz5WBSuYHOw=
X-Gm-Gg: AZuq6aIdvIm1PI7+n9wz2nVGJoHi8UbDIXq6oyPCKQkOLvT5i0NfA46qlvCYzNx+nxi
	mdjXIaGTxTPgQeS8bRFTxtglThJKGPNA0ymxkrrw9nsA6CQbA4aFW9Igzt+JjwOEhzdqzJyT1M7
	nnNNs5g7pOVRQKFh+4j9DLOCteXVsJHuwDoyZ8PbU7GzRwn57y2pSTqOdCqA0Zdfv1kBsoFE27M
	0McSouBGg3vB6wqUz7KudtR6VsyTKfLgNteTOt1xDYSgemodcrEd9/2xxl/o+w1rmUgEsn0iwXK
	NXRqlpWj9tY=
X-Received: by 2002:a17:90b:2b43:b0:352:d0cf:9d18 with SMTP id
 98e67ed59e1d1-3549bafc8d5mr399008a91.5.1770234529339; Wed, 04 Feb 2026
 11:48:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-9-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-9-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:35 -0800
X-Gm-Features: AZwV_QgJy7fB-V7u2aIUi_WBvMRT4bLPItNSz_ncka0FXGNgBUOJOI58gJ1sfVA
Message-ID: <CAEf4Bzb=96Ja38VGBr9YGGSSjaWwhkfH_oWjMJULykA-a7jZxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 8/9] libbpf: Add syscall common attributes
 support for map_create
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5798-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CC30EEC380
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> With the previous commit adding common attribute support for
> BPF_MAP_CREATE, users can now retrieve detailed error messages when map
> creation fails via the log_buf field.
>
> Introduce struct bpf_log_opts with the following fields:
> log_buf, log_size, log_level, and log_true_size.
>
> Extend bpf_map_create_opts with a new field log_opts, allowing users to
> capture and inspect log messages on map creation failures.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c | 16 +++++++++++++++-
>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
>  2 files changed, 31 insertions(+), 2 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 9d8740761b7a..0c3e40844d80 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -209,6 +209,9 @@ int bpf_map_create(enum bpf_map_type map_type,
>                    const struct bpf_map_create_opts *opts)
>  {
>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog_ha=
sh_size);
> +       const size_t attr_common_sz =3D sizeof(struct bpf_common_attr);
> +       struct bpf_common_attr attr_common;
> +       struct bpf_log_opts *log_opts;
>         union bpf_attr attr;
>         int fd;
>
> @@ -242,7 +245,18 @@ int bpf_map_create(enum bpf_map_type map_type,
>         attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_hash,=
 NULL));
>         attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_size, =
0);
>
> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +       log_opts =3D OPTS_GET(opts, log_opts, NULL);
> +       if (log_opts && feat_supported(NULL, FEAT_BPF_SYSCALL_COMMON_ATTR=
S)) {
> +               memset(&attr_common, 0, attr_common_sz);
> +               attr_common.log_buf =3D ptr_to_u64(OPTS_GET(log_opts, log=
_buf, NULL));
> +               attr_common.log_size =3D OPTS_GET(log_opts, log_size, 0);
> +               attr_common.log_level =3D OPTS_GET(log_opts, log_level, 0=
);
> +               fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, &at=
tr_common, attr_common_sz);
> +               OPTS_SET(log_opts, log_true_size, attr_common.log_true_si=
ze);
> +       } else {
> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> +               OPTS_SET(log_opts, log_true_size, 0);
> +       }
>         return libbpf_err_errno(fd);
>  }
>
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 2c8e88ddb674..59673f094f86 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -37,6 +37,18 @@ extern "C" {
>
>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>
> +struct bpf_log_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibil=
ity */
> +
> +       char *log_buf;
> +       __u32 log_size;
> +       __u32 log_level;
> +       __u32 log_true_size;

please mention in the comment here that this is an out parameter set
by the kernel

> +
> +       size_t :0;
> +};
> +#define bpf_log_opts__last_field log_true_size
> +
>  struct bpf_map_create_opts {
>         size_t sz; /* size of this struct for forward/backward compatibil=
ity */
>
> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
>
>         const void *excl_prog_hash;
>         __u32 excl_prog_hash_size;
> +
> +       struct bpf_log_opts *log_opts;
> +
>         size_t :0;
>  };
> -#define bpf_map_create_opts__last_field excl_prog_hash_size
> +#define bpf_map_create_opts__last_field log_opts
>
>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
>                               const char *map_name,
> --
> 2.52.0
>

