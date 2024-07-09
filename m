Return-Path: <linux-api+bounces-1915-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A5A92C5C8
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 23:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABC21C22729
	for <lists+linux-api@lfdr.de>; Tue,  9 Jul 2024 21:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F57187853;
	Tue,  9 Jul 2024 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="INrTZPd3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8A8187849
	for <linux-api@vger.kernel.org>; Tue,  9 Jul 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562306; cv=none; b=FsQaIVyTc8DTh5S6C6q6cgHSMKLGKMYTC2erOPg8VUtBwzDEBo87xVKaqJwBSkXrc3Dx1jgG/6powzStxQy2mIGZ0NXCwg72EYzd5J3YzSTBbXZxtqPMy2Z7CRkR1qUW3kqen0iYsFDvypDiu40o27aNFikpLMeuqcRMJhkS/N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562306; c=relaxed/simple;
	bh=/JHQKI6qRGJJpd6MZqEnliPYlq/fkQstnp74/r7RAmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQTDaq4z5nlJFlT3KwfdxnPNiaByZnHz2mRoqBlXlfej2Lcs8GFgZrsT07MJw00MgtzqbliKCzoslSAud7+Um5EvdCwn6BEBrk/ceP7icQud6/x7q1LE1wehtEzD7goEZZG79UKvYzoYXVPJUVl+VMT5YKAnwjuG5LEi7ezzW2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=INrTZPd3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447df43324fso42431cf.1
        for <linux-api@vger.kernel.org>; Tue, 09 Jul 2024 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720562304; x=1721167104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N4RzwbAAmEP/AG2T8Gw592nDB74gw9mJLtjSTvDgE0=;
        b=INrTZPd3rTNb/Mv747Q3UPOIkhB01oo5WUfN8jay2s72Adoggnal6Q56keC2EeIyRX
         KaAYv3t5o4/qDGPQFqf/IylTwSH06CsJ+Ys7q9oFObHMqfq+X3yf/LfvDdxY7fiyrQjy
         mad8reCJ8WTeBjyCx2YilAetrxUmbsHYa8d5GD1leLQPLNEIKilqHVIqt/zhq209upBi
         V37jcSLeAkIp1i9/04ThRoWIoWrDuOzKP9NE+Yh/vBMjuMK7836ugOrCgIfSEBQh00jQ
         kDmfJ783zgT8681KEt6yk1aBG5ZtzDQAL3Rav2+zsggij/sKJR1au+Y5tjQFxi/OYo52
         sfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562304; x=1721167104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8N4RzwbAAmEP/AG2T8Gw592nDB74gw9mJLtjSTvDgE0=;
        b=t6cN7BgZ9vm7vAinjR8PCsbogfv4LpaqCeX8csvhwSSN3AuJwQeoRLK86hGXh8WPEx
         Y0RPv4mCIY3XFCnQQqjLNqay1NxZrblWXgO556QCw2LpH79KcnZFfMA/2pz0NTwTQf4j
         nk/9ybxvQ0yyueOO0jtCt/DnW3JwT+fQ3Ucj5CD73drxqjaPW0mI+qpcLqA7YzU4EP9E
         YuU5cAzr+am5IgvxioVPEhbYcINI5ihVA6BWGKTESPlV83sRpjzUtPlamPUkbGXhFHjC
         sFc70vJUxOmMJSPIF+WpwLh1ehJxt6poYon03pxHkJ/7fexNn56yADz0FHytQUv83Cla
         1awQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhD30baIg/Y9XesZ/GFvJaEjwjqdIS3j0ZFLlVWSAnjsN0/lXKJd7huKvJGEap0ArH6uDdiCsolNK20+IBj1d7s4opVrJBUtoy
X-Gm-Message-State: AOJu0YxDV8nJ/+8eSjjYXB0cdDnrIii8o1oLiQkztpb34vY8AIIOFrT0
	AJ5hUckbDQBBR/My96Vs9Qakk7XgieGRzZfESWxRG+BgkPkTEeiE7veRDuFvmOeEyhpMrchvFIu
	I9M5KEWDYTqVb6Wtk5MORYzjxaJYN6FLgrotq
X-Google-Smtp-Source: AGHT+IHU/ulbI1FgR/JVMf8iXIlBgjwo6bpuSXE1LPPT7fla6HjTvbnXEhuRdbGZtTi1CaktDzIEC12PO4kPA95OI0s=
X-Received: by 2002:a05:622a:15ce:b0:447:e728:d9b with SMTP id
 d75a77b69052e-44acc23802bmr1367101cf.26.1720562303300; Tue, 09 Jul 2024
 14:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net> <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org> <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
 <20240709.aech3geeMoh0@digikod.net>
