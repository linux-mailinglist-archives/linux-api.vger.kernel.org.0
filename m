Return-Path: <linux-api+bounces-4700-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E98B423CF
	for <lists+linux-api@lfdr.de>; Wed,  3 Sep 2025 16:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A3817FFE0
	for <lists+linux-api@lfdr.de>; Wed,  3 Sep 2025 14:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C495B1F2BAB;
	Wed,  3 Sep 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSi6pZm2"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BD81DE885
	for <linux-api@vger.kernel.org>; Wed,  3 Sep 2025 14:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756910011; cv=none; b=laPlX85r8gyLvcONMwOH1ZgOwB70jI/VkDiSybceSVzVzQl1QSu0JcoWsWvmxh3b442Q7kyPPIFgWZAofjgpBsABXzGPeoeI9wyo/6BjrOowrvorR719SyFkYPtcuNbh/WgbDXNd9drouIKSTVpoSm43mW/9gu4mAHTh5KeZLn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756910011; c=relaxed/simple;
	bh=mN+DFqUSjq5f9r02NjoBUh5IAC76LU3cKV+wGR4z25A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RhOLan2Iv5PnOzY5KQWqP15TbHw39+iEpV42lw9fac4FsIUtiuODgsiE65Tq+R1tsPn1JGyLsWDUnw2DIAQM/CKyjhESKPHs3nIeS6VyC48y91q/x42hyPRqe488yYRodjT+Panaof60/GyveQLmC29zG/krpiEGgWaSPJ5gAHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hSi6pZm2; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-74526ca7a46so2306689a34.2
        for <linux-api@vger.kernel.org>; Wed, 03 Sep 2025 07:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756910009; x=1757514809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLU//N//aBMAruTqJ7Q2JMfNgrJ8rE+drbjx9mqZ9YE=;
        b=hSi6pZm2xmW3AsYBb5ch2mF8vWSVfeXxNpiFVAaut361IgxnZc1e58mBrnfYrZLPFt
         u2fuYohRUS6sXdqGybcdIAdKFMfQeKZ3nEyuXYfM1tWmfyfW4FsJM7fEVXlRFjiGGrMH
         WmRAEL9qWl7G/GS+CBcqT3tAuZZ+QimFBJuHlW+YyiEL8c/OFwSK3FnPqsEMbL5oIKw3
         fY0zDk0No9zgjJ5NO++nlM/dZlYDteLpkIkBMDZ5mjaFy1b6cZQBo3F9g8RhBqfdyost
         K8D0rvOvl9QVY+siVgsymQjSH5zUQwnwXDYl9bEd8HsvbuImE1E+dClJOpD+apZHHdKr
         fsIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756910009; x=1757514809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLU//N//aBMAruTqJ7Q2JMfNgrJ8rE+drbjx9mqZ9YE=;
        b=ISe+V3uhsKMtk4pDOPake4XSQNvBAURpLi4aILDFXNkNKNeXlHhYnk1K9qrqhaotbP
         S8plF26nrTUd5TsxhjQPnYWUOraVqmKoFvDOppamHGXmccF9c+vnwWWbnA+UAMxaG2NP
         iI/YNBpbU1v4mVe/tCWJL6DkfzX3Uvq+2lwXyetgB8tN07jXGfWttLMutDW19cQtVAkR
         5XRlsaPyuS2gKTsCqaXTtb4vS+MpynuNuNQA4ow2UgeicHzlo98KB87iIJKUa465b0KK
         dOUbi6aOjPMTrAgnIAP9S3MxFsQWV4lX7IWUsNoZ0R0Mtbp2OYAGczO9+Mxn/LxW4qlx
         L0fg==
X-Forwarded-Encrypted: i=1; AJvYcCU+C7IoHkrySCW2mVrC1aXFRAjcmWrVa6bFktGoGwU9SsCZV6aQe6s3sS2Nk5Bm3sGRv0lZ6OwqGb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YznIpmBQSdVdVIKjW1HMUNkodG9tXpRCdneR2SSm8Pri+RLGrFp
	eeE+i8kBnQnVZ7Nt1PQlbYP9Dxb6+6pXiiuYVp34evD5nhW2DMAcUL+kzhhdVVSRgGor/cGBs+D
	O/csEPM0dYXTB9r/OGpsQkfpl71ApQyb+HdVvO544
