Return-Path: <linux-api+bounces-5089-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D42BCDAC0
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 17:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D0154133E
	for <lists+linux-api@lfdr.de>; Fri, 10 Oct 2025 15:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B362F746A;
	Fri, 10 Oct 2025 15:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFLDqTBw"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FE2F60CD
	for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108561; cv=none; b=qHUAm7P5euFyB2gYTHxcENXztZ8LXPJuasUy3tK3KCqTK7BV9pK4fWTEFWDAQyZ1MZelHlpXLwYQk+DdWBFTzv8D1a0JEYxGUQOBVveuw6Vh/c/57c1QXJaedCvytCmqPh5G0Pt6ttCsP2ntTNxPEt7c7JFcB2A0lHoyL4q9ljQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108561; c=relaxed/simple;
	bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTeXRCXWQ1HJEVW+Ejq/u48Igoxc6TYCIOtV3pHB3El4NEEUwO8cw1cgQa+sqRLFHiCaFbCwGHxEo9PJujo20veZD8gPLf6u5nNYvfSFGw9Jdl/35N0Lp8JRAtz3I83Hf5b6aekbzRNIZdBWdMRljDWUOLd/SJuC/LqSuo8jbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFLDqTBw; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b48d8deafaeso499244866b.1
        for <linux-api@vger.kernel.org>; Fri, 10 Oct 2025 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108558; x=1760713358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=aFLDqTBwDW9/tslHGMMpz/fDXm/8YFeWeEqOIcghoh/WbHIq4K/0SzxFSFr2C8rGcg
         FzfA6mauz29MwswTSj8YO3mq3cxhh5u7GFdf5ExSSfl6BXbILBg23XGuvlNp3mANuW6S
         eel9qNFJhrnpSPxNuvU8zfBQImKbaXpPm7yI2z/z99IQuraI1weEKXaWKAoKN2dn1Fia
         VeA9V8C1Loi2AzEhqtTtkmVxXU3/XSg2XO66Oqk58zTi4gP34AT/wGmHBqeZyuMiW54A
         2nUtDEww8Cwcun3qpGWQvCqHEXtidVmA+q8Oy3lJypcr/DIo7Im2rac59BUjorWx/gNF
         KEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108558; x=1760713358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=RzALk8gZJA6FUgq5fpeHYo6MlJgr5YKnbyUxPzP0dpida0bJpUUBW+rmakgjKCBmoF
         hhHnI/WzerPFTNYmyuCMDyYtVV4qFqkRcOWie+m/C64j/XgPDOuAWqsxttV++gRKVaOR
         e99VvXGN3KaKPY7rvq6ujxp/rKI7VJ19kXNOYQSRvu2Gq7bN5kjJFJC33mjiEJLgVnc8
         IYfq/pyhPLyCPYee50E1LNNmwh0Y+kIKWDtT+1YYlUtc6TfP4h/4LZwc9S1CZM1YYL88
         wePz4WWSGoh0Pl56L2qoIsAkM3X4YGHcyO9kIQYG6hHsMl6A/BJaEO+TLOcN5xPwRmnl
         gLcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg3ZQ/Eg+y7Tlli9KLNNFhNBfRdldj/QaYA9ZeZC4yhUZZyTy3g4c8bd1lY7Ejs+r0iPDN7qPurHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxsNQP3qrshaUxxn+olukBrdxQHZ9Gvzsv//4HCHsMPjvwFJO0
	rpye0YE2m42AIprfw2BRicKZneqrd7Tewd2skw3bhPoM0hPpOkkPsVDiqstt5hPdAh+Zm0Py477
	H2NuxFFD7R6C/wagrNUDaozlkwPdETlI=
X-Gm-Gg: ASbGncs6167anguia8YsjKAYVNPVwbVrgzn8tmv8OrZqEriO52ofcdbFDCES/hLx3ED
	s92aZzzTsbZ2lju2XYbUtbK19rAsUwdpt2AfT4t9ubyVMz8PePYIEwuaksArJPpTAoQB8z3VCbH
	sGW/KRN20uF9cVnkf/LTUN3HCmyiJaJ630QTQI8sZW9p9GcyeOuWaFhakGNd/9XJ2KHIpZHDnFx
	4zcqv9SuCW+siJV2sqDhj7RDQ==
X-Google-Smtp-Source: AGHT+IGa/polL6/8Ynsft44cUD0O1NPKwafCC8Smc6nmBnm4TDK7NhR64Y4hIQgBMI+z098vLRzD8f+sU8sdugojvoo=
X-Received: by 2002:a17:906:c104:b0:b04:9ad9:5b29 with SMTP id
 a640c23a62f3a-b50ac5d1e3bmr1407180966b.54.1760108556823; Fri, 10 Oct 2025
 08:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com> <20251010094047.3111495-2-safinaskar@gmail.com>
In-Reply-To: <20251010094047.3111495-2-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 18:02:00 +0300
X-Gm-Features: AS18NWAoVP5WYC_07QqSXrvsFY0nBG5PiGs9ESaeN2ZfR7dfSMsKUbHhpVYPARc
Message-ID: <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:42=E2=80=AFPM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> ...which do nothing. They were deprecated (in documentation) in
> 6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
> "rdev"") and in kernel messages in c8376994c86c ("initrd: remove support
> for multiple floppies")

With all the respect to the work and the series I have noted this:
1) often the last period is missing in the commit messages;
2) in this change it's unclear for how long (years) the feature was
deprecated, i.e. the other patch states that 2020 for something else.
I wonder if this one has the similar order of oldness.

--=20
With Best Regards,
Andy Shevchenko

