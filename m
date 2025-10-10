Return-Path: <linux-api+bounces-5086-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D28DBCDA75
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 16:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805C119E1711
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 15:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE092F746E;
	Fri, 10 Oct 2025 14:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JCcPlXSW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E552F7471
	for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108390; cv=none; b=gc9oE2V0HZxCg8zJ8kjm4Xw5lpmHdqocRGB86qrAQu9GN3t4VenZVfzeFYJlXn8aIVsUP4vLlpHwm+h8qEO8j+GKEPQP61pO5xAD43qDxas5+yunzZEpNgUvmyPWmGChwEqi0GiainZ5mwuTP0cB75YZVdZtInVMwETMKac02Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108390; c=relaxed/simple;
	bh=KD4eixvngpxKs37ysDRhAqXKK6Z9EeYjwRzv8uXJu2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M+CLrFighz/4WiDs/aCaOV54vc/MIkcjE9hEV0Lvack8VRRCyKLTv4pZUgzJX/J7pEM48sT39VKhtlDTHakRZ9Vd4bREfSgdhk3GkLvt8e3owBeTp+z77FTb+i3a2yTI10+mqoyoap63/9BPk1bfTrq3jK8RAobwkl7TimuxkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JCcPlXSW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27edcbbe7bfso27885205ad.0
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760108388; x=1760713188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+0sjW+oV0t2BMqgCvuWpzJUVVCqY3LbFgfCiYx9Oq0=;
        b=JCcPlXSWDH9a5m06VnHvoYfhVaiu5z+2LPT6lCbPZF4vfCfVuKfk7HuWMbOTAaheQQ
         RWevaP0t/FLJ03okG+qa6I2B6yE6h37NUbSgcr9ZZw6ahBfDsJqfufX1M2qu9hTkvVFk
         Lo/Yy1OM69mD1rxzcjVoS+iEcEGd/KfysTeD+Rd3/uQICKf1tjI1xO6TtHXJbuicQO+N
         IImmDDweBiUcpXOoGLT5HR+1iqz+9lmJJayKKqYm34p9tYzcJm5RDh9sHr9EfFkSKckz
         tvF1NYUxD3t8FFuFqGL5qR/8lGPNB+e5rgVQT4OBTIEfU96Yfp/Y0s4zDPIXaTaBA6gj
         8jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108388; x=1760713188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B+0sjW+oV0t2BMqgCvuWpzJUVVCqY3LbFgfCiYx9Oq0=;
        b=k1g8VezpH/iodZQ+Eefl1q0gFk41RJDv5GQ+uMlmv2ByKdK8cCEY+kjic4orNKdtGD
         8Bo7GC5fzxBfksnHBMLvQvfNeeB9KHIBmHYyIXvuKITDl06bhqCjeLyD8vXd0L+vd0cI
         CdITNDLXDXcQhcjxoqO94JSfDNk7Fcia0PcEij4Jowh62D38YWbI+8t9UpJuFkWUnk90
         avZbDNikb+Z86POdKyrbPdTTd/CgEzFk2RDS+b+We43KrTeIiyBc1bzXU8XIk8qqLjaS
         J0PJ63gteAiIE3I3UbSsncLpowT13Lbm4/Rp1NLuJMMNSJ2r1Fsn75dnhMhNbNBsDiGF
         e+Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWyP/w39I0Y2anucGFSz/NdYPzYdL2k5NN/sa6PjacKmBnU75T/4CyVkDOiuWQjFUwjaYsBXR+aIEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUstEaNWNEYRDGWOXHxOfx/Qx1ZEGBQYaYq3gpGFyViSl9vLWQ
	vnpqwTJLjogpz9eo3nXGlJTimhEiunXXCAukkzsjVMVFE2X4lfnGUBJkYvggWe5yeicZ3xZEaq2
	rXiGdi+x1ukz61SNnU9sbi/jUO9NC/75Z97FAHtef
