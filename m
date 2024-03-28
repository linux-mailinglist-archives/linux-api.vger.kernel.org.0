Return-Path: <linux-api+bounces-1136-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDE787B665
	for <lists+linux-api@lfdr.de>; Thu, 14 Mar 2024 03:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9C028726C
	for <lists+linux-api@lfdr.de>; Thu, 14 Mar 2024 02:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B5522E;
	Thu, 14 Mar 2024 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="QXkGO1Hk"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AE64A15
	for <linux-api@vger.kernel.org>; Thu, 14 Mar 2024 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383123; cv=none; b=QSP6apLvscg37UobNEnQb2hkJwjXhwux7DkVV/HVA3hHo8eniHNABZ9eIk5492QAndYtFOyf0SMd7WukborhthOX5Rt063S3jfxNRRwYo295U+nzCYJoVcqdHNdbZ2jWgQiD169xfZoXtuj+A/luCurUcDslXuqOjvPFbMIUfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383123; c=relaxed/simple;
	bh=PHmfTRRkYa6+3QEXvykncYQCKKUVxK2Ttb/mRSpBw54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6p1e0XGRcswI3VZ5sjM0zW0gZx/ck8cTNSlqduhar4b7bs/RXI/21xHazy3YKrAxTIIrtVGsM+ofWh2PSFHOUJsXmvuoMZsVl0KN1tRiu3/g07VuY5e0ipO0qWjgJ7On7Pl7ggSqcClTD8bv7FgvzYoekEBqe5lJyMwLqCSEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=QXkGO1Hk; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso286875276.1
        for <linux-api@vger.kernel.org>; Wed, 13 Mar 2024 19:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710383121; x=1710987921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4DNWvDyLPzqbKX5chJvouBSguAJQvQnzDIEEajS5+s=;
        b=QXkGO1HkrQ2dCi8vDoyLhEMDZjagXYXBXmtsN6u+Iu0tpF3hHI/0LujH4bqZdxr6hR
         ErUKZGq/0VTmN9BMU8bPnPPcSa7YfiJKUig9c8DBBNOkxkHznHwTE+OgFL9Zm7kCKAXP
         lkOAFhtMFNKUtd8/dSUPgz6OUcTPUkAan6HHNfmcgEWF66mslWQ/RL+K+TY6KxcPK9Ju
         tmc584b7Z53bxshjljLnrlwyxUDB1Zg2dOuKVHIvZlfZ4gue6+yTovIvkqB9QovJWZCl
         si0CFhgtBEBWHZ/KkC7M27DhWTIM6LNQMtLdUm4Vgw8rqTQeixD6x8B5CdY18Je69yL4
         jV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710383121; x=1710987921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4DNWvDyLPzqbKX5chJvouBSguAJQvQnzDIEEajS5+s=;
        b=duFnB+OYkByLHX77OfxoTcupG3/ZmzcJSB6pIuS62KOVilX/byElzvqbUQv8nAWXYF
         kXf5xSw+NfyuhMSauN5mjinw8Yxh6DFhxDZvJCJqL77NKbTK8BByoDSNsjD/1Nx9fFgN
         K4ZW8tYOv/8nHaK0gLtWn9aErl57oZSe+VWDbQ1Nz58w/VhVVAGtaXG/hp1zgzLLhwHX
         KcaKHpy7o19bcJfKst3x8Ec0gIgapXWfP5XhT1hYaNLKtZbLRdCKiXQFancWfdwk2jRX
         hK/++CpMP1GQ9sgSuLpk0WokS+IE73q/LfLXh3qZG6M/ANXWl9B8d3p39U9XqpP3edUx
         D4AA==
X-Forwarded-Encrypted: i=1; AJvYcCVENXZccuZ44MKhLbmjDJj1yE1H91/dm10QwIkFJICMFrySPmOT/aFa/2fDuwuF5isvzH860nSGDtKoXkk2EovZQqJyrssm1T1o
X-Gm-Message-State: AOJu0YzHb4tXCdXhXEX4fQSA7WK2SS+9vNl05JZc1NhA4SLqu2oyX4cO
	YLWEs/h5MvwqvCDuQbiLtJ35B4U8hSplwcUNncZLacIO63mXMI+BQzHWF6rK1BGOy+WWO2c7cC8
	dQoDB4S5Atwo0v5ado1Hoks6+EP3+bjARvcIS
