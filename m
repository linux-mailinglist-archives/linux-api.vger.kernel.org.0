Return-Path: <linux-api+bounces-5653-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A25D38942
	for <lists+linux-api@lfdr.de>; Fri, 16 Jan 2026 23:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACB2230184E6
	for <lists+linux-api@lfdr.de>; Fri, 16 Jan 2026 22:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C28930CD8F;
	Fri, 16 Jan 2026 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvgtbezV"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9D6288530
	for <linux-api@vger.kernel.org>; Fri, 16 Jan 2026 22:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602804; cv=pass; b=YJ9Azyqkm7kNijtrxbTcB7ayXfx3RmuiKjmLXTrxuqrgbOQcTY2HuhIcOhYymRYakh3+Vl1Pmqp9CZ/qlUmcQ9QC8jWi+IivkuIaFDW+ZoHLhUal6yp6uSB7bFKprI0jIKWWK2zhgmCwU9fE4rWWSwKVt7vJ+93WsPGM9J3XZzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602804; c=relaxed/simple;
	bh=r2Ojrj82J3XVjXm3G7LTsWFZ5Lta8bV48jzrvi4whCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OsXIJhonSxVQ+gQ4QnaC/WItNJfdko3cCChYpvnF2IOFzn0rqZUm1i/rWA/gbXo9dmt0JfXOKrh/htOfG5zVKOtnxSp8qzjfLOQjjXDKewoygrSKXyMbki5xhC5nPK1B8grZZAIr6XM9WReaUE17oJPPl4pj7onHVGgBR+7jl/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvgtbezV; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34f634dbfd6so1879891a91.2
        for <linux-api@vger.kernel.org>; Fri, 16 Jan 2026 14:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768602802; cv=none;
        d=google.com; s=arc-20240605;
        b=Lsx7GLq7GIoYmKE8SOA4feEh3QCgVixybs7d9Uf4p2rnxzgXZmcwZIUjYudbFD0D2k
         w+uIi6fkzXLVX6Xz964TNG8CAWuXNWKsJ7VeBJ5YvEOz0q0fHa2e67gLYiTTrqrUvnWQ
         Od0/IqtSZLgTpgeuxje9Q3LO+D8M7uHqU3QDQVtZ6qWcBtBw18Ni5G9tquVh8wV4dQuz
         uHzg+OfXn9OisRyg16Z7AuSXi3Yocvr534zxl8Xh3GpOlBLj20WWf/Z3HDBDVxfBVZ40
         b9Z/XYDdddtjaOp/Rn0fLrLUAsBu+ZHNNQDqo7N1pc7ILKhrsHceOxt14/KWydkQ1wDW
         HpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iJboOYL8nb5HKiKwIawaFZDgZ5gKyvu1KidzfHjD1h0=;
        fh=4Svipfp+KrahJz7EIIW3ZHL1pFUVf+ARSLZvbbOO3C4=;
        b=ledWeBvz2jh6Oh7+FK118gv3BPiXRWRnMY8IegzTvuSaaMKgAfHaAh/pEYygEHwgAm
         u3NVDtkFpSH8j59WXsmQkLPbzvfx/EJViZgXPZZaY3Ak/JkvZjHDfFTFdjHD3gQyZqwi
         +VyXjRCBrFHxDiOqg40C80WSzvxdBQrqEuvt65xUX1ip0JhnIkNqPyg+AEZcSFSFdxuL
         BcP+TZC6zUD6Rayl5Sb6DVoZtyTJA7NLB99LCOCRcYLR/16hQ9UcUx8qGj+ayiuWF1yP
         4z9BPaBYRyMZ8EPe7H7l5bNIUIsThA7j8ZYMHJbCRoRFDmUPTPAR7OXCT7BXqJYj/p0o
         IbMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602802; x=1769207602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJboOYL8nb5HKiKwIawaFZDgZ5gKyvu1KidzfHjD1h0=;
        b=hvgtbezVtlQA0URQHDFyOg+qTQu7OU6JUWASAux5rOegh1nYYf1b4IYdyRvaR3Ho0Y
         cqKAyCzll4p2x7HsZl0T++r3v/wsuF8snGY6508L892u+w5T+hfrIfJMjHmlCTBQlVRQ
         CulD527pKPi2+zceUGP5c7KnIfxDFCGkD7aEKpQY4aoZKoHMX+o39zZ1S9famOCcQqVE
         4QRxScx57EjErQcxo2Qlhs3c2S0p9BqQCUZ4iMNkTy2TKCG59keCErT/y+lgvi0u9ET2
         TGSuJWamoMB5/hI0fwSjkB/Bx0Q0sG1yYn/QWhZX5ZVHmIG7GJQN5O4i7UrAjXh2GJCi
         E8xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602802; x=1769207602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iJboOYL8nb5HKiKwIawaFZDgZ5gKyvu1KidzfHjD1h0=;
        b=N8mpDfMTfFhDMboMy3+TlloP5JZbJhLBckF6HByc3nwCAq2oQaSYn6/MbvxnqrKRWx
         b7s85zb3To4lS5sykrOHbJB5O/lcNTsTruKcmhfIvtVU/g5FG1Neh+gUWGp5g+GeGO1+
         Ba1RKLrl/9o3Cb+lnzBdrmYvPVcbRI3woomiPrmWpv7sn004yBKuEl+EJEn7f4gmJr03
         1Y/1kfNoCdVfXVaed5vj0qOCejzH2mHQhsHOF1odeALcF4M0jxxaFvN4t/g51onQAUYp
         oCPmD806+/Dsi5l32blEgWC5PdFpu8x6awftc9NHNIaM33gWUEKRgicz3q3j38Cs1i+r
         8Aig==
