Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B698FD489F
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 21:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbfJKTvK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Oct 2019 15:51:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38164 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728799AbfJKTvK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 Oct 2019 15:51:10 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1iJ0wI-00016N-9y; Fri, 11 Oct 2019 20:51:02 +0100
Received: from ben by deadeye with local (Exim 4.92.2)
        (envelope-from <ben@decadent.org.uk>)
        id 1iJ0wI-0000lm-2v; Fri, 11 Oct 2019 20:51:02 +0100
Message-ID: <c327ecb762ef788ef248ed5c006eeef5afa3b798.camel@decadent.org.uk>
Subject: Re: [PATCH] tracefs: Do not allocate and free proxy_ops for lockdown
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <matthewgarrett@google.com>,
        James Morris James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Fri, 11 Oct 2019 20:50:56 +0100
In-Reply-To: <20191011143610.21bcd9c0@gandalf.local.home>
References: <20191011135458.7399da44@gandalf.local.home>
         <CAHk-=wj7fGPKUspr579Cii-w_y60PtRaiDgKuxVtBAMK0VNNkA@mail.gmail.com>
         <20191011143610.21bcd9c0@gandalf.local.home>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-RVTAo56FC6JdCy3TcbW7"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--=-RVTAo56FC6JdCy3TcbW7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-10-11 at 14:36 -0400, Steven Rostedt wrote:
> On Fri, 11 Oct 2019 11:20:30 -0700
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
> > Willing to do that instead?
>=20
> Honestly, what you described was my preferred solution ;-)
>=20
> I just didn't want to upset the lockdown crowd if a new tracefs file
> was opened without doing this.
>=20
> Once locked down is set, can it ever be undone without rebooting?
[...]

Earlier versions of the lockdown patch set added a magic SysRq command
to turn it off.  That's not currently present upstream but there may be
plans to add it.

Ben.

--=20
Ben Hutchings
It is easier to change the specification to fit the program
than vice versa.



--=-RVTAo56FC6JdCy3TcbW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl2g3SAACgkQ57/I7JWG
EQlqjg//T/3zBWsuiQaVH1xm1ZKL0fiUmrONKKaR1YvKqTh3/48OycmNuiS5JouH
sehyxtKXJcTHTYDfbVy7+x2wWWWeHXKIZaHOUwBkGgsB6BK4SdUVLpb8uR8ye+Vt
WzXoy0N2/qdlg1JZC7SuIAZf3qI1WdCEFW/QFoHqUKDe89aE/8nCFdbp1hqDo5kr
SidNRHNT0WUAVlbHaZa2ykhYFF9j3vVtT11DwcLNtugV4PKBm5q+lo6bo4G1K1QT
mVygSOiRnVbsFrQ1FXOi7YFRcMeImimWgFJKxxhN3lVKE2KtD1Ngr9132ZySizkM
ysXXzk0bpCmDfxQh8v5ztA5SCqjTs/RAj21OXr+0s2iJlOyS6lgDIvpte480IMRg
u9CnOQgzn4w0O0Ya2NSvEs3vPwak2EmDRF38t0VIoBWnDL19yxKiykAhgjVZDDX9
8FI7MWgsRLEp2Oe/4Qm36gNHvZ0AWP+dMwMWVEReEFMs+mu6WmsColUB9XwWVuqY
iaELrt1d6QDxPqDOZ7Np3TpPstcxB891E8AOOtDox9S/xksqOiIEHhVf8UwoqzW7
SkLexfXtGdQi0drgiSshOCpBaaXQfjgqoI3k8ipNm9Sx3IL3S2D9fTQVt9rXhYHw
XhL95M7SYkGLGcMAD+Ew7R2PEMSGpsVNMsVYyVXzFTLAO+Rc6fg=
=3b+F
-----END PGP SIGNATURE-----

--=-RVTAo56FC6JdCy3TcbW7--
