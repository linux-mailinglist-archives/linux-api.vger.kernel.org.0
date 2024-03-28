Return-Path: <linux-api+bounces-1135-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BAE87B62D
	for <lists+linux-api@lfdr.de>; Thu, 14 Mar 2024 02:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD091F23238
	for <lists+linux-api@lfdr.de>; Thu, 14 Mar 2024 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB03523C;
	Thu, 14 Mar 2024 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KzDvk5aH"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583701FB4
	for <linux-api@vger.kernel.org>; Thu, 14 Mar 2024 01:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710380703; cv=none; b=RCPxjIu/4EMu5Jn+U9rX4gzoT2GHLgkv+EJSWBeWIK7aQcT0Gg8EBTVWK6A4EgnknA2Nn6Vhg2bRN1+5QCyrN0UoQQiTnvjj4xO+97lk09aS5b4mPlG1LWo9OEdp/qf5DjE4YhuWkIFmaFTpKbLot0ZCsv8I2ux+9LT70ambqnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710380703; c=relaxed/simple;
	bh=8ocKQTgy4aVumKQ3t2ClwDsyVzBXXUVM2MJIlVz1qOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+kLZ60yF7SnI57M4E/sdG29MC26DiD9G0qxycozJWi2ySyYOs9iE9AjLmf5lv+tdLgH2Gjomt4iWrV67/1PzNrGgm0X8L2VUjt8VA2GluiIuSZPuoQG+SN6PWVKWmxhxy6+ECwffzs3bwAiVy4ArwK72VdpdPxnIMy0QDCT4vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KzDvk5aH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609f060cbafso6091987b3.0
        for <linux-api@vger.kernel.org>; Wed, 13 Mar 2024 18:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710380699; x=1710985499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwpjwJbNEYd3LzOzuw0Mu9cmJt6mxKhJWAmaUDGQPhA=;
        b=KzDvk5aHRg/hC1XnLHtgiimJvIiPWtTAa3XC7PPZxpy3GE91fFPyvTB8bpUiFrJYxQ
         9Ye0cgLpkW9nXC6p17C6tzl2l35EYdWbLI8tV/EfeK7EdNuBRyG6tA7lOjwa+BwIdjNi
         pL38mJK9PHGgOFYLMH2IWTw7tyHVZUmBZbROhqkFmchT0gKB6z3l5nvIlAnm5VKeCnuT
         /Vx+OHL/tatRqhVHc39tHBjNhrWSTgL+8G0f4KGl5S6JVsjKLUl7QuCV+eZLFNNptcNR
         /AWrZHVj0buV4I0aB8vTeurzV3K+iErNon5z7ktHu8CSr4py8HUbHPpuqpszcFdPj+we
         PTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710380699; x=1710985499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwpjwJbNEYd3LzOzuw0Mu9cmJt6mxKhJWAmaUDGQPhA=;
        b=ClKiEZ6Piy63D2/52WphtfqFgT09T0xFU8CW4JDUhjLY+hvOXbT1eJra2CQlxnUdsb
         vPFNgRvQqLbS4YwNt8LS3pZ/JDTM2FwCxh6moMs1aU75uYI8wi8LxmTceARYCG9Ct8/W
         +2GktmuXQD7SEj2TWBFX2ZECO7kVbSa3Fv+BjpgrmIH5r1BGACbkq9p7ip8lwukgFjXy
         x8/IYDpSp5dBmGjzmt+2yipPPwCVuzRc52mNKx5kkoBw/Z2OUxcx6P8Np+1DYntTgQAp
         u9FOHU8X8V6Ft3/dIWy6XIdlA6D/W5d5YJPwyHstEHIgixFSQMuOugaayFP736b+WJDh
         QjAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUN2XPTtj4k7V4RxBgPe/c153+NbMo7xoRiooS8mcSfBtaJHyBn3nIp2GvOTIGQgEjNX/4Dt40Ks+C+xvc6YGt++thQkn3ItvZ8
X-Gm-Message-State: AOJu0YyAY/0+tsyIKX/6ZDMhojTa3iBlJxgWe/xJOBpMhhbBlAzWQDH6
	0swqsKlb4i14fqOHCj2fdCq8sdr5OTrDxWx90Ih9vN62duScwSKMD87L/azErbkAEVXq1ogFbvs
	XasmnPlfzBeRB3RSUyMi+4+gtaYG9TLi+JoCw
