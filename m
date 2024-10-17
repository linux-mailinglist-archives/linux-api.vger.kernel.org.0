Return-Path: <linux-api+bounces-2455-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4FD9A2DEB
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2024 21:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800171F2442D
	for <lists+linux-api@lfdr.de>; Thu, 17 Oct 2024 19:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A02227B84;
	Thu, 17 Oct 2024 19:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YnFSF1YN"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBD1DED54
	for <linux-api@vger.kernel.org>; Thu, 17 Oct 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729193834; cv=none; b=n+9Q65m00G5aLalFdlIWjsPp0n978/p6K1ommvOOeTMMhx6HvgDsCpYpzYvDyGO/VlEskVYm1tDUUXSLXoDAdMOQjvg550yXydXThi583Md4mjRzaIPCYYfrfHPxkHOzVXij/VAG0RJfOmBiEeb4f1uFsD/pUKC2HabgKavKpr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729193834; c=relaxed/simple;
	bh=6L2ezWNP+KL59GOZ8iDTVIF/P5jFnKtwE3A7kCOMqW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZPosAkThdyNVhlSjiztoqmNyBEfmfoJJMjS9PNt/uxc0PpV27ThHjzqyTxYT5UiGYAH64dH0nts5TdPRGJzr9N07nHvvZv81eRE0fTe65j/W/b0bIhex4M+LjvfWOzF54zcW+xycUqXzJKQHX7Jp68tcXjSFHXq6Ek3fow62cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YnFSF1YN; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a3a309154aso5071545ab.2
        for <linux-api@vger.kernel.org>; Thu, 17 Oct 2024 12:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729193828; x=1729798628; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6kDt4PSqwqzed7xdM+ppYuwWc64+1n90tTzAqCyOu+w=;
        b=YnFSF1YNhRvaF8FL4iIGaevu7KtnoK5ntetHSNcvxqkRy7KNZaeftfj9BrbbSpTBHl
         e0iFiGzwfwIzBp0b5KYlorjB8GQ4Gu29uF8T2fvjrFe1m1NM2r5R75mDDS51FIrsBv2W
         BJj5hFEhF7we+hv/j/ogxMwjaWRleiYqZQVkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729193828; x=1729798628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6kDt4PSqwqzed7xdM+ppYuwWc64+1n90tTzAqCyOu+w=;
        b=VL5DcyoliUJMNp81T/zO5HsB1idJEscjiLAGB86QbWvznkrztycwRG75ttZIHBbQEk
         4ojXfKVDXQzNkyKp9Uc9c31GN64OvhxsbFs38f19y/GYY28GfpcjoUk4Mk1Aqld6+NVm
         Cl0MyspMnmxGivylbTgTygEiWLsn1vzFgn77weC3R5LlZIHcRcDJxSa4kWRdtXvkkM/n
         PZzepDdLhCKze1AvqDIJaCIZZQP62/LROfKD5wuzrVMM8VuMwDU+7DErj97vD0aKmVTz
         IkFe5L6YD71FZ8jZM3ic/fFRQ3W4Mk9qjyTbsimQbCrcZUKOaMGg3JLJxBb+/1Tlm8FA
         2VKg==
X-Forwarded-Encrypted: i=1; AJvYcCXwz/P+YotWaSSpic0R6l9KTlJ8XVtLIsP6I+kAnfUKGowgNeVwbIdEIRSDSRNgWskNs7vEkFmAJoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVO4QcMZ7E8vMlynCqpMTE6NUIrDfYU24XZkGRc8HZCpMpDtbF
	//TH91dxnCcXJILHpsSxqlFWzc0AS4Khd+xA5M4g6OC48gmA6yD6A39WFXG7/WY=
X-Google-Smtp-Source: AGHT+IFkoyHAtNPtcVEkmnW87sgrwm9C/4bHGNtVw7TLSwB6i4QHE4KUdS6c4sui6FUCDwQh0ZK9/g==
X-Received: by 2002:a92:b701:0:b0:3a3:dadc:12d9 with SMTP id e9e14a558f8ab-3a3dadc1780mr78958115ab.25.1729193827785;
        Thu, 17 Oct 2024 12:37:07 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3d70747besm15386025ab.11.2024.10.17.12.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 12:37:07 -0700 (PDT)
Message-ID: <a6f56949-7db2-4587-a3c7-3c583cba2fe4@linuxfoundation.org>
Date: Thu, 17 Oct 2024 13:37:06 -0600
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 John Hubbard <jhubbard@nvidia.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 pedro.falcato@gmail.com, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver Sang <oliver.sang@intel.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
 <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
 <97b6a4ea-d53a-47f1-8e64-5b9558f194c1@nvidia.com>
 <28184c3d-3c88-4f8a-a25d-7b5268b55c93@lucifer.local>
 <79f70ce6-f2ad-4fa6-90b9-6a0a936669e5@nvidia.com>
 <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <de39bf17-a75f-4151-9569-cd85c26fc19c@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/17/24 11:38, Lorenzo Stoakes wrote:
> On Thu, Oct 17, 2024 at 10:37:00AM -0700, John Hubbard wrote:
>> On 10/17/24 10:28 AM, Lorenzo Stoakes wrote:
>>> On Thu, Oct 17, 2024 at 10:17:54AM -0700, John Hubbard wrote:
>>>> On 10/17/24 5:06 AM, Lorenzo Stoakes wrote:
>> ...
>>>>> 	#ifndef __TOOLS_LINUX_PIDFD_H
>>>>> 	#define __TOOLS_LINUX_PIDFD_H
>>>>>
>>>>> 	/*
>>>>> 	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
>>>>> 	 * work around this by setting the header guard.
>>>>> 	 */
>>>>> 	#define _LINUX_FCNTL_H
>>>>> 	#include "../../../include/uapi/linux/pidfd.h"
>>>>> 	#undef _LINUX_FCNTL_H
>>>>>
>>>>> 	#endif /* __TOOLS_LINUX_PIDFD_H */
>>>>>
>>>>>
>>>>> Then the test code needs only to update the pidfd.h file to #include
>>>>> <linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
>>>>> the pidfd self tests Makefile and we should be all good.
>>>>

I like this solution. I should have read this message first before
handling the others.

>>>> Yes.
>>>>
>>>>>
>>>>> That way we always import everything in this header correctly, we directly
>>>>> document this issue, we include the header as you would in userland and we
>>>>> should cover off all the issues?
>>>>
>>>> Very nice!
>>>
>>> Thanks!
>>>
>>> I saw from your other thread the idea was to take snapshots and to run scripts
>>> to compare etc. but I suppose putting this into the known-stub directory
>>
>> Actually, I'm not running scripts, because the only time things need to
>> change is when new selftests require a new include, or when something
>> changes that selftests depend on.
>>
>>> tools/include/linux rather than tools/include/uapi/linux would avoid a conflict
>>> here.
>>
>> This is the first time I've actually looked at tools/include/linux. That
>> sounds about right, though.
>>
>>>
>>> Or would you say the wrapper should regardless be in the uapi/linux directory?
>>>
>>
>> No, not if there is already a better location, as you pointed out.
> 
> OK perfect, I have a patch series ready to go with this (and addressing
> Christian's comments).
> 
> Shuah - if you are open to this approach then we should be good to go!

I am caught up with the discussion now. I am good with this change.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

