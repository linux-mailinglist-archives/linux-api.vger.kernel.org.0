Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39329133F9
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 21:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbfECTWf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 15:22:35 -0400
Received: from mail.efficios.com ([167.114.142.138]:59300 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfECTWf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 May 2019 15:22:35 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6E86D1DEA36;
        Fri,  3 May 2019 15:22:33 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 0QuwNrTwQwAY; Fri,  3 May 2019 15:22:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id E9E7F1DEA14;
        Fri,  3 May 2019 15:22:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E9E7F1DEA14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556911353;
        bh=Z1fXbode9z//U9geZ8RU9W20aXBHSnu7pA0JsyOME6U=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oJyLWiZAFwoLwOGgE/MF/ve5CmfrvgRQC3357sjT/Lu+vyPLa4t5XIFPcail2khfE
         FPuWIFxcT7lRWMYv1LTCAsgWVuzmLi901E1sH/a7YNODtduZGFcJkVqK00NTgq7ysG
         5CwtUVbbufy8KEkLSUDax3NDMfTMs3EDN0FZ7eYqFPptZHAqgfpqIPc9yeH6c7rXq9
         wHCqgo/7rpLRpgzH6Z+/+VHw/as3wcOATZg/1kAMGmfJx9gEUP5814jnH8UdYq5Xy4
         TnPppbgf75vEsavaCGv8GON7R+4IMK5Du7x+4XpbQGztic6wZNUAej7vjHmdVy3Cgv
         xmltnO/50PLkw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id zcPuURcV7p-X; Fri,  3 May 2019 15:22:32 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C98851DEA0E;
        Fri,  3 May 2019 15:22:32 -0400 (EDT)
Date:   Fri, 3 May 2019 15:22:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     shuah <shuah@kernel.org>, Andy Whitcroft <apw@canonical.com>,
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
        Joel Fernandes <joelaf@google.com>
Message-ID: <1137649333.995.1556911352713.JavaMail.zimbra@efficios.com>
In-Reply-To: <68a135d7-7b30-71c7-c570-c7608d6f75d5@kernel.org>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com> <678952111.699.1556908562445.JavaMail.zimbra@efficios.com> <68a135d7-7b30-71c7-c570-c7608d6f75d5@kernel.org>
Subject: Re: [PATCH for 5.2 00/12] Restartable Sequences selftests updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: Restartable Sequences selftests updates
Thread-Index: nivK8tFeBpLkZ4PuzE/4yflaEoxB+w==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 3, 2019, at 2:53 PM, shuah shuah@kernel.org wrote:

> On 5/3/19 12:36 PM, Mathieu Desnoyers wrote:
>> ----- On Apr 29, 2019, at 11:27 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>>> Those rseq selftests updates are hereby submitted to Shuah Khan,
>>> maintainer of kernel selftests, for the next merge window (5.2).
>>>
>>> They change the per-architecture pre-abort signatures to ensure those
>>> are valid trap instructions.
>>>
>>> The way exit points are presented to debuggers is enhanced, ensuring
>>> all exit points are present, so debuggers don't have to disassemble
>>> rseq critical section to properly skip over them.
>>>
>>> Discussions with the glibc community is reaching a concensus of exposing
>>> a __rseq_handled symbol from glibc to coexist with rseq early adopters.
>>> Update the rseq selftest code to expose and use this symbol.
>>>
>>> Support for compiling asm goto with clang is added with the
>>> "-no-integrated-as" compiler switch, similarly to the toplevel kernel
>>> Makefile.
>> 
>> Hi Shuah,
>> 
>> Is there anything else you need before you can pick up those patches ?
>> 
> 
> I was going to say "no more work needed" and noticed that the series has
> checkpatch errors and warns as I was running the series through
> pre-commit tests.
> 
> Patches 1,2,3,8 have errors/warns based
> on quick look at the log.
> 
> 
> ERROR: need consistent spacing around '%' (ctx:WxV)
> #227: FILE: tools/testing/selftests/rseq/rseq-x86.h:104:
> +		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])
> 
> 
> Will you be able to fix them and resend?

(CCing the che checkpatch maintainers)

checkpatch appears to be wrong for these errors. I suspect it thinks those are
'%' modulo operators (for which the style requires space before/after),
but those are actually part of the asm input and goto target operands.

Most warnings are about some lines over 80 cols. However, the areas where
this happens is due to following the style of already upstream code which
has the final "\" at the end of line sometimes beyond 80 col to accommodate
macros that take a bit of horizontal real estate.

For patch 8, the warning about "availble" being a typo is right. The
style error about space after "asm (" is right as well. Should I send only
this updated patch to you or should I send the whole patchset again ?

Thanks,

Mathieu


> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
