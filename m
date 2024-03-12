Return-Path: <linux-api+bounces-1110-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B708879513
	for <lists+linux-api@lfdr.de>; Tue, 12 Mar 2024 14:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C546028469A
	for <lists+linux-api@lfdr.de>; Tue, 12 Mar 2024 13:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47897A149;
	Tue, 12 Mar 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="P/rzX1/+"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BE95812A
	for <linux-api@vger.kernel.org>; Tue, 12 Mar 2024 13:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710249928; cv=none; b=c+4dG7aGbL8AfQ3/a4pAKSeODx/5+gW6GeR1qAqJwEy1pZnbgBOPCKP0t+r/81PIEzIk2y8m7VmZhAa4EjzVN7qJbVugs3+2MAkkQuWtCx4igO3zgC67e5m7TxJ88jR0zao2Uc0BqqJ/j51/J7MZZg2iBXbjhuCULe+LOhrUZrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710249928; c=relaxed/simple;
	bh=psGUUbaGpO0STvfivLy6nh3+05iM/5LFBTb9Tiu2sx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkIWWAgKhVmBVHyWYSWfxwZ2Vmy0ddEWcCE6tVC4uM6nmOzK8nSE4liuPnrzUlwlHyZc12bjlOagYW1xdMHwHuUlZvMDG5+1P7djwvuKr1lPtH68WQUwhF+JJTa590sP016LISiRZsw2dDAiobFV9Sy/nyFOGZ/nciR7JqPYHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=P/rzX1/+; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-609fb19ae76so47624697b3.2
        for <linux-api@vger.kernel.org>; Tue, 12 Mar 2024 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710249925; x=1710854725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JB/fCkc+DY4m42yOK4XJQgiO/OTJKfXykryTXv2ZIvc=;
        b=P/rzX1/+8Gsya7WVuz83YmqAKIk/yVcSz+63lCQGDNLXEtCbjZfmJqNyyRAeaCHOXf
         SyFFdqzMnnmVJpWt2JJOgACTKbW2jacz9YWj6isXiPaOP8opHzJwqxFx9f2+Tq8TSH+6
         TDUlQRefPZhsKvm5EgYDoNK/TsibUrHaChnFDQZkVAXNOI4bBkr3z4Mlp/uMBHSgF8Kg
         OBPfpJfXZ5W8jq/cNWT6lnyhZ9BEXFArfSrXw9/3vVRec2VKAHOP/HWtLNfgrltHXtSq
         fbDyUNeW44TOiwofbMGjbsVxYRjHXhhwpT9PSoYAIh3t2J3Vlk16Jx42AIdlGDfM4ouJ
         5xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710249925; x=1710854725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JB/fCkc+DY4m42yOK4XJQgiO/OTJKfXykryTXv2ZIvc=;
        b=q6iyOTvdtFGLdZ2kCJxVWSoKHjjXbyRMgtFGV6F2Dgm9e7jwS3N9tmu00eNtk7aTWm
         UkuHXLPXcq1Z8+GhCYGych2nrchkFljUws6Ii933w2qbB9J5g1OB9FfVmAEUlnci3kEz
         RMriXZd8A0tcbRHV8vq/bm1W5O8CR30Ecfhf5VNgdLCUF46cPIknabfkTspTe/rhv3Dd
         7dvFh5C33E5sPsNQ8jpveiSBsUmqJaXlKlJe/qjyqx91KI4qN0Ce4tLgOZY4lMO6UOuT
         APjkSck6gsvpahUUi1WClMDDeXlDeSoF5D0dXPEDKCmPKANNAaIn518LPPCCRF44khWL
         H2Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUxrOjOiHH6AfeiCw0JLoza/2BbEFuhAzhdVh64R5OQudB0MfrajxGsioeHJyfa45PuUQjaAQlwicz6Kb4Oy7PwxUcJl9lcuRND
