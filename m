Return-Path: <linux-api+bounces-5900-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNbLIhXKp2lFjwAAu9opvQ
	(envelope-from <linux-api+bounces-5900-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 06:58:45 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C82E1FB003
	for <lists+linux-api@lfdr.de>; Wed, 04 Mar 2026 06:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 579273024520
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2026 05:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08F937F8C1;
	Wed,  4 Mar 2026 05:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epgCOWwq"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1628829408
	for <linux-api@vger.kernel.org>; Wed,  4 Mar 2026 05:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772603917; cv=pass; b=sEo+9x/YYaZX8tSdpeFI9HoskDkOr0uDWO7DWGSpkCFsRajkvS0finNMGHAWbqgJXprHprYOe4/ZzJDcgpWWsq1bEf6vL1HDcwdK00YQ7vwgmBWSxbSDMtTrMUkdcR5QDnk9ZrYIAuAxdy6gf7iWrwnUUJD5e0a0IxoPvNNX/Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772603917; c=relaxed/simple;
	bh=/NX7IFwd1F4m7lXUlgO+wNI5t2GEUHSg21WBVXnVvIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bWbPsPjxhS2GELzDgwdYA9120T1vNQOy1EL7g49sBCciszbQUv8dAlo21nqxawh6QHtz783YuMu1CaFgzJ3ErtYYNkjcVgUW5B5EERI0N7QsEBB5EzgG2psR9au7kWcwqCvZYoJJapKXNBYtCd8TorBkIuCR8NTIEm1x3rqv7G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epgCOWwq; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48372efa020so56164665e9.2
        for <linux-api@vger.kernel.org>; Tue, 03 Mar 2026 21:58:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772603913; cv=none;
        d=google.com; s=arc-20240605;
        b=EduygS/3CGnnBv2xYQsxvQcdn9HlVcMW2SdgtdJOu929YUw/gJn6eJiSYunCN8LgR0
         KTQ+4HllHZin5irLtXRSBM7omd/xi47bI/r/SUS4mQNEMjPRse3Ow/8vJvJ1SwjjZ1Tl
         r0YEGqbV7yeldC0P+D/hgG4piCpICSUv+ZdSf3NPlq7Fy1v4ee4gR0q8QBjRg6i3JYZ7
         gOZWsRvp869hva7kRnsDzJ2aGASfrLlm0HIjBrXLDR781jblimKa5TJJALveC13nm9lC
         VSqHY4fZQnk+lFA3/fxJ0XCKKjptgYu2brV7zelQ8S7vyLfpAfLmQ/Cf+zrJT/wYKA2e
         Jppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kpgMwZZuaK2KyeVm1P5Jh1Jm+p04rBkurVuB64xnmxc=;
        fh=HG1Lcx1tmvbsWQJJmzkkdimaQc+6/woXL3t6gEj9pwI=;
        b=O6F/Dau4O1ipWPrWeOKE/ugR1IY79z46CRwl7zq13VWV9PIFtH2Cff5K8sp64oviSl
         A19lmsXIu6e7Ot5j65h56AOQBYprWUMqJw54AstmaOzkBgdUR9+2pV9oADmoWiWNaolb
         4rbRi/7lpPyLWeG5+awX75sijs8xGbScVMbM1LqmM+I/qIkxn9PIs7bpu27ZRHhv0QAg
         D/1NAa5viIwm5QhwnPbxGK4LHBDLoHFd/eZmw+DED7tS7b+DGu5kDgFehf2BTd7VzOuM
         XFIKS927LENtqKNBie2+aFftU3ITnNGj6vpzBzMkiEQ9BISV3RNYkoM4+ttQaMdiknoZ
         8mEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772603913; x=1773208713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpgMwZZuaK2KyeVm1P5Jh1Jm+p04rBkurVuB64xnmxc=;
        b=epgCOWwqhn2R7s4zUDMRPFuJmIe7WFu2ukL2zRAGseATTEXH3JpQJoZ/vtd2Zs87QR
         pcWFojEEIqPQknASR7pxuKlJ7+Eob5ztflW0XneqZ0aQjrNf9rwcjeB0QUXoXEv75qm4
         ixrF1wrjkz2hEFkd6Sn5XE/vw7mSZWk408/JpqSuQtK8oyyisBD7vK4Alugs+vSALmJp
         BoolpQCNsT1FQ15PPykheT1rzlWHkHdmT1kx30TpeIzfbXkIyA3irsxcg7joaxJwocjj
         x7RL9Fteb5wFr7URfFYMuxfIr4ffWYEfsBL58Ty1otch8++JeoYsZZ7R3oNpJSSeSQdc
         wC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772603913; x=1773208713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpgMwZZuaK2KyeVm1P5Jh1Jm+p04rBkurVuB64xnmxc=;
        b=rB2M3DEIdzQEhI3Px/4gVYWSZaEfonqXXEYnlcNFnB5HIOch3Ys7oiQzwDByI+5CXL
         ka3EvQre56fwNaTQ9ce6MCXuMFu9gt3z5UEpacfkksEBLtJnt0dzYRXUDqaZ5ZLPboQ/
         9ahFEaqd5zScDVl+QpvKRkZkpaRuNBbF9gqwwdpNZy4nyCXUXMSzOsrcFEhke0ZwdeJj
         O+vuGkJjFUoWlhMH/AKD0UbDBFKZ+a6U3l7+ErxBkFHy0Cu4C2rhFaaq/3TpFTuUwnpe
         1j+foDOXvCMzFAkL0/4IKjMhsyMexEfuOuMQW5GXAKJc1qbor9JLNJ15Oied8GxW3rzY
         H2pA==
X-Forwarded-Encrypted: i=1; AJvYcCUYhUmwJGlC7vCfuffbOuiMNYB99utf+kDLxpYvxBotxczdamLtmAGMOGTyIAPqDHkGOjXNDy/mpn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdkw37dG2+YSf/+wMV89lkOKHmDswC9e4lN8QF0SgASGfjgYmU
	g3u5WZ45Cq3bKoqajMiA4aDo5ipMKQzWYnDgGBu0khMr9kxY1MOiO5pFLH/Nm6Ek9PCvuoWmmq9
	+++pkTzJNQIsil6TgjVX39dAzRLOSU7A=
X-Gm-Gg: ATEYQzwUTejuHHrEL2ktcJiIg1ZLQJMWIfQ6JvZRpGS8wfJIQhOHRu6vMdkARMQWiX1
	Jfp9r0UvGo/jAMYK2NajcZB3YMeb/P8Bug/Op8iAqBOVC47XWsR4ZPLqCBjI3OiTdRNUY/0jQDU
	POCCJqhEt3FNAmRn0dy4m0paUY1j+X/q8nkRUtqUvoSmB9RyC99nbDThsmjbwX7X1mwNDwftNOM
	eI2I1RL1+SDfHQZwc9Zr8vH03Yqx/IORg4H535ivvQ5gzp9J36J09NoUU7Fij3vMySlEy6GnPi9
	yJSnzKCbV16fxcdvc2eFY03gVyAr6H+14ZeNCYAOGhNXm+wn6DBDozB8s25fhgZhhi6iRQf2HAK
	SAG2CUrxgBxBAr++hV7xvB1RVQo17F7R9Dqca
X-Received: by 2002:a05:600c:529b:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-485198840ddmr11665155e9.17.1772603913306; Tue, 03 Mar 2026
 21:58:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211151115.78013-1-leon.hwang@linux.dev> <20260211151115.78013-4-leon.hwang@linux.dev>
 <CAADnVQKc5H=k-++CHxs+Y1ggptRSLRcACLgVaMgOmt=QBT=dkA@mail.gmail.com> <c9cd645f-810b-4dd4-a1ed-27569dca5055@linux.dev>
In-Reply-To: <c9cd645f-810b-4dd4-a1ed-27569dca5055@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 3 Mar 2026 21:58:21 -0800
X-Gm-Features: AaiRm51xhuPvPiRd8hQXDi2A83VK1MO7x6pFIqJ0aN5XHu0ii-a61Eu49k78XMo
Message-ID: <CAADnVQJ4E5L8rL-K=yJJZpCeRBvEJZcSKOEQP0kg2ztowhGmvA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 3/8] bpf: Refactor reporting log_true_size
 for prog_load
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
X-Rspamd-Queue-Id: 2C82E1FB003
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
	TAGGED_FROM(0.00)[bounces-5900-lists,linux-api=lfdr.de];
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
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 9:47=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> On 4/3/26 00:32, Alexei Starovoitov wrote:
> > On Wed, Feb 11, 2026 at 7:13=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
>
> [...]
>
> >> @@ -6241,7 +6244,11 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t=
 uattr, unsigned int size,
