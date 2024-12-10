Return-Path: <linux-api+bounces-2880-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDAC9EA798
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 06:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C491888EED
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 05:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA2E226172;
	Tue, 10 Dec 2024 05:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aZlO+0AX"
X-Original-To: linux-api@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E975C2248A1;
	Tue, 10 Dec 2024 05:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733807707; cv=none; b=SZ1EV6r1U7I0XJ9B7Aag/+H+gOAYRfUpxn0jMUVPr3nAQKyVhpZ5zKvbM4c1UZBZDaoeYU39Dx2hFAzGEy0vVVRu+xJfdb+IhqYI1HD4+kVJI+Xg3tdFmmE79Lr5Z9QToG69bknIdiOH8CY87GOMFXNQmEp1r65LQBLvwdd3wr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733807707; c=relaxed/simple;
	bh=TAS3M9iUKSSJcFvlIA+AyNjSaKPXwEuJbNu3TRAmWGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhln8hUHm3xtnnfhLBjAH9OwasQWaUEq8lp5vKRAxetvGbzWS+FW3D0gh7wIX5ATWswxC8m3kQx81PuWmA2lT0E/vTrZdpMT5vII23gWTYGg8Bmom3yHqbtab+HTXjw2ZdhKWzMV//7HcaCjAfQDPj7PLa0mg59SnC8pypA9zhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aZlO+0AX; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733807695; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=2ZA9ZIdTj9FS727EqJt3O2PQJRHFWHzqJzoof+IPQO0=;
	b=aZlO+0AXWvXMpZIxIZnXz9CP90qfcpMa+JKWcHeqvG2sBD/rWD7l/nTg/kspjYxWIj0Osw5kQyvdWBDw4k0mF6fI42K9kaGCNmc4epUetisEr6KtYvXsHcCpkhti0LEMsBT3ElstQFTaPFBDqRVCp0MLEhrw++Ns+zVy5NO2+nw=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDmYYh_1733807694 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 13:14:55 +0800
Date: Tue, 10 Dec 2024 13:14:54 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
Message-ID: <20241210051454.GA83318@j66a10360.sqa.eu95>
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
 <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
 <b4bf68f1-189c-4685-8e1a-d8cbf60c1120@linux.alibaba.com>
 <CAGXJAmxkR7Wgmd2+eUKwOHos2tGbSJ8UFqYKE4nsegg7sr96WQ@mail.gmail.com>
 <CAGXJAmzzmNrp-7OANK1yQX+xJcGAYjTWDFuyhdD5pvjN28CtXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmzzmNrp-7OANK1yQX+xJcGAYjTWDFuyhdD5pvjN28CtXQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 09, 2024 at 09:03:08AM -0800, John Ousterhout wrote:
> A follow-up question on this, if I may. Is it OK to vmap a large
> region of user address space (say, 64 MB) and leave this mapped for an
> extended period of time (say, the life of the application), or would
> this have undesirable consequences? In other words, if I do this,
> would I need to monitor how actively the memory is being used and
> release the vmap for space that is inactive?
> 
> -John-
> 
> 

I am not an expert in this field, so the following is just my personal
opinion.

When users call setsockopt(HOMA_RCV), they should be aware that this
memory will be occupied by the kernel no matter how large this
memory is, until the user explicitly notifies the kernel to release this memory
(HOMA can only do this through close ?).

Therefore, my understanding is that the kernel does not
need to be responsible for the lifecycle of this memory. For example, if
the user space forgets that this registered memory has already been
freed, then a write from the kernel of cause could corrupt the user-space data,
but the kernel has no need to responsible for that.

If you believe that this could waste memory, perhaps you should provide
a sparse data structure instead of a fixed memory interface.

D. Wythe

> On Mon, Dec 9, 2024 at 8:53 AM John Ousterhout <ouster@cs.stanford.edu> wrote:
> >
> > Thanks for the additional information; I'll put this on my list of
> > things to consider for performance optimization.
> >
> > -John-
> >
> >
> > On Sun, Dec 8, 2024 at 10:56 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> > >
> > >
> > >
> > > On 12/6/24 3:49 AM, John Ousterhout wrote:
> > > > On Sun, Dec 1, 2024 at 7:51 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> > > >>> +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
> > > >>> +                 unsigned int optlen)
> > > >>> +{
> > > >>> +     struct homa_sock *hsk = homa_sk(sk);
> > > >>> +     struct homa_set_buf_args args;
> > > >>> +     int ret;
> > > >>> +
> > > >>> +     if (level != IPPROTO_HOMA || optname != SO_HOMA_SET_BUF ||
> > > >>> +         optlen != sizeof(struct homa_set_buf_args))
> > > >>> +             return -EINVAL;
> > > >>
> > > >> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can be
> > > >> implemented in getsockopt.
> > > >
> > > > I have changed it to HOMA_RCVBUF (and renamed struct homa_set_buf_args
> > > > to struct homa_rcvbuf_args). I also implemented getsockopt for
> > > > HOMA_RCVBUF.
> > > >
> > > >>> +
> > > >>> +     if (copy_from_sockptr(&args, optval, optlen))
> > > >>> +             return -EFAULT;
> > > >>> +
> > > >>> +     /* Do a trivial test to make sure we can at least write the first
> > > >>> +      * page of the region.
> > > >>> +      */
> > > >>> +     if (copy_to_user((__force void __user *)args.start, &args, sizeof(args)))
> > > >>> +             return -EFAULT;
> > > >>
> > > >> To share buffer between kernel and userspace, maybe you should refer to the implementation of
> > > >> io_pin_pbuf_ring()
> > > >
> > > > I'm not sure what you mean here. Are you suggesting that I look at the
> > > > code of io_pin_pbuf_ring to make sure I've done everything needed to
> > > > share buffers? I don't believe that Homa needs to do anything special
> > > > (e.g. it doesn't need to pin the user's buffers); it just saves the
> > > > address and makes copy_to_user calls later when needed (and these
> > > > calls are all done at syscall level in the context of the
> > > > application). Is there something I'm missing?
> > > >
> > >
> > > I just thought that since the received buffer is shared between kernel and user-space, if using
> > > vmap() to map the very memory, so that we don't need to use such "copy_to_user" to transfer the data
> > > from kernel to user-space, we can use memcpy() instead. This shall be more faster, but I had no
> > > relevant data to prove it..
> > >
> > > So I'm not going to insist on it, it ups to you.
> > >
> > > D. Wythe

