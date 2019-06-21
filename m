Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3DE4EC08
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbfFUPaT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 11:30:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45393 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfFUPaS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 11:30:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id f9so6969391wre.12
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5YZiI+zyweO0ekg0qLNHMbAW8w56yWaJIWuJNWGZdrg=;
        b=dbXgRwNiGWpZ5dPzPLSjqSh7tCw83/f69jreXjaWR8B2wtYOw9YPmU3lsN9j2es8Ei
         gRWkwcDnXMd82gOZr6ISqY820b65NQMRy8mIDEmdm+knU1sVfW/YrUbgxv5CXyM0koGm
         hyGmh+vnwAqc4WIK9HTB5GsGjbEmuhVn41ACwvK6XXpzidzcacXcM/u4Jl2IsLVo8JS+
         JH7Xao84vGP3gdM1BvNWl6r1D06nMa4/X9x1Kgn8LqcJzn4sSLj+qPMOwG20Sgbjn3bO
         DsSuII112vDKrvffk7Vwpv2Ty/QVRWYlMpN7vmsWKazy160tWAdFaQkwUhg7nSpNIb6V
         1hDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5YZiI+zyweO0ekg0qLNHMbAW8w56yWaJIWuJNWGZdrg=;
        b=KJoD3tDPNDQoTFfnd53BAraPkrE1rOVRNzmhjXWMjxQdIY+3ZcblGK/3E2zvVVljGu
         dQ75qrBc8ZbsiPMSoa9lzjqaQmWZ/KE8UFJVAWqrp+j6yu/mvDgH6MnkNeAbONQH8oVv
         I+sigLCk9GyGcbsepLYfvvEZAQ486vSBNQjePp0QUbAqcnFeDipK9z6JimqodTpOvYoF
         POgo1qcErTc+7weh4GRatxQ/vMEZ/UdIx57afFYa5mPXMujajF/q5b5w6fHJSzWRPpZu
         kssZlGjA1+oPhI4P4vkFBvTrxZPOvgCAiRE6L0KLhxD+5bEg0jaYmEZNzvH/04mW5cu+
         r2sQ==
X-Gm-Message-State: APjAAAXo5WRBYZjGxodpY7Wpd0IDD8GqWVU2/ip2UTeqzy/kZ3bnpjOP
        S2v8I0v03n3zDZI9orpWT9JZAQ==
X-Google-Smtp-Source: APXvYqxFKVSRfk08uzwdvWV3KQkOr6uYr6J60bP5szgzwI1jwV+mfyZuPSfD5iQmdEUNbgr/7nQ+KQ==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr3737859wrx.191.1561131016526;
        Fri, 21 Jun 2019 08:30:16 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id w23sm3178921wmi.45.2019.06.21.08.30.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 08:30:15 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:30:13 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Ley Foon Tan <lftan@altera.com>,
        "moderated list:NIOS2 ARCHITECTURE" 
        <nios2-dev@lists.rocketboards.org>
Subject: Re: [PATCH v3 2/2] arch: wire-up clone3() syscall
Message-ID: <20190621153012.fxwhx25mzmzueqh7@brauner.io>
References: <20190604160944.4058-1-christian@brauner.io>
 <20190604160944.4058-2-christian@brauner.io>
 <20190620184451.GA28543@roeck-us.net>
 <20190620221003.ciuov5fzqxrcaykp@brauner.io>
 <CAK8P3a2iV7=HkHBVL_puvCQN0DmdKEnVs2aG9MQV_8Q58JSfTA@mail.gmail.com>
 <20190621111839.v5yqlws6iw7mx4aa@brauner.io>
 <CAK8P3a0T1=eg5ONbMFhHi=vmk1K5uogZ+5=wpsXvjVDzn6vS=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0T1=eg5ONbMFhHi=vmk1K5uogZ+5=wpsXvjVDzn6vS=Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jun 21, 2019 at 04:20:15PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 21, 2019 at 1:18 PM Christian Brauner <christian@brauner.io> wrote:
> > On Fri, Jun 21, 2019 at 11:37:50AM +0200, Arnd Bergmann wrote:
> > >
> > > I never really liked having __ARCH_WANT_SYS_CLONE here
> > > because it was the only one that a new architecture needed to
> > > set: all the other __ARCH_WANT_* are for system calls that
> > > are already superseded by newer ones, so a new architecture
> > > would start out with an empty list.
> > >
> > > Since __ARCH_WANT_SYS_CLONE3 replaces
> > > __ARCH_WANT_SYS_CLONE for new architectures, how about
> > > leaving __ARCH_WANT_SYS_CLONE untouched but instead
> >
> > __ARCH_WANT_SYS_CLONE is left untouched. :)
> >
> > > coming up with the reverse for clone3 and mark the architectures
> > > that specifically don't want it (if any)?
> >
> > Afaict, your suggestion is more or less the same thing what is done
> > here. So I'm not sure it buys us anything apart from future
> > architectures not needing to set __ARCH_WANT_SYS_CLONE3.
> >
> > I expect the macro above to be only here temporarily until all arches
> > have caught up and we're sure that they don't require assembly stubs
> > (cf. [1]). A decision I'd leave to the maintainers (since even for
> > nios2 we were kind of on the fence what exactly the sys_clone stub was
> > supposed to do).
> >
> > But I'm happy to take a patch from you if it's equally or more simple
> > than this one right here.
> >
> > In any case, linux-next should be fine on all arches with this fixup
> > now.
> 
> I've looked at bit more closely at the nios2 implementation, and I
> believe this is purely an artifact of this file being copied over
> from m68k, which also has an odd definition. The glibc side
> of nios2 clone() is also odd in other ways, but that appears
> to be unrelated to the kernel ABI.
> 
> I think the best option here would be to not have any special
> cases and just hook up clone3() the same way on all
> architectures, with no #ifdef at all. If it turns out to not work
> on a particular architecture later, they can still disable the
> syscall then.

Hm, if you believe that this is fine and want to "vouch" for it by
whipping up a patch that replaces the wiring up done in [1] I'm happy to
take it. :) Otherwise I'd feel more comfortable not adding all arches at
once.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=clone

Christian
