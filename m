Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2016F25B8EA
	for <lists+linux-api@lfdr.de>; Thu,  3 Sep 2020 04:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgICCx0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Sep 2020 22:53:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:55151 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICCx0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 Sep 2020 22:53:26 -0400
IronPort-SDR: ctOvyHwD8IgpnkqdBTl3uOFfO8uA5EO9DQWRg1ZcFCLK0ApJpWMc6YjkOff4djrvruji+I3aLi
 nj0zvuqGyXwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="145203420"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="145203420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 19:53:25 -0700
IronPort-SDR: t+asyXuyfQSdPcnN23eLVIdO6o2QclIPFgTU1IGQt07uvHsMCCASuOZPLNnqwD9DPcUyoXp/aI
 zPYgRW+/WdRA==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; 
   d="scan'208";a="446740721"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.147.104]) ([10.209.147.104])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2020 19:53:23 -0700
Subject: Re: [PATCH v11 6/9] x86/cet: Add PTRACE interface for CET
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Jann Horn <jannh@google.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
References: <9be5356c-ec51-4541-89e5-05a1727a09a8@intel.com>
 <A7775E11-8837-4727-921A-C88566FA01AF@amacapital.net>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <46e42e5e-0bca-5f3f-efc9-5ab15827cc0b@intel.com>
Date:   Wed, 2 Sep 2020 19:53:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <A7775E11-8837-4727-921A-C88566FA01AF@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/2/2020 4:50 PM, Andy Lutomirski wrote:
> 
> 
>> On Sep 2, 2020, at 3:13 PM, Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>>
>> ﻿On 9/2/2020 1:03 PM, Jann Horn wrote:
>>>> On Tue, Aug 25, 2020 at 2:30 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>>> Add REGSET_CET64/REGSET_CET32 to get/set CET MSRs:
>>>>
>>>>      IA32_U_CET (user-mode CET settings) and
>>>>      IA32_PL3_SSP (user-mode Shadow Stack)
>>> [...]
>>>> diff --git a/arch/x86/kernel/fpu/regset.c b/arch/x86/kernel/fpu/regset.c
>>> [...]
>>>> +int cetregs_get(struct task_struct *target, const struct user_regset *regset,
>>>> +               struct membuf to)
>>>> +{
>>>> +       struct fpu *fpu = &target->thread.fpu;
>>>> +       struct cet_user_state *cetregs;
>>>> +
>>>> +       if (!boot_cpu_has(X86_FEATURE_SHSTK))
>>>> +               return -ENODEV;
>>>> +
>>>> +       fpu__prepare_read(fpu);
>>>> +       cetregs = get_xsave_addr(&fpu->state.xsave, XFEATURE_CET_USER);
>>>> +       if (!cetregs)
>>>> +               return -EFAULT;
>>> Can this branch ever be hit without a kernel bug? If yes, I think
>>> -EFAULT is probably a weird error code to choose here. If no, this
>>> should probably use WARN_ON(). Same thing in cetregs_set().
>>
>> When a thread is not CET-enabled, its CET state does not exist.  I looked at EFAULT, and it means "Bad address".  Maybe this can be ENODEV, which means "No such device"?
>>
>> [...]
>>
>>>> @@ -1284,6 +1293,13 @@ static struct user_regset x86_32_regsets[] __ro_after_init = {
>>> [...]
>>>> +       [REGSET_CET32] = {
>>>> +               .core_note_type = NT_X86_CET,
>>>> +               .n = sizeof(struct cet_user_state) / sizeof(u64),
>>>> +               .size = sizeof(u64), .align = sizeof(u64),
>>>> +               .active = cetregs_active, .regset_get = cetregs_get,
>>>> +               .set = cetregs_set
>>>> +       },
>>>>   };
>>> Why are there different identifiers for 32-bit CET and 64-bit CET when
>>> they operate on the same structs and have the same handlers? If
>>> there's a good reason for that, the commit message should probably
>>> point that out.
>>
>> Yes, the reason for two regsets is that fill_note_info() does not expect any holes in a regsets.  I will put this in the commit log.
>>
>>
> 
> Perhaps we could fix that instead?
> 

As long as we understand the root cause, leaving it as-is may be OK.

I had a patch in the past, but did not follow up on it.

https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/

Yu-cheng
