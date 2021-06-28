Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3AA3B5E65
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 14:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhF1MwW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 08:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232613AbhF1MwV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 08:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624884595;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZABl8+/jSYKEfqNOsXCGd5RJxa5cymEYoO5X3GXetQ=;
        b=AkOU7CjxKUonBW9WLfFw48IimB/hsFGSS8lw1Pd/8aSE+FlX8MNn0Dw1SVLKgJiwM74NWz
        Py/MDoXgpLGqiiJnm4XggZxsWGuStbdgpHTyCfhphuGHSo9IncQXiESM1BpGsOt9COn0Cd
        uaXJc63QCUhjmdGPYplZ321fRqL/74o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-jlX5duZyP96xeKiwgKFjpQ-1; Mon, 28 Jun 2021 08:49:54 -0400
X-MC-Unique: jlX5duZyP96xeKiwgKFjpQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF90D802C80;
        Mon, 28 Jun 2021 12:49:51 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-228.ams2.redhat.com [10.36.112.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 504D418AAB;
        Mon, 28 Jun 2021 12:49:46 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Len Brown <lenb@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
References: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
        <YIMmwhEr46VPAZa4@zn.tnic>
        <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
        <874kf11yoz.ffs@nanos.tec.linutronix.de>
        <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
        <87k0ntazyn.ffs@nanos.tec.linutronix.de>
        <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
        <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
        <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
        <87pmxk87th.fsf@oldenburg.str.redhat.com>
        <YKfIct+DhpEBbaCQ@hirez.programming.kicks-ass.net>
        <87wnqkzklg.fsf@oldenburg.str.redhat.com>
        <CAJvTdKkBTD62GTi=GW0+y0_1qc2JxfpfkNbXKWniWWOEmZZmUw@mail.gmail.com>
        <93e3b500-5992-a674-18e6-445d1db7b1f0@metux.net>
Date:   Mon, 28 Jun 2021 14:49:45 +0200
In-Reply-To: <93e3b500-5992-a674-18e6-445d1db7b1f0@metux.net> (Enrico
        Weigelt's message of "Mon, 28 Jun 2021 12:14:02 +0200")
Message-ID: <87tulirw5y.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Enrico Weigelt:

> On 24.06.21 01:11, Len Brown wrote:
>>>    x86 CPU features detection for applications (and AMX)
>>>    <https://lore.kernel.org/linux-api/87tulo39ms.fsf@oldenburg.str.redhat.com/>
>> FWIW, I didn't receive it, because you excluded
>> linux-kernel@vger.kernel.org
>
> me neither :(
>
> Maybe just repost it to LKML ?

Isn't it sufficient to start Cc:ing the list?

> You mention the interface *was* designed with cpu features remaining
> constant over a process' lifetime. Between the line I'm reading that
> this might not be the case anymore.
>
> How could that happen ? Process migration on a different CPU (or perhaps
> on a different host) ?

AMX will be shown as enabled in the hardware, but trap into the kernel
on first use.  The kernel developers prefer a model where it is checked
that the process has previously enabled the feature explicitly, instead
relying on lazy initialization as part of the trap (as intended by the
hardware design).  This means that the usual CPUID/XCR0 approach (which
is reflected in the glibc feature) will not work.

Now it turns out that we can still support this in glibc because of the
pointer indirection, but only if the kernel provides a bit we can read
in thread-specific data.

> Damn, how could the cpu designers come up with such weird concepts
> in the first place ? :o

It's not the CPU designers. The CPU behaves according to the old model.
(I consider the old model a success, despite all the challenges, but not
everyone agrees, obviosly.)

Thanks,
Florian

