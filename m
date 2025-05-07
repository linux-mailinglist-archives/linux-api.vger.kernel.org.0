Return-Path: <linux-api+bounces-3707-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C7DAAD602
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 08:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221BE9803A1
	for <lists+linux-api@lfdr.de>; Wed,  7 May 2025 06:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F43B205E3E;
	Wed,  7 May 2025 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dICMRTfx"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8041D432D;
	Wed,  7 May 2025 06:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746599195; cv=none; b=HLoaW1qt2rq+Zn/zCrYp2ffDf3FvOjbRj4Egdjr+KLF40Nkgid0NuAc7FN5oRLPTwsSSkvDGTCPiPhEuIoperlc76sIvtqEw00S9XKziTSQB8MwdEifrPzV5vXL2F9nHrr1lBp9RzKjj+XdTQoNgGKJUQEs2r6U+R2fgfexb3B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746599195; c=relaxed/simple;
	bh=GaA/zJXRvdyzWhvBvSQORxWGe7IYP25MXqgGd/qtJd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrGhourTA9XAT1G2BXb4T8cPB0bRM7to0h2ihajN/mqJHWya8vDC1WJZ+/8lQ9wYcYyafO9tZE4r6RzuM5I4qg26EC5XaD9uZR+wZGPMPgEL7NTBFx7Sgl0o0SsQjpTTUKSU6rxmr0B8ufFDFoCoegqwpkggI4nNPjS2OeLNo/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dICMRTfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA21C4CEEF;
	Wed,  7 May 2025 06:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746599193;
	bh=GaA/zJXRvdyzWhvBvSQORxWGe7IYP25MXqgGd/qtJd4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dICMRTfxofPY2kTbGCvmkRmicrGpiedx3MsMAhN5m8kr4HSy13nbYE/SPIJYr71/E
	 N33TTNdB6ASTnsleY7JRYZ3nRLIk6Zs1bvJubEr8/UbG2IfPTqW4sSCS7tBIEJgwLf
	 nqfCxcZwSkOgO9s4y/KKGBimU0MYh1h2vctEMjOSJjH32wrATWZgIvjnP1VFpoiD/+
	 NzrSAk3uPD0oP0/i3bnAokgZFjaOSrZrKnBFKtbt8vkB5FbrLxJ17iYCEmiBEPDoeY
	 EYgpBv7ohLEsMbiLKP5GMYj1SCE0TvCyTSpHBirSCJ/8Hn13lFs4n6fgmBVgPCulqE
	 RUWoCKnTMjQhQ==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40337dd3847so3646217b6e.0;
        Tue, 06 May 2025 23:26:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUL0HaWWyyQvZ9T6aO92PeQBF6EnSAD1v7Lbv/pRnYC+BYcOCNSw+PbUQydIo3+EjxSjM+okWETUgeo8ODV@vger.kernel.org, AJvYcCVm8YyqquM2BK6EBADs3J/FOL5L79NWE1hnkTSUYfkqYxljcQ3PJo4ynW23ssk2Ofb97hg7FCxmQK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnN3aGpEE4gYP1dK273lEl4ookg1qfednbWGtxRgVv+qjduzr
	Np6hUomd3bHi3Otu1IttX7PWHVIW6htiVlutjF2qcEiCmGxsMPlD5u7lZNiSMaEN4UOwDt3uegj
	PLtpVYSFuFgAkKt+lD95Vjw4GK/k=
X-Google-Smtp-Source: AGHT+IE6OoQBQFNIo2RMuI36yMDwzxZHGLigZ5rk40AM8etZx9c58IROyGc/jRXUBwa/wPABVFxm/WCKiib7VV1jN8w=
X-Received: by 2002:a05:6214:529b:b0:6e8:9e8f:cfb with SMTP id
 6a1803df08f44-6f542a5f62dmr30383316d6.24.1746599182795; Tue, 06 May 2025
 23:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506143254.718647-1-maxime.belair@canonical.com> <20250506143254.718647-2-maxime.belair@canonical.com>
In-Reply-To: <20250506143254.718647-2-maxime.belair@canonical.com>
From: Song Liu <song@kernel.org>
Date: Tue, 6 May 2025 23:26:11 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
X-Gm-Features: ATxdqUEG2jVvCzrgMgUy-LTFDpzXf-8Zg-TeGO0jYs2AI_kPt5jR1N9qESQfZXI
Message-ID: <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
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

On Tue, May 6, 2025 at 7:40=E2=80=AFAM Maxime B=C3=A9lair
<maxime.belair@canonical.com> wrote:
>
> Add support for the new lsm_manage_policy syscall, providing a unified
> API for loading and modifying LSM policies without requiring the LSM=E2=
=80=99s
> pseudo-filesystem.
>
> Benefits:
>   - Works even if the LSM pseudo-filesystem isn=E2=80=99t mounted or avai=
lable
>     (e.g. in containers)
>   - Offers a logical and unified interface rather than multiple
>     heterogeneous pseudo-filesystems.

These two do not feel like real benefits:
- Not working in containers is often not an issue, but a feature.
- One syscall cannot fit all use cases well...

>   - Avoids overhead of other kernel interfaces for better efficiency

.. and it is is probably less efficient, because everything need to
fit in the same API.

Overall, this set doesn't feel like a good change to me.

Thanks,
Song

