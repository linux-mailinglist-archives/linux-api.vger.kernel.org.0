Return-Path: <linux-api+bounces-2003-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4139370DE
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2024 00:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EAE21F21766
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2024 22:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEDC7E0E9;
	Thu, 18 Jul 2024 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XQckQ9nW"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EEF146593
	for <linux-api@vger.kernel.org>; Thu, 18 Jul 2024 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721343280; cv=none; b=fIxiLywj+19ZURaA+/F4HRZbdtkQSJR5V9m2LruF8Hs8jWwTX0S4xYorR5foJx87WTxooFFCASr1eo+2UPgC7QkUE8oM+FiPr4lBRoTTYZi0gdna0ohLJnJYo2a+XijEYp8q/dJoQ/BrBmy3RN+4JuUrCeZcRW6SB/9LZGtFI6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721343280; c=relaxed/simple;
	bh=VL+Lf2PCbmDdTiT3JFTZcz3U21Qry7ipzuZR0ssfsGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+RZ/IBgMZq/Ro4ECgKUDK026LMmBhxt21sK4D0qoe+rqUzJFgtmJFKoAHf1wPl5/FWpadiqnLm3CLn4OVHcY8X9Fdi70PGP9YONS6zzKwFKgfBQcYBDDb/0+JUO5ZQPZ0odG5WksMUnyLaI79LW2II75d9m22/emp/Wpw471EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XQckQ9nW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so3792a12.1
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2024 15:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721343277; x=1721948077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnXUJZUUq5kQBG44OPNJniIMw+LK8h1ZLMMk9t95bZg=;
        b=XQckQ9nWXFaczFQ12cnNj9LPHSvF7Aqf8KMMakcXHkl3p4j9Oflv01OhW5eXUpBhT9
         gvdlW2+XRxayOS/BrI/3ntkZGmlo693EHbmVdOvWr79dqI8J7SrTC6cu62c4F9+GOYax
         uY6xA1+UQt9YkueKsJfwLZdI0wvsw7+PzcO3x6QSq71g0UjS682XQUrJb7TjpvBMdYqb
         LegbKGPhiiW3A6Tfcp2nW17ArG/DCYgmRZIYsgSq7fuuRnSRyZPbYOyCPT86Mhdk/QDo
         MMbO5XYkdNW4AMWhaSm8yVRjbcCmDc89gztqAEzK1+EHTlDEd9w60rVZNHuMyom/gCuc
         n3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721343277; x=1721948077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnXUJZUUq5kQBG44OPNJniIMw+LK8h1ZLMMk9t95bZg=;
        b=DzwVJGxoJtsAYDjx53Lp+SKSte268TQEqqNGhvrDOU2mom4uabFmbZ5iLySt+Olb8D
         qcDoQb17omn0KVJYeevdBNafTqZ+y1X3rGn4mW2c9QzHrg6osHtGHdOyWRnWdEBfNblF
         xb32sB/eN/Bp2PdmQVVg/wWFKqslqyIpK5OWyKaHZjjbABVEnEPWWVRHnllo1wbPx5HL
         BeJ3VOVgcpzKrZqP33nmgh2sP7NXc30vpthV7YvGwD/YewRNGibEaxMP2kaZFKMgn3xr
         Y+UxtstFRrSFhxlyyVm6w67e3pvugAqgCcdb4+/qTJBOjimK7d10KUlSa0nZxXcgNPWM
         PXiA==
X-Forwarded-Encrypted: i=1; AJvYcCXk4nhkcPw+z0RnkKQFOrkFEho2jHSLrEazQMZEpd32bThF5KQrggSySAYx/CknUFcO4v7ZdEM60Jmmvy5C8p0nK8WcvA1+S820
X-Gm-Message-State: AOJu0YywtaBhZhGXhc+vCvbCMQhwwm93uniiRcyBTclCbovSwZx2nO7f
	3mPTRD2BLcBRhjkEoXieNhMks9apTaubz7TSlyGwIbCILKPIUgsNUFs1yOPCz/vaozfvjqZGc2R
	mFUgBZWITynUBQGo6Qvb0tUToFNhsOV+Ae8Nx
