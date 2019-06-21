Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE0A4EF67
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFUT17 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 15:27:59 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39374 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFUT16 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 15:27:58 -0400
Received: by mail-io1-f68.google.com with SMTP id r185so995656iod.6
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgNmp5vgEU3rAhixaVZBAVG/jZQe0nnZZmn89Y6ROOU=;
        b=PMBL5EB9hYeXfWjwjHLH+cq/MAI59cWGMboU3RV/osmS7BQI4sRYs6aYaTanGlalHX
         tIpSCrVAj7AQa5/F4xZHrX9VASbjutks5ySA6mYQq2NX0iSEfvgeuT0I9i9MG/tOxb1A
         bP60UPJDIQNxjOElRHl7AjJh1ttBX+0C3Z3DYehZsJO2Il9Pme+wAeHTftopa2Af9t9+
         MvCW90YoMiv0MB6oLhnacMv/hvgXnw4fHeVw8v5dEFs6qGsEiVEstqKdhE+IaCXoG3xT
         XREfXN82lzggbYkTcpkev7sXPFUmZsZk9lX3ILxYTnrRuCmjoneT7UI1Z3SuCdAOZT6z
         p9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgNmp5vgEU3rAhixaVZBAVG/jZQe0nnZZmn89Y6ROOU=;
        b=L50ihvOAF2hn727tQ/EAgTeutcypPB4IYaqOmPVDYJjSGAZpeSpy3unreZN+p1nDtV
         59H2LSlv4bDAdyD8+gd5SzuH9XkS/BOwC3puWqmm5pe8GpZ/nOv6tyxyWtQ5NlbneYzk
         em5KPdOsuymTIYO3mJ4hf2vM/ImkRCVh8xl+qGMxxE2DZ2bdoFuFiSBe9UdS+NWtkTSq
         CNZqDZ/hFQVuQwcYvXWOUKXNiZ7UJsADjo/VTOD8go3k/pMm9P8ccgr9MkBANcAD1pFW
         lugxgpnXBgXxP+dCZ4jMeFhdeTUiwZpTZAtEaa7CmlvimmLFNsHjQBYLYoHPm+DilO3I
         gfyA==
X-Gm-Message-State: APjAAAVjCXE9sYDpXCbt72HLq86RhkdMHQ5ta5Yz0uHezcuRPXnCXTL8
        iBTdYAtu/PMIPglG4y4k6TDM2RoqFXtVgktn76Arhg==
X-Google-Smtp-Source: APXvYqw85TXju4YL5DKRr8WddespTjK8zo6WjUenDASpEA1OS7EZ7BtksYwmtBqKGL6SHzGK1Cj7RhQ7HqvyLJha2yk=
X-Received: by 2002:a6b:8dcf:: with SMTP id p198mr36443852iod.46.1561145277675;
 Fri, 21 Jun 2019 12:27:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
 <20190621011941.186255-2-matthewgarrett@google.com> <CALCETrX87W4FE1xHF_W4=Do25Ci=LJxnvxNHMs9CTOFo4988aw@mail.gmail.com>
In-Reply-To: <CALCETrX87W4FE1xHF_W4=Do25Ci=LJxnvxNHMs9CTOFo4988aw@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Fri, 21 Jun 2019 12:27:46 -0700
Message-ID: <CACdnJusxhsYenacOEJkDXqVC13qoEd5eNXDgxWT_x8tz4bV5cQ@mail.gmail.com>
Subject: Re: [PATCH V33 01/30] security: Support early LSMs
To:     Andy Lutomirski <luto@kernel.org>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 20, 2019 at 10:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Jun 20, 2019 at 6:22 PM Matthew Garrett
> <matthewgarrett@google.com> wrote:
> >
> > The lockdown module is intended to allow for kernels to be locked down
> > early in boot - sufficiently early that we don't have the ability to
> > kmalloc() yet. Add support for early initialisation of some LSMs, and
> > then add them to the list of names when we do full initialisation later.
>
> I'm confused.  What does it even mean to lock down the kernel before
> we're ready to run userspace code?  We can't possibly be attacked by
> user code before there is any to attack us.

Certain kernel parameters can be disabled by lockdown, so we want to
have policy available before that parsing happens.
