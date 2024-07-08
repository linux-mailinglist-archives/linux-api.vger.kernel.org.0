Return-Path: <linux-api+bounces-1867-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EECE929A52
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 02:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BE9B20BFC
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 00:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28B336D;
	Mon,  8 Jul 2024 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X9Zmvy1a"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62F18E
	for <linux-api@vger.kernel.org>; Mon,  8 Jul 2024 00:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720397330; cv=none; b=ExmfDpc6958mb0sluCVhKFcvidcMs6x1+yhChrQDEPPKX7mHv+IC3KxCADVKE/YvNfi5xVw+wWICpfOzGjmqFvnPdlt36cmto8O8qR7r1z/4VY5Ik3Nz5wPEi/OURT2myn9mdbNP0HR/FVT0t7awr803rx0PPl2jUnWgUKr1lRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720397330; c=relaxed/simple;
	bh=vn3ej6uz5HJ27Cac3DuFzn+uB9SQgk0rY+AAwVDZ1TA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s/jVzNoo/MUEvSK+83Jnh+xSUcyi61Xd9PiCQNmPq394s5f1+hkyAZfHZ0kxIj1EWTHOwkGP6BL8dPvNfn+Wf/i71FFKE5hH3usYkWYN5Rlkra4TF8/4epHPwhjRqXye2jZV3HNHaykWxsNfNVd3AEgTipu3g+sX8LIf4bGBXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X9Zmvy1a; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-58ba3e38027so3827550a12.1
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 17:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720397327; x=1721002127; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AxHB4WSH7xbSrF4sriiEMDo3clBzyxps6KE5BYXF8FA=;
        b=X9Zmvy1a0/BwfgyjzRqkPU4zGtAANjSG92h3XEF3bjsujpRD1G3XU9krfRQ+ZVZAtT
         rKb6IQr9Jcsl4b07Dp7dq+I36CNKpLEQVrEF+LtnpasVLja2RytPKGtcFa0ZH0e55DET
         PHZqOIw7BGFsSaLCeYDr9Xv9GtZLI/JQJ7Yc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720397327; x=1721002127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AxHB4WSH7xbSrF4sriiEMDo3clBzyxps6KE5BYXF8FA=;
        b=rg7n+SrVer9bog8nzmYeGNCbVtSZixc/JokrazlLAnaNxB2LfGlbHss2DDpO9UeorZ
         fjx4Rdy38GYLJ3G09FBxifaG7YwglL9EhYgcAfD0W8vUynPbw3e+WsKlGBPuDUKllWGj
         EzbCK9f9bdYz1hPui8I10772b1q9VXcsziPLDjaFTJsF9bvWnhseK1ZdYx+RicHUosYr
         +9n3EZ1FxnrHq61LEPm9iF6fryYzXeQy6VIYq/MF5iG29UwxISqMQ4V8xk4Jc8YzD+nk
         9mY4NP44cs9FPk5Vs2SkAnHcjdYw8oXDeWQKXCyCZ9X+i07sisMAIvf+EA0joQyX5oVo
         Iqwg==
X-Forwarded-Encrypted: i=1; AJvYcCWNcpfDI//T9vuWt/ffl2FD2wMUXa4WYlAi3ovSLCwtw1ON1AIqe1/n2xrCLwCsMTr24G1xDxot7pb+PFZlkXBLoKraBgxx5Ibt
X-Gm-Message-State: AOJu0YzvNaGWdfEg6nUhJjRzSCqQl0aK/CHc2mqvykzeBRmWyRBSpfGq
	ABVoUg7CVqSnT3oD8zR3+bKqac+aKWhv3uL+CGogczKW32L9reg1A/ha/iU14wqBm9BYNGV0S0J
	MZjdh7A==