In-Reply-To: <20240709.aech3geeMoh0@digikod.net>
From: Jeff Xu <jeffxu@google.com>
Date: Tue, 9 Jul 2024 14:57:43 -0700
Message-ID: <CALmYWFuOXAiT05Pi2rZ1nUAKDGe9JyTH7fro2EYS1fh3zeGV5Q@mail.gmail.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
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
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 1:42=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> On Mon, Jul 08, 2024 at 03:07:24PM -0700, Jeff Xu wrote:
> > On Mon, Jul 8, 2024 at 2:25=E2=80=AFPM Steve Dower <steve.dower@python.=
org> wrote:
> > >
> > > On 08/07/2024 22:15, Jeff Xu wrote:
> > > > IIUC:
> > > > CHECK=3D0, RESTRICT=3D0: do nothing, current behavior
> > > > CHECK=3D1, RESTRICT=3D0: permissive mode - ignore AT_CHECK results.
> > > > CHECK=3D0, RESTRICT=3D1: call AT_CHECK, deny if AT_CHECK failed, no=
 exception.
> > > > CHECK=3D1, RESTRICT=3D1: call AT_CHECK, deny if AT_CHECK failed, ex=
cept
> > > > those in the "checked-and-allowed" list.
> > >
> > > I had much the same question for Micka=C3=ABl while working on this.
> > >
> > > Essentially, "CHECK=3D0, RESTRICT=3D1" means to restrict without chec=
king.
> > > In the context of a script or macro interpreter, this just means it w=
ill
> > > never interpret any scripts. Non-binary code execution is fully disab=
led
> > > in any part of the process that respects these bits.
> > >
> > I see, so Micka=C3=ABl does mean this will block all scripts.
>
> That is the initial idea.
>
> > I guess, in the context of dynamic linker, this means: no more .so
> > loading, even "dlopen" is called by an app ?  But this will make the
> > execve()  fail.
>
> Hmm, I'm not sure this "CHECK=3D0, RESTRICT=3D1" configuration would make
> sense for a dynamic linker except maybe if we want to only allow static
> binaries?
>
> The CHECK and RESTRICT securebits are designed to make it possible a
> "permissive mode" and an enforcement mode with the related locked
> securebits.  This is why this "CHECK=3D0, RESTRICT=3D1" combination looks=
 a
> bit weird.  We can replace these securebits with others but I didn't
> find a better (and simple) option.  I don't think this is an issue
> because with any security policy we can create unusable combinations.
> The three other combinations makes a lot of sense though.
>
If we need only handle 3  combinations,  I would think something like
below is easier to understand, and don't have wield state like
CHECK=3D0, RESTRICT=3D1

XX_RESTRICT: when true: Perform the AT_CHECK, and deny the executable
after AT_CHECK fails.
XX_RESTRICT_PERMISSIVE:  take effect when XX_RESTRICT is true. True
means Ignoring the AT_CHECK result.

Or

XX_CHECK: when true: Perform the AT_CHECK.
XX_CHECK_ENFORCE takes effect only when XX_CHECK is true.   True means
restrict the executable when AT_CHECK failed; false means ignore the
AT_CHECK failure.

Of course, we can replace XX_CHECK_ENFORCE with XX_RESTRICT.
Personally I think having _CHECK_ in the name implies the XX_CHECK
needs to be true as a prerequisite for this flag , but that is my
opinion only. As long as the semantics are clear as part of the
comments of definition in code,  it is fine.

Thanks
-Jeff


> >
> > > "CHECK=3D1, RESTRICT=3D1" means to restrict unless AT_CHECK passes. T=
his
> > > case is the allow list (or whatever mechanism is being used to determ=
ine
> > > the result of an AT_CHECK check). The actual mechanism isn't the
> > > business of the script interpreter at all, it just has to refuse to
> > > execute anything that doesn't pass the check. So a generic interprete=
r
> > > can implement a generic mechanism and leave the specifics to whoever
> > > configures the machine.
> > >
> > In the context of dynamic linker. this means:
> > if .so passed the AT_CHECK, ldopen() can still load it.
> > If .so fails the AT_CHECK, ldopen() will fail too.
>
> Correct
>
> >
> > Thanks
> > -Jeff
> >
> > > The other two case are more obvious. "CHECK=3D0, RESTRICT=3D0" is the
> > > zero-overhead case, while "CHECK=3D1, RESTRICT=3D0" might log, warn, =
or
> > > otherwise audit the result of the check, but it won't restrict execut=
ion.
> > >
> > > Cheers,
> > > Steve

