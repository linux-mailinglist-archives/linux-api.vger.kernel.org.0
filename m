Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74023B8489
	for <lists+linux-api@lfdr.de>; Wed, 30 Jun 2021 15:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhF3OB2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Jun 2021 10:01:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:33469 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234935AbhF3OAq (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Jun 2021 10:00:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="188729655"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="188729655"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 06:55:54 -0700
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="641716350"
Received: from vkodithy-mobl.amr.corp.intel.com (HELO [10.209.94.253]) ([10.209.94.253])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 06:55:53 -0700
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
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
From:   Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <0978e79c-33ad-c05b-3897-99334c381396@linux.intel.com>
Date:   Wed, 30 Jun 2021 06:55:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84be3cfd-e825-ae75-bbae-2bbd3360daa7@metux.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/30/2021 5:22 AM, Enrico Weigelt, metux IT consult wrote:
>>
>> AMX will be shown as enabled in the hardware, but trap into the kernel
>> on first use.  The kernel developers prefer a model where it is checked
>> that the process has previously enabled the feature explicitly, instead
>> relying on lazy initialization as part of the trap (as intended by the
>> hardware design).  This means that the usual CPUID/XCR0 approach (which
>> is reflected in the glibc feature) will not work.
> 
> Ah, now I'm beginning to get it:
> 
> * this feature needs to be initialized first, before it can be used
> * on first use (when not initialized yet), it traps into the kernel
> * we don't want to always initialize it at boot
> 
> Correct ?

not really, the init is PER PROCESS

and then there is a per thread 8Kb state allocation that needs to be context switched/etc
once you actually use AMX.

> 
> What I'm wondering: why shall the process explicitly ask for it and
> why isn't the initialization be done either on bootup or on first use ?

the kernel needs to be able to say "no" in a graceful way, there are several scenarios
(from the sysadmin wanting to manage power/performance/resources to outright compatibility where
the kernel wants or needs to say "no". Most obvious example: if a process asked for an sigaltstack,
we can't let the process use AMX since that stack will be too small most likely to hold
the stackframe)

If you do this on "first use of the instruction" there is no graceful way to say "no".

