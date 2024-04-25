Return-Path: <linux-api+bounces-1369-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758878B198A
	for <lists+linux-api@lfdr.de>; Thu, 25 Apr 2024 05:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91FFB22214
	for <lists+linux-api@lfdr.de>; Thu, 25 Apr 2024 03:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BB422F03;
	Thu, 25 Apr 2024 03:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="jfWVKEGT"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32D822EE5
	for <linux-api@vger.kernel.org>; Thu, 25 Apr 2024 03:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714015925; cv=none; b=twmDfmaRZPEvQiWVju4Wdnk6kHQmY/cBVTjxiTUjNSSPhaJWPNM5q0++vaWg2/veabgCRg3ajsx/EYtM0nsFdiPPOTyMFvK6nwtLQuPW9D+k2PCvhOHzJVJ4DuZxkBZzDWxgCpwKuoqIEfvPt3jGaFS/AETukvkgNpx7ldk5vR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714015925; c=relaxed/simple;
	bh=gHMAoGy8TNYioD+eXe4aVw67pBse8qSNhPaTVtoZuE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYZCFh5ikWJB4nA0L563OXRau9wZWgHphIWZCfMvjWnoo7RIXnDR86cIdaoiJDPcYc447Akmf2Fbg2oWjtZbNVaVryQpXT+whsIwzPxOfspETRNVBW0eT/3l7/tnChDV6PFbFej7ySY2VGrIy/uA1uISSoqtp7WQz6rj4Y26LaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=jfWVKEGT; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4daab3cf090so299606e0c.0
        for <linux-api@vger.kernel.org>; Wed, 24 Apr 2024 20:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1714015923; x=1714620723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gGmdOMBGN+jAZMVZO+RAUMFMAI4tVTruMWQA+8VFG40=;
        b=jfWVKEGTfz9raH/b7UTiNeh2C2K0jnYecE6bYS9FMhq5MEhXoN4bJ0jRH/rKZffJ1o
         WOM+d8ZEefURiLQYSDprHxUlZ44eNgxrdsYxn02be4UcK96yaSyjBAN0TesHoch86cfV
         YQOry8bp29d3GE0/h3e5kAenJplTJPt++2uYE3MhHonW7wLTdZ+sL+YfguZlJKdKbP39
         xFE/uOUzROmJ9gCn6ebyVP5iF+lZjh+GfPM0Fpqk6smvxqqGCSftMmBohuN/c1pKlG4c
         yslOgeDvhN4tCUPxOKRp/Np2+HOkbC2ZvYGCm1R5n2eBLIoHsDy32XmvuZ3u3jOH0V5b
         kXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714015923; x=1714620723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGmdOMBGN+jAZMVZO+RAUMFMAI4tVTruMWQA+8VFG40=;
        b=MuSovb+1voWzDr5+zSddw6RCFSeXhEDTRhY/K21M+csgPz+AIsFoaZBcl4shjxw+jE
         equ4U9mIbZ+d1+E89f8bUefoARSMTB5s15DjtYBQR0ZkwQO9ijpDjEmzcF6R+xrf4S6k
         wAw0d1y/TJB+EVjc07TJGQtRAYXuE4TD16oHq9O7Pv4vR2apUhypIzBBH+hKnd4OFa+I
         nsAYTQk+rslrG037aDhjIU58qSuK+03uQYNtCWD52b/sg5fry3eOBBcE6/yaaJUPQkwO
         zGzVU6/SoSZ9QIsFqs5X4ifHQSd8UuKkKzze4RHN2PIy6GJGy3MqKOnNoGc5aT7WQjSP
         aYIw==
X-Forwarded-Encrypted: i=1; AJvYcCX3RQ4GUZqM5FoejvilTcgX16XoLcYlgNDSSco9AA0E8lO7Iz015gJQptBXjlqxRayMb5ET1hVZS0C1gb+mSQEfvXzHTeFKYVFw
X-Gm-Message-State: AOJu0YyWDmtVkLmHd0nliNeKsgT1ivAWkyxSpYSux9uHRsw42dS3myfV
	d1CqizzKMO6NcQLOIC4Hv5VjBMCpDcVOVeBPIGnUldDrwysh2sudqc6bz7YDWy+d8yhvKNTWue9
	WP3NlzX6w1VcC+4sDPSB/8ZphNlfmw8LHCEfq
X-Google-Smtp-Source: AGHT+IHKUUg0dcOStUxOvrMlbUU6GBfvUsCmFlOr7lkTfYGog5U46Mr3biaE0pMIM9Q8m0zC8aKeQ/cJ54RqoQN6j6I=
X-Received: by 2002:a05:6122:4110:b0:4d5:f28b:2c2c with SMTP id
 ce16-20020a056122411000b004d5f28b2c2cmr2069871vkb.3.1714015922862; Wed, 24
 Apr 2024 20:32:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423110148.13114-1-stsp2@yandex.ru> <4D2A1543-273F-417F-921B-E9F994FBF2E8@amacapital.net>
 <0e2e48be-86a8-418c-95b1-e8ca17469198@yandex.ru> <CALCETrWswr5jAzD9BkdCqLX=d8vReO8O9dVmZfL7HXdvwkft9g@mail.gmail.com>
 <20240425014358.GG2118490@ZenIV>
In-Reply-To: <20240425014358.GG2118490@ZenIV>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 24 Apr 2024 20:31:51 -0700
Message-ID: <CALCETrVekFGzzu1VyZf7s42hFZoT9TVV6FuW5AmrBELUxkZhwQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: stsp <stsp2@yandex.ru>, linux-kernel@vger.kernel.org, 
	Stefan Metzmacher <metze@samba.org>, Eric Biederman <ebiederm@xmission.com>, 
	Andy Lutomirski <luto@kernel.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	=?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 6:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Apr 24, 2024 at 05:43:02PM -0700, Andy Lutomirski wrote:
>
> > I like that, but you're blocking it the wrong way.  My concern is that
> > someone does dfd =3D open("/proc/PID/fd/3") and then openat(dfd, ...,
> > OA2_INHERIT_CRED);  IIRC open("/proc/PID/fd/3") is extremely magical
> > and returns the _same open file description_ (struct file) as PID's fd
> > 3.
>
> No, it doesn't.  We could implement that, but if we do that'll be
> *not* a part of procfs and it's going to be limited to current task
> only.

Egads -- why would we want to implement that?  In the apparently
incorrect model in my head, Linux's behavior was ridiculous and only
made sense for some historical reason.  But I wonder why I thought
that.

Diving a tiny bit down the rabbit hole, I have a copy of TLPI on my
bookshelf, and I bought it quite a long time ago and read a bunch of
it when I got it, and my copy is *wrong*!  Section 5.11 has the
behavior of /dev/fd very clearly documented as working like dup().

And here it is: erratum 107.  Whoopsies!

https://man7.org/tlpi/errata/index.html

Anyway, I retract that particular objection to the series.  But I
wouldn't be shocked if one can break a normal modern systemd using the
patchset -- systemd does all kinds of fun things involving passing
file descriptors around.

--Andy

