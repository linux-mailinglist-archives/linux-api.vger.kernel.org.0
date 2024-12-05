Return-Path: <linux-api+bounces-2841-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7CA9E5F21
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2024 20:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07F816C4C7
	for <lists+linux-api@lfdr.de>; Thu,  5 Dec 2024 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED26227BB5;
	Thu,  5 Dec 2024 19:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="qlcdh6k3"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC61B218F
	for <linux-api@vger.kernel.org>; Thu,  5 Dec 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733428189; cv=none; b=dVfMosx/FnbaKivvPpd+8l6Yz0PtNSvgkOK1sesv38PNemLof2Lqtj/RCzu+1AiCbLw1ZJLCvx/fIaSbKr1GV3t/3SKXTod7HOoaRRgWmxqwwB8y9MuKukOna6GjV3ZsCXxdKpU9rVJTvVbuThdiRGTXP69Pn8fFNL8iHTw4hk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733428189; c=relaxed/simple;
	bh=BS8yQvb8lZJY58Hmywn/i7LEO8Qy3r3PXGOTPgp2tZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QaduUU4z6/mmQm/9aNL2lzftF3To2Z9ViRAvlQU/yBiqkjur5hKEzm+ZZIwfteZrFxN7W+7qvN90DHpTONDsVY0SZZrFBbL9kS5qr4+iXHVFVrEVaW4lmBAAOAl+1Ab2WTVWMz5iZ+QA0DUZmJFJsKfAYwx1X7kdyeg8FkrZPMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=qlcdh6k3; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PisVU2txEHHM4YTkpfkzypV97rChtEdNjRShYPLfwBU=; t=1733428188; x=1734292188; 
	b=qlcdh6k3naBUz9toG9B7gZYo/1tnpCEHpIfVpMA3hKjLIwJJDNw4qsO1e6rvVEbt40E996/lEYb
	+gXWwSGaJlXClGIOVcQUn8bm3iTjByxKgyIR8M+kW8gbcW+KlbQ5Z9bdRqwb9OzzXq5wTxtOK5dfa
	Z0p9Nqo+Ebcxy14Qtr4JWXKVoxTHWFt5lb2LmQLJoqj/GleKQgJrXV+hw41N0fczTNAlyvUv9xzso
	c1pJnOOVAg52WhEnQEGwAwCNOgkN3lsIfCEYQhAQzr0vErKHafJuDSmB/uoU9fyjgIq/gzQfLQEd3
	OUk35H6FknkZOZs9kCLG6xnMa8JN91LpC7Zw==;
Received: from mail-oi1-f178.google.com ([209.85.167.178]:50323)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tJHr7-0004dc-DM; Thu, 05 Dec 2024 11:49:47 -0800
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3ea78529de1so301794b6e.0;
        Thu, 05 Dec 2024 11:49:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs3yVITIM4T+DRT1UejtLaPbQmQjfeOWLkcxva6fsE7hKzRj0nQrJh4QUAARXh4XHJdSkJ4zTFMkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSnzFqwZ6y7SFmgcGcHFk4wGcYpnWpQD3IjP/GQTRFSe24KofC
	Wanw9XlRY+9/J59YN8PoB30XwQ6wCRsrwHkgQEbgVOdOdHFges4+vd5owbKbJDXLfsjusF/HTP9
	CaWKMP9WUV8C0rBoJ1fXl/9I3A1o=
X-Google-Smtp-Source: AGHT+IEci/iXS3Bv1RNAtUF8QhcmqNMuJRa2m2yFkliZHvnt4oqJwwgS1W3KGHSNbbR5ltDpvLNa6wzxrvai+sFjgDA=
X-Received: by 2002:aca:2b16:0:b0:3ea:6d2f:b763 with SMTP id
 5614622812f47-3eb19da78femr71389b6e.29.1733428184693; Thu, 05 Dec 2024
 11:49:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
In-Reply-To: <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 5 Dec 2024 11:49:09 -0800
X-Gmail-Original-Message-ID: <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
Message-ID: <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 755e08f2f25288cbff1b38deb5b03168

On Sun, Dec 1, 2024 at 7:51=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
> > +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr_t=
 optval,
