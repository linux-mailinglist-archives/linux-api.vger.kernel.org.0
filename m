Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15B438D089
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 00:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhEUWIn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Fri, 21 May 2021 18:08:43 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:33500 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhEUWIn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 18:08:43 -0400
Received: by mail-ej1-f45.google.com with SMTP id z12so31099108ejw.0;
        Fri, 21 May 2021 15:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nAZ3ctVppRd1U/MccQN84z1G3WIdv4u58Ovt2vtZEtA=;
        b=HxeueTVh07FS/rPlaXpGAgh2YxU9bSqjViSbbVI5pE1QLFNrOBkkg0Y2TRTXDDL6+t
         phvK9K+419Y/7bstTBIR0+g900muoHdY7txT6mr1C7w7x+QbcIzj5cgx+/cXWfDA/+TH
         1x3zAio6vbEDQe9of75AWPffqqArM2zmJmn973OIatiWj2Oc3BUTpPDuJtN3HK0ZJkHe
         Jq4SuRcAXnM79MUGIDJDyjxJxcF9INBzPHs6LBP5MaEi1A2TDBwXo3gmsrl132hPxKnd
         WZwHMZPRuIUD4wwuag28b775UURJMka1P1WJjm9Anz4THiSWL2qnVktD4eo6GvA+ewOk
         3wgA==
X-Gm-Message-State: AOAM532qgjkvVXEk5H9L8FpCn0IsOctiF/qsS0wwZblk1DANZYbFF8Fx
        eP0Jr9fC/PuvLmi8CH3J6baIQgCVG61MgXpYntQ5+zf1u3c=
X-Google-Smtp-Source: ABdhPJxfnkKSzl5c7G/ekRtzAyy56ToLCT78WZHq6eht9dQb75JoSrmqsLa3qTaej9oOikziIMLlT6wvXS0CxElQhXU=
X-Received: by 2002:a17:907:33d4:: with SMTP id zk20mr12157139ejb.330.1621634838469;
 Fri, 21 May 2021 15:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com> <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com> <87r1i06ow2.fsf@oldenburg.str.redhat.com>
 <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com> <87k0nraonu.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87k0nraonu.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 May 2021 18:07:07 -0400
Message-ID: <CAJvTdK=A64DQXjYkZgPebWb-V_p_HAM+jTZRLTyi1qrP9kucMg@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 3:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, May 21 2021 at 09:31, Andy Lutomirski wrote:
> > arch_prctl(SET_XSTATE_INIT_ON_FIRST_USE, TILE_STUFF);?
> >
> > As long as this is allowed to fail, I don’t have a huge problem with
> > it.
>
> I'm fine with that. It's still controlled by the OS and can return
> -EPERM.
>
> If allowed then the application would also accept to be insta killed if
> that #NM allocation fails. Any bug report vs. that will be ignored.

Regarding pre-allocation vs on-demand allocation, consider two scenarios:

1. Synchronous.  At process or thread start up time, prctl()
synchronously allocates 8K context switch buffers.  Return code is 0
-- good go go!  10 seconds later the program decides to create
additional threads.  Woops. vmalloc failed, and the process
synchronously dies.  bug filed.

2. On demand.  Same scenario, except vmalloc failure upon creation of
those additional threads sends a SIGSEGV at the instruction where AMX
is touched.  bug filed.

Why ignore the 2nd bug and not ignore the 1st bug?

My concern about synchronous allocation is that it will be very easy
to abuse.  programs and threads can ask for buffers they will never
use.  With on-demand allocation, we allocate buffers only if they are
actually needed.

Len Brown, Intel Open Source Technology Center
