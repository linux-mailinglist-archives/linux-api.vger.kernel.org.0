Return-Path: <linux-api+bounces-4575-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AEBB347D0
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 18:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B881B254BB
	for <lists+linux-api@lfdr.de>; Mon, 25 Aug 2025 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EB9301460;
	Mon, 25 Aug 2025 16:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="LJBtn8hz"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BEE301014
	for <linux-api@vger.kernel.org>; Mon, 25 Aug 2025 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140227; cv=none; b=K5QYhcteOKe+U4Ky4U4TdxQMg6O40Pr+8XAs5Wwv4tOdc+9//Fw5XSOnGeeEAco+q/DTXlCnGd/YgjljmDGznyLfTDLvvRqyXCt70WC29xHB4/p6J074W2WpnXWZg7OcbUAxCQAZHLpN0HLWciSRDKiOym3nYb4kAq/SJpXA340=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140227; c=relaxed/simple;
	bh=mrvVK8/Xsrljs2OlTw2saC30UIQ8XhkSiEQOYrZEW8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy3HBTBUJ3pRuZyxaLCSD0r5gADiKhulOq9madiPHzB6NwyTX9VfTyN2kF7xch3pvVrkGz/R2IQByk1cO7YSt5/5y7ScslLshWz8qkNlHkzj0rvACCy1E7kk2g3oSn9f6tv0MCqLoY7C2R+wWQ5mvncHRi2itN/Xn97hcsNFRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=LJBtn8hz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-333f918d71eso32651411fa.3
        for <linux-api@vger.kernel.org>; Mon, 25 Aug 2025 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1756140224; x=1756745024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PLv6y/UhSOB8bdOkGYyaQMgyRuq9HEBdk6Xh5IVulM=;
        b=LJBtn8hz9+1q0YtwAmqQoOT4NrmZQ2SKq2o/M1bmIOD8I7C0es7ckJbRx/MOsfdmK6
         MgmVBU9kkITmd8wHsdZGW1WCqOCLFGo44p7hgKXyb53xCpqlhlrbKYk/UfVp4IoiAGQl
         DcSx6PbRN6eNvl+q38qNWi1twzzm+8oeiKRvoIr3wmC4XN/mQS5IrDEOQ0t2HkCYkbS3
         IEOjewoT1zuKhaMU75icXZWujI8GwB8CEIOTKJuwXuCYk0WIkvgaMXDOJ5Fo+v5oPQDn
         VvJcIlFEWgd3h4CAWTuHai2S2TkozFw1Nl/RZ/O+XUS5hxyTTKwxZNHE4ADffnjQg3TN
         3+Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756140224; x=1756745024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7PLv6y/UhSOB8bdOkGYyaQMgyRuq9HEBdk6Xh5IVulM=;
        b=sC+0eY2cjqtdZetw8+QmSEPnogSu5zK1cyVpBZwp+7ykOW9XsyQQUWR8yajxA/HEBn
         Cbsp1n6XUmvRY4EmiAPHmf7v5Gs5dRgLTG84ek96bMRGJlJG/D9dUcpYZ7n7Wjj5jHub
         wqnI/miEqr9ghr243XTR8MDCw7CUb9BDO5ljnY687ZfmoUN53cPxEfCZjwaOSRYjFHKa
         3BvPZaiSfJZpTAcEm8Aa7Ub8HsflRN5ITuVb3GuTclsVUKtdHbH9CRMpORoevbxI+VbU
         w3XKdgFgv+vU8wGRSJhxd2KSGGQ58ti12ijwT7x+u5uRpPTycTPBKlTsH8X9cLiJ+RvJ
         EJZA==
X-Forwarded-Encrypted: i=1; AJvYcCUch6K70uQ1OcjFv97+1y9uY3OGaibBejFzgrh9c5SZmrA9dcRjOhS5IGzT0UubCluV/5IJcOkmpRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2uz6nEC/itQiM7HhbQm8wgG9AUEvkS1yvlzqB22Yrh22iQFvr
	Bv8EELK7Me4ndYFonwMztCErxGW7xdaSFzs8wBOVq3nw4LgjM8v8+82AI8Z4QPYhdUXAbiIlNdi
	Fhk9MZggDRLGXdgQzZvMjf1ka+EmsRx9sMWRdtIUf
X-Gm-Gg: ASbGnct/DxzEspmHPfpiQ/J/xvoGYuTj/EyAPmxSGgsYE2D5k2UA+YPdwXpYinivKUW
	XOUcPJPRbe09TySXWVQDW6/3sP3nQO0jGb9c0Uy4pX1nQ4GEtQ5GQG4lC413NFn+F10bEt9LPv2
	6oYYoUYeyPVCAlFjJZMtoeUM8SBgPQBKem05ND+xaTHvzswuX9s4+F7FXg6qlG+Gt+lHtf4d73B
	mmbeg==
X-Google-Smtp-Source: AGHT+IEMdqK/C2LpKtNe8HwPygFUadpsqtunEn/HXVLtMBboXyEX1vSk+kxH2wVSUzVD8p+wSlL+I8mi2gjoh9eWb18=
X-Received: by 2002:a2e:a018:0:b0:330:d981:1755 with SMTP id
 38308e7fff4ca-33650de81e9mr24090271fa.6.1756140223780; Mon, 25 Aug 2025
 09:43:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822170800.2116980-1-mic@digikod.net> <20250822170800.2116980-2-mic@digikod.net>
 <CAG48ez1XjUdcFztc_pF2qcoLi7xvfpJ224Ypc=FoGi-Px-qyZw@mail.gmail.com>
 <20250824.Ujoh8unahy5a@digikod.net> <CALCETrWwd90qQ3U2nZg9Fhye6CMQ6ZF20oQ4ME6BoyrFd0t88Q@mail.gmail.com>
 <20250825.mahNeel0dohz@digikod.net>
