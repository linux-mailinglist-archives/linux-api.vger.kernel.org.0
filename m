Return-Path: <linux-api+bounces-5327-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B17B5C64CF5
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 16:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6517F28D0B
	for <lists+linux-api@lfdr.de>; Mon, 17 Nov 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B759335075;
	Mon, 17 Nov 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="G+FZEsMp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559FE30ACEB
	for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 15:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392210; cv=none; b=Gc7sdUZxmb6X2oCZa+Z48fr17aDrh5kQxMbCpkShr+Nq2OV4F+mMmy8MYTYz0KHKzl8/1mag7K/y6jmObec1evfWwD/+rWI7v0E6rEqerF2FGygVZ0lPq4lXD+UXiE+h0qyLzwgxRon9XmCedU/5hSsqW6vklAL+J1hNtaV0hSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392210; c=relaxed/simple;
	bh=O+V4AMyNh4uVjqUHrTpj49PuAqNdgV98a59O8ozBiT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLTaJK+A+2HHHdjpnaLMNAzXbOUrPSsASDRec3ggWIbWDBuf1yANNB0sDeZYbDrmyjhA3fc3GoXIMMdl2Cl7kn5hEh+3uxS95Jk0XSIhTW7xJJ/o3QJuiUjt8Y/7cjVyUw8Nt3rarsQpDHjeGCCC8qUGYa8qL/XBx3IjIAdk7nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=G+FZEsMp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so5962388a12.2
        for <linux-api@vger.kernel.org>; Mon, 17 Nov 2025 07:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763392205; x=1763997005; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dP2LHZDimsWJcFP9x1EBqhMw+V3jN7gWuVzxTdsDvKU=;
        b=G+FZEsMpJEGAD+DukLY1nz+kdQnSzXrErP3HUeZj4TW8BqWd3f6CP4ciZz1EHCd4+U
         6xjAyi6tp0comxeeuwGGMEhvbwvFz5ro79Ig9Ic8X0+HOOYmYyKAJsM2dGpiWZEwXwd5
         jNScAl3/eXcXas7M3g8oqVKg+RCbcFQaBxxYhfJvVg7k02gn8kfdciKTvCjbyzdz/Ai/
         1yk38Z295oa4+NnMaJU80CKatwlIm1Jfva/g5Fg/9hmC2W0GHRujs1Z6xW63IOevbfkt
         ZiCneHoL02eUJVXQeCUsitRWt9I+OkoS8TEN4riQebQeOIhiQzqFEj7dbdPoemL9sO6C
         wVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392205; x=1763997005;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP2LHZDimsWJcFP9x1EBqhMw+V3jN7gWuVzxTdsDvKU=;
        b=fW63JRA36iC3v2O316SOSCO50KSY3kYopzubc8y54OLZ29jhD47rW/kXqgoW3zlCAH
         LYaugI3QTwbEnD9ie2exO0tVfDMTLD7vBmYMDrgkggeYFDwaPWqgAWKsky6MDNJmrx43
         hRPjpv4qz7Xm2zhi5VA1sdrCtU12CjF3/yMo51T9LaZ4A6x84Vc2hPfNrvVqcM2FHBRZ
         ug+5s3yHgLVwu0cpnpIGzAhlkIoypaoH/QWE6J4SLKsU3W07pkKDuBXSYAISTcAJjlE4
         De7BzLZj3RBbkvydY+9zmOjBUBl5NtJoAaVnwUuTEmMV384fSlhOgaNuJlE99/foMkfN
         8dMA==
X-Forwarded-Encrypted: i=1; AJvYcCVNipv3IlP0DOQwIR+uTu3l4L344M30aPx3i0Z3jkWDLDo3VDcwUFHmF445k5XOe12x5fRfmFVtkhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP8mvPewjUnAqQp+mGA53x51cSbTQR+z4UgmXibkTS6Yh4gzV7
	8VcdSOiNn0cq1x3Cx8PxOdc0pmcnOxK3EHHAF8bzjOk04QKhyI1OIy4DShxVxGFRSfTx8qu2Sm2
	JMEoUcHkubslS2FS+e6Sd288HcaUuJxY3h+fnMo0iDw==
