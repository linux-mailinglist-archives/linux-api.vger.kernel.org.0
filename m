Return-Path: <linux-api+bounces-474-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B5882A53C
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 01:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C57428973B
	for <lists+linux-api@lfdr.de>; Thu, 11 Jan 2024 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4038F;
	Thu, 11 Jan 2024 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NJsf+udm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A077219E
	for <linux-api@vger.kernel.org>; Thu, 11 Jan 2024 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a27cd5850d6so509683866b.1
        for <linux-api@vger.kernel.org>; Wed, 10 Jan 2024 16:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704933196; x=1705537996; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=NJsf+udmMv6VWRQdlcAXxWsoP078V+yWouc3IQeOpsuDb8rBqf8Jwfw07hLxjov059
         J8vy97crNMGtVjaNPq4msOkVwEl5x3bkCSb2IceT3LFOCPMF2tAqZLLjqg2WOnBuDHRr
         sCfordjb1dO+oCi1c5/jySKpXZ/i/+teGjbss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933196; x=1705537996;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=TNfTyvo2bqMVYR71Cu4Lu9uYjW9ozr7cL33WHApoH9UFfUG+223zjO40GO/+HScgbs
         GvkQFbE2mHR/nMEXYcgqafH2x7oiJ7aI9HncT6gloPDksv9Z1tvXl43qpYxKe7p9oUZr
         KCG9HZ2u7dJV1Zq/Uo8mQnU/v80owTRo9VdS4/hPlUU3BQfM8W2a+rYQA7jY02YBjcyd
         lFHYJalniA4/3VeE7Py/BoKOde59OXH13JALFGycebXJqnNFzDeUdOgLwITz+r3NT+ea
         ei1ayM3j4wGlL+qk5e3jsSwbJMUkEvH7apBYmeCfH7HLCwAlkZq/KB95J9gG5m4zrkhh
         3XVw==
X-Gm-Message-State: AOJu0Ywu73LYoEftpzz9NtHdfcShMQOq3quxtrT5Avo/TlpABuQz8TZC
	MZRGw63ZbsrOob2U5XFt4xQ0tNgIbLUKwdxu/LMWys46Mq0qDU7i
X-Google-Smtp-Source: AGHT+IH8Cl+9Y7wYYTTl2o+kJAc/N3BihNr4iWlz+DAePvqWZPniud3avwowcHCbvJlo4ZbgEKn7RA==
X-Received: by 2002:a17:907:2990:b0:a26:9347:3742 with SMTP id eu16-20020a170907299000b00a2693473742mr126595ejc.44.1704933195717;
        Wed, 10 Jan 2024 16:33:15 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709061dd700b00a2c2a9b5766sm341009ejh.97.2024.01.10.16.33.14
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 16:33:14 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a277339dcf4so523705266b.2
        for <linux-api@vger.kernel.org>; Wed, 10 Jan 2024 16:33:14 -0800 (PST)
X-Received: by 2002:a17:907:1c9b:b0:a28:d5dd:574f with SMTP id
 nb27-20020a1709071c9b00b00a28d5dd574fmr218565ejc.31.1704933194074; Wed, 10
 Jan 2024 16:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
In-Reply-To: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 16:32:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> with this patch in the tree, all sh4 builds fail with ICE.
>
> during RTL pass: final
> In file included from fs/namespace.c:11:
> fs/namespace.c: In function '__se_sys_listmount':
> include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275

We do have those very ugly SYSCALL_DEFINEx() macros, but I'm not
seeing _anything_ that would be odd about the listmount case.

And the "__se_sys" thing in particular is just a fairly trivial wrapper.

It does use that asmlinkage_protect() thing, and it is unquestionably
horrendously ugly (staring too long at <linux/syscalls.h> has been
known to cause madness and despair), but we do that for *every* single
system call and I don't see why the new listmount entry would be
different.

           Linus

