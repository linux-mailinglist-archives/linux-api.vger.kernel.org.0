Return-Path: <linux-api+bounces-3725-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9685CAAF5AB
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 10:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B95E3A1FC6
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 08:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954A0229B27;
	Thu,  8 May 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="VWXbskEa"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2D9211A00;
	Thu,  8 May 2025 08:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692949; cv=none; b=mJ6lK2KZO9dwc5GUJo3qQYNIkA0Z+Mir8r7nj/IPjn7GQNsJlymLFXkbeeRJXaLEyjn7CbfgTSUTFrpdxPPR0EZktI+0wTFR4ZO5nfWi2yfarExSWZaKJ7BdborGwhIpez3WqS80c0FxnuP4/3412znIzehPgQ6mZxIk5RdvT8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692949; c=relaxed/simple;
	bh=CnVgTZ1UWFqStpjsVhnGhCEa95pvZ6Tf/34ZQ4x8thY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g8L+7AKHh9DV16b8za7VIx048V7ZM8wZkkHyQMDJLZRxrtSoNAzmZXaC+MraZk0Q0z6bDGZf0BKvfRREW7ud71YO8Ga1gtdx1W8bQf3nZpHzTw/aYXCglHult9LNjJsuUoXRRE1bPj154IJ7MDDejLj9Q/weK7ZGz54SYMUuP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=VWXbskEa; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [10.101.3.5] (unknown [213.157.19.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D27DB3FB95;
	Thu,  8 May 2025 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746692944;
	bh=XH6y8mEZBmq1o1/i4oq6k0EFSwlQLCoZgzRUJn0bYTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=VWXbskEaMUU1lOtE23N0HYO48Z06BA7n7d1GhyKORBKUVGtn+m6zGkKh6We5k9OhR
	 08iJOvUwiwiq4a3YZsdCx87gcXgPYwayGCf1VvPgP/QtgbTzMui5U51KfKBSJAVM3y
	 wgfqg63pGUPSvH3Qehisb9aUfruaLveArl9G85pNbZ5shrs23utIkwbd1JnKDTbI8Z
	 J4AMHgvVKA33Ae5OQGPMVHOU2Yff+rMHk5LxYO1uUn7ieQUDsNrIPeYJ6+ooJQwDpw
	 uYjt4RWkcDmxwVzY6Hcd6Jdc1D+aNLCpEEjBL3MDrYWBS1MEK/1k4yWQ+Lmf7z6x6r
	 Pkps6xwnEM86g==
Message-ID: <120954c2-87b7-4bda-958b-2b4f0180a736@canonical.com>
Date: Thu, 8 May 2025 01:29:02 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: Paul Moore <paul@paul-moore.com>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com,
 mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
 casey@schaufler-ca.com, takedakn@nttdata.co.jp, linux-api@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
 <CAHC9VhRKwB4quqBtYQyxRqCX2C6fCgTbyAP3Ov+NdQ06t1aFdA@mail.gmail.com>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <CAHC9VhRKwB4quqBtYQyxRqCX2C6fCgTbyAP3Ov+NdQ06t1aFdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/7/25 13:25, Paul Moore wrote:
> On Wed, May 7, 2025 at 6:41 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>> On 2025/05/06 23:32, Maxime Bélair wrote:
>>> diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
>>> index dcaad8818679..b39e6635a7d5 100644
>>> --- a/security/lsm_syscalls.c
>>> +++ b/security/lsm_syscalls.c
>>> @@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids, u32 __user *, size,
>>>   SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void __user *, buf, u32
>>>                __user *, size, u32, flags)
>>>   {
>>> -     return 0;
>>> +     size_t usize;
>>> +
>>> +     if (get_user(usize, size))
>>> +             return -EFAULT;
>>> +
>>> +     return security_lsm_manage_policy(lsm_id, op, buf, usize, flags);
>>>   }
>>
>> syzbot will report user-controlled unbounded huge size memory allocation attempt. ;-)
>>
>> This interface might be fine for AppArmor, but TOMOYO won't use this interface because
>> TOMOYO's policy is line-oriented ASCII text data where the destination is switched via
>> pseudo‑filesystem's filename ...
> 
> While Tetsuo's comment is limited to TOMOYO, I believe the argument
> applies to a number of other LSMs as well.  The reality is that there
> is no one policy ideal shared across LSMs and that complicates things
> like the lsm_manage_policy() proposal.  I'm intentionally saying
> "complicates" and not "prevents" because I don't want to flat out
> reject something like this, but I think there needs to be a larger
> discussion among the different LSM groups about what such an API
> should look like.  We may not need to get every LSM to support this
> new API, but we need to get something that would work for a
> significant majority and would be general/extensible enough that we
> would expect it to work with the majority of future LSMs (as much as
> we can predict the future anyway).
> 

yep, I look at this is just a starting point for discussion. There
isn't going to be any discussion without some code, so here is a v1
that supports a single LSM let the bike shedding begin.