X-Gm-Gg: ASbGncuO1pKb9FF7yXVVlJJOYc3Auv2dOeNVxmqnteM2qxOQ74EwVlKKgvelYrN2yyj
	WnqWmMLv18WTaf1mEWPyIxbg89qqe4kIeX3u1Ke6hdorkoM5Kinfse0LfMMja/MtvuMPuSKtftd
	0wpi4CwGbCu9fHUAU8CfQ1Z9SFyBYsnuwrOgUFiBwpxTExHbXuxpY6kwJcVC/vghQPZP+PPz4DB
	WA9TRWUNtJNpHTjpeD4IDVm0EgqdTilirAV2+VBBrlxqI+8GG0v3Qm9AV/qfUQLTyn6
X-Google-Smtp-Source: AGHT+IE14EI84+1nV9PNUG6pyDkb7Qkp/5p7KJ3U1mYqA34EgSz0oKhHHX1OOhrjgCkHr3Z59mY5mFsJkBFb4s2zZDw=
X-Received: by 2002:a05:6402:2809:b0:640:fb1f:e95c with SMTP id
 4fb4d7f45d1cf-64350e8ecefmr12877833a12.20.1763392205305; Mon, 17 Nov 2025
 07:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-5-pasha.tatashin@soleen.com> <aRoEduya5EO8Xc1b@kernel.org>
In-Reply-To: <aRoEduya5EO8Xc1b@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 10:09:28 -0500
X-Gm-Features: AWmQ_bmj83X6sEGtJOzbfwBfqdKgU7Rrd4Q7eSBnGujAPm0UgvTXUn65F7Vknl4
Message-ID: <CA+CK2bC_z_6hgYu_qB7cBK2LrBSs8grjw7HCC+QrtUSrFuN5ZQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/20] liveupdate: luo_session: add sessions support
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"

> > +/**
> > + * struct luo_session_ser - Represents the serialized metadata for a LUO session.
> > + * @name:    The unique name of the session, copied from the `luo_session`
> > + *           structure.
>
> I'd phase it as
>
>                 The unique name of the session provided by the userspace at
>                 the time of session creation.

Done

>
> > + * @files:   The physical address of a contiguous memory block that holds
> > + *           the serialized state of files.
>
> Maybe add                                    ^ in this session?

Done

>
> > + * @pgcnt:   The number of pages occupied by the `files` memory block.
> > + * @count:   The total number of files that were part of this session during
> > + *           serialization. Used for iteration and validation during
> > + *           restoration.
> > + *
> > + * This structure is used to package session-specific metadata for transfer
> > + * between kernels via Kexec Handover. An array of these structures (one per
> > + * session) is created and passed to the new kernel, allowing it to reconstruct
> > + * the session context.
> > + *
> > + * If this structure is modified, LUO_SESSION_COMPATIBLE must be updated.
>
> This comment applies to the luo_session_header_ser description as well.

Done

>
> > + */
> > +struct luo_session_ser {
> > +     char name[LIVEUPDATE_SESSION_NAME_LENGTH];
> > +     u64 files;
> > +     u64 pgcnt;
> > +     u64 count;
> > +} __packed;
> > +
> >  #endif /* _LINUX_LIVEUPDATE_ABI_LUO_H */
> > diff --git a/include/uapi/linux/liveupdate.h b/include/uapi/linux/liveupdate.h
> > index df34c1642c4d..d2ef2f7e0dbd 100644
> > --- a/include/uapi/linux/liveupdate.h
> > +++ b/include/uapi/linux/liveupdate.h
> > @@ -43,4 +43,7 @@
> >  /* The ioctl type, documented in ioctl-number.rst */
> >  #define LIVEUPDATE_IOCTL_TYPE                0xBA
> >
> > +/* The maximum length of session name including null termination */
> > +#define LIVEUPDATE_SESSION_NAME_LENGTH 56
>
> You decided not to bump it to 64 in the end? ;-)

I bumped it to 64, but in the next patch, I will fix it in the next version.

