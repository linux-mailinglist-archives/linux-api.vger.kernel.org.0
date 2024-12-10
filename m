Return-Path: <linux-api+bounces-2881-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFF39EA82C
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 06:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95163169BC0
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 05:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0B122617B;
	Tue, 10 Dec 2024 05:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="nIW9+JV4"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E057C1D356E
	for <linux-api@vger.kernel.org>; Tue, 10 Dec 2024 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733809843; cv=none; b=PBWwjcXPzYTA8abZ24Mn9qNMwAJuQnVW9kJbHxO8OKfwcFeHdMPbvVLzSFASFuJlgITHimcnvpiMeSc+TwB1Y7xE0PjqQ38byBuctlS7g3ISgMA2IxfilP42RM5rSZWl2ZO4ApJK5MhtH81PCs+yb229ZqZuomkGVjCyGfrJ7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733809843; c=relaxed/simple;
	bh=i12LuLilrWg6B9vu8z7dCPecWb0hCMyXfoZtEXsosaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRyLWQjOeZUy8sC8qKmF5SLIi79Bc/0jRlVJYvifozm/BP9a4JqZX3Jn6y2aDW1Lzcl+3Da8RCS1hFRkmoyKJyu53FZFkaiVh1hLp/Ky2NGp/OW9oswFwrxM0YxI7K5QXlQVKkUIPD/z7BCoXHFXc+h8Ka3uw/2zXsgduVsLJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=nIW9+JV4; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=o2mg0Xtw9YgLt/j6XwvSePsULYemrVG7dDKqpQqzw70=; t=1733809841; x=1734673841; 
	b=nIW9+JV4PtiC3O60qacCch5sohq1nSdliVxtPKLmJxXIzod0mFrKEybSUJd2Z4fuZ7PyqOJY5Wa
	psqWDt5pDbyBpT4EfZyGNXtBk1wjjJNlWb9phYt0EVnODBaqm0wla4gmeGebh+Ux4x/foolWz7+ZX
	7/npgUpL071qqdJ/d5ve5lLSL/Fc46+CYXVjwbwSVDaQQZ3bBFH8WPg0fEZYFUTlYKxErXjGH9yYP
	ShyOErBuCIdpI753M+jaB2Fta5te7XNIrAvVHIgJHUNwmpcXNT+6i4kN0oket45SDfE+gQZ7Mnm32
	xzNygKscNbLYWGLxsro9l3JJ8PdsejxvprPQ==;
Received: from mail-oo1-f42.google.com ([209.85.161.42]:56526)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tKt8q-0006GS-JE; Mon, 09 Dec 2024 21:50:41 -0800
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5f2ab8cb429so966937eaf.0;
        Mon, 09 Dec 2024 21:50:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXOkQnwlWo/TUNlgGY9tJ2q0UpmFxztf2UXeL6kuPLeLGE/vQFFe7+hYOTrraygPnI9k6r69/+DU/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9odX8EZJv6SNXvBJtzmtsRKAfo2mSJOU5iduYgWZayCvgv8ZE
	qRAxbncytkCvOO4MBxO9Rc3PJLEX/7TdtIeisxxWxo7jbaHVSZLt/ICoJVvwIpcVTDr4pEa56fc
	vvHN09Ukm+OQeVorx+0XSc+lQ4Bg=
X-Google-Smtp-Source: AGHT+IED29dcCGadD2TtZWN+13nlDUuuFX5cCy4N9yd/kFUXtGbSzj2WrjVlFLJ9VcRb0bA+CaY23WI/I0x0WE2i968=
X-Received: by 2002:a05:6870:bb15:b0:29e:5894:9de7 with SMTP id
 586e51a60fabf-29f734d3526mr11731477fac.33.1733809839915; Mon, 09 Dec 2024
 21:50:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111234006.5942-1-ouster@cs.stanford.edu> <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com> <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
 <b4bf68f1-189c-4685-8e1a-d8cbf60c1120@linux.alibaba.com> <CAGXJAmxkR7Wgmd2+eUKwOHos2tGbSJ8UFqYKE4nsegg7sr96WQ@mail.gmail.com>
 <CAGXJAmzzmNrp-7OANK1yQX+xJcGAYjTWDFuyhdD5pvjN28CtXQ@mail.gmail.com> <20241210051454.GA83318@j66a10360.sqa.eu95>
In-Reply-To: <20241210051454.GA83318@j66a10360.sqa.eu95>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 9 Dec 2024 21:50:03 -0800
X-Gmail-Original-Message-ID: <CAGXJAmwA-aEdEWezOxWhHB8tdsB6aaBYjwYCo+=Hnhh0j8up4Q@mail.gmail.com>
Message-ID: <CAGXJAmwA-aEdEWezOxWhHB8tdsB6aaBYjwYCo+=Hnhh0j8up4Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c homa_utils.c
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 4c131ba64fa6a0a0fa7484275de2528c

