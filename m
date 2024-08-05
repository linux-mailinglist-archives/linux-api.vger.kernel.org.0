Return-Path: <linux-api+bounces-2123-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FB49485E1
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 01:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 549561C21EFB
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275D716CD12;
	Mon,  5 Aug 2024 23:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmGzrrh3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB0F1547FB;
	Mon,  5 Aug 2024 23:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722900314; cv=none; b=JCCxoerzUlcgkuRiYR2d2KlX6VZQ0chfnertjXoBZshzB1/ZoFcApOmu6vyqVu1Jeo9Mb8oB4dWAQiD4BJM/OnKfdoTI67iC4wbnvRTB7RpamcmkXTmuk3vd/9fE7AvYNu6/3ehFafFmmjsf0duqGjh1I1g1lkpcBYE7HLN4R0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722900314; c=relaxed/simple;
	bh=2zBIarod2HVl/CUnRXWVgnn0mxMrpjXcU7UzEEJJgco=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Hf1qP6FKpaI3hcygs++0cIT0u81kt9/e/v5AvSBppjYY5Zl92WrxU511AivMSotJhqiBME3tsknxuKws+KXqSTf9TNJ1L11fGQ7w5aLalcn2bI+ibkp/bFUEeVweJ7wREDThsZkOcyBREAxIcZWF6xVVB7mY+aAxeczR5BfFZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmGzrrh3; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2cfec641429so123377a91.0;
        Mon, 05 Aug 2024 16:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722900312; x=1723505112; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zBIarod2HVl/CUnRXWVgnn0mxMrpjXcU7UzEEJJgco=;
        b=fmGzrrh3Ann027+ynGnbwJNhbtXgoDHYQg7wXeSsaimRg2+q+Pc/+qybBuPbR9/wpY
         1S9TqDrdMyhB7T2ua9cHmKAY97q7+Xrs0NkGScWVj7YF9M5xg66Erj1REshVeDQN9HnP
         RFnNWiQ8gE+MzWOIaNGyv1esxuPlCd9sU8FVU97XbUEClc8gKOeZEYGrs9sOZFiLBlyY
         qdTpoeBCXx7c99fbwZW5UblrBGWZTd8hDMbdQel2uyobPvRK603zAwilarwc5cDj03Em
         iKDm3Xm0j0NrRGeDYjMbJC6eMJBigTCeIzZHQw2pDt9ja9JV4aDaYoatxGuj7qo9hf2A
         Fc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722900312; x=1723505112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2zBIarod2HVl/CUnRXWVgnn0mxMrpjXcU7UzEEJJgco=;
        b=rN/YzPSuOTzs8HU+S6HZSsspdTpr1atlGTsjcoU2wa/ITdyBixBZkXOmHRx84nf4z+
         Ov15O/bV4EjS7h+57HTLH2MN4ZFt/5nloIejfLU6iLKDvpa0w4mN7bHWHsWzChF8RV0h
         2CQztaFeaAaM/CPjkyzXJGVkJx2+yZDEL+PSMJiqYHLpfljivYBFUskQKEtfNT0NNW7d
         14Y9e0izzgogmd/FWy3tLIrvSTRi6Y8ZrpJadpDsEyPjRA8+b1mur7Gl6M6jO4w8G8FR
         d5Vnwfqdn4X98nuG8cuJ6TIaJvpFD+whEFcuhix4lltWsW5fLCLbfgbZ/l6jJ2UPpf1C
         v5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuQr54MH6x3lplSkf4q3gkw3nhWnnGYaCpM8fttZVvtdhZv2FExqO6YipeMYVUOHnmF0Wa5/tcvp9LsUvffsXno4d4+fPWLLivrsYob6RhATch5C6oQuSHluwtbkaPmWZnhfcyKXnF
X-Gm-Message-State: AOJu0YwcorpJniLcUGWX54TYvCLQ7IB2Q5YABUEkfCrcV0NveV1g/eeJ
	pdfXO4PD69TgWQwdOzTX5slt8FNfWuD6s2w2+y+bEYvjPP88XZ5d
X-Google-Smtp-Source: AGHT+IEKIal6yU7k7Lhrnqubd6yU4EmHWWHnqQEQk4+X/HJkwuuyTpiT6qDT5UZniCRaYxknZQYlKA==
X-Received: by 2002:a17:90b:1c03:b0:2c9:9fdf:f72e with SMTP id 98e67ed59e1d1-2cff9547ea1mr12052804a91.26.1722900311942;
        Mon, 05 Aug 2024 16:25:11 -0700 (PDT)
Received: from localhost ([1.145.206.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdeef43bcsm10813103a91.39.2024.08.05.16.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 16:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Aug 2024 09:24:56 +1000
Message-Id: <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com>
Cc: "Michael Ellerman" <mpe@ellerman.id.au>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Pedro Falcato" <pedro.falcato@gmail.com>,
 "kernel test robot" <oliver.sang@intel.com>, "Jeff Xu"
 <jeffxu@chromium.org>, <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
 <linux-kernel@vger.kernel.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Kees Cook" <keescook@chromium.org>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Dave Hansen" <dave.hansen@intel.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Guenter Roeck"
 <groeck@chromium.org>, "Jann Horn" <jannh@google.com>, "Jonathan Corbet"
 <corbet@lwn.net>, "Jorge Lucangeli Obes" <jorgelo@chromium.org>, "Matthew
 Wilcox" <willy@infradead.org>, "Muhammad Usama Anjum"
 <usama.anjum@collabora.com>, =?utf-8?q?Stephen_R=C3=B6ttger?=
 <sroettger@google.com>, "Suren Baghdasaryan" <surenb@google.com>, "Amer Al
 Shanawany" <amer.shanawany@gmail.com>, "Javier Carrasco"
 <javier.carrasco.cruz@gmail.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-api@vger.kernel.org>, <linux-mm@kvack.org>, <ying.huang@intel.com>,
 <feng.tang@intel.com>, <fengwei.yin@intel.com>
Subject: Re: [linus:master] [mseal] 8be7258aad:
 stress-ng.pagemove.page_remaps_per_sec -4.4% regression
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>, "Jeff Xu"
 <jeffxu@google.com>
X-Mailer: aerc 0.18.2
References: <202408041602.caa0372-oliver.sang@intel.com>
 <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>

On Tue Aug 6, 2024 at 5:48 AM AEST, Linus Torvalds wrote:
> On Mon, 5 Aug 2024 at 12:38, Jeff Xu <jeffxu@google.com> wrote:
> >
> > I'm curious, why does ppc need to unmap vdso ? ( other archs don't
> > have unmap logic.)
>
> I have no idea. There are comments about 'perf' getting confused about
> mmap counts when 'context.vdso' isn't set up.
>
> But x86 has the same context.vdso logic, and does *not* set the
> pointer before installing the vma, for example. Also does not zero it
> out on munmap(), although it does have the mremap logic.
>
> For all I know it may all be entirely unnecessary, and could be
> removed entirely.

I don't know much about vdso code, it predated my involvedment in ppc.
Commit 83d3f0e90c6c8 says CRIU (checkpoint restore in userspace) is
moving it around. Why CRIU wants to do that, I don't know.

Can userspace on other archs not unmap their vdsos?

Thanks,
Nick

