Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2216B3BA4C3
	for <lists+linux-api@lfdr.de>; Fri,  2 Jul 2021 22:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhGBUn1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 2 Jul 2021 16:43:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230434AbhGBUn1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 2 Jul 2021 16:43:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78BB5613E0;
        Fri,  2 Jul 2021 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625258454;
        bh=6+OITvBZ38kQshqJCixbf/xFxJSGTuAC9lgseuVW7bg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=snqekq95VrymLhPd5Dvw/KBsUQRAfQtKZOjvhZDn713Jh5clkllIiq3MFBwqKsaml
         OLBt/mIx8iTaoR1bsT1g+FOaqk9EzkISYBV8QlcbBcni13gQ8TCz/P2BZVB5UQ+u7v
         RWovPD0wU4/QeJr5PxX3C+UqUeNx/Rw5HnFA7Hkjg9yGeZQwTmmJT6SsuSaka+MQEo
         +ET1g+JtAbCwVkGvGiE5w5oG8ASaYh9abQgwUdho1KdiSndMlUKPKruFJ5UQEvBG0U
         HShPMaUIZLnXBpg4GIXLErsp9kn9geBv+iuwjcGBavSTw78z18k4fbi+yqNKKR2Ih/
         pq4Vk6E1vqvvw==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9572627C0054;
        Fri,  2 Jul 2021 16:40:52 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Fri, 02 Jul 2021 16:40:52 -0400
X-ME-Sender: <xms:0nnfYK5oyWhPLiq9Mptzw4G4D_Zmdanr_wLeKVfZqr2DXC5T4gLlQQ>
    <xme:0nnfYD4CLD7ePx7jesr8LmkF_BN2S74vBOv9N84t1BvJdY0ZK_VErDjZNigCs2PYk
    d2iKNhbaf0WyBpANJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeikedgudehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:0nnfYJcASc9c5j0p9LdKS7-reaKLswdtZg9svK8zgOsRMbKVHGNi7A>
    <xmx:0nnfYHJWtJqgW76XYNVTiX4IjY8OPXE_JlDPQHlE0QgBz_PFYiw6Kw>
    <xmx:0nnfYOL-zq3KX5LLS3Z8v59kIwRl5oVSxBNqdY5TZ553L87JMx8W-w>
    <xmx:1HnfYPe0x3qVkrUFKuOnB94I8wQviQyhKjPspWmFec-J5hUDOmE0YFA75-0>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7A008A000EE; Fri,  2 Jul 2021 16:40:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-530-gd0c265785f-fm-20210616.002-gd0c26578
Mime-Version: 1.0
Message-Id: <9a943ade-cabe-40e0-992a-13f26ed58f69@www.fastmail.com>
In-Reply-To: <CAG48ez1=RPbsUos6yY1jMVU49U+GqSN8kFPosoFpKJZjFa4yvQ@mail.gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
 <YN6wlwFomEJ0LK1Y@gmail.com>
 <CAG48ez1=RPbsUos6yY1jMVU49U+GqSN8kFPosoFpKJZjFa4yvQ@mail.gmail.com>
Date:   Fri, 02 Jul 2021 13:40:26 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jann Horn" <jannh@google.com>, "Andrei Vagin" <avagin@gmail.com>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Anton Ivanov" <anton.ivanov@cambridgegreys.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        "Dmitry Safonov" <0x7f454c46@gmail.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Jeff Dike" <jdike@addtoit.com>,
        "Mike Rapoport" <rppt@linux.ibm.com>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Richard Weinberger" <richard@nod.at>,
        "Thomas Gleixner" <tglx@linutronix.de>, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Fri, Jul 2, 2021, at 4:51 AM, Jann Horn wrote:
> On Fri, Jul 2, 2021 at 8:25 AM Andrei Vagin <avagin@gmail.com> wrote:
> > On Mon, Jun 28, 2021 at 06:13:29PM +0200, Jann Horn wrote:
> > > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wr=
ote:
> > > > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct=
 *target_mm)
> > > > +{
> > > > +       struct task_struct *tsk =3D current;
> > > > +       struct mm_struct *active_mm;
> > > > +
> > > > +       task_lock(tsk);
> > > > +       /* Hold off tlb flush IPIs while switching mm's */
> > > > +       local_irq_disable();
> > > > +
> > > > +       sync_mm_rss(prev_mm);
> > > > +
> > > > +       vmacache_flush(tsk);
> > > > +
> > > > +       active_mm =3D tsk->active_mm;
> > > > +       if (active_mm !=3D target_mm) {
> > > > +               mmgrab(target_mm);
> > > > +               tsk->active_mm =3D target_mm;
> > > > +       }
> > > > +       tsk->mm =3D target_mm;
> > >
> > > I'm pretty sure you're not currently allowed to overwrite the ->mm=

> > > pointer of a userspace thread. For example, zap_threads() assumes =
that
> > > all threads running under a process have the same ->mm. (And if yo=
u're
> > > fiddling with ->mm stuff, you should probably CC linux-mm@.)
> > >
> > > As far as I understand, only kthreads are allowed to do this (as
> > > implemented in kthread_use_mm()).
> >
> > kthread_use_mm() was renamed from use_mm in the v5.8 kernel. Before
> > that, it wasn't used for user processes in the kernel, but it was
> > exported for modules, and we used it without any visible problems. W=
e
> > understood that there could be some issues like zap_threads and it w=
as
> > one of reasons why we decided to introduce this system call.
> >
> > I understand that there are no places in the kernel where we change =
mm
> > of user threads back and forth, but are there any real concerns why =
we
> > should not do that? I agree that zap_threads should be fixed, but it=

> > will the easy one.
>=20
> My point is that if you break a preexisting assumption like this,
> you'll have to go through the kernel and search for places that rely
> on this assumption, and fix them up, which may potentially require
> thinking about what kinds of semantics would actually be appropriate
> there. Like the MCE killing logic (collect_procs_anon() and such). And=

> current_is_single_threaded(), in which the current patch probably
> leads to logic security bugs. And __uprobe_perf_filter(). Before my
> refactoring of the ELF coredump logic in kernel 5.10 (commit
> b2767d97f5ff75 and the ones before it), you'd have also probably
> created memory corruption bugs in races between elf_core_dump() and
> syscalls like mmap()/munmap(). (Note that this is not necessarily an
> exhaustive list.)
>=20

There=E2=80=99s nmi_uaccess_okay(), and its callers assume that, when a =
task is perf tracing itself, that an event on that task with nmi_uaccess=
_okay() means that uaccess will access that task=E2=80=99s memory.

Core dump code probably expects that dumping memory will access the corr=
ect mm.

I cannot fathom why any kind of remote vm access touched FPU state at al=
l.

What PKRU value is supposed to be used when doing mm swap shenanigans?  =
How about PASID?

What happens if one task attempts to issue a KVM ioctl while its mm is s=
wapped?
