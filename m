Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B4415123
	for <lists+linux-api@lfdr.de>; Wed, 22 Sep 2021 22:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhIVUJj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Sep 2021 16:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:52886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237792AbhIVUIn (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 22 Sep 2021 16:08:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F037D6120F;
        Wed, 22 Sep 2021 20:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632341232;
        bh=EUDv/d1z0+Yk3qR9RCf+lUMDPezno7R23Coza2AStXw=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=S+xED0a/uPB0/Xg5j1sgWSuL2K8cTZOmXac4v2rAGlAgLV4wxIZd9MZxxrEl+xdt2
         bi67aJ7G2QhSzv+8oMAjgS4gPtXBraDGmPWUAiMYhsKc94/z0K19KdytTHjmY60She
         VWeD0laDrf+xiSLYilTE3JkhSAQYn7lmN+KfsHSmX23rhWozb7lYxwtq9aGAFoaMuH
         yae+e7lCij8fVRUBUjvyfnwPwNzNrQTT2qGtDbuAC0ZwAg0gW4jf72K0ansu8b5Xsd
         DXYGNKrur2oqz2hwtJnmBmMG74+UqiLm36v9laACrVdhpKuBoTrXDpLmkRXNnL6AQ3
         2L0p+ihz4klEg==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0A9C327C005B;
        Wed, 22 Sep 2021 16:07:11 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute6.internal (MEProxy); Wed, 22 Sep 2021 16:07:11 -0400
X-ME-Sender: <xms:7oxLYaBxxqK4obnXad4C7Ol1pEzQ2wO3VTgVX07lksiIiiW6MOAzEA>
    <xme:7oxLYUg9CmAX57-4BFdWVc1wVCtNPt_l1cMPkyXIB-hb5NDvcSMOXT32LItalPJ0E
    ab6XD-nw-FKuRFghz8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    nhguhicunfhuthhomhhirhhskhhifdcuoehluhhtoheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedvleehjeejvefhuddtgeegffdtjedtffegveethedvgfejieev
    ieeufeevuedvteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegrnhguhidomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudduiedu
    keehieefvddqvdeifeduieeitdekqdhluhhtoheppehkvghrnhgvlhdrohhrgheslhhinh
    hugidrlhhuthhordhush
X-ME-Proxy: <xmx:7oxLYdkfK_3gvwX7TUxRnFARMDnXZxxli_rJGQ95kZOfXs4BhvZ6qg>
    <xmx:7oxLYYzx6FhnQiNrNa8fLbZH777WZTuy5sOOryiUrfaj6ikfavSz0Q>
    <xmx:7oxLYfRkhnX45a8ZcOFZi7zcFrkGFrVOfJ7voUfhwpA-lFLKWmVevQ>
    <xmx:74xLYZfG5NGsT5YOB1YphMRJtJfjkfJ9FeqkRxSQ_ueak3BejFrc4g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 7BA7F21E0063; Wed, 22 Sep 2021 16:07:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1302-gc62ab821ef-fm-20210921.001-gc62ab821
Mime-Version: 1.0
Message-Id: <0f209e1c-3d5c-46be-b5e7-323970112a8e@www.fastmail.com>
In-Reply-To: <20210922155253.nj5dorsyv7loduws@wittgenstein>
References: <CALCETrUM0cko=5ki-Dd402DNFU2TmgnJTz_vfrsaofkGD-1kmA@mail.gmail.com>
 <20210916092719.v4pkhhugdiq7ytcp@wittgenstein>
 <2ebf1a9d-77d5-472b-a99a-b141654725da@www.fastmail.com>
 <6eff0e8a-4965-437d-9273-1d9d73892e1a@t-8ch.de>
 <CALCETrWA1TBvbknH1Jzt=newTd4sHzNFm0RPuRxazjuRQRsR7w@mail.gmail.com>
 <8cbf0703-5734-4e92-a6cc-12de69094f95@t-8ch.de>
 <YUi95tFDWS7oceYP@bombadil.infradead.org>
 <CALCETrX9keVFxEZYUkKr7_dWb9Ubo9q4E2aTY_ZOWGSHyRph8g@mail.gmail.com>
 <20210922122523.72ypzg4pm2x6nkod@wittgenstein>
 <59e230b3-0e85-42ff-84a8-6b30ad0719d8@www.fastmail.com>
 <20210922155253.nj5dorsyv7loduws@wittgenstein>
Date:   Wed, 22 Sep 2021 13:06:49 -0700
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



On Wed, Sep 22, 2021, at 8:52 AM, Christian Brauner wrote:
> On Wed, Sep 22, 2021 at 08:34:23AM -0700, Andy Lutomirski wrote:
>> On Wed, Sep 22, 2021, at 5:25 AM, Christian Brauner wrote:
>> > On Mon, Sep 20, 2021 at 11:36:47AM -0700, Andy Lutomirski wrote:
>> >> On Mon, Sep 20, 2021 at 11:16 AM Luis Chamberlain <mcgrof@kernel.o=
rg> wrote:
>> >> >
>> >> > On Mon, Sep 20, 2021 at 04:51:19PM +0200, Thomas Wei=C3=9Fschuh =
wrote:
>> >>=20
>> >> > > > Do you mean it literally invokes /sbin/modprobe?  If so, hoo=
king this
>> >> > > > at /sbin/modprobe and calling out to the container manager s=
eems like
>> >> > > > a decent solution.
>> >> > >
>> >> > > Yes it does. Thanks for the idea, I'll see how this works out.
>> >> >
>> >> > Would documentation guiding you in that way have helped? If so
>> >> > I welcome a patch that does just that.
>> >>=20
>> >> If someone wants to make this classy, we should probably have the
>> >> container counterpart of a standardized paravirt interface.  There
>> >> should be a way for a container to, in a runtime-agnostic way, iss=
ue
>> >> requests to its manager, and requesting a module by (name, Linux
>> >> kernel version for which that name makes sense) seems like an
>> >> excellent use of such an interface.
>> >
>> > I always thought of this in two ways we currently do this:
>> >
>> > 1. Caller transparent container manager requests.
>> >    This is the seccomp notifier where we transparently handle sysca=
lls
>> >    including intercepting init_module() where we parse out the modu=
le to
>> >    be loaded from the syscall args of the container and if it is
>> >    allow-listed load it for the container otherwise continue the sy=
scall
>> >    letting it fail or failing directly through seccomp return value.
>>=20
>> Specific problems here include aliases and dependencies.  My modules.=
alias file, for example, has:
>>=20
>> alias net-pf-16-proto-16-family-wireguard wireguard
>>=20
>> If I do modprobe net-pf-16-proto-16-family-wireguard, modprobe parses=
 some files in /lib/modules/`uname -r` and issues init_module() asking f=
or 'wireguard'.  So hooking init_module() is at the wrong layer -- for t=
hat to work, the container's /sbin/modprobe needs to already have figure=
d out that the desired module is wireguard and have a .ko for it.
>
> You can't use the container's .ko module. For this you would need to
> trust the image that the container wants you to load. The container
> manager should always load a host module.
>

Agreed.=20

>>=20
>> >
>> > 2. A process in the container explicitly calling out to the contain=
er
>> >    manager.
>> >    One example how this happens is systemd-nspawn via dbus messages
>> >    between systemd in the container and systemd outside the contain=
er to
>> >    e.g. allocate a new terminal in the container (kinda insecure but
>> >    that's another issue) or other stuff.
>> >
>> > So what was your idea: would it be like a device file that could be
>> > exposed to the container where it writes requestes to the container
>> > manager? What would be the advantage to just standardizing a socket
>> > protocol which is what we do for example (it doesn't do module load=
ing
>> > of course as we handle that differently):
>>=20
>> My idea is standardizing *something*.  I think it would be nice if, f=
or example, distros could ship a /sbin/modprobe that would do the right =
thing inside any compliant container runtime as well as when running out=
side a container.
>>=20
>> I suppose container managers could also bind-mount over /sbin/modprob=
e, but that's more intrusive.
>
> I don't see this is a big issue because that is fairly trivial.
> I think we never want to trust the container's modules.
> What probably should be happening is that the manager exposes a list of
> modules the container can request in some form. We have precedence for
> doing something like this.
> So now modprobe and similar tools can be made aware that if they are in
> a container they should request that module from the container manager
> be it via a socket request or something else.
> Nesting will be a bit funny but can probably be made to work by just
> bind-mounting the outermost socket into the container or relaying the
> request.

Why bother with a list?  I think it should be sufficient for the contain=
er to ask for a module and either get it or not get it.
