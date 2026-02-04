Return-Path: <linux-api+bounces-5800-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPq6Juuig2kLqQMAu9opvQ
	(envelope-from <linux-api+bounces-5800-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:50:03 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFD5EC3EA
	for <lists+linux-api@lfdr.de>; Wed, 04 Feb 2026 20:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7FB143028651
	for <lists+linux-api@lfdr.de>; Wed,  4 Feb 2026 19:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1417D3D5233;
	Wed,  4 Feb 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+DkgA+a"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96503AEF52
	for <linux-api@vger.kernel.org>; Wed,  4 Feb 2026 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770234541; cv=pass; b=SC8X82ANHCh7Bi/Ak0rAksh+QpALHou083+Jnk96DXyrkmsKSL0fkvgTK6xd7NGdT9gEJlubiMgwYNAyQjWRdXiAAv/0kxHzK8Y6Zpgl2mzBoPFAIhN2vEeOashRkV0VixrxpAGciYueUHIPtgiyC12OiblAECaL5sxGgTaNHOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770234541; c=relaxed/simple;
	bh=B3y43fdvkCJvjh5Z6KJwL8Qv+EAMqv2LGtVQzZKKa94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ALVIXZggnh0cfuoBBJE5qU207soKu4yJHHtIHARS1C8Gb4Ob6CpeljYRwNheoea4eP04q6V6qUM3q/KzHPaZVQ+CFx7ZxdeNVVz3DDTdAQt8bNiOrZeYLuNsdVNiDM1viti3TEsh/j7Mn6v+NDjLsMwADyF1RIwrZ6F2ZTt6CwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+DkgA+a; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so55311a12.0
        for <linux-api@vger.kernel.org>; Wed, 04 Feb 2026 11:49:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770234540; cv=none;
        d=google.com; s=arc-20240605;
        b=eV+Jej+iPmwg4oI+VizgxKxr/H/Agl/fPUq9eEC7YZcyrK2wot3DrFvjMBu4+67C0S
         QIDvn4P6J1hz3qYFwVXI+SpLCfqJ6cgSPumRoIwG7a964I2cMwwc3vnk6LDrz428CpRB
         oIOp6Sm8OXVnl58Ix/L0f5Zm9I/0W5Sq/5oh6ohDUNlly9e/xjDL6b9xI0KnsOM3GXtJ
         JbLZDY+u6CoeG8U6Ly0GfLhx7qLRshqkDjb3dB0FlG6PbxRDyBeqZi9ltcg0+LF4wLBw
         rqrZGaAMriR9+R5vlOh2Sl3rZNm1/rp+oh6Hj0TDwJHeZLwyM/5pB4bhNkBAFkYNI6aC
         oy6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ou3bUaOU6pyPsxirJGD47BajZ+kCq3l+P77vnFSOEKM=;
        fh=8p5TDhboTjWeFebQou1sxtDIYmdb09XlZnLbTdnJm1k=;
        b=ZCK47Dczx6NwoQRyBgeKvvgoHVc4TqXyk8VPNWcASvh2bKFo5ZK7eStrRFuzumCX6w
         tKWI8uSnaDwqylk8XO9w3pXEcNybvSoDjxgS5VCJ6DKp2+McmPyAjFVj0JYhGcfeSxAQ
         ozSaXGQHzikAvus8g8ebuCSt31KXV3UOphKdxlwDf+h81U4FuybjM2MJg7fmft/gm0FA
         a4CO/l5kAu55WotLDu8oOjYBe+UWycOTHBilaTTEiWJasov33TNlYEBrRAaxrs/T/FNB
         +TxbeSR1IWqfU0zomVLOQjD90ER72EANQAZyemS0XRYIY7+UrEsYu5Onq+QfTwjejz/H
         QHxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770234540; x=1770839340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ou3bUaOU6pyPsxirJGD47BajZ+kCq3l+P77vnFSOEKM=;
        b=Y+DkgA+aINdjpTwfL4D9odDSkqgXwawF9kQcOARx3c9RvxscRiza7UdtNemb3S0W0x
         IOcShVmT3D+XKC8GwvNRBTojGU4xDupCX6Om5xv0NRME6GBsoft7/eA/eApWZV85xDjm
         8SRFX2NIkeDb0BhHskW/XbrGTcs04Xl3Kl97RXd3kkWhtRITGXQx0lxhB5VhOhIQYOtm
         I+Bp312iaQwUFUgYkHiiBlCmhbnr+6HZlbn70t0DnJ7NTZDHXecb3RMyM2AccrxLatVq
         TvKUv+4WU4a0VFlxqQl9tbRCRgxRaEv95LI4tsLdjHjpKr1+zp0y+AjUbfrVXoldvWZi
         75iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770234540; x=1770839340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ou3bUaOU6pyPsxirJGD47BajZ+kCq3l+P77vnFSOEKM=;
        b=SU/oO/BCVArPW/40BRyvrZP0mYVz7I0zXwG0xiXOl8JlFzMQixPT2kQRXcUYjKhI5R
         i9R1xrt97F/AMeFMoBYzD9UV3RcyC7Vz3P9A6m5FQbOKqtiTfkGr5L1uv3e7C7XVdYoU
         s1TeiCv/oeKArcIOBZ/bDi/mYqA+qw+9Dg1q4CJOap0aQTGlOQasO3hOon0+KJ0My3DT
         dY2C8FAAjAONPPe2njrIR272xSvUGqrnfMqgGPti5aaUy8hKm+2/w3fnjoyiM+uboJ1c
         bkWYWjOHEQ+BdKUs3GYfRXsCDnX1IFgW7Sa7CcMXgEhrKujz+tgpW8dn8f10UPJp84Y7
         a8cA==
X-Forwarded-Encrypted: i=1; AJvYcCXYasgs21h0WiLbTRkKHlsZakoiuIxC4cr4JE4c6rrryPCPjHv/DJnnAXyOTRzV7WJakhS2AKpmbmk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6i/X/jz8G4rDNMxGVMqepJ6eLsZz1D4oVxFEtmbrCwFq3pMNz
	ZDa6V710LQc5vMmZPwbhLicBR7JEJzByyVsxg0UBVhCEfB3s5zalPEtfUPa0MTQw9LyE35Cv0N5
	Nmo7nl+6xLCEIM0wIBDizSS0FaxK7+tM=
X-Gm-Gg: AZuq6aJMzST6fmb4VM/ayDBRtpFDcIRXRnrgTJxLBCBDEWftj1PhNyHv+Rl7zS0MxPT
	mhXrAQ8PdihM8TA/CK/FrHbElBPg6PZTdajO+ft5QdCxF0Iz1zofk5LucgvwQu9s1nDFtEVPZND
	P29pbUhdgkqqSeSDH3iCdWfzpCbAxibW5MXAFFg8gF3YnxKL6oeJ3capJzK8tJmajltLtaBpt4c
	do1wkF3OjnsJKia3+DS20nV/+n39CuTWCsCFddDar94NWIZB3LpzPH2I2sXfhPNd7JHKduWnGKE
	+C8336XeLpg=
X-Received: by 2002:a17:90b:35c8:b0:340:b86b:39c7 with SMTP id
 98e67ed59e1d1-354870e4f05mr3605002a91.11.1770234540184; Wed, 04 Feb 2026
 11:49:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-4-leon.hwang@linux.dev>
In-Reply-To: <20260202144046.30651-4-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:48:43 -0800
X-Gm-Features: AZwV_QgJ7Bm5-XV_jmFavQ2YE0pj8PhX0zAxJIGqH2A1WMmMepCAC4lZG3IYaek
Message-ID: <CAEf4Bza+n2-tq0cGvAit23OduWbqO6teF211iPnOfp0s_ZwEPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 3/9] bpf: Refactor reporting log_true_size for prog_load
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
	TAGGED_FROM(0.00)[bounces-5800-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CFD5EC3EA
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 6:42=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> The next commit will add support for reporting logs via extended common
> attributes, including 'log_true_size'.
>
> To prepare for that, refactor the 'log_true_size' reporting logic by
> introducing a new struct bpf_log_attr to encapsulate log-related behavior=
:
>
>  * bpf_prog_load_log_attr_init(): initialize the log fields, which will
>    support extended common attributes in the next commit.
>  * bpf_log_attr_finalize(): handle log finalization and write back
>    'log_true_size' to userspace.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h          |  4 +++-
>  include/linux/bpf_verifier.h | 10 ++++++++++
>  kernel/bpf/log.c             | 35 +++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c         |  8 +++++---
>  kernel/bpf/verifier.c        | 13 +++----------
>  5 files changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index cd9b96434904..d4dbcc7ad156 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2913,7 +2913,9 @@ int bpf_check_uarg_tail_zero(bpfptr_t uaddr, size_t=
 expected_size,
>                              size_t actual_size);
>
>  /* verify correctness of eBPF program */
> -int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr=
, u32 uattr_size);
> +struct bpf_log_attr;
> +int bpf_check(struct bpf_prog **fp, union bpf_attr *attr, bpfptr_t uattr=
,
> +             struct bpf_log_attr *attr_log);
>
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
>  void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth);
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 8355b585cd18..c805b85b6f7a 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -631,6 +631,16 @@ static inline bool bpf_verifier_log_needed(const str=
uct bpf_verifier_log *log)
>         return log && log->level;
>  }
>
> +struct bpf_log_attr {
> +       u32 offsetof_true_size;
> +       u32 uattr_size;
> +       bpfptr_t uattr;
> +};
> +
> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> +                               bpfptr_t uattr, u32 size);
> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log);
> +
>  #define BPF_MAX_SUBPROGS 256
>
>  struct bpf_subprog_arg_info {
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index a0c3b35de2ce..ff579fcba36f 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -863,3 +863,38 @@ void print_insn_state(struct bpf_verifier_env *env, =
const struct bpf_verifier_st
>         }
>         print_verifier_state(env, vstate, frameno, false);
>  }
> +
> +static void bpf_log_attr_init(struct bpf_log_attr *attr_log, int offseto=
f_true_size, bpfptr_t uattr,
> +                             u32 uattr_size)
> +{
> +       memset(attr_log, 0, sizeof(*attr_log));
> +       attr_log->offsetof_true_size =3D offsetof_true_size;
> +       attr_log->uattr_size =3D uattr_size;
> +       attr_log->uattr =3D uattr;
> +}
> +
> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union bpf=
_attr *attr,
> +                               bpfptr_t uattr, u32 size)
> +{
> +       bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_siz=
e), uattr, size);
> +       return 0;
> +}
> +
> +int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verifier=
_log *log)
> +{
> +       u32 log_true_size;
> +       size_t size;
> +       int err;
> +
> +       if (!log)
> +               return 0;

can this ever happen? why guard against this?

> +
> +       err =3D bpf_vlog_finalize(log, &log_true_size);
> +
> +       size =3D sizeof(log_true_size);
> +       if (attr->uattr_size >=3D attr->offsetof_true_size + size &&
> +           copy_to_bpfptr_offset(attr->uattr, attr->offsetof_true_size, =
&log_true_size, size))
> +               err =3D -EFAULT;

minor nit: return -EFAULT;

> +
> +       return err;
> +}

[...]

