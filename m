Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210EA1BAF74
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 22:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgD0U1j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 16:27:39 -0400
Received: from mail.efficios.com ([167.114.26.124]:46638 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgD0U1j (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 16:27:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0C69325D7FA;
        Mon, 27 Apr 2020 16:27:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zpJz7Q7A6GVa; Mon, 27 Apr 2020 16:27:37 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B71DB25DD91;
        Mon, 27 Apr 2020 16:27:37 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B71DB25DD91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588019257;
        bh=iQGZNhQE4d0xrSqlbr6eWjSmtSNujZgcs81rb84xW6E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mfty3xKf3nu2USKAtDeqd3+9emnR6p4RFXFttDr0/JbNPJyKlQu1kviz4T1Xy+Lmu
         Ohj0fIHuJeOpkyRFf0di8t6r5azHT5b6IGbfaW84OFmYwHqg7T2554GyVG22R1TnlH
         +isP1dQRAQzHlPUcQjmVb7tZCF6vZtS7Ufjrvbl61R/9ceO2l6mgEP80d9qTBUFosm
         CDapR7iTZOyafGHNz+AHuNCtY80UavNKoRHaRopxTeyEEbCT8SZES0Jrjgyq3Fibhd
         oEcCEmfan7RKcY90Q3FWduJIvgOieeK1LtnBiP/T7wGhtNQH9szmDp3B7K93vytZ+j
         VR+bjXJ7TrOVw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q_MBrq2xLTdb; Mon, 27 Apr 2020 16:27:37 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A03B825DCBF;
        Mon, 27 Apr 2020 16:27:37 -0400 (EDT)
Date:   Mon, 27 Apr 2020 16:27:37 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Rich Felker <dalias@libc.org>,
        linux-api <linux-api@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ben Maurer <bmaurer@fb.com>, Dave Watson <davejwatson@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul <paulmck@linux.vnet.ibm.com>, Paul Turner <pjt@google.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Message-ID: <122741024.71528.1588019257574.JavaMail.zimbra@efficios.com>
In-Reply-To: <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <20200326155633.18236-6-mathieu.desnoyers@efficios.com> <87ees9z417.fsf@mid.deneb.enyo.de> <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com> <87zhawvphv.fsf@mid.deneb.enyo.de> <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: NB5tGkGbwSwj6uwD4kCQxwPloIWw0/vi9NhR
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 27, 2020, at 1:26 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:
[...]
>>> We don't mind that user-space uses that pointer, but we never want the kernel
>>> to touch that pointer rather than the 32/64-bit-aware fields. One possibility
>>> would be to do:
>>>
>>>     union
>>>       {
>>>         uint64_t ptr64;
>>> #ifdef __LP64__
>>>         uint64_t ptr;
>>> #else
>>>         struct
>>>           {
>>> #if (defined (__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined
>>> (__BIG_ENDIAN)
>>>             uint32_t padding; /* Initialized to zero.  */
>>>             uint32_t ptr32;
>>> #else /* LITTLE */
>>>             uint32_t ptr32;
>>>             uint32_t padding; /* Initialized to zero.  */
>>> #endif /* ENDIAN */
>>>           } ptr;
>>> #endif
>>>
>>> #ifndef __KERNEL__
>>>      const struct rseq_cs *uptr;
>>> #endif
>>>       } rseq_cs;
>>>
>>> in the union, so only user-space can see that field. Thoughts ?
>> 
>> I think this depends on where the x32 question lands.
> 
> x32 should not be an issue as explained above, so I'm very open to
> add this "uptr" for user-space only.

Actually, the snippet above is broken on 32-bit. It needs to be:

    union
      {
        uint64_t ptr64;
#ifdef __LP64__
        uint64_t ptr;
# ifndef __KERNEL__
        const struct rseq_cs *uptr;
# endif
#else   
        struct
          {
#if (defined (__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined (__BIG_ENDIAN)
            uint32_t padding; /* Initialized to zero.  */
            uint32_t ptr32;
#else /* LITTLE */
            uint32_t ptr32;
            uint32_t padding; /* Initialized to zero.  */
#endif /* ENDIAN */
          } ptr;
# ifndef __KERNEL__
        struct
          {
#  if (defined (__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined (__BIG_ENDIAN)
            uint32_t padding; /* Initialized to zero.  */
            const struct rseq_cs *uptr32;
#  else /* LITTLE */
            const struct rseq_cs *uptr32;
            uint32_t padding; /* Initialized to zero.  */
#  endif /* ENDIAN */
          } uptr;
# endif
#endif
      } rseq_cs;

I'll leave this out of the patchset for now as we'd need more feedback on its
usefulness.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
