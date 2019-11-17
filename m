Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA6FF8DD
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 12:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfKQLMS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 06:12:18 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.101]:34882 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfKQLMS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 06:12:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573989134;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=MT2mPjdD45S2F5oIRqRGfpRXIEr/oEzDuVVP6bvuysY=;
        b=XYGEUR0I70hDP+Si0+//TM3DvsCZs8BveedNchYb+NiCRDeDTaXebHcnuGvQq/cJ/O
        aiy2kz1B87gM+Ja3zlqie5cRm2DNt1fwh7j6m0il4RVZu5UrvBC5Qa/rW3LjZ/Rr7sQ8
        WxvaBVOUpQjdXar++wQFnA1Gij4SXedW0DvSf4pMES8BxMj5V3lPeiXOPzQV+1EIbxdh
        95pJvDh4U0NyX3IpkiVBtuUkiRwA5Xouqd0tHbuWWtTq/zYSsOoNqmpP7xNDu1v9Mi2f
        jlPWX3S3afFP/i6U8mYjq4ZEQtZdPlZfSalkRpGo1mvH+tZNEcdjJMZ8TuSJOvG6CONP
        DtWg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbIvSfb0y2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAHBB6VUM
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 12:11:06 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
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
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Nicolai Stange <nstange@suse.de>,
        "Peter, Matthias" <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Roman Drahtmueller <draht@schaltsekun.de>,
        Neil Horman <nhorman@redhat.com>
Subject: Re: [PATCH v25 10/12] LRNG - add TRNG support
Date:   Sun, 17 Nov 2019 12:10:58 +0100
Message-ID: <3159012.PsEOTp9LqO@positron.chronox.de>
In-Reply-To: <DDB907EA-3FCC-40C7-B55B-A84BC77FD7A1@amacapital.net>
References: <5390778.VeFRgus4bQ@positron.chronox.de> <DDB907EA-3FCC-40C7-B55B-A84BC77FD7A1@amacapital.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Samstag, 16. November 2019, 17:09:09 CET schrieb Andy Lutomirski:

Hi Andy,

> > On Nov 16, 2019, at 1:40 AM, Stephan M=C3=BCller <smueller@chronox.de> =
wrote:
> >=20
> > =EF=BB=BFThe True Random Number Generator (TRNG) provides a random numb=
er
> > generator with prediction resistance (SP800-90A terminology) or an NTG.1
> > (AIS 31 terminology).
>=20
> ...
>=20
> > The secondary DRNGs seed from the TRNG if it is present. In addition,
> > the /dev/random device accesses the TRNG.
> >=20
> > If the TRNG is disabled, the secondary DRNGs seed from the entropy pool
> > and /dev/random behaves like getrandom(2).
>=20
> As mentioned before, I don=E2=80=99t like this API.  An application that,=
 for some
> reason, needs a TRNG, should have an API by which it either gets a TRNG or
> an error. Similarly, an application that wants cryptographically secure
> random numbers efficiently should have an API that does that.  With your
> design, /dev/random tries to cater to both use cases, but one of the use
> cases fails depending on kernel config.
>=20
> I think /dev/random should wait for enough entropy to initialize the syst=
em
> but should not block after that. A TRNG should have an entirely new API
> that is better than /dev/random.

I apologize for the misunderstanding. I assumed we would introduce such /de=
v/
true_random at a later stage.

If you agree, I can certainly add /dev/true_random right now that links wit=
h=20
the TRNG and make /dev/random behave as discussed, i.e. behave exactly like=
=20
getrandom(..., 0);

As this would introduce a new device file now, is there a special process t=
hat=20
I need to follow or do I need to copy? Which major/minor number should I us=
e?

Looking into static const struct memdev devlist[] I see

         [8] =3D { "random", 0666, &random_fops, 0 },
         [9] =3D { "urandom", 0666, &urandom_fops, 0 },

Shall a true_random be added here with [10]?

Ciao
Stephan


