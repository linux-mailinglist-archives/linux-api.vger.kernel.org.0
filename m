Return-Path: <linux-api+bounces-5809-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMmPLTQXhWl48QMAu9opvQ
	(envelope-from <linux-api+bounces-5809-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 23:18:28 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFDAF804E
	for <lists+linux-api@lfdr.de>; Thu, 05 Feb 2026 23:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA4FB3025A7F
	for <lists+linux-api@lfdr.de>; Thu,  5 Feb 2026 22:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57C12F28E3;
	Thu,  5 Feb 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGnRuN1x"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162D2FFF8D
	for <linux-api@vger.kernel.org>; Thu,  5 Feb 2026 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770329898; cv=pass; b=XVZi/BF/nozCl/J9pYp4bYHsf3VXNYKfNe5G70S9g3zDl78xCg/t9MazXFGj0FnwgK1FST2gJbgi2Vp0TKY3m4jkwGmBrCIDbEL5bsttKhk3zyTJx4kHaIEAwMVnBqCe2R0eYes6qBP2Zce7yq0BD2hn+MP/GtKNWj55NuR4ZVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770329898; c=relaxed/simple;
	bh=vLtqOXlkmpDp8649uQXAFwpec++fglZ9xjz1AMQBNq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmzNyMW7C8Wu+9iEGCTE6hl+w6Qjfd/h6H1re1Z3aKw709lpDmKrtFtYnrk43+vyHpmUY9xqd7I2AkLXDDJCZWQ3Ye9BUfWGzjlTbg3FEM91/yuZsaXkfW4iDBCpFnbcIhutBjdJjOXQBrVxME1yBRVWGmbtDkEIlMiWEFYM/0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BGnRuN1x; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-354a2d107bfso30519a91.0
        for <linux-api@vger.kernel.org>; Thu, 05 Feb 2026 14:18:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770329898; cv=none;
        d=google.com; s=arc-20240605;
        b=TdvvT2e2+tCvzhboAfms5FtENOm7rKwUAWddvm2eWIdGdV5YTR0NfFb8pNEGHf9GUN
         M2xsZ+DveBmGpPwxJldaQ8MPm9uPmNF4Ygb9EcQw6RHIS92nhXQMr+lUX/Bd1hTkyG6X
         uoySC0FtlSqzu5aaERdYCEN1AzPdXnVjhfxkDcda0lHTTiI1kzPcLuCQpTA+dQj/K2fS
         0yCD+CeugX1FBPLF0vDnrzVKJ/phTUTwBKdbLbKzQcJSmm9SnOUzX93eBBKd/4q6QOYu
         c8RUbY9wVJJQsFdO86iLbT6hFExxti8F67NmMzvMsLX7h0CNIFXYsfq5xlFjcG6xjsEU
         UdVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cchYFu5XNpUxtrsOKugy/nLBzyYeneYwWP7P7Z/OFic=;
        fh=S5YyApTeKwvUHRrOstP7NJJy9QKwCyokhu2h+8Wt8oM=;
        b=dPtAoz9L4NDgvrOUS9hAWtpvMrHsr3tcnJl/fxXupG2/RdxR5oawPhtN5hI70C4JhR
         Xva+tmKtngoaDMGo+bDdy8WKw+Lduf5eAFI506/EGX74O1qt7XG08KepTA53d4z+HSNw
         teV/0f5GEWrNDEs6bk0/Q1BozV8xnyeVHhp2lKZv2VoFfbm2YTfKV9YaMtdltCjqD9Wb
         e42wzTpnFqztmbFnQB7YYBfXvwNuMx/IXFpibZwspz8dk9RAW5CreWu2GEp9Ev0BPv8B
         ZB3iEpegaWNfsyC8gECmjtQ4lw3Qxt0WU/B/3xlyE70/rLDG+IlX/L3aKDV7v+4hI2mP
         LJbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770329898; x=1770934698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cchYFu5XNpUxtrsOKugy/nLBzyYeneYwWP7P7Z/OFic=;
        b=BGnRuN1xm224yBwoxJ3XKVwxoAhqF2aIhi/2MPkVwX6Z43Qsnv1MSm3uPm3QdsPQvv
         ddYLDTLDdR80ta9BGrAvwK0g77wrj+4dVI8deyySuJbvEIgfFJtyqCuWFC6wnmzQUjbY
         KFRYzc4UyKo6xohOULVB/33hllZn26j8uzKPSdLTCJseXmBjrDFiLwWzAnWpey71FcFb
         SxF3n6woZDclOAdUoedg1xXRxxf3ds28mxd+L7s7wcg+Mu/gFMFLQgsKNASj06HnDwdK
         lhNeuDC/49efp6fdFp59AkFSeDDqWEVsu57OTLCdJxL8N2ZPhcrXDhmNTyH5PrE65XHw
         v59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770329898; x=1770934698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cchYFu5XNpUxtrsOKugy/nLBzyYeneYwWP7P7Z/OFic=;
        b=Y0tFMl2TqWTiBJmaUVcBXCs4eYRd9WoameYNHnjFd/PuIP9/f8TKuVZm6rsF+tO6KH
         8zTXkqXnyR0EkzJRvG3jmJ7m1LPMg1vsz78ChNIt+fknti05St1l85JX40Z8VSdCKxSM
         ppV44oFM2as2ckVkbuIV+vceGBvbVeOJbpwiEiem/qwf00QeEA8xebQXhNVW84qKRbwO
         CKgazbGBZ5q5bmmxaA1Jw1LDN4uAYQIEGiB/R9e0MaHbA9plX2FuIiOO0xYrtQ/8X6+L
         F0RJo4LEtFp7teSiYlkbcEDyEcQdd0kbb798dP9Zk20EMNCbZtg++X7TQ2KuhohEVJJ6
         sKHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5bGR/S1ngvxnRTNa9mlvVxWxRYU4aDPFw2VjR/CwujZt92UhwaDq0jj1xkryU4MZGtN5Hh+IHHIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tGt+5UYdiZGQUUnTF7a1dpw+ElnNcEoBM6xMRWBsCm2kxwY6
	FBudwqTeF0BzLon0uH0t+JrZFFmz7voSlKuIt8A3qAcg5aFm5P8+gnMx0R4AOdqYeKm27Piki2V
	jzG051CSrACQrnzuGdNgF23c0DV6NlBA=
X-Gm-Gg: AZuq6aKIcgPtL/6Lw+/hc8V74IYd4SVgL2mwxRZBOe/RRYEZCJghk9UXh8KLyCG9F92
	/vZZgwodtz1jgd6Se40Q283qhGLnM0mtI3+LFh3RSK8DWDMSHI024qI5zijvw3Rps2ZX0y2nrkB
	lyYzEVXJo17mUAvzVonbopdZuG+6EJZOlGJAHXqs2r9qvcE0XljUZbKnnveT2fFn957GQNL3nUQ
	gtspruDfo2EcMpxUI47HWA9ltmQ3g9HzLplRtuW1VzrHnRJrtpY51W+md3PKApLca6HLI30ul9G
	+fHJoNcnfds=
X-Received: by 2002:a17:90b:6c3:b0:354:7c90:8c6 with SMTP id
 98e67ed59e1d1-354b3e4503dmr359395a91.25.1770329897674; Thu, 05 Feb 2026
 14:18:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202144046.30651-1-leon.hwang@linux.dev> <20260202144046.30651-5-leon.hwang@linux.dev>
 <CAEf4Bza-PM9ExqJS=Q_oj7Cqc5dvmbN_Zv9-4UnJNtsZU28FoQ@mail.gmail.com> <a31b7f19-a22a-44ab-8ecd-9df9dead9c3d@linux.dev>
In-Reply-To: <a31b7f19-a22a-44ab-8ecd-9df9dead9c3d@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 5 Feb 2026 14:18:05 -0800
X-Gm-Features: AZwV_QhcaugW1hKMYmi69h669dkiCWPGiiQzGYvFIpSUB_4402UB2ZyoHNuy4Kg
Message-ID: <CAEf4BzZWawrE+mXaPNPAT8zcz0Qy+5QYA6r4JzEVw7UAcUH-uA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5809-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 6EFDAF804E
X-Rspamd-Action: no action

On Wed, Feb 4, 2026 at 7:42=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
>
>
> On 5/2/26 03:48, Andrii Nakryiko wrote:
> > On Mon, Feb 2, 2026 at 6:42=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> >>
> >> BPF_PROG_LOAD can now provide log parameters through both union bpf_at=
tr
> >> and struct bpf_common_attr. Define clear conflict and precedence rules=
:
> >>
> >> - if both are provided and log_buf/log_size/log_level match, use them;
> >> - if only one side provides a log buffer, use that one;
> >> - if both provide log buffers but differ, return -EINVAL.
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf_verifier.h |  3 ++-
> >>  kernel/bpf/log.c             | 24 ++++++++++++++++++++++--
> >>  kernel/bpf/syscall.c         |  3 ++-
> >>  3 files changed, 26 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index c805b85b6f7a..0d106fddbbc5 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -638,7 +638,8 @@ struct bpf_log_attr {
> >>  };
> >>
> >>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union =
bpf_attr *attr,
> >> -                               bpfptr_t uattr, u32 size);
> >> +                               bpfptr_t uattr, u32 size, struct bpf_c=
ommon_attr *attr_common,
> >> +                               bpfptr_t uattr_common, u32 size_common=
);
> >>  int bpf_log_attr_finalize(struct bpf_log_attr *attr, struct bpf_verif=
ier_log *log);
> >>
> >>  #define BPF_MAX_SUBPROGS 256
> >> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> >> index ff579fcba36f..345005ba98dd 100644
> >> --- a/kernel/bpf/log.c
> >> +++ b/kernel/bpf/log.c
> >> @@ -873,10 +873,30 @@ static void bpf_log_attr_init(struct bpf_log_att=
r *attr_log, int offsetof_true_s
> >>         attr_log->uattr =3D uattr;
> >>  }
> >>
> >> +static bool bpf_log_attrs_diff(struct bpf_common_attr *common, u64 lo=
g_buf, u32 log_size,
> >> +                              u32 log_level)
> >> +{
> >> +       return log_buf && common->log_buf && (log_buf !=3D common->log=
_buf ||
> >> +                                             log_size !=3D common->lo=
g_size ||
> >> +                                             log_level !=3D common->l=
og_level);
> >
> > let's validate (unless we do this somewhere else) that if log_buf is
> > set, then log_size and log_level (? not sure, maybe zero is fine) are
> > set, or all three are not set. Same for common->log* fields...
> >
>
> Ack.
>
> Will validate 'log_buf && log_size && log_level' first.
>
> >
> >> +}
> >> +
> >>  int bpf_prog_load_log_attr_init(struct bpf_log_attr *attr_log, union =
bpf_attr *attr,
> >> -                               bpfptr_t uattr, u32 size)
> >> +                               bpfptr_t uattr, u32 size, struct bpf_c=
ommon_attr *attr_common,
> >> +                               bpfptr_t uattr_common, u32 size_common=
)
> >>  {
> >> -       bpf_log_attr_init(attr_log, offsetof(union bpf_attr, log_true_=
size), uattr, size);
> >> +       if (bpf_log_attrs_diff(attr_common, attr->log_buf, attr->log_s=
ize, attr->log_level))
> >> +               return -EINVAL;
> >> +
> >> +       if (!attr->log_buf && attr_common->log_buf) {
> >> +               attr->log_buf =3D attr_common->log_buf;
> >> +               attr->log_size =3D attr_common->log_size;
> >> +               attr->log_level =3D attr_common->log_level;
> >
> > why are we setting this? Do we still have code that can access
> > attr->log_buf even though we pass attr_log everywhere? If yes, should
> > we still have that "split brain" code?
> >
>
> 'attr->log_buf' is accessed only in bpf_check().

bpf_check should be changed then, see below

>
> > If we don't have this assignment, then I think we don't need to have
> > bpf_prog_load-specific and btf_load-specific log_attr_init() helpers.
> > They can be unified into generic log_attr_init, where for
> > bpf_prog_load you'll pass offsetof(log_true_size) +
> > attr->log_{buf,size,level}, and for btf_load you'll pass different
> > offset of and btf-specific attr->btf_log*
> >
> > This helper will just be making decision whether to use common_attr's
> > log fields or passed directly command-specific ones.
> >
> > Or what am I missing?
> >
>
> If the log attributes differ, where should the effective
> log_* values be stored?
>
> Should they live in struct bpf_common_attr, or should we extend
> struct bpf_log_attr to carry them?
>
> Note that in v8, Alexei suggested struct bpf_log_attr only needs
>   u32 offsetof_true_size;
>   bpfptr_t uattr;
>
> so I=E2=80=99d like to clarify the intended direction here. Once that=E2=
=80=99s clear, a
> single generic log_attr_init() should be sufficient to handle this.
>

The intended direction is to have log buf/size/level in one place
(after attr and common_attr validations), so we keep internal logic
simple. Let's put all of that and log_true_size **pointer** (we don't
have to much with offsetof, just calculate user addr for
log_true_size, which just might be NULL) into bpf_log_attrs and teach
all code to look and work *only* with that struct, ignoring anything
log related from attr.

> Thanks,
> Leon
>
> >
> >> +               bpf_log_attr_init(attr_log, offsetof(struct bpf_common=
_attr, log_true_size),
> >> +                                 uattr_common, size_common);
> >> +       } else {
> >> +               bpf_log_attr_init(attr_log, offsetof(union bpf_attr, l=
og_true_size), uattr, size);
> >> +       }
> >>         return 0;
> >>  }
> >>
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index e81199361241..7125ea445c6c 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -6232,7 +6232,8 @@ static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t =
uattr, unsigned int size,
> >>                 err =3D map_freeze(&attr);
> >>                 break;
> >>         case BPF_PROG_LOAD:
> >> -               err =3D bpf_prog_load_log_attr_init(&attr_log, &attr, =
uattr, size);
> >> +               err =3D bpf_prog_load_log_attr_init(&attr_log, &attr, =
uattr, size, &attr_common,
> >> +                                                 uattr_common, size_c=
ommon);
> >>                 err =3D err ?: bpf_prog_load(&attr, uattr, &attr_log);
> >>                 break;
> >>         case BPF_OBJ_PIN:
> >> --
> >> 2.52.0
> >>
>

