Return-Path: <linux-api+bounces-1881-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A1E92A77E
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 179831C20CAB
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 16:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952B814659A;
	Mon,  8 Jul 2024 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Ls7ifb6"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2C81751
	for <linux-api@vger.kernel.org>; Mon,  8 Jul 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720456886; cv=none; b=NXIjZN0QH3aB0TPqg+5IoaqhtxVRpYumzNQAOq7/GtwYG/CGv4P1IKHgLLWeD33tBnedkhyIKKbHNr2aTGp1VAcDFk6N/AnOVYDigQN/tdyj2DeQ3kT4Guh6tL9clb5YsATI0+t2GOYCp9RbIakFieB5hMy9/RYD4KD1+r62jW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720456886; c=relaxed/simple;
	bh=kgSwKFu/TnS6fJXWAO8HYbXIDAtOL7ia5DsT4ZaMrJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LFgWfe9a+1qo93VmKudROZEmeawsf5xe6EMtLfnV+7B6iE/svJE8oYWfZln8PFaqT60shCSiXpLiTylvJXPK3KeUWcERDCeJehGCzNyCrSdHrnX0tceGmcU9jh6dxr3RkcFHuRVTbSUKyKaYuxQJxGjJfXJgLKwcnIGkCWe6dBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Ls7ifb6; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58c0abd6b35so142a12.0
        for <linux-api@vger.kernel.org>; Mon, 08 Jul 2024 09:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720456883; x=1721061683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5h9K8a8sSLubZd/W2Bpa7ei/SlFMORW/ZDCStOq+wM=;
        b=2Ls7ifb6v0UXptyiNOS8Qk3j0Fsn4WCN0HGGsBuOipNbtsbqctXuxei9NsUSdia8BV
         3HlsQy0z9fQWERbbgerwhh0sFBoYgB0xj80YiKL2DDZwgI5zFO7c0b62STuvA7i7fdPn
         j+SgYrQdcrxxMn4zf92QrCT8+OIYkAEmebWy65/lU/tfRXXqOELKhqCWprBFRm1aNFSt
         PeF/+Vn+BXT+PkU1nh4lfr6LI6KIjptHqyR3L3gALE/f1kTiWO7HB1wiT5F/m3TiaVmf
         jwBqSxUAuNETAr+L39b4ogXSjcBPtL2C4zsG2dWbRleOpPLBavQwv4iIuBnwzqXs2dso
         G7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720456883; x=1721061683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5h9K8a8sSLubZd/W2Bpa7ei/SlFMORW/ZDCStOq+wM=;
        b=guZIkuqn9O/vB/oO4dwIJVl2hGR/B7AwcR+96MYdKTjZII6tFzS0QDCwsXVrZ9giGk
         BOIBolJaFx/kmbLiLGFBE/bXNjpdlVq3NUK+QYmKWQaAgRkvEZtkCLRX2AR/SlTF4iSD
         FUuHuxv9k7VL/MLrSV38D2mKg4rMiRPSca2fE8lM+GvhidXkWwXdCU4uys4McWi4yfzd
         pZI2FWcI+EvvYs0Y2sw/6po4liEUGrohZuuSaHOCw4z2zvzFd2gUkVZRSq2O6vxlpiCI
         vLAJA1HvQMdpdbgMrP9wyx50mtQNB+GinredK2eQeMWhGrLe6CIQkb0b1U/MME4apj2O
         deEg==
X-Forwarded-Encrypted: i=1; AJvYcCUkA5QOduePYq13r8kGjeq81Z1DxPUhpd69JDk37xAc3OfIPWCrFfFtPcS1a6IClIJETJ/V+rHlkCGKkpIjzPTgNEkggRi5aDD4
X-Gm-Message-State: AOJu0YzQkE/0HdTptvKH29pXQU4as1j1yft8X5yoZ3L31GLDZjwFsOXX
	fnbyd8U3zT/NJLRHsGSLsAZkPrkW0qTGX6dikEiElZgIeeZ9nwxcUoqU32DvoJrnEr1JlCKIy4T
	oFf10b43FBFdw66MtKQHP1c2+p6eODt2DoR92
X-Google-Smtp-Source: AGHT+IGnZrn5/gF0KK99nMLQYDqQtH14UdCGc9dpKYr4CJb2IgbOmv7c7MrCZL5Np69D3hoUFnM393mMoyI6bE88g5c=
X-Received: by 2002:a50:bae9:0:b0:58b:dfaa:a5cd with SMTP id
 4fb4d7f45d1cf-59352e1a5b2mr174396a12.2.1720456883109; Mon, 08 Jul 2024
 09:41:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com> <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
 <87ed83etpk.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87ed83etpk.fsf@oldenburg.str.redhat.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 09:40:45 -0700
Message-ID: <CALmYWFvkUnevm=npBeaZVkK_PXm=A8MjgxFXkASnERxoMyhYBg@mail.gmail.com>
Subject: Re: [RFC PATCH v19 1/5] exec: Add a new AT_CHECK flag to execveat(2)
To: Florian Weimer <fweimer@redhat.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, 
	Alejandro Colomar <alx.manpages@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, 
	Christian Heimes <christian@python.org>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Eric Chiang <ericchiang@google.com>, 
	Fan Wu <wufan@linux.microsoft.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
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
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 9:26=E2=80=AFAM Florian Weimer <fweimer@redhat.com> =
wrote:
>
> * Jeff Xu:
>
> > Will dynamic linkers use the execveat(AT_CHECK) to check shared
> > libraries too ?  or just the main executable itself.
>
> I expect that dynamic linkers will have to do this for everything they
> map.
Then all the objects (.so, .sh, etc.) will go through  the check from
execveat's main  to security_bprm_creds_for_exec(), some of them might
be specific for the main executable ?
e.g. ChromeOS uses security_bprm_creds_for_exec to block executable
memfd [1], applying this means automatically extending the block to
the .so object.

I'm not sure if other LSMs need to be updated ?  e.g.  will  SELINUX
check for .so with its process transaction policy ?

[1] https://chromium-review.googlesource.com/c/chromiumos/third_party/kerne=
l/+/3834992

-Jeff


> Usually, that does not include the maim program, but this can
> happen with explicit loader invocations (=E2=80=9Cld.so /bin/true=E2=80=
=9D).
>
> Thanks,
> Florian
>

