Return-Path: <linux-api+bounces-1095-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B55B87118B
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 01:19:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B221C21A1D
	for <lists+linux-api@lfdr.de>; Tue,  5 Mar 2024 00:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41067FD;
	Tue,  5 Mar 2024 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e/gUSg1O"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5346B5
	for <linux-api@vger.kernel.org>; Tue,  5 Mar 2024 00:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597922; cv=none; b=PRYw4VcBAqUR/q2VS8oWmTXaXX8kW/1xdxTHpk8aZ1T6/A40TXj3ARy377cnXZ7U0wQRQLYWL5I8i/q1wb3+kVuJd26nu87Fkf1xm67lt8YYAyL9ROxNnte1T5EN7jdm/YrHEwigd3xcwUlYyIgzFJI1fYO5T82il4dN3byqd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597922; c=relaxed/simple;
	bh=VTzSWIU3sNO28fCSe6cT8ghbqucqlQTDM5Ytu0OqlaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qcXtrULahB4ZXjw9sijosFZmIaX13tY/BC6bTbbeAp3OfGAELghjDQbkKZB5CRwK/Knc4fpVkxggcmAJ9u3ef/WrTbOD7guK82WKuG0/HCJRAKiX3cfNWVM4qAKcIdmOoEpHYm6NGUCMtMck94vHXace27PSuS/lTyUahTSaPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e/gUSg1O; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-607f8894550so34899697b3.1
        for <linux-api@vger.kernel.org>; Mon, 04 Mar 2024 16:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709597920; x=1710202720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4eHKrWkcXgUL3+cyRGRJ5RxD+f+Xd066rGA238lEtiA=;
        b=e/gUSg1OMrK9WOS8tH3GK6WmQRzZa0FfbZJak5S49RkU9uCN3YBQL7LnCjdhGxyNpp
         xdxEASW6FmoyAEF53WSdVraHRjhQm+dRVWXP+WTs/DOQsb88j6flfnHsMnp4bQ/VelwB
         BEusHoHGSqVPrEp6o4GlIq4aJ+0WfJXfW/SO9DF4+K0PiNoEnb9F78/rMPKa8Dz0524i
         hT/UF1sF/CATkBcOkhoOiJZmSC298d0f2CbNNBc4JSiYqfz1AX8LUUx82Dc/I74WObM9
         gKgYeYPN/TQvdSO4yQd0KgKJ5i8iFsmhOz/JwxXA5SZC1mfPjSyv9KhoiHhSsmsrEuuP
         dpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709597920; x=1710202720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eHKrWkcXgUL3+cyRGRJ5RxD+f+Xd066rGA238lEtiA=;
        b=KxxWTg9twQITZNDXCQLcuDvMs74w5jdFJCEyUPSwLU7iik1hY0V0ZTFAT3LK6oURiH
         kdbLuV2Z5iuD2MPF8RaW1ZtWMDF0Al5t/JIVJ3kUqY7mmIpbSnpmWSqzBBW4efAFPs/J
         Wwp6hZtsYBYf48oZ9GciPuqwzkp1/Vplh/H4FC7NrD5bOWbZthFATpQMBTTnyVdvcoSj
         OErm++sUVgo9ZPX4tGO2Auys4eC/D7ZBOr+0LI/PmB/zGN00ea0Tr7lbcXZNRGtaVO06
         aZL63+MZMMixBJTeEtjd3DHfj1ncogIqv9JGtcdNWIVRCVsOabUKWfP3HG50PldCv9hg
         /LJg==
X-Forwarded-Encrypted: i=1; AJvYcCXosN8ir5pIKqlo08CAqmVt3DuGIqiCVJR+ZLJyXLTmCHiEf61LbO75oxItpAMFEkK3XE3osWqsODh5eI21p/7fnOMb1ZA9oZpV
X-Gm-Message-State: AOJu0YymdzIbDu6mmIDzSKVZOhJwjappdVuL4ou0to2HdLij96a9xEFE
	4DVYo1qtyEyZW7om55DpEeY3Msl8p1ZMRiYO/Ttrovla9kXf5kF5vGDJU2n6QR54ufrzz2qchP6
	zJVTOhMQdjH0Ey5bSxRHgXLANLyzTjmunSIXo
