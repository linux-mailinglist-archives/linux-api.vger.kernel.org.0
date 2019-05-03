Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAAC135E4
	for <lists+linux-api@lfdr.de>; Sat,  4 May 2019 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfECW7P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 18:59:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfECW7P (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 3 May 2019 18:59:15 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F17582063F;
        Fri,  3 May 2019 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556924354;
        bh=c5BabGzNJmVs5Eqq6k6wAV9zIaA+Vxh6BthoEQ0ElZM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VoyRCsmrqpJYoF4RrkGGDv5/nxCkqf5nTa1ptWmSW8aUXnqqDGYB/uMi/ENac3z/E
         PwZQc2TaBfND+hC08Qh4ZLxlE7KyjzcvgVrRg58XoXAfeCHn8V+WZzuM8vBlO00H13
         9hHLdJp5jy69Yol1Nf6eqcfsKuLT2p7/hO+tyd5Q=
Subject: Re: [PATCH for 5.2 00/12] Restartable Sequences selftests updates
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
 <678952111.699.1556908562445.JavaMail.zimbra@efficios.com>
 <68a135d7-7b30-71c7-c570-c7608d6f75d5@kernel.org>
 <1137649333.995.1556911352713.JavaMail.zimbra@efficios.com>
From:   shuah <shuah@kernel.org>
Message-ID: <9aa2d6ca-5b42-5c4d-788d-d82dc0389eff@kernel.org>
Date:   Fri, 3 May 2019 16:59:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1137649333.995.1556911352713.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/3/19 1:22 PM, Mathieu Desnoyers wrote:
> ----- On May 3, 2019, at 2:53 PM, shuah shuah@kernel.org wrote:
> 
>> On 5/3/19 12:36 PM, Mathieu Desnoyers wrote:
>>> ----- On Apr 29, 2019, at 11:27 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:
>>>
>>>> Those rseq selftests updates are hereby submitted to Shuah Khan,
>>>> maintainer of kernel selftests, for the next merge window (5.2).
>>>>
>>>> They change the per-architecture pre-abort signatures to ensure those
>>>> are valid trap instructions.
>>>>
>>>> The way exit points are presented to debuggers is enhanced, ensuring
>>>> all exit points are present, so debuggers don't have to disassemble
>>>> rseq critical section to properly skip over them.
>>>>
>>>> Discussions with the glibc community is reaching a concensus of exposing
>>>> a __rseq_handled symbol from glibc to coexist with rseq early adopters.
>>>> Update the rseq selftest code to expose and use this symbol.
>>>>
>>>> Support for compiling asm goto with clang is added with the
>>>> "-no-integrated-as" compiler switch, similarly to the toplevel kernel
>>>> Makefile.
>>>
>>> Hi Shuah,
>>>
>>> Is there anything else you need before you can pick up those patches ?
>>>
>>
>> I was going to say "no more work needed" and noticed that the series has
>> checkpatch errors and warns as I was running the series through
>> pre-commit tests.
>>
>> Patches 1,2,3,8 have errors/warns based
>> on quick look at the log.
>>
>>
>> ERROR: need consistent spacing around '%' (ctx:WxV)
>> #227: FILE: tools/testing/selftests/rseq/rseq-x86.h:104:
>> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
>>
>>
>> Will you be able to fix them and resend?
> 
> (CCing the che checkpatch maintainers)
> 
> checkpatch appears to be wrong for these errors. I suspect it thinks those are
> '%' modulo operators (for which the style requires space before/after),
> but those are actually part of the asm input and goto target operands.
> 
> Most warnings are about some lines over 80 cols. However, the areas where
> this happens is due to following the style of already upstream code which
> has the final "\" at the end of line sometimes beyond 80 col to accommodate
> macros that take a bit of horizontal real estate.
> 
> For patch 8, the warning about "availble" being a typo is right. The
> style error about space after "asm (" is right as well. Should I send only
> this updated patch to you or should I send the whole patchset again ?
> 

No need to send all patches. This is good.

thanks,
-- Shuah
