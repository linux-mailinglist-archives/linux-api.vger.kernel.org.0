Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5F758755
	for <lists+linux-api@lfdr.de>; Tue, 18 Jul 2023 23:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjGRVjQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Jul 2023 17:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGRVjP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Jul 2023 17:39:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A191988;
        Tue, 18 Jul 2023 14:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB9326100E;
        Tue, 18 Jul 2023 21:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987DCC433C8;
        Tue, 18 Jul 2023 21:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689716353;
        bh=2EaS9hb1FXX9OJHDbvK6squyFB5ZfxFtByX8KIvw0CQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dLSQxVEEl6J4Ye1wgzJ/jKWvR/e1SMqfn5OrfpXiCB+s1AL4wvrcm6Dk85vuhbdSs
         GJaOjPJcps093lqgpFJQJ5MEBhX9mIXxPpB17r9ZOHLU0lROFgk9ex4pndVHOonTi2
         ljbN/oOCIcXLYobYRdGFjV8SfyIggA90WHwtAaWFvoOvQILiLTRWRdU6Yj5orUVoJt
         BzdPNp+A5mMuZxBH8zPnoJ29H0qrj8V7ccF/HZw80BFSLXpJJlgszyE3A+ywe2v+A2
         UeaMA6yGihL6V6ke9VffKGB9rpjml0Aha9Yn9K65Nc9NiOINFIGtM6i1Kc5N/QFFA6
         LnzrXFYxMbqCQ==
Message-ID: <96515710-f82f-cd2a-8366-7fff84f28d82@kernel.org>
Date:   Tue, 18 Jul 2023 23:39:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] recv.2: Document MSG_CMSG_CLOEXEC as returned in
 msg_flags
Content-Language: en-US
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230709213358.389871-1-mattlloydhouse@gmail.com>
 <363c0f82-969d-1927-1bd5-b664cfc83a87@kernel.org>
 <20230716234803.851580-1-mattlloydhouse@gmail.com>
 <47e21a59-f74a-4a63-0f13-237c015ae6bb@kernel.org>
 <20230718060121.934187-1-mattlloydhouse@gmail.com>
 <05f6395d-4ee2-ce87-253a-9dcbfe227d42@kernel.org>
 <20230718172648.943269-1-mattlloydhouse@gmail.com>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <20230718172648.943269-1-mattlloydhouse@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------1UKNO0Xc1FdY7aK6BnYWF4J6"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------1UKNO0Xc1FdY7aK6BnYWF4J6
Content-Type: multipart/mixed; boundary="------------Wgi8bN2d3gaLi7ZzCrRRu4Kv";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Matthew House <mattlloydhouse@gmail.com>
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
 netdev@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Andrew Morton <akpm@linux-foundation.org>
Message-ID: <96515710-f82f-cd2a-8366-7fff84f28d82@kernel.org>
Subject: Re: [PATCH v3] recv.2: Document MSG_CMSG_CLOEXEC as returned in
 msg_flags
References: <20230709213358.389871-1-mattlloydhouse@gmail.com>
 <363c0f82-969d-1927-1bd5-b664cfc83a87@kernel.org>
 <20230716234803.851580-1-mattlloydhouse@gmail.com>
 <47e21a59-f74a-4a63-0f13-237c015ae6bb@kernel.org>
 <20230718060121.934187-1-mattlloydhouse@gmail.com>
 <05f6395d-4ee2-ce87-253a-9dcbfe227d42@kernel.org>
 <20230718172648.943269-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230718172648.943269-1-mattlloydhouse@gmail.com>

--------------Wgi8bN2d3gaLi7ZzCrRRu4Kv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Matthew, Ulrich,

On 2023-07-18 19:26, Matthew House wrote:
> Ever since commit 4a19542e5f69 ("O_CLOEXEC for SCM_RIGHTS") added the
> MSG_CMSG_CLOEXEC flag to recvmsg(2), the flag has also been copied into=
 the
