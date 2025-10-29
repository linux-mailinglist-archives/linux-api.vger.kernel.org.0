Return-Path: <linux-api+bounces-5148-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F85AC1D53D
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 21:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 195A24E2D63
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 20:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7EE312816;
	Wed, 29 Oct 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="HfBfEVYA"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D145312823
	for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771561; cv=none; b=qLgRP9R8a26T28YIwb3TsOIvxJJ0D3ZzylMbrLaCDO1edh743PlMiq5Kgmco2KkNwmS/sJcA1nLnlwjI2xMDEzaXS98JNcctQTnvZRBzcSFmom6lL9An/swhflBJQXZP6CQk0XgmH7Vers3QS+fmDV4+jAF+RpjAyZeDlOO3OAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771561; c=relaxed/simple;
	bh=LbCzKk2cGvRRVZVsuoizSMZfwxwz1pQ654zQNk3mgK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uasJk6j6+bliZdVJtupqx1k3b0oG6kdFUJiRZU6K387IWlc9WG33AfxwfmiO41e8cNtyYCyEdtj0fgRHViA5jUJtIb9KT5QgG8ab6JWEH3Slpg3m2VSvHccymhKVIpitV7dvAicb4dNawoBqiR+E43B0BGDswU1CPKm8KZiil1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=HfBfEVYA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b5a8184144dso53332866b.1
        for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 13:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761771558; x=1762376358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfAN57AJ3VlZrtEXkpg0YM0RNnc6zjLGC6mTJFKCfBA=;
        b=HfBfEVYAm6pKrOzMQIBf8PkgeaLjDBNONliYapp6CWViux2Dk2stZc23yzp+kCiYd6
         eIwPDPx1uHrwbJcnVmI5Pg+8rvb6ndWVMCyoJyvMIZGPC/0eKiQWG+d0VjtgxYlk9evl
         hU8m51IiiPJYZ1y21+dEwj738WlG4fz9y2Phyr9hvRMQ5bkdqPlqOJbERD339Gs9wo64
         GjKXrWjxKA4CDHQkRnR5IY2K/kBV2sW5LUnwQtBQ8cH9Au313zSu3BknGP1fZZD4yZpu
         kt/e7xhhQ2osoba0CbBjrGGZ+/nxysfO43ysnewmOuBtYtgevpout5pD/vq/pm226wsZ
         Gp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771558; x=1762376358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QfAN57AJ3VlZrtEXkpg0YM0RNnc6zjLGC6mTJFKCfBA=;
        b=i5uU6MRgKYwVvOg4QWbFUAA+xCRz4OCbH1TJvPlaVg4KCMQ7nSesgm9+VmrmWkLSJ8
         /Y3BBpMNaBgYpF8EzKKTG2QhmOEUJVdWovVPRJGexMVK6o/GlP164xJkahQKObeO2osE
         rSB5zAaVaYJhnCOP0VHDLvYSwjzT+NVRJ59F6nzzGTUhAW7alAPoWjBzytkDEyeODIph
         XX8Q5SoPShTNhkp5t38kgut2lv6Sovv+G60dVY+QDh5+lrbAgkfViGmsPcthNOoaCdU6
         3C7s49n9175Y04zW8/5Aue1AsQw71OcEUmvwFJEP/IsqE63jBzIy0B/AQ3ek9Nyko1Hz
         AWyw==
X-Forwarded-Encrypted: i=1; AJvYcCUP00YGuYkLOjv9xoMRyES0SvwJECxQ4vorJ4jvsdmNjNo/Z2stgdAbexO0XGhrbptBKEHACZgEUAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiwxaZbJ+UkYgSVaFUVFjMfIqefi1lEGef03GaOkw6iloz8wBd
	UzVjMB+yZ0xX6YkUdkCXg30oPeYrE0srm1k96Zz3Z2F0cqZY37lmgdKJ/LtZohizcgK6dBpyuHb
	EWamgwD2PA+aOyIpWVml6yZ62QqmetJaXtD+EQyVSaQ==
X-Gm-Gg: ASbGncvUj0PtW1ZW3xGsyGWd0Ist00Fw3oJ20F/dnPWpe73KrOBVszy7TDTEQlndxB9
	dsJ7OmNXRQ6SAwtE+Uk0l6HD6IbV9pBTagL6GVYiFKLpJUzda/yeW1TLoyZxXrWN8BCmD/DngsB
	4dj9Um3CAgJvEKahGzDIo2Ye8+6ShQRHctvMTE+RBpN1KNVSUSqFTU8GAr0omvwGgcPbhT8PTv/
	bwVugnZgIrW9ZRgcgSfCwApFcTgYBA2G3KeunA4MoRs2La7Zmo7j0R1ew==
