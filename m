Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076EA757047
	for <lists+linux-api@lfdr.de>; Tue, 18 Jul 2023 01:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGQXLU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 17 Jul 2023 19:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjGQXLT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 17 Jul 2023 19:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEF21702;
        Mon, 17 Jul 2023 16:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F69612BB;
        Mon, 17 Jul 2023 23:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF37C433C8;
        Mon, 17 Jul 2023 23:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689635441;
        bh=VAkly4UtztOarHWB2AbVqWUdKuQY20SJP9hPEG7WB98=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YSuxnzks5UKj83H4W2XDWd4cJglhLh7Qr0sSu/l45xVouz2pCIzcXGiaZbZFVywAJ
         M1pGDWtCTeqlSHD8e3WFs3aFBJvAyS7tVGnoUg26ak61atNCBlbBVKViH7C96KnHc0
         PxOLY6pCG3VAu/fVaZUjN+iTDWzkKd/27Nm2RbtgzEHPYdy3PJ9lIyJ6iBtraV8iKM
         zbkANBK8w3d94jY3NFqdlOEKeR2VpYmZPEbqQBR366Q+0RZCBJyLfpAVOT8KTKOyg8
         U5r9viIt0noc01B4/q+i6tqmNaL/9Nw3YOIWcv4pLxHZtqzu1w8UJJCn6MEHyFo4r6
         eu6HLpTl9RpAQ==
Message-ID: <47e21a59-f74a-4a63-0f13-237c015ae6bb@kernel.org>
Date:   Tue, 18 Jul 2023 01:10:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] recv.2: Document MSG_CMSG_CLOEXEC as returned in
 msg_flags
Content-Language: en-US
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     linux-man@vger.kernel.org,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
References: <20230709213358.389871-1-mattlloydhouse@gmail.com>
 <363c0f82-969d-1927-1bd5-b664cfc83a87@kernel.org>
 <20230716234803.851580-1-mattlloydhouse@gmail.com>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <20230716234803.851580-1-mattlloydhouse@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------VjIneUFMoQx2gSfxNLbP5hW0"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------VjIneUFMoQx2gSfxNLbP5hW0
Content-Type: multipart/mixed; boundary="------------YTy04Z0V0IMVDfiK8VSl7QEQ";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Matthew House <mattlloydhouse@gmail.com>
Cc: linux-man@vger.kernel.org,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Message-ID: <47e21a59-f74a-4a63-0f13-237c015ae6bb@kernel.org>
Subject: Re: [PATCH v2] recv.2: Document MSG_CMSG_CLOEXEC as returned in
 msg_flags
References: <20230709213358.389871-1-mattlloydhouse@gmail.com>
 <363c0f82-969d-1927-1bd5-b664cfc83a87@kernel.org>
 <20230716234803.851580-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230716234803.851580-1-mattlloydhouse@gmail.com>

--------------YTy04Z0V0IMVDfiK8VSl7QEQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On 2023-07-17 01:47, Matthew House wrote:
> Signed-off-by: Matthew House <mattlloydhouse@gmail.com>
> ---
> Clarified that the argument comes from the recvmsg() call. It feels a b=
it
> redundant to name recvmsg() again here, given that the list of flags is=

> immediately preceded by, "The msg_flags field in the msghdr is set on
> return of recvmsg(). It can contain several flags: [...]" But I'll let =
you
> be the judge of that.
>=20
>  man2/recv.2 | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/man2/recv.2 b/man2/recv.2
> index 660c103fb..1cd9f3e1b 100644
> --- a/man2/recv.2
> +++ b/man2/recv.2
> @@ -412,6 +412,15 @@ is returned to indicate that expedited or out-of-b=
and data was received.
>  .B MSG_ERRQUEUE
>  indicates that no data was received but an extended error from the soc=
ket
>  error queue.
> +.TP
> +.BR MSG_CMSG_CLOEXEC " (since Linux 2.6.23)"
> +.\" commit 4a19542e5f694cd408a32c3d9dc593ba9366e2d7
> +indicates that
> +.B MSG_CMSG_CLOEXEC
> +was specified in the
> +.I flags
> +argument of
> +.BR recvmsg ().

I don't understand what's the purpose of this.  The kernel sets a bit
just to report to the caller that it set a bit?  No other purpose?
It feels very weird.  Of course, the caller already has that info,
doesn't it?

Thanks,
Alex

>  .SH RETURN VALUE
>  These calls return the number of bytes received, or \-1
>  if an error occurred.

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------YTy04Z0V0IMVDfiK8VSl7QEQ--

--------------VjIneUFMoQx2gSfxNLbP5hW0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmS1ym4ACgkQnowa+77/
2zI9aQ/9EItWScmhnNtj0ZUpDBng3HZ5dl6YRRuGoJNVWbKDYTaKSDERJlV9eV+K
B75ZzSQDcLltsGpIOvYZ+CNJ8Bj+fOsmNiewQt+P3xKBnrXeoxhvpRrN5bmF+UMb
UFrlg95eAQOl4jU3E5o747A9OyingUvqf9Pa7gkEhnR66uPIbXiRu6ogJKsV5zVZ
c6LwpNxUXzLq3IECRAEVPU6moTEUJW7fylM7O1TwRsEU5mI4kBKbq+Oo3ai2oOvU
p5HjFKsNOPlYv/f+SUq7cQijigOEyR53AiqnQjkjxSLyX1QdS+xJ99TG1ObLwmkk
rL8A96oZMzH01A4CNN7p6kuIuRtauGV9h5SAEbgww8xP+Sv9mYDfs9dZmK1Q5rVC
9WDFiDHgsZLijDqwXl+m5MvBAXsdRAvtGaHv/A4d49gsNbl6eX/M3VCV0xkQRvjI
TUOGGwQlWP3l/jwRgVQ1/ieSD5sjzIXlcog2w59gYJFTGvwFkSUxV6AWAPeREu/2
0daEzvPfwwaM3wa34Xb2pA7hOOnLgKLokwmc72m7e8Syg4rhtXPhw7mo6KEgufEh
Afstjt4UP3QPjYgdLHus+KCpXfoCYzhapJ4pUet4s8fpPbN415zn1HudBtEXlpzC
zzuEcKFbMKdM6EauBP46D4D+THnsx8o4wG8NMv3H+P0MXsOa1Ms=
=XI2L
-----END PGP SIGNATURE-----

--------------VjIneUFMoQx2gSfxNLbP5hW0--
