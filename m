Return-Path: <linux-api+bounces-492-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7182BA0B
	for <lists+linux-api@lfdr.de>; Fri, 12 Jan 2024 04:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10E7BB22AD2
	for <lists+linux-api@lfdr.de>; Fri, 12 Jan 2024 03:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9341A733;
	Fri, 12 Jan 2024 03:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BLKAXCl/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400071B27B
	for <linux-api@vger.kernel.org>; Fri, 12 Jan 2024 03:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55569b59f81so7412071a12.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 19:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705030852; x=1705635652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1uV8nauYydYh4R8L5vh4G6BKRZADuM0xKtlvDNSU8=;
        b=BLKAXCl/EkJ7r8T0o4KJBW2ORNo2Q0UMIniipZJ4hD0VR/zPd/NfnTsS5gbkGxnOm0
         AnmXBI+W2/1HA4tCrLPxTg4EF654zCUKQo5aPPUFqVKK+Fw2sl+oYssjX15MU3RDDD5F
         Idr0CeKbvCjn2KjUwTcIGaFt+N8quWWCoKajA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705030852; x=1705635652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1uV8nauYydYh4R8L5vh4G6BKRZADuM0xKtlvDNSU8=;
        b=F1ZrqkYnv7/O5l8vzjhsjSmgTyB1YoIG2RVAa5rr/nfpTZ9M3FbfaRx57nyLlRoxnb
         OEA1WZQxnqtu8riQBiiPyHHMMi2vA1j4sg2ZfXCWMRe0jliq6Zd9q42p8tSBhDpZGjbe
         4bLh52aVZ6sDrCUDbz5Du02OWxWYcvUXjJsLJ0ldVB/5EQAUdGSbNhumNXbpikl1IFks
         QWbxF2Ld7cD/+i78Mzk8tyVsL/AKp3fo35c3a+GKlF9tUppl7cTk0K6JhKilOHSCBNRb
         v0ew6ghCBkBAoxX8dk8J6qROR6bhYk48SJ7dh2LjwQfIqEgA8tbujgyO03Dv7SvZNRqG
         fYAA==
X-Gm-Message-State: AOJu0Yz9tvDlnn0Q8RheanLT+SoiD91EJdNwlxnI3u0kE3qCdcPig6zZ
	LnPD7c0UL0c4jMD52F6+6yvhuZ+G0l8m4PqqKUdShDcNgp9Hw0K9
X-Google-Smtp-Source: AGHT+IEIN+ZIR2NnyH/dVrvjTCle7EuRy319tAF13nzcwbfReRGC5MmV6xAXyWtR80AMsBm/MjU9cA==
X-Received: by 2002:a17:906:6a06:b0:a2c:34e8:6429 with SMTP id qw6-20020a1709066a0600b00a2c34e86429mr338114ejc.69.1705030852364;
        Thu, 11 Jan 2024 19:40:52 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id g17-20020a170906c19100b00a2b1a20e662sm1280820ejz.34.2024.01.11.19.40.49
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 19:40:49 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28a6cef709so665960666b.1
        for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 19:40:49 -0800 (PST)
X-Received: by 2002:a17:907:a02:b0:a28:df9e:b2e1 with SMTP id
 bb2-20020a1709070a0200b00a28df9eb2e1mr358646ejc.54.1705030849339; Thu, 11 Jan
 2024 19:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net> <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
 <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net> <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
 <77b38aa7-a8b1-4450-8c50-379f130dda16@roeck-us.net>
In-Reply-To: <77b38aa7-a8b1-4450-8c50-379f130dda16@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 19:40:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>
Message-ID: <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 15:57, Guenter Roeck <linux@roeck-us.net> wrote:
>
> I wonder if something may be wrong with the definition and use of __m
> for u64 accesses. The code below also fixes the build problem.

Ok, that looks like the right workaround.

> But then I really don't know what
>
> struct __large_struct { unsigned long buf[100]; };
> #define __m(x) (*(struct __large_struct __user *)(x))

This is a historical pattern we've used because the gcc docs weren't
100% clear on what "m" does, and whether it might for example end up
loading the value from memory into a register, spilling it to the
stack, and then using the stack address...

Using the whole "tell the compiler it accesses a big structure" turns
the memory access into "BLKmode" (in gcc terms) and makes sure that
never happens.

NOTE! I'm not sure it ever did happen with gcc, but we have literally
seen clang do that "load from memory, spill to stack, and then use the
stack address for the asm". Crazy, I know. See

  https://lore.kernel.org/all/CAHk-=wgobnShg4c2yyMbk2p=U-wmnOmX_0=b3ZY_479Jjey2xw@mail.gmail.com/

where I point to clang doing basically exactly that with the "rm"
constraint for another case entirely. I consider it a clang bug, but
happily I've never seen the "load only to spill" in a case where the
"stupid code generation" turned into "actively buggy code generation".

If it ever does, we may need to turn the "m" into a "p" and a memory
clobber, which will generate horrendous code. Or we may just need to
tell clang developers that enough is enough, and that they actually
need to take the asm constraints more seriously.

                Linus