X-Google-Smtp-Source: AGHT+IFD08e2bkpE0+ciYMxbQAHum1I99VoHhJUfFR8GdMFbVfM2/11g6fb19Z5YGSucTrp/1La67vd2feM3Ldh0j0I=
X-Received: by 2002:a05:6402:51cd:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5a2cae572bbmr113920a12.6.1721343277083; Thu, 18 Jul 2024
 15:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <a0da7702-dabe-49e4-87f4-5d6111f023a8@python.org> <20240717.AGh2shahc9ee@digikod.net>
 <CALmYWFvxJSyi=BT5BKDiKCNanmbhLuZ6=iAMvv1ibnP24SC7fA@mail.gmail.com> <20240718.ahph4che5Shi@digikod.net>
In-Reply-To: <20240718.ahph4che5Shi@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 18 Jul 2024 15:54:00 -0700
Message-ID: <CALmYWFvAFfXmHgo6Ca+FsKhAapJ_C1VXhqT7LdFy3ZnU4Vu3Hw@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Steve Dower <steve.dower@python.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Paul Moore <paul@paul-moore.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Florian Weimer <fweimer@redhat.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, James Morris <jamorris@linux.microsoft.com>, 
	Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 5:23=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Wed, Jul 17, 2024 at 06:51:11PM -0700, Jeff Xu wrote:
> > On Wed, Jul 17, 2024 at 3:00=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Wed, Jul 17, 2024 at 09:26:22AM +0100, Steve Dower wrote:
> > > > On 17/07/2024 07:33, Jeff Xu wrote:
> > > > > Consider those cases: I think:
> > > > > a> relying purely on userspace for enforcement does't seem to be
> > > > > effective,  e.g. it is trivial  to call open(), then mmap() it in=
to
> > > > > executable memory.
> > > >
> > > > If there's a way to do this without running executable code that ha=
d to pass
> > > > a previous execveat() check, then yeah, it's not effective (e.g. a =
Python
> > > > interpreter that *doesn't* enforce execveat() is a trivial way to d=
o it).
> > > >
> > > > Once arbitrary code is running, all bets are off. So long as all ar=
bitrary
> > > > code is being checked itself, it's allowed to do things that would =
bypass
> > > > later checks (and it's up to whoever audited it in the first place =
to
> > > > prevent this by not giving it the special mark that allows it to pa=
ss the
> > > > check).
> > >
> > We will want to define what is considered as "arbitrary code is running=
"
> >
> > Using an example of ROP, attackers change the return address in stack,
> > e.g. direct the execution flow to a gauge to call "ld.so /tmp/a.out",
> > do you consider "arbitrary code is running" when stack is overwritten
> > ? or after execve() is called.
>
> Yes, ROP is arbitrary code execution (which can be mitigated with CFI).
> ROP could be enough to interpret custom commands and create a small
> interpreter/VM.
>
> > If it is later, this patch can prevent "ld.so /tmp/a.out".
> >
> > > Exactly.  As explained in the patches, one crucial prerequisite is th=
at
> > > the executable code is trusted, and the system must provide integrity
> > > guarantees.  We cannot do anything without that.  This patches series=
 is
> > > a building block to fix a blind spot on Linux systems to be able to
> > > fully control executability.
> >
> > Even trusted executable can have a bug.
>
> Definitely, but this patch series is dedicated to script execution
> control.
>
> >
> > I'm thinking in the context of ChromeOS, where all its system services
> > are from trusted partitions, and legit code won't load .so from a
> > non-exec mount.  But we want to sandbox those services, so even under
> > some kind of ROP attack, the service still won't be able to load .so
> > from /tmp. Of course, if an attacker can already write arbitrary
> > length of data into the stack, it is probably already a game over.
> >
>
> OK, you want to tie executable file permission to mmap.  That makes
> sense if you have a consistent execution model.  This can be enforced by
> LSMs.  Contrary to script interpretation which is a full user space
> implementation (and then controlled by user space), mmap restrictions
> should indeed be enforced by the kernel.
Ya, that is what I meant. it can be out of scope for this patch.
Indeed, as you point out, this patch is dedicated to script execution
control, and fixing ld.so /tmp/a.out is an extra bonus in addition to
script.

Thanks
-Jeff

