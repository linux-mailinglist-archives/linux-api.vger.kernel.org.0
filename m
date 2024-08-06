Return-Path: <linux-api+bounces-2125-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0870F9486F7
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 03:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70741F22253
	for <lists+linux-api@lfdr.de>; Tue,  6 Aug 2024 01:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9980664A;
	Tue,  6 Aug 2024 01:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2K1vJSa"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79424C69
	for <linux-api@vger.kernel.org>; Tue,  6 Aug 2024 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722907414; cv=none; b=MnkGAVu+A6ASGy75heOkB0C+MJrGifZEpL/yB/GDdzAtfeJQZo1bFCNxgp8iiKeBGzlMUGTNx8pjB7d2+DUyIZPwSwsoN5ehGpLNhbG6ZAaIw6YYqlAi5qmJCDOXTYuDaLxUCUInNdpu25UAM+MUV6gDjqsk4GNYBaWs5ZEynBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722907414; c=relaxed/simple;
	bh=vA4qaSs5vwrQoFaoWs6qaP6dAmPJ7PdCG5HHaDna8EA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cF/xYDFH+d8QbOC9j5+2doIMP3O3EMiGw9UbBE0Ralexi2qDNxEKr/21qpBYThTrnMfWrw5hDkfxklq7Ojlk016YalckEi0Npc9FRLEQjsyll1bWxK8WBd9j48AXDgHOo5La8WbDrybtq4hNUPjzk2zFts6MjWiwTE/5NtV7O8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f2K1vJSa; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52efc82c872so1078e87.1
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 18:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722907411; x=1723512211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2zr5Jw8aSSrppFuky4osrxPL34Y2hdQ6m0LCpom6O0=;
        b=f2K1vJSaR4TFJzpntUMJ8+7DmjtOLHYCBBpF5iXazjlCBjJkS3V90QGi10RVuzuhAt
         WuPvFsTTUgz399kxIYMcrtC0MnP2EUv4oTOVlagyfcotQvvBYGqqz9qiRoT2eZHt+XEu
         D+Qhu7OY5CdKu12j4WVvPGqrhNChX0nTrr70cNG6CJaYcAZuwujiZPFd4DTzmBuoo6w/
         Wb25DlCZsDjTwnWHO4hUd1GwErfcFMzr1H9lgPNMs+5BSS0O52o7zY7yPINm80JDGcfU
         Z+yfqcwSjhX1rS7SEWOG2v7lX6b74kHbDIL1M+4htNIO1XO3P0j8haZ2Zp14WEa23FqB
         oLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722907411; x=1723512211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2zr5Jw8aSSrppFuky4osrxPL34Y2hdQ6m0LCpom6O0=;
        b=TKI+3A58zBDdrg0XCydeC47fUwmhYTsuvPw7dDxwx0vY53K1vt3ynnJ4DyEWDIYUsB
         crHsWpAMeLNV12g+V1b2NkSruZROh1FSPAqoaQ5IW0HqTs0mwbJITpI2cMqjx/VZWMyj
         +2wDLoghAbkQtCA7ruIEWl99P8srD7R5h0fFJsJ4ShufErwg0IKlVRt6l+A5e+c50OUN
         2V1ArcoFokNhn98m6/TDZ23mcR0LpfG/GeEKpCSthw+jLRXhmavYBlCP9P9jVB40uMlc
         HBl5FY9gnx85ded3CqzGUEKjXuK1e7yn6tv2Rx3vgNGJd5KNTU6RmaKULVjQ7AgBt8+A
         bXtA==
X-Forwarded-Encrypted: i=1; AJvYcCW/OE9F1fU/WDYnRq0tL9OkfAUelKecUhXo4Xv0juS9pnGPkde0KFjbEqPKNUwhx0tmPb1qcgZYBv+WchRW7sV22wqDGMzOgAdD
X-Gm-Message-State: AOJu0YyyFBtegOIiC+wQTMEJtZYgXM5+QGnN/1oX7CsmKuejnZnZ3IWE
	7VaKvMEt9hXTb6ErUPiFHqb/HQb2c3KbLCjllVDpv/8oZkXB7l0TMM68W+RTOom/aAZi94ak2fS
	QS4Ebb9FUXWn9o3yCfbdG1WKes26ZiUJBcHV1
X-Google-Smtp-Source: AGHT+IHDKybFd7xjBRooCMWNn/w6NoQhtyT6dyera+RHZ8++MzQjx2qRg4C4mrmTqvpJKMndQwKboNUTLGvAKAJR9gQ=
X-Received: by 2002:a05:6512:b94:b0:52c:b243:cd02 with SMTP id
 2adb3069b0e04-530d593c470mr35192e87.1.1722907410501; Mon, 05 Aug 2024
 18:23:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202408041602.caa0372-oliver.sang@intel.com> <CAHk-=whbxLj0thXPzN9aW4CcX1D2_dntNu+x9-8uBakamBggLA@mail.gmail.com>
 <CAKbZUD3B03Zjex4STW8J_1VJhpsYb=1mnZL2-vSaW-CaZdzLiA@mail.gmail.com>
 <CALmYWFuXVCvAfrcDOCAR72z2_rmnm09QeVVqdhzqjF-fZ9ndUA@mail.gmail.com>
 <CAHk-=wgPHCJ0vZMfEP50VPjSVi-CzL0fhTGXgNLQn=Pp9W0DVA@mail.gmail.com>
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com>
 <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
 <D38D6LJZOIQK.2GV58PGVL5K85@gmail.com> <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
In-Reply-To: <CAHk-=wjeWqr+0Ktzbwqrw17aESe5dZm5Kt6nwqtKJX00VsDqWg@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 5 Aug 2024 18:22:51 -0700
Message-ID: <CALmYWFuXTd5qYLa=rEkoFbzSk07PjdKExgKsUkgMkT2E1Pjrtg@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Pedro Falcato <pedro.falcato@gmail.com>, 
	kernel test robot <oliver.sang@intel.com>, Jeff Xu <jeffxu@chromium.org>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Dave Hansen <dave.hansen@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <groeck@chromium.org>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Matthew Wilcox <willy@infradead.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Amer Al Shanawany <amer.shanawany@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	linux-api@vger.kernel.org, linux-mm@kvack.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:13=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 5 Aug 2024 at 16:25, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > Can userspace on other archs not unmap their vdsos?
>
> I think they can, and nobody cares. The "context.vdso" value stays at
> some stale value, and anybody who tries to use it will just fail.
>
I want to seal the vdso :-), so I also care (not having it changeable
from userspace)

For the restore scenario, if vdso is sealed,  I guess CRIU won't be
able to relocate the vdso from userspace, I 'm interested in hearing
vdso dev's input on this , e.g. is that possible to make CRIU
compatible with memory sealing.

> So what makes powerpc special is not "you can unmap the vdso", but
> "powerpc cares".
>
> I just don't quite know _why_ powerpc cares.
>
> Judging by the comments and a quick 'grep', the reason may be
>
>     arch/powerpc/perf/callchain_32.c
>
> which seems to have some vdso knowledge.
>
> But x86 does something kind of like that at signal frame generation
> time, and doesn't care.
>
> I really think it's an issue of "if you screw with the vdso, you get
> to keep both broken pieces".
>
>            Linus

