Return-Path: <linux-api+bounces-4645-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D86CB3A74E
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 19:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D51160AF6
	for <lists+linux-api@lfdr.de>; Thu, 28 Aug 2025 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978822A7F9;
	Thu, 28 Aug 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wr3PV8mU"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6E32C332
	for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756400770; cv=none; b=jlnoqSMFx38gPSaM1c0StsM62pn4/1On5tkSeMq01qXYeJhok6UwNvC5KWtZgC2eIsZ/K9WETvrkZFYGZ/Xylpe9B8O2MgLsCPQkr6mt/Mk4Nc6lRnbrLOzf3nwk5pMtYLT/Yhk5hbw2TM5hxrr4ErwaxokQw6MxqLhICwjTH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756400770; c=relaxed/simple;
	bh=WSbnWXW0HBDbb1NPrMmmiy6JZ7oeCU17lyhKwiUumMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVCQslf/Vgs8En0zpdzA4COcMCUIET9H/G7EprM23HRJtpq5mvOhnnViVSJ9nTSaLXIrfrtFvb92bPx/16vNEZxMZavo1zpKrsANsHWBUM7o7ke2fSmMCZ5SD7QrubWka1Pk+1kOtasmD8MM37XaMvo0+0noAqWilOsVrDVLxas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wr3PV8mU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49d6f8f347so1096897a12.0
        for <linux-api@vger.kernel.org>; Thu, 28 Aug 2025 10:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756400768; x=1757005568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=e84z4/Ij6jNaOkkwc2uumR+iYRASeG3uUzpNNYapRqo=;
        b=wr3PV8mUU7FTv8v4WNwclCe13iyd8efWgq4b/dhy/bPIKb8GFuaaX1jkt7GFvVDP+D
         +sD0B7IHgYXA+/qPiiSgHuUSZiTRR0biMVJjCuFuRvaxWXm9RcXoDeC/wnRf1T8BM0ap
         i1xPL7kie8gCFmPbzrOdZtGlsi5EkKCXOmHhDHpV+06DoT9OP+Kb/1xKIpghREI8Umrv
         zgZEPpbpf1Ha0QjesCKKU74hFkPbAboFfhfCNdwmG1OORc8Wx29LxQeUnrchmgJQ464R
         4dBjxlu/zfE9O9jhBcy8oORL/tI0vihclu2JB/2mRl6riB+XzHgrShJv4XJToA8Tmc4H
         moHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756400768; x=1757005568;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e84z4/Ij6jNaOkkwc2uumR+iYRASeG3uUzpNNYapRqo=;
        b=rUxN89e/1rJiqtk7WsSgHfhqY+gpBC+VmuWj8dTY39NadD8MTuGc4xB6B31pj9pFeD
         rvvjZv0bWy8mpPFcGEDYqyXGg1E2JVCzEOfG8QifVgokIiZkxS2bLlhhSt9qZuGdjLKY
         SI6cqInJwbhQHJeQULWAy1hjgf/pz6cY0TGZ/4NV2eiD/VsPOemaAP6HzhTBm+7PuBuv
         Npo3wFmC/5+j5aKAWw7GC4VFFd9vwRYrkOxrycOmgv+OO0pZrUB0p62+nDbnaXK/duv3
         lNBJXMv5rV5KjLm1F/YOllJijPSE4R+neY0qmlXrB6AquBR1KOV6jVbdz+e7PIp5j/l5
         8R2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhsmzv+/RizWn6YliwCOkBbHWR7THL0g/NdGs37JEv4bPHKuSBycBR1X5vwHikIF1b65t4yBa1uxg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5GQViydaNigmU2E9qR99xyBNNfUD0OyDtBA0X6LDvfvhc/TX
	UjQornWGO+MKYU12QpyYjShuynlV1bRC4ArC1ft+TiKswDJ+lWhWQZbJyHIZgYWX9kwS2MZWTn/
	wdgws
