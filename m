Return-Path: <linux-api+bounces-3798-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235AABA8C9
	for <lists+linux-api@lfdr.de>; Sat, 17 May 2025 09:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB441BA14B5
	for <lists+linux-api@lfdr.de>; Sat, 17 May 2025 08:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAF3E1D5AB7;
	Sat, 17 May 2025 07:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="V/UQDf9r"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B17015A85E;
	Sat, 17 May 2025 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747468781; cv=none; b=kHrxoTUSp7+/3CVZcfg+iAlHWUGZzm3ZaMQlgD8apd/K6KxNoIiBj0jBD986SzZraNGjs9s/mAoRoPm0a605+fktg54IX+C5DxadqB2jklEDRPxguLc2tEBY+gSSV+b/Hnhh44ABN1t4RZKobfR0mQtzvD9C6YHDRcQesmNRnAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747468781; c=relaxed/simple;
	bh=b1p+tihqeOwil/X+feaB+AdMD+e2FnzeG6zEDkwk+zU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHymA1rS1HklnpzH5B8AKLxsvQdhDWUVHFiscY20uvseeScRcOMhEt6Tmm2oakDpBhbvQd6qtFOmD2r35kJwSEn9mPArXkPb/aJNtSc8Rz/76Pkuj8/rAIsYzMwjyAd/OPF3+Qvtt28oGigjANS4PYbPoIQqoItDMcxAXkD/hJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=V/UQDf9r; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [172.20.3.254] (unknown [213.157.19.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4035F3FAF2;
	Sat, 17 May 2025 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747468777;
	bh=boRUM1/YvyQdPx5YHnooNrkfveY46XxsAxCI4cm/TsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=V/UQDf9rxlnpSNpS7k9Sbb3deNhURqm0LcOlXKaJgbv6R4bsyygbUloa8di/yfuuE
	 CMdHN8pKGM0Ena9q67wQiIayTjOifV/7ASXWa1n8sHxlzyCxEcoi568QWSrVu7V6rt
	 1jyX7mB327zAWRd12n0e+lHy+H2+gKffyGCOeyNcuOnW5NiRChCxuv2hmEZ7MU9xZ+
	 1j2L6kyYTQH3r0wBJ/IfM/Vya9hRJGxeS9L9EOU2a08kZQcIlT8m6gvsjwU6rVipLh
	 zyfqEoIk/YMoqrBFGPtXhRyNieg/Tt0cWntUbGgPJZ9d/TQ0CTQh4HxVwL3RT7c+pY
	 aWFIl6m7kaZ9A==
Message-ID: <b5aeb40d-e1e7-4b99-8c26-cc6b7d8b422b@canonical.com>
Date: Sat, 17 May 2025 00:59:36 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Song Liu <song@kernel.org>, =?UTF-8?Q?Maxime_B=C3=A9lair?=
 <maxime.belair@canonical.com>, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, kees@kernel.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp,
 linux-api@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-2-maxime.belair@canonical.com>
 <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
 <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
 <CAPhsuW4FVMS7v8p_C-QzE8nBxCb6xDRhEecm_KHZ3KbKUjOXrQ@mail.gmail.com>
 <9aaeda3a-8ef5-4820-b2e4-9180b73fb368@canonical.com>
 <20250509.ePu7gaim1Foo@digikod.net>
 <19313f6b-42d7-4845-9a4b-93c7546aadb9@canonical.com>
 <20250512.Uong6eCaVuwu@digikod.net>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250512.Uong6eCaVuwu@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/12/25 03:20, Mickaël Salaün wrote:
> On Sun, May 11, 2025 at 03:47:21AM -0700, John Johansen wrote:
>> On 5/9/25 03:26, Mickaël Salaün wrote:
>>> On Thu, May 08, 2025 at 01:18:20AM -0700, John Johansen wrote:
>>>> On 5/7/25 23:06, Song Liu wrote:
>>>>> On Wed, May 7, 2025 at 8:37 AM Maxime Bélair
>>>>> <maxime.belair@canonical.com> wrote:
>>>>> [...]
> 
>>>>> permission check to each pseudo file. The downside of the syscall, however,
>>>>> is that all the permission checks are hard-coded in the kernel (except for
>>>>
>>>> The permission checks don't have to be hard coded. Each LSM can define how it handles
>>>> or manages the syscall. The default is that it isn't supported, but if an lsm decides
>>>> to support it, there is now reason that its policy can't determine the use of the
>>>> syscall.
>>>
>>>   From an interface design point of view, it would be better to clearly
>>> specify the scope of a command (e.g. which components could be impacted
>>> by a command), and make sure the documentation reflect that as well.
>>> Even better, have a syscalls per required privileges and impact (e.g.
>>> privileged or unprivileged).  Going this road, I'm not sure if a
>>> privileged syscall would make sense given the existing filesystem
>>> interface.
>>>
>>
>> uhhhmmm, not just privileged. As you well know we are looking to use
>> this for unprivileged policy. The LSM can limit to privileged if it
>> wants but it doesn't have to limit it to privileged policy.
> 
> Yes, I meant to say having a syscall for unprivileged actions, and maybe
> another one for privileged ones, but this might be a hard sell. :)
> 
indeed, in the apparmor case context would be important. Just exactly
what is privileged. It may be a privileged operation to load policy to one
namespace, but not to another that you are setting up for a child.

> To say it another way, for your use case, do you need this syscall(s)
> for privileged operations?  Do you plan to drop (or stop extending) the

need, probably. That is to say, loading of policy have varying levels
of privilege. root within the container has privilege to load policy
to its namespace, but it might have authority to setup a child namespace
that does not require privilege for it to load policy into, and it
will determine if the child has privilege or unprivleged policy within
it.

Ideally we won't have to use the fs interface within the "privileged"
container, as there are cases where this is currently not done or
undesirable.

> filesystem interface or do you think it would be good for (AppArmor)
> privileged operations too?  I know syscalls might be attractive and
> could be used for everything, but it's good to have a well-defined plan
> and semantic to avoid using such syscall as another multiplexer with
> unrelated operations and required privileges.
> 
sure. But the privilege level is use case dependent, to which policy
namespace is policy being loaded, replaced, ...  The privilege level
very much will depend on what is in the stack/bounding of policy.

> If this syscall should also be a way to do privileged operations, should
> we also agree on a common set of permissions (e.g. global CAP_MAC_ADMIN
> or user namespace one)?
> 
I think requiring something like CAP_MAC_ADMIN would be a per LSM
decision.


> [...]
> 
>>>>> Overall, I am still not convinced a syscall for all LSMs is needed. To
>>>>> justify such
>>>>
>>>> its not needed by all LSMs, just a subset of them, and some nebulous
>>>> subset of potentially future LSMs that is entirely undefinable.
>>>>
>>>> If we had had appropriate LSM syscalls landlock wouldn't have needed
>>>> to have landlock specific syscalls. Having another LSM go that route
>>>> feels wrong especially now that we have some LSM syscalls.
>>>
>>> I don't agree.  Dedicated syscalls are a good thing.  See my other
>>> reply.
>>>
>>
>> I think we can just disagree on this point.
>>
>>>> If a
>>>> syscall is needed by an LSM its better to try hashing something out
>>>> that might have utility for multiple LSMs or at the very least,
>>>> potentially have utility in the future.
>>>>
>>>>
>>>>> a syscall, I think we need to show that it is useful in multiple LSMs.
>>>>> Also, if we
>>>>> really want to have single set of APIs for all LSMs, we may also need
>>>>> get_policy,
>>>>
>>>> We are never going to get a single set of APIs for all LSMs. I will
>>>> settle for an api that has utility for a subset
>>>>
>>>>> remove_policy, etc. This set as-is appears to be an incomplete design. The
>>>>
>>>> To have a complete design, there needs to be feedback and discussion
>>>> from multiple LSMs. This is a starting point.
>>>>
>>>>> implementation, with call_int_hook, is also problematic. It can easily
>>>>> cause some> controversial behaviors.
>>>>>
>>>> agreed it shouldn't be doing a straight call_int_hook, it should only
>>>> call it against the lsm identified by the lsmid
>>>
>>> Yes, but then, I don't see the point of a "generic" LSM syscall.
>>
>> its not a generic LSM syscall. Its a syscall or maybe a set of syscalls
>> for a specific scoped problem of loading/managing policy.
>>
>> Can we come to something acceptable? I don't know but we are going to
>> look at it before trying for an apparmor specific syscall.
> 
> I understand and it's good to have this discussion.


