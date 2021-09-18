Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B1E410823
	for <lists+linux-api@lfdr.de>; Sat, 18 Sep 2021 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbhIRSsz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Sep 2021 14:48:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233539AbhIRSsy (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 18 Sep 2021 14:48:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65F6F61179;
        Sat, 18 Sep 2021 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631990850;
        bh=sXrYWbDc0/zJ0anCv51/5CNRbVEo3f9JGglXRPxPPnA=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=IdW+hk+BdQ3c7S5r7ksVpU82/PMuLZlO9m5uoovA+dNs1ms7+dEoxBTn52xD9n2fT
         HURKFY2hnynlkwfIynCZgt9JVfJTTbaKCEw4++I06j4XXTJpSkn2OcKsi580V+/WEJ
         dT0vWJQWH+7+QEZlJjsBBsBqTcfMvHz5ejEvLtiTVm9le/XFhPlnON1INt0JM4pWbi
         MPWVnob20dwicujY8lQtONaoO5vPjid/ThSLbSvFwnACEScXi+ci244zUVrd1/kefF
         xfjIBp9YQJyu2c6z6GOaSZzbHIaUfcVr0++juekEqPMCYLRpedFQPHrdo7yGqyDEhu
         q3ealWrITjYQQ==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 864AD27C0054;
        Sat, 18 Sep 2021 14:47:29 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute6.internal (MEProxy); Sat, 18 Sep 2021 14:47:29 -0400
X-ME-Sender: <xms:QTRGYY3dQj8ySfv3KUUmDu5wGENHPR5Ut7oLYBfsgRTl7f1a_Vwmug>
    <xme:QTRGYTEfd87V0qCpUZYwWwX0pArJv_Bgd5QctnXqu4BcBh0_IMik4haqglsd660pB
    Xz5FNfw-KQ_0clEfXU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehkedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:QTRGYQ6mSiXKQHFsFxPqAh4ud6fBKgSdGUFA0KwvbwjOC7zDWxRahw>
    <xmx:QTRGYR20xG_8MsZVvPpC0NVWKtov1YjtFfUk8oP_trJHKd4jc69dpQ>
    <xmx:QTRGYbGCkr13Ht5MgQJR0TiLq2dINde7A-FDzgSJTLAa1fCUWv6ZKA>
    <xmx:QTRGYTBUQc-exRLjdbEusRghXGpQaFaAWDkD9RhJVyL8sKZwbfCURw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id F2BEFA03DC4; Sat, 18 Sep 2021 14:47:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1291-gc66fc0a3a2-fm-20210913.001-gc66fc0a3
Mime-Version: 1.0
Message-Id: <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
In-Reply-To: <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
Date:   Sat, 18 Sep 2021 11:47:07 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Christian Brauner" <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Luis Chamberlain" <mcgrof@kernel.org>,
        "Jessica Yu" <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On Thu, Sep 16, 2021, at 2:27 AM, Christian Brauner wrote:
> On Wed, Sep 15, 2021 at 09:47:25AM -0700, Andy Lutomirski wrote:
> > On Wed, Sep 15, 2021 at 8:50 AM Thomas Wei=C3=9Fschuh <thomas@t-8ch.=
de> wrote:
> > >
> > > Hi,
> > >
> > > I would like to propose a new syscall that exposes the functionali=
ty of
> > > request_module() to userspace.
> > >
> > > Propsed signature: request_module(char *module_name, char **args, =
int flags);
> > > Where args and flags have to be NULL and 0 for the time being.
> > >
> > > Rationale:
> > >
> > > We are using nested, privileged containers which are loading kerne=
l modules.
> > > Currently we have to always pass around the contents of /lib/modul=
es from the
> > > root namespace which contains the modules.
> > > (Also the containers need to have userspace components for modulel=
oading
> > > installed)
> > >
> > > The syscall would remove the need for this bookkeeping work.
> >=20
> > I feel like I'm missing something, and I don't understand the purpose
> > of this syscall.  Wouldn't the right solution be for the container to
> > have a stub module loader (maybe doable with a special /sbin/modprobe
> > or maybe a kernel patch would be needed, depending on the exact use
> > case) and have the stub call out to the container manager to request
> > the module?  The container manager would check its security policy a=
nd
> > load the module or not load it as appropriate.
>=20
> I don't see the need for a syscall like this yet either.
>=20
> This should be the job of the container manager. modprobe just calls t=
he
> init_module() syscall, right?

Not quite so simple. modprobe parses things in /lib/modules and maybe /e=
tc to decide what init_module() calls to do.

But I admit I=E2=80=99m a bit confused.  What exactly is the container d=
oing that causes the container=E2=80=99s copy of modprobe to be called?

>=20
> If so the seccomp notifier can be used to intercept this system call f=
or
> the container and verify the module against an allowlist similar to how
> we currently handle mount.
>=20
> Christian
>=20
