Return-Path: <linux-api+bounces-3732-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1F0AB08DB
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 05:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9123B60FB
	for <lists+linux-api@lfdr.de>; Fri,  9 May 2025 03:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE6921E094;
	Fri,  9 May 2025 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Z3UZjFbx"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE8364A8F;
	Fri,  9 May 2025 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746761112; cv=none; b=Crt23Mm47ivSDc7K3lWcYMD51oKEJuiVsxNoIM04uCyjEPhDE0GjQ47s6BFAzmJNs7K6BeNuX+yIA9ut8e/ap3smZlofy3FPIK+Pp+a02vx6tWmwkq1as8r4OpmgblCaEjGsj8F4yOxUcsXwZtrxuV+K+xAQYrG4nl75qMdj94o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746761112; c=relaxed/simple;
	bh=JPqmzf4gOx8AVbXkvRM+lnEpK1UDKkWYdXTKOvnpdfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvR7cS8S7d6cfrpWJWMnAWKjl76wN1POGBEgWIfql4KJIgQbcrlbwBV1QIZ1jckTb4EjtbI/uAum033bHgCAijt+ZaJdreEMT16B8OivDD2gpQJZJv/auH5O4H9pNplmKzvcZHQxxi/SMmnAk75EYzZumQjzI/FsamPAcEGdxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Z3UZjFbx; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [172.20.3.254] (unknown [213.157.19.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 5EAA53FBEE;
	Fri,  9 May 2025 03:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746761107;
	bh=1DZ8iwMZIwS63JI0hHfUuAmxjE7s0c4ZLKJru1Z5GFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=Z3UZjFbxfDXTXYGZNY4EWCokJ8sJ38K9KuFbP+NcrMu+gv8FqVZgRFi3BzATOue0B
	 EfINAXCcp57pzqgD5kC69+9xWo+YSo11lMUv3QZMpp7QyHRyXWI8Z20U07LgN+/ECp
	 GyQLaIdrs8J975UpP0AQa67DJouQ7UPQX5mUWo760PmDlyUplG1Iz8l/9YG25iBM7x
	 jyFP41YpQBAoUljlPnNTvzD9jKMCblyALUd6/GbHNbsQYWvm0X2MOJw3YNEdfNFvGI
	 2PBC39M0QIqFdzbGo89G4r62vKBrxhaJyz6/p9VfrIgfyfpggyIngfVTO2IxbiJ0/x
	 SVHdUtG0ZeOGQ==
Message-ID: <88d70234-2c43-4208-88c2-15a39aa5c6eb@canonical.com>
Date: Thu, 8 May 2025 20:25:04 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
 mic@digikod.net, kees@kernel.org, stephen.smalley.work@gmail.com,
 casey@schaufler-ca.com, takedakn@nttdata.co.jp, linux-api@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
 <6d785712-6d8e-491c-86d4-1cbe5895778f@canonical.com>
 <75c0385c-b649-46b0-907f-903e2217f460@I-love.SAKURA.ne.jp>
 <07a496b2-ed1f-4a18-88d1-7be36dba3a8a@canonical.com>
 <75c7424b-fec9-469b-8f73-50ab86948a24@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <75c7424b-fec9-469b-8f73-50ab86948a24@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/25 08:07, Tetsuo Handa wrote:
> On 2025/05/08 23:44, John Johansen wrote:
>> On 5/8/25 05:55, Tetsuo Handa wrote:
>>> On 2025/05/08 17:25, John Johansen wrote:
>>>> That is fine. But curious I am curious what the interface would look like to fit TOMOYO's
>>>> needs.
>>>
>>> Stream (like "FILE *") with restart from the beginning (like rewind(fp)) support.
>>> That is, the caller can read/write at least one byte at a time, and written data
>>> is processed upon encountering '\n'.
>>>
>>
>> that can be emulated within the current sycall, where the lsm maintains a buffer.
> 
> That cannot be emulated, for there is no event that is automatically triggered when
> the process terminates (i.e. implicit close() upon exit()) in order to release the
> buffer the LSM maintains.
>

security_task_free()
  
>> Are you asking to also read data back out as well, that could be added, but doing
>> a syscall per byte here or through the fs is going to have fairly high overhead.
> 
> At least one byte means arbitrary bytes; that is, the caller does not need to read
> or write the whole policy at one syscall.
> 
got it

>>
>> Without understanding the requirement it would seem to me, that it would be
>> better to emulate that file buffer manipulation in userspace similar say C++
>> stringstreams, and then write the syscall when done.
> 
> The size of the whole policy in byte varies a lot.
> 
sure, buffers can be variable length. AppArmor policy also varies a lot in size.

More than anything I am trying to understand TOMOYO's requirements. They do
align better with using an fs interface. Can they be met sure, but it would
be more work for TOMOYO.

One of the big motivations for the syscall from the apparmor side is getting
away from the need to have the vfs present or having to pass an fd into the
environment.