X-Gm-Gg: ASbGncvqDmWKb86SDtX+UL6NRTrRZY3O96TKGU8/rqlk6gzI249ZRYXnts6LKV9bVaB
	nuFTOiSNXRh6ih5c5N7GhAC9db37dkXC77mEwmqishqHYWuzoDSSeMB1tLgUtf0NdhgrM4oYmh9
	NoNWLlvrd/YtI+JTPFhI3//3QpyLVF/LJXS2sbFgCjEhNUtXVLgRsz5znmr7VhfyH3h8V7ClTy8
	q8lH8ux9a2qmJrs1f7IFRfGbw==
X-Google-Smtp-Source: AGHT+IG9hy80Ik6+ARbIl3oz3A3KG5+fo5fGn6VPEI+bWA/pwCD/ahXTgPJG7kBipRJaOCzTwImphgjwuOgiPM9OpYY=
X-Received: by 2002:a17:902:f602:b0:274:9dae:6a6d with SMTP id
 d9443c01a7336-290272c1a67mr159749285ad.34.1760108388086; Fri, 10 Oct 2025
 07:59:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709080220.110947-1-maxime.belair@canonical.com>
 <20250709080220.110947-3-maxime.belair@canonical.com> <20250820.Ao3iquoshaiB@digikod.net>
 <0c7a19cb-d270-403f-9f97-354405aba746@schaufler-ca.com>
In-Reply-To: <0c7a19cb-d270-403f-9f97-354405aba746@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Oct 2025 10:59:36 -0400
X-Gm-Features: AS18NWAVS7migS1jhRtb-IPHhnKptQlfKCCpqw55Hl-FAqPL4NSJFJGx8uS1S6s
Message-ID: <CAHC9VhSXcqKF9KQ1+KanPqoTk=GRsOXs5dGNNnmTiK_BcMUV5A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] lsm: introduce security_lsm_config_*_policy hooks
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, kees@kernel.org, 
	stephen.smalley.work@gmail.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, rdunlap@infradead.org, 
	linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 11:30=E2=80=AFAM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 8/20/2025 7:21 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> > On Wed, Jul 09, 2025 at 10:00:55AM +0200, Maxime B=C3=A9lair wrote:
> >> Define two new LSM hooks: security_lsm_config_self_policy and
> >> security_lsm_config_system_policy and wire them into the corresponding
> >> lsm_config_*_policy() syscalls so that LSMs can register a unified
> >> interface for policy management. This initial, minimal implementation
> >> only supports the LSM_POLICY_LOAD operation to limit changes.
> >>
> >> Signed-off-by: Maxime B=C3=A9lair <maxime.belair@canonical.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |  4 +++
> >>  include/linux/security.h      | 20 ++++++++++++
> >>  include/uapi/linux/lsm.h      |  8 +++++
> >>  security/lsm_syscalls.c       | 17 ++++++++--
> >>  security/security.c           | 60 ++++++++++++++++++++++++++++++++++=
+
> >>  5 files changed, 107 insertions(+), 2 deletions(-)

...

> >> diff --git a/include/uapi/linux/lsm.h b/include/uapi/linux/lsm.h
> >> index 938593dfd5da..2b9432a30cdc 100644
> >> --- a/include/uapi/linux/lsm.h
> >> +++ b/include/uapi/linux/lsm.h
> >> @@ -90,4 +90,12 @@ struct lsm_ctx {
> >>   */
> >>  #define LSM_FLAG_SINGLE     0x0001
> >>
> >> +/*
> >> + * LSM_POLICY_XXX definitions identify the different operations
> >> + * to configure LSM policies
> >> + */
> >> +
> >> +#define LSM_POLICY_UNDEF    0
> >> +#define LSM_POLICY_LOAD             100
> > Why the gap between 0 and 100?
>
> It's conventional in LSM syscalls to start identifiers at 100.
> No compelling reason other than to appease the LSM maintainer.

If you guys make me repeat all the reasons why, I'm going to get even
crankier than usual :-P

--=20
paul-moore.com

