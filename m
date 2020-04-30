Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78431BF137
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2020 09:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgD3HU1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Apr 2020 03:20:27 -0400
Received: from mail.cs.msu.ru ([188.44.42.39]:52053 "EHLO mail.cs.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgD3HU1 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 30 Apr 2020 03:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
         s=dkim; h=Subject:In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E6x7YTRKZyE9vJXUY4aZZd4ADx06WY24vGTZ4p1mfuA=; b=izsqNTKjGwJT6f4cTIkfuZDN6u
        HkiFIDKOUvlhDjyQ1P4bahFShCtYQzjXC86Epng21f3sG8EkiIu6lMI+LYFZulFS7VhKngdTWuvfS
        yh4T1A+eA8zJDHB6KQ89xbW54NOWr+/ff3phsALp8Kt0RH6R9nip8t4YuA7sAJJXG61Ku7rh1lpWq
        TJOfqDJzzKXOBzSQOX8AilC7hO9Ne6634QWb2YaAE6UDBat672BlRrFwpAMwcxAgBqqM0whc1TOWu
        jwvz5f0NyE9bmgpe03V2ROhN/oI+9xFikCzOvU/zf4eC8zwASjTicD2azWr2qWsshBP+qBT5Jk9CI
        D6f0825Q==;
Received: from [37.204.119.143] (port=45544 helo=cello)
        by mail.cs.msu.ru with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93.0.4 (FreeBSD))
        (envelope-from <ar@cs.msu.ru>)
        id 1jU3Ue-0006kd-0Y; Thu, 30 Apr 2020 10:20:24 +0300
Date:   Thu, 30 Apr 2020 10:20:22 +0300
From:   Arseny Maslennikov <ar@cs.msu.ru>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Landley <rob@landley.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Pavel Machek <pavel@ucw.cz>, linux-api@vger.kernel.org,
        "Vladimir D. Seleznev" <vseleznv@altlinux.org>
Message-ID: <20200430072022.GI43805@cello>
References: <20200430064301.1099452-1-ar@cs.msu.ru>
 <20200430064301.1099452-6-ar@cs.msu.ru>
 <323be592-b614-907d-e9be-4748f159fb07@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aFi3jz1oiPowsTUB"
Content-Disposition: inline
In-Reply-To: <323be592-b614-907d-e9be-4748f159fb07@suse.cz>
OpenPGP: url=http://grep.cs.msu.ru/~ar/pgp-key.asc
X-SA-Exim-Connect-IP: 37.204.119.143
X-SA-Exim-Mail-From: ar@cs.msu.ru
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.cs.msu.ru
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_ADSP_ALL autolearn=no autolearn_force=no version=3.4.4
Subject: Re: [PATCH v3 5/7] tty: Add NOKERNINFO lflag to termios
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: Yes (on mail.cs.msu.ru)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


--aFi3jz1oiPowsTUB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2020 at 08:55:43AM +0200, Jiri Slaby wrote:
> On 30. 04. 20, 8:42, Arseny Maslennikov wrote:
> > The termios lflag is off by default.
>=20
> This commit message is too poor. Describing the intended use would help.
>=20

I described its use in the last patch of the series, where it actually
gains some use.

I agree, however, that the limited explanation in this commit does not
look helpful at all when looking at e.g. git blame output.

I'll resend a v4 with this commit message improved.

--aFi3jz1oiPowsTUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE56JD3UKTLEu/ddrm9dQjyAYL01AFAl6qfCkACgkQ9dQjyAYL
01BFHhAAml+XD+qV4guDdTSNwGuvJNRkulv3C56N+UT8iqccZPDr2kKn38Flkv/W
2nj2+kuDbtil6wdf9bqojHA1itVdiTaaeNPGfOFNr9jr0FgDaBjwHAQaMrsNWknD
xHx7XXj9zz4MlnKZx+eWNgSdiyGBPaTZFojZp0fN76HN5oD5/Kx7sEaY8UFs16dw
uz0p1+rNmwMK9VQ43hcAML1jW1qH/NHTgeOVmvUC0JEqXxvz844E2HjtpttRZvTy
8iccSRdOLS5f5yFRNucK4gIYXRP+lm1Co3iM3rqOKt02dZm+tooCsydyzFX6glDO
vcK0ZRoAa8sxQZBmtYXdGhpPsEzhg2ODjcOKfRjRC3fSnXGiU83b9gUg6e5Z7Ocs
1F9l5bDDjiAQNZBXO2rJPVPjvXNSY/PeVofXJyNWO7mA2+ajHfp4D05lBh03Z6o6
fhWOjAG2uCTWwNrUf2x8tObGvnUQyZMDStA0jx0JV/HjPQFLYOOlvnxGaP6v/C59
iYoqctMXY26sphySOon8S3lEubfbL1d/WVYuUK/CHyIajhUP0wHSC1el11ndCJXD
JMdrxjVFMsUB9J1psz/X7bXcgb5GD/GKkNsRjWwUEwFpB+3RhRcsC0GFYWidiSoC
djVdRtD0ukmyVCUAYKdgK7q/9LeXNsFOXXDYXeLxUcw40ghhQTo=
=6OEc
-----END PGP SIGNATURE-----

--aFi3jz1oiPowsTUB--
