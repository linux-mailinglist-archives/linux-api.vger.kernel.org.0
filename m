Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685163426AC
	for <lists+linux-api@lfdr.de>; Fri, 19 Mar 2021 21:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbhCSUIr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 19 Mar 2021 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCSUI0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 19 Mar 2021 16:08:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4338C06175F
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 13:08:25 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z8so13395349ljm.12
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 13:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l/0awmwbYpldGtvhGbGrjtgg5S5AmtnvrJ31RfQjWzg=;
        b=Udu99pfuLvrG3/uGIHBn854uuyD2MnagNpLodzU1KeSa2MMu8iHwpvgaE2s5sLcD22
         weRb6idNCOSd97o1eHiD3ISp6GYnVz2SUXOIzQcXDYj1Oz/8mwXreNqGUuJeQNjkMvkB
         hBIs/RjQ8pcafCqVnLFRmLTU+wZUiLkOdJY5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l/0awmwbYpldGtvhGbGrjtgg5S5AmtnvrJ31RfQjWzg=;
        b=t06x5J6crIZES0t+rAsHI1kIOr5Bd/UE80sN+t4k5bDMcd7lHeNTpgch6APdvOi/Rh
         Cyh7G1mE77qkMu0C9mfeEy/LwgE57PHIPsfmHR6YWtcR/vWf54OOtpXwNPxYRq7tuXPM
         +u+e+CM02OGOz2yGyyJ4D3x/9w/xZMVirEJGB4xUO7QJZwnN9HR1tbcFkXx7c7j2Sr0H
         dsX0R2dCbaLNbKYrlkF5siYb1t8A0jzB8G4iKJCLbVjJeOnabfXZjxyTSCzJKaBiB9PM
         gdK43JqPy+4m1+3g+aCLlyOJBbOm2s0vcfoaJLkmitQ5yGCBB7GknzjzPGSA64kW9OJr
         iTDw==
X-Gm-Message-State: AOAM530Kgp5SAVILXdvJTViFizvV5PvWc9Hz+2xkl1dEyhmlVNX2Fyah
        Vs0aATqe1dNV2CMqFweW4XsQawAcpVmZrg==
X-Google-Smtp-Source: ABdhPJwwfDDyCruFp2jf0nUY6DS46AnKDpowx9K6WquUxLy2WO2NC2eWlcZ09PXDRkcA6VN+JRHFZA==
X-Received: by 2002:a2e:581d:: with SMTP id m29mr1970089ljb.97.1616184504094;
        Fri, 19 Mar 2021 13:08:24 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t13sm888002ljk.47.2021.03.19.13.08.21
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 13:08:22 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id b83so11831846lfd.11
        for <linux-api@vger.kernel.org>; Fri, 19 Mar 2021 13:08:21 -0700 (PDT)
X-Received: by 2002:a05:6512:33cc:: with SMTP id d12mr1663604lfg.487.1616184501624;
 Fri, 19 Mar 2021 13:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1615922644.git.osandov@fb.com> <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
In-Reply-To: <8f741746-fd7f-c81a-3cdf-fb81aeea34b5@toxicpanda.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 Mar 2021 13:08:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
Message-ID: <CAHk-=wj6MjPt+V7VrQ=muspc0DZ-7bg5bvmE2ZF-1Ea_AQh8Xg@mail.gmail.com>
Subject: Re: [PATCH v8 00/10] fs: interface for directly reading/writing
 compressed data
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Mar 19, 2021 at 11:21 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> Can we get some movement on this?  Omar is sort of spinning his wheels here
> trying to get this stuff merged, no major changes have been done in a few
> postings.

I'm not Al, and I absolutely detest the IOCB_ENCODED thing, and want
more explanations of why this should be done that way, and pollute our
iov_iter handling EVEN MORE.

Our iov_iter stuff isn't the most legible, and I don't understand why
anybody would ever think it's a good idea to spread what is clearly a
"struct" inside multiple different iov extents.

Honestly, this sounds way more like an ioctl interface than
read/write. We've done that before.

But if it has to be done with an iov_iter, is there *any* reason to
not make it be a hard rule that iov[0] should not be the entirely of
the struct, and the code shouldn't ever need to iterate?

Also I see references to the man-page, but honestly, that's not how
the kernel UAPI should be defined ("just read the man-page"), plus I
refuse to live in the 70's, and consider troff to be an atrocious
format.

So make the UAPI explanation for this horror be in a legible format
that is actually part of the kernel so that I can read what the intent
is, instead of having to decode hieroglypics.

            Linus
