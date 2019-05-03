Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C727C133BE
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfECSx0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 14:53:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfECSx0 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 3 May 2019 14:53:26 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5B11205C9;
        Fri,  3 May 2019 18:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556909605;
        bh=TiML5h68eCpPCsuKHOOtspOVUAt7F/lUZRVTKNtdYKk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=zTAqsvPBmAjJPKl2Twmxd/X3iXa1QxWtxdwjAdaqr5RZlorGkZfRQtR7AHJM9pa4l
         x7IKH/SoqjFsFoqyOwyjImYs1tVVIoR2v+aum4ZKpC1pCYrZq5sM/GsLO0IfdUNjqL
         XK/2UL18lmUgwuBMXZv7msMWms0ilOeWx+9I53/s=
Subject: Re: [PATCH for 5.2 00/12] Restartable Sequences selftests updates
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
From:   shuah <shuah@kernel.org>
Message-ID: <68a135d7-7b30-71c7-c570-c7608d6f75d5@kernel.org>
Date:   Fri, 3 May 2019 12:53:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <678952111.699.1556908562445.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 5/3/19 12:36 PM, Mathieu Desnoyers wrote:
> ----- On Apr 29, 2019, at 11:27 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
> 
>> Those rseq selftests updates are hereby submitted to Shuah Khan,
>> maintainer of kernel selftests, for the next merge window (5.2).
>>
>> They change the per-architecture pre-abort signatures to ensure those
>> are valid trap instructions.
>>
>> The way exit points are presented to debuggers is enhanced, ensuring
>> all exit points are present, so debuggers don't have to disassemble
>> rseq critical section to properly skip over them.
>>
>> Discussions with the glibc community is reaching a concensus of exposing
>> a __rseq_handled symbol from glibc to coexist with rseq early adopters.
>> Update the rseq selftest code to expose and use this symbol.
>>
>> Support for compiling asm goto with clang is added with the
>> "-no-integrated-as" compiler switch, similarly to the toplevel kernel
>> Makefile.
> 
> Hi Shuah,
> 
> Is there anything else you need before you can pick up those patches ?
> 

I was going to say "no more work needed" and noticed that the series has
checkpatch errors and warns as I was running the series through
pre-commit tests.

Patches 1,2,3,8 have errors/warns based
on quick look at the log.


ERROR: need consistent spacing around '%' (ctx:WxV)
#227: FILE: tools/testing/selftests/rseq/rseq-x86.h:104:
+		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), %l[error1])


Will you be able to fix them and resend?

thanks,
-- Shuah
