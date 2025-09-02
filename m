Return-Path: <linux-api+bounces-4689-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C82B40BB5
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 19:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F1017F4F8
	for <lists+linux-api@lfdr.de>; Tue,  2 Sep 2025 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6124F341651;
	Tue,  2 Sep 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yCUvrmn6"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293B233EB01
	for <linux-api@vger.kernel.org>; Tue,  2 Sep 2025 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756833080; cv=none; b=MKO4aZlAJ7qio/fRS05xUIaMRhB07xZXFQ2Snbkw6twma/CiGNk/nCLTjr34kUhLpuCTn81f6jmiZshfraZ3Ojjd4Kzv33xm0Zp1xysHRledK5fpuKDiNrTtIW/h01safB0szeBWrXRIlYHwXRlVxcuPl3u4MVngRuOebDelhQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756833080; c=relaxed/simple;
	bh=0NAJe+Cuf/ZpIpM+Zt7QjuitzmB53106ZLXzJkwPQcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+svxQtV/6WYw/bIM6tZuhjtt1ue8U2os0nnzRCgoVkfn/KDaQvl/56Br1C+HjsR5Frv9bpF290T4fk2cVN1B69v61iYnAoItF16J+m7DsrHYsB0moMwcvwnhVLpNNu3+UWEouEGIFnm8MBvapwjeTpqFB08cdvYAal8zz/CgtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yCUvrmn6; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4c53892a56so4832079a12.2
        for <linux-api@vger.kernel.org>; Tue, 02 Sep 2025 10:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756833077; x=1757437877; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TC2Edz11eAYob5MGmNSLxSMee8gt8gC7TEc7ATtBRh8=;
        b=yCUvrmn6aqnjfR2DToS+o7e/eIPSuh/ilMisOKPEdEE7GjU+nF0Rr51WfvdUIfQZW5
         D7NNqTDj4VZvJ6RkkkVQTzmA/7NBMtHJUMb89ID4r6cHfifCcB0hMYsQo12MQpuD2TrY
         N1DkOtYbxPZdNYjlYZCgTbcVL9WnRCSClGVhU354jakRxHim3YwHHLeW4WfnBTI95bM/
         tjgCFExd1BOYlizA4m2gagYgCZCa9wUXumBvwTbBwgNUNKwHdNtsKlRM2t5xvHeOU0Eb
         uUfFqEEUOd2UWPKLY2JcdNxZs0yAYCl5X9xy1D4iiyO7pAeD6EYR7GxzZsxEWLCltYJH
         l3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756833077; x=1757437877;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TC2Edz11eAYob5MGmNSLxSMee8gt8gC7TEc7ATtBRh8=;
        b=UkoVj3syj1TLpz2VI3C/7Xz0wgwUflmemKY1xwX0fxAXVMdEKAmVbo3uTx7VxELFbz
         Ixp+PsYTpWgysZzxGcTfFI6aCxl9cxPvLMV82unwCSP/6/n66JPX9XdZSwTnfyn2ZlK0
         yXRDUG3bv99nit19PrsCnPNgd0DUW4qmXzFPFTyx9241GHHT7m66pAqfDxTkpCVf7NPg
         MeWx09Pp7WosXf/kspShFmEIc4RMuTcUPKoU0ALj6RQByx7NLrKWWytQE1t6qnCPzGzG
         ofNW5IjxA5M3BMmmgeuKOJnzvS2NiWoWuwiIrlMFqfOn2i4R4MT9kKokb9QUME2JTEUM
         rUeg==
X-Forwarded-Encrypted: i=1; AJvYcCXt3+U8zMjL/HX7vBH3nNRpX9tl5CxgYXRu+75wOCvd4ooG7bghXAEF4SC/dF8r4QzwxLwPA9YhRa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywsbArlcth05ChLypAZdBCtj1Cxzo7ti8ntl1b6Sr40aqOhek7
	tnta4gtBTZiTx+jACwFC8b8yLGk5wHaVzZCLhnzWTpuH6saSxV3MqP9+U2Rp5It0RfGGFtrDcVT
	TLy7I
X-Gm-Gg: ASbGnctdlGIrnsgRGTfioIzl1jkWBI61hBY19JxnHNE6KPC7Da2ZT7NjMuKU6a3Z1GQ
	p0i+2Zv3eHhztbpm0eOH2F7NNV2F0lcYS0a8r03F3YZJhonS6miShYI8TeR4AvObUovfOa0ECWY
	GI9Z0YqH9MrqKAvJBFr84MbitKVFv44xvw3wFc2tZye4RpiGRx60WxJLx9s6yH1cdWwbHBd2bMG
	mVJZVPynKior9vf7Jg+VfZyteAuCWB6Ze3YqjHUWpXUKhZHYAuxpCnUmLnqGb9zxhsVMzYCjBd7
	nqK7FDGZ51kSVrEB3PNRqXDQypt9qemmwb1O6cDliP5vhjgzb6xKV/TkChi9xEjTed7X9nAsKGx
	oRXesap/OktmPt0V+dNBRJhYFc65k4vKVTUtEKZ4LhwFDxCIAXXHpMqXlFyVQ/GcVcXJ2fGFUBe
	b28LdPQ6zgDQkqoMf4d7d5wrL7opIBi7oJeNG7VbpgjO0=
