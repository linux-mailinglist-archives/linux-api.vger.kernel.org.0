Return-Path: <linux-api+bounces-4578-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A2AB349D6
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 20:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F25189B78E
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515BD30BF55;
	Mon, 25 Aug 2025 18:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IZBdsdz7"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290893093BD
	for <linux-api@vger.kernel.org>; Mon, 25 Aug 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145462; cv=none; b=QUd5grgBMtH7ydPWxZUwjjdLe+wHPQETvPuuGW+JKLWyZuFbEIf3z0OCXWtIY9+OwNG2zPxyrmtpCylGZ1QU0TEcRS6SvlPGSX1tJf11wNfyZ3alG91btUWjuEGJg9fXKGKylI9QTVLdNT20vLZ4Un+m9ymbr2i2LArcsGpvv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145462; c=relaxed/simple;
	bh=7sbF6iBnc19BzvNLlUOJSm4vPADYw2l/nGqr1wrjdEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sw2VV3e+pxGQ1BOKNXS3jjmm0u2iWE8nvIdYNu5xnoywd99JGm/nJG+u0DieEH10c9UzRgxOn5MIWDb1QMm3zdeSOWh9UGZyH0BwhoonTH7fpXWcTf/D8oemWDkAzcBRpi8dcgtnYtLBSHaIFzuswpQmTHJNq5lDZ/Fro6zoLRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IZBdsdz7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45b60b612c9so6845e9.0
        for <linux-api@vger.kernel.org>; Mon, 25 Aug 2025 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756145458; x=1756750258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f72AMp+CXzD5eYq7ijxL7Cpgy8ZEES5VfyxS8Suef1c=;
        b=IZBdsdz75BnDGnYGI1CIPFG+sv+qT7Yl/o2j3DpgbwyEntcXpuyHous/6J0LNYlgvl
         J2GnInbuLN3UPMBvvbohLrY2nd3+r/KTpDPuFJ1Lm/RUSxDoZgjDIzJBDukV1GRwZMqH
         wCWMEoSfTYYkbMcoPKvPjAjA82zW7NkGmMR7ui07i1ChXw/VhkPzwQCd5ybnnjEL1lKV
         ae329UHb2ebnbOwaSCA1wdFiSO0cbemyKGAfFudWk1JlJd4q/p66ROJ3hDMT14g3iDsY
         gl/b9pFIkSKBvDlh2FRDJ6WWxfyaXED6ePYGG1J7sxgQU9WRu25s/y4uu8V4IrzC6wQL
         bksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756145458; x=1756750258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f72AMp+CXzD5eYq7ijxL7Cpgy8ZEES5VfyxS8Suef1c=;
        b=DdZ8icwUgboYiCyQoEblWVT4NGT/Ld0a2RvjEuOkB1I6lX/mMF625OuDtVKi1BuIJs
         B4A5tmqv5p5Tk8qaKo8AP0562gQ57VZxpzrjcG3duPUSp+BCZt+5dX77s3CPLBFmHQhM
         8rFgATFFOAVoaDUMTgkhS/etNgxz3j/pMNs/cSEx/ZI0DjXxfkieuI8Uq36RUQO6MURK
         Q3QaWFHzjnYVFFnRaWTkoqmJCcHs+BD/DQCTMz+mEAh2AvSQ2hP+U7tSZE+j6LFxvkY2
         JKZ1W1L9OUWyyTREs1zNI6JlxmrOcNP38pTgbI7xAra++Hv3R+Qnb4CEGRTQ+SO7ZrDf
         mfWg==
X-Forwarded-Encrypted: i=1; AJvYcCWkySUmoo3WA/ZoUU107ZeSgvMMCcrhWFR6sOk86nQQs27QugPtn3KOn+3bUE5hR7nmlOGkc8/W8KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKi1Xdvh21omsDl/FNI2Q3n71rcee4HcPpWBOZEJ7AR3Hl9mrW
	kQDkc4yk+Nf05h6uTfWFTizQxP9lDRV77qEeKmlb1tGVa7F1XzRz0Cb9BMHjf7Mmg6eF6weXYsb
	I7qWb6pXHHZpyhoVtrqIq+mCKYRE1ZS/uFmzCvwSI
X-Gm-Gg: ASbGncsrCFGbHUqqmMgJOA2tFwt/GPZu9pVMYv4cwy6OZY4gF8M2tH7+UvaeetW7k5+
	NrsAUXt7NjFxPWIpvps4IpRltpzytQLnqqKug7qVE9/sXV9AdjHM/KfE3T1AGhZfII/ybZ5bQo1
	V3EjSlNOjlLkVggk1l85tIYa9Av6Y6MGZcKuKUg3WCBOjKCnzi5Qr8rf/k7u1fZWqvwqCH46ww9
	JHnuFaOddhe8KmoD4vtLTsjxcAPNIloGw37OtFTtu0h
