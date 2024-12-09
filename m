Return-Path: <linux-api+bounces-2846-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC739E8BBC
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 07:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999501884451
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 06:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CE214815;
	Mon,  9 Dec 2024 06:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vJCmLBcb"
X-Original-To: linux-api@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723321D555;
	Mon,  9 Dec 2024 06:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727413; cv=none; b=aKlugxmCJ9FRtZAywHDNbx7oPrHraQhlvvy2cX3N1lukO91Yd+0y2inn4xkG1R+mrSLVGlqo1SYUYDv6sKEilFtV7Lr2ZunjkWObkYIyWQjXYVsA+ovGbd7pVD+WO0BvQK8780guYuaOVJYov7kPmtn9XC3G/Tx8Re0zkktNELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727413; c=relaxed/simple;
	bh=AnIU9Rsjcmz+m80BnS9WbGUMEIU+u43Qujmt520qf0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ymls17rGsWlUDwOt7E8lmPF7qC8nib4TC8B8O6KpX/lHyz3EFlH+SgthfMlR791M5VM7i9etGpHwtNBJecN/9hJJheLIEvLRmcJYddYq3zZH+K/hmbBwMvqxPdtG8UYgjidbhXstpxR3qhRnLYDsHrRE/+vVMqdYZeQ+JXwMPtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vJCmLBcb; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733727405; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OgASrKaj2u0hgQK/gz+96q+yy79DHQpGBBwGq4bWWP8=;
	b=vJCmLBcbkveUguxZT9cznVKzMUMYpksNrpgd6k5D284KpD04zUznrFu8wfD74TPTkv/M7RLLPknraqn83ZnoA9FpxSnu1qP0RjVR1dTe/48OG2pB42DQWkdaL5IANV8ABSIWurbDPLLClIKS/wEfAetDw3VcmPqEhtumWadDatU=
Received: from 30.221.147.207(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WL3ST9v_1733727403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 14:56:44 +0800
Message-ID: <b4bf68f1-189c-4685-8e1a-d8cbf60c1120@linux.alibaba.com>
Date: Mon, 9 Dec 2024 14:56:43 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
 <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAGXJAmw4tULA02TLXBPa8Lv5cXD1Oe+1ajTWrM2x9=byMTy4jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/6/24 3:49 AM, John Ousterhout wrote:
> On Sun, Dec 1, 2024 at 7:51 PM D. Wythe <alibuda@linux.alibaba.com> wrote:
>>> +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
>>> +                 unsigned int optlen)
>>> +{
>>> +     struct homa_sock *hsk = homa_sk(sk);
>>> +     struct homa_set_buf_args args;
>>> +     int ret;
>>> +
>>> +     if (level != IPPROTO_HOMA || optname != SO_HOMA_SET_BUF ||
>>> +         optlen != sizeof(struct homa_set_buf_args))
>>> +             return -EINVAL;
>>
>> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can be
>> implemented in getsockopt.
> 
> I have changed it to HOMA_RCVBUF (and renamed struct homa_set_buf_args
> to struct homa_rcvbuf_args). I also implemented getsockopt for
> HOMA_RCVBUF.
> 
>>> +
>>> +     if (copy_from_sockptr(&args, optval, optlen))
>>> +             return -EFAULT;
>>> +
>>> +     /* Do a trivial test to make sure we can at least write the first
>>> +      * page of the region.
>>> +      */
>>> +     if (copy_to_user((__force void __user *)args.start, &args, sizeof(args)))
>>> +             return -EFAULT;
>>
>> To share buffer between kernel and userspace, maybe you should refer to the implementation of
>> io_pin_pbuf_ring()
> 
> I'm not sure what you mean here. Are you suggesting that I look at the
> code of io_pin_pbuf_ring to make sure I've done everything needed to
> share buffers? I don't believe that Homa needs to do anything special
> (e.g. it doesn't need to pin the user's buffers); it just saves the
> address and makes copy_to_user calls later when needed (and these
> calls are all done at syscall level in the context of the
> application). Is there something I'm missing?
> 

I just thought that since the received buffer is shared between kernel and user-space, if using 
vmap() to map the very memory, so that we don't need to use such "copy_to_user" to transfer the data 
from kernel to user-space, we can use memcpy() instead. This shall be more faster, but I had no 
relevant data to prove it..

So I'm not going to insist on it, it ups to you.

D. Wythe

