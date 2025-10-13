Return-Path: <linux-api+bounces-5099-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A10BD195B
	for <lists+linux-api@lfdr.de>; Mon, 13 Oct 2025 08:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 992744EB42C
	for <lists+linux-api@lfdr.de>; Mon, 13 Oct 2025 06:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE92E040E;
	Mon, 13 Oct 2025 06:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E08XGpzm"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83002DCC1B
	for <linux-api@vger.kernel.org>; Mon, 13 Oct 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335595; cv=none; b=j9mA+s6davAGNk8/QKM+D3SgGimUTFoMVevTGI9l2uuy12n3GAT/lfPyYhPdbZIs67wKZgGKqkhz6vuxwN7li9TdlqwRlWWRrRmcvDilBg7ohgdYZN+ii+u9eBkvVUab90tHFfsFHymfNSOo50+vs0M5uKRV5n8+ZmmsrV+c1mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335595; c=relaxed/simple;
	bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r9hrwhPvDVmJs6Chj1wllKILnFbkoCcufuRI3Oda35QPamNYGD231JWQTGzN3onAx0fb6FiJqPQG0zN2gpvtiTucC2AdM3COoo7ERcOuD9dKCOsY3AL7MzfSwJcVSzytOJmXf7f3TF9oxWQt/omnvv3Jv3Yfpr3XsxgsSsBUnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E08XGpzm; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d60504bf8so35754747b3.2
        for <linux-api@vger.kernel.org>; Sun, 12 Oct 2025 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760335592; x=1760940392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
        b=E08XGpzmHVw0+qDzU5sCl5j2nWjFq/4gmZrI+HSMqUtrUQdW75O40jzorsqViIJ5Op
         YueCYgQvB7QPc4pUrMdPo6WnC+J7hR1UlRYyfnedh94HC57pUVWE3OllsoN75neJ05zd
         7IcSugJKTLhjY0wSwmbSfQ1BF+GIHKMdxFsZBTI139vylrWwsfot4THqwBnc5WWO1ADS
         owqxNkoEXxySlcupDmKJPMhXmeet3aWT00Ul8qKcfRlZ1+XFeBRnw6Pd6ASpf6fNaQKa
         kriZgtpxAU1TcDZRtFRbT0eY4rS6fV6XOKhazNP5uPTqs37bNueBArVUKMrsryxA49Ua
         /esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335592; x=1760940392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
        b=FjWtdgHG07e1enWmQ3Rk2809DBQ/aI7t3qUSX+3CYRzrslJ4gKthKdyPj6YZsm513x
         BlzqAjsAdIv6rzhXpgucCA/1bEg4saqNvymVIGbIycbQrIRYXuYpi8dQiooyvRSmuVWd
         p+kVGDlh79obOiDpU/OT8YKcwHrbRwKpYT9XsscM4EkN3Twyw/omDvHzdAAzuyAR9bjA
         BXl1xmu2Kds3SMOZnIhlBdLWoHuU6R5ijAqv+MVbApbE0uumuQeS4C2NrbHAq4y/f67l
         sdFqMCeAoU9awecqJX2HFQl6bI8/UcK6dIuVi2XwViWrjtaxPfKgqEiWkADZTcFbJ5ds
         kHMw==
X-Forwarded-Encrypted: i=1; AJvYcCWp/p2XNQxafhMdOryCcwVMNGzrdW44NTV8KS4+kPkxMr0n5GNnXDNvzJOeR/abXy2rixudiPALVSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7vNXuoqfAKdZoKydmg3ne7U3K7nv7bVqTb2eqkuh5RYfYy3ks
	FG4VLqY7El3QQ9BnMroXU4m0AZIYmcWH6RkyDxlG4GyzpIw8/jkm0WdZ0epMO41ZeZN8c/Jrl0O
	KVaDzciKU5SmK5Bk5Un/8735pLvO+v+c=
X-Gm-Gg: ASbGncuKV2KGtrB4dzZlLyzB5RhfDLA89ioyA/Phva/LLwRn7DIQpZw/b5DVHPTY/Dj
	VJsmsr6Pz3f7oS278quBnn/0OBLkGdtyZ2UOxtFGlalykP1s1uSFtYY55qS/+5dWnCl8tTrHGSf
	MAsil8opZlgPy10jJ0tB6ScKfrNyQBM/sQaEWuHq2mGzvKh/V+J3nXYCsUQrPwMBCt3vcDaDC4I
	DH/pHqWG9bZRLsL6Z99olfMSvhd21cl71xj
X-Google-Smtp-Source: AGHT+IGNAOIcFLi0/Sm93Y3jSHSuxr+30gS3y7Fr34MKhVqQQnt1MJ/lLmHR6+qpb+bVmq5VVWr9ycljJFZ2Qxe2L4U=
X-Received: by 2002:a05:690e:4142:b0:63c:f4eb:1b0d with SMTP id
 956f58d0204a3-63cf4eb1b25mr7582533d50.22.1760335592286; Sun, 12 Oct 2025
 23:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-2-safinaskar@gmail.com> <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
In-Reply-To: <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 09:05:56 +0300
X-Gm-Features: AS18NWAQKixJeSnu1jMDTs2ReasUmQ44oKevMSLcLyEUnjeI8Werl5Jwf9tycOM
Message-ID: <CAPnZJGDvHbDt_JvDNLN+LaU+5yFyB_qkdBtVhSEV60_yktAVzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Fri, Oct 10, 2025 at 6:02=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> 1) often the last period is missing in the commit messages;
I will fix in v3.

> 2) in this change it's unclear for how long (years) the feature was
> deprecated, i.e. the other patch states that 2020 for something else.
> I wonder if this one has the similar order of oldness.

These two commits were done in 2020, too. I will fix in v3.

--
Askar Safin

