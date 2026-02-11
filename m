Return-Path: <linux-api+bounces-5830-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP8HN/b9jGn4wgAAu9opvQ
	(envelope-from <linux-api+bounces-5830-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 23:08:54 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 10894127F8F
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 23:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84F2A3037D68
	for <lists+linux-api@lfdr.de>; Wed, 11 Feb 2026 22:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B5132860E;
	Wed, 11 Feb 2026 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKEMc8KQ"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF13731815D
	for <linux-api@vger.kernel.org>; Wed, 11 Feb 2026 22:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770847727; cv=pass; b=HJmee1rnLB1dKSKE7ZS4r+8FxOj7ef2m3PSRotdUtppMy2req5HAvBdsaDh3TYHQKG6y17Eo4hnfXpoaqAueXca+EZKIlcXSrOx1uuczW02UByBjg4a2/nZJuBSqZclsXnl4kcDa+pAWOn9I5tnr80FDtOfPjP0FovJ1Ou5voE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770847727; c=relaxed/simple;
	bh=YTEc7yz++McjM/QESfkzmoIxz5gszvA6+FEULAO3vW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sc708/0y+4eQVd6N7SWDKvPz1x13q7QbftEP0AdwzXkW6Dnoqf8/fCvsqh1Y3TifSwjASqdIN1Rp2bMu7G68hO0ZpwsqPl8NVEBDmKnquckJ44vFOZFUabQs7GY9/Wc4JgQ9lHKjUQ1elTAQF7IzJBXiTwMnDIS4OUgvsQG70kE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKEMc8KQ; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35621da1a7dso1662664a91.0
        for <linux-api@vger.kernel.org>; Wed, 11 Feb 2026 14:08:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770847726; cv=none;
        d=google.com; s=arc-20240605;
        b=D9U4mcl4gpcaOt3nZrSGRptIIPoe6xXT7wPn7rl6rZaf/nrat/sSqrW6a4ptRBz/2J
         3xWQFG7KO+96Ig2X9RJO6eR9QP/OIVHxcZW3dTHzJv/iYpiRo1s8nasLcrWQ72fRee47
         X/fsH+scd+ghPUoKEDTLydHbZt0M4hWsvW+CutYdepgzNcwBp4J3M7bU0YSe2Fjuwjy5
         PFnG3N0x6iUVDH5kgHRuOyK/zOsezb1Pnm8h/SyboKu1gL5FEKSnSsd3Wz/nKODesgfS
         0cxSRsYjCFVzZetop0RZLYqrmrCa1K8ttlRCtRJ8CsozDGN1OBB7UYBeji9SLLc/dDSR
         X6Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aBH8LUgAoQkvcJBNFakHNRaolsL29KJZe94++vwPAx8=;
        fh=PN1//S/9+EHNTJd0VPnoA6K1DiCXgg6ncOwi2oHeHc4=;
        b=bEEHvIP0m9iuz+XM1tRXvYXfr6hBdjlXKnqzGyIsmcx6fFWbUxTy8NHkcgcP+uczX6
         1lL/g3wiBYVphA9l+IXqQa0Jwq4bvXfhJB5XoiGB5nfpzHRAmxnjr72lU/ee1VQMb22V
         ud0/BKjtcmR08SaXGTgTpOzd2/VO4r1bL/F+hJoPK5fT2d8/H9K6w/8wgAvHohsjw6di
         aTLhFFbQs1R+Kedlo7EPi0fmZaZKAN125b0ANaIXyqunCAZQ2E2GgkMbIdWvgQVKRu8G
         W9RvVGqhPLtNsIOU/jEOmKCoMwGCONumEmPGEZ69rrAMhIbuHyBMkB1AFD36YeXd3iDb
         Wc1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770847726; x=1771452526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBH8LUgAoQkvcJBNFakHNRaolsL29KJZe94++vwPAx8=;
        b=NKEMc8KQYqzZgd/32ApugbQfpSTM7iHGzu6RpUeOFRcsNzbJ581VL8koHKiDCS7jLd
         +QXz/2qgsrKBFznkGa3zcPjBAsvyJCNTGDdXXSu7xR6o0hpIIAwpBL0ZmnwyBXW0Bhz/
         lmpRn5fvDW3UDRTs149pe75NLdTfD6X0ZlKM1vnEmly2Eep6NHEh7v2R3Dx7RTDwacoJ
         voH13EGmXoWY2lS0uUXiMmVfm9wk6J4t/0JA+ISqwKTWt1fm1jsledz3UOGPZAUHg7WS
         +0z9EvVT+uWnp50Z211j6RliwMItsiIh+AqI9M17M9TAADxQyA2NLhcbHlpDBQLCWwfH
         HBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770847726; x=1771452526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aBH8LUgAoQkvcJBNFakHNRaolsL29KJZe94++vwPAx8=;
        b=MSwJCCHlM6W8OxE0XsDDN1xHa40LJivKMDgMDP0rGRJiw+a1ZHmpBNdOxNtk6OCayZ
         P9U8vtapz2NeM0BRVjSC4bmu7mJLg1n4jbl9be65yyw3VRV8R6GjtwAbhbhXyRyl5W6h
         n4NKoe8HmfV/kBJCbVSghULcfd3U2YFBshzX85QRtwv+aLiYRXWhaY/7ebQ7hDBN04cO
         Rr69lX1QfYdvPnd65o4AaIaQP0d6YT77Qiqbp7QWKM9lLnBQn1HgH79crvePrcKVKHoq
         zYzmvHgBURe5OWah0YlO15vI6NkWol68HNhgsPqZN6A0fgOIgHiv0y9auh38r4IKsDvG
         rHgA==
X-Forwarded-Encrypted: i=1; AJvYcCVbgXm9EPPCaVtCTADWiU6iUhdjj2dQIUoqi6hG8D69p27KAm+dc1dnHLEgXmfUaBxcrvFjp95wuVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUog3LIBcAWjvmvgLJzm4kQjq6jcN82SumdrKYNoV8JNQLihG
	5RfR7SaD/Ds4RR4Wcxbnysv1tEwvJbDw3BCvzuxoTx4h2DzborF4HYVfvHT+uSbBxEG7OQAgcV4
	T/3AwIH+Vi62Wdim8nZKJzyoP0m5ROR4=
X-Gm-Gg: AZuq6aK/nl2p+9lm41TFns0aKMaChM0ZwWaUGeEL3LGVC4kRMRCTns2sW4eSIV3+dvj
	apujK8/p8fl4XDeRwYYQ2LaoshDZXXszQDvXt6ShMGnYdnS4aZ9UzdNKppxjTxyPQyyey/Te332
	qn2vlxVHvrH4kbY2T3R8S0qN7KdV3K3krHOgsjRbIxLeaJU7+bRlz5INKGP2nD6gKHme2z5P8KK
	xkJqV0V4J7SgEACdxFGsSDCAUjWl/ZwIUyu9aNWfZ9JBKCocMZVy7YkD1aWgTLUYj7gltZrsOSA
	4StL3Ny+q57dl1ihKo75qxs=
X-Received: by 2002:a17:90b:4ecd:b0:32b:c9c0:2a11 with SMTP id
 98e67ed59e1d1-35693cbc9b2mr148121a91.4.1770847726037; Wed, 11 Feb 2026
 14:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-5-leon.hwang@linux.dev>
In-Reply-To: <20260211151115.78013-5-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Feb 2026 14:08:32 -0800
X-Gm-Features: AZwV_Qh1cQXIN4noSjTPx6D9rnW3i7gLc8B_jvGvfZ948hxwQMFC6HuziGukW0c
Message-ID: <CAEf4BzbTtC19E_=RCk_KCjrOimbefhnXCEfURw4b+caxCY6SRQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 4/8] bpf: Add syscall common attributes
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-5830-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriinakryiko@gmail.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10894127F8F
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 7:13=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> BPF_PROG_LOAD can now take log parameters from both union bpf_attr and
> struct bpf_common_attr. The merge rules are:
>
> - if both sides provide a complete log tuple (buf/size/level) and they
>   match, use it;
> - if only one side provides log parameters, use that one;
> - if both sides provide complete tuples but they differ, return -EINVAL.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/log.c             | 31 ++++++++++++++++++++++++++++++-
>  kernel/bpf/syscall.c         |  2 +-
>  3 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index dbd9bdb955b3..34f28d40022a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -643,7 +643,8 @@ struct bpf_log_attr {
>  };
>
>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> -                     u32 __user *log_true_size);
> +                     u32 __user *log_true_size, struct bpf_common_attr *=
common, bpfptr_t uattr,
> +                     u32 size);
>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);
>
>  #define BPF_MAX_SUBPROGS 256
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index e31747b84fe2..a2b41bf5e9cb 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -864,14 +864,43 @@ void print_insn_state(struct bpf_verifier_env *env,=
 const struct bpf_verifier_st
>         print_verifier_state(env, vstate, frameno, false);
>  }
>
> +static bool bpf_log_attrs_set(u64 log_buf, u32 log_size, u32 log_level)
> +{
> +       return log_buf && log_size && log_level;
> +}
> +
> +static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 log_b=
uf, u32 log_size,
> +                              u32 log_level)
> +{
> +       return bpf_log_attrs_set(log_buf, log_size, log_level) &&
> +               bpf_log_attrs_set(common->log_buf, common->log_size, comm=
on->log_level) &&
> +               (log_buf !=3D common->log_buf || log_size !=3D common->lo=
g_size ||
> +                log_level !=3D common->log_level);
> +}
> +

