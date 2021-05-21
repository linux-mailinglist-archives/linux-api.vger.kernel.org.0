Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F9F38CEA1
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 22:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhEUUJl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 16:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231295AbhEUUJl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 May 2021 16:09:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 891A961164;
        Fri, 21 May 2021 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621627697;
        bh=L0AZm036/M2K55AooynLRoN6JnWPfVJLPizHslblkdE=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=bdia2dNXMChRT1FrUhPyrH5YTyAz24zzWD6MGdmhXx6rJFOkWOcENC5UuFoJkONpu
         ZRtfuzTVnzfOs8+bisqRrW4QQD0rKBqnxuyNU38TTQo5msofB7NShv3JNEchxjJDKI
         ja5Ne1KwNDdZItIPe+qCrciyDBbEydTNGj6pzSyeis5cqyMERDh+SftNzKqCQJUzDe
         x7J7OzkPGZGUvjj+JLEeMdIelxSRjLzl4rHKjIw/vGElRUpA5chWwXhXPKhmB72en7
         MNtyhWmCl6a3v09I8Owow5kOEnhnuA28ShIzddvKEDSFquLsazf0Y1M2ngPjgmXVY4
         EkNCKmKQdUtIg==
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9660027C0054;
        Fri, 21 May 2021 16:08:15 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Fri, 21 May 2021 16:08:15 -0400
X-ME-Sender: <xms:LROoYMdFsaVNQlbxxYvrJi_TWd47kgTyAa6KrfywLf0FnfG-BMhf2g>
    <xme:LROoYOOblf6yrd54RqI054F--HFw198aw8LAf396OJVvO3tY4w93ob-vWNrOCDs3B
    ItUqFJuspPudhK2vgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdejfedgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:LROoYNipZVZhRxJs1KNGaE0iBAwot-rCCEy7BHv0xTWwxkIyWOiE9w>
    <xmx:LROoYB_N5EfQKoUkBzmR4m4P266lyLfUiBLuall6dHH9Xi_iVhJn-Q>
    <xmx:LROoYIv0jGOqUOZmyuNsdWNqfcKv261uuPsJHFfZv9Vfnfg4yCAq8g>
    <xmx:LxOoYJFKjiodfvx0MIoHTcq5VslWol0HG2xxKAVNl40dizKJDmfZ0EGsnL8waZ6cCQmL9Q>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id A9E8F51C0060; Fri, 21 May 2021 16:08:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <6c9c4597-a1af-4cbb-9dc8-424999d04793@www.fastmail.com>
In-Reply-To: <87k0nraonu.ffs@nanos.tec.linutronix.de>
References: <20210415044258.GA6318@zn.tnic> <20210415054713.GB6318@zn.tnic>
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
 <263a58a9-26d5-4e55-b3e1-3718baf1b81d@www.fastmail.com>
 <87k0nraonu.ffs@nanos.tec.linutronix.de>
Date:   Fri, 21 May 2021 13:07:52 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Dave Hansen" <dave.hansen@intel.com>
Cc:     "Dave Hansen via Libc-alpha" <libc-alpha@sourceware.org>,
        "Len Brown" <lenb@kernel.org>, "Rich Felker" <dalias@libc.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Kyle Huey" <me@kylehuey.com>, "Borislav Petkov" <bp@alien8.de>,
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



On Fri, May 21, 2021, at 12:10 PM, Thomas Gleixner wrote:
> On Fri, May 21 2021 at 09:31, Andy Lutomirski wrote:
> > arch_prctl(SET_XSTATE_INIT_ON_FIRST_USE, TILE_STUFF);?
> >
> > As long as this is allowed to fail, I don=E2=80=99t have a huge prob=
lem with
> > it.
>=20
> I'm fine with that. It's still controlled by the OS and can return
> -EPERM.
>=20
> If allowed then the application would also accept to be insta killed i=
f
> that #NM allocation fails. Any bug report vs. that will be ignored.
>=20
> > I think several things here are regrettable:
> >
> > 1. Legacy XSTATE code might assume that XCR0 is a constant.
> >
> > 2. Intel virt really doesn=E2=80=99t like us context switching XCR0,=
 although
> > we might say that this is Intel=E2=80=99s fault and therefore Intel=E2=
=80=99s
> > problem. AMD hardware doesn=E2=80=99t appear to have this issue.
> >
> > 3. AMX bring tangled up in XSTATE is unfortunate.  The whole XSTATE
> > mechanism is less than amazing.
> >
> > IMO the best we can make of this whole situation is to make XCR0
> > dynamic, but the legacy compatibility issues are potentially
> > problematic.
>=20
> Why? The bit can be enabled and #NM catches the violation of the ABI
> contract if the application did not request usage. No XCR0 fiddling on=

> context switch required.
>=20
> Thanks,
>=20
>         tglx
>=20
>=20
>=20

XFD does nothing about signals.  It also doesn=E2=80=99t help give appli=
cations a non-Linux-specific way to ask if AMX is available. The SDM say=
s that one can read XCR0.  Sure, we can use it, but cross platform libra=
ries seem likely to get it wrong.
