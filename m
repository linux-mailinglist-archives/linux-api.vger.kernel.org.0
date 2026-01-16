Return-Path: <linux-api+bounces-5644-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F26B0D296FA
	for <lists+linux-api@lfdr.de>; Fri, 16 Jan 2026 01:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A0F803008146
	for <lists+linux-api@lfdr.de>; Fri, 16 Jan 2026 00:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835F306B3B;
	Fri, 16 Jan 2026 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVkJRyv4"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035AA302CDE
	for <linux-api@vger.kernel.org>; Fri, 16 Jan 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524157; cv=pass; b=USj3MO190NcFmzQdURPqaRGbYW2ufCHI2cuY04pVS/r3goX3dsflbuJrA/SeMeW3szGJecVTg78Vmu0GKD0RxlODEfzFEFEPpsv1xwupIobrblKT+ZLgeAbhND1sfWOKi8JzrCYuxp7Hzae2voZJR0hfUcIHzPQJ4XUD8+TrlPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524157; c=relaxed/simple;
	bh=Cg06FeML/T7hypkXS7qHos2NFAbpK6c7/UMKz+ylJjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YB2iYca/43sBCm44YFDiM08sK3VDMGwY8NUMOy26pIwJSJ83FrZjttL61SMBYC/ZkAgojrrO+hQE3BkiSHe3Ic53i69zgbkaXpKTi9nZg4kI23TGmaOeFZDaERK3nvLZ34PQSB1JYWroZBmtYo0zQiorWC8GzuUlZhAaAPgKQcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVkJRyv4; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c2a9a9b43b1so1006627a12.2
        for <linux-api@vger.kernel.org>; Thu, 15 Jan 2026 16:42:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768524155; cv=none;
        d=google.com; s=arc-20240605;
        b=JGTdLE+TaXJzM7PQj62Fj7j2x7LVCOMuDVlBfQkYCQytJIRMdzR+cTIurKY8fLZjKW
         Ag66F0JYaLdcNU0vwYgN77CekOJTkrOELoVB8OvoJdnpQiuCVJhIxrHgxGd6UW4xy05w
         Z+97va4OcLv7mIYDmVYyuSrJzWoY3a6wGfwBe2HD0NkICVVtvyR1DVHbhZNQn74ftNp9
         NwnEh24pFz7Mg1waYvga7+7fq0GXtkd+0TCjlhNWkZLc81ZLICuoi5IsKd+CIhVc48TD
         esfI8orrTwpY2LD5xo5dt1/sSzHfY8FIfg49K3VyLBU1VxhmR1+v/ltV8XgvxvYGuaUf
         DtTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5didJoF5BdyOHZEdMd//tIhEBHGWfShDkE5NMN7SDPc=;
        fh=DF9EF8u1FJ674qXZdh/VOHDSDe2CbogIGSYjjMtR3ok=;
        b=Rw5pWgTlsk3CjVUA82BRkwV4juT9eP1uzRCKY+MTtNV8hmuJHK4A/O56peCcd5MIlI
         N4ROcz1vFe/csP8D7a7a+0Jgdbi1CdZgNqGpSC6xUmrTqD2WHDmJik8Pecqb9MDBU3QQ
         idU9M54TN1jnQahitz1C51CQOwbm8T8aDyUNCYzUHtIDu+lXy8rBcq6LR5Lh4WWRh5kQ
         WM3m4/N0vpRqy0DzzJmU9qwnyFeDMegL1ipmXqBPU4+grLRrNg1wePj75s3+lppASBBl
         PrN8hgIgB3ajGTlTw++k9bLX1642eDmLcc5kL0dXR/duaxj8qMNzJfeCsJoiXywiwYx5
         x4Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768524155; x=1769128955; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5didJoF5BdyOHZEdMd//tIhEBHGWfShDkE5NMN7SDPc=;
        b=PVkJRyv4wcnQphsJYUL9o+JzgLoVMiUaRtV1XYHCiQgvWERdKmnH+IJ0l/ns9nc3C+
         yqbgSF8fifVtaxTxA2mF1alosvTWSeRHW7jEaQPYr/M4gd9AMwbYsuBYLqH3ShzfZRj4
         dxnlt82E+EcPPtWxvOisW5JYtgGBAPqaHTWRNwM68PgkDPox7o3A0duq9+Svc6b1ThD/
         I+Wn4l083lP2unDG2era2RfqUGiJrqaxO3mZ88oAIdDOTsP+nFeu5zdCyT+m+XcubMSo
         p/ZoEVheCrKjOWQv8h6sU+Zre1pM0Qf2P4pg8/j5MpO0Peu4E1w7NVjHuz/vmxD4hiuE
         FNRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768524155; x=1769128955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5didJoF5BdyOHZEdMd//tIhEBHGWfShDkE5NMN7SDPc=;
        b=FRemIJavVP5ezyOkMu+7W8HzsTA+XB5J0zGEWmvrWJkREJYsv3X6pYkE8tjn/qcZrG
         BswjMrsiunJ3Ng/1fcLS8IkXKOL5iKhUdEykCbm2NPLHlCfdlnQswBgFu9JhB4eI6E3c
         mWe3mq4NzB7+2Nh8w9FOU+0lXjAM1d64DEj/FTW1mU+XmsP4mPotWqB80dhXWQJrHn7c
         73tMygH5bcqdLHkfWkF3qcqeF3DZeByYIMh/6ac5S55qlIRtoCdw8IB0+i4xjB5rATSp
         VKWBYqbIZ7+iLoIbTK4KEpDY3ds3UAyVwMKXoSzalYw8FiFPLYX5Al7q2ImWI/QDYf/F
         /gwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9/FGjy71cmsb4C7Hy/jMOVEKImhAZMsGlQuJw1n1kIkIPQ2eX2cyoHjMN7c9Lpn63jcNzpo3Em7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzpSZ/8WNOfyNm+55nv3fakLAID1Zlql1MSt2WcXfK6lmAED6t
	Lt1k1Ly8G9dDjcNYS5Az254iUpKe0m/8mhPIAybOApzRYjQkfko7MWQhnKkhYjcl2RfaN1pWlWG
	OACIPm7tAO0KTElRQXzzJtSUomf7HEGY=