X-Google-Smtp-Source: AGHT+IFYUkxOEhQKtZv4RDWGr18Yy1vPWXFlH6i5Ekd9ZJwY97TUC2FmfY9L53RrqRHQnXDVrpU46w==
X-Received: by 2002:a05:6402:270e:b0:584:8feb:c3a1 with SMTP id 4fb4d7f45d1cf-58e5a8e72abmr9216572a12.1.1720397326668;
        Sun, 07 Jul 2024 17:08:46 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-58ec3e34198sm4265247a12.42.2024.07.07.17.08.46
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jul 2024 17:08:46 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58b447c511eso4128059a12.2
        for <linux-api@vger.kernel.org>; Sun, 07 Jul 2024 17:08:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW7qvsLEFbgiq/vbXZ0xXhcii1oIaNscU+uI5xuyYCLXaQniyGwgtGizaziwkPoTXAq4SJ2Y5v6sTAfBJQselU1LrAmMUGwnFpZ
X-Received: by 2002:a17:906:ce53:b0:a6f:af8e:b75d with SMTP id
 a640c23a62f3a-a77ba4552damr759244366b.8.1720397325858; Sun, 07 Jul 2024
 17:08:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707002658.1917440-1-Jason@zx2c4.com> <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com> <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com> <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
In-Reply-To: <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jul 2024 17:08:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
Message-ID: <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: David Hildenbrand <david@redhat.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	tglx@linutronix.de, linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, 
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Jul 2024 at 14:01, David Hildenbrand <david@redhat.com> wrote:
>
> At least MAP_DROPPABLE doesn't quite make sense with hugetlb, but at least
> the other ones do have semantics with hugetlb?

Hmm.

How about we just say that VM_DROPPABLE really is something separate
from MAP_PRIVATE or MAP_SHARED..

And then we make the rule be that VM_DROPPABLE is never dumped and
always dropped on fork, just to make things simpler.

It not only avoids a flag, but it actually makes sense: the pages
aren't stable for dumping anyway, and not copying them on fork() not
only avoids some overhead, but makes it much more reliable and
testable.

IOW, how about taking this approach:

   --- a/include/uapi/linux/mman.h
   +++ b/include/uapi/linux/mman.h
   @@ -17,5 +17,6 @@
    #define MAP_SHARED  0x01            /* Share changes */
    #define MAP_PRIVATE 0x02            /* Changes are private */
    #define MAP_SHARED_VALIDATE 0x03    /* share + validate extension flags */
   +#define MAP_DROPPABLE       0x08    /* 4 is not in MAP_TYPE on parisc? */

    /*

with do_mmap() doing:

   --- a/mm/mmap.c
   +++ b/mm/mmap.c
   @@ -1369,6 +1369,23 @@ unsigned long do_mmap(struct file *file,
                        pgoff = 0;
                        vm_flags |= VM_SHARED | VM_MAYSHARE;
                        break;
   +            case MAP_DROPPABLE:
   +                    /*
   +                     * A locked or stack area makes no sense to
   +                     * be droppable.
   +                     *
   +                     * Also, since droppable pages can just go
   +                     * away at any time, it makes no sense to
   +                     * copy them on fork or dump them.
   +                     */
   +                    if (flags & MAP_LOCKED)
   +                            return -EINVAL;
   +                    if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
   +                            return -EINVAL;
   +
   +                    vm_flags |= VM_DROPPABLE;
   +                    vm_flags |= VM_WIPEONFORK | VM_DONTDUMP;
   +                    fallthrough;
                case MAP_PRIVATE:
                        /*
                         * Set pgoff according to addr for anon_vma.

which looks rather simple.

The only oddity is that parisc thing - every other archiecture has the
MAP_TYPE bits being 0xf, but parisc uses 0x2b (also four bits, but
instead of the low four bits it's 00101011 - strange).

So using 8 as a MAP_TYPE bit for MAP_DROPPABLE works everywhere, and
if we eventually want to do a "signaling" MAP_DROPPABLE we could use
9.

This has the added advantage that if somebody does this on an old
kernel,. they *will* get an error. Because unlike the 'flag' bits in
general, the MAP_TYPE bit space has always been tested.

Hmm?

              Linus

