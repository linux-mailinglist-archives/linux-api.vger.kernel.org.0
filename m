Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC7B133A1
	for <lists+linux-api@lfdr.de>; Fri,  3 May 2019 20:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbfECSgF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 May 2019 14:36:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:46420 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfECSgF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 May 2019 14:36:05 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 641C71DD78A;
        Fri,  3 May 2019 14:36:03 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id JJEe9UUBIbrN; Fri,  3 May 2019 14:36:02 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B88B11DD779;
        Fri,  3 May 2019 14:36:02 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B88B11DD779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556908562;
        bh=lCKVxMU3qGBGUPt68WuIIx9ADpMi0+hIh0FPjZb4IXg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bS3Q7c6yNlPv4L7OQgGylnEROtWVTOidXlR3RIgdSE/xJH57jNPcY7/aGaihqaO5k
         NI3B2YZzMpWOpnlqVXx9fng3Qh9GrbfLXoElln6emRbQxLF1yb+hOw1a6YM0EVv2HK
         CGSqoG3TTGF6hWn01bCjTDslNR5Ukjsvi8hGYtsIu/NzbxvZfJnfNy6MS0pt0Z5Eyj
         LhhYBJXcA+PeKZ/gIxi5RgJmwRz3MAZzI0JR0/bgqAE/oFbkfGv34ypz2RJEHzTulj
         xfaeOQmBqFt12h4W0vcc1GlvwKb5wDEjRtTanDqvrZiENFIjAF+ZFw1Af5AQeGOpbO
         Y6Nu8QjizJx4g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Dvbx8kLUtBVk; Fri,  3 May 2019 14:36:02 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 966701DD771;
        Fri,  3 May 2019 14:36:02 -0400 (EDT)
Date:   Fri, 3 May 2019 14:36:02 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     shuah <shuah@kernel.org>
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
Message-ID: <678952111.699.1556908562445.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH for 5.2 00/12] Restartable Sequences selftests updates
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: Restartable Sequences selftests updates
Thread-Index: 0ENCky/Ret7tFVO1wxVX5kIhz+XlIw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Apr 29, 2019, at 11:27 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Those rseq selftests updates are hereby submitted to Shuah Khan,
> maintainer of kernel selftests, for the next merge window (5.2).
> 
> They change the per-architecture pre-abort signatures to ensure those
> are valid trap instructions.
> 
> The way exit points are presented to debuggers is enhanced, ensuring
> all exit points are present, so debuggers don't have to disassemble
> rseq critical section to properly skip over them.
> 
> Discussions with the glibc community is reaching a concensus of exposing
> a __rseq_handled symbol from glibc to coexist with rseq early adopters.
> Update the rseq selftest code to expose and use this symbol.
> 
> Support for compiling asm goto with clang is added with the
> "-no-integrated-as" compiler switch, similarly to the toplevel kernel
> Makefile.

Hi Shuah,

Is there anything else you need before you can pick up those patches ?

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> Martin Schwidefsky (1):
>  rseq/selftests: s390: use trap4 for RSEQ_SIG
> 
> Mathieu Desnoyers (11):
>  rseq/selftests: x86: Work-around bogus gcc-8 optimisation
>  rseq/selftests: Add __rseq_exit_point_array section for debuggers
>  rseq/selftests: Introduce __rseq_cs_ptr_array, rename __rseq_table to
>    __rseq_cs
>  rseq/selftests: Use __rseq_handled symbol to coexist with glibc
>  rseq/selftests: s390: use jg instruction for jumps outside of the asm
>  rseq/selftests: x86: use ud1 instruction as RSEQ_SIG opcode
>  rseq/selftests: arm: use udf instruction for RSEQ_SIG
>  rseq/selftests: aarch64 code signature: handle big-endian environment
>  rseq/selftests: powerpc code signature: generate valid instructions
>  rseq/selftests: mips: use break instruction for RSEQ_SIG
>  rseq/selftests: add -no-integrated-as for clang
> 
> tools/testing/selftests/rseq/Makefile     |   8 +-
> tools/testing/selftests/rseq/rseq-arm.h   | 132 +++++++++++++--
> tools/testing/selftests/rseq/rseq-arm64.h |  74 ++++++++-
> tools/testing/selftests/rseq/rseq-mips.h  | 115 +++++++++++--
> tools/testing/selftests/rseq/rseq-ppc.h   |  90 +++++++++-
> tools/testing/selftests/rseq/rseq-s390.h  |  78 ++++++++-
> tools/testing/selftests/rseq/rseq-x86.h   | 264 +++++++++++++++++++++---------
> tools/testing/selftests/rseq/rseq.c       |  55 ++++++-
> tools/testing/selftests/rseq/rseq.h       |   1 +
> 9 files changed, 688 insertions(+), 129 deletions(-)
> 
> --
> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
