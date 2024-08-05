Return-Path: <linux-api+bounces-2119-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F60C94829B
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 21:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A69C28279F
	for <lists+linux-api@lfdr.de>; Mon,  5 Aug 2024 19:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4933815ECD1;
	Mon,  5 Aug 2024 19:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SLcyO+g3"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EA06F305
	for <linux-api@vger.kernel.org>; Mon,  5 Aug 2024 19:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722887473; cv=none; b=kXcs7CGvrjFmYZedZnllBcocviODiWoKnC75e1kzbL3TNCiyEs84daE3RSKprn4o/yVYNdo9F2nOzRpJ9D8vMt5KGnfusl0UwrAJOQ43fzchlDBhwB+1Hc5V8LXjgOywvZkyleP+BI6nBBjpliwf/nrHXpcOuTie41oHRA6HJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722887473; c=relaxed/simple;
	bh=RnAVL1F8Zc5pFSyUaXWapLKKpniVvPkLdg4oxhP2wTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cV6i+OqEnRJ1zyWsnbC+DdgDUCT1r16dWYNdlBxJb7S3LLh6OUHZh9l2XELuCMrTOKPHTIhywHgWZE80LBmQoie5+Ksoa4H6/wVylJ5t9DbkjecUqgrgwnRmFtRp4/HwAzm2T7kEwE0mhwSpQYQXguvMkoarI0q9RKdEgXWElHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SLcyO+g3; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-530ae4ef29dso11760593e87.3
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722887469; x=1723492269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LIYPIC0BflVMuV8NaYQS5YL8fh1QrNDyHT/xu/wxw5U=;
        b=SLcyO+g3e9LQXDR67nCRTNzjLry6k6s3TgrT8y0aHpTXaT5fsTikgR4ZGibhKucHXj
         +0szEEaRGHNyMeY1kT/8+GYgRtdOaE4RxJDZBrigB4ihbajjkNale5BkLdc8KZZUun8o
         /4pMzpcHuTXYq2ONao1mqwavtLhvFnuM4DVh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722887469; x=1723492269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIYPIC0BflVMuV8NaYQS5YL8fh1QrNDyHT/xu/wxw5U=;
        b=K2XPLQj5jdcTbTsyA6mmYLMcokfhCUTPjTZ6mXTed5e97TFihAgFs4TCh8mxqi5jcu
         jYQFMdGHfZDJvRT3JIbNYCntDB+51xQ7h4Rg4bf5DP/WXfrRP7pd/ek5PE+wc7OMEfXO
         wq9xuIlYULB0hZesgsxim/j7CK/qASvjRwGSxrhY7L8coWIDf0HC4CUR8Brrcj6X+6Xu
         Nv6C+IOhFTXvPduJ6fipX7h/b0aZ4p4e2nrRaPiRSpKIC5VmwFoTYJoEt1c7gjNwtFOx
         ZV0QEaUdjvwwiTIQoU8EqeViao6zRekwWXCf9hQzsLBDNIiR8ovCQOBuXvq55j8jCZon
         ey1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX2P59n0VrHoUhB8RjaMeQsMYSw/i7neBJETklFouYR790unx8gM3BnZoafUaQOIv2XCO84SG44xwPZQqjSovFnPkEyYVxV0/CG
X-Gm-Message-State: AOJu0Yyhx2eE4RfrGH2+4y+fXVC6j60HqCl6WLAkF5yM5ZiUIVsNFyNq
	UYkndOC5C/Ogo4jt1BYzIz0PWfLDhx/34CsDYaNs9QuXwWdNUvypvrRo+sF6dKKt68wbxuf/M76
	pFqJDwg==
X-Google-Smtp-Source: AGHT+IHjtnhD46UvZeXrjosTxj5NoeZl+fZ8NaPMQ8Ah/wwVmHiD4kWAkRxeXblg3d2OH9lkniXQEw==
X-Received: by 2002:a05:6512:3d87:b0:52c:d628:c77c with SMTP id 2adb3069b0e04-530bb3b4707mr10959306e87.43.1722887469236;
        Mon, 05 Aug 2024 12:51:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba10e47sm1229945e87.83.2024.08.05.12.51.08
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 12:51:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef248ab2aeso152657901fa.0
        for <linux-api@vger.kernel.org>; Mon, 05 Aug 2024 12:51:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQi6Rzx2P9kEaM+DucgF1m5JNfBP1b4umpfNanq8JPtswHNiGVJR5bQr0gRnxJdjFWk59YVNI4Aa/qB9J4zN4Al0rZ9QWOGfNz
X-Received: by 2002:a2e:9845:0:b0:2ef:20ae:d117 with SMTP id
 38308e7fff4ca-2f15aa88cc7mr104885471fa.10.1722887468283; Mon, 05 Aug 2024
 12:51:08 -0700 (PDT)
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
 <CALmYWFuCvphvLQOuQHBbFq0G8Ekyze=q45Tt4dATOt-GhO2RGg@mail.gmail.com> <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
In-Reply-To: <CAHk-=wgySgXXkZtx49Xq70X2CmSizM8siacYKncMmFWRzKjs5Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 12:50:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgP0hCD-05rfvWcVmizzx676WsR0+iEuVwQUMSFFnM8kw@mail.gmail.com>
Message-ID: <CAHk-=wgP0hCD-05rfvWcVmizzx676WsR0+iEuVwQUMSFFnM8kw@mail.gmail.com>
Subject: Re: [linus:master] [mseal] 8be7258aad: stress-ng.pagemove.page_remaps_per_sec
 -4.4% regression
To: Jeff Xu <jeffxu@google.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
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

On Mon, 5 Aug 2024 at 12:48, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But x86 has the same context.vdso logic, and does *not* set the
> pointer before installing the vma, for example. Also does not zero it
> out on munmap(), although it does have the mremap logic.

Oh, and the empty stale arch_unmap() code on the x86 side has never
been about the vdso thing, it was about some horrid MPX notification
that no longer exists.

In case people wonder like I did.

           Linus

