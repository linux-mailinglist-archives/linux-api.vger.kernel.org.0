Return-Path: <linux-api+bounces-3738-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6831FAB27E2
	for <lists+linux-api@lfdr.de>; Sun, 11 May 2025 13:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8F7173298
	for <lists+linux-api@lfdr.de>; Sun, 11 May 2025 11:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE69F1D5154;
	Sun, 11 May 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="CVWROG4u"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677DF1CA84;
	Sun, 11 May 2025 11:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746961805; cv=none; b=V8npoRGYe2xRuaEo1rbpd9rj8hf48tovPSb31ZeqluwUnybnb3KGB7oEDahKxR8/nV4FOhhEYVMkyRTKPeXo/GpnHUBx75vwEAKRq4POGbsEDJJ5n9JWRkT6fygF129EYdCHMyvGjne63W9mkI37RW91i+Cmzwjde6on1AW1ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746961805; c=relaxed/simple;
	bh=jMQBK9nDENFw/bCN1t0pnnaMpP8NqWeKB9vcg7JDZWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ue9GmP0rdSu+8R6VG8do+bvu60tt8TeXmgjBKAF9U3FgOrFJPuKzCKhu6VwVqZK7Q0anIOkBZSv7i3/ey4n5CsIuVmecnUWyaGW5wg+zrbAbw/gmFH4efNQ83ufA2PW0wapZoavWt5bPPEfk84/dIowMc1O0e9mcn9Zbi1T8DCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=CVWROG4u; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [172.20.3.254] (unknown [213.157.19.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id CC9DE3FE1C;
	Sun, 11 May 2025 11:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1746961800;
	bh=+uL/f0wq2ESOTZKET8OH5w68gAIopfy0QxnsRwSKynA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=CVWROG4uQt7gdi6SeZNs+j1hdq8C0KxT1gYttB2rwjZ8p3p8Ve8cXz63QDccn1vgd
	 ZufUZ6uuZryPfeGeqYwuPDA7FSnRyzekaeJv+/d8eaBTngoC57k7EUthBC44H9Xj3L
	 Dlg70sv6C/tIwmXePcdoHKqAKnYZY+92FjQmigGcqYRy5bEv06fDqB13dDz/+EOOad
	 moP+Hu3ogc0qdPGGRL9sYNs2WKN4GNrIO7Q85ZhngceGUIGq88+mLYuJFssK0dYKLw
	 GCEO+9544qn7wPU4ngsei+p5UgAZSuUp9JwYLorM8SLq2ouxyze5inYAh7kAxwQw9Y
	 FUJPaHiC1vdGw==
Message-ID: <c8faa0ca-1cbd-439f-bdf7-0bf34c2b9d91@canonical.com>
Date: Sun, 11 May 2025 04:09:58 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Wire up the lsm_manage_policy syscall
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>,
 Song Liu <song@kernel.org>, linux-security-module@vger.kernel.org,
 paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, kees@kernel.org,
 stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
 takedakn@nttdata.co.jp, linux-api@vger.kernel.org,
 apparmor@lists.ubuntu.com, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-2-maxime.belair@canonical.com>
 <CAPhsuW4qY9B3KdhqrUOZoNBWQmO_RDwbH46my314WxrFwxbwkQ@mail.gmail.com>
 <aa3c41f9-6b25-4871-a4be-e08430e59730@canonical.com>
 <470689f0-223e-4d26-a919-8d48f383883b@I-love.SAKURA.ne.jp>
 <7da224cd-fd9c-4c80-9a23-cb977420f50b@canonical.com>
 <20250509.bokeiCho2oov@digikod.net>
Content-Language: en-US
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20250509.bokeiCho2oov@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/9/25 03:25, Mickaël Salaün wrote:
> On Thu, May 08, 2025 at 12:52:55AM -0700, John Johansen wrote:
>> On 5/7/25 15:04, Tetsuo Handa wrote:
>>> On 2025/05/08 0:37, Maxime Bélair wrote:
>>>> Again, each module decides which operations to expose through this syscall. In many cases
>>>> the operation will still require CAP_SYS_ADMIN or a similar capability, so environments
>>>> that choose this interface remain secure while gaining its advantages.
>>>
>>> If the interpretation of "flags" argument varies across LSMs, it sounds like ioctl()'s
>>
>> yes that does feel like ioctls(), on the other hand defining them at the LSM level won't
>> offer LSMs flexibility making it so the syscall covers fewer use cases. I am not opposed
>> to either, it just hashing out what people want, and what is acceptable.
>>
>>> "cmd" argument. Also, there is prctl() which can already carry string-ish parameters
>>> without involving open(). Why can't we use prctl() instead of lsm_manage_policy() ?
>>>
>>
>> prctl() can be used, I used it for the unprivileged policy demo. It has its own set of
>> problems. While LSM policy could be associated with the process doing the load/replacement
>> or what ever operation, it isn't necessarily tied to it. A lot of LSM policy is not
>> process specific making prctl() a poor fit.
>>
>> prctl() requires allocating a global prctl()
>>
>> prctl() are already being filtered/controlled by LSMs making them a poort fit for
>> use by an LSM in a stacking situation as it requires updating the policy of other
>> LSMs on the system. Yes seccomp can filter the syscall but that still is an easier
>> barrier to overcome than having to have instruction for how to allow your LSMs
>> prctl() in multiple LSMs.
>>
>>
>> Mickaël already argued the need for landlock to have syscalls. See
> 
> Landlock indeed requires syscalls mainly because of its unprivileged
> nature.
> 

yes that is the dominant reason

>> https://lore.kernel.org/lkml/20200511192156.1618284-7-mic@digikod.net/
>> and the numerous iterations before that.
> 
> This link might be misleading though, it points to an initial version of
> the syscall proposal (v17) and it was then decided to create one syscall
> per operation (v34), which is why we ended with 3 syscalls.  See the
> changelog:
> https://lore.kernel.org/r/20210422154123.13086-9-mic@digikod.net
> 

yes and no. I am well aware landlock's syscall got split into three syscalls.

All I was trying to do is reference to the start of the discussion on why
landlock needed a syscall(s). I thought the details of why you have three
etc, really didn't add to the discussion. But yeah not also pointing to
v34 could be considered misleading.


>>
>> Ideally those could have been LSM syscalls, with landlock leveraging them.
> 
> I don't agree.  The Landlock syscalls have a well-defined semantic, with

First I don't begrudge Landlock its syscalls, I think at the time it was
the only way forward.

> documented security requirements, and they deal with specific kernel
> objects identified with file descriptors, including a dedicated one:
> [landlock-ruleset].

I am aware. Those semantics could have been kept and documented, within
a set of LSM syscalls. Yes landlock's syscalls shouldn't have been done
behind a single LSM syscall, I am not advocating for that but maybe
behind several LSM syscalls.

>  For the features provided by these Landlock
> syscalls, it would not have been a good idea to reuse existing syscalls,
> nor to rely on the syscall proposed in this series because the interface
> is too specific to some of the current privileged LSMs (i.e. ingest a
> policy blob).  Making this interface more generic would lead to even
> less defined semantic though.

Right, so again not a generic LSM syscall. But "generic" LSM syscalls
for certain purposes. Let me walk my statement back a little, what I
find unfortunate was that the landlock LSM syscalls didn't get discussed
as a set of generic LSM syscall's with landlock being the first to
implement them.

The question is hashing out where the generic semantics are vs. the
individual LSMs. Having an LSM syscall to deal with specific kernel
objects idenetified with file descriptors, and allowing each LSMs
to deal with that if it needs is possible.

Its a matter of figuring something out. It could be it turns out it is
not worth it. And some individual LSM syscalls like landlocks are the
way to go, its that it wasn't explored. I don't fault you, and think
it really wasn't even an option at the time.

> 
>> AppArmor
>> is getting to where it has similar needs to landlock. Yes we can use ioctls, prctls,
>> netlink, the fs, etc. it doesn't mean that those are the best interfaces to do so,
> 
> I think it would make sense to propose AppArmor-specific syscalls.
> 

that may be the case, but I think we should explore providing a more
LSM generic interface first.

>> and ideally any interface we use will be of benefit to some other LSMs in the future.
> 
> The LSM syscalls may make sense to deal with LSM blobs managed by the
> LSM framework (e.g. get/set properties) when the operations are
> common/generic.
> 
> Security policies are specific to each LSM and they should implement
> their own well-defined interface (e.g. filesystem, netlink, syscall).
> 
policies at some level are just blobs too. It is worth at least
exploring whether there can be a common interface.

> The LSM framework doesn't provide nor manage any security policy, it
> mainly provides a set of consistent and well-defined kernel hooks with
> security blobs to enforce a security policy.  I don't think it makes
> sense to add LSM syscalls to manage things not managed by the LSM
> framework.

we aren't talking about the LSM framework managing security policy,
just whether it makes sense for it to provide a common interface that
an LSM can choose to use to provide it a blob of policy that it
can then manage.

Its just a mechanism. This isn't all that different than using the
filesystem, netlink, or other mechanisms to shuttle the blob
between userspace to the kernel, and then the LSM manages its
policy and data.

The big difference is that using the syscall opens unprivileged
policy up to the LSM more broadly. If we are going to go the syscall
route for apparmor, we might as well see if we can't make that
mechanism more broadly available, and make it easier for other
LSMs in the future.

Again, it might turn out its a fools errand, and we have to do
an apparmor specific syscall, but it is worth exploring first.



