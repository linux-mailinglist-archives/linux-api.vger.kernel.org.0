Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3F4FB53
	for <lists+linux-api@lfdr.de>; Sun, 23 Jun 2019 13:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfFWLce (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 23 Jun 2019 07:32:34 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:44088 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfFWLce (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 23 Jun 2019 07:32:34 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id E597372CC6C;
        Sun, 23 Jun 2019 14:32:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id BD7567CCE2E; Sun, 23 Jun 2019 14:32:30 +0300 (MSK)
Date:   Sun, 23 Jun 2019 14:32:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] samples: make pidfd-metadata fail gracefully on older
 kernels
Message-ID: <20190623113230.GC20697@altlinux.org>
References: <20190620103105.cdxgqfelzlnkmblv@brauner.io>
 <20190620110037.GA4998@altlinux.org>
 <20190620111036.asi3mbcv4ax5ekrw@brauner.io>
 <20190621170613.GA26182@altlinux.org>
 <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190621221339.6yj4vg4zexv4y2j7@brauner.io>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2019 at 12:13:39AM +0200, Christian Brauner wrote:
[...]
> Out of curiosity: what makes the new flag different than say
> CLONE_NEWCGROUP or any new clone flag that got introduced?
> CLONE_NEWCGROUP too would not be detectable apart from the method I gave
> you above; same for other clone flags. Why are you so keen on being able
> to detect this flag when other flags didn't seem to matter that much.

I wasn't following uapi changes closely enough those days. ;)


--=20
ldv

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdD2NOAAoJEAVFT+BVnCUIynwQANQg2+3d1f3l3bLNZVQ5QcSi
TXyKC5vKPf+zMj/1U2worLzq75AC6r+cfM7dVZoTb6zVCqN3CiQMQUuVXJHItA3N
uwFq3KM4DLR0ofIyRoyYq9MnWDpBUWNt0xdUZxLYPYMiRfaueAaqDfvFOAhexDcX
PouLJj3ixzVP5JXmzxzZer//oj+gyy+8Of2Z5QTg7K4mJMyrthS/3/qg9q7Ys1jR
N9LysvxIVUn8UgmtWxIk1vKcwiVjCNmrqM63NWfhm6gX8YhaDzP+k9AwdYBO3MIV
U58OZwWsQ4lrsnKEjQd74ACZPyuZk1ics50oK9bfFwk9HJBVgIp1WfEP2z1//VZM
auZtI5SYix3svGX2MIV8l16nKj/FP3IY+IfyYwSxlermffcM9olR+hRNoEdYAxEt
SBC7mSfozIeNLqokGNXr81SMx2w+QT0GawDdk2P8WB9ZJNAARDgLxOUw69Eu7p7q
0lBb0bPqUrCrp6XPJ3zVDpi6W+DbVBd7748iTxlorSKepFfVbWIsKLE591pfmOe/
m+tWajRVbMHQ080kualKehGgFLyahPpCzqUEmyThibInTlxShvZ50iFoNWRUxiID
6BF7OzGRoVG6Y4qSS4EalX1Mzo7xwh6+dcQPLxshSU0J32FG2alLxyQKOEChzAQ9
YQ8V+SuiitfJh3VPHBE6
=Eosu
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
