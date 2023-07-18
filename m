Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CAE757B1A
	for <lists+linux-api@lfdr.de>; Tue, 18 Jul 2023 14:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjGRMDR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 18 Jul 2023 08:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjGRMDQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 18 Jul 2023 08:03:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3691A5;
        Tue, 18 Jul 2023 05:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF0A6153D;
        Tue, 18 Jul 2023 12:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056C7C433B9;
        Tue, 18 Jul 2023 12:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689681793;
        bh=EAi8VRs32kR48ZLJNu1wKHsY1QUZSEQk4BWzcMUNFAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N6lbTfudHc1m2mYCX/V+4s9D1WAgXGy2br/jrPdu7xzvlR2pBbbUSkWRixj5sbAxm
         USVKhmFEPBG5TIrxPzXjEauX1RBmKCQujQljlh3HU24mgoTKHhx6iDT2EVNbBLwVlN
         Fe48jK6W6WZGCFEnx6GuFgAIpZ+RsaOCAvrU1/Rey6qBpU5QpJTlCGAhP7bQQ7jSI2
         9iTb86VeB/Gespeb1kOSzOUBk+S48zu7i7U5c32QfA0285nHBHlzaDVBpiKCPIL4EB
         feA58bLC8OIj0ivQPweqv4Yq0duzEFx8Hc30HRewKVQnvZmt5RwIWAr3OUwFqIEKPr
         Ny0kyFJTUgS0g==
Message-ID: <05f6395d-4ee2-ce87-253a-9dcbfe227d42@kernel.org>
Date:   Tue, 18 Jul 2023 14:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] recv.2: Document MSG_CMSG_CLOEXEC as returned in
 msg_flags
Content-Language: en-US
To:     Matthew House <mattlloydhouse@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, Ulrich Drepper <drepper@gmail.com>,
        Ulrich Drepper <drepper@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230709213358.389871-1-mattlloydhouse@gmail.com>
 <363c0f82-969d-1927-1bd5-b664cfc83a87@kernel.org>
 <20230716234803.851580-1-mattlloydhouse@gmail.com>
 <20230718060121.934187-1-mattlloydhouse@gmail.com>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <20230718060121.934187-1-mattlloydhouse@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Dac0DMFjn2KQY7N829aKX9UO"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Dac0DMFjn2KQY7N829aKX9UO
Content-Type: multipart/mixed; boundary="------------botqBotNa7AKw0NfaN0pDAUd";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Matthew House <mattlloydhouse@gmail.com>
Cc: linux-man@vger.kernel.org, linux-api@vger.kernel.org,
 netdev@vger.kernel.org, Ulrich Drepper <drepper@gmail.com>,
 Ulrich Drepper <drepper@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <05f6395d-4ee2-ce87-253a-9dcbfe227d42@kernel.org>
Subject: Re: [PATCH v2] recv.2: Document MSG_CMSG_CLOEXEC as returned in
 msg_flags
References: <20230709213358.389871-1-mattlloydhouse@gmail.com>
 <363c0f82-969d-1927-1bd5-b664cfc83a87@kernel.org>
 <20230716234803.851580-1-mattlloydhouse@gmail.com>
 <20230718060121.934187-1-mattlloydhouse@gmail.com>
In-Reply-To: <20230718060121.934187-1-mattlloydhouse@gmail.com>

--------------botqBotNa7AKw0NfaN0pDAUd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On 2023-07-18 08:00, Matthew House wrote:
> On Mon, Jul 17, 2023 at 7:10 PM Alejandro Colomar <alx@kernel.org> wrot=
e:
>> Hi Matthew,
>>
>> I don't understand what's the purpose of this.  The kernel sets a bit
>> just to report to the caller that it set a bit?  No other purpose?
>> It feels very weird.  Of course, the caller already has that info,
>> doesn't it?
>=20
> The main reason I posted this patch was because I was confused by the
> flag's presence in the msg_flags when I was looking at some strace logs=
, so
> I figured that it would be a good idea to document it.

Makes sense.

> As for the original
> purpose of the behavior, it's not really clear, and it may well have be=
en
> an implementation artifact that got enshrined in the user space ABI. (E=
ven
> io_uring is careful to replicate this behavior!)

This is what worries me.  I've CCd a bunch of people to see if they can
bring some light.

>=20
> This behavior began when the MSG_CMSG_CLOEXEC flag was first added in L=
inux
> 2.6.23, with Ulrich Drepper's commit 4a19542e5f69 ("O_CLOEXEC for
> SCM_RIGHTS"). Per the commit message, the flag was designed to be
> "passe[d]... just like the existing MSG_CMSG_COMPAT flag". Since it was=

