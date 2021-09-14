Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2910740B70F
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 20:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhINSlp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 14:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhINSlo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 14 Sep 2021 14:41:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B0654610E6;
        Tue, 14 Sep 2021 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631644826;
        bh=l7C56GEOC+aCw6hs43x4MKGepxIPQ/bOtEDY/hCzwNQ=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=eLekWCKFBxK4cA+J4J+PVXVWpATAWAY8FORxhwkJ193WGqfguIhEIf5BR0syRlowU
         l/WCM/7O2A6rjqREoXDqhQrEcq+t6DrjwoIE9ffSc0ovJ5sCFJB347WfXp21JOuPmN
         b4hDChbeD+fQyuL4lqZr6QWpyR1FsOBNc8NFOun1m4vhRFfDnp2mVgcJLVmHOOars+
         QMeyzo5eJsWQu0TNkk4gYNoO/6yty/k9x9szkhdlwTOiitTRahdLWYxQevO2QYATdz
         YhVB6wkOblGy5q5soUjtDUnW4H2XBlRpv5UeTE3Ls3wRBF48Ijo8txx/7sw+hVgqIl
         49TOqkwUb1wAw==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id CE00B27C0054;
        Tue, 14 Sep 2021 14:40:24 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Tue, 14 Sep 2021 14:40:24 -0400
X-ME-Sender: <xms:l-xAYd4-h5qAKx4EUeas2immw3-tDeP0V3xnPhi-qlt2hzKGNIHKdg>
    <xme:l-xAYa5Urw6Nkn6eI-ESxdFC2L3KNspMNkPEIJmFexNlNMOTjSoyDYMkOJv6-pNgJ
    y1JT7-7cWcZwoxGtlI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegledguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:l-xAYUe6g7JP8B6UQ5jhjFySNQgGYxuzWfDDK5_fWfLW4Y0R_vwI8g>
    <xmx:l-xAYWKGyeuTQ2XB8HO_a34Dayp7Qk0ATv9AuZpMNwmvyQW1h2iRmw>
    <xmx:l-xAYRIIJo5m2sGPdNiTo7oLvgMK0tWY38qnspjSmtdua4mkcljZtA>
    <xmx:mOxAYaUDtTJ9m5CjWeBoZCY5l55HKTKhrCwOOhhUlSdPPlgDF2EIrW0IgU4>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7823AA002E4; Tue, 14 Sep 2021 14:40:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <f6fdecfe-963d-4669-ae05-1d7192467a19@www.fastmail.com>
In-Reply-To: <YUDlzxLjNsW+oYGC@hirez.programming.kicks-ass.net>
References: <20210908184905.163787-1-posk@google.com>
 <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com>
 <d656e605-4f89-4ea2-8baf-f7786f0630d9@www.fastmail.com>
 <YUDlzxLjNsW+oYGC@hirez.programming.kicks-ass.net>
Date:   Tue, 14 Sep 2021 11:40:01 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     "Jann Horn" <jannh@google.com>, "Peter Oskolkov" <posk@google.com>,
        "Peter Oskolkov" <posk@posk.io>, "Ingo Molnar" <mingo@redhat.com>,
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



On Tue, Sep 14, 2021, at 11:11 AM, Peter Zijlstra wrote:
> On Tue, Sep 14, 2021 at 09:52:08AM -0700, Andy Lutomirski wrote:
> > With a custom mapping, you don=E2=80=99t need to pin pages at all, I=
 think.
> > As long as you can reconstruct the contents of the shared page and
> > you=E2=80=99re willing to do some slightly careful synchronization, =
you can
> > detect that the page is missing when you try to update it and skip t=
he
> > update. The vm_ops->fault handler can repopulate the page the next
> > time it=E2=80=99s accessed.
>=20
> The point is that the moment we know we need to do this user-poke, is
> schedule(), which could be called while holding mmap_sem (it being a
> preemptable lock). Which means we cannot go and do faults.

That=E2=80=99s fine. The page would be in one or two states: present and=
 writable by kernel or completely gone. If its present, the scheduler wr=
ites it. If it=E2=80=99s gone, the scheduler skips the write and the nex=
t fault fills it in.

>=20
> > All that being said, I feel like I=E2=80=99m missing something. The =
point of
> > this is to send what the old M:N folks called =E2=80=9Cscheduler act=
ivations=E2=80=9D,
> > right?  Wouldn=E2=80=99t it be more efficient to explicitly wake som=
ething
> > blockable/pollable and write the message into a more efficient data
> > structure?  Polling one page per task from userspace seems like it
> > will have inherently high latency due to the polling interval and wi=
ll
> > also have very poor locality.  Or am I missing something?
>=20
> The idea was to link the user structures together in a (single) linked
> list. The server structure gets a list of all the blocked tasks. This
> avoids having to a full N iteration (like Java, they're talking stupid
> number of N).
>=20
> Polling should not happen, once we run out of runnable tasks, the serv=
er
> task gets ran again and it can instantly pick up all the blocked
> notifications.
>=20

How does the server task know when to read the linked list?  And what=E2=
=80=99s wrong with a ring buffer or a syscall?