X-Gm-Gg: ASbGnctImc71p1rciwOJpwdm78QK6+SlEcgrIwamymCkugBRJXMPE/FlEgomJD1lKW7
	hjdLWQl019Q+YO9sCaBTHq8UASv59HO8Jo8T9UmBCxcEFpCgk1yJTk+GQG+AqrpvN7AFVQGsDEY
	k1FAjNVhLkYqqa6DPvmQ7RZTehbvfKSDPGa8Hz0rVZJY38GDc2co2Ov7trbAAU9Jhg1DMTIbH0i
	peU7tC5xDQ=
X-Google-Smtp-Source: AGHT+IHvSk//3LTeEfuGYCKWfnWv8g6wvm4GugPnCqvHD49sPPnunOhty8mIYAbVsVQGuhUphHu04cqzzgBv1CDroyM=
X-Received: by 2002:a05:6808:222a:b0:434:689:6c10 with SMTP id
 5614622812f47-437f7d994cfmr8309357b6e.37.1756910008794; Wed, 03 Sep 2025
 07:33:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org> <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu> <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu> <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu> <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
 <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu> <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
 <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu> <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
 <CAJgzZooK+w7NTjsFV_0c=SmPSnsSMiWXFgnvcw=w3msj7NBY9A@mail.gmail.com> <CAG_osabF4nynNNFc=CP_ZFqZ_iJr47VXTJpsN75CzX+Pi+CgEQ@mail.gmail.com>
In-Reply-To: <CAG_osabF4nynNNFc=CP_ZFqZ_iJr47VXTJpsN75CzX+Pi+CgEQ@mail.gmail.com>
From: enh <enh@google.com>
Date: Wed, 3 Sep 2025 10:33:17 -0400
X-Gm-Features: Ac12FXxbDm3wY24oq5q5UA3h8CGbY4HVmeYYeGCDBDki8uRgyyPhjVX-fk1wBRA
Message-ID: <CAJgzZooC-CQ3DDtgzffKEuoLguXW-GUHgayc+N8vEsZS-XyCww@mail.gmail.com>
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Arjun Shankar <arjun@redhat.com>
Cc: Paul Eggert <eggert@cs.ucla.edu>, Aleksa Sarai <cyphar@cyphar.com>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, libc-alpha@sourceware.org, 
	linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 8:10=E2=80=AFAM Arjun Shankar <arjun@redhat.com> wro=
te:
>
> Hello!
>
> > > Earlier on in this thread, Aleksa mentioned sched_setattr as
> > > establishing precedent for the kernel modifying non-const objects. It
> > > looks like glibc actually does provide a sched_setattr wrapper since
> > > 2.41. The relevant argument hasn't been marked as const and the kerne=
l
> > > does modify the contents, and glibc's syscall wrapper simply passes i=
t
> > > through. So we already do this.
> >
> > given that
> >
> > SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, =
uattr,
> >                                unsigned int, flags)
> >
> > calls sched_setattr(), which is defined thus:
> >
> > int sched_setattr(struct task_struct *p, const struct sched_attr *attr)
> > {
> >         return __sched_setscheduler(p, attr, true, true);
> > }
> >
> > i think that's just a copy & paste mistake in the kernel -- carefully
> > preserved in glibc and bionic -- no?
> >
> > (i only see the kernel updating its own _copy_ of the passed-in struct.=
)
>
> Based on my understanding, it all happens before the call to the const
> marked sched_setattr. Starting from line 986 (as of today) on the same
> syscalls.c file [1]:
>
>         retval =3D sched_copy_attr(uattr, &attr);
>         if (retval)
>                 return retval;
>
> Which inside sched_copy_attr does:
>
>         ret =3D copy_struct_from_user(attr, sizeof(*attr), uattr, size);
>         if (ret) {
>                 if (ret =3D=3D -E2BIG)
>                         goto err_size;
>
> And that leads to:
>
> err_size:
>         put_user(sizeof(*attr), &uattr->size);
>         return -E2BIG;

oh, wow. it didn't even occur to me to look inside a function called
sched_copy_attr(), though the fact that it wasn't a direct call to
copy_struct_from_user() should perhaps have been a clue :-(

> Which writes to userspace.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/kernel/sched/syscalls.c?id=3De6b9dce0aeeb91dfc0974ab87f02454e24566182#n9=
86
>
> --
> Arjun Shankar
> he/him/his
>