X-Google-Smtp-Source: AGHT+IHlITOg75CIyNpYozu0Q61DdnANQrJlYWSXarrNgbzmdmKUnhw5mGbqAcqxPRKzY0zRJ3OhfGH/U4c/MNV5UKI=
X-Received: by 2002:a81:b408:0:b0:609:f49f:5949 with SMTP id
 h8-20020a81b408000000b00609f49f5949mr395125ywi.21.1710380699301; Wed, 13 Mar
 2024 18:44:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <da4d181d-16b9-4e0f-a744-ac61702e0b63@schaufler-ca.com>
 <ef972e0088964722adffc596d38b0463@paul-moore.com> <CAHC9VhTkvyWpvkejbFf-VJoTvUKVDGxBDYkKFdNrdgq4jy5i_w@mail.gmail.com>
 <b5ebbb40-0dda-4595-a058-d5c3a6e800df@schaufler-ca.com>
In-Reply-To: <b5ebbb40-0dda-4595-a058-d5c3a6e800df@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 13 Mar 2024 21:44:48 -0400
Message-ID: <CAHC9VhQyje1KdbXLKhZ3atgDbf2mNHB409BHtNyE_RSBACpB7g@mail.gmail.com>
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

On Wed, Mar 13, 2024 at 6:48=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 3/13/2024 3:37 PM, Paul Moore wrote:
> > On Wed, Mar 13, 2024 at 4:07=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >> On Mar 13, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>> LSM: use 32 bit compatible data types in LSM syscalls.
> >>>
> >>> Change the size parameters in lsm_list_modules(), lsm_set_self_attr()
> >>> and lsm_get_self_attr() from size_t to u32. This avoids the need to
> >>> have different interfaces for 32 and 64 bit systems.
> >>>
> >>> Cc: stable@vger.kernel.org
> >>> Fixes: a04a1198088a: ("LSM: syscalls for current process attributes")
> >>> Fixes: ad4aff9ec25f: ("LSM: Create lsm_list_modules system call")
> >>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>> Reported-and-reviewed-by: Dmitry V. Levin <ldv@strace.io>
> >>> ---
> >>>  include/linux/lsm_hook_defs.h                        |  4 ++--
> >>>  include/linux/security.h                             |  8 ++++----
> >>>  security/apparmor/lsm.c                              |  4 ++--
> >>>  security/lsm_syscalls.c                              | 10 +++++-----
> >>>  security/security.c                                  | 12 ++++++----=
--
> >>>  security/selinux/hooks.c                             |  4 ++--
> >>>  security/smack/smack_lsm.c                           |  4 ++--
> >>>  tools/testing/selftests/lsm/common.h                 |  6 +++---
> >>>  tools/testing/selftests/lsm/lsm_get_self_attr_test.c | 10 +++++-----
> >>>  tools/testing/selftests/lsm/lsm_list_modules_test.c  |  8 ++++----
> >>>  tools/testing/selftests/lsm/lsm_set_self_attr_test.c |  6 +++---
> >>>  11 files changed, 38 insertions(+), 38 deletions(-)
> >> Okay, this looks better, I'm going to merge this into lsm/stable-6.9
> >> and put it through the usual automated testing as well as a kselftest
> >> run to make sure everything there is still okay.  Assuming all goes
> >> well and no one raises any objections, I'll likely send this up to
> >> Linus tomorrow.
> >>
> >> Thanks everyone!
> >
> > Unfortunately it looks like we have a kselftest failure (below).  I'm
> > pretty sure that this was working at some point, but it's possible I
> > missed it when I ran the selftests previously.  I've got to break for
> > a personal appt right now, but I'll dig into this later tonight.
>
> In v2:
>
> diff --git a/security/security.c b/security/security.c
> index 7035ee35a393..a0f9caf89ae1 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -810,7 +810,7 @@ int lsm_fill_user_ctx(struct lsm_ctx __user *uctx, si=
ze_t *uctx_len,
>         nctx->ctx_len =3D val_len;
>         memcpy(nctx->ctx, val, val_len);
>
> -       if (copy_to_user(uctx, nctx, nctx_len))
> +       if (uctx && copy_to_user(uctx, nctx, nctx_len))
>                 rc =3D -EFAULT;
>
>  out:
>
> This addresses the case where NULL is passed in the call to lsm_get_self_=
attr()
> to get the buffer size required.

Yeah, thanks.  I didn't get a chance to look at the failure before I
had to leave, but now that I'm looking at it I agree.  It looks like
it used to work prior to d7cf3412a9f6c, but I broke things when I
consolidated the processing into lsm_fill_user_ctx() - oops :/

I'll start working on the patch right now and post it as soon as it
passes testing.

--=20
paul-moore.com

