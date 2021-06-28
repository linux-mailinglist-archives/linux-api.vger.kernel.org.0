Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C77B73B66C7
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhF1QdX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Jun 2021 12:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233108AbhF1QdW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 28 Jun 2021 12:33:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E08F6198D;
        Mon, 28 Jun 2021 16:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624897856;
        bh=sKyqPO15EImCw3svh4v8lKYkwAoCpB9/n9aUDIsf1q4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=QFNA5j0vI8jLovwax7NHz2zyoe1WSwCttoe+l2NqK0c+A9C1WJLsapEYOlDV5NN/7
         pJ3cEIMqaCUgavTAPp3FV3X6GbPrkshvHIX4KjTkI5lCqY/FEjrfHnSvWGSEcloUMg
         51Xm80XTAnXBCSXVEy5NJo0K/9kbpP5oY9cqwlBsB/KkZT0zTsl5JkAQivs6Zxkhzn
         iAx8YfBLH4U6IJkBXesAdSN/n2+CROQ0tdg9X+thfR/8XaAXvmI3LUOlUlg+P36DfY
         6cp6PnKni9TR7JYxnaXudh4KvdhoA036sLuqY+F5HLE6ZRq8gjZDWL0GXirRI0fjHW
         o8pzJnZvgNf9A==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2882D27C0060;
        Mon, 28 Jun 2021 12:30:54 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute6.internal (MEProxy); Mon, 28 Jun 2021 12:30:54 -0400
X-ME-Sender: <xms:PPnZYO39LH4FBrTmGu_S-v39xiVujdiV8U2wGLRQTBLes97BQS1AQw>
    <xme:PPnZYBEovQkNPTheGrXSbdyza8HHVdIuAftqy68ln6qYbwJnpabsO0uwRKKz3kbDH
    Fg3njYskbrtEPjblio>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:PPnZYG6tlbzKCHxNF_IB4ikW4MJH4oj2A0f2ckUfzwvA4UkBZEa27g>
    <xmx:PPnZYP0X108S2YRONIv1FFggAREuJfckBhZ4G8cYJCn36d9iCYmxag>
    <xmx:PPnZYBFJov0Y5jG0VhjNMdhH4_4eg_LCXAOPGL4AabvKcOmFFAvXxg>
    <xmx:PvnZYHUwjbJak9e-BJsYJFC-K0me8Y9bA7LKg9N_51G7pZ61d6dYHdMiyDs>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2BC6251C0060; Mon, 28 Jun 2021 12:30:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-530-gd0c265785f-fm-20210616.002-gd0c26578
Mime-Version: 1.0
Message-Id: <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
In-Reply-To: <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
Date:   Mon, 28 Jun 2021 09:30:31 -0700
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
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Mon, Jun 28, 2021, at 9:13 AM, Jann Horn wrote:
> On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:=

> > This change introduces the new system call:
> > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long fl=
ags,
> >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemas=
k)
> >
> > process_vm_exec allows to execute the current process in an address
> > space of another process.
> [...]
>=20
> I still think that this whole API is fundamentally the wrong approach
> because it tries to shoehorn multiple usecases with different
> requirements into a single API. But that aside:
>=20
> > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *ta=
rget_mm)
> > +{
> > +       struct task_struct *tsk =3D current;
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
> > +       active_mm =3D tsk->active_mm;
> > +       if (active_mm !=3D target_mm) {
> > +               mmgrab(target_mm);
> > +               tsk->active_mm =3D target_mm;
> > +       }
> > +       tsk->mm =3D target_mm;
>=20
> I'm pretty sure you're not currently allowed to overwrite the ->mm
> pointer of a userspace thread. For example, zap_threads() assumes that=

> all threads running under a process have the same ->mm. (And if you're=

> fiddling with ->mm stuff, you should probably CC linux-mm@.)

exec_mmap() does it, so it can=E2=80=99t be entirely impossible.
