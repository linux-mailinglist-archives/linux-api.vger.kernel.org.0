Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC103369B1
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 02:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhCKBfF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 10 Mar 2021 20:35:05 -0500
Received: from mail.kingsoft.com ([114.255.44.145]:14444 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhCKBeu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Mar 2021 20:34:50 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Mar 2021 20:34:50 EST
X-AuditID: 0a580155-1f5ff7000005482e-6d-604968aae979
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id 4C.75.18478.AA869406; Thu, 11 Mar 2021 08:47:38 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 11 Mar
 2021 09:19:41 +0800
Date:   Thu, 11 Mar 2021 09:19:41 +0800
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
        LKML <linux-kernel@vger.kernel.org>, <yaoaili@kingsoft.com>,
        <sunhao2@kingsoft.com>
Subject: Re: [PATCH v3] x86/fault: Send a SIGBUS to user process always for
 hwpoison page access.
Message-ID: <20210311091941.45790fcf@alex-virtual-machine>
In-Reply-To: <047D5B49-FDBB-494C-81E9-DA811476747D@amacapital.net>
References: <4fc1b4e8f1fb4c8c81f280db09178797@intel.com>
        <047D5B49-FDBB-494C-81E9-DA811476747D@amacapital.net>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsXCFcGooLsqwzPBYMZZIYvPG/6xWbzY0M5o
        MW2juMXm7x1sFpd3zWGzuLfmP6vF6rUNrBbnd61ltbh0YAGTxcXGA4wWW/e3Mloc7z3AZLF5
        01RmizcX7rFY/NjwmNWB3+N7ax+Lx/03f1k8Nq/Q8li85yWTx6ZVnWwemz5NYvd4d+4cu8e8
        k4EeL65uZPF4v+8qm8fnTXIeJ1q+sAbwRHHZpKTmZJalFunbJXBlnLptXvCWp+LWpNPsDYwt
        XF2MnBwSAiYSb96uZ+xi5OIQEpjOJLG9dSkTSEJI4BWjxLxjoSA2i4CqxImV8xlBbDYge9e9
        WawgtoiApsTLKfNZQJqZBU6zSLTt6QYrEhZIljgz6QGYzStgJfFs11k2EJtTwEni/M9PQA0c
        QAsKJKafCAEJ8wuISfRe+c8EcZC9RNuWRVCtghInZz5hAbGZgXa1bv/NDmFrSyxb+JoZ4k5F
        icNLfrFD9CpJHOmewQZhx0osm/eKdQKj8Cwko2YhGTULyagFjMyrGFmKc9ONNjFCIjN0B+OM
        po96hxiZOBgPMUpwMCuJ8Podd0sQ4k1JrKxKLcqPLyrNSS0+xCjNwaIkzrv3mGuCkEB6Yklq
        dmpqQWoRTJaJg1OqgUnQSUF4Voulk8S9KR7SZsJCB/Pd1lufniYo3ZeZE/pGZ9+8rdlMc/pq
        PDoDJ898IVhkrh3iymBRyuAXmmde1PtzmTLPl7j0O9tP8ShbWU7/93Tmottf/u7OSbSaaKFV
        NE/aV6P8dtEGo+KjV529jc5NeihZsqnp7P7qjnU+56tcz6ckeE56qDevpj5zdfmSDX5ztV5O
        bhDwYwzVM7Psk72SHGcUeK2PK8JTbL12mMFBof8fruWLmZ6NkAu+feHhYoboRdcPPfOJyPbK
        yFTSeM/yqsUzUr0j+A1zfPbn1ybp0/4JCTBHzt1enJl/h6nc/Duf/BOXc2e0J7eeD558h709
        Xnk2z7fzD1N85xUpsRRnJBpqMRcVJwIA7iPl1zsDAAA=
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 8 Mar 2021 11:00:28 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > On Mar 8, 2021, at 10:31 AM, Luck, Tony <tony.luck@intel.com> wrote:
> > 
> > ﻿  
> >> 
> >> Can you point me at that SIGBUS code in a current kernel?  
> > 
> > It is in kill_me_maybe().  mce_vaddr is setup when we disassemble whatever get_user()
> > or copy from user variant was in use in the kernel when the poison memory was consumed.
> > 
> >        if (p->mce_vaddr != (void __user *)-1l) {
> >                force_sig_mceerr(BUS_MCEERR_AR, p->mce_vaddr, PAGE_SHIFT);  
> 
> Hmm. On the one hand, no one has complained yet. On the other hand, hardware that supports this isn’t exactly common.
> 
> We may need some actual ABI design here. We also need to make sure that things like io_uring accesses or, more generally, anything using the use_mm / use_temporary_mm ends up either sending no signal or sending a signal to the right target.
> 
> > 
> > Would it be any better if we used the BUS_MCEERR_AO code that goes into siginfo?  
> 
> Dunno.

I have one thought here but don't know if it's proper:

Previous patch use force_sig_mceerr to the user process for such a scenario; with this method
The SIGBUS can't be ignored as force_sig_mceerr() was designed to.

If the user process don't want this signal, will it set signal config to ignore?
Maybe we can use a send_sig_mceerr() instead of force_sig_mceerr(), if process want to
ignore the SIGBUS, then it will ignore that, or it can also process the SIGBUS?

-- 
Thanks!
Aili Yao
