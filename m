Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02E1C0335
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 18:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgD3Qz5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 12:55:57 -0400
Received: from mail.efficios.com ([167.114.26.124]:49564 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3Qz4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Apr 2020 12:55:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7276B29019A;
        Thu, 30 Apr 2020 12:55:55 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R5cw2QtpS93e; Thu, 30 Apr 2020 12:55:55 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 23F64290199;
        Thu, 30 Apr 2020 12:55:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 23F64290199
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588265755;
        bh=Mp2N6YTybV9Yy+BQgTJKnPNXrZLjJEVr2GwPlCCPe5c=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=P6ml2Iwzx7dNVYFLxrkWSsVQThYw2dO3hAxklBIuoMnX1mQB+Y+TkBHjCIh/KOIiK
         9BF34ObzvD7EE0Hr81wiv7OtYPzdGzJXdgqrla23Pz5l57swsihELEvq3+YXRQClmD
         81+/l/Fs9ulbqJ73MQSBGcwOfmUe8AbfDdOMlfyXDnaSuFW047vhG9fsmbW+mLtMbc
         NtgKvA+1/SvxFlG9EBw4mryfTapc5isfKLWecPHz2sww9O0bRpma0OU09IM+lhT1/j
         ubLuTCXPy4/5jJfn2l/haVyrwneiGLCkA4es97pCEgtPeQk9956ziSJ7+Ktofw3NOA
         x0OenWRJfbIvw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GXJtEnICMaN0; Thu, 30 Apr 2020 12:55:55 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0F11629021D;
        Thu, 30 Apr 2020 12:55:55 -0400 (EDT)
Date:   Thu, 30 Apr 2020 12:55:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1972833271.77975.1588265754974.JavaMail.zimbra@efficios.com>
In-Reply-To: <878sidkk0z.fsf@oldenburg2.str.redhat.com>
References: <20200428171513.22926-1-mathieu.desnoyers@efficios.com> <875zdhmaft.fsf@oldenburg2.str.redhat.com> <1287616647.77866.1588263099045.JavaMail.zimbra@efficios.com> <878sidkk0z.fsf@oldenburg2.str.redhat.com>
Subject: Re: [RFC PATCH glibc 1/3] glibc: Perform rseq(2) registration at C
 startup and thread creation (v18)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v18)
Thread-Index: vkaNGJYbQ5to7FGk5na6JixiLNcPYQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 30, 2020, at 12:36 PM, Florian Weimer fweimer@redhat.com wrote:

> * Mathieu Desnoyers:
> 
[...]
> 
>>>> +  if (__rseq_abi.cpu_id == RSEQ_CPU_ID_REGISTRATION_FAILED)
>>>> +    return;
>>>> +  ret = INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
>>>> +                              0, RSEQ_SIG);
>>>> +  if (INTERNAL_SYSCALL_ERROR_P (ret) &&
>>>> +      INTERNAL_SYSCALL_ERRNO (ret) != EBUSY)
>>>> +    __rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
>>> 
>>> Sorry, I forgot: Please add a comment that the EBUSY error is ignored
>>> because registration may have already happened in a legacy library.
>>
>> Considering that we now disable signals across thread creation, and that
>> glibc's initialization happens before other libraries' constructors
>> (as far as I remember even before LD_PRELOADed library constructors),
>> in which scenario can we expect to have EBUSY here ?
> 
> That's a good point.
> 
>> Not setting __rseq_abi.cpu_id to RSEQ_CPU_ID_REGISTRATION_FAILED in case
>> of EBUSY is more a way to handle "unforeseen" scenarios where somehow the
>> registration would already be done. But I cannot find an "expected"
>> scenario which would lead to this now.
>>
>> So if EBUSY really is unexpected, how should we treat that ? I don't think
>> setting REGISTRATION_FAILED would be appropriate, because then it would
>> break assumption of the prior successful registration that have already
>> been done by this thread.
> 
> You could call __libc_fatal with an error message.  ENOSYS is definitely
> an expected error code here, and EPERM (and perhaps EACCES) can happen
> with seccomp filters.

If we go this way, I'd also recommend to treat any situation where
__rseq_abi.cpu_id is already initialized as a fatal error. Does the
code below seem OK to you ?

static inline void
rseq_register_current_thread (void)
{
  int ret;

  if (__rseq_abi.cpu_id != RSEQ_CPU_ID_UNINITIALIZED)
    __libc_fatal ("rseq already initialized for this thread\n");
  ret = INTERNAL_SYSCALL_CALL (rseq, &__rseq_abi, sizeof (struct rseq),
                              0, RSEQ_SIG);
  if (INTERNAL_SYSCALL_ERROR_P (ret))
    {
      if (INTERNAL_SYSCALL_ERRNO (ret) == EBUSY)
        __libc_fatal ("rseq already registered for this thread\n");
      __rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
    }
}

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
