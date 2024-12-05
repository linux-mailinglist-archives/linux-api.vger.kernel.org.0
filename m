Return-Path: <linux-api+bounces-2827-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C7D59E4CBA
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2024 04:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E313D1881233
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2024 03:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1A01917EB;
	Thu,  5 Dec 2024 03:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LV2+lPjt"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8946C193
	for <linux-api@vger.kernel.org>; Thu,  5 Dec 2024 03:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733369629; cv=none; b=hRkkxois5VDb8cZxyjdXBp1nzqTQ/XeztpKS2NSM0/c3iEOfATMKF14Dztw83dc5hbCGasclN610BIGzGye6zuYsK2Jt5sGVU1QcN8hCYuk9J2p8Aq3MUuq7y9yD6YDfJ52+dV05rqjF4G4g/8cEwQf6v86XwnAwmlWrV9wZ8Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733369629; c=relaxed/simple;
	bh=2YpfMKIZHCtC1yAwRNTrkyONKJmfX3P1Dgzh962vtHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFoZxqkWOwFxrq077GTYvj/S7AJHl2Xsu1A+S0PHoOrRN4wgCbnKxCsCGU+rQT0uier/IM/O6c/bW20s44w0kPJXJb3GU3KG6E5aVPg1xhAIkG14afEwEQy22PdjJdnak4DcfYEsutUpZHXwCrn0hrk8sKxxpSVbbZKkTxfTUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LV2+lPjt; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e396cff6d36so614510276.3
        for <linux-api@vger.kernel.org>; Wed, 04 Dec 2024 19:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733369625; x=1733974425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqqlC+ZUU04wDK2N54+0ftqA1cSI7m49jZLokKLp/0E=;
        b=LV2+lPjt4zqa+p3asLanKzH/KAN9YuOD1oGdsCw6FQtNOeq7PFsPJO8I8X4zIcUDmd
         T7VgI8gcSdFEDjzhHMWVR7vTaE3AUoKXxCkZyU2kUOgvKf7PCEhLfXL4eTFtoK0vWiQK
         L+2FhhgTocjiE17U4gEUoXEpKsSor8m7J4iMyxSJxWKvcDXhZbD2mqCO4NO0A2cluNh1
         FiG+ZH3PhYBA4UqYfQY6KA8RRUA5pW5MwMcncmhKWhzV4YcCUDef3uqhJV2JELjCbLht
         wlX1SRH8ORLTADfiIfQXcu6waSGFjC64jTXCxCh+VM02shbKnMtxlWLmPbbxnM6U3w6r
         5oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733369625; x=1733974425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqqlC+ZUU04wDK2N54+0ftqA1cSI7m49jZLokKLp/0E=;
        b=JZe3q4Z6yzvQoizqINGFa8h+O+lytZNa/82vvp8foXSwMwyzjypvv4N2UMKmpb/9ip
         vjGqaaEcmwLjdRqRXyEKzIKMqyYDqc5fn7uP4EO2SYd309CV6rAauoUL2aXZ04pnB3kh
         Iho/BAb2guqP0PGY477PGV5K2GgYW22lD3rxkpHVqsVaRG0Ej3EObnbGhJ4MtQpbBev4
         KWYEhKyjTt4Pep8W6DXEIWwFEZmPJgfyKCi9eVELxg+gMgF206hWQYYDvUTgV/25ELmn
         7hgNaC86Pntv5kBxAgiD9U9GYpBDY00/lK6NK+AxqjIHMvTRAWA5rCaBloIYHuxG+b14
         4YNw==
X-Forwarded-Encrypted: i=1; AJvYcCVU49nNYh9MLvKKyTewOal7gN7VPqkHUbf0m63zWqKe+IJR/6MiRAv2V3sgaDQNtHv5aRVoa9e1O4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJQSoWSDxVGAsglfoARKjVKbIhPvcOAkAwc7iy3KswiDuh2Hwq
	s7l5J4SkwOrDquKpztAR+P0BP3WdrKjfc6LFvkspq0l3IMWoY1xoRLJEKj+IdRyUY3Zm3jfnEO/
	uuSs/JMGQbfVFDgt3pw1W8Q0HVFrDD6tur163
