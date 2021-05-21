Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A9C38D204
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 01:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhEUXdP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 19:33:15 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:42845 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbhEUXdN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 19:33:13 -0400
Received: by mail-ej1-f46.google.com with SMTP id lg14so32730879ejb.9;
        Fri, 21 May 2021 16:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wV8Jn7oT1/R7b2roeYS63X9RldUmuefktohm7BDX3HU=;
        b=XxzDQ+N3/y6YmsPojl6IqtP0Tclfi00AlIYkS0WvbfwRaOTaDluTWbFYjGiTf52pF1
         zhsRwvK2tvFybmcHp9fEhn50IOxMfHYgM/MH1rWilrG5ukMzJReZ0ZCTyjfulf5pr8f2
         nLZBDOCC5qjdg/s/Mj3vOQqFwGg3cV/yQcNaAHYl2pBTaR3rP2LDxO7F7HDHm1hDwBek
         y0iCq3X4oidFHkp4w0x/s/Rre1kGSjRZNg+EGqjgNcgQzwZSZfN9FQgU4ZGoS1F3gwwY
         fICThoQUeYs1P95bpdWwP6jvySk2nlxxjjnlQ0Q2RSvHTbPIVAzo9WG9JBoNaW+0EVCQ
         Beeg==
X-Gm-Message-State: AOAM532oXhmap4JEika/qU04bqgNGtTjY5npRhVj2+8JjHwxJyCNXH0/
        uJ6/1qRTfTlrarp7iv81BfSb6diPUFDyN4dNL/8=
X-Google-Smtp-Source: ABdhPJz4C5ZOddqS3tbZaqexGV5+LYrWfAAC+etCAF9RcobtSRavqwUwpidy3DCbGV2yMd2mlkf/1V/4C40J4ZVhZ60=
X-Received: by 2002:a17:906:1dd1:: with SMTP id v17mr12370205ejh.31.1621639907917;
 Fri, 21 May 2021 16:31:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic> <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de> <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de> <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com> <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com> <87r1i06ow2.fsf@oldenburg.str.redhat.com>
 <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com> <87k0nraonu.ffs@nanos.tec.linutronix.de>
 <CAJvTdK=A64DQXjYkZgPebWb-V_p_HAM+jTZRLTyi1qrP9kucMg@mail.gmail.com> <878s47aeni.ffs@nanos.tec.linutronix.de>
In-Reply-To: <878s47aeni.ffs@nanos.tec.linutronix.de>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 21 May 2021 19:31:36 -0400
Message-ID: <CAJvTdK=Ws1QvBvdx50OSmAi0vBX49KZZHUoiMFbhUUEPmjGmBw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen via Libc-alpha <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>, Borislav Petkov <bp@alien8.de>,
        Keno Fischer <keno@juliacomputing.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

With this proposed API, we seem to be combining two requirements, and
I wonder if we should be treating them independently.

Requirement 1: "Fine grained control".  We want the kernel to be able
to prohibit a program from using AMX.  The foundation for this is a
system call that the kernel can say "No".  It may deny access for
whatever reason it wants, including inability to allocate a buffer, or
some TBD administer-invoked hook in the system call, say membership or
lack of membership of the process in an empowered cgroup.

Requirement 2: Ability to synchronously fail upon buffer allocation.
I agree that pthread_create() returning an error code is more friendly
way to kill a program rather than a SIGSEGV when touching AMX state
for the first time.  But the reality is, that program is almost
certainly going to exit either way.

So the 1st question is if the system call requesting permission should
be on a per-process basis, or a per-task basis.

A. per-task.  If we do it this way, then we will likely wind up
mandating a GET at the start of every routine in every library that
touches AMX, and potentially also a PUT.  This is because the library
has no idea what thread called it.  The plus is that this will address
the "used once and sits on a buffer for the rest of the process
lifetime' scenario.  The minus is that high performance users will be
executing thousands of unnecessary system calls that have zero value.

B. per-process.  If we do it this way, then the run time linker can do
a single system call on behalf of the entire process, and there is no
need to sprinkle system calls throughout the library.  Presumably the
startup code would query CPUID, query XCR0, query this system call,
and set a global variable to access by all threads going forward.  The
plus is that permission makes more sense on a process basis than on a
task basis.  Why would the kernel give one thread in a process
permission, and not another thread -- and if that happened, would a
process actually be able to figure out what to do?  If we do
per-process, I don't see that the PUT call would be useful, and I
would skip it.

Neither A or B has an advantage in the situation where a thread is
created long after initialization and faces memory allocation failure.
A synchronously fails in the new system call, and B synchronously
fails in pthread_create.

The 2nd question is if "successful permission" implies synchronous
allocation, or perhaps it allows "please enable on-demand dynamic
allocation"

X. Synchronous Allocation results in allocation failures returning a
synchronous error code, explaining why the program needs to exit.  The
downside is that it is likely that in both case A and B, every thread
in the program will allocate a buffer, if they ever use it or not.
Indeed, it is possible that the API we have invented to manage AMX
buffer use will actually *increase* AMX buffer use...
a
Y. Enable on-demand allocation.  Here the system call enables XFD to
not kill the process, but on first use to allocate a buffer for a
thread that is actually touching AMX.  The benefit is if you have a
program with many threads, only the ones that actually use AMX will
allocate buffers.  Of course the down side is that this program is
exposed to a SIGSEGV if vmalloc fails in that run-time allocation,
rather than a friendly pthread_create -1 return code killing the
program.

And, of course, we can have our cake and eat it too, by having a the
syscall tell the kernel if it wants (X) or (Y).  The question is if it
is worth the complexity of having two options.

thoughts?
-Len
