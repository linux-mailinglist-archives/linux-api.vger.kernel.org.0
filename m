Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B3B3B6769
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 19:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbhF1RR0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 13:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbhF1RR0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 13:17:26 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B4EC061760
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 10:15:00 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id p24so11560408ljj.1
        for <linux-api@vger.kernel.org>; Mon, 28 Jun 2021 10:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2XZJeJAnEeTw6EZhaeLtrIK78gkna+e52JMMHDT7CCg=;
        b=vXUXr4QmB8bjJVw5A5IXOs6Bo6viOvMc2F0ojinBt6aXe1DSaxMQwbtfRnJQb+8lYW
         zcyFZgIJtaGNLaTOhAJJ8JyG4hU3Dd4EVJs3il9GJtDKN9WZZqQPALe2FH+E+iIl863X
         Em5ZoXz7AkXDHv014gmOyuqVRDCUpKfJKn76opXr3IIGqQ2vTCeVV+c6OVkmR9ipZiTi
         wPUxWKKKF0t+qKL2L2riNFGIDdEgqH7abrYvPLwsnGxKzWtGCM82TnEj13IwbrX83Qjv
         BW79d4ELwMWWecaVuLUPoewSfeWAdNbdVCEW55GA4IZ/6mRwnCEwB5tXIwF7FNxQA7Kb
         /qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2XZJeJAnEeTw6EZhaeLtrIK78gkna+e52JMMHDT7CCg=;
        b=hP/fNFdDUzkG+/5r7cwNaY8plaAECEfQ6wxLBab5OjtwXs19kN6jrMnNxiOIDQO1tZ
         C6XP2eVm45Sa1u2eLANCfirDmwtmJKB4Xonw7TicEd1oHXcnQUFou+/N9WHBR/uyd/OL
         O+Y6GA3Y78WRV36X787eVoZI16RR53caLtL7hwYO09+k+ODaR90f1YdHsp0DFzdPWOvi
         jWO1HSKYf7htV472uixm/2sKNT9h54+HkgvdRLfRPdFQZhpSDq0NnH48DkYOX8MG9def
         haxPOkCzYT8ChMKPmytc7C7ky8hP0fTdW/DjHF65mp12m5xYh5Ev3kgnrYSBuz3yhjsZ
         4HWg==
X-Gm-Message-State: AOAM533JTx3nzb4MR8a1Z88sKrNfKTnYFkvo1L+ZI943dSn74bNOD1au
        3ajSAdOYZF42WVMEUnYEKcIqXwW95FSWHhQSLn0yBw==
X-Google-Smtp-Source: ABdhPJwouLp0BeyvLadrY22lhcl7T2zhKeDBodDpwR+JLO60lkyrdWsQoS1kjfX3iybtOy7rkSxgTUJm5fJEEgP3AO8=
X-Received: by 2002:a2e:918a:: with SMTP id f10mr362098ljg.226.1624900497482;
 Mon, 28 Jun 2021 10:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com> <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com> <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
In-Reply-To: <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 28 Jun 2021 19:14:31 +0200
Message-ID: <CAG48ez1d3abHEekh_fYoXdAe85RG+c--G7sEyMYhiKEsns3uog@mail.gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrei Vagin <avagin@gmail.com>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 28, 2021 at 6:30 PM Andy Lutomirski <luto@kernel.org> wrote:
> On Mon, Jun 28, 2021, at 9:13 AM, Jann Horn wrote:
> > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
> > > This change introduces the new system call:
> > > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long fla=
gs,
> > >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask=
)
> > >
> > > process_vm_exec allows to execute the current process in an address
> > > space of another process.
> > [...]
> >
> > I still think that this whole API is fundamentally the wrong approach
> > because it tries to shoehorn multiple usecases with different
> > requirements into a single API. But that aside:
> >
> > > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *tar=
get_mm)
> > > +{
> > > +       struct task_struct *tsk =3D current;
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
> > > +       active_mm =3D tsk->active_mm;
> > > +       if (active_mm !=3D target_mm) {
> > > +               mmgrab(target_mm);
> > > +               tsk->active_mm =3D target_mm;
> > > +       }
> > > +       tsk->mm =3D target_mm;
> >
> > I'm pretty sure you're not currently allowed to overwrite the ->mm
> > pointer of a userspace thread. For example, zap_threads() assumes that
> > all threads running under a process have the same ->mm. (And if you're
> > fiddling with ->mm stuff, you should probably CC linux-mm@.)
>
> exec_mmap() does it, so it can=E2=80=99t be entirely impossible.

Yeah, true, execve can do it - I guess the thing that makes that
special is that it's running after de_thread(), so it's guaranteed to
be single-threaded?