Thanks for the additional information. My concern was whether the
available kernel virtual address space for vmapping is a scarce
resource, in which case it might not be good for Homa to lock up large
amounts of it for long periods of time. I'm not as worried about
physical memory usage (that will happen regardless of whether the
buffers get vmapped into the kernel).

-John-


On Mon, Dec 9, 2024 at 9:14=E2=80=AFPM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
>
> On Mon, Dec 09, 2024 at 09:03:08AM -0800, John Ousterhout wrote:
> > A follow-up question on this, if I may. Is it OK to vmap a large
> > region of user address space (say, 64 MB) and leave this mapped for an
> > extended period of time (say, the life of the application), or would
> > this have undesirable consequences? In other words, if I do this,
> > would I need to monitor how actively the memory is being used and
> > release the vmap for space that is inactive?
> >
> > -John-
> >
> >
>
> I am not an expert in this field, so the following is just my personal
> opinion.
>
> When users call setsockopt(HOMA_RCV), they should be aware that this
> memory will be occupied by the kernel no matter how large this
> memory is, until the user explicitly notifies the kernel to release this =
memory
> (HOMA can only do this through close ?).
>
> Therefore, my understanding is that the kernel does not
> need to be responsible for the lifecycle of this memory. For example, if
> the user space forgets that this registered memory has already been
> freed, then a write from the kernel of cause could corrupt the user-space=
 data,
> but the kernel has no need to responsible for that.
>
> If you believe that this could waste memory, perhaps you should provide
> a sparse data structure instead of a fixed memory interface.
>
> D. Wythe
>
> > On Mon, Dec 9, 2024 at 8:53=E2=80=AFAM John Ousterhout <ouster@cs.stanf=
ord.edu> wrote:
> > >
> > > Thanks for the additional information; I'll put this on my list of
> > > things to consider for performance optimization.
> > >
> > > -John-
> > >
> > >
> > > On Sun, Dec 8, 2024 at 10:56=E2=80=AFPM D. Wythe <alibuda@linux.aliba=
ba.com> wrote:
> > > >
> > > >
> > > >
> > > > On 12/6/24 3:49 AM, John Ousterhout wrote:
> > > > > On Sun, Dec 1, 2024 at 7:51=E2=80=AFPM D. Wythe <alibuda@linux.al=
ibaba.com> wrote:
> > > > >>> +int homa_setsockopt(struct sock *sk, int level, int optname, s=
ockptr_t optval,
> > > > >>> +                 unsigned int optlen)
> > > > >>> +{
> > > > >>> +     struct homa_sock *hsk =3D homa_sk(sk);
> > > > >>> +     struct homa_set_buf_args args;
> > > > >>> +     int ret;
> > > > >>> +
> > > > >>> +     if (level !=3D IPPROTO_HOMA || optname !=3D SO_HOMA_SET_B=
UF ||
> > > > >>> +         optlen !=3D sizeof(struct homa_set_buf_args))
> > > > >>> +             return -EINVAL;
> > > > >>
> > > > >> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which als=
o can be
> > > > >> implemented in getsockopt.
> > > > >
> > > > > I have changed it to HOMA_RCVBUF (and renamed struct homa_set_buf=
_args
> > > > > to struct homa_rcvbuf_args). I also implemented getsockopt for
> > > > > HOMA_RCVBUF.
> > > > >
> > > > >>> +
> > > > >>> +     if (copy_from_sockptr(&args, optval, optlen))
> > > > >>> +             return -EFAULT;
> > > > >>> +
> > > > >>> +     /* Do a trivial test to make sure we can at least write t=
he first
> > > > >>> +      * page of the region.
> > > > >>> +      */
> > > > >>> +     if (copy_to_user((__force void __user *)args.start, &args=
, sizeof(args)))
> > > > >>> +             return -EFAULT;
> > > > >>
> > > > >> To share buffer between kernel and userspace, maybe you should r=
efer to the implementation of
> > > > >> io_pin_pbuf_ring()
> > > > >
> > > > > I'm not sure what you mean here. Are you suggesting that I look a=
t the
> > > > > code of io_pin_pbuf_ring to make sure I've done everything needed=
 to
> > > > > share buffers? I don't believe that Homa needs to do anything spe=
cial
> > > > > (e.g. it doesn't need to pin the user's buffers); it just saves t=
he
> > > > > address and makes copy_to_user calls later when needed (and these
> > > > > calls are all done at syscall level in the context of the
> > > > > application). Is there something I'm missing?
> > > > >
> > > >
> > > > I just thought that since the received buffer is shared between ker=
nel and user-space, if using
> > > > vmap() to map the very memory, so that we don't need to use such "c=
opy_to_user" to transfer the data
> > > > from kernel to user-space, we can use memcpy() instead. This shall =
be more faster, but I had no
> > > > relevant data to prove it..
> > > >
> > > > So I'm not going to insist on it, it ups to you.
> > > >
> > > > D. Wythe

