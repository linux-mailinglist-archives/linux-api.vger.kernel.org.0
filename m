Return-Path: <linux-api+bounces-2561-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5F09AF305
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 21:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F64D281477
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2024 19:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171219B3FF;
	Thu, 24 Oct 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kc2T1nGB"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053017333D;
	Thu, 24 Oct 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799725; cv=none; b=GekGZ8OmnSCEpzHE15iYvRefefiMndtWFhYQAkFZFeZOtUUykdtKVYQgPE5leTUD3ZdEo+CcG9t00Gbx+f9nXHQVKo4jtWS/tHHHjyQSYNfguetNDANVdtpoyPbPhZJOi+17ri4BiG7qlZUy93WGZz/OD0uwBBvhyMAFlVpgsOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799725; c=relaxed/simple;
	bh=+DMNl5qULG9FzRvzLgVcNxfhnGStCnO2VwdaRMuh1fY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pK+/mJM52k+0274oxuVDPI9V5MP3+hfRBhcjfftRd93yjmFCRdkHsDaIo5t5bsq34mqS5jFM725YFeuwGt9NsAD61EAoUXHzLeqdwc9J8y5J5ID2AlJ+AQ466tLg7h6e3HmfktL0LYpdW6YtKk+dPFwX7QB2XVabLaoken+OUo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kc2T1nGB; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZHYWgrJ/utlUa68DupieJ4xEvMacDX1gfqRqVZ7XE6M=; b=kc2T1nGB47lYWskaB51rcPaXbe
	hkUzwzP6MFpiLhqLuJwZ18qiMRuJJvhV7WuYUN94RpK6KzFO0Mq2c4lmLXDbtzD/JwdgpPKCRvHvh
	aOlvXwRQVVLziz7zN554S69Pif2Y1q7cGqgv+UiInw+71YWrBLfxBvh5dCbjdXOQVlkIBd1JniiKK
	Om35rxAfnQV9i2cEjuoxHC8qhm4QfXQhlqJV6mwKte2xnpXMS95OEERU5medVK6UiyV4+aHqHdrcc
	1ENu7F88dUVSsKN1BQGP/EPZyyJVFb1WUzjzZwZ5+WOULFhtQLDUpJAzsU8XOBOKtfXpUQ4jlMUi+
	FpvHXwqA==;
Received: from [177.172.124.83] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t43vJ-00EdfN-1Q; Thu, 24 Oct 2024 21:55:09 +0200
Message-ID: <59509fc9-1a19-4162-ac89-559e08b75c06@igalia.com>
Date: Thu, 24 Oct 2024 16:55:03 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/1] futex: Create set_robust_list2
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Darren Hart <dvhart@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, sonicadvance1@gmail.com,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 linux-api@vger.kernel.org
References: <20241024145735.162090-1-andrealmeid@igalia.com>
 <20241024145735.162090-2-andrealmeid@igalia.com>
 <bde852ec-8e2f-4957-9368-00d8e5a422c4@app.fastmail.com>
 <1e62e083-f97c-4157-8d50-c3655edda97b@igalia.com>
Content-Language: en-US
In-Reply-To: <1e62e083-f97c-4157-8d50-c3655edda97b@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 24/10/2024 15:03, André Almeida escreveu:
> Hi Arnd,
> 
> Em 24/10/2024 12:57, Arnd Bergmann escreveu:
>> On Thu, Oct 24, 2024, at 14:57, André Almeida wrote:
>>> This new syscall allows to set multiple list to the same process. There
>>> are two list types: 32 and 64 bit lists.
>>>

[...]

>>> +    if (unlikely(!list_empty(list2))) {
>>> +        list_for_each_entry_safe(curr, n, list2, list) {
>>> +            if (curr->head != NULL) {
>>> +                if (curr->list_type == ROBUST_LIST_64BIT)
>>> +                    exit_robust_list(tsk, curr->head);
>>> +                else if (curr->list_type == ROBUST_LIST_32BIT)
>>> +                    compat_exit_robust_list(tsk, curr->head);
>>> +                curr->head = NULL;
>>> +            }
>>
>> This looks like the behavior of a 32-bit task using
>> ROBUST_LIST_64BIT is different on native 32-bit kernels
>> compared to running on compat mode.
>>
>> Assuming we want them to behave the same way, did you intend
>> ROBUST_LIST_64BIT to refer to 64-bit pointers on 32-bit
>> tasks, or should they use normal word-size pointers?
> 
> Oh right, I haven't covered that indeed. I think I would need to have 
> something like:
> 
> static void exit_robust_list_64()
> static void exit_robust_list_32()
> 
> And then each function would use explicit sizes for pointers. Also, I 
> would rewrite the conditions to make that every combination of 64/32bit 
> kernel/app calls the appropriated function.

Something like this:

#ifdef CONFIG_64BIT
	if (unlikely(tsk->robust_list)) {
		exit_robust_list_64bit(tsk, tsk->robust_list);
		tsk->robust_list = NULL;
	}
#else
	if (unlikely(tsk->robust_list)) {
		exit_robust_list_32bit(tsk, tsk->robust_list);
		tsk->robust_list = NULL;
	}
#endif

#ifdef CONFIG_COMPAT
	if (unlikely(tsk->compat_robust_list)) {
		exit_robust_32bit(tsk, tsk->compat_robust_list);
		tsk->compat_robust_list = NULL;
	}
#endif

	/* Simplified */
	list_for_each_entry_safe(curr, n, list2, list) {
		if (curr->list_type == ROBUST_LIST_64BIT)
			exit_robust_list_64bit(tsk, curr->head);
		else if (curr->list_type == ROBUST_LIST_32BIT)
			exit_robust_list_32bit(tsk, curr->head);
	}


