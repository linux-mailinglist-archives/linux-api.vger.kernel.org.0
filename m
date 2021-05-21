Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDD938C386
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhEUJmx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 05:42:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhEUJms (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 05:42:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621590085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4VR+tP02SUkxZ3Obqm7E3T8T6SgRs31uiGemz9GjIEM=;
        b=wdsMqD7aDfb/bcx15h66hq52SHdiDFiFRtFTPt10HfD/gLWlX7kNse2OzmZYd8QHi5s3dC
        Iw9sbUjXMCycQhtcb4kgdKKPCez0JBrrXziZAur16aIlW+rUNwLYD3OgeHPE4EPIO8vgvz
        H3IOReWnWv6hVwjllPXbKEevN1fn5vJ2Ou6kbT0R9YHY4ClhGGEjW4NMaS07tcHNGJxyG+
        fcwQrEeQeA9HyXR3RDE6+0+rWcPfuJMBkDnFbo9hLugSoJqcDzd7i24qG/qgnt4me/819W
        5cbgcLdmYldXhokj6Cd53wQjd88RTG+nh6ZaOy3lZokdLrc5fQi+BH4KgW0Y0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621590085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4VR+tP02SUkxZ3Obqm7E3T8T6SgRs31uiGemz9GjIEM=;
        b=PAIhOIuTz8NxOqO3IeFDbtx1n5Qe0/OKAxMD5x3YztZ1HhxRNCliw/opR1cBPxt6ydCPLk
        iPf1VQCerXudxICA==
To:     Dave Hansen <dave.hansen@intel.com>, Len Brown <lenb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Willy Tarreau <w@1wt.eu>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae\, Chang Seok" <chang.seok.bae@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
In-Reply-To: <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu> <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com> <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com> <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com> <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com> <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com> <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com> <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com> <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com> <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
Date:   Fri, 21 May 2021 11:41:24 +0200
Message-ID: <87bl94bf0b.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dave, Len,

On Thu, May 20 2021 at 15:53, Dave Hansen wrote:
> On 5/20/21 2:41 PM, Len Brown wrote:
>> So the questions are:
>> 1. who calls it -- a call/thread or process?  the application?  a
>> library -- which library?
>> 2. is it optional, or mandatory?
>> 3. if it is mandatory, what is the best way to enforce it?
>> 4. should we have a "release" system call too?
>> 
>> 1. Every thread needs a context switch buffer.  Does every thread make
>> the system call?  It seems sort of awkward for a library to always
>> make a system call before doing a TMUL.  It would be functionally
>> harmless, but it would add latency to an otherwise low-latency
>> operation.  If some central library does it, and caches that it has
>> done it before, then it would be ugly, but at least it would remove an
>> unnecessary user/kernel transition.
>
> Our system calls are *REALLY* fast.  We can even do a vsyscall for this
> if we want to get the overhead down near zero.  Userspace can also cache
> the "I did the prctl()" state in thread-local storage if it wants to
> avoid the syscall.

Correct.

>> 2. If it is optional, then v5 is code complete -- because it allows
>> you to allocate either explicitly via prtcl, or transparently via #NM.
>
> It needs to be mandatory.  If it's not, then nobody will use it, and
> they'll suffer the dreaded SIGSEGV-on-vmalloc()-failure and start filing
> bug reports.

Yes. Plus mandatory allows to do access control. IOW the prctl() can
return EPERM.

>> 3. If it is mandatory, then we should re-purpose the XFD mechanism:
>> app starts with XFD armed, by default
>> if app touches AMX before prctl, it takes a signal (and dies).

Yes.

>> When app calls prctl, allocate buffer disarm XFD for that app (exactly
>> what #NM trap does today).
>
> Yes, that sounds like a good use of XFD.

Agreed.

>> 4. I don't see a justification for a release concept, but it is
>> possible -- though sort of sticky with possible nested calls from
>> combinations of apps and libraries.  If that were sorted out by a
>> central library, then the actual system call on the last release per
>> thread would re-arm XFD to prevent access until the next explicit
>> request.  Unclear if it is important that the kernel actually do the
>> free -- some things might run faster if we keep it around...
>
> I think would be more of a get/put model rather than an allocate/free model.
>
> The "put" could effectively be a noop for now.

Yes.

> But, if we don't put this in the ABI up front, we can't add it later.
> That means that we could never add a lazy-free, even if we wanted to.

As I said somewhere in that thread, something like:

       prctl(PR_QUERY_XSTATE_FEATURES,....
       prctl(PR_ENABLE_XSTATE_FEATURES,....
       prctl(PR_DISABLE_XSTATE_FEATURES,....

To make this work you need refcounting and the last put (DISABLE) drops
the buffer and re-arms XFD. But of course an application/library can do
the put late if it knows that it's going to use it over and over.

Thanks,

        tglx
