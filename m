Return-Path: <linux-api+bounces-2009-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653F29379DE
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2024 17:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8845D1C20D8A
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2024 15:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EA713D61D;
	Fri, 19 Jul 2024 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aXH0hAzy"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176D61448E0
	for <linux-api@vger.kernel.org>; Fri, 19 Jul 2024 15:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402881; cv=none; b=I6EaFNE/aPLFGJ9P2ySdcv981QtT48lAKjEPKDIf8d3jAE/ksZQP2E5i6hrYU/6JxHPgKS6nJjfdLadvjftExsuw/okDfcfqi0bYR308QDDg8N+Zk+e6feZeQfALPq/E0w3gahKZVerfQqYTWFYri8pZpnDLUYeJohMutf27EbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402881; c=relaxed/simple;
	bh=sD1lGd9SneUctEquyLBmVbslUeLr+/Ruw82FHYbwjto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lzkeF3flS+NtZL0pNfPunJzZIeNFd8MFjr15ruJaTB7RnAFrK+AQ70seN2lhwYGJQ7BWb1vLewMcGpU6IxztYbIvzcHBkUiit/rh3S/wJrRT3sPZUlzpAgcl3BEYTBTvf6bZuVyqNsH8FR3HZrgwlCDRgs8Ourt3VIu6vYT8gP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aXH0hAzy; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1b073d7cdso17745a12.0
        for <linux-api@vger.kernel.org>; Fri, 19 Jul 2024 08:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721402878; x=1722007678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/MxYH2/uzCcS4HqNETSoYIUh519YogSSIkssubeOjA=;
        b=aXH0hAzy9WFcE/WsXnwIXUinFc2tYiWtF+sspx4k49z1wTp2JcuKgxXf0GYLSPZJFx
         NF5BtUWzep56Sd02nJ5x1UbJOOvMOoA+sZNL2Yh0GqbeEsxOO4pUWUDVI0BQM/ceY1aK
         5yU2xaoF4O9l6LUXiI2aJd8i3MKDrTETHo9dhDh2jL15QiXGv/j2uJdaTUyddb3AHIJk
         QBLNLlffWSlW8EF+zbegUQLlzbeKtPTTu6MKFUyBF/Jxe0qY4RJtCQsJOSCcyCrbq4gC
         0pNpa7nHWngnjSbjbIfuzWY1blUl5kvxMytHKc8Aah6axhpKhIJcXa82+YX4O7BBPWTJ
         zOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402878; x=1722007678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/MxYH2/uzCcS4HqNETSoYIUh519YogSSIkssubeOjA=;
        b=AjNirGae1u2yATaPVFrg9QCXOG/vBYi3XTa9mye588ebCmO7BCAYD2N6vmtDxU7UGn
         owM7tFcS1mGNzuVMvCZS/duEHTSlCCtPc4d6cV2HgexyUPXajwEnTsyeFWSmVApXi1Su
         57WyfVHy1988uw6HCAmDZz0UZEDZYw1eKwR//RmjdNuZoh6renLSs1obIfMUVHdh+nUK
         bsBJxDd3crCOA05IKN9g3Cy8KIVYYHz+xE6UqStqiefsnpaKNDzXLu4XqUtRWIC3st86
         bzacNTUMeVBJHK/1xDiWVUJPxvYZc2dhzqjasvq1YU4VIAoHb6Qbi6xWQk228PDBx3//
         XYtw==
X-Forwarded-Encrypted: i=1; AJvYcCVmMiumvJLTK7ur2T+IQOLSBhnr+430UHd+0iluYhdk06C0UCwocKmV7HxHPL/T2hexoktgq1QpiJ01hI3eWtpBOGXbjc6Hsfvh
X-Gm-Message-State: AOJu0YyQ53i6kkUsqvJ4GjkgYTDhyUA/tmcWAAAG4fwxe+uZFo7APH0f
	zTqK7ecicrVvslzSWYClZsxxJWAlyYiViWNmx/2pKFBWta0EBevv+azOVSWt17tCk5cxTOXsj+n
	qKCOjCbOaGsWkBYWpbotOWweNxSekbD7Yf/1T
X-Google-Smtp-Source: AGHT+IGSwc1Sbm2gtpC0SvLJW7tBA/sZMi1xLeY6EhseEA9RMcDEKQHymOTelOQ90KNEQFpSSZW3FvOrxTA1Y9I1PzU=
X-Received: by 2002:a05:6402:50c9:b0:57c:c5e2:2c37 with SMTP id
 4fb4d7f45d1cf-5a2f262b220mr178043a12.3.1721402878011; Fri, 19 Jul 2024
 08:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net> <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net> <CALmYWFto4sw-Q2+J0Gc54POhnM9C8YpnJ44wMz=fd_K3_+dWmw@mail.gmail.com>
 <20240719.shaeK6PaiSie@digikod.net> <CALmYWFsd-=pOPZZmiKvYJ8pOhACsTvW_d+pRjG_C4jD6+Li0AQ@mail.gmail.com>
 <20240719.sah7oeY9pha4@digikod.net>
