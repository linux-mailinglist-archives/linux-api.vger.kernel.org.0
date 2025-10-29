Return-Path: <linux-api+bounces-5144-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C386EC1D2D1
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 21:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0909534BC65
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 20:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D533A35A153;
	Wed, 29 Oct 2025 20:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Q2aEghgF"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C32EC557
	for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761768836; cv=none; b=IeQrDHZ9HWjFsNhwu8LH8DW2QKlpvngtZj5P5V48cG7UrqMwDsOjqoymFynJgU+MAbWT2ECFUVWJXX6ddXIf2B9Al74iH4vNM4LHx7gIaLpI1wjI/urzGmOuU2L74xWeSweSmTyeqoGs3YG8CiH4KzUYQ6yutwCS1BRpbIdZKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761768836; c=relaxed/simple;
	bh=/m2x2MhZTK99jvIZnV9WiC+2RFNXEYnnV84Nk0+ZbG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S491EcuY6KpQvZGb4DnrIm+TntPnFTp7+t9jjqTPH2O8Z4qOjoAsop0pD6BkEtjmnlT4dRVCjtCgeUTaHknj46C+4Po9XDF6ef11cWxWymxPbt8Ve/T1ScGEnWUpGBfK0bZrfDUq4bcy77uf7fsFgUQO2arAlc9rIxLiaZKYvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Q2aEghgF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5e19810703so40963666b.2
        for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 13:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761768832; x=1762373632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxNKUqsLJOnot7UUBS6WN0bVpwUbu+IjTrx41B9jW8k=;
        b=Q2aEghgF/7lpX6vBLcltuHqDvb/zoSnI23KkhfLsKYxkbO+nBX2L5QfOL3XW1RHs7r
         36q83zQArkvdhhKBd3pqX4c8u1IomZBP/ZZH47BiMi4w0UBYOPiSQHX3YiP4LGAgEwvY
         JZb4hkg+H8BbZxRIqI0dN8+fLdGo1WUTJVh0L+Kc6q4TRCHpPAmmbf4v2Ldbbkk2/JgA
         e1BUpVop5VfPvOK78pj0UwKGo/3De+6wUmy2yyIkVlD/Bv1Zj1RQuu5P8nV50hC+lJSu
         blJWDQhu/3JMniqh2qcZqrj6FFf2L3hKJ4PK6IR4y9hWKXj+2xmAderMD/Aggw1eVJk1
         ZO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761768832; x=1762373632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxNKUqsLJOnot7UUBS6WN0bVpwUbu+IjTrx41B9jW8k=;
        b=UzN+wv2rdAS2u8lu2wQU/Pr2US3WbIufTbYd21Gjms7RkW0yicC1SnNfSicQL/fqnv
         xwR7PQYwCYq5lWmnvpM6pwjjOluLTPD+4OQyPoz6noHAzihm4ibjB8oqlOU07xLIEOlA
         Nnq8my+gf0rSV327LzQF2jMtvhmG7AUI5t6K4uFi5td77qS+s3ahkkfeaXYpr/qcA0u1
         aEKTJwQbvfXRhZfliOjuWU0u0Ui2WO3CZgxtkKqDqg1Q/MTWbKjNnZsCeQMmmF+zRPtR
         5Cm6xCHvyRXvkyCpnuzGSU25T6nMrAvDXxvutVb1EwUom8UncRhx1vTLgh/wuMaTNjDm
         5otw==
X-Forwarded-Encrypted: i=1; AJvYcCWbc3YtsRScgUhUOVN9D2GBDxzxfRPGBrarPdS5zwNx7emvI8+XxvHv08Ou0abIWTVAtP4y/orPhoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxfTs74yRpQwKJq33QMvkBgRXJ46q4QpClNGlCYXLIg6Gm5MyV
	EKqet1lPm8YEVBlhrXnsYGlPYyYDtDUOMMLDBitt8vrOVGAjOPTQpEKHSSiIN588P/WWh+bxRx2
	tQ7r0JNYyfZT9Ys3CbBepRTNzwYnYsR7XqXgccCPzYQ==
X-Gm-Gg: ASbGncvYAJFdyGEaUGMfU23oFkR6AdRhq+Q4VTwWMczFF5bu8hgc0xV2fs2At7GmKf6
	WpSuh8d7dwiI5gtkPI8XEPBL2x0DGJqDJK0Vr/63hqqhiLcQLTZAu1nU6n67Nd+VR33jtnwN4+s
	wjUKmOPF6TJttpRPFb4a4ds/JrU7MJ3xfgGU/eGibWWxrLoI617dyzTvaZGmLiTPDnfd9qJd4fm
	5gQpKv0Y7hcbFYsD0Zt8Br2wARJMiQnFvcTbemnS4eJnlYdRcTAGqGeVu3WJ93ZUspF
X-Google-Smtp-Source: AGHT+IGrqbF9PW88BwcvYbeFbvOXRwoCun/iE1ZSEaorTMP1Ihb1MtG0h6t2CJQLQRZKh3kqkmFzEpEHa7ehLYOu0M8=
X-Received: by 2002:a17:907:72c4:b0:b45:60ad:daf9 with SMTP id
 a640c23a62f3a-b7053b0cf7amr50121266b.3.1761768831381; Wed, 29 Oct 2025
 13:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <20250929010321.3462457-15-pasha.tatashin@soleen.com> <mafs0tszhcyrw.fsf@kernel.org>
