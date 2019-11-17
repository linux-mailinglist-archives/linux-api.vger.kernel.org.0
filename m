Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55837FF8C4
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 11:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfKQKbw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 05:31:52 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:18213 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfKQKbw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 05:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573986707;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YIRBWy6xFDF2aafrRHV3OAx+nt5eArNLC9lAVDkTFxs=;
        b=ceYz9e/7xtXSGt91JOiWo+Mop5dwRZrXuyaaVtv1ERe5cIjwgYHlgcBYIcBAEmqEW/
        xsaHo05WgsPqQLxepXw4UrUSynr5HU8378XQ/OYUQb215U+70gMhShbzdNFu4YvbDVIq
        Ye0mACPoFPeDHC2q/ZG90VyyLTAY1loJiBC+IoJAsasCDZ6QxbU4Xx2/2xrz58+tEw8G
        ebKeM/vJzNx4y3ruaBvsL4CCYLKcbhPpaRCND5+kgZmZh/7WnUmXhLjfyZUlWlh+0m6j
        CZoi1fk+1vAHtLN9Usw9YyhNmh0MLGuR8x9hXGECE0nQqvpWQuqdk6qD80bwhpX4PxhG
        NxRQ==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbIvSfb0y2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAHAUEVPH
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 11:30:14 +0100 (CET)
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
Subject: Re: [PATCH v25 01/12] Linux Random Number Generator
Date:   Sun, 17 Nov 2019 11:30:13 +0100
Message-ID: <9486573.CV9Qe9s7RZ@positron.chronox.de>
In-Reply-To: <alpine.DEB.2.21.1911161216540.14348@nanos.tec.linutronix.de>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2645285.kI0haNqfm4@positron.chronox.de> <alpine.DEB.2.21.1911161216540.14348@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Samstag, 16. November 2019, 12:25:21 CET schrieb Thomas Gleixner:

Hi Thomas,

> On Sat, 16 Nov 2019, Stephan M=FCller wrote:
> > +/**
> > + * Hot code path - Callback for interrupt handler
> > + */
> > +void add_interrupt_randomness(int irq, int irq_flags)
> > +{
> > +	lrng_time_process();
> > +
> > +	if (!lrng_pool_highres_timer()) {
> > +		struct pt_regs *regs =3D get_irq_regs();
> > +		static atomic_t reg_idx =3D ATOMIC_INIT(0);
> > +		u64 ip;
> > +
> > +		lrng_pool_lfsr_u32(jiffies);
> > +		lrng_pool_lfsr_u32(irq);
> > +		lrng_pool_lfsr_u32(irq_flags);
> > +
> > +		if (regs) {
> > +			u32 *ptr =3D (u32 *)regs;
> > +			int reg_ptr =3D atomic_add_return_relaxed(1, &reg_idx);
> > +			size_t n =3D (sizeof(struct pt_regs) / sizeof(u32));
> > +
> > +			ip =3D instruction_pointer(regs);
> > +			lrng_pool_lfsr_u32(*(ptr + (reg_ptr % n)));
> > +		} else
> > +			ip =3D _RET_IP_;
> > +
> > +		lrng_pool_lfsr_u32(ip >> 32);
> > +		lrng_pool_lfsr_u32(ip);
> > +	}
>=20
> Is there a way to avoid all that processing right in the interrupt hot
> path and just store the raw data for later processing?

The main code path is lrng_time_process(). This code is streamlined as you=
=20
already suggested: it is very lightweight to the interrupt handler. Compare=
d=20
to the existing /dev/random implementation it is about 50% faster.

When measuring the lrng_time_process, it takes on one particular test syste=
m=20
on average about 65 cycles where on that very same system the=20
add_interrupt_randomness code path from the existing /dev/random takes on=20
average about 97 cycles.

The additional code you see in the add_interrupt_randomness is only execute=
d=20
if lrng_pool_highres_timer is not set. This is not set if the LRNG does not=
=20
find a high-resolution time stamp, i.e. random_get_entropy() returns 0. As =
on=20
most architectures this is now set, this code path is not executed.

This additional code path serves as an emergency code to collect some data=
=20
that smells random and having entropy but not having really much.

It may be a bit more stremlined but since it is hardly used, I left it as i=
t=20
is so far. Do you see the need to streamline it more at this time?

Thanks a lot.


Ciao
Stephan


