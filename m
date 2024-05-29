Return-Path: <linux-api+bounces-1648-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6B48D2E39
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2024 09:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A07BD289A6F
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2024 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F5616728A;
	Wed, 29 May 2024 07:29:28 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64569167264;
	Wed, 29 May 2024 07:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967768; cv=none; b=uBbLEJ9e9rlvCIWJvj64bXsfcF7NhTFyG8iSfuxftH+WXT2S0fCdtH57xnzPEOVRYvXUOGoLD7R8SwextWqyXy4BxnUSd/Seq0DrY7mGh7/YqMd2Vnl6Bt2jTtQ+OQvYrRFbhBeuOGUOszjJTqfVDAL2B3DInU1+D1s5BFtCSQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967768; c=relaxed/simple;
	bh=WIOCUhK39/UAXtMryFTKAaKRKRwz2on5iHGlR4EA8/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iMlixfoCk1HtDKpt/Rhqr0gwgsMU+wO9FEy3bNTROIzy0tXnzq0Yg1Q2zqlHGP6E18SlfF+Xmj3Fess991tzr/M1Htccy+usKj5+0kHfqpnCIlfHBRXJQUscjxfl18v4G7MFEPNrHUVxQy0nmwa6hbRxUuJwhLjl/tVLkMGNJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a1eff78so22902231fa.0;
        Wed, 29 May 2024 00:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716967766; x=1717572566;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LVtxrKov8/0ih2xFiV/RAkMoecZBEr2njLAHNHI7QE=;
        b=vxeJPtLY6yfgociQ9PHZXizI4L0WJH/DqW97nrBaYOU6RSO6Ai+jjQQCRQiwxZtIYE
         sLgRiLwGTPzYM9VVwasMIr5apNPicuYgQ2DzlH2EMcZAb4oOTk0IeHXVGgJzt2/TcpCa
         ZDRgSEO/Yy/p5VCXskk/I58HJybIgVp8CdqEXGVRyK5uSu31p2OcYuoCUl4wJ/LpEEo+
         WrSWLKgRrZUrM5PBYCTFS7yNOLOIUNf+SRrQvt9wN4MXT5jjYbCG3bUifmyrwz2i+Yqx
         WY4FsVqRjm8TRDdpXNdo0Slv107COU1YauGnxlipoFVJvhynrjLyZc25cwNuHaN2K7mP
         tkGA==
X-Forwarded-Encrypted: i=1; AJvYcCWxmBNXfJDRlmXc2wWtoNT8yeVdCz36cPY/JeQ/8H2JAwc3s1KFwoPUv2fVWVGc2tsmf3iEjuLcaAAWV+b6m0tCi6QMBsWiO1mgSY2iFuHYUu/sqBsNKuDOX/1RgNMyjo0boS0Nng6CrTfgpHn3nZDcl0WSoNraUXs94m7Op5y/2tY0UG0=
X-Gm-Message-State: AOJu0Yz1MJELLhdAKP6mHZeQJhkOcjTXnrNnts5YZ2rfDzkTqQbc2sOL
	P+IAY41SNfdMWOE3uYyOWTXQQePRuGEkB6F3Ub0VOFj7ZzwvnPVLFQW2vg==
X-Google-Smtp-Source: AGHT+IEnwTOHIp3cj7rUeadinrjoeSKjgMV0rKAoChzp5xrhtA1d7uEfCNsHcai1emwQGYQJZYpdrg==
X-Received: by 2002:a2e:954e:0:b0:2e9:77ec:58eb with SMTP id 38308e7fff4ca-2e977ec599amr68239081fa.17.1716967765321;
        Wed, 29 May 2024 00:29:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae976sm169446685e9.38.2024.05.29.00.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 00:29:24 -0700 (PDT)
Message-ID: <0da9785e-ba44-4718-9d08-4e96c1ba7ab2@kernel.org>
Date: Wed, 29 May 2024 09:29:23 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] VT: Use macros to define ioctls
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexey Gladkov <legion@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 Arnd Bergmann <arnd@kernel.org>
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <e4229fe2933a003341e338b558ab1ea8b63a51f6.1713375378.git.legion@kernel.org>
 <2024041836-most-ablaze-f417@gregkh>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <2024041836-most-ablaze-f417@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18. 04. 24, 8:18, Greg Kroah-Hartman wrote:
> On Wed, Apr 17, 2024 at 07:37:35PM +0200, Alexey Gladkov wrote:
>> All other headers use _IOC() macros to describe ioctls for a long time
>> now. This header is stuck in the last century.
>>
>> Simply use the _IO() macro. No other changes.
>>
>> Signed-off-by: Alexey Gladkov <legion@kernel.org>
>> ---
>>   include/uapi/linux/kd.h | 96 +++++++++++++++++++++--------------------
>>   1 file changed, 49 insertions(+), 47 deletions(-)
> 
> This is a nice cleanup, thanks for doing it, I'll just take this one
> change now if you don't object.

Unfortunately, _IOC_NONE is 1 on some archs as noted by Arnd, and this 
commit changed the kd ioctl values in there which broke stuff as noted 
by Al.

We either:
* use _IOC(0, X, Y) in here, instead of _IO(X, Y), or
* define KDIOC(X) as _IOC(0, KD_IOCTL_BASE, X), or
* revert the commit which landed to -rc1 already.

thanks,
-- 
js


