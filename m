Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FADA2A6F28
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 21:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbgKDUqv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 15:46:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgKDUqv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 15:46:51 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03327C0613D3
        for <linux-api@vger.kernel.org>; Wed,  4 Nov 2020 12:46:51 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id m3so4784102vki.12
        for <linux-api@vger.kernel.org>; Wed, 04 Nov 2020 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uLAg6w7+e2pko8BYI4hCD6KQj4t4TWdlHLoWIf2PADs=;
        b=qbmO/Y+s1b0hA6aznMliYm+lLNzHUxClnoaAxNVDgEOO0cgLBNXqgyN2/XO5muo/uL
         CWFXirSsbrsXd33oitrG1dTPALHGU7Ek3IREpTMvcv/UixgbYsqPHvYZzoX5GIUNUyEF
         iiSnNSL2orEOZv0n8oGuBBykqn4egv5OJt9/EgBS2/To00/slLtMNKkznLA+2yFmla0m
         D1FrP1ULiaqaq38/SJu6A706iMZ/D7IrEOTFronOXuEKMRhNmsJafWFeUySgy3MSVEzt
         VNpx009i/GSEVt4RfjWnVEFsYd76+MNo7iCrKfTdocIwLAM8ILIE0SZqUiuJVxS8u8eL
         ug4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uLAg6w7+e2pko8BYI4hCD6KQj4t4TWdlHLoWIf2PADs=;
        b=aYgLQs9lXwfaPPPT0vlGHONDCemV9Ijsegx8tTpaqZAV4VSlt0A73Cq4rKlxXCSkdX
         KT56vU3jxrYR8+ZnLdKJdEZnZA2CyAeSkGPV8qezlk3R+HIm2PFvBNaCazIb9t//3mnr
         cXiMsPjHHAT+P47DYrtBRmLq42T68G4PEnkQA/wRZZWklcVg36a4Uw9KzRcrMhEXrTby
         azfqRzgmGvHhuXxeTIpTs19MTBfUe2OkQB6UfZR+cGRthSQZ7c3eCQ1e5FtuuM2FoQLb
         +6VJvfOMxdSLaYapwpm0gsJxXooaI8+7xzxZ7A92WBj8WkOPt8IvCBwnv8uM+2D1Q9Hg
         ri2g==
X-Gm-Message-State: AOAM533Th09vbFZxbchquNkwuG5d3pRXBB7pgeQaymxx9CsYd/jDm/aX
        /ecD/1kuklit2/DAqnLJ6u8VMOhkXw2g/mwSIGosmA==
X-Google-Smtp-Source: ABdhPJyX9Fxxp5uaHvFJkdnYDOhlG+NcXIFXA5WjVyrTdOU7rGXP2Qwck/tzNquHq4RM/mz1kRy1Bba+WE7qfnrCb6A=
X-Received: by 2002:a1f:ee08:: with SMTP id m8mr6099745vkh.3.1604522810010;
 Wed, 04 Nov 2020 12:46:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604376407.git.pcc@google.com> <7e26600459cb08c5016611b37fe88c23098b40eb.1604376407.git.pcc@google.com>
 <87a6vx6p11.fsf@x220.int.ebiederm.org> <20201104172447.GF28902@gaia>
In-Reply-To: <20201104172447.GF28902@gaia>
From:   Peter Collingbourne <pcc@google.com>
Date:   Wed, 4 Nov 2020 12:46:39 -0800
Message-ID: <CAMn1gO7aMPF85uokyMb6PNTSQqTgf3tkMFBpTLrjYhbjvWQs8w@mail.gmail.com>
Subject: Re: [PATCH v13 1/8] parisc: Drop parisc special case for __sighandler_t
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 4, 2020 at 9:24 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Nov 04, 2020 at 10:54:34AM -0600, Eric W. Biederman wrote:
> > Peter Collingbourne <pcc@google.com> writes:
> > > From: Helge Deller <deller@gmx.de>
> > >
> > > I believe we can and *should* drop this parisc-specific typedef for
> > > __sighandler_t when compiling a 64-bit kernel. The reasons:
> > >
> > > 1. We don't have a 64-bit userspace yet, so nothing (on userspace side)
> > > can break.
> > >
> > > 2. Inside the Linux kernel, this is only used in kernel/signal.c, in
> > > function kernel_sigaction() where the signal handler is compared against
> > > SIG_IGN.  SIG_IGN is defined as (__sighandler_t)1), so only the pointers
> > > are compared.
> > >
> > > 3. Even when a 64-bit userspace gets added at some point, I think
> > > __sighandler_t should be defined what it is: a function pointer struct.
> > >
> > > I compiled kernel/signal.c with and without the patch, and the produced code
> > > is identical in both cases.
> > >
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > > Reviewed-by: Peter Collingbourne <pcc@google.com>
> > > Link:
> > > https://linux-review.googlesource.com/id/I21c43f21b264f339e3aa395626af838646f62d97
> >
> > Peter as you have sent this, this also needs your Signed-off-by.
> >
> > Otherwise this looks reasonable to me.
> > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Thanks, likewise for the other patches that you acked.

> > While the final bits look like they are still under discussion it looks
> > like the preceding cleanups are pretty solid at this point.
>
> Minor nits, unless you nak the whole approach of SA_FAULTFLAGS and
> SA_UNSUPPORTED ;) (it looks a bit complicated to me but I don't have a
> better idea for a generic implementation).
>
> > Any chance we can get the cleanups into a tree in linux-next so that
> > the discussion can focus on the core parts of this work?
> >
> > Perhaps I should pick up the clenaups?
>
> However you prefer (I usually start queuing patches at -rc3). If you
> pick them up, please provide a stable branch somewhere so that we can
> add the others on top.

Picking up the cleanups first sounds good to me and I don't mind which
tree they go via. To make it easier to pick up just the cleanups I
will reorder the patches a bit. I will move patch 6 to patch 4 so that
1-4 are the non-uapi-affecting cleanups and 5-8 implement the
substantive changes.

Peter
