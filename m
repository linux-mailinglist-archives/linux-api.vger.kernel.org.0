Return-Path: <linux-api+bounces-3719-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B29AAAF357
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 08:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7342A986EFC
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 06:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2647E2010E3;
	Thu,  8 May 2025 06:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urcbgj5y"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5A328E17;
	Thu,  8 May 2025 06:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746684428; cv=none; b=Qxf22ty8BkBtcgUxc1bceQJVrQOjSU6OYv/3qzsA01iaJ3wDGOIXW3TpXAhV6SB2sv1vdqmCZccxVKiIu+C5a4rZLXupvVXLsJxniz+Ej/NZ+DI3wY/QeHdUqc1l1EFlcXeMucGTXuaq10waQqzhxaFM2IpxA5PhjlPRZLQMwNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746684428; c=relaxed/simple;
	bh=sG/A4JJdEuqJ4ihN6R09kdFVdFV61BxKD5KeuzzmKdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQIF4n7RTbbmf0w6cbFpnAuPykyt/gnKAW9BrCEK0yP86w+EcQg7dsBghPxfFusj8JE8yLhze2VkQbPevHqF3YxA7V+oT2YcCXvjoTGzIXCxy+Y/UD3ULAbgy465SzanLG2UdmoQCnlDR2g4tSs/cXQ8oAsH/IbvIiBUfpfwuDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urcbgj5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB55C4CEF6;
	Thu,  8 May 2025 06:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746684427;
	bh=sG/A4JJdEuqJ4ihN6R09kdFVdFV61BxKD5KeuzzmKdY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=urcbgj5ySHsDNnUleu2qBzA2KUUvD1Qm63dqnBBaeQoFTQAkKXIdK4Kn4zT7oDADi
	 i97HFoo7acljXIaZ00enrKFD5GPUg3yRzY9oZg20sNv6UcEcGNaujCl2sbjnilPJY9
	 r+y1DQ49Un8yBKEWdfQEnUB9OlT6k0J6fx6dNlokLPn2clzrMp4Dib1qYvHFtG/L/Z
	 KrOTNfprUX4DpCQ+kQ4hOK9ESgxrS7+ffNakyUfkzCcn1Lk0XAjdGfqedrsQlVBCc0
	 zxmIucSnhT12rayZPnraNB5bRj8oH4tCcMe14Tb6i/xTVulbmuViIyEO/H+3BnaQJb
	 xJMOcNnvwVRmA==
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c597760323so61964985a.3;
        Wed, 07 May 2025 23:07:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWE5zILR7w8L4APP9EGCN7bhfNYXzngVuFLM+DVXMqLOjUxJaAp7igYTtr8F2cBVauMD8/77UixPe1y+7R8@vger.kernel.org, AJvYcCWXKX4JgcHB26LF6cdH4qcwjb5kZLyZ7jVnHd1rZSYuC6THXQKuzf+jwF+Rk1mRC3mlz8F0AAOeBkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbdXJDWv62iemH47s3QLIYAENxuXoscdUQUfFoz+mZbPAc8rnj
	Dtc8CaoTH75RO/ecAVp10RhaWeJp+fAdqc++lKV8qqFoPgcmZPUrMltugvvz6dfuTKcaVRFQqXA
	FB7Iuu8z5nCq88xWp3owxOK9e7Dc=
X-Google-Smtp-Source: AGHT+IH1F8h0h2SHfSdaI2nzHPlotKSsjVbT3JhBTuJALzuEgmgmOWxBeNcvV0wjfVxCVT4zGEENBcK78KOSn7zjlik=
X-Received: by 2002:ad4:5ca5:0:b0:6e8:9dfa:d932 with SMTP id
 6a1803df08f44-6f542a5994emr90456286d6.15.1746684426480; Wed, 07 May 2025
 23:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-2-maxime.belair@canonical.com> <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
 <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
