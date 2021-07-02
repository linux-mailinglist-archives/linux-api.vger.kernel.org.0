Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B413B9C29
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbhGBG2W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 02:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbhGBG2W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 02:28:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9615C061762;
        Thu,  1 Jul 2021 23:25:49 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b1so5064375pls.5;
        Thu, 01 Jul 2021 23:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6gR7+oJ7XUI6MhB8zU2feJZoMeVNHRmve9e7TtBVXiM=;
        b=lut5GHGzEENqE8c4bauh/TlTusHss46DVGXnM+uHrZNQa2tVs3OSIJno9FEvBX0IEE
         DRd0IxZVKcqShqReCftvCxc27vVee57OdWf8It8CqNa6zWmIFhfx7PWIJKDW6UttNeFP
         SR0aLs6JXUA7vWA9nCRK2R0GWaHK7Jt+UD4CtLFXDbj3lj9ZpHcgQzgbomiWONF2ySwc
         BxX6qpyhqDIhg5Ks56kIlMaIX77/IH8xAwOaEMBtpkltVPWvlreaGyagGNX/3R+XR77y
         DhCOij3wubI5Ai80m2VhgBv/HS/RUGw5JKna45VYuleIvU3tZzfdQWmHN2gEJIyt5Bek
         rKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6gR7+oJ7XUI6MhB8zU2feJZoMeVNHRmve9e7TtBVXiM=;
        b=Nfde3sgmsBjChbq4hsjs88LKac6roqGVakgEkeUTZrGpP9BWf5UwXGpE9Du3wajdNw
         hdIfchFD3hseCznUBLlUbg46i8+zmToyE7IA7OEPBkhFaUHf8IWFvECF1gvu4wy/muki
         bqPCmGplZd9lNBbGMYq0xKYwrHNk+PtmYYzY2410JODw+Fis9qTMyT0cCpMKYHi42qLO
         F9lT7yJCAt2PHoIlLojoyDvJNPVHG5p17FtDqfwImcmGfz+QsNuAWuUsh2ui+Rc5jFH9
         Ze5U4U8JChc9hRHr4oaS5JTllcd/WLqeB9O5GY6zTwbyt3c+dfh0kOpyEEoxTHbVgRx9
         Kpzg==
X-Gm-Message-State: AOAM532X1G+yN8FjATJonvEyZJrGzvyWtKvNkJYKgKkEHkzOE9JZNRB2
        Bdo7zZSd0kGbxzpltzfurKA=
X-Google-Smtp-Source: ABdhPJwNyKqnFsz6sUSx1d/aGhENQ2XeF1+TR5MNvyjlOl72Tstx0VP9NRESCGyA5ledv+bxfbqarg==
X-Received: by 2002:a17:90a:4091:: with SMTP id l17mr3384594pjg.12.1625207148980;
        Thu, 01 Jul 2021 23:25:48 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id b19sm1499251pjh.29.2021.07.01.23.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 23:25:48 -0700 (PDT)
Date:   Thu, 1 Jul 2021 23:22:15 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Message-ID: <YN6wlwFomEJ0LK1Y@gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 28, 2021 at 06:13:29PM +0200, Jann Horn wrote:
> On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > This change introduces the new system call:
> > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
> >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)
> >
> > process_vm_exec allows to execute the current process in an address
> > space of another process.
> [...]
> 
> I still think that this whole API is fundamentally the wrong approach
> because it tries to shoehorn multiple usecases with different
> requirements into a single API. But that aside:

Here, I can't agree with you, but this is discussed in the parallel
thread.

> 
> > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> > +{
> > +       struct task_struct *tsk = current;
> > +       struct mm_struct *active_mm;
> > +
> > +       task_lock(tsk);
> > +       /* Hold off tlb flush IPIs while switching mm's */
> > +       local_irq_disable();
> > +
> > +       sync_mm_rss(prev_mm);
> > +
> > +       vmacache_flush(tsk);
> > +
> > +       active_mm = tsk->active_mm;
> > +       if (active_mm != target_mm) {
> > +               mmgrab(target_mm);
> > +               tsk->active_mm = target_mm;
> > +       }
> > +       tsk->mm = target_mm;
> 
> I'm pretty sure you're not currently allowed to overwrite the ->mm
> pointer of a userspace thread. For example, zap_threads() assumes that
> all threads running under a process have the same ->mm. (And if you're
> fiddling with ->mm stuff, you should probably CC linux-mm@.)
> 
> As far as I understand, only kthreads are allowed to do this (as
> implemented in kthread_use_mm()).

kthread_use_mm() was renamed from use_mm in the v5.8 kernel. Before
that, it wasn't used for user processes in the kernel, but it was
exported for modules, and we used it without any visible problems. We
understood that there could be some issues like zap_threads and it was
one of reasons why we decided to introduce this system call.

I understand that there are no places in the kernel where we change mm
of user threads back and forth, but are there any real concerns why we
should not do that? I agree that zap_threads should be fixed, but it
will the easy one.

> 
> > +       switch_mm_irqs_off(active_mm, target_mm, tsk);
> > +       local_irq_enable();
> > +       task_unlock(tsk);
> > +#ifdef finish_arch_post_lock_switch
> > +       finish_arch_post_lock_switch();
> > +#endif
> > +
> > +       if (active_mm != target_mm)
> > +               mmdrop(active_mm);
> > +}