X-Google-Smtp-Source: AGHT+IECiY4YVZAqwaxOff8lFI7V2ZdpLVLzbdje+OgdQtXO6RsKZavewAJp+5ymITOpxAwA0RjB5A==
X-Received: by 2002:a17:903:32c6:b0:248:8626:8e38 with SMTP id d9443c01a7336-249448d72cfmr159498335ad.17.1756833077297;
        Tue, 02 Sep 2025 10:11:17 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:b25:7c5a:61ad:cddf:915b? ([2804:1b3:a7c1:b25:7c5a:61ad:cddf:915b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065a3b67sm137792415ad.120.2025.09.02.10.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 10:11:16 -0700 (PDT)
Message-ID: <2a979a5e-a78d-4ee1-ac96-7176a8c45fb4@linaro.org>
Date: Tue, 2 Sep 2025 14:11:14 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Paul Eggert <eggert@cs.ucla.edu>, Arjun Shankar <arjun@redhat.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, libc-alpha@sourceware.org,
 linux-api@vger.kernel.org
References: <2c5ae756-c624-4855-9afb-7b8e8ce91011@linaro.org>
 <828f6dfb-7402-45e1-a9ed-9e17b6356c5c@linaro.org>
 <2025-08-25.1756160579-pudgy-swank-chard-regalia-j3jdtD@cyphar.com>
 <5c3b9baf-76b4-40d7-87fb-9b8dd5afd1ee@cs.ucla.edu>
 <2025-08-26.1756212515-wealthy-molten-melody-nobody-a5HmWg@cyphar.com>
 <6432a34d-fba9-414e-ad38-d3354fa0d775@cs.ucla.edu>
 <2025-08-27.1756273344-decaf-ominous-thrift-twinge-h1gGBI@cyphar.com>
 <5c9fa556-da00-4b76-8a70-8e2d1dddd92d@cs.ucla.edu>
 <2025-08-27-perky-glossy-dam-spindle-kPpnnk@cyphar.com>
 <5cbd7011-9c2a-4a23-bbce-84c100877cdb@cs.ucla.edu>
 <2025-08-28-foreign-swampy-comments-arbor-nOkpXI@cyphar.com>
 <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu>
 <CAG_osaYc21nR0M3O6UKs8zna6x_k9U4=Rt4B0mKHog=ZLSH1AQ@mail.gmail.com>
 <d88d7228-fabe-41d1-9a09-298fcb313647@cs.ucla.edu>
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <d88d7228-fabe-41d1-9a09-298fcb313647@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 02/09/25 13:34, Paul Eggert wrote:
> On 2025-09-01 19:41, Arjun Shankar wrote:
>> While it is true that openat cannot be extended in this way, for
>> openat2 (whether or not it eventually materializes in Linux) there
>> already is the RFC patch series proposing CHECK_FIELDS that Aleksa
>> referred to earlier.
> 
> Is this the RFC Aleksa proposed last October <https://lkml.org/lkml/2024/10/10/25>? If so, I don't exactly see a rousing endorsement there.
> 
> If not, where is the later RFC? I'd like to send the critical comments I've already sent on this thread. These comments have not been responded to adequately.
> 
> 
>> Unless the kernel marks open_how as const
> 
> ? The kernel doesn't mark anything as const. It merely copies in or copies out. And for openat2, it copies only one way.

I think in this case we can refer to the SYSCALL_DEFINE4 at the kernel
source kernel, since there is no explicit contract w.r.t to argument 
point-to-const in the kernel header. But I am not sure which is the 
Linux policy for changing the implementation, or if Linus or other
maintainer will chime in if someone tries to do it.


> 
> 
>> future if the kernel starts modifying open_how, glibc's openat2
>> wrapper will no longer align with the kernel's behavior. At that
>> point, glibc will either need to discard the const (which will cause
>> any existing users of the wrapper to fail to recompile),
> 
> There are multiple easy ways out there. For example, glibc could document the argument as being pointer-to-const now, but warn that this may change to unrestricted pointer later, if the misguided change is made to the kernel. This would be similar to the already-existing warning in the proposed glibc patch, which warns that you can't assume sizeof (struct open_how) is a constant and so you can't expose it in library APIs. Of course people can ignore the documentation warnings but that's on them.

Yes, we could proper document it but changing it later is always troublesome
and may force users to start to resort to hacks like bypassing the libc with
assemble hacks, and/or redefine the function prototype, or just using syscall()
instead (all far from ideal) to support multiple glibc version.

So I would *really* like to avoid going forward with this path.

> 
> Better, though, would be to keep the API pointer-to-const. That's much cleaner. We can extend it later for a "give me the supported flags" flag, wwithout changing it the API away from pointer-to-const.
> 
>> Earlier on in this thread, Aleksa mentioned sched_setattr as
>> establishing precedent for the kernel modifying non-const objects. It
>> looks like glibc actually does provide a sched_setattr wrapper since
>> 2.41.
> 
> Although it may be too late to change that misfeature, it's not too late to change this one. And even if it was a good idea for sched_setattr, that doesn't mean it's a good a good idea for openat2.
> 

The main problem I see is if we set for point-to-const, the kernel eventually
adds some API that changes the input, and the users will start to deploy the
aforementioned hacks to overcome possible issues using the glibc interface.

So I think if kernel developers are planing to make the argument in/out I think
glibc should just follow the kernel.

