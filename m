Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6BA104498
	for <lists+linux-api@lfdr.de>; Wed, 20 Nov 2019 20:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfKTTwX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Nov 2019 14:52:23 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:29107 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKTTwW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 20 Nov 2019 14:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574279540;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=LeodlJc2E0O1WN5oYZY2L3ih1kyEFugDWGrCoq/S39M=;
        b=ruprINJH9bhaV2VGvM41XuV/8huZ76KYqhD2WHYIyFx+E9yqRcQ7eOK7AnMgrMQsx5
        e9qpTE3GHrhs/g4wbHFV5NdpcoBBuyzqRa56Q8EfJUXN2Ywff2Z5J+8wgnwx398AK8xg
        hav/iGWI6MyayuOet6rCfbZhMAe7VicD+du4i3hKBHt8wL+aiN1NBzSgis0YUE+fMA+6
        QrzEGLh4YRGJKuCqvufjPvsOWvRj1bbUpXQ4WTpTQFgzVcv1gRr9KMgs+BJ8h5lSY8Sk
        6uNTnXJEC7DMSpyVoYJs+ciXsmOuMwTE/7FRZWFLEXcDFyC2xglZPF0UidMwrUQ4E3hF
        g2ow==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbL/ScbtM="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAKJpBmvw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 20 Nov 2019 20:51:11 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Willy Tarreau <w@1wt.eu>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
Date:   Wed, 20 Nov 2019 20:51:11 +0100
Message-ID: <1695782.oZ5Vf4nH9s@positron.chronox.de>
In-Reply-To: <20191120132918.GA2892197@kroah.com>
References: <5390778.VeFRgus4bQ@positron.chronox.de> <19681012.svDddlc5pN@positron.chronox.de> <20191120132918.GA2892197@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Mittwoch, 20. November 2019, 14:29:18 CET schrieb Greg Kroah-Hartman:

Hi Greg,

> On Wed, Nov 20, 2019 at 09:58:35AM +0100, Stephan M=FCller wrote:
> > Am Dienstag, 19. November 2019, 13:41:50 CET schrieb Greg Kroah-Hartman:
> >=20
> > Hi Greg,
> >=20
> > > On Tue, Nov 19, 2019 at 02:07:40AM -0800, Andy Lutomirski wrote:
> > > > > As this would introduce a new device file now, is there a special
> > > > > process that I need to follow or do I need to copy? Which
> > > > > major/minor
> > > > > number should I use?
> > > > >=20
> > > > > Looking into static const struct memdev devlist[] I see
> > > > >=20
> > > > >          [8] =3D { "random", 0666, &random_fops, 0 },
> > > > >          [9] =3D { "urandom", 0666, &urandom_fops, 0 },
> > > > >=20
> > > > > Shall a true_random be added here with [10]?
> > > >=20
> > > > I am not at all an expert on chardevs, but this sounds generally
> > > > reasonable.  gregkh is probably the real authority here.
> > >=20
> > > [10] is the aio char device node, so you better not try to overlap it=
 or
> > > bad things will happen :(
> >=20
> > Thanks for your insights.
> >=20
> > Which device minor number could we use?
>=20
> Get your own dynamic one by using a misc device if you _REALLY_ want to
> add yet-another-char-node-for-random-data.
>=20
> But I would have thought that we all realize that this is not the way to
> do things.  Let's not have "random", "urandom", and "true_random" be
> something we want to totally confuse userspace with, that way is insane.
>=20
> Please just make the existing userspace api "just work", don't add to
> the mess.

Thank you, I think we should follow that advise.

With that and considering Alexander's rightful remark we have a challenge. =
So,=20
changing the syscall may not be the right way unless we find a way to restr=
ict=20
the permissions somehow (capability? LSM? None of that seems to be a good=20
fit).

What about providing a /sys file? I.e. adding a file that:

a) has permissions 440 per default and maybe the ownership of root:root

b) allow user space to perform a chown/chgrp

c) only supports reading of data from user space

But then, how could we provide a common interface for the existing random.c=
=20
and the LRNG?

Or should we use a proc file for that? If yes, I guess it should not be a=20
sysctl, but a "regular" proc file that should allow a chown(2) operation. O=
n=20
the other hand, is proc the right place to provide a user space interface f=
or=20
exporting data to user?

Thanks a lot.

Ciao
Stephan


