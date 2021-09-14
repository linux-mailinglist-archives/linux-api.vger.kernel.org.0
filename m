Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1440B550
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhINQxw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 12:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229379AbhINQxu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 14 Sep 2021 12:53:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 74C38610CE;
        Tue, 14 Sep 2021 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631638353;
        bh=5qP3jIRU2Rimob/+IYVt164Jnqvvfj2vNhaBNaS1Euc=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=qpjCV2r0KJCB7Py3WfpwurzZuFEl598uIvpWFzhdPJvxUVHeuiSnXbZM8EX+cmOAp
         FiiNKd68d1ruquTrhfv3kFA/Uaqvm4szhdNTmVKj+vhZdklwPinxjEkiCvEnEmFHSZ
         A/N8cKYJqtMKMFrmEmhBfiAkiyxoN+eae78VLZcc2L4wwqLEc/UlDQHoZmmeEjBQMl
         mqvbDjnjz1pIo1YYGxGHAImuqMb+ewswBs8XOj3js/XsTmFq23dEOevFrVhcmV7n9J
         8K2bG692J41RJG7QahowxPsX/41kLJsmbcaCUeo8LO/Ene2AKwS8pi+QZqcdBUREPo
         p7Kdi2KtcvJ7w==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 981AC27C006B;
        Tue, 14 Sep 2021 12:52:31 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Tue, 14 Sep 2021 12:52:31 -0400
X-ME-Sender: <xms:TtNAYeLH4PKwEZupuFLwrLbxNYUVc1gaGHYO9RLvNVwhtj89Lfxo_Q>
    <xme:TtNAYWJDmOUPeF9HRTQwGiCZwn0819wNKq5uBQ5s7Dte0IUFbrBxEQXbOS9E3Za_n
    qDQRzU_6YaS3EGiPp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeugfeufeevkeehvddtfffgkeelhefgkeehveetgeeikeegheei
    vdffgfejteduhfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghnugihodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdduudeiudekheeifedvqddvieefudeiiedtkedqlh
    huthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuhigrdhluhhtohdruhhs
X-ME-Proxy: <xmx:TtNAYesUF6DI-HDYzEAl0IEv8h_KLtXrRt2lg_iTM-OedrNsSJEsHA>
    <xmx:TtNAYTZ2Jj7JXaZwszr4s8qqEfrvFRpWpmqaYpdnk2xdc27ahDwPjQ>
    <xmx:TtNAYVadoA6ZXn9drF8Efztyutyo_SrnIvXkYwUPjX1kXSoj-ooEZA>
    <xmx:T9NAYXmQPQJLFi8UD0TUtmm64KOPNNoWoffALv5jjt4gcyFZQ8SPRIijzBM>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C0723A002E4; Tue, 14 Sep 2021 12:52:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <d656e605-4f89-4ea2-8baf-f7786f0630d9@www.fastmail.com>
In-Reply-To: <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
References: <20210908184905.163787-1-posk@google.com>
 <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
Date:   Tue, 14 Sep 2021 09:52:08 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Jann Horn" <jannh@google.com>, "Peter Oskolkov" <posk@google.com>
Cc:     "Peter Oskolkov" <posk@posk.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Paul Turner" <pjt@google.com>, "Ben Segall" <bsegall@google.com>,
        "Andrei Vagin" <avagin@google.com>,
        "Thierry Delisle" <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Thu, Sep 9, 2021, at 2:20 PM, Jann Horn wrote:
