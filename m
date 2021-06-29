Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC7B3B6BE8
	for <lists+linux-api@lfdr.de>; Tue, 29 Jun 2021 03:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhF2BHm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 21:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhF2BHm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 21:07:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA30FC061574;
        Mon, 28 Jun 2021 18:05:14 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c15so9945276pls.13;
        Mon, 28 Jun 2021 18:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XyjrBBqKuXXp7P2ZwUMXqg1MVFp6okeVGxa9hWFm7S4=;
        b=YudMmojcl8EcewHCVOzKzNOaZCv8gvxxc3MVxhmsJqbE2V35ct/dB50dD9ikE2uWBW
         2oIVsGMgPM65c5eBHS98Qdq6LrDLLdhVS8vwZ8EOlseIgbflPKy3c9hx84xV7FdsHANw
         FQbxlMJMQAtlMTfaNbguanJZBqIjpV/Q7CNIfP2+RFCbE2NEua6eLX7/AmlrfaEdXhTm
         pMFnhEif4H4JY16mgSAQJhy/3by1wtxsgWTPHMUnqVbZI2m0vQYVwMFQkv0B+GPLrMkr
         P2oTfMwPpk6H/dYuqe5kItNUqNX7IlajS8Q7ETyajHUJCOZQJNswp/CiNXtSJDdSevqP
         8USg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XyjrBBqKuXXp7P2ZwUMXqg1MVFp6okeVGxa9hWFm7S4=;
        b=rHB6AUA4DH1Q/x+ShKZN5yv4QcMEEtkDpD23MgLNZUU59kLO++QP544oeB+FU70xDD
         70oedYTOPxt23uOoclkdyhUZpRPlF38J05lSZqDbLlIKdjTM2Xz3gn1XgTeP/JrdBaRz
         rIPM828GtKMSKkh3WUGMhfa4stbTJvlgMcir1s3wnsPEcFf3tXWnrDVDfHAn6HEi0u+t
         zADwFNZBXI8Y11ZKxI5s2BZW7nLL5wNsi+wG5hcfVLtmSSIyWa2rLHtL9VpBYiHFE0sS
         Z9bm9iI9/p/75pvzPU8e4af5PfQkcmXivKOihoUCRNmlk4Hc6CHAUacfCCKzq+OmMo7U
         wt5A==
X-Gm-Message-State: AOAM532T6k3snwT1jWcg134pTQ1qqjSrjWXBvTGzC6Kv04mGx7G3ou7u
        Ke+SDymzMp+ygxFs1NBe0lY=
X-Google-Smtp-Source: ABdhPJz9JhMtSK+wELOy3wDFTu9TB5p9rlWUIqAdu55+YzzGIp/JMq+7UD8w+nOlM7ikBH5UzG2m6Q==
X-Received: by 2002:a17:90a:390d:: with SMTP id y13mr40019491pjb.133.1624928713891;
        Mon, 28 Jun 2021 18:05:13 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id w21sm1669030pge.30.2021.06.28.18.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 18:05:13 -0700 (PDT)
Date:   Mon, 28 Jun 2021 18:01:43 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YNpw92ji12g9+W3D@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
 <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
 <CAG48ez1d3abHEekh_fYoXdAe85RG+c--G7sEyMYhiKEsns3uog@mail.gmail.com>
 <87o8bpyhsw.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o8bpyhsw.fsf@disp2133>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 28, 2021 at 01:18:07PM -0500, Eric W. Biederman wrote:
> Jann Horn <jannh@google.com> writes:
> 
> > On Mon, Jun 28, 2021 at 6:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> >> On Mon, Jun 28, 2021, at 9:13 AM, Jann Horn wrote:
> >> > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> >> > > This change introduces the new system call:
> >> > > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
> >> > >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)
> >> > >
> >> > > process_vm_exec allows to execute the current process in an address
> >> > > space of another process.
> >> > [...]
> >> >
> >> > I still think that this whole API is fundamentally the wrong approach
> >> > because it tries to shoehorn multiple usecases with different
> >> > requirements into a single API. But that aside:
> >> >
> >> > > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> >> > > +{
> >> > > +       struct task_struct *tsk = current;
> >> > > +       struct mm_struct *active_mm;
> >> > > +
> >> > > +       task_lock(tsk);
> >> > > +       /* Hold off tlb flush IPIs while switching mm's */
> >> > > +       local_irq_disable();
> >> > > +
> >> > > +       sync_mm_rss(prev_mm);
> >> > > +
> >> > > +       vmacache_flush(tsk);
> >> > > +
> >> > > +       active_mm = tsk->active_mm;
> >> > > +       if (active_mm != target_mm) {
> >> > > +               mmgrab(target_mm);
> >> > > +               tsk->active_mm = target_mm;
> >> > > +       }
> >> > > +       tsk->mm = target_mm;
> >> >
> >> > I'm pretty sure you're not currently allowed to overwrite the ->mm
> >> > pointer of a userspace thread. For example, zap_threads() assumes that
> >> > all threads running under a process have the same ->mm. (And if you're
> >> > fiddling with ->mm stuff, you should probably CC linux-mm@.)
> >>
> >> exec_mmap() does it, so it can’t be entirely impossible.
> >
> > Yeah, true, execve can do it - I guess the thing that makes that
> > special is that it's running after de_thread(), so it's guaranteed to
> > be single-threaded?
> 
> Even the implementation detail of swapping the mm aside.  Even the idea
> of swaping the mm is completely broken, as an endless system calls
> depend upon the state held in task_struct.  io_uring just tried running
> system calls of a process in a different context and we ultimately had
> to make the threads part of the original process to make enough things
> work to keep the problem tractable.
> 
> System calls deeply and fundamentally depend on task_struct and
> signal_struct.

In opposite to io_uring, process_vm_exec doesn't intend to run system
calls in the context of the target process. We initially declare that
system calls are executed in the context of the current process with
just another mm. If we are talking about user-mode kernels, they will
need just two system calls: mmap and munmap. In case of CRIU, vmsplice
will be used too.

> 
> I can think of two possibilities.
> 1) Hijack and existing process thread.
> 2) Inject a new thread into an existing process.

I am not sure that I understand what you mean here, but it sounds like
we will need to do a context switch to execute anything in a context
of a hijacked thread. If I am right, it kills the main idea of
process_vm_exec. If I misunderstand your idea, maybe you can describe it
with more details.

Thanks,
Andrei
