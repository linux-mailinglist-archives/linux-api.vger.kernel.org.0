Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C7E3B824E
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 14:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhF3Mo7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 08:44:59 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:57169 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234455AbhF3Mo7 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Jun 2021 08:44:59 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 15UCfBAA024028;
        Wed, 30 Jun 2021 14:41:11 +0200
Date:   Wed, 30 Jun 2021 14:41:11 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Florian Weimer <fweimer@redhat.com>, Len Brown <lenb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <20210630124111.GC23648@1wt.eu>
References: <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
 <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net>
 <87wnqkzklg.fsf@oldenburg.str.redhat.com>
 <CAJvTdKkBTD62GTi=GW0+y0_1qc2JxfpfkNbXKWniWWOEmZZmUw@mail.gmail.com>
 <93e3b500-5992-a674-18e6-445d1db7b1f0@metux.net>
 <87tulirw5y.fsf@oldenburg.str.redhat.com>
 <84be3cfd-e825-ae75-bbae-2bbd3360daa7@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84be3cfd-e825-ae75-bbae-2bbd3360daa7@metux.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 30, 2021 at 02:22:19PM +0200, Enrico Weigelt, metux IT consult wrote:
> Ah, now I'm beginning to get it:
> 
> * this feature needs to be initialized first, before it can be used
> * on first use (when not initialized yet), it traps into the kernel
> * we don't want to always initialize it at boot
> 
> Correct ?

Not exactly. It's available but comes with a huge context-switch
cost for each task using it.

> What I'm wondering: why shall the process explicitly ask for it and
> why isn't the initialization be done either on bootup or on first use ?

The whole discussion about the pros and cons is archived here:

   https://lore.kernel.org/lkml/CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com/

> I'm still claiming already this old model is a horrible misdesign and
> (most of) the extensions made over the decades are anything but well
> designed - there had been many changes to do it much, much better.
> For example there would have been ways to introduce new opcodes in a way
> that they can be easily emulated in kernel or userland, w/o going
> through a full trap.

It's not a matter of opcodes but of context switch cost which not
everyone wants to inflict to every single task that opportunistically
uses these instructions without realizing what this subsequently
implies for the rest of their life. All this is discussed in the
thread above. I don't remember seeing anybody criticize the choice
of instruction encoding hence it's irrelevant to this discussion.

Hoping this helps,
Willy
