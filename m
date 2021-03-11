Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E918D3369FE
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 03:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhCKCCX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 10 Mar 2021 21:02:23 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:47467 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229714AbhCKCB5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Mar 2021 21:01:57 -0500
X-AuditID: 0a580155-1f5ff7000005482e-22-6049728f68b2
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 89.95.18478.F8279406; Thu, 11 Mar 2021 09:29:51 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 11 Mar
 2021 10:01:54 +0800
Date:   Thu, 11 Mar 2021 10:01:54 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        HORIGUCHI NAOYA <naoya.horiguchi@nec.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        <yangfeng1@kingsoft.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, <sunhao2@kingsoft.com>,
        <yaoaili@kingsoft.com>, <suhua1@kingsoft.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210311100154.5a75c62e@alex-virtual-machine>
In-Reply-To: <CALCETrVqkK29n=6wtVhd7qgTWf83x3SUk6+bkD30asHyWSqppw@mail.gmail.com>
References: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
        <047D5B49-FDBB-494C-81E9-DA811476747D@amacapital.net>
        <20210311091941.45790fcf@alex-virtual-machine>
        <CALCETrVqkK29n=6wtVhd7qgTWf83x3SUk6+bkD30asHyWSqppw@mail.gmail.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsXCFcGooNtf5Jlg8PUUs8XnDf/YLF5saGe0
        mLZR3GLz9w42i8u75rBZ3Fvzn9Vi9doGVovzu9ayWlw6sIDJ4mLjAUaLrftbGS2O9x5gsti8
        aSqzxZsL91gsfmx4zOrA7/G9tY/F4/6bvywem1doeSze85LJY9OqTjaPTZ8msXu8O3eO3WPe
        yUCPF1c3sni833eVzePzJjmPEy1fWAN4orhsUlJzMstSi/TtErgyrm5fyljQKlKxa+p91gbG
        A/xdjOwcEgImEntsuhi5OIQEpjNJHDu0lAnCecUosfH1cSCHk4NFQFXiZ8tWMJsNyN51bxYr
        iC0ioCnxcsp8FpAGZoFHLBINsxezgySEBZIlzkx6wAhi8wpYSWz4Mh+omYODUyBQ4sFBGYgF
        LxglOju3s4HU8AuISfRe+Q+2QELAXqJtyyKoXkGJkzOfsIDYzEDLWrf/ZoewtSWWLXzNDGIL
        CShKHF7yix2iV0niSPcMNgg7VmLZvFesExiFZyEZNQvJqFlIRi1gZF7FyFKcm260iRESm6E7
        GGc0fdQ7xMjEwXiIUYKDWUmE1++4W4IQb0piZVVqUX58UWlOavEhRmkOFiVx3r3HXBOEBNIT
        S1KzU1MLUotgskwcnFINTAdWnODNFdlnd+0k64q9+yQ6157PmrlAMSnlz4YY9RsHn3lfexrT
        x9nftDLhu/nVi4F5tfKHOqr7fC76mSyO3CFkf7Ro2ZvEyhk2xte2+jrYJy1kNlnyzqs+5kGs
        yx+TpeeUzwarLhBSYWrYtXvig3nLDwicMj0TaBKdOenu1arXTF6lv5MnGxb/YHQqORmxeZ+E
        tPdeTjfZT/IS7EnecWUpgg6dhx5dCmW7krL0zv+DbXZ3HqbfcOE4FDWxPn6nk/7cu21yElXH
        HcNN93N8UpNPCSrmmNC+6vvcrYu+cn3ZkW3566bNzMg/G49qhCvEbL4Ye+sgQ2OGzAGTg3/W
        O2zeVnk2a+W93NMPtaxi/iixFGckGmoxFxUnAgBRSXrGPAMAAA==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 10 Mar 2021 17:28:12 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> On Wed, Mar 10, 2021 at 5:19 PM Aili Yao <yaoaili@kingsoft.com> wrote:
> >
> > On Mon, 8 Mar 2021 11:00:28 -0800
> > Andy Lutomirski <luto@amacapital.net> wrote:
> >  
> > > > On Mar 8, 2021, at 10:31 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > > >
> > > > ﻿  
> > > >>
> > > >> Can you point me at that SIGBUS code in a current kernel?  
> > > >
> > > > It is in kill_me_maybe().  mce_vaddr is setup when we disassemble whatever get_user()
> > > > or copy from user variant was in use in the kernel when the poison memory was consumed.
> > > >
> > > >        if (p->mce_vaddr != (void __user *)-1l) {
> > > >                force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);  
> > >
> > > Hmm. On the one hand, no one has complained yet. On the other hand, hardware that supports this isn’t exactly common.
> > >
> > > We may need some actual ABI design here. We also need to make sure that things like io_uring accesses or, more generally, anything using the use_mm / use_temporary_mm ends up either sending no signal or sending a signal to the right target.
> > >  
> > > >
> > > > Would it be any better if we used the BUS_MCEERR_AO code that goes into siginfo?  
> > >
> > > Dunno.  
> >
> > I have one thought here but don't know if it's proper:
> >
> > Previous patch use force_sig_mceerr to the user process for such a scenario; with this method
> > The SIGBUS can't be ignored as force_sig_mceerr() was designed to.
> >
> > If the user process don't want this signal, will it set signal config to ignore?
> > Maybe we can use a send_sig_mceerr() instead of force_sig_mceerr(), if process want to
> > ignore the SIGBUS, then it will ignore that, or it can also process the SIGBUS?  
> 
> I don't think the signal blocking mechanism makes sense for this.
> Blocking a signal is for saying that, if another process sends the
> signal (or an async event like ctrl-C), then the process doesn't want
> it.  Blocking doesn't block synchronous things like faults.
> 
> I think we need to at least fix the existing bug before we add more
> signals.  AFAICS the MCE_IN_KERNEL_COPYIN code is busted for kernel
> threads.

Got this, Thanks!

I read https://man7.org/linux/man-pages/man2/write.2.html, and it seems the write syscall is not expecting
an signal, maybe a specific error code for this scenario is enough.

-- 
Thanks!
Aili Yao