X-Forwarded-Encrypted: i=1; AJvYcCXOUNVAh0oAtL5PsKdLxgkw8tDVzhRonFvxM1APiXdFkWKiQODEUdzovwjx/16neRFok/YuLE2gyKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+abS30igVnUtKYhXlFFyLoS4TzSVk9UZWdBuDY2OhpX+Ukbds
	b/KUD5jAtwRGdntcz7AA6mLvpTYdRtKfKzfr+Eyvfsk25nQjbbQe6Ql2sVIGGYQ+gxezOzhATMa
	HjKg0X2qKUAKXJuHcBLEKSxssXcWDb/w=
X-Gm-Gg: AY/fxX7YieJkcBs9TuXQZxxdKzpLITG6IKZ8diT3sSEkEpSlal6oaEVcLQ50rHiE9bI
	dDqY+s/U6EY52wCG8Mm9B/DzNtrqPDXIdVHfeVrgbnMT9uA8nmYCAe5I3ImNRpDsH62zQTcmhtY
	wDiBOZlMclO9vF1Q+pxjnV17GIn6RUINCWW9+yuAkpj2Hur0PjrW6RkGjqMrz6jgtTJAErjhE3a
	C5mBFDKf5aXCA7TokiYuuFUbjdTcXNihZaTY6bIUQkml89O8a3Ks4otTD4/rYldpwiDjlKyGDRV
	QKWih0Lglcg=
X-Received: by 2002:a17:90a:d00b:b0:34f:62e7:4cfd with SMTP id
 98e67ed59e1d1-35272f8800emr3821863a91.24.1768602802018; Fri, 16 Jan 2026
 14:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-9-leon.hwang@linux.dev>
 <CAEf4BzarSrW1aTRcjrheLWqxFCh1FFd7vwJ4OQup1dbT13EapQ@mail.gmail.com> <22e0de9a-8963-454b-8b35-f8c9be15dee3@linux.dev>
In-Reply-To: <22e0de9a-8963-454b-8b35-f8c9be15dee3@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:33:09 -0800
X-Gm-Features: AZwV_Qj5-qhQEeblkq6zDE7vf09okjNAQE4EuJYtKd-cqp--OSf-P39pgeg23DY
Message-ID: <CAEf4Bza7d8sdo2Y-D0U5BQos6Z2C6i-4f4B4oe8sApfua0uNAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 8/9] libbpf: Add common attr support for map_create
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

