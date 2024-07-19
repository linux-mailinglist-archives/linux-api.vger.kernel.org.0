Return-Path: <linux-api+bounces-2008-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121309379AE
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2024 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C256B21167
	for <lists+linux-api@lfdr.de>; Fri, 19 Jul 2024 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8234145A01;
	Fri, 19 Jul 2024 15:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLiAw4TG"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2D314535B
	for <linux-api@vger.kernel.org>; Fri, 19 Jul 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721402005; cv=none; b=lWoiN/Zy0pCd2mnUGjWdASJ7Pc5b9clGX6mQnmOYcy1Qi0bSOR7l4FcUpC97UfjpRrGJtjIIfZhixkE4x0+f8Z8WYwRq756kCM2kWDHrCpT/Lgxfid6BCkFyrNIhRi9kC9EriHRWRFTOfDnZsq/xoNnvw9QDm2qozRBX866cCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721402005; c=relaxed/simple;
	bh=cNzYZ/BtYyZDYVyvCWTWgLlzPaAtMCxc6S1Bv8I5Lck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEW1gDe89lxykxk2Pua+piYtam7ukt1kPq7PnXQqiVt1vuSdkHgla+Cr8+LNBINL/OrOW8aiGIg4lMq8L3j56FX3UF9yTXeqnsLUjqmU/C3aYIRaQyiQyyywsG9+AegWGpCxLHLkZAWwUurUAgUf5Dr9A8+qP5tgv56FAGcmK6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FLiAw4TG; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5a28b61b880so13255a12.1
        for <linux-api@vger.kernel.org>; Fri, 19 Jul 2024 08:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721402002; x=1722006802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOJZUI+POSTXFSIgNy35weqRERtHN5CsyKdohOMq5CI=;
        b=FLiAw4TGg/gaI0MJ3VFuXxJiexG2NF+XT7VJP4kC+kIjMxbaU1zmk9P+sHmNHGeUiE
         PudRrPfvtR/qvN9fwEfrhBkwtJf3nxAIs2JK81e9CWUqb9NbHIDVyc2qKY8xPvOuzK6B
         Sk0z0sVDSTGpdgyTp4LZ7JwM63rradyU++JuQF4Nq9upMZ79xsszZCTRkoJoTQozNpl+
         3rsOeFNx5O3jTV9gKOIToCgpdGDBUkgRzib4Ol8FWB90s18HTJ+Kx3TT0TGLpbY+LKcC
         dCzAg+Pdm2gcJaE4maihNSueKsPv2gjFnSeBJi/QJAZ35m1JWL8cnS1ynzGdXIvhjkfy
         2gkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721402002; x=1722006802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOJZUI+POSTXFSIgNy35weqRERtHN5CsyKdohOMq5CI=;
        b=vP0god99koenP4/n35INMNqDA07HB45aRb8TpffijoiTlC7h4GGXWHbhZxv6/foO5L
         TGWH1FYZqKWt90507nqQu/Ix89VfGVNze0MZoOpVWwcjem2SxJKc+d5KaZL2vSChu6Gr
         7gS/PKqqXmrgFRTszOiv79KGgzDl/h/WetTHRar+R/xG+vlNnXgZSvBjRSJiEl5N492z
         dJH9yjnjTGqVBaourKmpCYbf5INhOz7bG093Svh22iv9oSV53cbfUfB7GODAY28xijdZ
         jmfl8AsGIUWZJnV6YkO1nvqX8vF0d6/dj3kehSD0mSxZ0FbF/LloTOpjX0FBzUI8in7u
         Qw8w==
X-Forwarded-Encrypted: i=1; AJvYcCXnKpqmRqQ5ONY60dlo2gmwCEB10VRC5y1ILC8/gOgQxVuUbY0T2Zn2WnyL7mVUtdCMGBW6BZmg8+2xPXURQsNtQ1/Ecx1yWXZc
X-Gm-Message-State: AOJu0Yyvo/BsrGYeUL1pjTvnKj+9VHACG8+43cHT/H8S/W7pjXXXwvBz
	o4NfUwwQFWDuJWN8vhMupylC2/DdGVhjXALEhWePQ3eNZ8Db3dcl7ESOJhC7RtlX/Uz3tbg/JzT
	f9IjnA7onP4p+DJdRPaCrscv7lZSzJP8OCHdd
X-Google-Smtp-Source: AGHT+IF8jhfTz4CuviZW9GqUcQNbR2n0XX/TjDOw52cr0zBh16yuWoo/aIR1mpwaKRcfuoy4T/F2djmB2w64vrVE1xU=
X-Received: by 2002:a05:6402:4405:b0:59e:9fb1:a0dc with SMTP id
 4fb4d7f45d1cf-5a2cb049fdamr247891a12.6.1721401996282; Fri, 19 Jul 2024
 08:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <CALmYWFss7qcpR9D_r3pbP_Orxs55t3y3yXJsac1Wz=Hk9Di0Nw@mail.gmail.com>
 <20240717.neaB5Aiy2zah@digikod.net> <CALmYWFt=yXpzhS=HS9FjwVMvx6U1MoR31vK79wxNLhmJm9bBoA@mail.gmail.com>
 <20240718.kaePhei9Ahm9@digikod.net>
