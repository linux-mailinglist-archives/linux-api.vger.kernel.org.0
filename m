Return-Path: <linux-api+bounces-37-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1B47E937A
	for <lists+linux-api@lfdr.de>; Mon, 13 Nov 2023 01:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B532280AA5
	for <lists+linux-api@lfdr.de>; Mon, 13 Nov 2023 00:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1762A399;
	Mon, 13 Nov 2023 00:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi0HjTMI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8454368
	for <linux-api@vger.kernel.org>; Mon, 13 Nov 2023 00:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63F6EC433CC
	for <linux-api@vger.kernel.org>; Mon, 13 Nov 2023 00:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699834125;
	bh=J4HknDoArB4ViSGbXTge5MV2QIRiveJDtQEAca3JRFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hi0HjTMI+nRsZwwwx9LHEpR0yFWgWQP53nCLAd/51TrnmA6/mad2w65izFJfcsXY0
	 e6JKQ2/xhMNBfSnaOHQUpFT+ooBIhBO1vWu+aVJpKyl1eANCDLQo/X1iYeoHw6Fczn
	 8D70/txhskZtPXKmjaZkojsnkPCjhgWn4o6H/ABstX10k/5O/8zaynnJ2H4KwQqZJf
	 r6IKjf/1dp5gVo5+aztfyvY6rxkVuER09PaHgcY69tIoUqclIhpAJPSWFrIKj9v1A7
	 yvKL+c+kpGTEt+UEXbj1O6Xn7T2v06UbLe1Zp9N2BniTz4zhCG8lMT+rcsa47vJuxG
	 GcBUDiS6nXhDg==
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4ac89e8e964so1697350e0c.3
        for <linux-api@vger.kernel.org>; Sun, 12 Nov 2023 16:08:45 -0800 (PST)
X-Gm-Message-State: AOJu0Yxz7Dxv28VjK5HnQOOZajvc9NVcpr8yA0AY/KcS89i3rGAGMqeI
	J5pOuDm8PDGhL+cNMyBv/FPm8k3AyFhxdyNQy/Aj9g==
X-Google-Smtp-Source: AGHT+IExtM3e5B9oYl5Q78gHtL5BrHeWXvK+rbc/rl7vuukhHSKNddDfLnVLfVZelEBUmqmA3mEYIczPv1uoHdtexL4=
X-Received: by 2002:a05:6122:458a:b0:495:cace:d59c with SMTP id
 de10-20020a056122458a00b00495caced59cmr5601637vkb.0.1699834124363; Sun, 12
 Nov 2023 16:08:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231111125126.11665-1-yjnworkstation@gmail.com>
 <20231111132431.GA3717@1wt.eu> <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
In-Reply-To: <CAHk-=whTZDjeH2FJqBozjAF44sh4XVNQrt2xdQn_Ujt=Be6=dw@mail.gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Sun, 12 Nov 2023 16:08:33 -0800
X-Gmail-Original-Message-ID: <CALCETrV+2wPJwZ90-nZFgM9o_f0hCQ4Gf3Y+H+6cdkjoafgiZQ@mail.gmail.com>
Message-ID: <CALCETrV+2wPJwZ90-nZFgM9o_f0hCQ4Gf3Y+H+6cdkjoafgiZQ@mail.gmail.com>
Subject: Re: [PATCH] exitz syscall
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Willy Tarreau <w@1wt.eu>, York Jasper Niebuhr <yjnworkstation@gmail.com>, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Nov 11, 2023, at 5:24=E2=80=AFPM, Linus Torvalds <torvalds@linux-found=
ation.org> wrote:
>
> =EF=BB=BFOn Sat, 11 Nov 2023 at 05:24, Willy Tarreau <w@1wt.eu> wrote:
>> IMHO it does not make sense to add a syscall for this, please have a
>> look at prctl(2) instead, which is already used for similar settings.
>
> Honestly, I don't think it makes any sense at all.
>
> If the key manager people can't be bothered to keep track of their
> keys, the kernel certainly shouldn't be bothered with this kind of
> huge hammer.
>
> It looks like an active DoS attack to me, by anybody who just creates
> a huge process and then sits there giggling as the machine comes to a
> complete halt, with the kernel busy zeroing pointless crap.

The implementation in this patch is =E2=80=A6 bad.  But that aside, the who=
le
concept seems wrong to me: zeroing memory specifically when an mm
exits seems rather bizarre -- it's the wrong condition. From a
hardening perspective, there are really three concerning cases, IMO:

1. Something sensitive is in memory, and some bug (side channel or
straight up kernel bug) allows an attacker to read it.  Zeroing early
shortens the window but doesn't actually prevent the attack.

2. Something sensitive is in memory, and some bug allocates the memory
before it's freed.  (I.e. allocator state gets corrupted.)  Like #1,
all we can do is shorten the window.  But these kinds of bugs are
quite rare.

3. Something sensitive is in memory, it gets freed, it gets reused
without __GFP_ZERO, and it gets leaked.  This actually seems fairly
plausible.  While __GFP_ZERO is fairly common, there are tons of paths
that don't use it, and bugs happen.

We do have:

commit 6471384af2a6530696fc0203bafe4de41a23c9ef
Author: Alexander Potapenko <glider@google.com>
Date:   Thu Jul 11 20:59:19 2019 -0700

    mm: security: introduce init_on_alloc=3D1 and init_on_free=3D1 boot opt=
ions


And I can easily imagine a useful API to flag some memory as being
sensitive such that either the kernel will always zero it when freed
or will make sure it's zeroed before being reallocated even if
__GFP_ZERO is not set and init_on_alloc and init_on_free are both
zero.

This would be a rather different patch that exitz().

--Andy


>
> Do it in user space. And if your user space randomly crashes, you have
> other problems - but you can try to use ptrace to catch even that case
> if you care.
>
>        Linus

