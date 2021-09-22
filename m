Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBD414D10
	for <lists+linux-api@lfdr.de>; Wed, 22 Sep 2021 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbhIVPgR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Sep 2021 11:36:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236429AbhIVPgR (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 22 Sep 2021 11:36:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 806EF61168;
        Wed, 22 Sep 2021 15:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632324887;
        bh=xFQo9lM17aSuzFSISevtYQSbPe53mGBV8+WNabxdSM4=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=CGYxEmVvdGglQjpPG2tO8ZpeKdFGhE7N2qSVJzoQRy3lFyu6dbPp5xYE203OosxuE
         ktOOqgL7JPKq1dDHn3iwxcOIQqxZAZQfh70hsg3hNqdOvWmcr93YHNhFYWU1atmbym
         XeJHSxkNtWib1xArlzV5AaGcUzusp7S/uAyzh3wPovBXyAq/ky++121J/g0pr7air3
         YHhn56Cr5wspORIUL0vSEVqOzNIaisZ+jWgJ9pp08AgIFbQj9JnBQxJP9x2nNutKmA
         04TOW1ZJ4WdkxZ6LD7IolJuHYl2SXRX70ROMUO0w/iCfmh88g4XUik/D4jgEnkuDvX
         Hltj0KwYG2dng==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id A360627C0054;
        Wed, 22 Sep 2021 11:34:45 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Wed, 22 Sep 2021 11:34:45 -0400
X-ME-Sender: <xms:FU1LYaTFP7c6pAGmEJN5N0n4AC1og761pEMaqnPvnUzpUQLm3qIrHg>
    <xme:FU1LYfya3gSKnbagApg98igoDY3ddoEr25OgWRHaKL4rw73ymvWei7M-6IxuqYBaf
    CLlSZx61zOlvuoyzHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:FU1LYX29tnHH8uA2hTHMp4AeAMupr0QIjgLEimc3PPdUOaIhMGTlsg>
    <xmx:FU1LYWBoLPNbmOHABj8xfaUvtNoRU_pOYt1jTvFnnafgc2LerzVefw>
    <xmx:FU1LYTh1ciTnuARuvsfDCghLJ8aptmefQXcIKZT3rd8tX8ZFuDj5FQ>
    <xmx:FU1LYQv2DMoBal2WfT1TuAzUthihFmNByU9_HS35IvvvlP1PCJuh3A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E87CF21E0062; Wed, 22 Sep 2021 11:34:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <59e230b3-0e85-42ff-84a8-6b30ad0719d8@www.fastmail.com>
In-Reply-To: <20210922122523.72ypzg4pm2x6nkod@wittgenstein>
References: <705fde50-37a6-49ed-b9c2-c9107cd88189@t-8ch.de>
 <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
 <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
 <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
 <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
 <YUi95tFDWS7oceYP@bombadil.infradead.org>
 <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
 <20210922122523.72ypzg4pm2x6nkod@wittgenstein>
Date:   Wed, 22 Sep 2021 08:34:23 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Christian Brauner" <christian.brauner@ubuntu.com>
Cc:     "Luis Chamberlain" <mcgrof@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
        "Linux API" <linux-api@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Jessica Yu" <jeyu@kernel.org>
Subject: Re: [RFC] Expose request_module via syscall
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 22, 2021, at 5:25 AM, Christian Brauner wrote:
> On Mon, Sep 20, 2021 at 11:36:47AM -0700, Andy Lutomirski wrote:
>> On Mon, Sep 20, 2021 at 11:16 AM Luis Chamberlain <mcgrof@kernel.org>=
 wrote:
>> >
>> > On Mon, Sep 20, 2021 at 04:51:19PM +0200, Thomas Wei=C3=9Fschuh wro=
te:
>>=20
>> > > > Do you mean it literally invokes /sbin/modprobe?  If so, hookin=
g this
>> > > > at /sbin/modprobe and calling out to the container manager seem=
s like
>> > > > a decent solution.
>> > >
>> > > Yes it does. Thanks for the idea, I'll see how this works out.
>> >
>> > Would documentation guiding you in that way have helped? If so
>> > I welcome a patch that does just that.
>>=20
>> If someone wants to make this classy, we should probably have the
>> container counterpart of a standardized paravirt interface.  There
>> should be a way for a container to, in a runtime-agnostic way, issue
>> requests to its manager, and requesting a module by (name, Linux
>> kernel version for which that name makes sense) seems like an
>> excellent use of such an interface.
>
> I always thought of this in two ways we currently do this:
>
> 1. Caller transparent container manager requests.
>    This is the seccomp notifier where we transparently handle syscalls
>    including intercepting init_module() where we parse out the module =
to
>    be loaded from the syscall args of the container and if it is
>    allow-listed load it for the container otherwise continue the sysca=
ll
>    letting it fail or failing directly through seccomp return value.

Specific problems here include aliases and dependencies.  My modules.ali=
as file, for example, has:

alias net-pf-16-proto-16-family-wireguard wireguard

If I do modprobe net-pf-16-proto-16-family-wireguard, modprobe parses so=
me files in /lib/modules/`uname -r` and issues init_module() asking for =
'wireguard'.  So hooking init_module() is at the wrong layer -- for that=
 to work, the container's /sbin/modprobe needs to already have figured o=
ut that the desired module is wireguard and have a .ko for it.

>
> 2. A process in the container explicitly calling out to the container
>    manager.
>    One example how this happens is systemd-nspawn via dbus messages
>    between systemd in the container and systemd outside the container =
to
>    e.g. allocate a new terminal in the container (kinda insecure but
>    that's another issue) or other stuff.
>
> So what was your idea: would it be like a device file that could be
> exposed to the container where it writes requestes to the container
> manager? What would be the advantage to just standardizing a socket
> protocol which is what we do for example (it doesn't do module loading
> of course as we handle that differently):

My idea is standardizing *something*.  I think it would be nice if, for =
example, distros could ship a /sbin/modprobe that would do the right thi=
ng inside any compliant container runtime as well as when running outsid=
e a container.

I suppose container managers could also bind-mount over /sbin/modprobe, =
but that's more intrusive.

