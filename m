Return-Path: <linux-api+bounces-5770-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOFSIqcneGl7oQEAu9opvQ
	(envelope-from <linux-api+bounces-5770-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 27 Jan 2026 03:49:11 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8968F33F
	for <lists+linux-api@lfdr.de>; Tue, 27 Jan 2026 03:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA71F303817F
	for <lists+linux-api@lfdr.de>; Tue, 27 Jan 2026 02:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB1D2DE709;
	Tue, 27 Jan 2026 02:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmYFXohr"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937BC2DB78C
	for <linux-api@vger.kernel.org>; Tue, 27 Jan 2026 02:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481828; cv=pass; b=VKxMAmSv6pJ6rNNVSdWRo/fCGt/GOMftojKviWk9ytiLA1GG6hrvN92GA2vsZs3k8YutdEGhVp6oNHRYpBuFP2LuRX6D4aNuK8bm9PeBKQQLxuUJM4XwDct6ifUmB/p7/exWKwyN5vbPXviLyKpEEHi/uUShzVj66PP8KgOiF5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481828; c=relaxed/simple;
	bh=BvbEr7o+FAIoZ+8+sAFL5GGnCQGVrASlVNUsngs9qy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqPEyGm0Nd/G9BQh0spHuFlIwe3oqE92U+Laom+s8nwNz5h48dp7vCWSkGC2nLITDf5/aNsV/1Fm8iWE7Hb98eO5u+69Sdu0oKLp2FVP9zLmxuDwEbhD+jRtNCAKp2bx4Y1Dzruu+gpxukyS0vgQ59oL1SL6d7K1QY0y3PiADgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmYFXohr; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so3482111f8f.0
        for <linux-api@vger.kernel.org>; Mon, 26 Jan 2026 18:43:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769481825; cv=none;
        d=google.com; s=arc-20240605;
        b=ZOTckQNqEfPXWKy63PM9jpdH6LIvmqrJDLpzdDIUFtp/g8B9N6UJkmw4K+9KhAgmpt
         wdeOuYTcVlAgpgNpg5MLTDLDnaOf+1NL44nbmXF5qhP0q9QIxSwgHwt4aC3UPl17L+lu
         P3CGgLLXr92c4Tw3sG54Kqq0eSd9y2HhTWxMY4ns1Yz2jWOwVxegruvt75E/e2mg0X6y
         M8YpAg/r3Td8HOsOnxzWi5FlmEh1Q20XNUn7o1FMkSqNXAy7EYjMfOEdVGqiHDgSMfJ2
         uzBzWA0FIa5lROvW+YZNHYP4nzeB1WMKmMr8lQy/VnQd8RC88GqcpxkZjTQssOelOmRH
         nQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sNWYftb3y5oZnnbsPB6EKKeLAdQS5y4v0pCFC0lgynQ=;
        fh=9usdqvJL27pCRoI6TDrbvFnz6RfwUR94+GlNgkd5xO0=;
        b=TG4XNlLXZXFxca1ME+vYtthDk16e9bDaSFRUE8FEo0nulVD3OlXU4dTb/Pt2w0Gylc
         HJJxlFPLWppw0TWNkeSkJb20FfwJ9ajEyrdF4JjNq/23VBRRcYSr2+Wm1sr4iw2krqTs
         0inJmhREaPurQez/7oW75+AQZQWmYdQwLjygYd0yoh6dKkpVKWHJWa/Xmvq+8Sx41eHr
         mPPc9Xryr0IX+4+AqQpWauToljNOiWDeiK5lHkqnTvRfebLWTAMDw44E3mhI3E9PJMn+
         XKltjN9iC9a4z9nUbHwObwyo6kqsNg3XqTO773w2CgfNiZobqqlXNVdRVzAr/vVgCly6
         z7gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769481825; x=1770086625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNWYftb3y5oZnnbsPB6EKKeLAdQS5y4v0pCFC0lgynQ=;
        b=mmYFXohrl4Wb8lb3KVBWlYEjhtkt6DQAYXgiZEeYsgQb8Q7d5KKbgZnL0b5dids1hh
         HcF6B5chDd1sgwqXinDQGS22V24TpJNDauCMwztWln3V9ad6UJD+KUaZjT9aAqrlkMd4
         OA1yQ+IBK58EAaVFs8IiR1hVqbjDU5kf+om+Udkd/CYiYuIFzTfN8BcefAfzfQmmQiJL
         vhWJjO9tQnu9sXnrCBD4GnR4dyeki0Te2Qyojyan2s9qHXmDqa4GES234LPRTLcHm6gp
         eZGdf42XjAMSa3osUk5fDNzzlZwH9mI8gAGZDagbVfSQc3faP0mJ8o33dKr6ApXMcUCu
         pYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769481825; x=1770086625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sNWYftb3y5oZnnbsPB6EKKeLAdQS5y4v0pCFC0lgynQ=;
        b=KcIFvdsQ5LqpuNMeJZZ3Q+5qx4WAJ1/PIlg9/Ivke8sMOK3R/A3vCZcV8w2BaqsZ6q
         rmzDhCLjeUZohycjdNe5bmZxRq7VcaMT/CUd6rxvVeBjviX+cJdcouNDYJFo7r2lctGJ
         LcRTR5493xvlHFtuHu791Ieo5ACAsPmT22EP7kjebeP6gHz7dCLKzphSLvwL3rPLr2gz
         KQswYaJfTTk0phdtylCqwVPS5mkNHHmpSSkB9YE3hP5xejT+bScMiT8rFp4MTDDd8G+3
         C1RsdKQWoi70c9ecpDN2QS8DiDoMzsy1hctORe8p98dx8yXXJJZ+IiqI86bjMSQyF61a
         NXnA==
X-Forwarded-Encrypted: i=1; AJvYcCWtVE9C5hi6cHACeQRN8FWVeANCmMqklHJWRpdh6nAOtzxbIh+JGN4ZP+8AlZn8hmZrqs+2mDzAk5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeSJXwk1/DoWtdcJRhoF6ie7ZwfI+Cf2ml3ri0s7Ns/RM48VTP
	u+bmBazQ+/nMhCXE98v7MF8qFGR30IehxKI8989J7Ua20svp0rR3ebGlPyMwPcus8lvmKhaxKGA
	HbSGi0U0Ed/hIv5+qxejF+znhOts5Z5w=
X-Gm-Gg: AZuq6aLRazD/UmwjyufXSbIoVgSS3hy3velTSKoZ+HkR9ZaArovfJbA6c0iR0pzD75t
	z5SEIcnm7mmZ/Ogi4TLj9I4ju5T0JygD7uQYt3B2TttggiM8SciUkLgAyx0N8TZQB+lWKe7rzj4
	HkWowlFPKcSWkXxEoGA3bQPzEpfJYGWl9Hw3mCbtOfwfkgA9sT8qdYgGChWHiVTHMgNJw/km4nJ
	4ZZB4x0EBAyWiHTpoO4FY6ytAeIBWhu62eSplEeYAFGHVD75RRVKg+8D53YgYwrQ/5jA5ILva/s
	vn9ZdCuigv7912okFKhjeZFalvhVYxptJGeaAI1PDHF4+PocBodBLvuNaKLjxvcjbYgRzPMySk8
	LrsQyezla6/Dt8A6SYmFPORsm
X-Received: by 2002:a05:6000:a8c:b0:435:bbd7:185f with SMTP id
 ffacd0b85a97d-435dd029a52mr105023f8f.9.1769481824811; Mon, 26 Jan 2026
 18:43:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126151409.52072-1-leon.hwang@linux.dev> <20260126151409.52072-5-leon.hwang@linux.dev>
In-Reply-To: <20260126151409.52072-5-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Jan 2026 18:43:33 -0800
X-Gm-Features: AZwV_Qjob0hpI61E7bKlmlYJJVAtwCwP_z812BtK6il96WSFPg5NoRPUSzKlj9k
Message-ID: <CAADnVQ+PDCV=YrFhxG3gXPC3jDPdbTmsaAOKBsFceKgEware0Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 4/9] bpf: Add syscall common attributes
 support for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
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
	Rong Tao <rongtao@cestc.cn>, LKML <linux-kernel@vger.kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5770-lists,linux-api=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C8968F33F