> On Thu, Sep 9, 2021 at 9:07 PM Peter Oskolkov <posk@google.com> wrote:
> > On Wed, Sep 8, 2021 at 4:39 PM Jann Horn <jannh@google.com> wrote:
> >
> > Thanks a lot for the reviews, Jann!
> >
> > I understand how to address most of your comments. However, one issue
> > I'm not sure what to do about:
> >
> > [...]
> >
> > > If this function is not allowed to sleep, as the comment says...
> >
> > [...]
> >
> > > ... then I'm pretty sure you can't call fix_pagefault() here, which
> > > acquires the mmap semaphore (which may involve sleeping) and then =
goes
> > > through the pagefault handling path (which can also sleep for vari=
ous
> > > reasons, like allocating memory for pagetables, loading pages from
> > > disk / NFS / FUSE, and so on).
> >
> > <quote from peterz@ from
> > https://lore.kernel.org/lkml/20210609125435.GA68187@worktop.programm=
ing.kicks-ass.net/>:
> >   So a PF_UMCG_WORKER would be added to sched_submit_work()'s PF_*_W=
ORKER
> >   path to capture these tasks blocking. The umcg_sleeping() hook add=
ed
> >   there would:
> >
> >     put_user(BLOCKED, umcg_task->umcg_status);
> >     ...
> > </quote>
> >
> > Which is basically what I am doing here: in sched_submit_work() I ne=
ed
> > to read/write to userspace; and we cannot sleep in
> > sched_submit_work(), I believe.
> >
> > If you are right that it is impossible to deal with pagefaults from
> > within non-sleepable contexts, I see two options:
> >
> > Option 1: as you suggest, pin pages holding struct umcg_task in sys_=
umcg_ctl;
>=20
> FWIW, there is a variant on this that might also be an option:
>=20
> You can create a new memory mapping from kernel code and stuff pages
> into it that were originally allocated as normal kernel pages. This is
> done in a bunch of places, e.g.:

With a custom mapping, you don=E2=80=99t need to pin pages at all, I thi=
nk.  As long as you can reconstruct the contents of the shared page and =
you=E2=80=99re willing to do some slightly careful synchronization, you =
can detect that the page is missing when you try to update it and skip t=
he update. The vm_ops->fault handler can repopulate the page the next ti=
me it=E2=80=99s accessed.

All that being said, I feel like I=E2=80=99m missing something. The poin=
t of this is to send what the old M:N folks called =E2=80=9Cscheduler ac=
tivations=E2=80=9D, right?  Wouldn=E2=80=99t it be more efficient to exp=
licitly wake something blockable/pollable and write the message into a m=
ore efficient data structure?  Polling one page per task from userspace =
seems like it will have inherently high latency due to the polling inter=
val and will also have very poor locality.  Or am I missing something?

>=20
>
> Note that what I'm suggesting here is a bit unusual - normally only
> the vDSO is a "special mapping", other APIs tend to use mappings that
> are backed by files. But I think we probably don't want to have a file
> involved here...
>=20

A file would be weird =E2=80=94 the lifetime and SCM_RIGHTS interactions=
 may be unpleasant.

> If you decide to go this route, you should probably CC
> linux-mm@kvack.org (for general memory management) and Andy Lutomirski
> (who has tinkered around in vDSO-related code a lot).
>=20

Who=E2=80=99s that? :)

> > or
> >
> > Option 2: add more umcg-related kernel state to task_struct so that
> > reading/writing to userspace is not necessary in sched_submit_work().
> >
> > The first option sounds much better from the code simplicity point of
> > view, but I'm not sure if it is a viable approach, i.e. I'm afraid
> > we'll get a hard NACK here, as a non-privileged process will be able
> > to force the kernel to pin a page per task/thread.
>=20
> To clarify: It's entirely normal that userspace processes can force
> the kernel to hold on to some amounts of memory that can't be paged
> out - consider e.g. pagetables and kernel objects referenced by file
> descriptors. So an API that pins limited amounts of memory that are
> also mapped in userspace isn't inherently special. But pinning pages
> that were originally allocated as normal userspace memory can be more
> problematic because that memory might be hugepages, or file pages, or
> it might prevent the hugepaged from being able to defragment memory
> because the pinned page was allocated in ZONE_MOVABLE.
>=20
>=20
> > We may get around
> > it by first pinning a limited number of pages, then having the
> > userspace allocate structs umcg_task on those pages, so that a pinned
> > page would cover more than a single task/thread. And have a sysctl
> > that limits the number of pinned pages per MM.
>=20
> I think that you wouldn't necessarily need a sysctl for that if the
> kernel can enforce that you don't have more pages allocated than you
> need for the maximum number of threads that have ever been running
> under the process, and you also use __GFP_ACCOUNT so that cgroups can
> correctly attribute the memory usage.
>=20
> > Peter Z., could you, please, comment here? Do you think pinning pages
> > to hold structs umcg_task is acceptable?
>=20
