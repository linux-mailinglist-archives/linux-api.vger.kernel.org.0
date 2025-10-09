Return-Path: <linux-api+bounces-5036-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6342BC8157
	for <lists+linux-api@lfdr.de>; Thu, 09 Oct 2025 10:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31381A60665
	for <lists+linux-api@lfdr.de>; Thu,  9 Oct 2025 08:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C6D2D2488;
	Thu,  9 Oct 2025 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sd1CQWr6"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF92D1907
	for <linux-api@vger.kernel.org>; Thu,  9 Oct 2025 08:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759999419; cv=none; b=uj3Sl8fTkg5F2rYBmTtNdpCB8ooIEEkDmqo94TXXB3/0xU+AuD3FHeTxpRNnmrDzHHS1FMCNHqXHDus/CmVKNE9ZR2Yp3U8+vSGlSLUbAHOnY2UVnVQq4FppyspC0s3YRGMzQJsp6squ0oCbjwcg+uwxcXBF/AjFb66fL5QVXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759999419; c=relaxed/simple;
	bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rC+WUlIt+ZugVxmY2/2WovRCT1TF9m+YldYAm0xncNR13Bf+pMZaCIQA9YS1JuFv6W7ZtzrpGkVptXO95tJ2ix/BHNPWLHTDF4v0OeNpBclwriwmuvK1IuSUlzobjeYDmc8YSpA82H7r4VO+fLD/bXh3aNCPlW0+oV4FVTTEfxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sd1CQWr6; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d6051aeafso7391957b3.2
        for <linux-api@vger.kernel.org>; Thu, 09 Oct 2025 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759999416; x=1760604216; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
        b=Sd1CQWr65JLYzY9EVKrEmyokZCi5vMbs6EjxpG+7QH6YGT3tDWbcej0s4cZgoeqQuS
         JarC6ZTWUL+kjcHPGBPAUN8Ppb1QBAPtlSxQfjpNRglhJxMMypRIPnB6rYYKLQvZjKiN
         y72xO5wzZc7AAEZk+IBKqraBb7+6wC4+Imv7nbjEtku9PO6PAKcYEb1vRHgafdvgR9U2
         dCS1DB4VwniCeBOnc8XLvNltoejI4ecSgvo1PpGG1tSl6PrUxnfallIONRoeLTNOEzbX
         FvDKAaN4VsNHkaBPKCCqR4S+rBMFmJJlJYY4H+OBfaZXGyq7o1ppfnH/vgJ3jgRm0T4d
         tz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759999416; x=1760604216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOmLRNO4yxmZr9GGl+AUsKcQlyU35gqHSeHKaWhtPwQ=;
        b=c0c8B2K1XT+s3vkuZ00gR1GAgLbAr/B6o6ABNScwUZfhIQSDeLmDA1XIIxMLTnXx6b
         nJ9dvDlzHq6kLTr+ZdmTk56s5cI4f/0qc8iM/jp9IpXXZRovDnhEHVokACh7aYNxijAW
         kR7x6HZ9ijheRzOon2AiVyw1JXBgNhYT9Ct6kjITGZzPeU/LLfbQ4FObJrZK9byNQcBy
         aUDHxPoAU4XD/NITCQdRG6TJoCzjVH5z2/KGnA7swqZzqHAMIDZRzx4eEQONtLtzDmkY
         0ZKSirthEO0CUJK6FRdpzjYhHz5DPe2WsTVK8HJ6UNEjm3McqhMR7ay8GxobEfH+rIk+
         U0XA==
X-Forwarded-Encrypted: i=1; AJvYcCXdS4pgrAfIPe+xCdxsBvi7JnFQEDTyi4QBj2WO/SYaQY1Erf1Fd2Mn9zaRLFdHPIBX1iIpV4XORqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRBFP9isvEkesF2gCUC0Xd8G0MQ9iwBclJ+xcqwEHaXyEZt6m
	i1iSKpZQsBNMjKYKnelk2+XQUdKV16wG9uz4raswxOx9bd5P3ecD08R4g7kXiiXWbTHYQeHzswK
	+jhP7+9T27Qj1V/MUkfQ+i2butFGbALI=
X-Gm-Gg: ASbGncvsZ3HV+4BdRfw+jwmPjgQo75ehoF7Bm5K70LpBCqivlofO4oUz3apENY0VCRs
	23BMzyC2NHW+Frro5vHWG84P2OP1XqGWSqRHO0Dxq4vNV2mOhgzye46z4yF8vDU1i9HE3mfXumu
	ZKsUU9K0uK0HpNZiNhbVuLQyqIGJjJdADyYEolR2nbjEfkFvpd2EtgJkWEg4l5/bVi9oDLaTTWz
	6lWWbmq8x5rKdLUUxYM3y3jgl8wbMiVDZvBSvz74Q==
X-Google-Smtp-Source: AGHT+IHqqt7JHMFlL5DEMxX8/4fuWke6o7x715NV65SuEycRYAp5q8y3uA9SPr+Cccah/gPAgRpT2LfWBS7AmxUm0/4=
X-Received: by 2002:a05:690e:146:b0:635:4ece:20a9 with SMTP id
 956f58d0204a3-63ccb91d5e0mr4410660d50.46.1759999415603; Thu, 09 Oct 2025
 01:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918152830.438554-1-nschichan@freebox.fr> <20250918195806.6337-1-safinaskar@gmail.com>
 <CAHNNwZAzecVcJXZmycX063-=p-M5jVkfStfgYVKJruOFo7y9zg@mail.gmail.com>
 <CAPnZJGDwETQVVURezSRxZB8ZAwBETQ5fwbXyeMpfDLuLW4rVdg@mail.gmail.com> <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
In-Reply-To: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Thu, 9 Oct 2025 11:42:59 +0300
X-Gm-Features: AS18NWA7xuLtf9pobQHoPGHI9uL9SjsnEaZg-EuuD52zBO81KbUszIYBPPZ5wRY
Message-ID: <CAPnZJGAp-wG+9wDmmisfpxvFbRtXkG-RipAuZe=fi1BWy-3G-Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Nicolas Schichan <nschichan@freebox.fr>
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 5:29=E2=80=AFPM Nicolas Schichan <nschichan@freebox=
.fr> wrote:
> > Then in September 2026 I will fully remove initrd.
>
> Is there a way to find some kind of middle ground here ?

I still plan to fully remove initrd in September 2026.
Maintainers will decide whether they will merge my patchset.
You may try to convince them.

> I can send a patch for that but first I need to sort out my SMTP
> issues from the other day.

If you still have mail issues, consider applying for @linux.dev email,
they are free for Linux devs ( https://linux.dev/ ).

Also, I just tried to test whether your use case is still supported in
mainline (i. e. uncompressed initrd with root=3D/dev/ram0).
It turned out that on modern kernels you need to enable
recently introduced CONFIG_BLK_DEV_WRITE_MOUNTED to
make this work.
So, make sure to enable this when upgrading kernel.

--=20
Askar Safin

