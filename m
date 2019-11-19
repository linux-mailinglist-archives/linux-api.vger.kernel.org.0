Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4930102264
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2019 11:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfKSK5W (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 19 Nov 2019 05:57:22 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.80]:30729 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfKSK5W (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 19 Nov 2019 05:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574161039;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WnvWEcD1OrisdQgGt5N9I3ouD0nZvk5Ggwkbt0h9+NM=;
        b=PQ3F5gHzfWRsdXUMqQBIHETC07qc1jHFDZUSMFCejtlKP7vFn9iMan8Pisuo/mPFhc
        OhR8tshwaBoyr6673hfVB1NwaPDXA10atBcnSTbTpXqLhndus48Cq2zhAH0HQhE7i+O+
        nVJViTOYC2RFi2Xgkz0OUno2cuMMBROiowZ9ndUDWN/3Jc6lse/AAxEoPafQUkyO2xH4
        qisGi9xvAyjXspSeDAY3vSG4pyerXDq/ISl+eFwlZoIw+wITIgCJMDPU1kGd92sUgAuV
        QVVgjq8aIqVP2ie9tpiZifKBinWPQj3D+y9iyZsf00rXk1gz2bSEEQN8gcXilYjGHOXt
        qkDw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zT8DNpa83PTIPmLqL6mXsiNby0r49Q+bn6Gzw6e9E9jMEY/jj9Sk"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id N09a57vAJAtTetb
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 19 Nov 2019 11:55:29 +0100 (CET)
From:   Stephan Mueller <smueller@chronox.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v25 03/12] LRNG - /proc interface
Date:   Tue, 19 Nov 2019 11:55:23 +0100
Message-ID: <5323691.yyFvDVlHDV@tauon.chronox.de>
In-Reply-To: <CALCETrVXGuShozaf5RpgmQnwtTpAbmaTVny+E0q8OE4OLuWwAQ@mail.gmail.com>
References: <2476454.l8LQlgn7Hv@positron.chronox.de> <3043322.Kq9igzfA0K@positron.chronox.de> <CALCETrVXGuShozaf5RpgmQnwtTpAbmaTVny+E0q8OE4OLuWwAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 19. November 2019, 11:06:02 CET schrieb Andy Lutomirski:

Hi Andy,

> On Sun, Nov 17, 2019 at 4:16 AM Stephan M=C3=BCller <smueller@chronox.de>=
 wrote:
> > Am Samstag, 16. November 2019, 17:39:40 CET schrieb Andy Lutomirski:
> >=20
> > Hi Andy,
> >=20
> > > > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.=
de>
> > > > wrote:
> > > >=20
> > > > =EF=BB=BFThe LRNG /proc interface provides the same files as the le=
gacy
> > > > /dev/random. These files behave identically. Yet, all files are
> > > > documented at [1].
> > >=20
> > > Why?
> >=20
> > I am not sure here: are you referring to the documentation? Or the one
> > additional file?
> >=20
> > If it is the documentation, do you want me to add it to the patch
> > description? I initially did not add it as these files were present and
> > seemingly known what they provide. But I would add that documentation to
> > the patch description if this is desired.
>=20
> Sorry, I should have been a lot more explicit.  Why do you want to add
> a new interface to read the RNG?  What's wrong with the old one?

There is nothing wrong at all. I actually want to be 100% API and ABI=20
compliant with the existing random.c. Thus, the list of the sysctls are=20
identical to the existing random.c with the same behavior (hence I skipped =
the=20
documentation of these files).

Yet, the wiring up of the interfaces to internal data structures and handle=
rs=20
is different than for the existing random.c.

Also, the reason why I created a separate lrng_proc.c (and lrng_interface.c=
)=20
is to allow a possible merger of this similar code with the existing random=
=2Ec.=20
The only question that needs to be solved is to find a common way to invoke=
=20
the random.c internal logic and the LRNG internal logic with these interfac=
es.
>=20
> I think your patch description should explain the purpose of the patch.

Ok, I can surely add a description for each file to the patch description.

Ciao
Stephan