In-Reply-To: <20250825.mahNeel0dohz@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 25 Aug 2025 09:43:31 -0700
X-Gm-Features: Ac12FXyB6lzRP1sYgoa00swEucBzjGB4o1VKS2fSTUJC8HJqzdooeCFOZN6Irw4
Message-ID: <CALCETrX+OpkRSvOZhaWiqOsAPr-hRb+kY5=Hh5LU3H+1xPb3qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] fs: Add O_DENY_WRITE
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <serge@hallyn.com>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Elliott Hughes <enh@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
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

On Mon, Aug 25, 2025 at 2:31=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Sun, Aug 24, 2025 at 11:04:03AM -0700, Andy Lutomirski wrote:
> > On Sun, Aug 24, 2025 at 4:03=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Fri, Aug 22, 2025 at 09:45:32PM +0200, Jann Horn wrote:
> > > > On Fri, Aug 22, 2025 at 7:08=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > > Add a new O_DENY_WRITE flag usable at open time and on opened fil=
e (e.g.
> > > > > passed file descriptors).  This changes the state of the opened f=
ile by
> > > > > making it read-only until it is closed.  The main use case is for=
 script
> > > > > interpreters to get the guarantee that script' content cannot be =
altered
> > > > > while being read and interpreted.  This is useful for generic dis=
tros
> > > > > that may not have a write-xor-execute policy.  See commit a5874fd=
e3c08
> > > > > ("exec: Add a new AT_EXECVE_CHECK flag to execveat(2)")
> > > > >
> > > > > Both execve(2) and the IOCTL to enable fsverity can already set t=
his
> > > > > property on files with deny_write_access().  This new O_DENY_WRIT=
E make
> > > >
> > > > The kernel actually tried to get rid of this behavior on execve() i=
n
> > > > commit 2a010c41285345da60cece35575b4e0af7e7bf44.; but sadly that ha=
d
> > > > to be reverted in commit 3b832035387ff508fdcf0fba66701afc78f79e3d
> > > > because it broke userspace assumptions.
> > >
> > > Oh, good to know.
> > >
> > > >
> > > > > it widely available.  This is similar to what other OSs may provi=
de
> > > > > e.g., opening a file with only FILE_SHARE_READ on Windows.
> > > >
> > > > We used to have the analogous mmap() flag MAP_DENYWRITE, and that w=
as
> > > > removed for security reasons; as
> > > > https://man7.org/linux/man-pages/man2/mmap.2.html says:
> > > >
> > > > |        MAP_DENYWRITE
> > > > |               This flag is ignored.  (Long ago=E2=80=94Linux 2.0 =
and earlier=E2=80=94it
> > > > |               signaled that attempts to write to the underlying f=
ile
> > > > |               should fail with ETXTBSY.  But this was a source of=
 denial-
> > > > |               of-service attacks.)"
> > > >
> > > > It seems to me that the same issue applies to your patch - it would
> > > > allow unprivileged processes to essentially lock files such that ot=
her
> > > > processes can't write to them anymore. This might allow unprivilege=
d
> > > > users to prevent root from updating config files or stuff like that=
 if
> > > > they're updated in-place.
> > >
> > > Yes, I agree, but since it is the case for executed files I though it
> > > was worth starting a discussion on this topic.  This new flag could b=
e
> > > restricted to executable files, but we should avoid system-wide locks
> > > like this.  I'm not sure how Windows handle these issues though.
> > >
> > > Anyway, we should rely on the access control policy to control write =
and
> > > execute access in a consistent way (e.g. write-xor-execute).  Thanks =
for
> > > the references and the background!
> >
> > I'm confused.  I understand that there are many contexts in which one
> > would want to prevent execution of unapproved content, which might
> > include preventing a given process from modifying some code and then
> > executing it.
> >
> > I don't understand what these deny-write features have to do with it.
> > These features merely prevent someone from modifying code *that is
> > currently in use*, which is not at all the same thing as preventing
> > modifying code that might get executed -- one can often modify
> > contents *before* executing those contents.
>
> The order of checks would be:
> 1. open script with O_DENY_WRITE
> 2. check executability with AT_EXECVE_CHECK
> 3. read the content and interpret it

Hmm.  Common LSM configurations should be able to handle this without
deny write, I think.  If you don't want a program to be able to make
their own scripts, then don't allow AT_EXECVE_CHECK to succeed on a
script that the program can write.

Keep in mind that trying to lock this down too hard is pointless for
users who are allowed to to ptrace-write to their own processes.  Or
for users who can do JIT, or for users who can run a REPL, etc.

> > But maybe a less kludgy version could be used for real.  What if there
> > was a syscall that would take an fd and make a snapshot of the file?
>
> Yes, that would be a clean solution.  I don't think this is achievable
> in an efficient way without involving filesystem implementations though.

It wouldn't be so terrible to involve filesystem implementations.
Most of the filesystems that people who care at all about security run
their binaries from either support reflinks or are immutable.  Things
like OCI implementations may already fit meet those criteria, and it
would be pretty nifty if the kernel was actually aware that OCI layers
are intended to be immutable.  We could even have an API to
generically query the hash of an immutable file and to ask the kernel
if it's validating the hash on reads.

