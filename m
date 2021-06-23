Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C083B23E5
	for <lists+linux-api@lfdr.de>; Thu, 24 Jun 2021 01:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWXOX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Jun 2021 19:14:23 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:35439 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhFWXOX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Jun 2021 19:14:23 -0400
Received: by mail-ej1-f48.google.com with SMTP id gn32so6524394ejc.2;
        Wed, 23 Jun 2021 16:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uOSFodj4auX4yeH5YdDicEQGbayWjRRaX6zTkpmd55M=;
        b=aLw43jD/9+bSuPoYxiSOjKcTKDGlOJdlQK7HcoEZzlcps4wIwTbu010KJ80KRSxK3L
         Z9ycPCmoItksfm0tmeJEwMhFXnKgwhUcSU4X6dk0wKSkqMWTuhXNVX31mnQ4zPP1F08M
         oeCYFgSXdNj6s5k8BjiRgq1yS0L0A4c5Lfqqw5vzxLnUZ+4Xk0t2DFO3jWVnxZOx81/B
         5HDJ7Bpta0AJKcx5Nohgkrzb6EM7RltjNBB6vvT7lJ9kAik/Xcp1OB7RwTGDR9B0zl5r
         Fnb7yagqDOSwW6r6NtLrjfYCISLetJzy1Fm5k03YySCzBxyHKqs4/4HBWWtUzL61gaxz
         simg==
X-Gm-Message-State: AOAM532f4L3piZVlATzAJjAiZKyAnMfGDW8BZrKEGFoLi/8lBTmENk1j
        3MZF36V2PDAJraxHfBYXSpI3vjvL54Napg4htGA=
X-Google-Smtp-Source: ABdhPJyC295VkNAJqZlMSj3vxEw5F3msVz/27GqRfqjyeIfuinxBYjCGV7BUPtT6RywvWfkoGYNXyeQZ8UNERHAHgh0=
X-Received: by 2002:a17:906:2bc6:: with SMTP id n6mr2348171ejg.256.1624489923489;
 Wed, 23 Jun 2021 16:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com> <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net> <87wnqkzklg.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wnqkzklg.fsf@oldenburg.str.redhat.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 23 Jun 2021 19:11:52 -0400
Message-ID: <CAJvTdKkBTD62GTi=GW0+y0_1qc2JxfpfkNbXKWniWWOEmZZmUw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 23, 2021 at 11:07 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Peter Zijlstra:
>
> > On Fri, May 21, 2021 at 04:44:58PM +0200, Florian Weimer wrote:
> >
> >> And we added an interface for querying x86 CPU features to glibc 2.33
> >> which is completely incompatible with this because it assumes that CPU
> >> features do not change during the lifetime of a process. 8-(
> >
> > How many x86 kernel maintainers signed off on that patch?
>
> I've started a new thread:
>
>   x86 CPU features detection for applications (and AMX)
>   <https://lore.kernel.org/linux-api/87tulo39ms.fsf@oldenburg.str.redhat.com/>

FWIW, I didn't receive it, because you excluded

linux-kernel@vger.kernel.org

(x86@kernel.org is just the actual x86 kernel committers, ISTR)

Len Brown, Intel Open Source Technology Center