X-Gm-Gg: ASbGnctARqoFN60EDLrgZma3mSKODJYkrYaVB9uisD4pZ0y2aIYcuSXn0LT0cwHgWPt
	0w5fpUxoTxKjk3WP2bAef3sFwVaiirA==
X-Google-Smtp-Source: AGHT+IFIW0nv4nMp+xB3hRxH7jiqJFLJ+/vbSzLjYlJYf27dkS9U79OHIOtdDmrXE95yoa1diQrswqexP0FD2HzbsL0=
X-Received: by 2002:a05:6902:10c1:b0:e2b:dbf6:34ca with SMTP id
 3f1490d57ef6-e39d43740bdmr7490115276.36.1733369625457; Wed, 04 Dec 2024
 19:33:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112191858.162021-1-mic@digikod.net> <20241112191858.162021-2-mic@digikod.net>
 <CABi2SkVRJC_7qoU56mDt3Ch7U9GnVeRogUt9wc9=32OtG6aatw@mail.gmail.com>
 <20241120.Uy8ahtai5oku@digikod.net> <CABi2SkUx=7zummB4JCqEfb37p6MORR88y7S0E_YxJND_8dGaKA@mail.gmail.com>
 <20241121.uquee7ohRohn@digikod.net>
In-Reply-To: <20241121.uquee7ohRohn@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 4 Dec 2024 22:33:34 -0500
Message-ID: <CAHC9VhT9sRXauYX+=21MUdOmfTZL4=sdGQsXojJjjTsdui+F_g@mail.gmail.com>
Subject: Re: [PATCH v21 1/6] exec: Add a new AT_EXECVE_CHECK flag to execveat(2)
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Jeff Xu <jeffxu@chromium.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Serge Hallyn <serge@hallyn.com>, Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
	Alejandro Colomar <alx@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Elliott Hughes <enh@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Luca Boccassi <bluca@debian.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	Steve Dower <steve.dower@python.org>, Steve Grubb <sgrubb@redhat.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Eric Paris <eparis@redhat.com>, 
	audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 8:40=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> On Wed, Nov 20, 2024 at 08:06:07AM -0800, Jeff Xu wrote:
> > On Wed, Nov 20, 2024 at 1:42=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > > On Tue, Nov 19, 2024 at 05:17:00PM -0800, Jeff Xu wrote:
> > > > On Tue, Nov 12, 2024 at 11:22=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <=
mic@digikod.net> wrote:

...

> > > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > > index cd57053b4a69..8d9ba5600cf2 100644
> > > > > --- a/kernel/auditsc.c
> > > > > +++ b/kernel/auditsc.c
> > > > > @@ -2662,6 +2662,7 @@ void __audit_bprm(struct linux_binprm *bprm=
)
> > > > >
> > > > >         context->type =3D AUDIT_EXECVE;
> > > > >         context->execve.argc =3D bprm->argc;
> > > > > +       context->execve.is_check =3D bprm->is_check;
> > > >
> > > > Where is execve.is_check used ?
> > >
> > > It is used in bprm_execve(), exposed to the audit framework, and
> > > potentially used by LSMs.
> > >
> > bprm_execve() uses bprm->is_check, not  the context->execve.is_check.
>
> Correct, this is only for audit but not used yet.
>
> Paul, Eric, do you want me to remove this field, leave it, or extend
> this patch like this?
>
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 8d9ba5600cf2..12cf89fa224a 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -1290,6 +1290,8 @@ static void audit_log_execve_info(struct audit_cont=
ext *context,
>                 }
>         } while (arg < context->execve.argc);
>
> +       audit_log_format(*ab, " check=3D%d", context->execve.is_check);
> +
>         /* NOTE: the caller handles the final audit_log_end() call */
>
>  out:

I would prefer to drop the audit changes rather than add a new field
to the audit record at this point in time.  Once we have a better
understanding of how things are actually being deployed by distros,
providers, and admins we can make a more reasoned decision on what we
should audit with respect to AT_EXECVE_CHECK.

Beyond that it looks okay to me from a LSM and audit perspective, so
feel free to add my ACK once you've dropped the audit bits.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