On Fri, Jan 16, 2026 at 6:17=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2026/1/16 09:03, Andrii Nakryiko wrote:
> > On Mon, Jan 12, 2026 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> With the previous commit adding common attribute support for
> >> BPF_MAP_CREATE, users can now retrieve detailed error messages when ma=
p
> >> creation fails via the log_buf field.
> >>
> >> Introduce struct bpf_syscall_common_attr_opts with the following field=
s:
> >> log_buf, log_size, log_level, and log_true_size.
> >>
> >> Extend bpf_map_create_opts with a new field common_attr_opts, allowing
> >> users to capture and inspect log messages on map creation failures.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  tools/lib/bpf/bpf.c | 15 ++++++++++++++-
> >>  tools/lib/bpf/bpf.h | 17 ++++++++++++++++-
> >>  2 files changed, 30 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> >> index d44e667aaf02..d65df1b7b2be 100644
> >> --- a/tools/lib/bpf/bpf.c
> >> +++ b/tools/lib/bpf/bpf.c
> >> @@ -207,6 +207,9 @@ int bpf_map_create(enum bpf_map_type map_type,
> >>                    const struct bpf_map_create_opts *opts)
> >>  {
> >>         const size_t attr_sz =3D offsetofend(union bpf_attr, excl_prog=
_hash_size);
> >> +       const size_t common_attr_sz =3D sizeof(struct bpf_common_attr)=
;
> >> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
> >> +       struct bpf_common_attr common_attr;
> >>         union bpf_attr attr;
> >>         int fd;
> >>
> >> @@ -240,7 +243,17 @@ int bpf_map_create(enum bpf_map_type map_type,
> >>         attr.excl_prog_hash =3D ptr_to_u64(OPTS_GET(opts, excl_prog_ha=
sh, NULL));
> >>         attr.excl_prog_hash_size =3D OPTS_GET(opts, excl_prog_hash_siz=
e, 0);
> >>
> >> -       fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> >> +       common_attr_opts =3D OPTS_GET(opts, common_attr_opts, NULL);
> >> +       if (common_attr_opts && feat_supported(NULL, FEAT_EXTENDED_SYS=
CALL)) {
> >> +               memset(&common_attr, 0, common_attr_sz);
> >> +               common_attr.log_buf =3D ptr_to_u64(OPTS_GET(common_att=
r_opts, log_buf, NULL));
> >> +               common_attr.log_size =3D OPTS_GET(common_attr_opts, lo=
g_size, 0);
> >> +               common_attr.log_level =3D OPTS_GET(common_attr_opts, l=
og_level, 0);
> >> +               fd =3D sys_bpf_ext_fd(BPF_MAP_CREATE, &attr, attr_sz, =
&common_attr, common_attr_sz);
> >> +               OPTS_SET(common_attr_opts, log_true_size, common_attr.=
log_true_size);
> >> +       } else {
> >> +               fd =3D sys_bpf_fd(BPF_MAP_CREATE, &attr, attr_sz);
> >
> > OPTS_SET(log_true_size) to zero here, maybe?
> >
>
> Unnecessary, but ok to do it.
>
> >> +       }
> >>         return libbpf_err_errno(fd);
> >>  }
> >>
> >> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> >> index 2c8e88ddb674..c4a26e6b71ea 100644
> >> --- a/tools/lib/bpf/bpf.h
> >> +++ b/tools/lib/bpf/bpf.h
> >> @@ -37,6 +37,18 @@ extern "C" {
> >>
> >>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
> >>
> >> +struct bpf_syscall_common_attr_opts {
> >> +       size_t sz; /* size of this struct for forward/backward compati=
bility */
> >> +
> >> +       char *log_buf;
> >> +       __u32 log_size;
> >> +       __u32 log_level;
> >> +       __u32 log_true_size;
> >> +
> >> +       size_t :0;
> >> +};
> >> +#define bpf_syscall_common_attr_opts__last_field log_true_size
> >
> > see below, let's drop this struct and just add these 4 fields directly
> > to bpf_map_create_opts
> >
> >> +
> >>  struct bpf_map_create_opts {
> >>         size_t sz; /* size of this struct for forward/backward compati=
bility */
> >>
> >> @@ -57,9 +69,12 @@ struct bpf_map_create_opts {
> >>
> >>         const void *excl_prog_hash;
> >>         __u32 excl_prog_hash_size;
> >> +
> >> +       struct bpf_syscall_common_attr_opts *common_attr_opts;
> >
> > maybe let's just add those log_xxx fields here directly? This whole
> > extra bpf_syscall_common_attr_opts pointer and struct seems like a
> > cumbersome API.
> >
>
> Oops... This struct was suggested by the v3 discussion [1].
>
> This struct was used to report 'log_true_size' without changing
> 'bpf_map_create()' API.
>

Ah, I already forgot. log_true_size being an output parameter here...
Sigh. I don't like the verboseness of bpf_syscall_common_attr_opts and
"common_attr_opts" and all that stuff...

What if we make it struct bpf_log_opts {} and keep it log-specific?

> Links
> [1]
> https://lore.kernel.org/bpf/CAEf4Bzaw9cboFSf1OXmD84S7pKaeyj=3DbcQg_diUzGw=
AkFsjUgg@mail.gmail.com/
>
> Thanks,
> Leon
>
> >> +
> >>         size_t :0;
> >>  };
> >> -#define bpf_map_create_opts__last_field excl_prog_hash_size
> >> +#define bpf_map_create_opts__last_field common_attr_opts
> >>
> >>  LIBBPF_API int bpf_map_create(enum bpf_map_type map_type,
> >>                               const char *map_name,
> >> --
> >> 2.52.0
> >>
>

