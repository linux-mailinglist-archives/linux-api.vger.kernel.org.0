Return-Path: <linux-api+bounces-4862-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE63B81477
	for <lists+linux-api@lfdr.de>; Wed, 17 Sep 2025 20:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A735487727
	for <lists+linux-api@lfdr.de>; Wed, 17 Sep 2025 18:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B2A3009E9;
	Wed, 17 Sep 2025 18:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="g1LtUuBN"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19612FFFAC
	for <linux-api@vger.kernel.org>; Wed, 17 Sep 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758132049; cv=none; b=PBlrFWHs11UPIlJGNCnSZ9s6Vq8gnyJFcEYvuFqaTPo3Ne7AROehio6hQFEnG0gPkX2ei2BiOs8OnYxDEmOfsKnlef4J4qCyS6+KiQtS1wtgxdjZDzWT0X1PuocdLdHVwAVWu2yzCuBHc0HR8PlojYRYqs6t3ixDdwV5ocpvQbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758132049; c=relaxed/simple;
	bh=DLDcGQ3mu3T/MPVKq0NF9V2I5Jn6ILZwFaw9KVQfhOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEpLowpb9c2WeJrgZZOOtpRLXKLMYE+WRJ6LCbzqb4b8CdAnchR4i0x0HOgLb5B1V+cSQQ7rGxb4GWB/vlxxUPU84whDGQ4BnZBCobTe0tP0FmJQKIXJN8MQIwRbtuodMy0/NsPqveo5UW40MjMxEdzf9QCxhLY/dDUD3z5ZiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=g1LtUuBN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-577232b26a6so101907e87.2
        for <linux-api@vger.kernel.org>; Wed, 17 Sep 2025 11:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1758132044; x=1758736844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pv4dFUExNQfPloEDat7jfEF9BkjeLOy7zrinjdnc80=;
        b=g1LtUuBN2lj4qvyQzWAdLKTewMPpvB0BMgAm3EhYmOSEcT379TNMgVSmJk7DCmgjc/
         T0eHokwlFMY3Yd+mXYCz+ekytPn0ndF69T0GJJIC1YMQr15FXnETUToESn8hAOjjN4TJ
         wc+dE3joK8Hj6X0qrUlvmHpmCBRx7/hVESh3NV1/RSPbebawN77L/JxPYbAY8rno5NPR
         h45BlMuQrVS79kOiLhszZHO32mHd/xwXNvhKNiRJJPEEOxGanxAq7D4RvCoxMPnsrP0o
         gtEy+UX8pbw1CA/Tbhp0++SKDmI4SgqYBJ/2EKyXEOwvuyrgRQgYTYLI+VQny1h7rWhV
         /NkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758132044; x=1758736844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pv4dFUExNQfPloEDat7jfEF9BkjeLOy7zrinjdnc80=;
        b=lCXOtoEiq6O64z8gEwUsS8KcOEkNQapk6sgwLHpDYqdBJir/BLRwNmU+osU+X/3sLa
         Y4+IOB7+9NFblRW1jEnYf7Q4Hl8Hh1XdGau0eSM+qfx2rYIY69wSJc9hRLtxloJe/3fu
         8/Kd6ZE6Z9wN4J3bFgEKfdNpMnIYFAblJNkZDKQ9RH8flQmkbCYiGLR0cl+FzHqLModq
         MgpKoEDl26/GsgDjF4zdByH21YtQjjQybnnuuN/XsVmgCTvk0W1RGb8/Ny9alz23NHjW
         BYDCpiQ9AoNq3GARHgFynk07YNsAnbwOW4B9bFU6mGpXvwDuKcE1r7V3mkFFFBh0Sm69
         MyyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4gntEuOAQ+8VgtBVtaMXW+ngdaaddE/dQPj3HaWDedwPx8v19M6sYembJCFHI6GEbj/By61GuofU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ8E9did0dHI/DPY1HncB6PS1YGA61XZXk3xrJvxuh+h7VkT/X
	3orxTbgoumfgHAv3P6LRW++C7XP1mUHLlDQtVD7H/6v5TURSxUhxsnvAskiuxNxp/yIseLNokxG
	oVlcf50LTlBg6kf4xk9Ttje59n5BWZOpIRmU0xHka
X-Gm-Gg: ASbGncvvwQsQ6jILUsyUBlCnwkq80WlNwPyBs4/oXJ43V5dzaYIZtLkqo+6O/+eqyjH
	C8x6MumBm0P0mM7KzYVxIpWAtFHAEXTzf9Qipo1ysbZIByuwmzMdYMOK5kovP10wsLegKRL8cq+
	WkPlAIqP/Bn3UePLPMlOTGpzZ4UUVZxS9eER8NdqGeS0Jgm+H/vbyAaZBPzEgDVgO/aW9dDH8Zl
	OZ+HQ==
X-Google-Smtp-Source: AGHT+IGI+xF2OSgRbI6+fabXiqu9Xwuf5bxWYwnja/rNGOUuSmNzhH42MNUAKuR34Ox7ov8nmiujA9clDhMS84oRbmU=
X-Received: by 2002:ac2:4e09:0:b0:576:d217:3f2f with SMTP id
 2adb3069b0e04-57796b5e819mr1028160e87.3.1758132043747; Wed, 17 Sep 2025
 11:00:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912223937.3735076-1-safinaskar@zohomail.com> <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
In-Reply-To: <0342fbda-9901-4293-afa7-ba6085eb1688@landley.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 17 Sep 2025 11:00:32 -0700
X-Gm-Features: AS18NWAGwakGZ9zjxjq7MnfN8O7ZgOJb6fmKIJ0JIML7P3j0NnlDZ27eNb5S7Es
Message-ID: <CALCETrXHxOkHoS+0zhvc4cfpZqJ0wpfQUDnXW-A-qyQkqur-DQ@mail.gmail.com>
Subject: Re: [PATCH 00/62] initrd: remove classic initrd support
To: Rob Landley <rob@landley.net>
Cc: Askar Safin <safinaskar@zohomail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:09=E2=80=AFAM Rob Landley <rob@landley.net> wrot=
e:

> While you're at it, could you fix static/builtin initramfs so PID 1 has
> a valid stdin/stdout/stderr?
>
> A static initramfs won't create /dev/console if the embedded initramfs
> image doesn't contain it, which a non-root build can't mknod, so the
> kernel plumbing won't see it dev in the directory we point it at unless
> we build with root access.

I have no current insight as to whether there's a kernel issue here,
but why are you trying to put actual device nodes in an actual
filesystem as part of a build process?  It's extremely straightforward
to emit devices nodes in cpio format, and IMO it's far *more*
straightforward to do that than to make a whole directory, try to get
all the modes right, and cpio it up.

I wrote an absolutely trivial tool for this several years ago:

https://github.com/amluto/virtme/blob/master/virtme/cpiowriter.py

it would be barely more complicated to strip the trailer off an cpio
file from some other source, add some device nodes, and stick the
trailer back on.  But it's also really, really, really easy to emit an
entire, functioning cpio-formatted initramfs from plain user code with
no filesystem manipulation at all.  This also makes that portion of
the build reproducible, which is worth quite a bit IMO.

--Andy

