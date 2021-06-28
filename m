Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C069F3B5C52
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhF1KRb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 06:17:31 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbhF1KRa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 06:17:30 -0400
Received: from [192.168.1.155] ([77.9.21.236]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mq33i-1lTPOc2NxS-00nDbm; Mon, 28 Jun 2021 12:14:08 +0200
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
To:     Len Brown <lenb@kernel.org>, Florian Weimer <fweimer@redhat.com>
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
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <93e3b500-5992-a674-18e6-445d1db7b1f0@metux.net>
Date:   Mon, 28 Jun 2021 12:14:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAJvTdKkBTD62GTi=GW0+y0_1qc2JxfpfkNbXKWniWWOEmZZmUw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:lSyi4PgVQ1Q3XMSWurC8SV8Bg+7YTr6EDcg0xFwZhAa7CdyqBwo
 y2/PQTszne3zHE2CsHWbDrsqI1aT0Fw+n02sncfcu7QcpMZEty6ObhDerSaUl0s9CfeDbEW
 J2Bc+/nkZppt5TRvJoWV34h+G8u5LaqhHPfRNRzz2bOHkBKsxApDfFYKNkE0YoY/tRdKYbV
 1Bg7WvHflG+7NRsPIiLEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:g8YuvF7/MfU=:oBD29W2LKejICBROVCUpSA
 zT5DGff/UY7BI0cMzJmmJP24/uK3IfbR5+WZcqyOE+1SzEs48igl1vOzV78iqfe5pROsVrCTb
 j6TfKvTeZJ+UY8fHM4x2USvej2b449ydTYG1/TAu1uEgBLINXfla7hDQfeZh6CTuQhObNUyWE
 P/p6kobIV17khYQcJOHrk1ZDl5J1WmPwJFyB38AbfoSBV0JtLyuik7Vy8gRDDNhdNgK/Mj6s1
 /G/ySKHQyVfeq8P77klUuIbY3PkxmUqkeHxXtDsVKEvQD3jdtiL2OLrLhiUJhTka7cadkvRb5
 kuzoKaHgc8Fy+7u8klD2h+oG0X4FAfEsKS94cdfKSZ00xUvGFK5tpmAs/l/Mf1s+QL64daG0Y
 Ei6+vAoZlmcLH5bNg6k5rO4ZsUJHAlfbr+Ip/4w0gJyJChAoBybjtVcaSUAW4cJ+giK0CRc4Z
 ub49WhLJ4YbDE6XtcmdKZhpq/NZ1k/TWlaEQLo2Ur8/v12gy4EcrvxaAizThD0tvBcm4ZKgAU
 J366UcY8EfYz9wf+mQr1ok=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 24.06.21 01:11, Len Brown wrote:
>>    x86 CPU features detection for applications (and AMX)
>>    <https://lore.kernel.org/linux-api/87tulo39ms.fsf@oldenburg.str.redhat.com/>
> 
> FWIW, I didn't receive it, because you excluded
> 
> linux-kernel@vger.kernel.org

me neither :(

Maybe just repost it to LKML ?

You mention the interface *was* designed with cpu features remaining
constant over a process' lifetime. Between the line I'm reading that
this might not be the case anymore.

How could that happen ? Process migration on a different CPU (or perhaps
on a different host) ?

This is gonna be tricky, because this somehow needs to be synchronized
with the application (even if we check the bits before calling some
cpu-specific opcode, which also has some performance cost), there's
still some window where the application might not yet recognize the
change. So either we need some explicit migration points (where app
tells, please let me finish this func first) or transparent emulation.

Damn, how could the cpu designers come up with such weird concepts
in the first place ? :o


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
