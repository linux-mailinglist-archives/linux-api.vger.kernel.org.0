Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BB3B8210
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 14:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhF3MZ6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 08:25:58 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:38141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbhF3MZ4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 08:25:56 -0400
Received: from [192.168.1.155] ([95.114.41.241]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N32y5-1lDavc0pPJ-013NAg; Wed, 30 Jun 2021 14:22:25 +0200
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
References: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic>
 <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de>
 <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de>
 <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
 <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net>
 <87wnqkzklg.fsf@oldenburg.str.redhat.com>
 <CAJvTdKkBTD62GTi=GW0+y0_1qc2JxfpfkNbXKWniWWOEmZZmUw@mail.gmail.com>
 <93e3b500-5992-a674-18e6-445d1db7b1f0@metux.net>
 <87tulirw5y.fsf@oldenburg.str.redhat.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <84be3cfd-e825-ae75-bbae-2bbd3360daa7@metux.net>
Date:   Wed, 30 Jun 2021 14:22:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87tulirw5y.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q2U/DcR2uXXOT58TGV2LIz3pJ8OLY9I37s4vT0/dVUwgCKhSjsf
 KYd2aYms5Zpap97FBe6nT+tHZBX0rdHUeAmuroeYKWhpdLnPSg20ovCsEtfHxH3yvfO2akA
 6IEGuKsTn7vCPjiS/CaUW9rHOn5Tyc8okqBmMtYp9W3rvpI0lUK85IeHaY8bIqEL76SGxcL
 KSyLmTNnm+cREhdsyYGwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:onLzaRAUw2E=:yBvf4GrOjtQU3Zd1gPxOZe
 WF18O8QhVUF99xgPW6Qi7v6Ck57Rzi3JE0RyaQ8MgL2CgYyOSsgbc+HuNmNUucVZHBE8vWa7i
 5HRRUrPbLYj3cyyxsKf1NqR5hp/w4VDVhlc34TGmfEv5h/Qm38Sl2vfdn9R8S163fHU/o82Mx
 APt077WXhT2GLiqXuEi8ItLbZ+lMxQBugyKQ0G/kjEO0QPXsleeMaKsE22Z0gHiJC8PIe7ypz
 TQXeFwJyJtiqBu3H8i3h2A4RILnZPy2PS0dhmVnQ5aC0/Hgs2pHYRI6ndP5hW9bBztR0fp2LZ
 4ZLtFwQ9FDPnghcE1O+AabGTyrDD2nGIJTkeX3/secev9gu8BoMhfLL2sGTHRySarXTIHT16B
 +IWoenWGM68b9WAXs+ZBxOVJlv29Ob48ZtInD87UbLi7zQBMHOceSshrFV1gjaRyToznG4Vbq
 1Mqbwo3vSem/G4eQte70kt5jj0Na+uSEEsIbKcUS7dcXDhi5kDPZdHMItkvKZzIYHciRLRrOW
 678r35EWj9WTIbiy/PWf60fLBxeMg5p6jCJgYjkGlaaeYiWfnePkVfmoKjtfCY55NpBg+G4MF
 mfTHOpc/9BKWm8eUMcumYIOukeR4xELptwCeSCeVawjtts6bz52MBdVf7kydjVb+me9h/cpF7
 E8MSgM8ckm5tYE5A26iLNetZRgP9b4xsP5gZ+jMofUCOPG59sAaeaBKcocJl8nbHg7kGR6B77
 tSjhGlngwhZMzPlPpe83863FPvhcNFAlvigX4TZ2v+GsA7OPkSODzac9yc4GCFiXzp1QIiihD
 4tcEBk0esoTtXFZFesGbIhwGp6xJLA4ievwBB4dMW7XG9aqV6R7hFQRuqGNj30sXCKt5QAT
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 28.06.21 14:49, Florian Weimer wrote:
> * Enrico Weigelt:
> 
>> On 24.06.21 01:11, Len Brown wrote:
>>>>     x86 CPU features detection for applications (and AMX)
>>>>     <https://lore.kernel.org/linux-api/87tulo39ms.fsf@oldenburg.str.redhat.com/>
>>> FWIW, I didn't receive it, because you excluded
>>> linux-kernel@vger.kernel.org
>>
>> me neither :(
>>
>> Maybe just repost it to LKML ?
> 
> Isn't it sufficient to start Cc:ing the list?

Well, in that case people probably missed the original mail.
(maybe, I'm too lazy for searching the web for archives ... :P)

>> You mention the interface *was* designed with cpu features remaining
>> constant over a process' lifetime. Between the line I'm reading that
>> this might not be the case anymore.
>>
>> How could that happen ? Process migration on a different CPU (or perhaps
>> on a different host) ?
> 
> AMX will be shown as enabled in the hardware, but trap into the kernel
> on first use.  The kernel developers prefer a model where it is checked
> that the process has previously enabled the feature explicitly, instead
> relying on lazy initialization as part of the trap (as intended by the
> hardware design).  This means that the usual CPUID/XCR0 approach (which
> is reflected in the glibc feature) will not work.

Ah, now I'm beginning to get it:

* this feature needs to be initialized first, before it can be used
* on first use (when not initialized yet), it traps into the kernel
* we don't want to always initialize it at boot

Correct ?

What I'm wondering: why shall the process explicitly ask for it and
why isn't the initialization be done either on bootup or on first use ?

>> Damn, how could the cpu designers come up with such weird concepts
>> in the first place ? :o
> 
> It's not the CPU designers. The CPU behaves according to the old model.
> (I consider the old model a success, despite all the challenges, but not
> everyone agrees, obviosly.)

I'm still claiming already this old model is a horrible misdesign and
(most of) the extensions made over the decades are anything but well
designed - there had been many changes to do it much, much better.
For example there would have been ways to introduce new opcodes in a way
that they can be easily emulated in kernel or userland, w/o going
through a full trap.

But that's gonna be a long discussion on its own, probably getting
offtopic here.


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
