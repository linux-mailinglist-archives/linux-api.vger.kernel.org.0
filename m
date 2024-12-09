Return-Path: <linux-api+bounces-2848-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7805E9E9C85
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 18:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE7516738D
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 17:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18BE13AA2F;
	Mon,  9 Dec 2024 17:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="Aj2Pyz7H"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991A149DFF
	for <linux-api@vger.kernel.org>; Mon,  9 Dec 2024 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763827; cv=none; b=nGoKZCJV5ZH7a2FBibcy7ZWzwpyCz3O+arttFbSpQCu1ztQjrEORinbUULR3Bn7O6VfL4FBja5dYy5lxo9KhPE6SHQ6M7cso2Ix2IcaafvVf1fteIb8EsaGtexyd6KZ2o/WRClOsGHnkp1/H6/PywDPiO8bK8PvaOTXrI3Jyyw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763827; c=relaxed/simple;
	bh=TS2dJvRpcbYgPpTKZ5ZMeYuSA6Xg6ig0fMR+eYbQUgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPNf7c/VG1yTvo34TSRa95cquATYcepdLUysjPLtvjfagVKYx6KsUp/wcXMN6NmY4hC3zbj/CeI3KPImAr8BA6/FZJ+/+xLFTbIj0zbNnhOTQffqIrH3HCaFuoxuhD514zzwM6zHA3X/Ou80UYiuzMqVBaJfIJ7tSPfrTGGTT6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=Aj2Pyz7H; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ja54K3Mix1tFT4xLqbj9VGzMOknxqdpdclB1ZrggbhM=; t=1733763826; x=1734627826; 
	b=Aj2Pyz7HxjsqpB/UoMXNLNl275lmDBCnKSOrmb6eOrZBK3FdxnqPSSl1HrvUp5Mo/1yLHPrxpk/
	giuplY8xfNTE0awvj83O4huiFlB6M97zd1mnQKJVXaTeehhlHBw2EayzsEvGdBydgv/E2+7zr9DLm
	LgkOVMbLDr/wbksAI/QHdgPjOps9k+rYn5gqA1ayg8CDENk1KbOfjP88V/MqLQZgmPpJJhBb7mOdC
	IP2z2xE7G/zt9UeMHzestI5stmqx9yoSaCMjgI8+rjqextEuS98k6NCJvRKpdNisOLYIUcSXTfUib
	oruzyAK5zjbqUZj7Q5anveKnnuwfK2LSG17Q==;
Received: from mail-oi1-f177.google.com ([209.85.167.177]:60735)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tKhAe-00031R-WD; Mon, 09 Dec 2024 09:03:45 -0800
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3eb34620af9so958501b6e.1;
        Mon, 09 Dec 2024 09:03:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUsoMReA/ZPKvqOVuYZ7OuBhiHiHllfDiU3AcfxU0mYygZUocgNKDL1y9C8scYd2xs+yQygL5p414=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw66QH8WtKV2Sc2b7QIiGbTvLo67BdOWVmb/ifAIoLUQ4w4lS+M
	ySfP/jdB39US0Tg4qW8FrrLCQNjAanVEntQRtC9tpuZXRIFaUbnZre8YlWAla/pzbIVXmUhGkoW
	KCt0seHOOBk5eMU26ylgJHNQ4BUg=
X-Google-Smtp-Source: AGHT+IEx49wfEmM9KnGVO24uFYJAhJE6eoNVVDYpalHyD8aUiQ9WMrfjb8X+AwJBVyX8mq+O2ZE0+FcSo/FJ/5TmQNk=
X-Received: by 2002:a05:6870:a91f:b0:29e:5522:8ee4 with SMTP id
 586e51a60fabf-29f733ace51mr11999301fac.25.1733763824396; Mon, 09 Dec 2024
 09:03:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com> <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
 <b4bf68f1-189c-4685-8e1a-d8cbf60c1120@linux.alibaba.com> <CAGXJAmxkR7Wgmd2+eUKwOHos2tGbSJ8UFqYKE4nsegg7sr96WQ@mail.gmail.com>