>
> > +
> >  #endif /* _UAPI_LIVEUPDATE_H */
> > diff --git a/kernel/liveupdate/Makefile b/kernel/liveupdate/Makefile
> > index 413722002b7a..83285e7ad726 100644
> > --- a/kernel/liveupdate/Makefile
> > +++ b/kernel/liveupdate/Makefile
> > @@ -2,7 +2,8 @@
> >
> >  luo-y :=                                                             \
> >               luo_core.o                                              \
> > -             luo_ioctl.o
> > +             luo_ioctl.o                                             \
> > +             luo_session.o
> >
> >  obj-$(CONFIG_KEXEC_HANDOVER)         += kexec_handover.o
> >  obj-$(CONFIG_KEXEC_HANDOVER_DEBUG)   += kexec_handover_debug.o
>
> ...
>
> > +int luo_session_retrieve(const char *name, struct file **filep)
> > +{
> > +     struct luo_session_header *sh = &luo_session_global.incoming;
> > +     struct luo_session *session = NULL;
> > +     struct luo_session *it;
> > +     int err;
> > +
> > +     scoped_guard(rwsem_read, &sh->rwsem) {
> > +             list_for_each_entry(it, &sh->list, list) {
> > +                     if (!strncmp(it->name, name, sizeof(it->name))) {
> > +                             session = it;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +
> > +     if (!session)
> > +             return -ENOENT;
> > +
> > +     scoped_guard(mutex, &session->mutex) {
> > +             if (session->retrieved)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     err = luo_session_getfile(session, filep);
> > +     if (!err) {
> > +             scoped_guard(mutex, &session->mutex)
> > +                     session->retrieved = true;
>
> Retaking the mutex here seems a bit odd.
> Do we really have to lock session->mutex in luo_session_getfile()?

Moved it out of luo_session_getfile(), and added
lockdep_assert_held(&session->mutex); to luo_session_getfile


> > +int luo_session_deserialize(void)
> > +{
> > +     struct luo_session_header *sh = &luo_session_global.incoming;
> > +     int err;
> > +
> > +     if (luo_session_is_deserialized())
> > +             return 0;
> > +
> > +     luo_session_global.deserialized = true;
> > +     if (!sh->active) {
> > +             INIT_LIST_HEAD(&sh->list);
> > +             init_rwsem(&sh->rwsem);
> > +             return 0;
>
> How this can happen? luo_session_deserialize() is supposed to be called
> from ioctl and luo_session_global.incoming should be set up way earlier.

No LUO was passed from the previous kernel, so
luo_session_global.incoming.active stays false, as it is not
participating.

> And, why don't we initialize ->list and ->rwsem statically?

Good idea, done.

> > +     }
> > +
> > +     for (int i = 0; i < sh->header_ser->count; i++) {
> > +             struct luo_session *session;
> > +
> > +             session = luo_session_alloc(sh->ser[i].name);
> > +             if (IS_ERR(session)) {
> > +                     pr_warn("Failed to allocate session [%s] during deserialization %pe\n",
> > +                             sh->ser[i].name, session);
> > +                     return PTR_ERR(session);
> > +             }
>
> The allocated sessions still need to be freed if an insert fails ;-)

No. We have failed to deserialize, so anyways the machine will need to
be rebooted by the user in order to release the preserved resources.

This is something that Jason Gunthrope also mentioned regarding IOMMU:
if something is not correct (i.e., if a session cannot finish for some
reason), don't add complicated "undo" code that cleans up all
resources. Instead, treat them as a memory leak and allow a reboot to
perform the cleanup.

While in this particular patch the clean-up looks simple, later in the
series we are adding file deserialization to each session to this
function. So, the clean-up will look like this: we would have to free
the resources for each session we deserialized, and also free the
resources for files that were deserialized for those sessions, only to
still boot into a "maintenance" mode where bunch of resources are not
accessible from which the machine would have to be rebooted to get
back to a normal state. This code will never be tested, and never be
used, so let's use reboot to solve this problem, where devices are
going to be properly reset, and memory is going to be properly freed.