In-Reply-To: <mafs0tszhcyrw.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 29 Oct 2025 16:13:14 -0400
X-Gm-Features: AWmQ_bnKVfAOoreyDJlaPrAp9h8ss-TNKXA3PtoSrf7r-Gv5W7RZKx9AA8z_D0k
Message-ID: <CA+CK2bBVSX26TKwgLkXCDop5u3e9McH3sQMascT47ZwwrwraOw@mail.gmail.com>
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

On Wed, Oct 29, 2025 at 3:07=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
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
> [...]
> > +/**
> > + * struct liveupdate_session_get_state - ioctl(LIVEUPDATE_SESSION_GET_=
STATE)
> > + * @size:     Input; sizeof(struct liveupdate_session_get_state)
> > + * @incoming: Input; If 1, query the state of a restored file from the=
 incoming
> > + *            (previous kernel's) set. If 0, query a file being prepar=
ed for
> > + *            preservation in the current set.
>
> Spotted this when working on updating my test suite for LUO. This seems
> to be a leftover from a previous version. I don't see it being used
> anywhere in the code.

thank you will remove this.

> Also, I think the model we should have is to only allow new sessions in
> normal state. Currently luo_session_create() allows creating a new
> session in updated state. This would end up mixing sessions from a
> previous boot and sessions from current boot. I don't really see a
> reason for that and I think the userspace should first call finish
> before starting new serialization. Keeps things simpler.

It does. However, yesterday Jason Gunthorpe suggested that we simplify
the uapi, at least for the initial landing, by removing the state
machine during boot and allowing new sessions to be created at any
time. This would also mean separating the incoming and outgoing
sessions and removing the ioctl() call used to bring the machine into
a normal state; instead, only individual sessions could be brought
into a 'normal' state.

Simplified uAPI Proposal
The simplest uAPI would look like this:
IOCTLs on /dev/liveupdate (to create and retrieve session FDs):
LIVEUPDATE_IOCTL_CREATE_SESSION
LIVEUPDATE_IOCTL_RETRIEVE_SESSION

IOCTLs on session FDs:
LIVEUPDATE_CMD_SESSION_PRESERVE_FD
LIVEUPDATE_CMD_SESSION_RETRIEVE_FD
LIVEUPDATE_CMD_SESSION_FINISH

Happy Path
The happy path would look like this:
- luod creates a session with a specific name and passes it to the vmm.
- The vmm preserves FDs in a specific order: memfd, iommufd, vfiofd.
(If the order is wrong, the preserve callbacks will fail.)
- A reboot(KEXEC) is performed.
- Each session receives a freeze() callback to notify it that
mutations are no longer possible.
- During boot, liveupdate_fh_global_state_get(&h, &obj) can be used to
retrieve the global state.
- Once the machine has booted, luod retrieves the incoming sessions
and passes them to the vmms.
- The vmm retrieves the FDs from the session and performs the
necessary IOCTLs on them.
- The vmm calls LIVEUPDATE_CMD_SESSION_FINISH on the session. Each FD
receives a finish() callback in LIFO order.
- If everything succeeds, the session becomes an empty "outgoing"
session. It can then be closed and discarded or reused for the next
live update by preserving new FDs into it.
- Once the last FD for a file-handler is finished,
h->ops->global_state_finish(h, h->global_state_obj) is called to
finish the incoming global state.

Unhappy Paths
- If an outgoing session FD is closed, each FD in that session
receives an unpreserve callback in LIFO order.
- If the last FD for a global state is unpreserved,
h->ops->global_state_unpreserve(h, h->global_state_obj) is called.
- If freeze() fails, a cancel() is performed on each FD that received
freeze() cb, and reboot(KEXEC) returns a failure.
- If an incoming session FD is closed, the resources are considered
"leaked." They are discarded only during the next live-update; this is
intended to prevent implementing rare and untested clean-up code.
- If a user tries to finish a session and it fails, it is considered
the user's problem. This might happen because some IOCTLs still need
to be run on the retrieved FDs to bring them to a state where finish
is possible.

This would also mean that subsystems would not be needed, leaving only
FLB (File-Lifecycle-Bound Global State) to use as a handle for global
state. The API I am proposing for FLB keeps the same global state for
a single file-handler type. However, HugeTLB might have multiple file
handlers, so the API would need to be extended slightly to support
this case. Multiple file handlers will share the same global resource
with the same callbacks.

Pasha

> > + * @reserved: Must be zero.
> > + * @state:    Output; The live update state of this FD.
> > + *
> > + * Query the current live update state of a specific preserved file de=
scriptor.
> > + *
> > + * - %LIVEUPDATE_STATE_NORMAL:   Default state
> > + * - %LIVEUPDATE_STATE_PREPARED: Prepare callback has been performed o=
n this FD.
> > + * - %LIVEUPDATE_STATE_FROZEN:   Freeze callback ahs been performed on=
 this FD.
> > + * - %LIVEUPDATE_STATE_UPDATED:  The system has successfully rebooted =
into the
> > + *                               new kernel.
> > + *
> > + * See the definition of &enum liveupdate_state for more details on ea=
ch state.
> > + *
> > + * Return: 0 on success, negative error code on failure.
> > + */
> > +struct liveupdate_session_get_state {
> > +     __u32           size;
> > +     __u8            incoming;
> > +     __u8            reserved[3];
> > +     __u32           state;
> > +};
> > +
> > +#define LIVEUPDATE_SESSION_GET_STATE                                 \
> > +     _IO(LIVEUPDATE_IOCTL_TYPE, LIVEUPDATE_CMD_SESSION_GET_STATE)
> [...]
>
> --
> Regards,
> Pratyush Yadav

