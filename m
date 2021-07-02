Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DE03BA015
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 13:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhGBLyI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhGBLyI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Jul 2021 07:54:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E9C061762
        for <linux-api@vger.kernel.org>; Fri,  2 Jul 2021 04:51:36 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q16so17614287lfr.4
        for <linux-api@vger.kernel.org>; Fri, 02 Jul 2021 04:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itw4ZSFZPbB5jMtAcW94A5cIi28Zbh7A4MY1L25gGO0=;
        b=skWOQ+tjB/RGXCRgCh/oX+pSqn801BpaewaioJ94g7BDJUoKJyzmNIJxfF6R7k4OVV
         FkwksQciuoAEGOrZtrGFPyYLCXxLZXMJQsbTDphZ25i2JhWuw1YkS/xEcgUdDDbf9BEz
         j7+1ZY18y7jKX0p1sfgvxy86H6YhI4LvjICQmgerkbW0Z3rzuCrlxHcOSbVsgrfKEMkm
         twF/uAlLn/bNXF+depqyu2UMF8dk7nIYWit4IrjecjAjTjt4ERd3UudzQ1TbM8bnmPv4
         qcu2ePgioE8YFrrKk17qWsiRJ2RNd9GS4629An1dwAydO/asFBTQAYsYJLt0DMpXfTAL
         jsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itw4ZSFZPbB5jMtAcW94A5cIi28Zbh7A4MY1L25gGO0=;
        b=RHnX/CkKJZc5F/CR8YOJLI5OBnlVH2tMfZ9MacjJG/pRWWi71ps2CViu9p1UtJ6UGM
         UPeWOaZt9ks7iw2D62+1mxije2+f405Mx6hrZMgY8Lzg+dG/X0+L3xQbUlvrdN8juzSU
         2bGQ2S9btf/URgMk+dhU+1UeoLhPQCTi1O1s8dci9RFoaR5BEIGOSB4TAaIw/a0Hfh0x
         PnroqhLhA5btLBvjkLKvR2T4tmqUfmiHl4S/sAWDVWe5JjBPraUFx4IZcBZeMB3PXsxZ
         lofdUInvpc58ZDQkR5dbsfozB2s4MkrccJy/b1O+Gs7y2eQtEAl1XIQ8G5YN50e1EmOe
         ENQw==
X-Gm-Message-State: AOAM531O5sM3AMWAd7PsJo0A+1L25LZTqpdktThDuTMs2/+gty0TCZXF
        PI69vQT8IKQW1ThD2hIlAnIYuONp7Qf6ll5nrv/7tw==
X-Google-Smtp-Source: ABdhPJzv91oZ5IBQE4TVWTsbh26N4tL41MOZOBkez4YnKnXUpCp87craAVl4JAJ/NuKAFHVkgR9wdySOTWnDC2Tli5g=
X-Received: by 2002:a19:f51a:: with SMTP id j26mr3666613lfb.390.1625226694605;
 Fri, 02 Jul 2021 04:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com> <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com> <YN6wlwFomEJ0LK1Y@gmail.com>
In-Reply-To: <YN6wlwFomEJ0LK1Y@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 2 Jul 2021 13:51:08 +0200
Message-ID: <CAG48ez1=RPbsUos6yY1jMVU49U+GqSN8kFPosoFpKJZjFa4yvQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
To:     Andrei Vagin <avagin@gmail.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 2, 2021 at 8:25 AM Andrei Vagin <avagin@gmail.com> wrote:
> On Mon, Jun 28, 2021 at 06:13:29PM +0200, Jann Horn wrote:
> > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
> > > +{
> > > +       struct task_struct *tsk = current;
> > > +       struct mm_struct *active_mm;
> > > +
> > > +       task_lock(tsk);
> > > +       /* Hold off tlb flush IPIs while switching mm's */
> > > +       local_irq_disable();
> > > +
> > > +       sync_mm_rss(prev_mm);
> > > +
> > > +       vmacache_flush(tsk);
> > > +
> > > +       active_mm = tsk->active_mm;
> > > +       if (active_mm != target_mm) {
> > > +               mmgrab(target_mm);
> > > +               tsk->active_mm = target_mm;
> > > +       }
> > > +       tsk->mm = target_mm;
> >
> > I'm pretty sure you're not currently allowed to overwrite the ->mm
> > pointer of a userspace thread. For example, zap_threads() assumes that
> > all threads running under a process have the same ->mm. (And if you're
> > fiddling with ->mm stuff, you should probably CC linux-mm@.)
> >
> > As far as I understand, only kthreads are allowed to do this (as
> > implemented in kthread_use_mm()).
>
> kthread_use_mm() was renamed from use_mm in the v5.8 kernel. Before
> that, it wasn't used for user processes in the kernel, but it was
> exported for modules, and we used it without any visible problems. We
> understood that there could be some issues like zap_threads and it was
> one of reasons why we decided to introduce this system call.
>
> I understand that there are no places in the kernel where we change mm
> of user threads back and forth, but are there any real concerns why we
> should not do that? I agree that zap_threads should be fixed, but it
> will the easy one.

My point is that if you break a preexisting assumption like this,
you'll have to go through the kernel and search for places that rely
on this assumption, and fix them up, which may potentially require
thinking about what kinds of semantics would actually be appropriate
there. Like the MCE killing logic (collect_procs_anon() and such). And
current_is_single_threaded(), in which the current patch probably
leads to logic security bugs. And __uprobe_perf_filter(). Before my
refactoring of the ELF coredump logic in kernel 5.10 (commit
b2767d97f5ff75 and the ones before it), you'd have also probably
created memory corruption bugs in races between elf_core_dump() and
syscalls like mmap()/munmap(). (Note that this is not necessarily an
exhaustive list.)
