Return-Path: <linux-api+bounces-5142-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DA5C19555
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 10:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B28E568F11
	for <lists+linux-api@lfdr.de>; Wed, 29 Oct 2025 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9E92DC355;
	Wed, 29 Oct 2025 09:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h1RUxSyM"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE621765B
	for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761728467; cv=none; b=AMqu0w7Drwu8T+t39xZzM//+rZ/R8KMBTmuzQhjf6XpvUnVYHya5d6XVEaqyrqV1w2JI1LU1xyBrkmhV0qQqve2r785Va/+Of+N84wUo2Y/sS4gGECJChx119F+c/TmX4YQkrjpYMNt3hiIY4p7raHT6QdKVVXQnZRPItU2AkJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761728467; c=relaxed/simple;
	bh=jQhuuAvoKgkk6vfmb3VFERiNTx6StUXHjNHCAWBJip4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+2/1LANLTsjNaUVmhWlfy0V+YK5g8yC7gWkgXCBqTeIPu6eXQzvc5QG5C5VUrvbZUKr0S77hZl9AuihM1EPfkDTCOe4DQzNZFsKQJonzUZLI8h/QGTZNrcm4VemUZ0BpPkhydP2C6xYOzJGa6CrHtEoUk7ejFILCd9XuI00nXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h1RUxSyM; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-294df925292so5156605ad.1
        for <linux-api@vger.kernel.org>; Wed, 29 Oct 2025 02:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761728461; x=1762333261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUwDe+S5e4Vj4jBiFCqPV2Mo5aWLB9NDL+lhcB1gW2E=;
        b=h1RUxSyMayik310C3Re+CfagmQKHbNR3CDnvrulhZ2c29pGx/v1riybjNKuUaUXYxk
         GpGRDgwyFyDWNUXXzfJk+hNsOQ0vARQ7Bdi5Sujig2rpWMzAatwVzjg8K97ce7r3+Rof
         W4o9r1Vx1Ldbt02bELgxQ5mL4fvHo941lfsGID9Y/dmuulr0WLavqRjHz4oM+e0YVtQE
         C16x6Niny18jpTVy4U2soffozT+YJcVJ5eOlfDmSmv8JV9KxbsF3UicUQLzR+xfo9L0d
         TiWGqRION/7Zi4WCLq8zC0K2D5bsKj4jnzsBpJi4+rKxx97VbZPDgk7dpVT8Ku5Vnb1c
         1XJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761728461; x=1762333261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IUwDe+S5e4Vj4jBiFCqPV2Mo5aWLB9NDL+lhcB1gW2E=;
        b=Tmn9ysPuvb8Ip/P4Lz0YEWOOb3eXFQRrQnlk92MVk6W7uHtC3Trzj7p3E/PjVYP9QL
         oHZ+r/oBWNSeX2E+G/zbVKJx0aYLwPP+8Hs7weh9eGkUvYMlVxbWLYtBvC2p4s60xkIw
         2VlF1B6xOJh9NnMpKUhIVwyVf6DhisXK0kwYJcxzXVlzG9FzxSNKXZXQR4CfZCrA7jcp
         stJrL+pKOTf4A06rr19axmNzJ+NvBo8t4qBoIZ/56K5MS4AqogWTFVrBwapSf+O7y/e6
         E3bKWpk6NUQ7m8X3Yh2uUjcFE+stN40c9En7C58O3Ot8rP30GsGYhLQXjgnCA1V4Dtps
         Hcow==
X-Forwarded-Encrypted: i=1; AJvYcCUCz0fdoZ7L08ABqlMA6XgrT/NRy0y7zx+9j0a1etYt9WuP4+McblQXbcOzOGEkWE6aFazT3NVm8no=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcoRrDYVfzdF7sZvqnb4LJ2UdOFAKRFkEw3JUrZ4Gk3T/XImE
	0PTYhrIyTdOaKQ/w36Fz99UNcev0Gw2aExoLohIlwqErUVeKEwbEEg5uiHGmWro8wii+I5QnhpS
	H/9p5qhTqPVnD4tlmuuBpYjZlp0yV+cU=
