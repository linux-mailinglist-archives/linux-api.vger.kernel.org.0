Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07ABFF8F2
	for <lists+linux-api@lfdr.de>; Sun, 17 Nov 2019 12:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfKQLip (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 17 Nov 2019 06:38:45 -0500
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:19612 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfKQLip (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 17 Nov 2019 06:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1573990721;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YqzTRKct9z9gla3oe9zMeXrMmZD+9Bx/RGc/dTtEL+I=;
        b=ZFWs9y7EWsDsBHNY0NStjHd33PTuGywm722Ez8mcyoSbuwRGvCz3m8pWhL+/T4nRQn
        s5EUQ0TCYE+loG2+GPIYy4kQdW4Obr10C+1+7fxR7lQUa68GxbxLYp/cGwNLCskxoBhM
        FeQueWU/nACy0U4vZ4sWKav7oUYmO1uy7rDErgcFys7Wbt+N6/nwiDQvhFLCNP+4mOmr
        GQJfYwzAcx+t4NJmDuhlcqa3UsTgNOFO54aXUL/nlDe6Ksui/tC7vFemejVsmADH1aoa
        GvIUQ/BmcKz0mhR+7nccvpM5UT1jRqpzixHKuUy1GD6YQsyavUF1y8OoUSfIC9do1AmP
        z0UA==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXDbIvSfb0y2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
        by smtp.strato.de (RZmta 44.29.0 DYNA|AUTH)
        with ESMTPSA id N09a57vAHBbgVWe
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 12:37:42 +0100 (CET)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
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
Subject: Re: [PATCH v25 03/12] LRNG - /proc interface
Date:   Sun, 17 Nov 2019 12:37:42 +0100
Message-ID: <2404102.WUYFDzPpWi@positron.chronox.de>
In-Reply-To: <87k17z4cna.fsf@x220.int.ebiederm.org>
References: <6157374.ptSnyUpaCn@positron.chronox.de> <2476454.l8LQlgn7Hv@positron.chronox.de> <87k17z4cna.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Am Sonntag, 17. November 2019, 00:36:25 CET schrieb Eric W. Biederman:

Hi Eric,

> Stephan M=FCller <smueller@chronox.de> writes:
> > The LRNG /proc interface provides the same files as the legacy
> > /dev/random. These files behave identically. Yet, all files are
> > documented at [1].
>=20
> For someone who works in this area a lot this description is confusing.
>=20
> You are talking about sysctls not ordinary proc files.

Agreed and I will change the description accordingly.
>=20
> You don't have a call register_sysctl.  If you want your own
> implementation of these sysctls that would seem to be the way to get
> them.  Teach each implementation to register their own set of sysctls
> if they are enabled.

Agreed, I will do that.
>=20
> The entire structure of the code you are adding I have quite confusing,
> and a bit messing.
>=20
> Why add a declaration of random_table in patch 1 and then delete that
> declaration in patch 3?  Nothing uses that declaration until this point.

This is only to ensure that patch 1 compiles. Without it, there would be a=
=20
dangling reference that is required by static struct ctl_table kern_table[].

As I was always under the impression that each patch should compile by itse=
lf=20
to support bisect, I added that empty declaration. Yet, patch 1 is never=20
intended to live without patch 3. I only split patch 3 up is to aid code=20
review by having as many individual patches as possible while still allowin=
g=20
them to compile.
>=20
> What is the point of adding an extern declaration just before you
> declare the table itself?  As I understand the C language that achieves
> nothing.  I understand that is what the existing code in
> drivers/char/random.c does but that is equally buggy there.

I totally agree and I was wondering here as well. But I simply was taking i=
t=20
as is.

I am happy to clean this one up.
>=20
> I also don't understand why you don't modify the existing random
> generator code into the form you want?  What is the point of a
> side-by-side replacement?  Especially since only one of them can
> be compiled into the kernel at the same time?

I was developing small patches for random.c since 2013, mostly cleanup=20
patches. Unfortunately most of them were silently ignored. Some others were=
=20
silently taken but appeared two or three kernel releases later.

Getting more architecture-invasive patches into the existing random.c code =
is=20
considered to be quite a problem considering this experience.

Besides, the LRNG has quite a different architecture compared to the random=
=2Ec.=20
As the RNG is an important aspect of the kernel, I did not feel bold enough=
 to=20
simply replace the existing code which implies that there is no fallback. B=
y=20
allowing a side-by-side code base which is even deactivated by default, it=
=20
allows other researchers to analyze the mathematical aspects beyond the pur=
e=20
code while still having an implementation that provides a known and analyze=
d=20
entropy source.

Also, considering other kernel components like memory allocators, I/O=20
schedulers or even file systems, providing different architectures covering=
=20
similar problems (memory allocation, accessing a disk) with an entirely=20
different architecture and thus implementation seems to be an appropriate=20
solution.

=46inally, I tried to keep code that has a similar functionality to the exi=
sting=20
random.c similar to allow a merge at a later stage. For example, the sysctl=
s=20
are identical, but internally use different variables.
>=20
> This build a replacement and then switch over seems like a recipe for
> loosing the lessons of history because you are not making incremental
> changes that can be clearly understood, reviewed and bisected.
>=20
> As I read your patchset until this change your code will fail to compile
> in an ordinary configuration with proc enabled.  Have you even tested
> compiling your patchset one patch at a time?

Yes, it does compile with proc enabled with the warning that random_table i=
s=20
considered to contain one element.
>=20
> For me a great reorganization to impelment a better structure that fails
> to have a good structure on the usual merits makes me dubious about the
> entire thing.  As it can be a sign the author was pushing so hard to
> make things work he stopped looking at problematic details.
>=20
> Dubious-by: "Eric W. Biederman" <ebiederm@xmission.com>
>=20
> Eric
>=20
> > +
> > +extern struct ctl_table random_table[];
> > +struct ctl_table random_table[] =3D {
> > +	{


Ciao
Stephan