> returned msg->msg_flags when specified, regardless of whether any file
> descriptors were actually received, or whether the protocol supports
> receiving file descriptors at all. This behavior was primarily an
> implementation artifact: by copying MSG_CMSG_CLOEXEC into the msg_flags=
,
> scm_detach_fds() in net/core/scm.c (and its _compat() counterpart in
> net/compat.c) could determine whether it was set without having to rece=
ive
> a copy of the recvmsg(2) flags.
>=20
> This mechanism was closely modeled after the internal MSG_CMSG_COMPAT f=
lag,
> which is passed by the compat versions of the send[m]msg(2) and
> recv[m]msg(2) syscalls to inform various functions that user space expe=
cts
> a compat layout. When the flag was first implemented by commits
> 3225fc8a85f4 ("[NET]: Simplify scm handling and sendmsg/recvmsg invocat=
ion,
> consolidate net compat syscalls.") and 7e8d06bc1d90 ("[COMPAT]: Fix
> MSG_CMSG_COMPAT flag passing, kill cmsg_compat_recvmsg_fixup.") (in
> history/history.git), the behavior was very similar: recvmsg(2) would a=
dd
> MSG_CMSG_COMPAT to the msg_flags, and put_cmsg() and scm_detach_fds() i=
n
> net/core/scm.c would read the flag to determine whether to delegate to
> their _compat() counterparts.
>=20
> However, after the initial implementation, more work was done to hide
> MSG_CMSG_COMPAT from user space. First, commit 37f7f421cce1 ("[NET]: Do=
 not
> leak MSG_CMSG_COMPAT into userspace.") started scrubbing the bit from
> msg_flags right before copying it back into user space. Then, since pas=
sing
> the MSG_CMSG_COMPAT flag into the syscalls from non-compat code could
> confuse the kernel, commits 1be374a0518a ("net: Block MSG_CMSG_COMPAT i=
n
> send(m)msg and recv(m)msg") and a7526eb5d06b ("net: Unbreak
> compat_sys_{send,recv}msg") made them return -EINVAL if user space
> attempted to pass the flag. But to reduce breakage, commit d720d8cec563=

> ("net: compat: Ignore MSG_CMSG_COMPAT in compat_sys_{send, recv}msg")
> rolled that back somewhat, making MSG_CMSG_COMPAT an error for the
> non-compat syscalls and a no-op for the compat syscalls, which is the
> current status quo.
>=20
> Even though MSG_CMSG_CLOEXEC was implemented after the kernel started
> scrubbing MSG_CMSG_COMPAT from the returned msg_flags, the newer flag n=
ever
> received the same treatment. At this point, this behavior has effective=
ly
> become part of the user-space API, to the extent that io_uring has been=

> careful in commit 9bb66906f23e ("io_uring: support multishot in recvmsg=
")
> to replicate the behavior in its multishot IORING_OP_RECVMSG operation.=

>=20
> Therefore, document this behavior to avoid confusion when user space se=
es
> MSG_CMSG_CLOEXEC returned in msg->msg_flags.
>=20
> Cc: linux-api@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: Ulrich Drepper <drepper@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Matthew House <mattlloydhouse@gmail.com>
> ---
> Alright, I've summarized the history in the commit message, and I've ad=
ded
> the CCs you requested.
>=20
> Also, for future reference, Drepper gave a reply to the last email, whi=
ch
> did not make it onto the list:
>=20
> On Tue, Jul 18, 2023 at 9:24 AM Ulrich Drepper <drepper@redhat.com> wro=
te:
>> On Tue, Jul 18, 2023 at 2:10=E2=80=AFPM Alejandro Colomar <alx@kernel.=
org> wrote:
>>
>>>> As for the original
>>>> purpose of the behavior, it's not really clear, and it may well have=
 been
>>>> an implementation artifact that got enshrined in the user space ABI.=

>>> (Even
>>>> io_uring is careful to replicate this behavior!)
>>>
>>> This is what worries me.  I've CCd a bunch of people to see if they c=
an
>>> bring some light.
>>>
>>
>> It definitely was an artifact of the implementation.  I haven't tested=

>> getting the close-on-exec flag information for all interfaces.  The
>> assumption was that the information about the close-on-exec flag is
>> received with the universal fcntl() call.

Patch applied.  I've included Drepper's quote in the commit message too.
Thank you both!

Cheers,
Alex

>=20
> Thank you,
> Matthew House
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
>  .SH RETURN VALUE
>  These calls return the number of bytes received, or \-1
>  if an error occurred.

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------Wgi8bN2d3gaLi7ZzCrRRu4Kv--

--------------1UKNO0Xc1FdY7aK6BnYWF4J6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmS3Bn0ACgkQnowa+77/
2zJ/eg/+KZ4z2UJuINFBb+ruxyfYN+dBsa+wc1p8AkMsCSLzzyzMDFa8NStb+qu7
MQwZiAuSDeZMeatfU6HrEtHOAzdmofSxbTpkT6jBkVSRGsNmOY7+bTnGhurVZ2O7
Tw9S2JPnyTYZc7yeCXMpAF81wQyQHCgpSKg7P1OYVHz0lk4N0XNh9C3oESRc6pqf
dk9/o8zA6pgmfuzYXJVN6ZH3HZ3vi+r63LLNq/rps9k9GWgjdsiLIAwR5DP7gnnN
PlaqNIfgpxoTArYfoOozvSkb7UFFid6/2yOpSL5zoFmDlP3xMlyg+rfSrFEVzjT6
3Q1aAWk4vc4qhILB4SJp34t4C0joJ5+CITQJOFsJwMtBidLTNjHw4wVq/o6hxj1r
8JIs9tHAu7VTkPaoAQj01uAnjsrcOCscHSi+8vLulzaj3UyCM4GD0QHhlbtXpYQO
6Jkuk3HQWUohMwfUJW2EVwATyO9d8iCX/J4wRuLq/mC/HV1IQgZuQpTabV9jXFPc
lk5wRFsPwUTYus8hItE5Nb+zV1Hoq3JPYwMz0WeHohGSwwnf2tNsaTxbdp9lvgng
5NTqbKjWY+NZBBWjUw5GTCV3R1k4y15ldGNk01i0/mUSq/4flLIy5VB2QoDttqPd
jMx3Jl4sDiQawRUP1RmjaLzJForNwVdP3q58b/8Z808U0yzwgQU=
=jlgC
-----END PGP SIGNATURE-----

--------------1UKNO0Xc1FdY7aK6BnYWF4J6--
