Return-Path: <linux-api+bounces-3730-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B16AAFEC8
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 17:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13DA21885A6B
	for <lists+linux-api@lfdr.de>; Thu,  8 May 2025 15:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1C279329;
	Thu,  8 May 2025 15:08:46 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837871D7E41;
	Thu,  8 May 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716926; cv=none; b=HCEYS6jXi7oykoSG5i2irVhEEvgvHdWa0mIjxaP4S8WZRIqJfdwNL8O8/VDmYCMMlVpaT22yjxyjDYG3L9r+xVJY8kEkS984iHf9fm2IGL351X/1pzByXqNRuL3ke8MP0wlCfAPIldZ13xeaUEwtksRdRbQSu/DszqJcjD68Xmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716926; c=relaxed/simple;
	bh=pO36bLXEqsI5dmjb3fZVSCZpu0F+ckPnsDM8jsyHElA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SjqG9YibNvIChqjG4TXAZkA2cZKLb3Dk8bj36LYGGA4YqgaNNZdY9gKWWwNudycpYfsD4Luv4yXOVkUoGu5rYBMznxCwRaYfYN6qjTCJFuhk57CTX4W95a7t/dBdNt/s4VjcElqn12khfHnnHEJEaMO4KRrmZFsTR6Ii2o7JzEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 548F7qGx083296;
	Fri, 9 May 2025 00:07:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 548F7o6P083277
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 9 May 2025 00:07:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <75c7424b-fec9-469b-8f73-50ab86948a24@I-love.SAKURA.ne.jp>
Date: Fri, 9 May 2025 00:07:48 +0900
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: John Johansen <john.johansen@canonical.com>,
        =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
        linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net,
        kees@kernel.org, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, takedakn@nttdata.co.jp,
        linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-kernel@vger.kernel.org
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com>
 <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
 <6d785712-6d8e-491c-86d4-1cbe5895778f@canonical.com>
 <75c0385c-b649-46b0-907f-903e2217f460@I-love.SAKURA.ne.jp>
 <07a496b2-ed1f-4a18-88d1-7be36dba3a8a@canonical.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <07a496b2-ed1f-4a18-88d1-7be36dba3a8a@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav402.rs.sakura.ne.jp

On 2025/05/08 23:44, John Johansen wrote:
> On 5/8/25 05:55, Tetsuo Handa wrote:
>> On 2025/05/08 17:25, John Johansen wrote:
>>> That is fine. But curious I am curious what the interface would look like to fit TOMOYO's
>>> needs.
>>
>> Stream (like "FILE *") with restart from the beginning (like rewind(fp)) support.
>> That is, the caller can read/write at least one byte at a time, and written data
>> is processed upon encountering '\n'.
>>
> 
> that can be emulated within the current sycall, where the lsm maintains a buffer.

That cannot be emulated, for there is no event that is automatically triggered when
the process terminates (i.e. implicit close() upon exit()) in order to release the
buffer the LSM maintains.

> Are you asking to also read data back out as well, that could be added, but doing
> a syscall per byte here or through the fs is going to have fairly high overhead.

At least one byte means arbitrary bytes; that is, the caller does not need to read
or write the whole policy at one syscall.

> 
> Without understanding the requirement it would seem to me, that it would be
> better to emulate that file buffer manipulation in userspace similar say C++
> stringstreams, and then write the syscall when done.

The size of the whole policy in byte varies a lot.