X-Google-Smtp-Source: AGHT+IE/RXMv8hoooZh1E58NXDF0M8rMKt7Jq2/dOGekqdl2XNp/FrTs01ETHE1dw8Wf9fSE9rBqLnrH1cmST40VDnY=
X-Received: by 2002:a17:906:6a10:b0:b5c:753a:a4d8 with SMTP id
 a640c23a62f3a-b703d601679mr444730266b.62.1761771557853; Wed, 29 Oct 2025
 13:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0pla5cuml.fsf@kernel.org>
In-Reply-To: <mafs0pla5cuml.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Oct 2025 16:58:40 -0400
X-Gm-Features: AWmQ_bl42EDPtm_TaUQbgHgrX7gDrKin3DS3aEDrxO6qieGZ-fwZboHP8lat9pQ
Message-ID: <CA+CK2bB6e_=yQ9tQgvh7tJ3q34vCo9v4KpYG8DRF5pRa+YuUrQ@mail.gmail.com>
Subject: Re: [PATCH v4 14/30] liveupdate: luo_session: Add ioctls for file
 preservation and state management
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 4:37=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi Pasha,
>
> On Mon, Sep 29 2025, Pasha Tatashin wrote:
>
> > Introducing the userspace interface and internal logic required to
> > manage the lifecycle of file descriptors within a session. Previously, =
a
> > session was merely a container; this change makes it a functional
> > management unit.
> >
> > The following capabilities are added:
> >
> > A new set of ioctl commands are added, which operate on the file
> > descriptor returned by CREATE_SESSION. This allows userspace to:
> > - LIVEUPDATE_SESSION_PRESERVE_FD: Add a file descriptor to a session
> >   to be preserved across the live update.
> > - LIVEUPDATE_SESSION_UNPRESERVE_FD: Remove a previously added file
> >   descriptor from the session.
> > - LIVEUPDATE_SESSION_RESTORE_FD: Retrieve a preserved file in the
> >   new kernel using its unique token.
> >
> > A state machine for each individual session, distinct from the global
> > LUO state. This enables more granular control, allowing userspace to
> > prepare or freeze specific sessions independently. This is managed via:
> > - LIVEUPDATE_SESSION_SET_EVENT: An ioctl to send PREPARE, FREEZE,
> >   CANCEL, or FINISH events to a single session.
> > - LIVEUPDATE_SESSION_GET_STATE: An ioctl to query the current state
> >   of a single session.
> >
> > The global subsystem callbacks (luo_session_prepare, luo_session_freeze=
)
> > are updated to iterate through all existing sessions. They now trigger
> > the appropriate per-session state transitions for any sessions that
> > haven't already been transitioned individually by userspace.
> >
> > The session's .release handler is enhanced to be state-aware. When a
> > session's file descriptor is closed, it now correctly cancels or
> > finishes the session based on its current state before freeing all
> > associated file resources, preventing resource leaks.
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > ---
> [...]
> > +static int luo_session_restore_fd(struct luo_session *session,
> > +                               struct luo_ucmd *ucmd)
> > +{
> > +     struct liveupdate_session_restore_fd *argp =3D ucmd->cmd;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     guard(rwsem_read)(&luo_state_rwsem);
> > +     if (!liveupdate_state_updated())
> > +             return -EBUSY;
> > +
> > +     argp->fd =3D get_unused_fd_flags(O_CLOEXEC);
> > +     if (argp->fd < 0)
> > +             return argp->fd;
> > +
> > +     guard(mutex)(&session->mutex);
> > +
> > +     /* Session might have already finished independatly from global s=
tate */
> > +     if (session->state !=3D LIVEUPDATE_STATE_UPDATED)
> > +             return -EBUSY;
> > +
> > +     ret =3D luo_retrieve_file(session, argp->token, &file);
>
> The retrieve behaviour here causes some nastiness.
>
> When the session is deserialized by luo_session_deserialize(), all the
> files get added to the session's files_list. Now when a process
> retrieves the session after kexec and restores a file, the file
> handler's retrieve callback is invoked, deserializing and restoring the
> file. Once deserialization is done, the callback usually frees up the
> metadata. All this is fine.
>
> The problem is that the file stays on on the files_list. When the
> process closes the session FD, the unpreserve callback is invoked for
> all files.


> The unpreserve callback should undo what preserve did. That is, free up

Right, we discussed that continous preservation is not going to be
possible. So, this bug is not going to be present in the next version.