> added to the msg_flags at the start of sys_recvmsg(), the
> scm_detach_fds[_compat]() functions in net/core/scm.c and net/compat.c
> could read the flag off of msg->msg_flags without having to thread the
> recvmsg() flags through.
>=20
> This was indeed similar to the behavior of MSG_CMSG_COMPAT. That flag w=
as
> added in Linux 2.5.65, with commit 3225fc8a85f4 ("[NET]: Simplify scm
> handling and sendmsg/recvmsg invocation, consolidate net compat
> syscalls."), in which put_cmsg() and scm_detach_fds() in net/core/scm.c=

> read it off of msg->msg_flags. (It wouldn't actually be set in msg_flag=
s
> until Linux 2.5.67, with commit 7e8d06bc1d90, "[COMPAT]: Fix
> MSG_CMSG_COMPAT flag passing, kill cmsg_compat_recvmsg_fixup." Both of
> these commits are from history/history.git.)
>=20
> However, the MSG_CMSG_COMPAT flag has been scrubbed from the output
> msg_flags since Linux 2.6.14, with commit 37f7f421cce1 ("[NET]: Do not =
leak
> MSG_CMSG_COMPAT into userspace."). That's what I find so unclear:
> MSG_CMSG_CLOEXEC was added after the kernel started scrubbing
> MSG_CMSG_COMPAT from the output, but the new flag was never written to =
be
> similarly scrubbed.
>=20
> Later, in Linux 3.10, with commits 1be374a0518a ("net: Block
> MSG_CMSG_COMPAT in send(m)msg and recv(m)msg") and a7526eb5d06b ("net:
> Unbreak compat_sys_{send,recv}msg"), MSG_CMSG_COMPAT was banned from be=
ing
> passed to the *msg() syscalls' flags from user space, with the rational=
e
> that they were "not intended to be part of the API". Then, in Linux 4.0=
, we
> reached the current status quo with commit d720d8cec563 ("net: compat:
> Ignore MSG_CMSG_COMPAT in compat_sys_{send, recv}msg"), where
> MSG_CMSG_COMPAT is allowed (and a no-op) in compat syscalls, but banned=

> from non-compat syscalls.
>=20
> So I agree that it's very weird that this flag gets returned to user sp=
ace,
> even while the internal flag that it's modeled after doesn't. I suppose=
 I
> could spin up a nice story, where the user-space function calling recvm=
sg()
> is totally separate from the function processing the returned struct
> msghdr, and the latter function would really like to know whether the f=
ds
> in that message are close-on-exec without having to call fcntl(F_GETFD)=
=2E
> But that's all just a total guess. If you want to know for sure, perhap=
s
> cc'ing Drepper may be worthwhile?
>=20
> A cursory look hasn't shown me any existing user-space code that depend=
s on
> this behavior. Though one library appears to be aware of this behavior,=

> actively filtering MSG_CMSG_CLOEXEC out of the result flags:
> <https://github.com/dutchanddutch/node-socket-calls/blob/ca759a0da87cb1=
12875d158f4a81b45b31f4a871/src/socket_calls.cc#L417>
>=20
> Also, only somewhat relatedly, some libraries incorrectly attempt to
> request MSG_CMSG_CLOEXEC by passing it into the msg_flags field instead=
 of
> the flags argument:
> <https://git.samba.org/samba.git/?p=3Dsamba.git;a=3Dblob;f=3Dlib/messag=
ing/messages_dgm.c;hb=3Drefs/tags/samba-4.17.9#l1272>
> <https://github.com/genodelabs/genode/blob/23.05/repos/base-linux/src/l=
ib/base/ipc.cc#L132>
> <https://github.com/proxmox/pve-lxc-syscalld/blob/a14430f3e75c2b695332a=
d712164e599464177fc/src/io/seq_packet.rs#L123>

In any case, all of this mail has been very interesting,
and it would be useful to have it in the commit message of the patch.
Please send an v2 with it, and add 'Cc:' tags for all these people:

Cc: <linux-api@vger.kernel.org>
Cc: <netdev@vger.kernel.org>
Cc: Ulrich Drepper <drepper@gmail.com>
Cc: Ulrich Drepper <drepper@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

(I don't know if <drepper@redhat.com> still works.  Does anyone know?)

Thanks!
Alex

>=20
> Thank you,
> Matthew House

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------botqBotNa7AKw0NfaN0pDAUd--

--------------Dac0DMFjn2KQY7N829aKX9UO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmS2f3YACgkQnowa+77/
2zJ9iBAAj5PgJ/3F3qti5XTtK4VwTFO6bJN3Dv4KOr7pb4mwZoJ20cQ0llFX5xuf
5sY6uA2V8wLtpOjbx0tSJM4y0dQD+PjkYjjKfrIJZr9syOY8WO0dhKG8lrUR53Co
ygvCjuOPU3dxdy9tJo9eYVizz1vIj1Dh/2LGX0iR2jKoas69uypZuuXPVI6CKxEC
a+J9XJouch+S2GDENgtRjmyYHfhCxCrXrdNejWE1tF5zFJXbx5XUWVNbRsG/2ksq
lCw7vqB6TxKxUOD03KNnTpzmzCdeRIFWt0SgqlLiFAM/91ueFXTphWT5UaF+qEwh
SuiemkogwsO8uILlD+9YZCTyRbzFIbwwnweBitdP5x0S7XPFrwxuKnXgAcYlDa85
yFUuQCD5M7LK+htpWNf6gGd+pjeU8jige8Da4juXFeMNh2BKLVFJTh8NZ1kkwKqQ
XtEqvBOzFFkSpLk6dwPpph2tSCUFOBMlbqanC+rP49NvoOWBItR8K7QvX7AjUaaU
PBg0dSI1jTYZqm3/YXTiCk1QmJu1Jq4k8m596WyUAwjeJEpEKEVq2kidXSIe2oj5
6MZwIF2ggnWGfgxXQIb7Kx3FFS779jFq0rbnUYSkUdpiEgUx4CurQBRH4JWPj412
hlKMyyjiGOxLHuin1EADJMuvPUwYd0YzLLy0v0pWFLSPjaNmJCk=
=BSXr
-----END PGP SIGNATURE-----

--------------Dac0DMFjn2KQY7N829aKX9UO--
