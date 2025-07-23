Return-Path: <linux-api+bounces-4194-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849F2B0F4EA
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 16:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D2B67A6B20
	for <lists+linux-api@lfdr.de>; Wed, 23 Jul 2025 14:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2142F432E;
	Wed, 23 Jul 2025 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="tXelu70y"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172F32F2C5E
	for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279722; cv=none; b=TZBU386BUKI8Eqza4jxy7o0gCLj5cf/OPTW5ph+q9Cq0tc6MT1k/VdO0j+OQD0PiAtZzQuXmAzgwF2kIiLeU26go6yu8bBCZmVcHnpph1Lvacfb8qNnGSqLKtBH8W0Wu09pIMOZ/qEbM+DSDBnJFrJ+qAicTh9SxbL0uT9oPfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279722; c=relaxed/simple;
	bh=EYCQ+Y4SGloI9batOxe6eah89jgSfjrOwxOFu5iP0Ok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m789fcvsB5wt2iI3iuPzFi06z/fj2smrlJgLU0BU1+a+PzNqdU8rYdH18dJ8LsnJy3/BxKTl6lQdXWZ1L5qXRSnkarWzGrOUSuII3NwqaeGuE5y2ulEK/5yLJG+IwddOFp3lP+biEf41D0TgLoLbDX4eSbylbIX4PbDEl4Vt9J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=tXelu70y; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab8403b6daso68590521cf.2
        for <linux-api@vger.kernel.org>; Wed, 23 Jul 2025 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1753279720; x=1753884520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EYCQ+Y4SGloI9batOxe6eah89jgSfjrOwxOFu5iP0Ok=;
        b=tXelu70yiW8vPdSXtL0JJ+i1ZNy3aPSqCYiOhiNagT42dpVrKJxDU2ZahCr2FMzmzR
         vmPko7FUGeBFLqFFC+wxHP553EdHMJ6jUIFtgLBDFWGo5MKZ694C/FCwNyORqxrPMQ6Q
         qyGXYfVmcQtHPc3H6bXw0KOIQncmgajKxvBl/5/G6Mzs4DaP7LFCZ7kCvevEVry4b5EG
         KsqjcIsRd4HODUcWN2YpihyOI4X/yIxkOV3CRNhdIj7yvEpfI+2l8z8C6zf89/akdLq/
         wxzcH7T+6JaB0vnnGMkK4yBx7iIfd/1XwEjsRJHxcYKJnwQ7cEPkGQ8LM49Ng+HkKJzT
         hXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279720; x=1753884520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EYCQ+Y4SGloI9batOxe6eah89jgSfjrOwxOFu5iP0Ok=;
        b=usVtKRy8aQ4nnqB0RSonhF0fPYVFryS6qr+wZUoPWIEupHxSqGpBJTrzNtul/RAgAr
         /PnD/QETQjz2xG3+v21gJRb3YUBpzR1xwxghcwVwmxUADKvNIZw0qnPIwz7DNzM0odbG
         TgHsZwqjH/rzHTHWmkqBpHrgDrsVx20dYsetEGhYYiKJwuCZmcmLBvMYJBZSX/1PW1b1
         KqVNMEN+EDr/lU865oD7c0CJ+SblIhTspGlsRqPz+WZulsBYKdOtCTewIQU3Pl3JltZJ
         6h70jeaRoS+LDyH19TvJZrCcNTnN6EmRKijvgxzRf1wrCE+qgqXb/8kPbpotFb0IEtun
         xXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhXzLC3wNFpexmI0BSmhuqk66odaI3ST8mS/Ik8i+qwJaKYSYmKpLcjhnXWzwfu9LWNvjA6bNqil4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6misS6SNG5W0+EVA9DuqE+mkdXDznZYZV2kK8g+5HaJ68Qz8q
	jWk7QH+rYVPYe5AdbJ11butvVrw2AfZ0KL/jdJ/wgVkcgWUckykbgKmKUNHXIwedm2FMYu8Nuvz
	eTt4ZWMSi/6UNsK1LAtkl7Id283BOboiKJRWQ/5UW0g==
X-Gm-Gg: ASbGncu4vP2CHwnymJzM7tt7JOszy0QOuiGsyoGtJFmH7fVN6vKWDKvFyuxbdXDuA7X
	IDLtHsni2CBGc3ls31gX7mbi8cY7qsnC/FTmosjYjorkgNALjW6Snrot4G7/67SaebMjF1FTSBo
	hZcqOyyK80CO1GXhDZdebdpkM0LXxALzmQpTEGHvJYvHiuPEFJxOn8+PKRvQDyW+ErbzfP1aOKS
	HT5
X-Google-Smtp-Source: AGHT+IEZg9+tOdoBN5pipaSz8l0JIXA4kWu5teWmH4MdPQcTJ4hEm9+p/VjHT1EFMtU++w0i7sf5NEh4l/b4T/vp+IU=
X-Received: by 2002:a05:622a:299b:b0:4aa:d487:594b with SMTP id
 d75a77b69052e-4ae6df3479fmr44745741cf.35.1753279719903; Wed, 23 Jul 2025
 07:08:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
 <20250625231838.1897085-26-pasha.tatashin@soleen.com> <mafs01pr6u06u.fsf@kernel.org>
In-Reply-To: <mafs01pr6u06u.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Jul 2025 14:08:02 +0000
X-Gm-Features: Ac12FXwWi_rhmMIkdkRxwkl_fKGePVCICDRFX_LJg-BXvjlQMX0IOJ0Ennnr9xw
Message-ID: <CA+CK2bCHFW35oudOUTykzV4zH6Hv4ChmUq=-BZAtDP_mtOwBjA@mail.gmail.com>
Subject: Re: [PATCH v1 25/32] mm: shmem: use SHMEM_F_* flags instead of VM_* flags
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 1:01=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org=
> wrote:
>
> Hi all,
>
> On Wed, Jun 25 2025, Pasha Tatashin wrote:
>
> > From: Pratyush Yadav <ptyadav@amazon.de>
> >
> > shmem_inode_info::flags can have the VM flags VM_NORESERVE and
> > VM_LOCKED. These are used to suppress pre-accounting or to lock the
> > pages in the inode respectively. Using the VM flags directly makes it
> > difficult to add shmem-specific flags that are unrelated to VM behavior
> > since one would need to find a VM flag not used by shmem and re-purpose
> > it.
> >
> > Introduce SHMEM_F_NORESERVE and SHMEM_F_LOCKED which represent the same
> > information, but their bits are independent of the VM flags. Callers ca=
n
> > still pass VM_NORESERVE to shmem_get_inode(), but it gets transformed t=
o
> > the shmem-specific flag internally.
> >
> > No functional changes intended.
>
> I was reading through this patch again and just realized that I missed a
> spot. __shmem_file_setup() passes VM flags to shmem_{un,}acct_size(),
> even though it now expects SHMEM_F flag. Below fixup patch should fix
> that.

Added for v2.

Pasha

