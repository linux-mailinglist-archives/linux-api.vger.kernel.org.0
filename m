Return-Path: <linux-api+bounces-4850-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F399B58AAA
	for <lists+linux-api@lfdr.de>; Tue, 16 Sep 2025 03:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2902D4E27B5
	for <lists+linux-api@lfdr.de>; Tue, 16 Sep 2025 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8012F202987;
	Tue, 16 Sep 2025 01:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0I/Xm2a"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006E1E1C02
	for <linux-api@vger.kernel.org>; Tue, 16 Sep 2025 01:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757984728; cv=none; b=pp7iXO355VcUTZqimST6cUCXT1bLVBPeBkqzIwcTz4ITcVhpNOmVrAk62r960yP6ShtTHRJHNg2zmvuedz+F3i5Rb66q91jW0sbBAfQGh6j5pc2aBp+bbLOG8MdDjp8NohJQtG2yMJ2vW7y6v+1ypRc+Sb13T7lbRcHPVlqrhjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757984728; c=relaxed/simple;
	bh=d4rwn8y0vRJNvu8C079VdIgUQlj+kBjL5HuZ7smgp/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfitUdFPu+H2skQ7qybvigddpcJ+sJAQX/QpQMo0lSKn1NvczV33UspmFQafLwdpA65tU3UK05uwnfzx8PsTyZi3GuEo/sFviZZOmWPrgVcWe7/8iqvEHSyVzcUYOldd9ATfva4Rmq4+GWtSF6XC8eg0c1Tv0Wwh9QdUXB1x7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0I/Xm2a; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e94d678e116so5035718276.2
        for <linux-api@vger.kernel.org>; Mon, 15 Sep 2025 18:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757984724; x=1758589524; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4rwn8y0vRJNvu8C079VdIgUQlj+kBjL5HuZ7smgp/E=;
        b=T0I/Xm2a26Pz9ueMVGxxM+8PBoBl72rLmCzNxbz1k+Zf7VAgqOZWtMXsxpbWUBL8J8
         jPG2qCslo6GuL8OE/CdATF314calnEw7vxx91ORh8INwPj72HtzWCItEMHgqlS1BGB4L
         AnggdLmhtN6PrPfYWJw6oIkc2HOZ6SuTst0SQp47zn7zXDjLJdQBMyL/dFLz8br5otKI
         8dlCMxoRBNvoekrOuCctZSU/9APTEadss2NF0KJzW0tKMoYDIAsZq+yHkaxGVYfE6o2t
         SJT7LsbW215Aa9TuYPrX1VwOTxvlChId8n3HZzda/uwuRnZUTB37Ib6PO7vzKl/LFvlj
         okaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757984724; x=1758589524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4rwn8y0vRJNvu8C079VdIgUQlj+kBjL5HuZ7smgp/E=;
        b=lHNsrBorrDKbXmTjSg55nNK5u72Ta25iLEOpJN9ZC9/k0JoAtR7ncCeuUfzep1GP1S
         25K0fXjVMv/mByO3Vqa6zoVXkyEwQAmYvUWiP+W2qUYj2SFz40EaH1D3QhyxX57pSe/U
         zNtde04oPpaoUMh4pEUcVy29DmiXdNpgFSDcm7FPILx15exjEpX7YlFg5/e2D0egxkwF
         a9VwvaaFFcMDGc4+E1mTzIXKHV4jY8ymyV1U6cnHxFZVHQxGKZWQKLRiicj9W27XgVwe
         lC2r3Rrn7aq+9XsBNTgihYoXQwsAInDxRmLGnCjV4CLe6WImYUrLCObiTdJtxxDaKBGA
         UFpg==
X-Forwarded-Encrypted: i=1; AJvYcCVoUzquI0afsHeb+N2CP753nLDiBD7NNvHU0tvUPWOuuQxVV+Qr6dJuZUtrDdXn5TjccOfVEMq3aVI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hRqfxBFNfiWpMe1V91q37DFCTrljpqJqymy/JdIHT8jYbqs8
	qIGdQW8996Dm4BOBromHQAsBKMkAX27HCHpGSHU/k51Uj2QU1prOBKAiRrAIej/KUxbKhChQJXf
	muwfQ7vSCQAcRGKaTdOKpxsP4rByZv3M=
X-Gm-Gg: ASbGncv1/ux6uZbPErE+l9v75cjlcCVZU9ZZoHIn15Rf2t6Fk122drCOxkebQiLX7Fx
	7nUlssN9xuDqIMlzU5mxKRp4Wd1cUk4/spEXQywjLCrqzw7bPjOMFcpYS7Evdn/0uXuzdkq7TXJ
	M2gm1Hw+x44LIKR7Idu2CeOyxU3Rl+AdAp7PkAzmCpYMeGifSWQUb+f7/c5mQdPpHzDj7rEFsAh
	5m2cYDvk6/Gea+C1g==
X-Google-Smtp-Source: AGHT+IFaJEo1gVHkPCEaCD3vWYjtreYFiQ2WOrRU9CIpbMyg97OVJtr/v3uxdpG+fiXE68E0IfjXLuECnr1bsw09sPQ=
X-Received: by 2002:a05:6902:2b02:b0:e98:9926:e5ca with SMTP id
 3f1490d57ef6-ea3d9a6c911mr10729577276.36.1757984723469; Mon, 15 Sep 2025
 18:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250915-modebranche-marken-fc832a25e05d@brauner>
In-Reply-To: <20250915-modebranche-marken-fc832a25e05d@brauner>
From: Askar Safin <safinaskar@gmail.com>
Date: Tue, 16 Sep 2025 04:04:47 +0300
X-Gm-Features: Ac12FXwuxsP2xoupllcCoDiRw8q2uuerrvP566PgC2Qr6qfMP36Zqdrto9P8zEU
Message-ID: <CAPnZJGAjfpHZn_VzU3ry9ZV6OUS0RN2iWos153_oM_PhVbMgVg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
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

On Mon, Sep 15, 2025 at 4:34=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Split it up into multiple patch series. Send a first series that
> focusses only on removing the generic infrastructure keeping it as
> contained as possible. Only do non-generic cleanups that are absolutely
> essential for the removal. Then the cleanups can go in separate series
> later.

Ok, I will do this.
I will send a minimal patchset with arch/ changes kept to absolute minimum
or even absent. Nearly all of the changes will be in init/ and docs.
Hopefully it will pass via the VFS tree.

If it gets to kernel release, I will consider sending more patchsets.


--=20
Askar Safin

