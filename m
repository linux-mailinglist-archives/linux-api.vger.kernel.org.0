Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41020FBE
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 22:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfEPUtC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 16:49:02 -0400
Received: from mail.efficios.com ([167.114.142.138]:35978 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfEPUtC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 16:49:02 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F240EADBAA;
        Thu, 16 May 2019 16:49:00 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id vzaCwoTpeqOF; Thu, 16 May 2019 16:49:00 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 7C23AADB9D;
        Thu, 16 May 2019 16:49:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 7C23AADB9D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1558039740;
        bh=T6tB5oucUJQiYwUQy00a3W/PHRzwk7hwAhqOqcUpxQU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=loAapQuhGsDymqQYkp3fr522T6o689kXMDM78TPzkykDOIfQFimq7bB4OSHLjEwbq
         j5dFVwWlNXFaUrhNRdjC5L3q7YMEkklz3uBoLHmSPb8S8Se8qP3FfEh0fTKbBq7T0W
         1VGChKEtSFW/D5harJ6CZNu71CXXqpa3tU/1S+YHuaoPNTEbnbMjvAqdVHdyQNN2tc
         LY4AjQSF/uAlHlc4Y4MD7rsC0YoXvnI26c9uYZmvKo2Uxv2AAUHhGGOzdFv37BR2pa
         FeT2EdktJoraiNlmQC/9ZDbLeHHVC6lxCPPZdnPh8G/6TjBUdw1/sRPFUCZJf0ekUX
         A4Jr4pUJhRnZg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 6_bTRsBCf0uv; Thu, 16 May 2019 16:49:00 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5B469ADB8A;
        Thu, 16 May 2019 16:49:00 -0400 (EDT)
Date:   Thu, 16 May 2019 16:49:00 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     shuah <shuah@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        schwidefsky <schwidefsky@de.ibm.com>
Message-ID: <1150133970.2996.1558039740182.JavaMail.zimbra@efficios.com>
In-Reply-To: <ae4bdd65-d7ab-6bb8-f823-c22e320b4f64@kernel.org>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com> <20190429152803.7719-8-mathieu.desnoyers@efficios.com> <ae4bdd65-d7ab-6bb8-f823-c22e320b4f64@kernel.org>
Subject: Re: [PATCH for 5.2 07/12] rseq/selftests: s390: use trap4 for
 RSEQ_SIG
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: s390: use trap4 for RSEQ_SIG
Thread-Index: MQQxEXkQJjNJ2KoXle2eK6CTH9qBYg==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 16, 2019, at 4:39 PM, shuah shuah@kernel.org wrote:

> Hi Mathieu,
> 
> On 4/29/19 9:27 AM, Mathieu Desnoyers wrote:
>> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> 
>> Use trap4 as the guard instruction for the restartable sequence abort
>> handler.
>> 
>> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>   tools/testing/selftests/rseq/rseq-s390.h | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>> 
>> diff --git a/tools/testing/selftests/rseq/rseq-s390.h
>> b/tools/testing/selftests/rseq/rseq-s390.h
>> index 7c4f3a70b6c7..1d05c5187ae6 100644
>> --- a/tools/testing/selftests/rseq/rseq-s390.h
>> +++ b/tools/testing/selftests/rseq/rseq-s390.h
>> @@ -1,6 +1,13 @@
>>   /* SPDX-License-Identifier: LGPL-2.1 OR MIT */
>>   
>> -#define RSEQ_SIG	0x53053053
>> +/*
>> + * RSEQ_SIG uses the trap4 instruction. As Linux does not make use of the
>> + * access-register mode nor the linkage stack this instruction will always
>> + * cause a special-operation exception (the trap-enabled bit in the DUCT
>> + * is and will stay 0). The instruction pattern is
>> + *	b2 ff 0f ff	trap4   4095(%r0)
>> + */
>> +#define RSEQ_SIG	0xB2FF0FFF
>>   
>>   #define rseq_smp_mb()	__asm__ __volatile__ ("bcr 15,0" ::: "memory")
>>   #define rseq_smp_rmb()	rseq_smp_mb()
>> 
> 
> I generated my pull request for Linus and did a sanity check and ran
> into merge conflict on this patch. Looks like this is already in
> Linus's tree.
> 
> Can you confirm!
> 
> I have to drop this patch and regenerate my pull request. Can you
> confirm!

I confirm, it went through the s390 maintainer tree, here is the
upstream commit already in Linus' master:

commit e24e4712efad737ca09ff299276737331cd021d9
Author: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date:   Wed Apr 10 12:28:41 2019 +0200

    s390/rseq: use trap4 for RSEQ_SIG
    
    Use trap4 as the guard instruction for the restartable sequence abort
    handler.
    
    Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

So you can either drop it from your end of the pull request, or Linus will
deal with the merge, as you prefer.

Thanks!

Mathieu


> 
> thanks,
> -- Shuah

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
