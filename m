Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD338CB0D
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 18:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhEUQdP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 12:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230119AbhEUQdO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 May 2021 12:33:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C343613AD;
        Fri, 21 May 2021 16:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621614711;
        bh=oxjGhdUOBodTprFXEf43FPxyTig36c7rbVQyBkMzWLg=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=jzlbG+n+3RHUHPR9mV9Jc108G578I6y623BdePDmtYmpwSHVZGbcGoiY+QtvobDlu
         W0CGj2p1PYCX29TKhS3xIIwXVtkO6kqgazbIfoHzUDKLnJ6v9cIMTlLJDNl7OL29XH
         d9ZKECx3M6AsYMc4g5/yViCPxLHKK3OOcwWDjLFqDFDRBC5ijwWy/Cdz1Ll/ZuM1lB
         b/YkisaLXur2Po7/imHwgzyQeV7j0noQioozwVWexlPwJsix838QROriKeLBsj/rvs
         6zSPQK6Afqa+qqybmJSghHKct9CH1zvAQ5maz4vdAzcVldR34b3wzwkW3HWIbSDN+X
         2PLIGLiGJD+JQ==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 417E527C0054;
        Fri, 21 May 2021 12:31:49 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Fri, 21 May 2021 12:31:49 -0400
X-ME-Sender: <xms:c-CnYIc_XC8ij_7gHqu6_i1CSVjZlkxdbRCL5AONgo54zBkpJmDRuA>
    <xme:c-CnYKNyxPXkL1VT4rcXZRJbYtwc3DGd2J3Bymnl23evbf-Yj0X8tI1q1iyAo8dqG
    W_JoubhATgYbJoYVJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:c-CnYJiZRyMfZoSjnen747H3Fn4SarzX7epw3dfUIOkB5krGI2hvgQ>
    <xmx:c-CnYN9hfgbiwV6dOUCN2CphWPgSJW2713mwaTpCAwCSRLSHWOqgAQ>
    <xmx:c-CnYEvKlSfNAQNv1CMOaaTTog0RIUDd3-0Spq9cFm2Bn1b2OrJ9Vg>
    <xmx:deCnYFHmKdZBcfw-pgsAsbynHbOZh_7LY03DOG3G0tzEtpPU0Eo9B3QGF5TLjX8Igtsiag>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E34EF51C0060; Fri, 21 May 2021 12:31:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com>
In-Reply-To: <87r1i06ow2.fsf@oldenburg.str.redhat.com>
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic>
 <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
 <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic>
 <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic>
 <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic>
 <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
 <874kf11yoz.ffs@nanos.tec.linutronix.de>
 <CAJvTdKkYp+zP_9tna6YsrOz2_nmEUDLJaL_i-SNog0m2T9wZ=Q@mail.gmail.com>
 <87k0ntazyn.ffs@nanos.tec.linutronix.de>
 <37833625-3e6b-5d93-cc4d-26164d06a0c6@intel.com>
 <CAJvTdKmqzO4P9k3jqRA=dR+B7yV72hZCiyC8HGQxDKZBnXgzZQ@mail.gmail.com>
 <9c8138eb-3956-e897-ed4e-426bf6663c11@intel.com>
 <87pmxk87th.fsf@oldenburg.str.redhat.com>
 <939ec057-3851-d8fb-7b45-993fa07c4cb5@intel.com>
 <87r1i06ow2.fsf@oldenburg.str.redhat.com>
Date:   Fri, 21 May 2021 09:31:26 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Florian Weimer" <fweimer@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     "Dave Hansen via Libc-alpha" <libc-alpha@sourceware.org>,
        "Len Brown" <lenb@kernel.org>, "Rich Felker" <dalias@libc.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Kyle Huey" <me@kylehuey.com>, "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Keno Fischer" <keno@juliacomputing.com>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        "Willy Tarreau" <w@1wt.eu>
Subject: =?UTF-8?Q?Re:_Candidate_Linux_ABI_for_Intel_AMX_and_hypothetical_new_rel?=
 =?UTF-8?Q?ated_features?=
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Fri, May 21, 2021, at 9:19 AM, Florian Weimer wrote:
> * Dave Hansen:
>=20
> > On 5/21/21 7:44 AM, Florian Weimer wrote:
> >> * Dave Hansen via Libc-alpha:
> >>> Our system calls are *REALLY* fast.  We can even do a vsyscall for=
 this
> >>> if we want to get the overhead down near zero.  Userspace can also=
 cache
> >>> the "I did the prctl()" state in thread-local storage if it wants =
to
> >>> avoid the syscall.
> >> Why can't userspace look at XCR0 to make the decision?
> >
> > The thing we're trying to avoid is a #NM exception from XFD (the new=

> > first-use detection feature) that occurs on the first use of AMX.
> > XCR0 will have XCR0[AMX]=3D1, even if XFD is "armed" and ready to
> > generate the #NM.
>=20
> I see.  So essentially the hardware wants to offer transparent
> initialize-on-use, but Linux does not seem to want to implement it thi=
s
> way.
>=20
> Is there still a chance to bring the hardware and Linux into alignment=
?

arch_prctl(SET_XSTATE_INIT_ON_FIRST_USE, TILE_STUFF);?

As long as this is allowed to fail, I don=E2=80=99t have a huge problem =
with it.

I think several things here are regrettable:

1. Legacy XSTATE code might assume that XCR0 is a constant.

2. Intel virt really doesn=E2=80=99t like us context switching XCR0, alt=
hough we might say that this is Intel=E2=80=99s fault and therefore Inte=
l=E2=80=99s problem. AMD hardware doesn=E2=80=99t appear to have this is=
sue.

3. AMX bring tangled up in XSTATE is unfortunate.  The whole XSTATE mech=
anism is less than amazing.

IMO the best we can make of this whole situation is to make XCR0 dynamic=
, but the legacy compatibility issues are potentially problematic.

>=20
> Thanks,
> Florian
>=20
>=20
