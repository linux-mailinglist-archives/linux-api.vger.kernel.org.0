Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11A472E16E
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 17:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfE2PpN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 11:45:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:46590 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfE2PpM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 11:45:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5C5E520E810;
        Wed, 29 May 2019 11:45:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 06Uex-ntIi6b; Wed, 29 May 2019 11:45:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C762520E80B;
        Wed, 29 May 2019 11:45:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C762520E80B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1559144710;
        bh=Z8u/h+OkjMEmjPJ6ylYRgvClv2UsRwp41k4WjCc8j/0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=ViqyNnKao9tEaN867vuBuAYQVDaw826E1hgVaz5U8GY9XZRZMApV6dp8PUcC6qnsk
         +o0dC6tPNyGGjG9x7qDHmlwtk9GKPP63jK+XJnsXXuFG+lfXTtIurAuphyL2PEC1si
         rlWL8eJyrWq7eEPcITpC1O0xGLROp+sH+thw7gWpGNbfCgalOVbzJAfyN7ZASz72ZB
         kP1lFDRCvpiVRQUNaIdpKo4dODwQcVR1bV/sdBoUJQ/mU2SlAzHIT5Vyf1qPKMUiqm
         llCSbpGVtnQyqYP0bIKpxpLiQVlFrQGpJbFImbtRhvJbcNQXU+cBUnm7YAFgVWsYLw
         S0TzC/XTwigbw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id D_tNcsrx8C2x; Wed, 29 May 2019 11:45:10 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id AA0FE20E7FE;
        Wed, 29 May 2019 11:45:10 -0400 (EDT)
Date:   Wed, 29 May 2019 11:45:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <140718133.18261.1559144710554.JavaMail.zimbra@efficios.com>
In-Reply-To: <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com>
References: <20190503184219.19266-1-mathieu.desnoyers@efficios.com> <20190503184219.19266-2-mathieu.desnoyers@efficios.com> <87h89gjgaf.fsf@oldenburg2.str.redhat.com> <1239705947.14878.1558985272873.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v10)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3803 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v10)
Thread-Index: 18yTu+T8PFt4cXiNhOg61XhmaTl3EWs0GkO7
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On May 27, 2019, at 3:27 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On May 27, 2019, at 7:19 AM, Florian Weimer fweimer@redhat.com wrote:
> 

[...]

>> 
>> Furthermore, the reference to ELF constructors is misleading.  I believe
>> the code you added to __libc_start_main to initialize __rseq_handled and
>> register __seq_abi with the kernel runs *after* ELF constructors have
>> executed (and not at all if the main program is written in Go, alas).
>> All initialization activity for the shared case needs to happen in
>> elf/rtld.c or called from there, probably as part of the security
>> initialization code or thereabouts.
> 
> in elf/rtld.c:dl_main() we have the following code:
> 
>  /* We do not initialize any of the TLS functionality unless any of the
>     initial modules uses TLS.  This makes dynamic loading of modules with
>     TLS impossible, but to support it requires either eagerly doing setup
>     now or lazily doing it later.  Doing it now makes us incompatible with
>     an old kernel that can't perform TLS_INIT_TP, even if no TLS is ever
>     used.  Trying to do it lazily is too hairy to try when there could be
>     multiple threads (from a non-TLS-using libpthread).  */
>  bool was_tls_init_tp_called = tls_init_tp_called;
>  if (tcbp == NULL)
>    tcbp = init_tls ();
> 
> If I understand your point correctly, I should move the rseq_init() and
> rseq_register_current_thread() for the SHARED case just after this
> initialization, otherwise calling those from LIBC_START_MAIN() is too
> late and it runs after initial modules constructors (or not at all for
> Go). However, this means glibc will start using TLS internally. I'm
> concerned that this is not quite in line with the above comment which
> states that TLS is not initialized if no initial modules use TLS.
> 
> For the !SHARED use-case, if my understanding is correct, I should keep
> rseq_init() and rseq_register_current_thread() calls within LIBC_START_MAIN().

I've moved the rseq initialization for SHARED case to the very end of
elf/rtld.c:init_tls(), and get the following error on make check:

Generating locale am_ET.UTF-8: this might take a while...
Inconsistency detected by ld.so: get-dynamic-info.h: 143: elf_get_dynamic_info: Assertion `info[DT_FLAGS] == NULL || (info[DT_FLAGS]->d_un.d_val & ~DF_BIND_NOW) == 0' failed!
Charmap: "UTF-8" Inputfile: "am_ET" Outputdir: "am_ET.UTF-8" failed
/bin/sh: 4: cannot create /home/efficios/git/glibc-build/localedata/am_ET.UTF-8/LC_CTYPE.test-result: Directory nonexistent

This error goes away if I comment out the call to rseq_register_current_thread (),
which touches the __rseq_abi __thread variable and issues a system call.

Currently, the __rseq_abi __thread variable is within
sysdeps/unix/sysv/linux/rseq-sym.c, which is added to the
sysdep_routines within sysdeps/unix/sysv/linux/Makefile. I
suspect it may need to be moved elsewhere.

Any thoughts on how to solve this ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
