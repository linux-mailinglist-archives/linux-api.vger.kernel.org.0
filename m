Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5FF86E3
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2019 03:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbfKLC0l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 11 Nov 2019 21:26:41 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.171]:13920 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfKLC0k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 11 Nov 2019 21:26:40 -0500
X-Greylist: delayed 25988 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Nov 2019 21:26:39 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573525598;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/lsl6nTo//BjYrk5oV+rdFSP85ZYnNHrebh0HC0dN2g=;
        b=n2Mw6n7yQlnP2+Yg86gJCGqtMqi0M51lDJuB/tNgQy0Qxf6whTQBEkcsbSxBKhAD/q
        gt4aj76Mc5GUvI2T3Gk4OmTYmoRUdDtjPtyrbBYcreXzJafwc3uYmTo4OmjYaQsLQ8Jo
        2OyKhK3vf0+RcUE80YqNDRAKkHpb+9TxQyRDfqHLbLWIVa9KCLj7LOhvzVYhgThaovWj
        HyI8xKfjzjhZ8TxPN7VOL1QQA7lSl3fBdYWi3Z2qK3YXAGniahW6iXlSIJCi2wjA2p6T
        ZAUPdjhlpLzznIS2ZtTUI2eVS9pqeZ1b7o8mhbuOGcplBY9I5pPnYfbOuV6U6R4LH8V/
        F7EA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9zWgDMLyyzTHyZb69qn/xQ3l1emqDBm3cL6VhEyGWhThurAC8gyGEsg=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id N09a57vAC2P54QC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 12 Nov 2019 03:25:05 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [PATCH v24 01/12] Linux Random Number Generator
Date:   Tue, 12 Nov 2019 03:25:03 +0100
Message-ID: <9370249.4lZBqg7Imc@positron.chronox.de>
In-Reply-To: <alpine.DEB.2.21.1911120041060.1833@nanos.tec.linutronix.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2369119.jSEA3qhmGI@positron.chronox.de> <alpine.DEB.2.21.1911120041060.1833@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Dienstag, 12. November 2019, 00:54:16 CET schrieb Thomas Gleixner:

Hi Thomas,

> Stephan,
>=20
> On Mon, 11 Nov 2019, Stephan M=FCller wrote:
>=20
> thanks for Cc'ing me. I'll have a look at the technical details at later
> point in time.=20

Thank you very much for considering a review.

> While skimming through the patches I noticed, that you
> thankfully added the SPDX license identifiers, but
>=20
> > @@ -0,0 +1,105 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> > +/*
> > + * LRNG Fast Noise Source: CPU-based noise source
> > + *
> > + * Copyright (C) 2016 - 2019, Stephan Mueller <smueller@chronox.de>
> > + *
> > + * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
> > + * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
> > + * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ALL OF
> > + * WHICH ARE HEREBY DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR BE
> > + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> > + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
> > + * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
> > + * BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
> > + * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> > + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
> > + * USE OF THIS SOFTWARE, EVEN IF NOT ADVISED OF THE POSSIBILITY OF SUCH
> > + * DAMAGE.
>=20
> we really want to get rid of these boiler plate disclaimers as they are
> already implicit by the SPDX license identifier and provide no real
> value.
>=20
> Aside of that, the above disclaimer has even a slightly different wording
> than the standard BSD-2-Clause disclaimer which is going to cause even mo=
re
> headaches as automated scanner tools will detect that and someone has to =
go
> through that unreadable uppercase yelling mess and figure out whether it's
> a legaly substantial difference.
>=20
> Can you please get rid of those?

Absolutely. I have removed that boiler plate disclaimer from all files.

Though I hope it is acceptable to wait for further comments before a=20
resubmission.

Thank you very much.

Ciao
Stephan


