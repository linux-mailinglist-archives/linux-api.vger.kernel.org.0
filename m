Return-Path: <linux-api+bounces-2847-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC999E9C28
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 17:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B091886CFE
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 16:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2033A14884C;
	Mon,  9 Dec 2024 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Nfhkus41"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CF014B077
	for <linux-api@vger.kernel.org>; Mon,  9 Dec 2024 16:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763229; cv=none; b=C6D9mt0JO7WDL32XMWXyRPvXOCpzqojQcqSbHaBPiZr3s9zCIbyLNzQX6ZofFQ588NVytBlbpTFKZ1z95na7Viysb7qwXaXup39/qUdt6TrdGN2JbXlc8iUhZL5R9g4HGmIVz4yEl2qNMmOU7nfIyhCmrYjwX19QUKuje94nEEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763229; c=relaxed/simple;
	bh=nzhs+XhuI85Aboqzx6/Gi5n9/BrZ4n7SkMlLrEDtRtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIxWeUoISoXEWDN889baWfJo681CihO0EOsLYVWeE/tBOHXbAkE2fA8Fd/VBUTAGE/L6ujIg2Gz2ezLYwX8ynoyrwx8spS0nbAHOFvQUTmoL/IRod/+Ew33eX75uSdc+4zuE8Md/ZgcCQz/mDTZGTwMv4NnAe250EOsvvTub+tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Nfhkus41; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ky/6OyEhNZ5sN5gHIVseVpGgBLSCkT+H9/MTo6CbNx4=; t=1733763227; x=1734627227; 
	b=Nfhkus41+qAehh30eZiOGfZP3GGeIxGzsfL4r9xpPMQYzEbMj1Y6XeUOsso3loDXsuSvtgYzIC+
	O9CMfxyDHqVsLrO+trgz+EqkAH+ebDjnHDTnb3Vpjas0lQOFxNg8qR30jITo9ox6/9zrDlAUL/BHI
	k5H9WF4S0Eo8Jzeq4KXwtqjhtat5lHcBIqjWjLWuCBw6QK+hpyL+cytqfhPWq2TXdIWx85BTz1cXk
	B6aA1pnlnbuHwreC9Ss3lf67sKyWc3wNhCDlCCbHoHiFIwuwJcQ0lgwNNFba0PPN4+5amYK6sQQLk
	E8Q8qjEFiphf5WjtcERSwO7kAg9mAdx9rPLg==;
Received: from mail-oa1-f46.google.com ([209.85.160.46]:61669)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tKh0v-0002ML-1K; Mon, 09 Dec 2024 08:53:41 -0800
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29e998c70f9so2627597fac.2;
        Mon, 09 Dec 2024 08:53:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVYt8jTMmwxB/35lm1rPgbGVo1B4MNHxb/Dqe84nFt14HHbb/+ZETSCzjfixGXtji8B5dCJK41f40=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtrufFzKGoGobBwqAqVGoW3xRJxDNxgxxia2lxiJxUPCH2m8z
	OfheIp6GIH1ZN7ZhNVdCyq/9vQgwo/dkw4rxgv+HvooZMdOKuPAf/k0doE9sdLT8ZnxKMOiHyr7
	0AALMNfF4RCw25Q2UGtXShEb/eFQ=
X-Google-Smtp-Source: AGHT+IG+leR1pn8CtV8qGjlpHQjL2OV5d4oL5SoSTkxeAf1pTETfblc8kMj2XZktAeeiT6NhO6GZ7b799B13y2cHypo=
X-Received: by 2002:a05:6870:c03:b0:29e:4ba5:4ddc with SMTP id
 586e51a60fabf-29f73346d6dmr10746250fac.24.1733763220444; Mon, 09 Dec 2024
 08:53:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com> <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
 <b4bf68f1-189c-4685-8e1a-d8cbf60c1120@linux.alibaba.com>
In-Reply-To: <b4bf68f1-189c-4685-8e1a-d8cbf60c1120@linux.alibaba.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 9 Dec 2024 08:53:04 -0800
X-Gmail-Original-Message-ID: <CAGXJAmxkR7Wgmd2+eUKwOHos2tGbSJ8UFqYKE4nsegg7sr96WQ@mail.gmail.com>
Message-ID: <CAGXJAmxkR7Wgmd2+eUKwOHos2tGbSJ8UFqYKE4nsegg7sr96WQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: b05cf9a5276a81ca133e41a937654b06

Thanks for the additional information; I'll put this on my list of
things to consider for performance optimization.

-John-


On Sun, Dec 8, 2024 at 10:56=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com=
> wrote:
>
>
>
> On 12/6/24 3:49 AM, John Ousterhout wrote:
> > On Sun, Dec 1, 2024 at 7:51=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.=
com> wrote:
> >>> +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr=
_t optval,
> >>> +                 unsigned int optlen)
> >>> +{
> >>> +     struct homa_sock *hsk =3D homa_sk(sk);
> >>> +     struct homa_set_buf_args args;
> >>> +     int ret;
> >>> +
> >>> +     if (level !=3D IPPROTO_HOMA || optname !=3D SO_HOMA_SET_BUF ||
> >>> +         optlen !=3D sizeof(struct homa_set_buf_args))
> >>> +             return -EINVAL;
> >>
> >> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can =
be
> >> implemented in getsockopt.
> >
> > I have changed it to HOMA_RCVBUF (and renamed struct homa_set_buf_args
> > to struct homa_rcvbuf_args). I also implemented getsockopt for
> > HOMA_RCVBUF.
> >
> >>> +
> >>> +     if (copy_from_sockptr(&args, optval, optlen))
> >>> +             return -EFAULT;
> >>> +
> >>> +     /* Do a trivial test to make sure we can at least write the fir=
st
> >>> +      * page of the region.
> >>> +      */
> >>> +     if (copy_to_user((__force void __user *)args.start, &args, size=
of(args)))
> >>> +             return -EFAULT;
> >>
> >> To share buffer between kernel and userspace, maybe you should refer t=
o the implementation of
> >> io_pin_pbuf_ring()
> >
> > I'm not sure what you mean here. Are you suggesting that I look at the
> > code of io_pin_pbuf_ring to make sure I've done everything needed to
> > share buffers? I don't believe that Homa needs to do anything special
> > (e.g. it doesn't need to pin the user's buffers); it just saves the
> > address and makes copy_to_user calls later when needed (and these
> > calls are all done at syscall level in the context of the
> > application). Is there something I'm missing?
> >
>
> I just thought that since the received buffer is shared between kernel an=
d user-space, if using
> vmap() to map the very memory, so that we don't need to use such "copy_to=
_user" to transfer the data
> from kernel to user-space, we can use memcpy() instead. This shall be mor=
e faster, but I had no
> relevant data to prove it..
>
> So I'm not going to insist on it, it ups to you.
>
> D. Wythe