In-Reply-To: <20240718.kaePhei9Ahm9@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Fri, 19 Jul 2024 08:12:37 -0700
Message-ID: <CALmYWFupWw2_BKu1FF=ooXFpA=GtJr1ehZSK3p+1+1WH34eX=w@mail.gmail.com>
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

On Thu, Jul 18, 2024 at 5:24=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Wed, Jul 17, 2024 at 07:08:17PM -0700, Jeff Xu wrote:
> > On Wed, Jul 17, 2024 at 3:01=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Tue, Jul 16, 2024 at 11:33:55PM -0700, Jeff Xu wrote:
> > > > On Thu, Jul 4, 2024 at 12:02=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > Add a new AT_CHECK flag to execveat(2) to check if a file would b=
e
> > > > > allowed for execution.  The main use case is for script interpret=
ers and
> > > > > dynamic linkers to check execution permission according to the ke=
rnel's
> > > > > security policy. Another use case is to add context to access log=
s e.g.,
> > > > > which script (instead of interpreter) accessed a file.  As any
> > > > > executable code, scripts could also use this check [1].
> > > > >
> > > > > This is different than faccessat(2) which only checks file access
> > > > > rights, but not the full context e.g. mount point's noexec, stack=
 limit,
> > > > > and all potential LSM extra checks (e.g. argv, envp, credentials)=
.
> > > > > Since the use of AT_CHECK follows the exact kernel semantic as fo=
r a
> > > > > real execution, user space gets the same error codes.
> > > > >
> > > > So we concluded that execveat(AT_CHECK) will be used to check the
> > > > exec, shared object, script and config file (such as seccomp config=
),
> > >
> > > "config file" that contains executable code.
> > >
> > Is seccomp config  considered as "contains executable code", seccomp
> > config is translated into bpf, so maybe yes ? but bpf is running in
> > the kernel.
>
> Because seccomp filters alter syscalls, they are similar to code
> injection.
>
> >
> > > > I'm still thinking  execveat(AT_CHECK) vs faccessat(AT_CHECK) in
> > > > different use cases:
> > > >
> > > > execveat clearly has less code change, but that also means: we can'=
t
> > > > add logic specific to exec (i.e. logic that can't be applied to
> > > > config) for this part (from do_execveat_common to
> > > > security_bprm_creds_for_exec) in future.  This would require some
> > > > agreement/sign-off, I'm not sure from whom.
> > >
> > > I'm not sure to follow. We could still add new flags, but for now I
> > > don't see use cases.  This patch series is not meant to handle all
> > > possible "trust checks", only executable code, which makes sense for =
the
> > > kernel.
> > >
> > I guess the "configfile" discussion is where I get confused, at one
> > point, I think this would become a generic "trust checks" api for
> > everything related to "generating executable code", e.g. javascript,
> > java code, and more.
> > We will want to clearly define the scope of execveat(AT_CHECK)
>
> The line between data and code is blurry.  For instance, a configuration
> file can impact the execution flow of a program.  So, where to draw the
> line?
>
> It might makes sense to follow the kernel and interpreter semantic: if a
> file can be executed by the kernel (e.g. ELF binary, file containing a
> shebang, or just configured with binfmt_misc), then this should be
> considered as executable code.  This applies to Bash, Python,
> Javascript, NodeJS, PE, PHP...  However, we can also make a picture
> executable with binfmt_misc.  So, again, where to draw the line?
>
> I'd recommend to think about interaction with the outside, through
> function calls, IPCs, syscalls...  For instance, "running" an image
> should not lead to reading or writing to arbitrary files, or accessing
> the network, but in practice it is legitimate for some file formats...
> PostScript is a programming language, but mostly used to draw pictures.
> So, again, where to draw the line?
>
The javascript is run by browser and java code by java runtime, do
they meet the criteria? they do not interact with the kernel directly,
however they might have the same "executable" characteristics and the
app might not want them to be put into non-exec mount.

If the answer is yes, they can also use execveat(AT_CHECK),  the next
question is: does it make sense for javacript/java code to go through
execveat() code path, allocate bprm, etc ? (I don't have answer, maybe
it is)

> We should follow the principle of least astonishment.  What most users
> would expect?  This should follow the *common usage* of executable
> files.  At the end, the script interpreters will be patched by security
> folks for security reasons.  I think the right question to ask should
> be: could this file format be (ab)used to leak or modify arbitrary
> files, or to perform arbitrary syscalls?  If the answer is yes, then it
> should be checked for executability.  Of course, this excludes bugs
> exploited in the file format parser.
>
> I'll extend the next patch series with this rationale.
>