In-Reply-To: <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
From: Song Liu <song@kernel.org>
Date: Wed, 7 May 2025 23:06:55 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4FVMS7v8p_C-QzE8nBxCb6xDRhEecm_KHZ3KbKUjOXrQ@mail.gmail.com>
X-Gm-Features: ATxdqUFsvIM3m3XDmSjrxUKMHnRWZsOQlrBI5f05NCyl8yrg1_5EAXHKKaFLl_I
Message-ID: <CAPhsuW4FVMS7v8p_C-QzE8nBxCb6xDRhEecm_KHZ3KbKUjOXrQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net, 
	kees@kernel.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 8:37=E2=80=AFAM Maxime B=C3=A9lair
<maxime.belair@canonical.com> wrote:
[...]
> >
> > These two do not feel like real benefits:
> > - One syscall cannot fit all use cases well...
>
> This syscall is not intended to cover every case, nor to replace existing=
 kernel
> interfaces.
>
> Each LSM can decide which operations it wants to support (if any).=E2=80=
=AFFor example, when
> loading policies, an LSM may choose to allow only policies that further r=
estrict
> privileges.
>
> > - Not working in containers is often not an issue, but a feature.
>
> Indeed, using this syscall requires appropriate capabilities and will not=
 permit
> unprivileged containers to manage policies arbitrarily.
>
> With this syscall, capability checks remain the responsibility of each LS=
M.
>
> For instance, in the AppArmor patch, a profile can be loaded only if
> aa_policy_admin_capable()=E2=80=AFsucceeds (which requires=E2=80=AFCAP_MA=
C_ADMIN).=E2=80=AFMoreover, by design,
> policies can be loaded only in the current namespace.
>
> I see this syscall as a middle point between exposing the entire sysfs, c=
reating a large
> attack surface, and blocking everything.
>
> Landlock=E2=80=99s existing syscalls already improve security by allowing=
 processes to further
> restrict their ambient rights while adding only a modest attack surface.
>
> This syscall is a further step in that direction: it lets LSMs add restri=
ctive policies
> without requiring exposing every other interface.

I don't think a syscall makes the API more secure. If necessary, we can add
permission check to each pseudo file. The downside of the syscall, however,
is that all the permission checks are hard-coded in the kernel (except for
BPF LSM); while the sys admin can configure permissions of the pseudo
files in user space.

> Again, each module decides which operations to expose through this syscal=
l.=E2=80=AFIn many cases
> the operation will still require CAP_SYS_ADMIN or a similar capability, s=
o environments
> that choose this interface remain secure while gaining its advantages.
>
> >>   - Avoids overhead of other kernel interfaces for better efficiency
> >
> > .. and it is is probably less efficient, because everything need to
> > fit in the same API.
>
> As shown below, the syscall can significantly improve the performance of =
policy management.
> A more detailed benchmark is available in=E2=80=AF[1].
>
> The following table presents the time required to load an AppArmor profil=
e.
>
> For every cell, the first value is the total time taken by aa-load, and t=
he value in
> parentheses is the time spent to load the policy in the kernel only (tota=
l=E2=80=AF-=E2=80=AFdry=E2=80=91run).
>
> Results are in microseconds and are averaged over 10=E2=80=AF000 runs to =
reduce variance.
>
>
> | t (=C2=B5s)    | syscall     | pseudofs    | Speedup       |
> |-----------|-------------|-------------|---------------|
> | 1password | 4257 (1127) | 3333 (192)  | x1.28 (x5.86) |
> | Xorg      | 6099 (2961) | 5167 (2020) | x1.18 (x1.47) |
>

I am not sure the performance of loading security policies is on any
critical path.
The implementation calls the hook for each LSM, which is why I think the
syscall is not efficient.

Overall, I am still not convinced a syscall for all LSMs is needed. To
justify such
a syscall, I think we need to show that it is useful in multiple LSMs.
Also, if we
really want to have single set of APIs for all LSMs, we may also need
get_policy,
remove_policy, etc. This set as-is appears to be an incomplete design. The
implementation, with call_int_hook, is also problematic. It can easily
cause some
controversial behaviors.

Thanks,
Song

