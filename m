Return-Path: <linux-api+bounces-5810-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EmFJF8lhWlV9AMAu9opvQ
	(envelope-from <linux-api+bounces-5810-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 06 Feb 2026 00:18:55 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D8F84F6
	for <lists+linux-api@lfdr.de>; Fri, 06 Feb 2026 00:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDBF302261E
	for <lists+linux-api@lfdr.de>; Thu,  5 Feb 2026 23:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90A833C50F;
	Thu,  5 Feb 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsFEC+5x"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E6333BBCD
	for <linux-api@vger.kernel.org>; Thu,  5 Feb 2026 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333494; cv=pass; b=J7+CmXoZZQ++hMamnNwKGPWJ/EN5/Lk/cljebvHPSNYQWBQMcQL1/ddg9Fexvnl8STNeWIc+r3lx59Yfs5BieV8DC6efRLJM27QHcIoY4u4bZG0I52UGJqU+K7wWHEZjafnpqMGawG7/YXv0tNDksfd3FHKJRZc5shQVsXUosPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333494; c=relaxed/simple;
	bh=3DMdSbOnTDuQkq267j9yDrVRURkKzUdqV8Rm0kiBb5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxgKfac34ai3M68O2OjHT1itn9jSAkeT8q0tNgUXMCm/maYsX8mDu9ztDtJE82cY2zHpw9j2Qmd/YkaWdc45p49Y1QErq+5zedlSj0euunyGkeNm/0FInVHKqn8dnB32o/8hy3fxI2mO82soBSaI0ZmtkY9UIMXy0AjmrUbkAoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsFEC+5x; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43628a01c32so65451f8f.0
        for <linux-api@vger.kernel.org>; Thu, 05 Feb 2026 15:18:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770333492; cv=none;
        d=google.com; s=arc-20240605;
        b=luv7j9zzjbCnR3zubJYILmkRzQMoA5B+Vqti4OknNQ2e4NfXlDXjm5eiJdCxv2Ec94
         P8sRbdv26szk0CZLiFfRDHfTSLoE/5YPDoUqWBHXwzH9LiWs7mtMJBoef+DVGTQ/73Jo
         oOzTNZ7WerW3o4XTwUvnIru17TwnZRqEGVAoA0YLeeYq+0r87ddZEbINDpDkqSd0i0qq
         71Lvpz9wz0i8MF+9bRmUxjhXsDmMDqSJlmx49s6TIdPzOLbw/CkgGS1zx5l2qET3ymQp
         0DyLe3xEBF1ELN0i+/Q9gL3h9DfzECFSHcAprZoSbbZBrloaaXHaVD1SYYj3I1hAA014
         g6YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+gVxik1Rd2HR9YOH7lBv/JwMwx8oMND3FQlaYRrhj3M=;
        fh=g/jubENlvNbUygUP7yvc9SipvHAhJ7d+dmyydNDUpvE=;
        b=QSRuJtBUSp2b+qUqLBCMfiTY7yMUjxBaLgMM6ch3qBVIcIXK+UZSEKHpVEFZjcQEnb
         W2Urulch4vKloDhyGpjlmTq2l+B3UcaHvIhJHK3j0Utcx/wOSP/OnvA2HxIHnzrr+bZF
         CzwYbeRSGhDJV3PFISiuWmntOzTyTc/4Q8srU5ljeyCScVU7iObsArSabC7KmFXKdpVC
         E5Xkjr90nW6i0+CyFGmZPWylsPFzGZQjVb6vV+ZQI/Y8F2loFBkiyABlu27e9ooC/bic
         1wKq2dv08iNexHcp5rCtESikl15oYFyzfEa3ZgMwdOG+gpHBLZieGfJ/4LLQmEQGXODJ
         3wlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770333492; x=1770938292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gVxik1Rd2HR9YOH7lBv/JwMwx8oMND3FQlaYRrhj3M=;
        b=KsFEC+5xJJ1pF6iyIreneP2yUGYbr5Zur8v5VVisrEy/PRfRqCg8Ov3FW/+TEjTr8o
         n1REryVfGIVanWoMukYiheyROgDhgCAgIyZfMlm7VDEN/yle6NhEVOEDE57kZffAxesC
         Om4gDAdHZ4bQKl+1AldcE4txCGAVoLrUOtNiWfZe05f+maskeO/svj51iRXy2wmnpP+L
         okCu1ynLqxC6TC9ZZT+SJa8UWFE9i8N+HOSntnvNnZFiAuxlH7UGiia+HJkT8TMXQlHJ
         Abgt4TgzhHGrQmrckg0ZYgrzx6jRVg4W+luCL/CQfxJSb42ImyCohYhWZc0GOaWI5DYn
         WvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333492; x=1770938292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+gVxik1Rd2HR9YOH7lBv/JwMwx8oMND3FQlaYRrhj3M=;
        b=MXskkPL4Lnivn1qyIg4N+iZxZdBvtj/B2X6wkepvH7YZ+eWtB+09+baWXzokA+LKX+
         j/2Zf1Pet+CPLGpGo/C7lYVqqLB1jqHUlmXbxoQj714iKed5tEQKh9MrYPCRupEdCYi1
         v53i4AZ1uWX4laVxTHu4O4Qewb6Q94MD0GxGu7eXGGcHamGbUcoHS63dGX7fDppUFy+G
         JTUcXcfAhuV3MUjgMCGyuBf+G7hamDOEkLkakWfnWdEH7/TH/nqSYUpQoV0nZ2lF5XrE
         GJPgfbDyQCmNvilFt5008ayjh9R+xJjBOYO9lnhXyZ8Z7U2YIL12ZkQ7woLtKTkjuJlr
         HysA==
X-Forwarded-Encrypted: i=1; AJvYcCXo64tfuRQBj4oI6tEKi5x+rB96AlTwFn8V+nw8FoE2BmoLfPMpRwPt5/D1So9iJCLwZ5XANOb7foc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF5HJtBXPiLt/+kZ4KkkAJZX079PP17DxH65pb5MCdaD1gOEBo
	wAe2gSQXendX5GsAOPh+ZfRbvAx4iCawPujaFsojWwj8XLdTnRUQGyxLfTFq7en18aX/128cBvL
	sqt0WaH0cN/10Wl/s+NcsQERZMwN3ZSo=
X-Gm-Gg: AZuq6aIjpft830CEAiL/u0h/H5HUCi8te2A4GXBDOsutADwVVPcaDooTW+Ao4zGSYCV
	SlfPOCHYiEVyYf2VDT3y1T7VFCec8E52W3BmIZHyGd1bCV+9ZqRYTNw70ZzqWayt+k2ltRL0vN1
	8arV6W8zkU9qiyBcJ+a246AX+u/zGWmtbjF3rb8UW7jyuv1ZHBHYdUF+cCVBUNJ5NruoQPMEa2V
	M0xvaRyw/HOmXkD3f+0yz1TR3OU8qy6fxtpUSRnkap1BcogVJboJ7JwqfU49W3zkD6s60+TnuML
	rAzDFLGl28v+cKIDTe8uOzgpbTXIcD7CX/lJbA4rJIpuWM0VrnrCrCaTh9FoxvrmojE7B9h8Mp9
	Fks2wzxucdIFQaA==
X-Received: by 2002:a05:6000:25c5:b0:435:a160:4480 with SMTP id
 ffacd0b85a97d-436293b3972mr1289485f8f.29.1770333492352; Thu, 05 Feb 2026
 15:18:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-10-leon.hwang@linux.dev>
 <CAADnVQLXWQ8Miq2WBoXRDsEVP1QPwk=a5=Rj_uPN+9qKHZZmZw@mail.gmail.com> <11bb515b-35fd-44f3-9647-9c39580ce6a1@linux.dev>
In-Reply-To: <11bb515b-35fd-44f3-9647-9c39580ce6a1@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 5 Feb 2026 15:18:01 -0800
X-Gm-Features: AZwV_QglFJ6RG-mGREyP1kc1aziDJK4mQg7BQEXe8BuO6fsVJnqTfOcc_yniLk8
Message-ID: <CAADnVQKYwi2bNc8Hsg-r9dF0ACYYEzRyZDc33G2Kr_o0bu3bow@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 9/9] selftests/bpf: Add tests to verify map
 create failure log
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
	TAGGED_FROM(0.00)[bounces-5810-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2A6D8F84F6
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 7:54=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 5/2/26 04:14, Alexei Starovoitov wrote:
> > On Mon, Feb 2, 2026 at 6:43=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >> +
> >> +#define BPF_LOG_FIXED  8
> >> +
> >> +static void test_map_create(enum bpf_map_type map_type, const char *m=
ap_name,
> >> +                           struct bpf_map_create_opts *opts, const ch=
ar *exp_msg)
> >> +{
> >> +       const int key_size =3D 4, value_size =3D 4, max_entries =3D 1;
> >> +       char log_buf[128];
> >> +       int fd;
> >> +       LIBBPF_OPTS(bpf_log_opts, log_opts);
> >> +
> >> +       log_buf[0] =3D '\0';
> >> +       log_opts.log_buf =3D log_buf;
> >> +       log_opts.log_size =3D sizeof(log_buf);
> >> +       log_opts.log_level =3D BPF_LOG_FIXED;
> >
> > Why? Which part of the test needs the log with this flag?
>
> BPF_LOG_FIXED looks odd here.
>
> This test sets 'log_level =3D BPF_LOG_FIXED' to match the behavior of
> bpf_vlog_init() as initialized by bpf_log_attr_create_vlog() in
> patch #7. BPF_LOG_FIXED is intended to be the default log_level
> there.

I don't think you answered my question.
bpf_vlog_init() is using whatever log_level user space provided.
Why do you pass BPF_LOG_FIXED ?