In-Reply-To: <20240719.sah7oeY9pha4@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Fri, 19 Jul 2024 08:27:18 -0700
Message-ID: <CALmYWFsAZjU5sMcXTT23Mtw2Y30ewc94FAjKsnuSv1Ex=7fgLQ@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Elliott Hughes <enh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 8:04=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Fri, Jul 19, 2024 at 07:16:55AM -0700, Jeff Xu wrote:
> > On Fri, Jul 19, 2024 at 1:45=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Thu, Jul 18, 2024 at 06:29:54PM -0700, Jeff Xu wrote:
> > > > On Thu, Jul 18, 2024 at 5:24=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > > > > > On Wed, Jul 17, 2024 at 3:01=E2=80=AFAM Micka=C3=ABl Sala=C3=BC=
n <mic@digikod.net> wrote:
> > > > > > >
> > > > > > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > > > > > On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=
=C3=BCn <mic@digikod.net> wrote:
> > > > > > > > >
> > > > > > > > > Add a new AT_CHECK flag to execveat(2) to check if a file=
 would be
> > > > > > > > > allowed for execution.  The main use case is for script i=
nterpreters and
> > > > > > > > > dynamic linkers to check execution permission according t=
o the kernel's
> > > > > > > > > security policy. Another use case is to add context to ac=
cess logs e.g.,
> > > > > > > > > which script (instead of interpreter) accessed a file.  A=
s any
> > > > > > > > > executable code, scripts could also use this check [1].
> > > > > > > > >
> > > > > > > > > This is different than faccessat(2) which only checks fil=
e access
> > > > > > > > > rights, but not the full context e.g. mount point's noexe=
c, stack limit,
> > > > > > > > > and all potential LSM extra checks (e.g. argv, envp, cred=
entials).
> > > > > > > > > Since the use of AT_CHECK follows the exact kernel semant=
ic as for a
> > > > > > > > > real execution, user space gets the same error codes.
> > > > > > > > >
> > > > > > > > So we concluded that execveat(AT_CHECK) will be used to che=
ck the
> > > > > > > > exec, shared object, script and config file (such as seccom=
p config),
> > >
> > > > > > > > I think binfmt_elf.c in the kernel needs to check the ld.so=
 to make
> > > > > > > > sure it passes AT_CHECK, before loading it into memory.
> > > > > > >
> > > > > > > All ELF dependencies are opened and checked with open_exec(),=
 which
> > > > > > > perform the main executability checks (with the __FMODE_EXEC =
flag).
> > > > > > > Did I miss something?
> > > > > > >
> > > > > > I mean the ld-linux-x86-64.so.2 which is loaded by binfmt in th=
e kernel.
> > > > > > The app can choose its own dynamic linker path during build, (m=
aybe
> > > > > > even statically link one ?)  This is another reason that relyin=
g on a
> > > > > > userspace only is not enough.
> > > > >
> > > > > The kernel calls open_exec() on all dependencies, including
> > > > > ld-linux-x86-64.so.2, so these files are checked for executabilit=
y too.
> > > > >
> > > > This might not be entirely true. iiuc, kernel  calls open_exec for
> > > > open_exec for interpreter, but not all its dependency (e.g. libc.so=
.6)
> > >
> > > Correct, the dynamic linker is in charge of that, which is why it mus=
t
> > > be enlighten with execveat+AT_CHECK and securebits checks.
> > >
> > > > load_elf_binary() {
> > > >    interpreter =3D open_exec(elf_interpreter);
> > > > }
> > > >
> > > > libc.so.6 is opened and mapped by dynamic linker.
> > > > so the call sequence is:
> > > >  execve(a.out)
> > > >   - open exec(a.out)
> > > >   - security_bprm_creds(a.out)
> > > >   - open the exec(ld.so)
> > > >   - call open_exec() for interruptor (ld.so)
> > > >   - call execveat(AT_CHECK, ld.so) <-- do we want ld.so going throu=
gh
> > > > the same check and code path as libc.so below ?
> > >
> > > open_exec() checks are enough.  LSMs can use this information (open +
> > > __FMODE_EXEC) if needed.  execveat+AT_CHECK is only a user space
> > > request.
> > >
> > Then the ld.so doesn't go through the same security_bprm_creds() check
> > as other .so.
>
> Indeed, but...
>
My point is: we will want all the .so going through the same code
path, so  security_ functions are called consistently across all the
objects, And in the future, if we want to develop additional LSM
functionality based on AT_CHECK, it will be applied to all objects.

Another thing to consider is:  we are asking userspace to make
additional syscall before  loading the file into memory/get executed,
there is a possibility for future expansion of the mechanism, without
asking user space to add another syscall again.

I m still not convinced yet that execveat(AT_CHECK) fits more than
faccessat(AT_CHECK)


> >
> > As my previous email, the ChromeOS LSM restricts executable mfd
> > through security_bprm_creds(), the end result is that ld.so can still
> > be executable memfd, but not other .so.
>
> The chromeOS LSM can check that with the security_file_open() hook and
> the __FMODE_EXEC flag, see Landlock's implementation.  I think this
> should be the only hook implementation that chromeOS LSM needs to add.
>
> >
> > One way to address this is to refactor the necessary code from
> > execveat() code patch, and make it available to call from both kernel
> > and execveat() code paths., but if we do that, we might as well use
> > faccessat2(AT_CHECK)
>
> That's why I think it makes sense to rely on the existing __FMODE_EXEC
> information.
>
> >
> >
> > > >   - transfer the control to ld.so)
> > > >   - ld.so open (libc.so)
> > > >   - ld.so call execveat(AT_CHECK,libc.so) <-- proposed by this patc=
h,
> > > > require dynamic linker change.
> > > >   - ld.so mmap(libc.so,rx)
> > >
> > > Explaining these steps is useful. I'll include that in the next patch
> > > series.

