Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58C22144310
	for <lists+linux-api@lfdr.de>; Tue, 21 Jan 2020 18:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgAURVP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 Jan 2020 12:21:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43513 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgAURVP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 Jan 2020 12:21:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so3273139oif.10
        for <linux-api@vger.kernel.org>; Tue, 21 Jan 2020 09:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q5QgG9WnPTL3nteIJEXmB0Es5EWve1SbvFBsjUgPlKU=;
        b=Hqck99IjyucVajmKBNg5n6iwdy1Ba0Mz2Hv7kvqwVGnr1C5wiqxxGa6DCxk+QAHJMw
         cXceKiYFoYrkDPegt/RiLyqFE5RrUbXQmskCI624CSUZwIkdsYeR7ozgCXW/2NkqjUky
         zg5KXfgHjVYYDDWNfVZ+wcouy7tJQ8JJJ4ATWB9qwFy0TrYv28pZxxpkNpETf5xjLwjF
         k+H6lk6iR3rq1X88xVaAVMLnUBS2zqYVoBub6hlkuDBppV1PkIgYMt+ELbbvNGUory2d
         sR/mOkrzrP4IaEbwArJZYpYycJ7S5WK2drEdwQXGv8OQlFmyEPsHKxNi7GI/RXlpY2/f
         mSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q5QgG9WnPTL3nteIJEXmB0Es5EWve1SbvFBsjUgPlKU=;
        b=ikRXAq6+PbZJvXqMGrqUU3U/u1OdxfiXO/J6ZQTR3rcX+VIeuXJ3mPXovAbEWNDrsm
         fKSsaBTwSGa0BBAaTJqKTJsr2gl7e2UHTRkCKhvJNc7aE3XN0sXcCK2m3nIXFUKw9GT5
         P5qzXxBxZth1eVpcN0hRzw7QYps3T5yDmcbLp+yVkjaW6xopvRMicu+DkykyNn1JDrg6
         hmZh580GntUamY6/YYL2nECgv/5Vu5P38KBa4wzIFizTYZ7xD+Dx3DQUyXv0+/MH0fwx
         ddpXRvHY52hXgobGR+AvtTC9IEdQRmVuJ0eQo4LSTJXwj9Pwsw/PPHucCMpyqbzNX5ah
         yWIw==
X-Gm-Message-State: APjAAAV4N10WZVBgNc7WReWIdTWDe3wJpDmwcVc6a4oKRgOBhPAOx50X
        QG513QLVSpD8W0TpaNfpPJ6JWAQOtRupRsvuk8CKbA==
X-Google-Smtp-Source: APXvYqy/cHUnTgqn2AvhCUymfYtPS40fUfd4xCVnC3WQvi+Po8Vm5Fie2sP6ED7bhcqYTLpTOVe/2NqjYrJ36UAvcqo=
X-Received: by 2002:aca:4a08:: with SMTP id x8mr3813040oia.39.1579627274088;
 Tue, 21 Jan 2020 09:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20200121160312.26545-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20200121160312.26545-1-mathieu.desnoyers@efficios.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 21 Jan 2020 18:20:47 +0100
Message-ID: <CAG48ez2bQdoT9y7HkyU06DTazysUDdPdJe+gyV-NxgQA7JWQVQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system call
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Will Deacon <will.deacon@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 21, 2020 at 5:13 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> There is an important use-case which is not possible with the
> "rseq" (Restartable Sequences) system call, which was left as
> future work.
>
> That use-case is to modify user-space per-cpu data structures
> belonging to specific CPUs which may be brought offline and
> online again by CPU hotplug. This can be used by memory
> allocators to migrate free memory pools when CPUs are brought
> offline, or by ring buffer consumers to target specific per-CPU
> buffers, even when CPUs are brought offline.
>
> A few rather complex prior attempts were made to solve this.
> Those were based on in-kernel interpreters (cpu_opv, do_on_cpu).
> That complexity was generally frowned upon, even by their author.
>
> This patch fulfills this use-case in a refreshingly simple way:
> it introduces a "pin_on_cpu" system call, which allows user-space
> threads to pin themselves on a specific CPU (which needs to be
> present in the thread's allowed cpu mask), and then clear this
> pinned state.
[...]
> For instance, this allows implementing this userspace library API
> for incrementing a per-cpu counter for a specific cpu number
> received as parameter:
>
> static inline __attribute__((always_inline))
> int percpu_addv(intptr_t *v, intptr_t count, int cpu)
> {
>         int ret;
>
>         ret = rseq_addv(v, count, cpu);
> check:
>         if (rseq_unlikely(ret)) {
>                 pin_on_cpu_set(cpu);
>                 ret = rseq_addv(v, count, percpu_current_cpu());
>                 pin_on_cpu_clear();
>                 goto check;
>         }
>         return 0;
> }

What does userspace have to do if the set of allowed CPUs switches all
the time? For example, on Android, if you first open Chrome and then
look at its allowed CPUs, Chrome is allowed to use all CPU cores
because it's running in the foreground:

walleye:/ # ps -AZ | grep 'android.chrome$'
u:r:untrusted_app:s0:c145,c256,c512,c768 u0_a145 7845 805 1474472
197868 SyS_epoll_wait f09c0194 S com.android.chrome
walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
/proc/7845/status
3:cpuset:/top-app
Cpus_allowed_list: 0-7

But if you then switch to the home screen, the application is moved
into a different cgroup, and is restricted to two CPU cores:

walleye:/ # grep cpuset /proc/7845/cgroup; grep Cpus_allowed_list
/proc/7845/status
3:cpuset:/background
Cpus_allowed_list: 0-1

At the same time, I also wonder whether it is a good idea to allow
userspace to stay active on a CPU even after the task has been told to
move to another CPU core - that's probably not exactly a big deal, but
seems suboptimal to me.


I'm wondering whether it might be possible to rework this mechanism
such that, instead of moving the current task onto a target CPU, it
prevents all *other* threads of the current process from running on
that CPU (either entirely or in user mode). That might be the easiest
way to take care of issues like CPU hotplugging and changing cpusets
all at once? The only potential issue I see with that approach would
be that you wouldn't be able to use it for inter-process
communication; and I have no idea whether this would be good or bad
performance-wise.