X-Gm-Gg: AY/fxX5NAb8dbGmsV+qMFb4iF1YD61PqFVRYzv+jKV8HAgfm2WJMVfKZ1w6j+UaQnTl
	DC2B2tqns+KPrDB4pX6Qc+4gxNsW6Gln6G+5+VqYL5bsjfzZnYmfar0TchGsPyVvRvjWy2wayam
	8AUaZfy8oznLXCNmE+IDHmJWzRWbX98WQfoXrkjGQG4+eB7+i/mgHI+Sj8TM7eh/hfWtJNnzH8Z
	k/dUlmtYes1AlnieIPFkfBqDa7RkjN2AnS0Px4CWLMBHToX2eE8Qg81u8dRusNECXvsz0lXs8L0
	Fvks8Z94
X-Received: by 2002:a17:90b:56c4:b0:32e:7bbc:bf13 with SMTP id
 98e67ed59e1d1-35273298fdbmr910991a91.34.1768524155197; Thu, 15 Jan 2026
 16:42:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-3-leon.hwang@linux.dev>
In-Reply-To: <20260112145616.44195-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 16:42:22 -0800
X-Gm-Features: AZwV_QhNdxDJ6NlutrW9Xm3USMSfS1qX1NT2r_W00q3idFFQYx4FVRRsA0D_Y9s
Message-ID: <CAEf4BzYRC+=J05C6QDwgzbJ7gO7gZD4xcEcj9ixCaJ=xaRuSsQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/9] libbpf: Add support for extended bpf syscall
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

On Mon, Jan 12, 2026 at 6:58=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> To support the extended BPF syscall introduced in the previous commit,
> introduce the following internal APIs:
>
> * 'sys_bpf_ext()'
> * 'sys_bpf_ext_fd()'
>   They wrap the raw 'syscall()' interface to support passing extended
>   attributes.
> * 'probe_sys_bpf_ext()'
>   Check whether current kernel supports the extended attributes.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 34 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/features.c        |  8 ++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  3 files changed, 45 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 21b57a629916..d44e667aaf02 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -69,6 +69,40 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> +                             unsigned int size,
> +                             struct bpf_common_attr *common_attr,

nit: kernel uses consistent attr_common/size_common pattern, but here
you are inverting attr_common -> common_attr, let's not?

> +                             unsigned int size_common)
> +{
> +       cmd =3D common_attr ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMM=
ON_ATTRS);
> +       return syscall(__NR_bpf, cmd, attr, size, common_attr, size_commo=
n);
> +}
> +
> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
> +                                unsigned int size,
> +                                struct bpf_common_attr *common_attr,
> +                                unsigned int size_common)
> +{
> +       int fd;
> +
> +       fd =3D sys_bpf_ext(cmd, attr, size, common_attr, size_common);
> +       return ensure_good_fd(fd);
> +}
> +
> +int probe_sys_bpf_ext(void)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       union bpf_attr attr;
> +       int fd;
> +
> +       memset(&attr, 0, attr_sz);
> +       fd =3D syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr,=
 attr_sz, NULL,
> +                    sizeof(struct bpf_common_attr));
> +       if (fd >=3D 0)
> +               close(fd);

hm... close can change errno, this is fragile. If fd >=3D 0, something
is wrong with our detection, just return error right away?

> +       return errno =3D=3D EFAULT;
> +}
> +
>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..d786a815f1ae 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +static int probe_kern_extended_syscall(int token_fd)
> +{
> +       return probe_sys_bpf_ext();
> +}
> +
>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -581,6 +586,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_EXTENDED_SYSCALL] =3D {
> +               "Kernel supports extended syscall", probe_kern_extended_s=
yscall,

"extended syscall" is a bit vague... We specifically detect common
attrs support, maybe say that?

> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..e2a6ef4b45ae 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports extended syscall */
> +       FEAT_EXTENDED_SYSCALL,

FEAT_BPF_COMMON_ATTRS ?

>         __FEAT_CNT,
>  };
>
> @@ -757,4 +759,5 @@ int probe_fd(int fd);
>  #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
>
>  void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_=
LENGTH]);
> +int probe_sys_bpf_ext(void);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.52.0
>