X-Google-Smtp-Source: AGHT+IEsVarLQU9mwOayWOcTGW13ALxEq5QxXZXNeaozHAcSEtdGxaGdGSmS0c6k1blKwlww0Pt9gRb56aKe4aH3Uns=
X-Received: by 2002:a25:d044:0:b0:dc7:6192:c688 with SMTP id
 h65-20020a25d044000000b00dc76192c688mr387595ybg.65.1710383120859; Wed, 13 Mar
 2024 19:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
 <ef972e0088964722adffc596d38b0463@paul-moore.com> <CAHC9VhTkvyWpvkejbFf-VJoTvUKVDGxBDYkKFdNrdgq4jy5i_w@mail.gmail.com>
 <b5ebbb40-0dda-4595-a058-d5c3a6e800df@schaufler-ca.com> <CAHC9VhQyje1KdbXLKhZ3atgDbf2mNHB409BHtNyE_RSBACpB7g@mail.gmail.com>
In-Reply-To: <CAHC9VhQyje1KdbXLKhZ3atgDbf2mNHB409BHtNyE_RSBACpB7g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Mar 2024 22:25:09 -0400
Message-ID: <CAHC9VhTBOCUKva6ctOXx_E7+2nXMjR_eLaogMQNvEBJ4R_71gA@mail.gmail.com>
Subject: Re: [PATCH v3] LSM: use 32 bit compatible data types in LSM syscalls.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux kernel mailing list <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, 
	John Johansen <john.johansen@canonical.com>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:44=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Wed, Mar 13, 2024 at 6:48=E2=80=AFPM Casey Schaufler <casey@schaufler-=
ca.com> wrote:
> > On 3/13/2024 3:37 PM, Paul Moore wrote:
> > > On Wed, Mar 13, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > >> On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> > >>> LSM: use 32 bit compatible data types in LSM syscalls.
> > >>>
> > >>> Change the size parameters in lsm_list_modules(), lsm_set_self_attr=
()
> > >>> and lsm_get_self_attr() from size_t to u32. This avoids the need to
> > >>> have different interfaces for 32 and 64 bit systems.
> > >>>
> > >>> Cc: stable@vger.kernel.org
> > >>> Fixes: a04a1198088a: ("LSM: syscalls for current process attributes=
")
> > >>> Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> > >>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > >>> Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
> > >>> ---
> > >>>  include/linux/lsm_hook_defs.h                        |  4 ++--
> > >>>  include/linux/security.h                             |  8 ++++----
> > >>>  security/apparmor/lsm.c                              |  4 ++--
> > >>>  security/lsm_syscalls.c                              | 10 +++++---=
--
> > >>>  security/security.c                                  | 12 ++++++--=
----
> > >>>  security/selinux/hooks.c                             |  4 ++--
> > >>>  security/smack/smack_lsm.c                           |  4 ++--
> > >>>  tools/testing/selftests/lsm/common.h                 |  6 +++---
> > >>>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++---=
--
> > >>>  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
> > >>>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
> > >>>  11 files changed, 38 insertions(+), 38 deletions(-)
> > >> Okay, this looks better, I'm going to merge this into lsm/stable-6.9
> > >> and put it through the usual automated testing as well as a kselftes=
t
> > >> run to make sure everything there is still okay.  Assuming all goes
> > >> well and no one raises any objections, I'll likely send this up to
> > >> Linus tomorrow.
> > >>
> > >> Thanks everyone!
> > >
> > > Unfortunately it looks like we have a kselftest failure (below).  I'm
> > > pretty sure that this was working at some point, but it's possible I
> > > missed it when I ran the selftests previously.  I've got to break for
> > > a personal appt right now, but I'll dig into this later tonight.
> >
> > In v2:
> >
> > diff --git a/security/security.c b/security/security.c
> > index 7035ee35a393..a0f9caf89ae1 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -810,7 +810,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, =
size_t *uctx_len,
> >         nctx->ctx_len =3D val_len;
> >         memcpy(nctx->ctx, val, val_len);
> >
> > -       if (copy_to_user(uctx, nctx, nctx_len))
> > +       if (uctx && copy_to_user(uctx, nctx, nctx_len))
> >                 rc =3D -EFAULT;
> >
> >  out:
> >
> > This addresses the case where NULL is passed in the call to lsm_get_sel=
f_attr()
> > to get the buffer size required.
>
> Yeah, thanks.  I didn't get a chance to look at the failure before I
> had to leave, but now that I'm looking at it I agree.  It looks like
> it used to work prior to d7cf3412a9f6c, but I broke things when I
> consolidated the processing into lsm_fill_user_ctx() - oops :/
>
> I'll start working on the patch right now and post it as soon as it
> passes testing.

The patch posted below passes the kselftests and all my other sanity checks=
:

https://lore.kernel.org/linux-security-module/20240314022202.599471-2-paul@=
paul-moore.com

--=20
paul-moore.com

