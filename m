Return-Path: <linux-api+bounces-1366-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 120768B181B
	for <lists+linux-api@lfdr.de>; Thu, 25 Apr 2024 02:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36AB41C236D7
	for <lists+linux-api@lfdr.de>; Thu, 25 Apr 2024 00:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25B8210D;
	Thu, 25 Apr 2024 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="Ls+97lZT"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483EA15C0
	for <linux-api@vger.kernel.org>; Thu, 25 Apr 2024 00:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005796; cv=none; b=Z+/Y0+uRZcGO8+xuyJus/YK1wmbDnFWAhrq3pxYmUfhwpmuC6VfL+R49WG6z7tc3fcXUMtJq5MTcfJqt3HkDor5tXch/IigOP4XbrvshoNgspEb0yObzRbeVuKHGuu6l6T/T6ogRXJbFAPg5Jgdw+6MbaZuIiNoQI3GDTk3qEbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005796; c=relaxed/simple;
	bh=236gG8N4hj2YoDKj8i1xC+LA41Hwr3up0ZGcQlhtubw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jZdu2SUKj6KcY5juzI3BsjV2aErgAM8o0ON2GC0aO+FA3dceBVP1Zm/MRavQBl1oMpNCKGRxXrTPIJna1ie5E0cXMBFEB0as30nbwZ/kp+67/sfwxkErcyNCQSSEpdtokVcyslKWzTh/GhLbzbKQnXUQEtgQjdMq6ZXysuaD9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=Ls+97lZT; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4dac112e142so137705e0c.1
        for <linux-api@vger.kernel.org>; Wed, 24 Apr 2024 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714005794; x=1714610594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR7n1uhPFN3B2i3X955I2o/YTQLtqjqYe3qbWIU7RC4=;
        b=Ls+97lZTFoJ2/KChiAz0ijZpt+w8uKkyx0sDOpeeR2wRJst8ppj7IQMNXK9YVsfify
         KoldSLY5TOixc/CYJyNmoOIazKBu0O+8EAqWAX2KkZ9TAs0DCI8gxS9zjsxYjn1CKJH7
         PbXCVxti/h7UYwMEyc3k3ILN4giSD9R5dq1B1UKU80WGrP7FUY+jrywp8RsI/yMW1O/o
         Ec3sLVg0flnk54tkfSDXo5pofBMFom1oY/kALI1e7e6RTggr/8BP48Jy9/KGp6A9c1m5
         69ZFDoNxsXokabU95Vt4hFjFP5loY+NeWmG/5sPqG2tKPo6FF6QUc8CVEwBb2O7951xc
         Hp5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714005794; x=1714610594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fR7n1uhPFN3B2i3X955I2o/YTQLtqjqYe3qbWIU7RC4=;
        b=ZqXlLQ3VsrCQfAupXjkBnHFQ8h+NECnGnb0+IBuBoxbl+Ev/4damY3sb/O/oZxkwbv
         +JraQtEA9bDsJWMfJjDbt6xnGTXEoMBlcyiuUlAKubQlyhMKzrJ2l3fNEyWDcJgq2RQ5
         DMqEUpyGjyJ2kRtCSRVViKkEx0z3N3RqRj0By4s7MwwLbh9z6O4QkKX1e7oMZVM8OHPf
         Zi/V3+MK9RdD038/reevcexQ60r4qEmFi4/m2m0xL20fHVnQ3KtoCP6WLo4vGnSGMB/V
         pTsjFsRcoD/nryP0dbwoiAHsg1gwoPZIAy8Rfi2a6UoVjQiday26GbTL+1zRbV7JdUtd
         By9w==
X-Forwarded-Encrypted: i=1; AJvYcCXwHxKe6yexbIhNoG6aHw3aocIwbAA/xiawGpT/rrtxPXjl0oBvQx99HlHQmelP14Ozu5fM7guiAah9kzjUQ3DNEsamxyLWkW6f
X-Gm-Message-State: AOJu0YwgPo5sJ0/ihsIU0+6t3HWGiU2PwvjqvHhqd3NnTFuWJFcdDwEu
	axnNb82C6SPxjojvSf+wHdjp1GiNNZTz5+rtuCH5ooXQrXNyq+H4YL5NvqQQpV+7pLSuY8Dkguq
	5tYNmGiPqgIRd2IsrVZ/JkLkvuYzbD1Bkk43q