X-Rspamd-Action: no action

,


On Mon, Jan 26, 2026 at 7:15=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
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
> If they both have 'log_buf' but they are not same totally, return -EINVAL=
.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf_verifier.h |  4 +++-
>  kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
>  kernel/bpf/syscall.c         |  9 ++++++---
>  3 files changed, 35 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4a0c5ef296b9..7eb024e83d2d 100644
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
> index 457b724c4176..c0b816e84384 100644
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
> +       const struct bpf_common_attr *common =3D attrs_common ? attrs_com=
mon->attr : NULL;
> +

It seems the only point of struct bpf_attrs is to pass the attrs
here and remember them in bpf_log_attr.
It looks unnecessary. Also the cast to void and back to actual
type doesn't look pretty.
It seems all of it is to do two copy_to_bpfptr_offset() of log_true_size
in different places,
but libbpf will use only one, so let's do only one
copy_to_bpfptr_offset() and simply the whole thing.
struct bpf_log_attr only needs
  u32 offsetof_true_size;
  bpfptr_t uattr;

No need to introduce bpf_attrs and bpf_attrs_init() either.
When bpf_log_attr is inited make the choice of uattr and offset.
uattr will point at either new bpf_common_attr or old bpf_attr,
and offsetof_true_size will have 3 possible offsets.

pw-bot: cr