X-Google-Smtp-Source: AGHT+IEdzkmzQSE86sK/Re7Z3Y+S3h68XMMRvGS7u4Ul3xpIqcNPKL9CDchW0vRIxsbQVwF635c6eJCb0IgTL4iIJ34=
X-Received: by 2002:a05:600c:a102:b0:459:d7da:3179 with SMTP id
 5b1f17b1804b1-45b65f4e6ccmr13005e9.5.1756145458325; Mon, 25 Aug 2025 11:10:58
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net> <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net> <CALCETrX+OpkRSvOZhaWiqOsAPr-hRb+kY5=Hh5LU3H+1xPb3qg@mail.gmail.com>
In-Reply-To: <CALCETrX+OpkRSvOZhaWiqOsAPr-hRb+kY5=Hh5LU3H+1xPb3qg@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 25 Aug 2025 11:10:20 -0700
X-Gm-Features: Ac12FXyE5Uc9z6yYoKPiBcnlngqu1ThnovMVOVfP8SQyJlN2POaLvxRW9Wz9AP8
Message-ID: <CALmYWFvbcmrB6yDdi4_L-2iOaE216O3JTvtfMcwydHWR6ZVpEg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: Andy Lutomirski <luto@amacapital.net>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Robert Waite <rowait@microsoft.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Scott Shell <scottsh@microsoft.com>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 9:43=E2=80=AFAM Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>
> On Mon, Aug 25, 2025 at 2:31=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:
> >
> > On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> > > On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic=
@digikod.net> wrote:
> > > >
> > > > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > > > On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn =
<mic@digikod.net> wrote:
> > > > > > Add a new O_DENY_WRITE flag usable at open time and on opened f=
ile (e.g.
> > > > > > passed file descriptors).  This changes the state of the opened=
 file by
> > > > > > making it read-only until it is closed.  The main use case is f=
or script
> > > > > > interpreters to get the guarantee that script' content cannot b=
e altered
> > > > > > while being read and interpreted.  This is useful for generic d=
istros
> > > > > > that may not have a write-xor-execute policy.  See commit a5874=
fde3c08
> > > > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > > > >
> > > > > > Both execve(2) and the IOCTL to enable fsverity can already set=
 this
> > > > > > property on files with deny_write_access().  This new O_DENY_WR=
ITE make
> > > > >
> > > > > The kernel actually tried to get rid of this behavior on execve()=
 in
> > > > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that =
had
> > > > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> > > > > because it broke userspace assumptions.
> > > >
> > > > Oh, good to know.
> > > >
> > > > >
> > > > > > it widely available.  This is similar to what other OSs may pro=
vide
> > > > > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> > > > >
> > > > > We used to have the analogous mmap() flag MAP_DENYWRITE, and that=
 was
> > > > > removed for security reasons; as
> > > > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > > > >
> > > > > |        MAP_DENYWRITE
> > > > > |               This flag is ignored.  (Long ago=E2=80=94Linux 2.=
0 and earlier=E2=80=94it
> > > > > |               signaled that attempts to write to the underlying=
 file
> > > > > |               should fail with ETXTBSY.  But this was a source =
of denial-
> > > > > |               of-service attacks.)"
> > > > >
> > > > > It seems to me that the same issue applies to your patch - it wou=
ld
> > > > > allow unprivileged processes to essentially lock files such that =
other
> > > > > processes can't write to them anymore. This might allow unprivile=
ged
> > > > > users to prevent root from updating config files or stuff like th=
at if
> > > > > they're updated in-place.
> > > >
> > > > Yes, I agree, but since it is the case for executed files I though =
it
> > > > was worth starting a discussion on this topic.  This new flag could=
 be
> > > > restricted to executable files, but we should avoid system-wide loc=
ks
> > > > like this.  I'm not sure how Windows handle these issues though.
> > > >
> > > > Anyway, we should rely on the access control policy to control writ=
e and
> > > > execute access in a consistent way (e.g. write-xor-execute).  Thank=
s for
> > > > the references and the background!
> > >
> > > I'm confused.  I understand that there are many contexts in which one
> > > would want to prevent execution of unapproved content, which might
> > > include preventing a given process from modifying some code and then
> > > executing it.
> > >
> > > I don't understand what these deny-write features have to do with it.
> > > These features merely prevent someone from modifying code *that is
> > > currently in use*, which is not at all the same thing as preventing
> > > modifying code that might get executed -- one can often modify
> > > contents *before* executing those contents.
> >
> > The order of checks would be:
> > 1. open script with O_DENY_WRITE
> > 2. check executability with AT_EXECVE_CHECK
> > 3. read the content and interpret it
>
> Hmm.  Common LSM configurations should be able to handle this without
> deny write, I think.  If you don't want a program to be able to make
> their own scripts, then don't allow AT_EXECVE_CHECK to succeed on a
> script that the program can write.
>
Yes, Common LSM could handle this, however, due to historic and app
backward compability reason, sometimes it is impossible to enforce
that kind of policy in practice, therefore as an alternative, a
machinism such as AT_EXECVE_CHECK is really useful.

> Keep in mind that trying to lock this down too hard is pointless for
> users who are allowed to to ptrace-write to their own processes.  Or
> for users who can do JIT, or for users who can run a REPL, etc.
>
The ptrace-write and /proc/pid/mem writing are on my radar, at least
for ChomeOS and Android.
AT_EXECVE_CHECK is orthogonal to those IMO, I hope eventually all
those paths will be hardened.

Thanks and regards,
-Jeff