X-Gm-Message-State: AOJu0YyLovH4UDNWW1fWyr4YGI7Gh/VPrf+EQzBCTJREOroiTDWZwoGu
	6Zk9IeVLNBfuTTIqxIdZLhFTnx2HwNb6pmjwkcQf/VDOYjxmGu01GTHq7WfL7Fh78H039B5RdeL
	o8hHOntYYxruNAbmRRbSl7at0GsCKquRQEL1G
X-Google-Smtp-Source: AGHT+IF1cRnaQFumfUlCRp41/6fgcEMzhcjpf5y7umsfzmg6pOq1H7nSsHfaaBxXD1PgiupfKYVSHQ8j8xk0GqbcK7k=
X-Received: by 2002:a25:8f8c:0:b0:dc2:41de:b744 with SMTP id
 u12-20020a258f8c000000b00dc241deb744mr6886137ybl.32.1710249925381; Tue, 12
 Mar 2024 06:25:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912205658.3432-1-casey@schaufler-ca.com> <20230912205658.3432-6-casey@schaufler-ca.com>
 <20240312101630.GA903@altlinux.org>
In-Reply-To: <20240312101630.GA903@altlinux.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Mar 2024 09:25:14 -0400
Message-ID: <CAHC9VhRgjNT2YnVgCqMJnyr227qUjmfrWZ+LBnu_DGxnJZgeKw@mail.gmail.com>
Subject: Re: [PATCH v15 05/11] LSM: Create lsm_list_modules system call
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 6:16=E2=80=AFAM Dmitry V. Levin <ldv@strace.io> wro=
te:
> On Tue, Sep 12, 2023 at 01:56:50PM -0700, Casey Schaufler wrote:
> [...]
> > --- a/security/lsm_syscalls.c
> > +++ b/security/lsm_syscalls.c
> > @@ -55,3 +55,42 @@ SYSCALL_DEFINE4(lsm_get_self_attr, unsigned int, att=
r, struct lsm_ctx __user *,
> >  {
> >       return security_getselfattr(attr, ctx, size, flags);
> >  }
> > +
> > +/**
> > + * sys_lsm_list_modules - Return a list of the active security modules
> > + * @ids: the LSM module ids
> > + * @size: pointer to size of @ids, updated on return
> > + * @flags: reserved for future use, must be zero
> > + *
> > + * Returns a list of the active LSM ids. On success this function
> > + * returns the number of @ids array elements. This value may be zero
> > + * if there are no LSMs active. If @size is insufficient to contain
> > + * the return data -E2BIG is returned and @size is set to the minimum
> > + * required size. In all other cases a negative value indicating the
> > + * error is returned.
> > + */
> > +SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, size_t __user *, =
size,
> > +             u32, flags)
>
> I'm sorry but the size of userspace size_t is different from the kernel o=
ne
> on 32-bit compat architectures.

D'oh, yes, thanks for pointing that out.  It would have been nice to
have caught that before v6.8 was released, but I guess it's better
than later.

> Looks like there has to be a COMPAT_SYSCALL_DEFINE3(lsm_list_modules, ...=
)
> now.  Other two added lsm syscalls also have this issue.

Considering that Linux v6.8, and by extension these syscalls, are only
a few days old, I think I'd rather see us just modify the syscalls and
avoid the compat baggage.  I'm going to be shocked if anyone has
shifted to using the new syscalls yet, and even if they have (!!),
moving from a "size_t" type to a "u64" should be mostly transparent
for the majority of native 64-bit systems.  Those running the absolute
latest kernels on 32-bit systems with custom or bleeding edge
userspace *may* see a slight hiccup, but I think that user count is in
the single digits, if not zero.

Let's fix this quickly with /size_t/u64/ in v6.8.1 and avoid the
compat shim if we can.

Casey, do you have time to put together a patch for this (you should
fix the call chains below the syscalls too)?  If not, please let me
know and I'll get a patch out ASAP.

Thanks all.

--=20
paul-moore.com