X-Google-Smtp-Source: AGHT+IEuOV8CtKSYv9TlMNtV4mWkx5qUhIjY+TlAmFbtZ/idB3rPBVPTKrR4WP3lU3dvTKEemj682oUlph5REmziOcs=
X-Received: by 2002:a0d:ca57:0:b0:609:8fd6:f0d4 with SMTP id
 m84-20020a0dca57000000b006098fd6f0d4mr7399086ywd.42.1709597919919; Mon, 04
 Mar 2024 16:18:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUIlirG-ypudgpbK@debian> <20240303121454.16994-3-alx@kernel.org>
 <5882437.otsE0voPBg@nimes> <ZeRzS6mENO8kOh1W@debian>
In-Reply-To: <ZeRzS6mENO8kOh1W@debian>
From: enh <enh@google.com>
Date: Mon, 4 Mar 2024 16:18:28 -0800
Message-ID: <CAJgzZor8TTSysM=TiTXQdVtHMZPQWu5YOhPmb8PAevdVd-c31Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration' rather
 than 'request'
To: Alejandro Colomar <alx@kernel.org>
Cc: Bruno Haible <bruno@clisp.org>, Stefan Puiu <stefan.puiu@gmail.com>, linux-man@vger.kernel.org, 
	GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 3, 2024 at 4:55=E2=80=AFAM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> Hi Bruno,
>
> On Sun, Mar 03, 2024 at 01:45:37PM +0100, Bruno Haible wrote:
> > Alejandro Colomar wrote:
> > >  man2/clock_nanosleep.2 | 20 ++++++++++----------
> > >  man2/nanosleep.2       | 12 ++++++------
> >
> > The change to nanosleep.2 seems mostly fine. Except that the
> > term "requested relative duration" (line 142) raises questions;
> > what about changing that to "requested duration"?
>
> Yeah, I had doubts about that one.  Probably I should drop 'relative'.
>
> >
> > The change to clock_nanosleep.2 seems wrong. There are two cases
> > (quoting the old text):
> >
> >        If flags is 0, then the value specified in request is interprete=
d
> >        as an interval relative to the  current  value  of  the  clock
> >        specified by clockid.
> >
> >        If  flags  is  TIMER_ABSTIME,  then request is interpreted as an
> >        absolute time as measured by the clock, clockid.  If request is
> >        less than or equal to the current value of the clock, then
> >        clock_nanosleep() returns immediately without suspending the  ca=
lling
> >        thread.
> >
> > In the first case, the argument is a duration. In the second case, the
> > argument is an absolute time point; it would be wrong and very confusin=
g
> > to denote it as "duration".
>
> Hmm, thanks!  I guess we'll have to keep 'request' in clock_nanosleep(3)
> unless someone comes up with a better name.  Elliott, you may want to
> partially revert that change in bionic.

thanks! https://android-review.googlesource.com/c/platform/bionic/+/2987070
changes to

/**
 * [clock_nanosleep(2)](http://man7.org/linux/man-pages/man2/clock_nanoslee=
p.2.html)
 * sleeps for the given time (or until the given time if the TIMER_ABSTIME =
flag
 * is used), as measured by the given clock.
 *
 * Returns 0 on success, and returns -1 and returns an error number on fail=
ure.
 * If the sleep was interrupted by a signal, the return value will be `EINT=
R`
 * and `remainder` will be the amount of time remaining.
 */
int clock_nanosleep(clockid_t __clock, int __flags, const struct
timespec* _Nonnull __time, struct timespec* _Nullable __remainder);


> Have a lovely day!
> Alex
>
> --
> <https://www.alejandro-colomar.es/>
> Looking for a remote C programming job at the moment.

