Return-Path: <linux-api+bounces-2845-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAD29E8BA9
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 07:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A311885E5B
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2024 06:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA7D1C2335;
	Mon,  9 Dec 2024 06:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iFsekXNy"
X-Original-To: linux-api@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4247C1D555;
	Mon,  9 Dec 2024 06:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726761; cv=none; b=ADKX/8piJ1PShpNa/hptk9xy3p0cisNxRggJ9kGyzDarVZNqwDArM5tfa5Eg7Ae58N/7EJxwtNfFjyIqTGtBZlC/zI2d1zbioS7mZU5dBtQfgMfjtBfh8cAs0K1QajhThLEAixmIVH9bLw8HGX9dWz0LSvanslUh1Xq7opyppnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726761; c=relaxed/simple;
	bh=2Zgh82YInRNujXxJx28SoaNq1VdkgRl13UEd3cPF0U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egOUeT1hoJo88n+ibFsRHNbdKxjEv2dHYwf696nYwO3i36B1kAM8bPP6dvislmfbmR+rLmsj2LYCYQLKGJUOCeLf3SaCkwJzVoEzwSGdVTlofnRqrr6YUpQz6HIj7KzgTREvzX/vn/AlPQgn63kyUoF8I8Jufil/A64rAzK00GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iFsekXNy; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1733726754; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lEzZ52adzbYunRpL2ygJuu56f6yoRpwpu4wwmXv/eWw=;
	b=iFsekXNy2U4sxNpNVBnkemqmOJ4kB8PteF9k+qpH9b8rGNCOH/CpukK4mplpz//zWIRHafHuvZ42n8YpGr+fffj5YfFafsyqAf4TUoAxYKBFFRC6lkiIfduEiqGsSZZtljzEJaxLN1uJt3CktirKtSqFaW3qZpBOY+g/MK5OuOk=
Received: from 30.39.184.169(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WL3xrGL_1733726752 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Dec 2024 14:45:53 +0800
Message-ID: <a0358f1e-a63c-4059-adc8-d2f338710e36@linux.alibaba.com>
Date: Mon, 9 Dec 2024 14:45:52 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/12] net: homa: create homa_plumbing.c
 homa_utils.c
To: Andrew Lunn <andrew@lunn.ch>
Cc: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-12-ouster@cs.stanford.edu>
 <f79a70fd-35a4-4d0d-b239-daa4ab652880@linux.alibaba.com>
 <fd5cf76f-48c3-4d73-9609-c13ccb622382@lunn.ch>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <fd5cf76f-48c3-4d73-9609-c13ccb622382@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/3/24 9:51 AM, Andrew Lunn wrote:
> On Mon, Dec 02, 2024 at 11:51:48AM +0800, D. Wythe wrote:
>>> +/**
>>> + * homa_setsockopt() - Implements the getsockopt system call for Homa sockets.
>>> + * @sk:      Socket on which the system call was invoked.
>>> + * @level:   Level at which the operation should be handled; will always
>>> + *           be IPPROTO_HOMA.
>>> + * @optname: Identifies a particular setsockopt operation.
>>> + * @optval:  Address in user space of information about the option.
>>> + * @optlen:  Number of bytes of data at @optval.
>>> + * Return:   0 on success, otherwise a negative errno.
>>> + */
>>> +int homa_setsockopt(struct sock *sk, int level, int optname, sockptr_t optval,
>>> +		    unsigned int optlen)
>>> +{
>>> +	struct homa_sock *hsk = homa_sk(sk);
>>> +	struct homa_set_buf_args args;
>>> +	int ret;
>>> +
>>> +	if (level != IPPROTO_HOMA || optname != SO_HOMA_SET_BUF ||
>>> +	    optlen != sizeof(struct homa_set_buf_args))
>>> +		return -EINVAL;
>>
>> SO_HOMA_SET_BUF is a bit odd here, maybe HOMA_RCVBUF ? which also can be
>> implemented in getsockopt.
> 
> Please trim the text when replying to just the needed context. With
> pages and pages of useless quoted text it is easy to overlook your
> comments.
> 
> 	Andrew

Got it. Thanks for advice.

D. Wythe

