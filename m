Return-Path: <linux-api+bounces-2882-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FE39EA890
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 07:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AF9167E3F
	for <lists+linux-api@lfdr.de>; Tue, 10 Dec 2024 06:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E5822A1C0;
	Tue, 10 Dec 2024 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kt+5rz5t"
X-Original-To: linux-api@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4683922ACE5;
	Tue, 10 Dec 2024 06:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733811222; cv=none; b=UbLPAlhat5Clc9IJJSUjSmY8NT84QyeacSDbkQPDJqxl+PMpbucJUVkGx6T8fdxbO1nBp7hkrAzVAZVMuy61YSMowgoLE9W154cJQZQDiG1QizRUsfZ/2RXMHm6s3JzujAaiOQwevybJtvx7DrtdBnXhVMbESEGx2EysOmQJ2Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733811222; c=relaxed/simple;
	bh=SBDcaV0uL6z+dHvQUuZaquigSzTVYiVKMOG3bc9vJDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CYlDpmi/et100CTxyH3P+UrbDcTDsXiZvLx2JZt4W0lcXYYcZirLGCK356eAtke4YMzCiNZfl9itvOf5ug4YdOaR67Nlu+5ThbUv8j+QuqaIU7MTNV7JUaiZ/tO+NoUWLXH9I38TYpSEAoSIna5e6YWz9zZX2Cao2LtJVC3Vl+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kt+5rz5t; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733811216; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=SSmVo90RsJw81KC3euiYKS96JQMcBPF1+qB5NCX7uW8=;
	b=kt+5rz5tQyBBAHS4UxLLYi4EitvvrVwko69KCEebfWTTd1EIz41F1aei2d6ZR3bjcWx4IG6Yx+4AS3x3Ynkif6ymfkn8QfdHTkTnda2vRBa4vgCaTbSR6vo19ofK5oJwFffZM+tox7TbihZ3VTJNya2+8vUrVUkfybDlG1heBfw=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WLDtu-P_1733811215 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Dec 2024 14:13:36 +0800
Date: Tue, 10 Dec 2024 14:13:35 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: "D. Wythe" <alibuda@linux.alibaba.com>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
Message-ID: <20241210061335.GA22834@j66a10360.sqa.eu95>
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
 <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
 <b4bf68f1-189c-4685-8e1a-d8cbf60c1120@linux.alibaba.com>
 <CAGXJAmxkR7Wgmd2+eUKwOHos2tGbSJ8UFqYKE4nsegg7sr96WQ@mail.gmail.com>
 <CAGXJAmzzmNrp-7OANK1yQX+xJcGAYjTWDFuyhdD5pvjN28CtXQ@mail.gmail.com>
 <20241210051454.GA83318@j66a10360.sqa.eu95>
 <CAGXJAmwA-aEdEWezOxWhHB8tdsB6aaBYjwYCo+=Hnhh0j8up4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXJAmwA-aEdEWezOxWhHB8tdsB6aaBYjwYCo+=Hnhh0j8up4Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Dec 09, 2024 at 09:50:03PM -0800, John Ousterhout wrote:

It seems I misunderstood your point... I'm indeed not familiar with this.
Perhaps other members of the community can help you.

D. Wythe