X-Gm-Gg: ASbGncuA4VFpvd+OnNmlbsU3USV8GUER+9SVPNVLoKDNBTnJR0yA7pm/rMImz+/nfw1
	AT4H/iZD3ksii461+cCkz0K5vMTM9hhwijTEjTewpOAJMadGpVNf+NjkLFgKK9qOncKbPadI54U
	HjcirPuauH5ybeXJI0XJ7TLWqQ6mlN8Qlz5b6ymKjs3uQkJKcStBy6HGgXxXUYLLII2q9zV6vXi
	QE37ZL1RK/6Wly0bgvi1vO3DUQtbXQbQw8v4Hqb/bC+/h8wUbr3djqbOA7Fo8A=
X-Google-Smtp-Source: AGHT+IEyxx6Sq0hZGAlRLWTS97VWoSc6zGwQOtw6uII/95srKVXzkTRekQWkkYiSNvyQhYLdOZ2fy+pcsXJIBO+Xl8I=
X-Received: by 2002:a17:903:2f85:b0:264:ee2:c3f5 with SMTP id
 d9443c01a7336-294dee29c4cmr23574625ad.19.1761728460916; Wed, 29 Oct 2025
 02:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b959eedd02cbc0066e4375c9e1ca2855b6daeeca.1745176438.git.devhoodit@gmail.com>
 <e2wxznnsnew5vrlhbvvpc5gbjlfd5nimnlwhsgnh6qanyjhpjo@2hxdsmag3rsk>
In-Reply-To: <e2wxznnsnew5vrlhbvvpc5gbjlfd5nimnlwhsgnh6qanyjhpjo@2hxdsmag3rsk>
From: hoodit dev <devhoodit@gmail.com>
Date: Wed, 29 Oct 2025 18:00:50 +0900
X-Gm-Features: AWmQ_bl9f3gHaYptHoYabHsvKO58o6lKLlx8-0mWznmYNGurQ_CmfsV001sLwHc
Message-ID: <CAFvyz33t9gYOi2HtNFNC_YAPS-_0QHiqJQwatc7YsGppstiZ7A@mail.gmail.com>
Subject: Re: [PATCH] man/man2/clone.2: Document CLONE_NEWPID and CLONE_NEWUSER flag
To: Alejandro Colomar <alx@kernel.org>, "Carlos O'Donell" <carlos@redhat.com>
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alejandro Colomar and Carlos

Just a friendly ping to check if you had a chance to review this patch.

Thanks

2025=EB=85=84 5=EC=9B=94 2=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 6:30, Al=
ejandro Colomar <alx@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Hi Carlos,
>
> On Mon, Apr 21, 2025 at 04:16:03AM +0900, devhoodit wrote:
> > CLONE_NEWPID and CLONE_PARENT can be used together, but not CLONE_THREA=
D.  Similarly, CLONE_NEWUSER and CLONE_PARENT can be used together, but not=
 CLONE_THREAD.
> > This was discussed here: <https://lore.kernel.org/linux-man/06febfb3-e2=
e2-4363-bc34-83a07692144f@redhat.com/T/>
> > Relevant code: <https://github.com/torvalds/linux/blob/219d54332a09e8d8=
741c1e1982f5eae56099de85/kernel/fork.c#L1815>
> >
> > Cc: Carlos O'Donell <carlos@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: devhoodit <devhoodit@gmail.com>
>
> Could you please review this patch?
>
>
> Have a lovely night!
> Alex
>
> > ---
> >  man/man2/clone.2 | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/man/man2/clone.2 b/man/man2/clone.2
> > index 1b74e4c92..b9561125a 100644
> > --- a/man/man2/clone.2
> > +++ b/man/man2/clone.2
> > @@ -776,9 +776,7 @@ .SS The flags mask
> >  no privileges are needed to create a user namespace.
> >  .IP
> >  This flag can't be specified in conjunction with
> > -.B CLONE_THREAD
> > -or
> > -.BR CLONE_PARENT .
> > +.BR CLONE_THREAD .
> >  For security reasons,
> >  .\" commit e66eded8309ebf679d3d3c1f5820d1f2ca332c71
> >  .\" https://lwn.net/Articles/543273/
> > @@ -1319,11 +1317,10 @@ .SH ERRORS
> >  mask.
> >  .TP
> >  .B EINVAL
> > +Both
> >  .B CLONE_NEWPID
> > -and one (or both) of
> > +and
> >  .B CLONE_THREAD
> > -or
> > -.B CLONE_PARENT
> >  were specified in the
> >  .I flags
> >  mask.
> > --
> > 2.49.0
> >
>
> --
> <https://www.alejandro-colomar.es/>