X-Gm-Gg: ASbGncvth79vK2cYAiyQAZhbGp9HJi5Yfh9PFNlOfHGILc/bKa676izijo7NkUQ3bSg
	fU+O94KJiBzGEFPY9cpdiz4YMjo7P5O2xDAvBCMosUXE82/n/mYCBviEiuwwap4vdY17NIY7eyo
	LFn5vJ8oZkuZSG0keLFZTP1NpLK03lnOTmolLRSsRDgB5DXhC96mSjTJyp0IjwZUHSTFvR0wm2d
	VEYeDNEdplb8LmMctRlTxz+K3Z1OCQ5BPyKkxIJ1ynJPdRUWfExYXTyNCcKJ4V2CCotzDAkJxR1
	Bl+5QtZN7aUaxkw/VL7EmodhTjYmbzrPbv44NtkiLSJ5hWS3G9C3Hdvc7X+30y07pLKvR9KkqyR
	CmzMccAKDrD2tLFH64MgEhshevWkk8I9Y/gUiSsyBUGjkB9xb2yfOml0AudgtablEYx0TmVQPBL
	5xWi1N7apzvNg5r2m03JIXpy7ntlAy5tot
X-Google-Smtp-Source: AGHT+IHWHNcLF+YuQ2+NrMXxHcqfIAz3X42xFA9u33AjZJEEiwck6IAPuGezj3D37yLt3CxvWPThSw==
X-Received: by 2002:a17:902:ce81:b0:246:de5e:cecd with SMTP id d9443c01a7336-246de5ed9a6mr200827655ad.54.1756400767713;
        Thu, 28 Aug 2025 10:06:07 -0700 (PDT)
Received: from ?IPV6:2804:1b3:a7c1:b25:ac59:50e1:2bd3:8e7c? ([2804:1b3:a7c1:b25:ac59:50e1:2bd3:8e7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249067db6basm452965ad.148.2025.08.28.10.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 10:06:07 -0700 (PDT)
Message-ID: <09fe6b8b-7bfd-4dca-97d7-8bf438356f47@linaro.org>
Date: Thu, 28 Aug 2025 14:06:04 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] linux: Add openat2 (BZ 31664)
To: Paul Eggert <eggert@cs.ucla.edu>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Arjun Shankar <arjun@redhat.com>, libc-alpha@sourceware.org,
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
Content-Language: en-US
From: Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>
Organization: Linaro
In-Reply-To: <cbbc9639-0443-4bf8-bbd1-9d3fdcb2fd37@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 28/08/25 10:43, Paul Eggert wrote:
> On 2025-08-28 01:42, Aleksa Sarai wrote:
>>> I still fail to understand how a hypothetical "give me the supported flags"
>>> openat2 flag would be useful enough to justify complicating the openat2 API
>>> today.
>> My only concern is that it would break recompiles if/when we change it
>> back.
> 
> OK, but from what I can see there's no identified possibility that openat2 will modify the objects its arguments point to, just as there's no identified possibility that plain openat will do so (in a hypothetical extension to remove unnecessary slashes from its filename argument, say).
> 
> In that case it's pretty clear that glibc should mark the open_how argument as pointer-to-const, just as glibc already marks the filename argument.

I am still not sure how a potentially CHECK_FIELDS feature would play with 
openat2 in the future, especially since glibc now prefers to first include 
the kernel headers before redefining a minimal API to the syscall usage 
(meaning that programs will have access to potentially new flags depending 
on the installed kernel header).

If the kernel intends to modify the open_how in the future, setting open_how 
as const will only add extra confusion. Users might be exposed to this feature 
without explicitly including the kernel headers.

Another option might to *not* include the kernel headers and keep syncing the 
kernel definitions on kernel releases (and maybe excluding flags that might 
modify the open_how). As Florian has said, this kind of mediation by glibc was 
historically time-consuming, complex, and subject to subtle bugs (and that's 
why we abandoned this over time).

