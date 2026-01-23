Return-Path: <linux-api+bounces-5721-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lAo1JqvGcmmspQAAu9opvQ
	(envelope-from <linux-api+bounces-5721-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 01:54:03 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DCA6EDBF
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 01:54:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1FF2300E635
	for <lists+linux-api@lfdr.de>; Fri, 23 Jan 2026 00:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07137354AE0;
	Fri, 23 Jan 2026 00:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mn0kQ2YS"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F6E352FAC
	for <linux-api@vger.kernel.org>; Fri, 23 Jan 2026 00:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769129638; cv=pass; b=RJyZLAi2Hiw+XUkPachLANAsU2SHt4+c402uPsNhwNOyzp2lzQfTZujyKE3gpd4YERxzrVeMKJEbzVE/G/uETQyLex65jc57WvZRneBL7he4mbnxMx0Z1CIXgnp0LSn5RqgjZlgSODf84BGnrDWJV3b9WjuvtLjAk3lBKleH+XQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769129638; c=relaxed/simple;
	bh=yBMXOwcpjCZoufdlj1pFQsMJaO1vK6MgX5cAbS0lKxY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W2Ydinjm0t1wl88VNWI9R5sfgygVWll6VA6BK7iIrsB0aQrfSFPQifwyP2WeYglbj58mCpckb207lAQbfgd5C2zPp+/0hQReOKASh9Pb5pV04nljGYYvRcKVHV7oEqf9ZfzID60TiSmYelZtHUmQEo9xIohCgK+NTYWlnLn1SC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mn0kQ2YS; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a102494058so13918295ad.0
        for <linux-api@vger.kernel.org>; Thu, 22 Jan 2026 16:53:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769129628; cv=none;
        d=google.com; s=arc-20240605;
        b=C3d/9NyAeuvJTDPoxK4d1fJECn4WFWXCs9KR4fauCv9vyJMgjFV0GfJKW1Z1wW/CEH
         13K2M8Wd+0f0M+qf6KEdD0yheFEo0StSlTuC/PrEFcVWd8lVn44RjbXXuE6Vo1sbjwW1
         Enl+DFI2esTmnWwfBmU2gQ5gJoe8QM0AphVTAVIqut2nK/LCQsMyAnaPkVdg/TYpcYnk
         1xCm4YF9Qi6t3fx03QrV8IiF2ELucJbX33KDnNk4DwYu63loiqafHY5rUwcSOKl30m0n
         jcEeGm5x9qfBU6NheGnPvx+efv7WHeJowcjUhOPeUdzpG/oO7qRyh4FFuXiYlMB0eAth
         26Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0udLKwql0iZ1SIidaCEnZjm9GhWInp/dfA55RalANy8=;
        fh=iRBw5o/LmEyhp7ENCf8lPa4QUTRBa+2ET1nYrYHYgFs=;
        b=M9KLUbtUanei6u9NZLDDkwEUourU3HsV4bTpi7FxorU6hMcU4iR/xlijb31N8LoFgl
         PZm7ov5B6zisYnGNcSr9vc0Q7dNLAf/FUgPtfrRrLr7slQMbPiuGPBcCyhZTzA8uMEXt
         LO8XshSrWdwOw1HcWd6Yr6G2nJzwbYT94jyMO/6ODbUMbh+9t+r2QILhPbU1v0OjGIY7
         5LqCvqRGZED3oLlUVKc24OHdziSvcDXfqNHPOBub+8fcwIjY50c/qXvVbrG7BOYefy9S
         IkbwA7hqjaiWrofxQu+y5MpKqfscZRTf6b/CxY9BizU2iMdzLg4KcL586ZiSGhsKXRK2
         vhiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769129628; x=1769734428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0udLKwql0iZ1SIidaCEnZjm9GhWInp/dfA55RalANy8=;
        b=Mn0kQ2YSe+Cnxf4NF5MddlWv1GorlD3WUAVEN2eT8o9DjsAFWLEMladCbDtKpMkKjE
         aXe2OOaOlK6H3G/vdqmWwevrjzgZmsYyUQXIamHW+xtMFt5R14gBOdOOokd4OTL0gbL4
         pDf2/+tKC8LDVU8IlVPRf/IWMAx+HMqLPn5QkUXXwtOYn0PWh4MRL2P8wzINscIwjweK
         SZg8cOBhXa2UTCkXgsgzZEtKy8H9EZF4oGUaTxlrsguWlMyscc8U8lzuybAKr6weNLiK
         WaufEs8h9KlAlopbrv/wGvltSd/MwK4ICnIw96tP3NQeEAzfkQKI5KC3aHk9qDAu4K//
         QNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769129628; x=1769734428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0udLKwql0iZ1SIidaCEnZjm9GhWInp/dfA55RalANy8=;
        b=iJSY5lLCsmvHdG4B9aI/YLtKGdR7nr4kELNYI3jEhdU0qBC+hkkC1Vi14O013R4yBG
         t/QB5D+YGlp0iYA2VWI1w/OfMX68Yo0maN7fMq8Y4DWYqBBnjmgb6WJKEiJ1j4MQrPEb
         FQ/xUtpBn+NvT7xcsMrj3TCh+S6cUUkPmtqeoMtci9aHUYc67wddzdc+tX3JQ356Dvhz
         2RdSR2StQrUY+/uGLbeT108ygEax6i8ekYMmodqX3cYtJd4kWTZLkroVAir73NOPqEyC
         bdLuHwNayEG2eRGriDAU/bvDpy70hKEOfAChWRsnFUhKqur8QDQU1PXWpkeFmLkildwt
         u+UA==
X-Forwarded-Encrypted: i=1; AJvYcCUIgP3YBTc5rJklQv/IeSBDeVmSPNjjWQSWo4R57pTcSFA/iafNdfrRmY3HLdhn3eQO8IHRlV3334g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHqpc5xIn92/dd80wCIlIUbJX/1IvCbLrVJat/T2Mxec1XA/LS
	aPyAfpHtjzel7HyvUe5814ueJFqnFe5pga/+lHfSv8wgFxlgCtW+Uv+EwOPdGXLzLqCGARL8tPo
	gwuQYjDSEi4kJdqmIIv0Jfa4uutwwX3k=
X-Gm-Gg: AZuq6aJptakaMB8UIZrrPBJ7nAwj+OE4tKM5z4kvLEaIs3+dwgvoMrAkSPgf1QagLqo
	C68dEKPxxHdiglLiiYyRGNwYSHB3LTVKnsZCRMFgw85BBOTzrCFm7rQ50tS+jBuaTMkShSOCHeI
	EXyY4hHwIqKovShIRzr5Ms1VHLAU1kNi+6nWZcUtgRQT2Qew6hlNSy02bknVuIH36imeoYAfEK/
	TMei5PZmD0BqoJYuYigwr7gzkYT5hQpqg/kocIGE4HBTE2wj7VC5paDJtBr3YrZweNxI97YtDif
	1mJ7y4OfSNs=
X-Received: by 2002:a17:903:f8e:b0:2a7:9163:8e60 with SMTP id
 d9443c01a7336-2a7fe80fddfmr9079865ad.23.1769129627880; Thu, 22 Jan 2026
 16:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120152424.40766-1-leon.hwang@linux.dev> <20260120152424.40766-3-leon.hwang@linux.dev>
In-Reply-To: <20260120152424.40766-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 Jan 2026 16:53:34 -0800
X-Gm-Features: AZwV_QhVQ3_tmlZbyi2JgIuf-ozS36BC6ziWbq4VPwpzBkySzzimkp-0gd_aROE
Message-ID: <CAEf4BzYuZsFC-DPhhzLcyFTahucHP59+6kAc0sooY2g+SqgrEA@mail.gmail.com>
Subject: Re: [RESEND PATCH bpf-next v6 2/9] libbpf: Add support for extended
 bpf syscall
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5721-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 05DCA6EDBF
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 7:26=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
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
>   Check whether current kernel supports the BPF syscall common attributes=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 32 ++++++++++++++++++++++++++++++++
>  tools/lib/bpf/features.c        |  8 ++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  3 files changed, 43 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 21b57a629916..ed9c6eaeb656 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -69,6 +69,38 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> +                             unsigned int size,
> +                             struct bpf_common_attr *attr_common,
> +                             unsigned int size_common)
> +{
> +       cmd =3D attr_common ? (cmd | BPF_COMMON_ATTRS) : (cmd & ~BPF_COMM=
ON_ATTRS);
> +       return syscall(__NR_bpf, cmd, attr, size, attr_common, size_commo=
n);
> +}
> +
> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
> +                                unsigned int size,
> +                                struct bpf_common_attr *attr_common,
> +                                unsigned int size_common)
> +{
> +       int fd;
> +
> +       fd =3D sys_bpf_ext(cmd, attr, size, attr_common, size_common);
> +       return ensure_good_fd(fd);
> +}
> +
> +int probe_sys_bpf_ext(void)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       union bpf_attr attr;
> +
> +       memset(&attr, 0, attr_sz);
> +       /* This syscall() will return error always. */

I'll cite myself from the last review:

> But fd should really not be >=3D 0, and if it is -- it's some problem,
> so I'd return an error in that case to keep us aware, which is why I'm
> saying I'd just return inside if (fd >=3D 0) { }

I didn't say let's just ignore syscall return with (void) cast and
happily check errno no matter what, did I? Drop the comment, and
handle fd >=3D 0 case explicitly, please.

pw-bot: cr

> +       (void) syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr,=
 attr_sz, NULL,
> +                      sizeof(struct bpf_common_attr));
> +       return errno =3D=3D EFAULT;
> +}
> +
>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b842b83e2480..e0d646a9e233 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -506,6 +506,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +static int probe_bpf_syscall_common_attrs(int token_fd)
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
> +       [FEAT_BPF_SYSCALL_COMMON_ATTRS] =3D {
> +               "BPF syscall common attributes support", probe_bpf_syscal=
l_common_attrs,
> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index fc59b21b51b5..aa16be869c4f 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -392,6 +392,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports BPF syscall common attributes */
> +       FEAT_BPF_SYSCALL_COMMON_ATTRS,
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