> > +                 unsigned int optlen)
> > +{
> > +     struct homa_sock *hsk =3D homa_sk(sk);
> > +     struct homa_set_buf_args args;
> > +     int ret;
> > +
> > +     if (level !=3D IPPROTO_HOMA || optname !=3D SO_HOMA_SET_BUF ||
> > +         optlen !=3D sizeof(struct homa_set_buf_args))
> > +             return -EINVAL;
>
> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can be
> implemented in getsockopt.

I have changed it to HOMA_RCVBUF (and renamed struct homa_set_buf_args
to struct homa_rcvbuf_args). I also implemented getsockopt for
HOMA_RCVBUF.

> > +
> > +     if (copy_from_sockptr(&args, optval, optlen))
> > +             return -EFAULT;
> > +
> > +     /* Do a trivial test to make sure we can at least write the first
> > +      * page of the region.
> > +      */
> > +     if (copy_to_user((__force void __user *)args.start, &args, sizeof=
(args)))
> > +             return -EFAULT;
>
> To share buffer between kernel and userspace, maybe you should refer to t=
he implementation of
> io_pin_pbuf_ring()

I'm not sure what you mean here. Are you suggesting that I look at the
code of io_pin_pbuf_ring to make sure I've done everything needed to
share buffers? I don't believe that Homa needs to do anything special
(e.g. it doesn't need to pin the user's buffers); it just saves the
address and makes copy_to_user calls later when needed (and these
calls are all done at syscall level in the context of the
application). Is there something I'm missing?

> > +
> > +     homa_sock_lock(hsk, "homa_setsockopt SO_HOMA_SET_BUF");
> > +     ret =3D homa_pool_init(hsk, (__force void __user *)args.start, ar=
gs.length);
> > +     homa_sock_unlock(hsk);
>
> It seems that if the option was not set, poll->hsk will not be initialize=
d
> and then if recvmsg is called, a panic will be triggered.

I fixed homa_pool_check_waiting to properly handle empty pools.

> > +/**
> > + * homa_sendmsg() - Send a request or response message on a Homa socke=
t.
> > + * @sk:     Socket on which the system call was invoked.
> > + * @msg:    Structure describing the message to send; the msg_control
> > + *          field points to additional information.
> > + * @length: Number of bytes of the message.
> > + * Return: 0 on success, otherwise a negative errno.
> > + */
> > +int homa_sendmsg(struct sock *sk, struct msghdr *msg, size_t length)
> > +{
> > +     struct homa_sock *hsk =3D homa_sk(sk);
> > +     struct homa_sendmsg_args args;
> > +     int result =3D 0;
> > +     struct homa_rpc *rpc =3D NULL;
> > +     union sockaddr_in_union *addr =3D (union sockaddr_in_union *)msg-=
>msg_name;
>
> msg->msg_name can be NULL.

I have added a check for this.

> > +     if (addr->in6.sin6_family !=3D sk->sk_family) {
> > +             result =3D -EAFNOSUPPORT;
> > +             goto error;
> > +     }
>
> addr->sa.sa_family? Using sin6_family would be odd to me, making it seem =
like homa can only run with
> IPv6.

The family is in the same place for all protocols so I thought it
would be safe to reference it as in6.sin6_family. But you're right
that it looks odd, so I changed it to addr->sa.sa_family.

> > +             rpc =3D homa_rpc_new_client(hsk, addr);
> > +             if (IS_ERR(rpc)) {
> > +                     result =3D PTR_ERR(rpc);
> > +                     rpc =3D NULL;
> > +                     goto error;
> > +             }
> > +             rpc->completion_cookie =3D args.completion_cookie;
> > +             result =3D homa_message_out_fill(rpc, &msg->msg_iter, 1);
> > +             if (result)
> > +                     goto error;
> > +             args.id =3D rpc->id;
> > +             homa_rpc_unlock(rpc);
>
> Strongly recommend that adding comments with all the unlock part to indic=
ate where it was
> locked from.

I went through the code and added comments in places where the locking
isn't relatively obvious (e.g. it happens through methods without
"lock" in their name, such as homa_rpc_new_client). I also renamed
homa_try_bucket_lock to homa_try_rpc_lock, which will clarify RPC
locking a bit better.

> > +             canonical_dest =3D canonical_ipv6_addr(addr);
>
> Are you treating all addresses as IPv6 addresses just for the sake of sim=
plicity? It's a bit odd,
> but okay to me.

Yes: Homa uses IPv6 addresses internally for both IPv4 and IPv6; this
allows Homa to work with both IPv4 and IPv6 with only a small amount
of code that is protocol-specific.

> > +int homa_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int =
flags,
> > +              int *addr_len)
> > +{
> > +     struct homa_sock *hsk =3D homa_sk(sk);
> > +     struct homa_recvmsg_args control;
> > +     struct homa_rpc *rpc;
> > +     int result;
> > +
> > +     if (unlikely(!msg->msg_control)) {
> > +             /* This test isn't strictly necessary, but it provides a
> > +              * hook for testing kernel call times.
> > +              */
> > +             return -EINVAL;
> > +     }
> > +     if (msg->msg_controllen !=3D sizeof(control)) {
> > +             result =3D -EINVAL;
> > +             goto done;
>
> Then you copied an uninitialized control into userspace ...
> Is goto really necessary ? Maybe just return.

Good catch; I changed it to just return. In general, I prefer to
funnel everything through a single cleanup-and-return point rather
than returning directly in some cases and jumping to a cleanup point
in others; I think that makes the code cleaner and more obvious. But,
that doesn't really work here.

>
> > +     }
> > +     if (unlikely(copy_from_user(&control,
> > +                                 (__force void __user *)msg->msg_contr=
ol,
> > +                                 sizeof(control)))) {
> > +             result =3D -EFAULT;
> > +             goto done;
>
> Same as above, is goto really necessary ?

I changed it to return directly.

> > +     }
> > +     control.completion_cookie =3D 0;
> > +
> > +     if (control.num_bpages > HOMA_MAX_BPAGES ||
> > +         (control.flags & ~HOMA_RECVMSG_VALID_FLAGS)) {
> > +             result =3D -EINVAL;
> > +             goto done;
> > +     }
> > +     homa_pool_release_buffers(hsk->buffer_pool, control.num_bpages,
> > +                               control.bpage_offsets);
>
> homa_pool_release_buffers() quietly ignores erroneous bpage_index values =
passed in from the
> userspace. This behavior may obscure more complex issues in userspace, an=
d exposure this problem
> could help users identify issues earlier.

Good point; homa_recvmsg now returns -EINVAL if there are erroneous
bpage_index values passed in.


> > +     control.num_bpages =3D 0;
> > +
> > +     rpc =3D homa_wait_for_message(hsk, (flags & MSG_DONTWAIT)
> > +                     ? (control.flags | HOMA_RECVMSG_NONBLOCKING)
> > +                     : control.flags, control.id);
> > +     if (IS_ERR(rpc)) {
> > +             /* If we get here, it means there was an error that preve=
nted
> > +              * us from finding an RPC to return. If there's an error =
in
> > +              * the RPC itself we won't get here.
> > +              */
> > +             result =3D PTR_ERR(rpc);
> > +             goto done;
> > +     }
> > +     result =3D rpc->error ? rpc->error : rpc->msgin.length;
>
> A trivial tips.
>
> result =3D rpc->error ?: rpc->msgin.length;

I wasn't aware that the shorter form existed. However, I find the
longer form a bit more obvious, so I'd prefer to leave that unless you
feel strongly that it should be abbreviated.

> > +
> > +     /* Collect result information. */
> > +     control.id =3D rpc->id;
> > +     control.completion_cookie =3D rpc->completion_cookie;
> > +     if (likely(rpc->msgin.length >=3D 0)) {
> > +             control.num_bpages =3D rpc->msgin.num_bpages;
> > +             memcpy(control.bpage_offsets, rpc->msgin.bpage_offsets,
> > +                    sizeof(control.bpage_offsets));
>
> A trivial tips.
>
> Although sizeof(control.bpage_offsets) and sizeof(rpc->msgin.bpage_offset=
s) are the same, but
> passing sizeof(rpc->msgin.bpage_offsets) would be more appropriate.

Done.

Thanks for the comments; lots of good caches there.

-John-