I'm not sure this check is doing what we discussed previously?... If
log_buf is set, but log_size or log_level is zero, you'll just ignore
log_buf here...

Maybe let's keep it super simple:

if (log_buf && common->log_buf && log_buf !=3D common->log_buf)
    return -EINVAL;
/* same for log_size, log_level, log_true_size */

and then below just

log->log_buf =3D u64_to_user_ptr(log_buf ?: common->log_buf);
log->log_size =3D log_size ?: common->log_size;

and so on


We can be stricter than that, of course (as in, all triplets have to
be completely set in either/both common_attr and attr, and they should
completely match), but it's just more code for little benefit.

>  int bpf_log_attr_init(struct bpf_log_attr *log, u64 log_buf, u32 log_siz=
e, u32 log_level,
> -                     u32 __user *log_true_size)
> +                     u32 __user *log_true_size, struct bpf_common_attr *=
common, bpfptr_t uattr,
> +                     u32 size)
>  {
> +       if (bpf_log_attrs_diff(common, log_buf, log_size, log_level))
> +               return -EINVAL;
> +
>         memset(log, 0, sizeof(*log));
>         log->log_buf =3D u64_to_user_ptr(log_buf);
>         log->log_size =3D log_size;
>         log->log_level =3D log_level;
>         log->log_true_size =3D log_true_size;
> +
> +       if (!log_buf && common->log_buf) {
> +               log->log_buf =3D u64_to_user_ptr(common->log_buf);
> +               log->log_size =3D common->log_size;
> +               log->log_level =3D common->log_level;
> +               if (size >=3D offsetofend(struct bpf_common_attr, log_tru=
e_size))
> +                       log->log_true_size =3D uattr.user +
> +                               offsetof(struct bpf_common_attr, log_true=
_size);
> +               else
> +                       log->log_true_size =3D NULL;

why not treat log_true_size same as log_buf/log_level/log_size? If
both are provided, they should match, and then we don't have a
possibility of inconsistency?

> +       }
>         return 0;
>  }
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e86674811996..17116603ff51 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -6247,7 +6247,7 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uat=
tr, unsigned int size,
>                 if (from_user && size >=3D offsetofend(union bpf_attr, lo=
g_true_size))
>                         log_true_size =3D uattr.user + offsetof(union bpf=
_attr, log_true_size);
>                 err =3D bpf_log_attr_init(&attr_log, attr.log_buf, attr.l=
og_size, attr.log_level,
> -                                       log_true_size);
> +                                       log_true_size, &attr_common, uatt=
r_common, size_common);
>                 err =3D err ?: bpf_prog_load(&attr, uattr, &attr_log);
>                 break;
>         case BPF_OBJ_PIN:
> --
> 2.52.0
>

