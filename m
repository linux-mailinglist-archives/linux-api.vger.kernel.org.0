Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2F03B863A
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 17:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbhF3P2l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 11:28:41 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45803 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbhF3P2j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Jun 2021 11:28:39 -0400
Received: from [192.168.1.155] ([95.114.41.241]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBll6-1m48P33CTE-00CCjm; Wed, 30 Jun 2021 17:25:17 +0200
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
To:     Arjan van de Ven <arjan@linux.intel.com>,
        Florian Weimer <fweimer@redhat.com>
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
 <84be3cfd-e825-ae75-bbae-2bbd3360daa7@metux.net>
 <0978e79c-33ad-c05b-3897-99334c381396@linux.intel.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <b97d754a-6173-0f7e-6e10-c3b6b7b67b54@metux.net>
Date:   Wed, 30 Jun 2021 17:25:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <0978e79c-33ad-c05b-3897-99334c381396@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N2k6KoSHPHqYv9ijq9iUuhi+ucELLluWy0O7PLPYB3WQfn9oYSF
 76ZkwrRfzkmmIqMMqfI+I1KspSG9WrWGBzUpIPsEm8WrBilyQ+lxz7LXzVcb4hkZJEGNTIJ
 jpdfrvpoopMjGH266l6Uuh1GW1yOWI0WqHDTQmKE2gKWWkOb6HaTmqgmoyjFl6BFlPtfoRJ
 iug6tmSHN1w5SyCcN926Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:38UN29YkGt8=:K5ic9j59y87A/7VdUJ7/hB
 TZK4Q2tEwRQ2BnedKghqj/JNdTrSPj7inZdlkhABTleusACua0O4EOn5VfBnv1AffGF2UUVwD
 QhYtWbTpu3c17peSMy+MtHyhu+sMqiJg9zPxhBLTIQOwvOiAedY/GeN42N4Pv333wBYf8+P1V
 87psoHJjXOuJUi4n1UTa298E2ZRxvKUS2V7MKUZVilr1q6beW+Dr+YV1a0b90e5Xg6VXo6LcO
 2AYy3AclJeTGNtMm/3Lwl8EOCofAl5o3PPOrqyJjjJD98G593+FXoUNqjBmyW2FpZ9TqC/SCc
 SX/PdzRfZsWK9qzkMeWtGEej89c+7ajhnOsToaOHV6VDWXgndWDFs3CZBY5F9i/Yz8hYayuae
 cuw7cDHmtrr006CZ5d3LEkVrMXu7XgiYcYr984RErdWfJh0gq5WdW8ti3ng7hfEzba0gzxhp6
 HJ0kHtBcojtaysGNWl9KUp270yUPPUTrCVI6SW2lQoMrr/Tnvt2Jw4y09H/Lqa3N4L3mTBo3y
 AjN5V611bSrBJ2iRao3E5atZLJnY1DJ1ZvsYJZJt6L6xPAaLajT2G0ScnNLnhGiBbcBVYj/l9
 gOpPfJ5ujvrR+WWV9uanPbo3GK9Fzuj1mIdcOvDti6vtP9yUtvf7DOvK/yjLKdp2DB97XnOeV
 XIiPbjn39ImsEdRz7P+Is/dqPklxpqk5bqbmJUwx9kqC4voZoav66yMoQo9VG7YF6cSeW5NFk
 Jss+X2DOTOQWuAN6syhtp0RX+QaaneXEY8aQQYZErpmcesDyD/BQS/oU1p6CogT8FdjcC83CL
 7AvOCZSjIjRr6thgLOjj1HN88HmzzI37OIJvOSHhw4bswExVNbFzr4LqyTXyxhnHj5DOErC
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 30.06.21 15:55, Arjan van de Ven wrote:

>> * this feature needs to be initialized first, before it can be used
>> * on first use (when not initialized yet), it traps into the kernel
>> * we don't want to always initialize it at boot
>>
>> Correct ?
> 
> not really, the init is PER PROCESS

IIRC there had been some discussion here whether it should be done per
thread. But now that I've learned that the major problem is saving the
register state, I wouldn't dare thinking about how a working per-thread
solution really would need to look like :o

(by the way: is sighandler stack per thread or per process ?)

> the kernel needs to be able to say "no" in a graceful way, there are 
> several scenarios
> (from the sysadmin wanting to manage power/performance/resources to 
> outright compatibility where
> the kernel wants or needs to say "no". Most obvious example: if a 
> process asked for an sigaltstack,
> we can't let the process use AMX since that stack will be too small most 
> likely to hold
> the stackframe)

Ah okay, when I wrote that mail, didn't know yet that so much state
needs to be saved.


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
