Return-Path: <linux-api+bounces-2109-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE47947BE0
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 15:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110BA1C21B97
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 13:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB352A1B8;
	Mon,  5 Aug 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgZ+0pQI"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0931F60A;
	Mon,  5 Aug 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864835; cv=none; b=YJ7vwvEAMrohDIHcsimkDupjgHE+4nkmdDl4BLkjc10r2N6W6vbjBHmwkII5P4bnI/f8fYnjgQF/I8yclksKylZUxnDjJG4RGT5012ERScjtx0ZwQm1vNsq2HL18Tp14HZsyLCxSX8R013WCXQftJmRfC8HYLO7G3kxkL8BoOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864835; c=relaxed/simple;
	bh=6UzLdIcsIQBjvvsljkRYWNG+zy1gpAPaUZQUZLQBsGc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJzqKWajT03ETvEv9LLm+IYGytn+ke57RViPmfeS8Lng8vTm6u7pWZP4epRW8JGTXF3MegNJRVzzyiOTbTg4qUuyrI8iuxzTKV5g9ZoiJzoaBZ9rwreKmT2nMk5nXVonATUASBRoFrbZmvxwoLp1Q7hact2olkONWdbTRiehbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lgZ+0pQI; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5c2ac3410so6023206eaf.2;
        Mon, 05 Aug 2024 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722864833; x=1723469633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bpYeWBTb5rgkeqmPvmBnfbIMAAfYEMneQoA10rCaXA=;
        b=lgZ+0pQIcD/2fiRBY/SKG4i2+upkzrGiuBOqL2jvILefvbtdSKhPmvf5sClabnttop
         55+KJDVQUGT4cHSySPtBrCtV8IXUN1LxdZWPn523P+SSFXP3Z1Y/YvYJ0fAMRMrjj8hI
         /jjhRIYAzGCzsnULG1fZh4Vhm1mjjBYqJ4OE4HtjBpz4L/ZLSGSchRb8cBuaNKr35pYq
         okba9/oxrPMKbhcY/VlQteN+MQg8XaBQOTqlNfWpAoHr34JCrKTERivwvj1Of27kQAW/
         zVHuF5bv8kz/LlbHWLS6Nj5ScbEIsVPbIIogsiMQTTQV/gvg/sce4tYAsjLXdi2cD6Lq
         iFZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722864833; x=1723469633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bpYeWBTb5rgkeqmPvmBnfbIMAAfYEMneQoA10rCaXA=;
        b=KjI4ftDENUuaT5QKtPPR1SY8YmsBmCeJPx68ZH2ENwxftr2pP3t9WSo2HqcuRVcnVV
         yUBUp2TA2zlGZk9g7pmIBeMHFqd/TYoknj61nH5XcEZ6wCe5zeZL457LD/7hznFvjr/5
         vIWsOyRMF2onE/WgjGwp5HucDkZdCAoczVe6vnts862j6EZ3b+XEt2gaWTgThxqKcU8J
         XgFSatq5dDknLZcHYm6yPTlrSfcTcPIxmIuHdQWos4lSaKXj4bgoPh+3MOFl4Eslc/4C
         Bfx4Bro5XXqhuJ5qgMm2joB1zL//cMQEo5nQLiNhlwJflQj8Jyd73outt/WX6EGmvK1s
         ffkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWe+FfylyHhLoIsjCMzBkNnPP0onWaCyedAYqZAaJJbK7DUS+XicAzhm3hNnHzCX2R2NG4WBH2MBetRXAMFxRarkBHSuzyG7HZKcjeda/oym8Junvk7e9KsnRMX7a6UqY/koQtjnNdo
X-Gm-Message-State: AOJu0YwXKtKCPLRbtMmuZzu/4IIK06E8dJkR0fHj90+e8q+nEhJKm3FK
	LpDLaNM0Z4dXrpFQi/9FLQZl0QC5BZC3dVtKf2N3+KoeKI0/5x2OVHUTTXetwqyThbYDlgCCS8f
	oxK1ejRQCFY490p9ncZhfNm91VZU=
X-Google-Smtp-Source: AGHT+IHkU0BXuahEoyQX22QUsa04qtYpJiIPRQVXPHgYx4oh0LF1TIyS+xQ4LfVhA8LQQBA+IPKEb5wm1P/5s9AEo3A=
X-Received: by 2002:a05:6358:5f1d:b0:1ac:f144:2b16 with SMTP id
 e5c5f4694b2df-1af3bababb6mr1497963255d.26.1722864833103; Mon, 05 Aug 2024
 06:33:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
In-Reply-To: <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Mon, 5 Aug 2024 14:33:41 +0100
Message-ID: <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 9:33=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, 4 Aug 2024 at 01:59, kernel test robot <oliver.sang@intel.com> wr=
ote:
> >
> > kernel test robot noticed a -4.4% regression of stress-ng.pagemove.page=
_remaps_per_sec on
> > commit 8be7258aad44 ("mseal: add mseal syscall")
>
> Ok, it's basically just the vma walk in can_modify_mm():
>
> >       1.06            +0.1        1.18        perf-profile.self.cycles-=
pp.mas_next_slot
> >       1.50            +0.5        1.97        perf-profile.self.cycles-=
pp.mas_find
> >       0.00            +1.4        1.35        perf-profile.self.cycles-=
pp.can_modify_mm
> >       3.13            +2.0        5.13        perf-profile.self.cycles-=
pp.mas_walk
>
> and looks like it's two different pathways. We have __do_sys_mremap ->
> mremap_to -> do_munmap -> do_vmi_munmap -> can_modify_mm for the
> destination mapping, but we also have mremap_to() calling
> can_modify_mm() directly for the source mapping.
>
> And then do_vmi_munmap() will do it's *own* vma_find() after having
> done arch_unmap().
>
> And do_munmap() will obviously do its own vma lookup as part of
> calling vma_to_resize().
>
> So it looks like a large portion of this regression is because the
> mseal addition just ends up walking the vma list way too much.

Can we rollback the upfront checks "funny business" and just call
can_modify_vma directly in relevant places? I still don't believe in
the partial mprotect/munmap "security risks" that were stated in the
mseal thread (and these operations can already fail for many other
reasons than mseal) :)

I don't mind taking a look myself, just want to make sure I'm not
stepping on anyone's toes here.

--=20
Pedro

