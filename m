Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF1238D1AC
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 00:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEUWsH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 18:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhEUWsH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 18:48:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EF0C061574;
        Fri, 21 May 2021 15:46:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621637201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7AL4eSbRRfrL2LByAtHmtcseyv6XL+hFBItU0efUNQY=;
        b=I7CGp5jnm8P1BsHpSC9A82tZ3cuS3c9nPvbb7LdqxvoMbVWcz5wJpDMo2A+fDOcZ8QcY4b
        n9HP0ua0JyAKKM6hLbphS1de1YALzyaLxqsXZHJ5S8NOUIjN6ZNP5yl+dDWswpCI/gRLPB
        oHKKobhOfYSodeCz7pCb81vRHnu32PyMqZbtb7zaGGebzeUzKI1L61jToCn7g7zf1eYzx6
        IjbAHBLQdmXik4BMhHZyHU+uhRcFpora5hYqzjjpZy5svPICI9XQmMVB+Z4lDvi7TrPQ/f
        1qPfBiTzmCDny0lMIDXEV32j3lQ/gDT9sNHi9hNr12sECZUfAA7Oux5DzZlo/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621637201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7AL4eSbRRfrL2LByAtHmtcseyv6XL+hFBItU0efUNQY=;
        b=HdOFBijiOOwEnDK506NEIaS/5VjPIOMEcDj018BpkIeJ+ZK+37B1sjpxz7F+15xHPXrx8+
        wM3bXyBYBeOsVuDg==
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <CAJvTdK=A64DQXjYkZgPebWb-V_p_HAM+jTZRLTyi1qrP9kucMg@mail.gmail.com>
References: <20210415044258.GA6318@zn.tnic> <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic>
 <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic>
 <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de>
 <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de>
 <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
 <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com>
 <87r1i06ow2.fsf@oldenburg.str.redhat.com>
 <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com>
 <87k0nraonu.ffs@nanos.tec.linutronix.de>
 <CAJvTdK=A64DQXjYkZgPebWb-V_p_HAM+jTZRLTyi1qrP9kucMg@mail.gmail.com>
Date:   Sat, 22 May 2021 00:46:41 +0200
Message-ID: <878s47aeni.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21 2021 at 18:07, Len Brown wrote:
> On Fri, May 21, 2021 at 3:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> Regarding pre-allocation vs on-demand allocation, consider two scenarios:
>
> 1. Synchronous.  At process or thread start up time, prctl()
> synchronously allocates 8K context switch buffers.  Return code is 0
> -- good go go!  10 seconds later the program decides to create
> additional threads.  Woops. vmalloc failed, and the process
> synchronously dies.  bug filed.

No. pthread_create() will fail with -ENOMEM. A return value of
-ENOMEM is not a bug. 

If the application fails to check the error code then it's not the
kernels problem and not a kernel bug either.

> 2. On demand.  Same scenario, except vmalloc failure upon creation of
> those additional threads sends a SIGSEGV at the instruction where AMX
> is touched.  bug filed.
>
> Why ignore the 2nd bug and not ignore the 1st bug?

See above.

> My concern about synchronous allocation is that it will be very easy
> to abuse.  programs and threads can ask for buffers they will never
> use.  With on-demand allocation, we allocate buffers only if they are
> actually needed.

Programs ask for memory in various ways. The buffer is not any different
than any other memory allocation of the application/thread. It's
accounted for and when the limits are reached the allocation fails.

But it fails in a way which can be acted upon at the application level
and not in a way where the kernel has no other choice than killing the
whole process.

So where is the problem? 

Thanks,

        tglx
