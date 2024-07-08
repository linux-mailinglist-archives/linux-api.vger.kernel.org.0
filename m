Return-Path: <linux-api+bounces-1877-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF8E092A6DC
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08CD1C21424
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 16:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD9E14430B;
	Mon,  8 Jul 2024 16:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqrsY0w5"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFD13D2A9
	for <linux-api@vger.kernel.org>; Mon,  8 Jul 2024 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454953; cv=none; b=mIqby8B/FtRtdI+Hh1cgH901wkMmt8v93l3U1RVqXcuvjOpJFURYBqV81dZTs4vZ4UYl2oyp9py8N5MX20ZvMZu449rgfKTENfeIxLH9XWGnUcLlmptgU5CU2OcsMdY0oe2a8cC54SFUORutLZCDLupgOLC9Z4hJPh9qvCALXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454953; c=relaxed/simple;
	bh=Vuy+tdEYiWTkuOL1+Ju14j/vlrE3oT4RzPh9CG4iLj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LRagxpD7RIfiGkzRx6yJzAMywO6gVjaNif0hdN44i4MqFtVYKdw/Y7HceOXwCfiFzMa12n5iHnz74Ly8PKlu6M1nUn+3e742wpEjpDCZyQDMIkBtQdP9fb3qlFEguRAQ2ltGM6JIPZPGa01YYZbJmr6WyyErrKVscpgpeqT2sVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqrsY0w5; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso41709a12.0
        for <linux-api@vger.kernel.org>; Mon, 08 Jul 2024 09:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720454950; x=1721059750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsiFj/WxLrZpXhxwXs3+FDSwWwZ1Cd4GcIfLRJ1s7ho=;
        b=VqrsY0w5ejKEVldgEKJIRbeyqZ9zuUGKF86JuCw6p2IFCoAxNFyaeqq2Dh3q64hO/x
         dkYXzluGQPJrYaBUD5Gj7NTBQrkFQtRwXL8lmrZPD9IS4z1MRKEcY7/H+mFMMSBteQWa
         FR44zgKoCMFDmg/ZsDIkwintaK4q7XqQgrjnvxdc1AU+bwrZxA002cOnMqb6yU6atuRo
         1yhWKFVFGlraZeF2OxMQiW6L8og8fylrQmIBfLW/z67Loz7IGpSKIr+O7XXezhTPDcIv
         qzrnEejjDLidPqvbrKh5667Lu4di/DuUoikzbLfCuKJISjNRlGs3u64mKrJE6aduhb7b
         53lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720454950; x=1721059750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsiFj/WxLrZpXhxwXs3+FDSwWwZ1Cd4GcIfLRJ1s7ho=;
        b=YZpsQJJAp8/RobK7pHk+PvAkZ4lVWVuGN/Hp0BCwi4C/KgT+rfdZKj2kZWHb0deELT
         LgXrGdwyNme0aEUT0s4BLLTMfNQM8M/JxyOgT8bWpsLMFpkW2QZhdTYkDDMjf8w4ylng
         3ViYEvwc5ba7cpDdX0q6DTzzy3slKWqG4G5CxgWqqFVYK2rg01AbGjQhPY7iPKXjp3Zm
         0TGWESnd1//EVSqdh5hAEb0SBWUF1xEXzuhqjYQ3VxVu+Vl56Hs7HE1eCe1Yps8XCp4d
         BORGXup8yv6dVj60QWXCwJrUaUO9Bur3QORnEiIP6Nc8uhwayF0MdDLlJpGykn/2zAbY
         37FA==
X-Forwarded-Encrypted: i=1; AJvYcCVxo5YRhcc1A8sOadem/Wne+36rY3R38k2K1b0NQ9rIpkJVz3alojTMLnt7YOyOHP9H2WENvwNJRUeajjjWiHSaprKIdqTqCtPY
X-Gm-Message-State: AOJu0YyMxqG1iUbK5C+1QV3MZbk09ELajhPlTBDTkSpiW0N+mIxjztyE
	F+HAZ7EURwu36k3yXs14pj45+QZ5Y20zNGheDbz88IqugOUngTZN04o8HFP/qW4bDQq6NAMOm9o
	WvLPY9jOjIhoNIXfnt/ta7xHmCsfmryA82gD4
X-Google-Smtp-Source: AGHT+IG68WVmOzY4xDmfQcCAQVMnFKtmNO3cbEdYJgbHLx0bLl7VhaJKp8PuklOozwexmfThc7tkOd6AwzlEUeRW6sA=
X-Received: by 2002:a50:8ad3:0:b0:57c:bb0d:5e48 with SMTP id
 4fb4d7f45d1cf-58e00933a13mr529925a12.2.1720454949927; Mon, 08 Jul 2024
 09:09:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-2-mic@digikod.net>
 <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87bk3bvhr1.fsf@oldenburg.str.redhat.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 09:08:29 -0700
Message-ID: <CALmYWFu_JFyuwYhDtEDWxEob8JHFSoyx_SCcsRVKqSYyyw30Rg@mail.gmail.com>
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

Hi

On Fri, Jul 5, 2024 at 11:03=E2=80=AFAM Florian Weimer <fweimer@redhat.com>=
 wrote:
>
> * Micka=C3=ABl Sala=C3=BCn:
>
> > Add a new AT_CHECK flag to execveat(2) to check if a file would be
> > allowed for execution.  The main use case is for script interpreters an=
d
> > dynamic linkers to check execution permission according to the kernel's
> > security policy. Another use case is to add context to access logs e.g.=
,
> > which script (instead of interpreter) accessed a file.  As any
> > executable code, scripts could also use this check [1].
>
> Some distributions no longer set executable bits on most shared objects,
> which I assume would interfere with AT_CHECK probing for shared objects.
> Removing the executable bit is attractive because of a combination of
> two bugs: a binutils wart which until recently always set the entry
> point address in the ELF header to zero, and the kernel not checking for
> a zero entry point (maybe in combination with an absent program
> interpreter) and failing the execve with ELIBEXEC, instead of doing the
> execve and then faulting at virtual address zero.  Removing the
> executable bit is currently the only way to avoid these confusing
> crashes, so I understand the temptation.
>
Will dynamic linkers use the execveat(AT_CHECK) to check shared
libraries too ?  or just the main executable itself.

Thanks.
-Jeff


> Thanks,
> Florian
>