> >>                 err =3D map_freeze(&attr);
> >>                 break;
> >>         case BPF_PROG_LOAD:
> >> -               err =3D bpf_prog_load(&attr, uattr, size);
> >> +               if (from_user && size >=3D offsetofend(union bpf_attr,=
 log_true_size))
> >> +                       log_true_size =3D uattr.user + offsetof(union =
bpf_attr, log_true_size);
> >
> > So you added 'from_user' gating because
> > you replaced copy_to_bpfptr_offset() with copy_to_user()?
> > This is a drastic change in behavior and you don't even talk about
> > it in the commit log.
> > You said "refactor". This is not a refactoring!
> >
> > This is v10. The common_attr feature is useful, but
> > you really need to think harder about what your patches
> > are doing.
> >
>
> Refactoring should not introduce any functional changes. If a functional
> change is involved, it should be factored out of the refactoring commit
> into a separate commit with an explanation in the commit log.
>
> I'll add this to my self-review checklist.
>
> The intention of 'from_user' was to replace copy_to_bpfptr_offset() with
> copy_to_user(), since the log is always copied to the user-space buffer
> when the log level is not BPF_LOG_KERNEL in
> kernel/bpf/log.c::bpf_verifier_vlog().
>
> The 'from_user' gating will be dropped in v12 to keep this patch as pure
> refactoring.

You were told multiple times to avoid copy pasting AI into your emails.
Sorry, but this crosses the line for me.
Your patches will be ignored for 2 weeks.