> Thanks for the additional information. My concern was whether the
> available kernel virtual address space for vmapping is a scarce
> resource, in which case it might not be good for Homa to lock up large
> amounts of it for long periods of time. I'm not as worried about
> physical memory usage (that will happen regardless of whether the
> buffers get vmapped into the kernel).
> 
> -John-
> 
> 
> On Mon, Dec 9, 2024 at 9:14 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 09:03:08AM -0800, John Ousterhout wrote:
> > > A follow-up question on this, if I may. Is it OK to vmap a large
> > > region of user address space (say, 64 MB) and leave this mapped for an
> > > extended period of time (say, the life of the application), or would
> > > this have undesirable consequences? In other words, if I do this,
> > > would I need to monitor how actively the memory is being used and
> > > release the vmap for space that is inactive?
> > >
> > > -John-
> > >
> > >
> >
> > I am not an expert in this field, so the following is just my personal
> > opinion.
> >
> > When users call setsockopt(HOMA_RCV), they should be aware that this
> > memory will be occupied by the kernel no matter how large this
> > memory is, until the user explicitly notifies the kernel to release this memory
> > (HOMA can only do this through close ?).
> >
> > Therefore, my understanding is that the kernel does not
> > need to be responsible for the lifecycle of this memory. For example, if
> > the user space forgets that this registered memory has already been
> > freed, then a write from the kernel of cause could corrupt the user-space data,
> > but the kernel has no need to responsible for that.
> >
> > If you believe that this could waste memory, perhaps you should provide
> > a sparse data structure instead of a fixed memory interface.
> >
> > D. Wythe
> >
> > > On Mon, Dec 9, 2024 at 8:53 AM John Ousterhout <ouster@cs.stanford.edu> wrote:
> > > >
> > > > Thanks for the additional information; I'll put this on my list of
> > > > things to consider for performance optimization.
> > > >
> > > > -John-
> > > >
> > > >
> > > > On Sun, Dec 8, 2024 at 10:56 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 12/6/24 3:49 AM, John Ousterhout wrote:
> > > > > > On Sun, Dec 1, 2024 at 7:51 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
> > > > > >>> +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
> > > > > >>> +                 unsigned int optlen)
> > > > > >>> +{
> > > > > >>> +     struct homa_sock *hsk = homa_sk(sk);
> > > > > >>> +     struct homa_set_buf_args args;
> > > > > >>> +     int ret;
> > > > > >>> +
> > > > > >>> +     if (level != IPPROTO_HOMA || optname != SO_HOMA_SET_BUF ||
> > > > > >>> +         optlen != sizeof(struct homa_set_buf_args))
> > > > > >>> +             return -EINVAL;
> > > > > >>
> > > > > >> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can be
> > > > > >> implemented in getsockopt.
> > > > > >
> > > > > > I have changed it to HOMA_RCVBUF (and renamed struct homa_set_buf_args
> > > > > > to struct homa_rcvbuf_args). I also implemented getsockopt for
> > > > > > HOMA_RCVBUF.
> > > > > >
> > > > > >>> +
> > > > > >>> +     if (copy_from_sockptr(&args, optval, optlen))
> > > > > >>> +             return -EFAULT;
> > > > > >>> +
> > > > > >>> +     /* Do a trivial test to make sure we can at least write the first
> > > > > >>> +      * page of the region.
> > > > > >>> +      */
> > > > > >>> +     if (copy_to_user((__force void __user *)args.start, &args, sizeof(args)))
> > > > > >>> +             return -EFAULT;
> > > > > >>
> > > > > >> To share buffer between kernel and userspace, maybe you should refer to the implementation of
> > > > > >> io_pin_pbuf_ring()
> > > > > >
> > > > > > I'm not sure what you mean here. Are you suggesting that I look at the
> > > > > > code of io_pin_pbuf_ring to make sure I've done everything needed to
> > > > > > share buffers? I don't believe that Homa needs to do anything special
> > > > > > (e.g. it doesn't need to pin the user's buffers); it just saves the
> > > > > > address and makes copy_to_user calls later when needed (and these
> > > > > > calls are all done at syscall level in the context of the
> > > > > > application). Is there something I'm missing?
> > > > > >
> > > > >
> > > > > I just thought that since the received buffer is shared between kernel and user-space, if using
> > > > > vmap() to map the very memory, so that we don't need to use such "copy_to_user" to transfer the data
> > > > > from kernel to user-space, we can use memcpy() instead. This shall be more faster, but I had no
> > > > > relevant data to prove it..
> > > > >
> > > > > So I'm not going to insist on it, it ups to you.
> > > > >
> > > > > D. Wythe