In-Reply-To: <CAGXJAmxkR7Wgmd2+eUKwOHos2tGbSJ8UFqYKE4nsegg7sr96WQ@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 9 Dec 2024 09:03:08 -0800
X-Gmail-Original-Message-ID: <CAGXJAmzzmNrp-7OANK1yQX+xJcGAYjTWDFuyhdD5pvjN28CtXQ@mail.gmail.com>
Message-ID: <CAGXJAmzzmNrp-7OANK1yQX+xJcGAYjTWDFuyhdD5pvjN28CtXQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 37a9e86f2e4d2511d38563a73d487f50

A follow-up question on this, if I may. Is it OK to vmap a large
region of user address space (say, 64 MB) and leave this mapped for an
extended period of time (say, the life of the application), or would
this have undesirable consequences? In other words, if I do this,
would I need to monitor how actively the memory is being used and
release the vmap for space that is inactive?

-John-


On Mon, Dec 9, 2024 at 8:53=E2=80=AFAM John Ousterhout <ouster@cs.stanford.=
edu> wrote:
>
> Thanks for the additional information; I'll put this on my list of
> things to consider for performance optimization.
>
> -John-
>
>
> On Sun, Dec 8, 2024 at 10:56=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.c=
om> wrote:
> >
> >
> >
> > On 12/6/24 3:49 AM, John Ousterhout wrote:
> > > On Sun, Dec 1, 2024 at 7:51=E2=80=AFPM D. Wythe <alibuda@linux.alibab=
a.com> wrote:
> > >>> +int homa_setsockopt(struct sock *sk, int level, int optname, sockp=
tr_t optval,
> > >>> +                 unsigned int optlen)
> > >>> +{
> > >>> +     struct homa_sock *hsk =3D homa_sk(sk);
> > >>> +     struct homa_set_buf_args args;
> > >>> +     int ret;
> > >>> +
> > >>> +     if (level !=3D IPPROTO_HOMA || optname !=3D SO_HOMA_SET_BUF |=
|
> > >>> +         optlen !=3D sizeof(struct homa_set_buf_args))
> > >>> +             return -EINVAL;
> > >>
> > >> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also ca=
n be
> > >> implemented in getsockopt.
> > >
> > > I have changed it to HOMA_RCVBUF (and renamed struct homa_set_buf_arg=
s
> > > to struct homa_rcvbuf_args). I also implemented getsockopt for
> > > HOMA_RCVBUF.
> > >
> > >>> +
> > >>> +     if (copy_from_sockptr(&args, optval, optlen))
> > >>> +             return -EFAULT;
> > >>> +
> > >>> +     /* Do a trivial test to make sure we can at least write the f=
irst
> > >>> +      * page of the region.
> > >>> +      */
> > >>> +     if (copy_to_user((__force void __user *)args.start, &args, si=
zeof(args)))
> > >>> +             return -EFAULT;
> > >>
> > >> To share buffer between kernel and userspace, maybe you should refer=
 to the implementation of
> > >> io_pin_pbuf_ring()
> > >
> > > I'm not sure what you mean here. Are you suggesting that I look at th=
e
> > > code of io_pin_pbuf_ring to make sure I've done everything needed to
> > > share buffers? I don't believe that Homa needs to do anything special
> > > (e.g. it doesn't need to pin the user's buffers); it just saves the
> > > address and makes copy_to_user calls later when needed (and these
> > > calls are all done at syscall level in the context of the
> > > application). Is there something I'm missing?
> > >
> >
> > I just thought that since the received buffer is shared between kernel =
and user-space, if using
> > vmap() to map the very memory, so that we don't need to use such "copy_=
to_user" to transfer the data
> > from kernel to user-space, we can use memcpy() instead. This shall be m=
ore faster, but I had no
> > relevant data to prove it..
> >
> > So I'm not going to insist on it, it ups to you.
> >
> > D. Wythe

