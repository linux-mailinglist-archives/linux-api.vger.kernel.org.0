Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F21138B915
	for <lists+linux-api@lfdr.de>; Thu, 20 May 2021 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhETVnV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 May 2021 17:43:21 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42688 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbhETVnU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 May 2021 17:43:20 -0400
Received: by mail-ed1-f50.google.com with SMTP id i13so21060287edb.9;
        Thu, 20 May 2021 14:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/4LtIOBD6wxF9iMPhLoPX028a1rtI0NTUTVZTA+F+Y=;
        b=e/66uxwhiRj7tkxVG5eko1XYFVp5SO5oyTL9gKy8ufon3KM7iqvREhclsOH/BLeG0f
         nqm+jUFb89AyeMXHfjbJ9SUD9lrBgXOVCTMSwK/xWuzj2gxw/aeCzFutUH3PlrsBxAYK
         umCTrbVBZzicVfdh+Q/JxKCw5dzEpqL6yoerQbjU/7XnaZKSl5Hk+XZ4lrf7FBH6unI4
         gccxEVWQ1VxLlKWriCYlrTjxFmF/Fj/jFyc6x/d0qw/NAAZeW++JzEiRGChuQGfQ+XBy
         UAXlYNjISdAEV+IDmrRtdXwQQBBaH7K14RxefWAUilB+oG7eDDjYlwP5zOZLIkZKEPz6
         8G7Q==
X-Gm-Message-State: AOAM532P8K9Sro7ZIMuoD45tcbmgUMICkgEZG6Rk9QlN70IGNJqoxENw
        cLBuNDRTe/F7VKqwpwZx16oKq38A2xV/4B5xf1vGT3BI
X-Google-Smtp-Source: ABdhPJxibk2/f4GeDvxy3AIuRa9jRf5Bkoi8neyu/Ok51BwgSMelBKvR44Ci02P9JsQRlgtytkLOnMKlNkh9T3CZyE8=
X-Received: by 2002:aa7:c6cd:: with SMTP id b13mr7100076eds.94.1621546917061;
 Thu, 20 May 2021 14:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
In-Reply-To: <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 20 May 2021 17:41:45 -0400
Message-ID: <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, May 20, 2021 at 5:13 PM Dave Hansen <dave.hansen@intel.com> wrote:

> >> Regarding error return for allocation failures.
...
>  * vmalloc() can fail (the memory.kmem cgroup limit is probably the most
>    likely place to be exposed to this)
>  * vmalloc() failure in a fault (like #NM) will result in SIGSEGV
>  * vmalloc() failure in a syscall can be handled with -ENOMEM

Thanks for clarifying this, Dave.

We added the explicit-allocate to v5,
which should be on the list by tomorrow.

So the questions are:
1. who calls it -- a call/thread or process?  the application?  a
library -- which library?
2. is it optional, or mandatory?
3. if it is mandatory, what is the best way to enforce it?
4. should we have a "release" system call too?

1. Every thread needs a context switch buffer.  Does every thread make
the system call?  It seems sort of awkward for a library to always
make a system call before doing a TMUL.  It would be functionally
harmless, but it would add latency to an otherwise low-latency
operation.  If some central library does it, and caches that it has
done it before, then it would be ugly, but at least it would remove an
unnecessary user/kernel transition.

2. If it is optional, then v5 is code complete -- because it allows
you to allocate either explicitly via prtcl, or transparently via #NM.

3. If it is mandatory, then we should re-purpose the XFD mechanism:
app starts with XFD armed, by default
if app touches AMX before prctl, it takes a signal (and dies).
When app calls prctl, allocate buffer disarm XFD for that app (exactly
what #NM trap does today).

4. I don't see a justification for a release concept, but it is
possible -- though sort of sticky with possible nested calls from
combinations of apps and libraries.  If that were sorted out by a
central library, then the actual system call on the last release per
thread would re-arm XFD to prevent access until the next explicit
request.  Unclear if it is important that the kernel actually do the
free -- some things might run faster if we keep it around...

Len Brown, Intel Open Source Technology Center