X-Google-Smtp-Source: AGHT+IGDxdao24yBIAE6mF2nR1EaA/sS73/iozSWk/HWHCQsnJdooMo1NGAL8N9vsDwXEby001pQKmbZiPPUcRArhTo=
X-Received: by 2002:a05:6122:790:b0:4d4:1ec7:76e5 with SMTP id
 k16-20020a056122079000b004d41ec776e5mr4505317vkr.16.1714005793771; Wed, 24
 Apr 2024 17:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423110148.13114-1-stsp2@yandex.ru> <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
 <0e2e48be-86a8-418c-95b1-e8ca17469198@yandex.ru>
In-Reply-To: <0e2e48be-86a8-418c-95b1-e8ca17469198@yandex.ru>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 24 Apr 2024 17:43:02 -0700
Message-ID: <CALCETrWswr5jAzD9BkdCqLX=d8vReO8O9dVmZfL7HXdvwkft9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
To: stsp <stsp2@yandex.ru>
Cc: linux-kernel@vger.kernel.org, Stefan Metzmacher <metze@samba.org>, 
	Eric Biederman <ebiederm@xmission.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:57=E2=80=AFAM stsp <stsp2@yandex.ru> wrote:
>
> 23.04.2024 19:44, Andy Lutomirski =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> On Apr 23, 2024, at 4:02=E2=80=AFAM, Stas Sergeev <stsp2@yandex.ru> wr=
ote:
> >>
> >> =EF=BB=BFThis patch-set implements the OA2_INHERIT_CRED flag for opena=
t2() syscall.
> >> It is needed to perform an open operation with the creds that were in
> >> effect when the dir_fd was opened. This allows the process to pre-open
> >> some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
> >> user, while still retaining the possibility to open/create files withi=
n
> >> the pre-opened directory set.
> > I like the concept, as it=E2=80=99s a sort of move toward a capability =
system. But I think that making a dirfd into this sort of capability would =
need to be much more explicit. Right now, any program could do this entirel=
y by accident, and applying OA2_INHERIT_CRED to an fd fished out of /proc s=
eems hazardous.
>
> While I still don't quite understand
> the threat of /proc symlinks, I posted
> v4 which disallows them.
>

I like that, but you're blocking it the wrong way.  My concern is that
someone does dfd =3D open("/proc/PID/fd/3") and then openat(dfd, ...,
OA2_INHERIT_CRED);  IIRC open("/proc/PID/fd/3") is extremely magical
and returns the _same open file description_ (struct file) as PID's fd
3.

> > So perhaps if an open file description for a directory could have somet=
hing like FMODE_CRED, and if OA2_INHERIT_CRED also blocked .., magic links,=
 symlinks to anywhere above the dirfd (or maybe all symlinks) and absolute =
path lookups, then this would be okay.
>
> So I think this all is now done.

But you missed the FMODE_CRED part!

So here's the problem: right now, in current Linux, a dirfd pointing
to a directory that you can open anyway doesn't convey any new powers.
So, if I'm a regular program, and I do open("/etc", O_PATH), I get an
fd.  And if I get an fd pointing at /etc from somewhere else, I get
the same thing (possibly with different f_cred, but f_cred is largely
a hack to restrict things that would otherwise be insecure because
they were designed a bit wrong from the beginning).

But, with your patch, these fds suddenly convey a very strong
privilege: that of their f_cred *over the entire subtree to which they
refer*.  And you can attack it using exactly your intended use case:
if any program opens a dirfd and then drops privileges, well, oops, it
didn't actually fully drop privilege.

So I think that, if this whole concept has any chance of working well,
it needs to be opt-in *at the time of the original open*.  So a
privilege-carrying open would be an entirely new option like
O_CAPTURE_CREDS or FMODE_CREDS.  And OA2_INHERIT_CREDS is rejected if
the dirfd doesn't have that special mode.

