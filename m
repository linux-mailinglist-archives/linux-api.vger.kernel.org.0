Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFE81BBE57
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 14:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgD1M4b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 08:56:31 -0400
Received: from mail.efficios.com ([167.114.26.124]:58448 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgD1M4a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 08:56:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8851627C857;
        Tue, 28 Apr 2020 08:56:29 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id yy07838jlHYR; Tue, 28 Apr 2020 08:56:29 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 31C7A27C771;
        Tue, 28 Apr 2020 08:56:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 31C7A27C771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1588078589;
        bh=wCLQaSXXFHWHOQTdzk9lhf8jXpkpRXiVjr4m5yXdZp0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=gHEORjTfvJt3R+b8gor73nsmxy3TUV2xG8onL/Drc9WtteeV9fk5x6oR3zGHRPBzz
         YPrCDh5F1+VvRK0MTyZCMvUQwtjNEWK8GckWqL3zSlUZOJ/NUMs+Rxe7QxFTuMASC8
         Vo7Mutoj7dKY3FZsVUdp5Abh73+xwtMymYKJp5N294AFcyYV3cCNtNSxp/hUH+e+ME
         LbKTM7upADUZuFbbEl5ngTM9uq5b3IvZ0uKkBOcv4hSHGuSM6yPBLKnk4s8qpO9Yck
         f1Ui1G+rzegttYk0Wv7fXppIA7vpafkfkqrGAD5XOQ0EaEtCDOgY0rfMIq4TdG12Vj
         YX97fNDldv/LQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FW4KC6PkGCbk; Tue, 28 Apr 2020 08:56:29 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1DD0B27C965;
        Tue, 28 Apr 2020 08:56:29 -0400 (EDT)
Date:   Tue, 28 Apr 2020 08:56:28 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        carlos <carlos@redhat.com>, Rich Felker <dalias@libc.org>,
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
Message-ID: <1862775654.72437.1588078588989.JavaMail.zimbra@efficios.com>
In-Reply-To: <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
References: <20200326155633.18236-1-mathieu.desnoyers@efficios.com> <20200326155633.18236-6-mathieu.desnoyers@efficios.com> <87ees9z417.fsf@mid.deneb.enyo.de> <284293396.70630.1588005648556.JavaMail.zimbra@efficios.com> <87zhawvphv.fsf@mid.deneb.enyo.de> <2102127737.70791.1588008377292.JavaMail.zimbra@efficios.com> <87ftcnrf7d.fsf@mid.deneb.enyo.de> <1080028389.72414.1588077193438.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH glibc 5/9] glibc: Perform rseq(2) registration at C
 startup and thread creation (v17)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF75 (Linux)/8.8.15_GA_3895)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v17)
Thread-Index: z7tk/3iPPlCh9cj1VVKnVHBj0mM1xIMs04Lw
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 28, 2020, at 8:33 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 28, 2020, at 8:02 AM, Florian Weimer fw@deneb.enyo.de wrote:
> 
[...]
>> 
>>> x32 should not be an issue as explained above, so I'm very open to
>>> add this "uptr" for user-space only.
>> 
>> Okay, then please use anonymous unions and structs as necessary, to
>> ensure that the uptr field can be reached on all platforms in the same
>> way.
> 
> OK, will do!

What I came up with looks like this. User-space can use rseq_cs.uptr.ptr
both on 32-bit and 64-bit to update the pointer:

    /* Restartable sequences rseq_cs field.

       Contains NULL when no critical section is active for the current
       thread, or holds a pointer to the currently active struct rseq_cs.

       Updated by user-space, which sets the address of the currently
       active rseq_cs at the beginning of assembly instruction sequence
       block, and set to NULL by the kernel when it restarts an assembly
       instruction sequence block, as well as when the kernel detects that
       it is preempting or delivering a signal outside of the range
       targeted by the rseq_cs.  Also needs to be set to NULL by user-space
       before reclaiming memory that contains the targeted struct rseq_cs.

       Read and set by the kernel.  Set by user-space with single-copy
       atomicity semantics.  This field should only be updated by the
       thread which registered this data structure.  Aligned on 64-bit.

       User-space may perform the update through the rseq_cs.uptr.ptr
       field.  The padding needs to be initialized to zero on 32-bit.  */
    union
      {
        uint64_t ptr64;
#ifdef __LP64__
        uint64_t ptr;
#else   
        struct
          {
# if (defined (__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined (__BIG_ENDIAN)
            uint32_t padding; /* Initialized to zero.  */
            uint32_t ptr32;
# else /* LITTLE */
            uint32_t ptr32;
            uint32_t padding; /* Initialized to zero.  */
# endif /* ENDIAN */
          } ptr;
#endif

#ifndef __KERNEL__
        struct
          {
# ifdef __LP64__
            const struct rseq_cs *ptr;
# else
#  if (defined (__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined (__BIG_ENDIAN)
            uint32_t padding; /* Initialized to zero.  */
            const struct rseq_cs *ptr;
#  else /* LITTLE */
            const struct rseq_cs *ptr;
            uint32_t padding; /* Initialized to zero.  */
#  endif /* ENDIAN */
# endif
          } uptr;
#endif
      } rseq_cs;

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
