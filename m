Return-Path: <linux-api+bounces-6290-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENpnFyeqAGrhLQEAu9opvQ
	(envelope-from <linux-api+bounces-6290-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 10 May 2026 17:54:15 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DB504EE5
	for <lists+linux-api@lfdr.de>; Sun, 10 May 2026 17:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A12530038D1
	for <lists+linux-api@lfdr.de>; Sun, 10 May 2026 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5C539FCD8;
	Sun, 10 May 2026 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inspirated-com.20251104.gappssmtp.com header.i=@inspirated-com.20251104.gappssmtp.com header.b="jJq4KJ6Y"
X-Original-To: linux-api@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5B38F250
	for <linux-api@vger.kernel.org>; Sun, 10 May 2026 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778428452; cv=none; b=Eclvsn5P3SrykVm5ftrrZqKQ05UJwhglEWt+EJVVKyGTJiGK0/vitBzTLCpcMnXOmMaAzVzGBoH0nwxS/V3G91+zwvj4KZyyZZfqysci8nyAAEdD82Zpb6knrUvJFjhHw0uFoNnK7QnsaIad6hZEIe/PWfechOiI2RX2DlD+IHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778428452; c=relaxed/simple;
	bh=LO76TaPcJ68KpkKLpiKa9Z5MHTFAwbrAsnYL2+h0mJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TW9RYuxT53ZsLsSGv8Ioi6VTTGhuyD10lZW7PV+36e8Wz9jsLVn5a8bhpRQUDbRBK+sq/8aToLUljU2Zpat1uqf7MQgo4pTdQd897kueeJc8+3yYs/2OkOPaK+EISf74A2+Rtb9qY//JmtHPTKR/X43fNMeRUCUXiLZ+HrzVjWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspirated.com; spf=pass smtp.mailfrom=inspirated.com; dkim=pass (2048-bit key) header.d=inspirated-com.20251104.gappssmtp.com header.i=@inspirated-com.20251104.gappssmtp.com header.b=jJq4KJ6Y; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspirated.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspirated.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c80167f56cdso1289493a12.3
        for <linux-api@vger.kernel.org>; Sun, 10 May 2026 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inspirated-com.20251104.gappssmtp.com; s=20251104; t=1778428449; x=1779033249; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oE6y69M3xiqzAX/8jVmHNK46h9/q1JAe0RRlKSB0MU=;
        b=jJq4KJ6Y9888cktD7MCWmzkxWrj+fcOOVIlTiUvOMN6L/l4d20+qne/w4MSqlqYbaY
         t/YHMhSA4MimVD7aDkAespAcawkwE3bDQDOeKpmwynsQSyvGv+meZ5J7DuDj9007TxJz
         MTtSISak3kCUrYVFsqFNel4NVhKehI2umNVCJk8VzM0kB/frl9aTkae6xQ02AlG6BohS
         46I5jda8PlbIsQqJF8BfV576wed45O6IFnga10TMpK1j9yau+8OaOPGzakKOrjngO3RQ
         3HUlEj2kYxA0CAJ3z6kVze3DQ6ciQqt5AFtKiVmDb+o+PG6H5O3t5+dzE0PxsaZo6Ue6
         z4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778428449; x=1779033249;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oE6y69M3xiqzAX/8jVmHNK46h9/q1JAe0RRlKSB0MU=;
        b=G32jdLjsTMPDj1iLJHV32KazM4Xi8sGetIN4Uxwv/qdpB9UgRlhgEcnDS0yUfbMqeC
         s7VI2c04KY0SJXEUL9Z/gMF3JDJnQPNNz0X9PMpwZzDEcHnpMZb5NtamcNEC6In3SH07
         76LGvccum0wQUzpW3HxxbbufFSEcMDbiQAEY1Q/IjZzIv5GxXj09mTsuHcEK+24NeIGK
         Q4cO2SzLh6NBZ2F0BtoGv67MxFQ+hxlZTmzCUUAFpM5GoljqLR4TPZ4GDXpRiSub1Hom
         GdqCYgBw8/zsChQZj2LZqIulND0jg7HTwWjrYUyTePMebQ9arVcIntBe+3fvopTQSJ5g
         Q3jg==
X-Forwarded-Encrypted: i=1; AFNElJ8lF2jUioTuM9Qj3Tfw96Q7ku1BfTeRbbqL8VqaVjRCtBTswjoMidNQS6TBesCVQojllmxiOekNNwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yoPtdsOikSUTqF4hpkKEl6D1PXJpUcrRFAVifKqPKEpSnDhO
	cakTLI3u5NsDWsbbVES2Rm00CnB+H1pysznS10bLyjWnfmjRCzrzqtvOCkfM0MYT7+k=
X-Gm-Gg: Acq92OF6Oaop2fAR1Lq0ENDyIbVS+E/SJpjpg1v2J3VmzS2k0SJNsyS7CwYLhZJ3a2O
	fVOewZk2uQCWs1tMlpwWv8Kfn6Ngb07k+GpKZqtSptJ+dZEOH3n8QjUe80ZM5fIf9c40ZMseUDq
	7FEY+KZ9s0Tt9kSNPhXkMZ/t0ew58L4cEbNXapZ+e9nMzHCCa/jLskTuOKZsbdWmpb6/ok6HO2H
	ubdobPpyGCZ+ZsrScrsrJ7sTq4ZU9iS6oTS2ksOoSKddEs1IUMY0bnCZkJJjgbtUYQX7zbo7gt2
	k3i+7Gh08tYLGpaK2v96r9UL6dqQCmxSlUlZu3DdoBPHC7kl9t9qlbGNQx2ooBw5nAXJjMttC3Q
	+O/dqXwkrCw7/Tsjj+mGPDOJiOTFn4xJ2klBHhTMN8H2eH8jatDDdVIjErld8ogKfF1FVhat4Lv
	CvdJIP9bksNpwOlujTmdCUtii7GfxXOIEwp2GGumI/q3drZ826klGMmzLxsaY3G+WUug==
X-Received: by 2002:a17:903:1a8d:b0:2bc:a58d:329 with SMTP id d9443c01a7336-2bca58d0532mr31671035ad.40.1778428448790;
        Sun, 10 May 2026 08:54:08 -0700 (PDT)
Received: from [192.168.1.106] ([50.35.35.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e8df57sm79286785ad.64.2026.05.10.08.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 08:54:08 -0700 (PDT)
Message-ID: <0b8bba44-f6bb-4d69-b9d4-5787c276d41a@inspirated.com>
Date: Sun, 10 May 2026 08:54:07 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>,
 Andy Lutomirski <luto@amacapital.net>
Cc: Eric Biggers <ebiggers@kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
 <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com>
Content-Language: en-US
From: Kamran Khan <kz@inspirated.com>
In-Reply-To: <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1C5DB504EE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[inspirated-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[inspirated-com.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-6290-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[inspirated.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kz@inspirated.com,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[inspirated-com.20251104.gappssmtp.com:dkim,chronox.de:url,copy.fail:url]
X-Rspamd-Action: no action

Hi,

AF_ALG is useful not just for hardware-offloading, but also for memory 
isolation so that applications only get oracle access to the crypto keys 
and a memory-safety vulnerability in user applications would not 
immediately put the secret key material at risk.

I understand and appreciate the concern with complex attack surface and 
the increased frequency of attacks in this area. But I fear that 
completely removing AF_ALG increases the risk for userspace applications 
relying on it for memory isolation.

What alternatives do userspace applications have on Linux for ensuring 
crypto keys are not exposed in user memory? That is, FreeBSD and NetBSD 
natively provide /dev/crypto; removing AF_ALG would kill the only 
equivalent option on the Linux side for kernel-delegated cryptography.

Thanks,
Kamran.

On 5/6/26 7:42 AM, Jeff Barnes wrote:
> Hi,
> 
> On May 5 2026, at 7:17 pm, Andy Lutomirski <luto@amacapital.net> wrote:
> 
>>> On Apr 29, 2026, at 6:19 PM, Eric Biggers <ebiggers@kernel.org> wrote:
>>>   
>>> ﻿AF_ALG is almost completely unnecessary, and it exposes a massive attack
>>> surface that hasn't been standing up to modern vulnerability discovery
>>> tools.  The latest one even has its own website, providing a small
>>> Python script that reliably roots most Linux distros: https://copy.fail/
>>   
>> How about adding a configuration option, defaulted on, that requires
>> capable(CAP_SYS_ADMIN) to create the socket (and maybe also to bind /
>> connect it).  And a sysctl to allow the administrator to override this
>> in the unlikely event that it’s needed.
>>   
>> IIRC cryptsetup used to and maybe even still does require these
>> sockets sometimes and this would let it keep working.  And there's all
>> the FIPS stuff downthread.
> 
> Apologize in advance for the long-winded answer.
> 
> The "FIPS stuff" centers on using sha512hmac -> libkcapi -> AF_ALG for
> verifying integrity. The early‑boot sha512hmac check that some
> distributions use (typically from initramfs) sits at an awkward
> intersection of multiple standards, and it may help to clarify where it
> actually fits and where it doesn't.
> 
>  From a standards perspective, FIPS 140‑3 requires a cryptographic module
> to perform self‑integrity verification using an approved algorithm and
> to prevent the module from entering an operational state on failure. In
> the Linux kernel, the cryptographic module is the kernel crypto
> subsystem, and these requirements are met by the kernel’s internal
> power‑up self‑tests (KATs, etc.) on the crypto code and critical data as
> loaded into memory.
> 
> FIPS 199 / SP 800‑53 (e.g., SI‑7) impose system‑level integrity
> requirements (for Moderate impact systems), i.e., that unauthorized
> modification of critical components is prevented or detected and that
> failures result in a protective action. These controls are explicitly
> technology‑agnostic and are not limited to cryptographic‑module self‑tests.
> 
> The sha512hmac check is not the FIPS 140‑3 cryptographic‑module
> self‑integrity test. Instead, it has historically been used as a system
> integrity control that provides auditors with assurance that the kernel
> image containing the cryptographic module has not been modified prior to
> execution, and that a failure will halt the boot.
> 
> Although FIPS 140‑3 does not mandate an HMAC over the kernel image, the
> early‑boot HMAC became an accepted evidence pattern for satisfying
> system‑integrity expectations (FIPS 199 / SI‑7) alongside a kernel
> crypto validation. This is why it is often perceived as “required” for
> FIPS submissions, even though it is not normatively required by
> FIPS 140‑3 itself.
> 
> With the deprecation/removal of AF_ALG for this use case, there is no
> longer a supported way to perform an early‑boot, userspace‑driven HMAC
> using validated kernel crypto without introducing circular dependencies
> (e.g., relying on userspace crypto before crypto self‑tests complete).
> As a result, there is no drop‑in replacement for sha512hmac that
> preserves all of its historical properties.
> 
> This is a new development that challenges a long‑standing assumption:
> that system‑integrity evidence and cryptographic‑module self‑integrity
> can be cleanly separated while still being demonstrated by a single
> early‑boot mechanism. That assumption no longer holds given proposed
> kernel interfaces.
> 
> A more accurate decomposition (and one that aligns with the intent of
> the standards) is to separate integrity enforcement by system phase.
> 
> 1. Secure Boot (or equivalent platform verification) ensures that a
> modified kernel image is not executed at all. This satisfies the
> requirement that critical components are not loaded in a modified state
> and that integrity failure results in a protective action (boot prevention).
> 
> 2. IMA (with appraisal and enforcement) ensures that modified
> executables, modules, or firmware cannot be loaded or executed once the
> kernel is running.
> 
> 3. Kernel crypto self‑tests continue to satisfy FIPS 140‑3
> self‑integrity requirements independently of the above.
> 
> Taken together, Secure Boot + IMA provide continuous system‑integrity
> enforcement without re‑introducing early‑boot HMACs or AF_ALG
> dependencies, while keeping cryptographic‑module self‑integrity
> correctly scoped to the kernel crypto subsystem.
> 
> The transition away from sha512hmac is therefore not a removal of
> integrity enforcement, but a shift from a single, early‑boot mechanism
> to a phased integrity model that better reflects the separation of
> concerns already present in the standards — even though this separation
> was previously masked by the hacky HMAC approach.
> 
> This change will require updated documentation and auditor education,
> but it reflects the current technical reality and avoids perpetuating an
> interface that no longer has a sustainable implementation path.
> 
>>   
>>   
>>>   
>>> This isn't sustainable, especially as LLMs have accelerated the rate the
>>> vulnerabilities are coming in.  The effort that is being put into this
>>> thing is vastly disproportional to the few programs that actually use
>>> it, and those programs would be better served by userspace code anyway.
>>>   
>>> These issues have been noted in many mailing list discussions already.
>>> But until now they haven't been reflected in the documentation or
>>> kconfig menu itself, and the vulnerabilities are still coming in.
>>>   
>>> Let's go ahead and document the deprecation.
>>>   
>>> This isn't intended to change anything overnight.  After all, most Linux
>>> distros won't be able to disable the kconfig options quite yet, mainly
>>> because of iwd.  But this should create a bit more impetus for these
>>> userspace programs to be fixed, and the documentation update should also
>>> help prevent more users from appearing.
>>>   
>>> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
>>> ---
>>>   
>>> This patch is targeting crypto/master
>>>   
>>> Documentation/crypto/userspace-if.rst | 82 ++++++++++++++++++++-------
>>> crypto/Kconfig                        | 69 ++++++++++++++++------
>>> 2 files changed, 113 insertions(+), 38 deletions(-)
>>>   
>>> diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/userspace-if.rst
>>> index 021759198fe7..c39f5c79a5b7 100644
>>> --- a/Documentation/crypto/userspace-if.rst
>>> +++ b/Documentation/crypto/userspace-if.rst
>>> @@ -2,30 +2,72 @@ User Space Interface
>>> ====================
>>>   
>>> Introduction
>>> ------------
>>>   
>>> -The concepts of the kernel crypto API visible to kernel space is fully
>>> -applicable to the user space interface as well. Therefore, the kernel
>>> -crypto API high level discussion for the in-kernel use cases applies
>>> -here as well.
>>> -
>>> -The major difference, however, is that user space can only act as a
>>> -consumer and never as a provider of a transformation or cipher
>>> -algorithm.
>>> -
>>> -The following covers the user space interface exported by the kernel
>>> -crypto API. A working example of this description is libkcapi that can
>>> -be obtained from [1]. That library can be used by user space
>>> -applications that require cryptographic services from the kernel.
>>> -
>>> -Some details of the in-kernel kernel crypto API aspects do not apply to
>>> -user space, however. This includes the difference between synchronous
>>> -and asynchronous invocations. The user space API call is fully
>>> -synchronous.
>>> -
>>> -[1] https://www.chronox.de/libkcapi/index.html
>>> +AF_ALG provides unprivileged userspace programs access to arbitrary hash,
>>> +symmetric cipher, AEAD, and RNG algorithms that are implemented in kernel-mode
>>> +code.
>>> +
>>> +AF_ALG is insecure and is deprecated. Originally added to the kernel
>>> in 2010,
>>> +most kernel developers now consider it to be a mistake.
>>> +
>>> +AF_ALG continues to be supported only for backwards compatibility.
>>> On systems
>>> +where no programs using AF_ALG remain, the support for it should be
>>> disabled by
>>> +disabling ``CONFIG_CRYPTO_USER_API_*``.
>>> +
>>> +Deprecation
>>> +-----------
>>> +
>>> +AF_ALG was originally intended to provide userspace programs access
>>> to crypto
>>> +accelerators that they wouldn't otherwise have access to.
>>> +
>>> +However, that capability turned out to not be useful on very many
>>> systems. More
>>> +significantly, the actual implementation exposes a vastly greater
>>> amount of
>>> +functionality than that. It actually provides access to all software algorithms.
>>> +
>>> +This includes arbitrary compositions of different algorithms created
>>> via a
>>> +complex template system, as well as algorithms that only make sense
>>> as internal
>>> +implementation details of other algorithms. It also includes full zero-copy
>>> +support, which is difficult for the kernel to implement securely.
>>> +
>>> +Ultimately, these algorithms are just math computations. They use
>>> the same
>>> +instructions that userspace programs already have access to, just
>>> accessed in a
>>> +much more convoluted and less efficient way.
>>> +
>>> +Indeed, userspace code is nearly always what is being used anyway.
>>> These same
>>> +algorithms are widely implemented in userspace crypto libraries.
>>> +
>>> +Meanwhile, AF_ALG hasn't been withstanding modern vulnerability
>>> discovery tools
>>> +such as syzbot and large language models. It receives a steady
>>> stream of CVEs.
>>> +Some of the examples include:
>>> +
>>> +- CVE-2026-31677
>>> +- CVE-2026-31431 (https://copy.fail)
>>> +- CVE-2025-38079
>>> +- CVE-2025-37808
>>> +- CVE-2024-26824
>>> +- CVE-2022-48781
>>> +- CVE-2019-8912
>>> +- CVE-2018-14619
>>> +- CVE-2017-18075
>>> +- CVE-2017-17806
>>> +- CVE-2017-17805
>>> +- CVE-2016-10147
>>> +- CVE-2015-8970
>>> +- CVE-2015-3331
>>> +- CVE-2014-9644
>>> +- CVE-2013-7421
>>> +- CVE-2011-4081
>>> +
>>> +It is recommended that, whenever possible, userspace programs be
>>> migrated to
>>> +userspace crypto code (which again, is what is normally used anyway) and
>>> +``CONFIG_CRYPTO_USER_API_*`` be disabled.  On systems that use
>>> SELinux, SELinux
>>> +can also be used to restrict the use of AF_ALG to trusted programs.
>>> +
>>> +The remainder of this documentation provides the historical
>>> documentation for
>>> +the deprecated AF_ALG interface.
>>>   
>>> User Space API General Remarks
>>> ------------------------------
>>>   
>>> The kernel crypto API is accessible from user space. Currently, the
>>> diff --git a/crypto/Kconfig b/crypto/Kconfig
>>> index 103d1f58cb7c..6cd1c478d4be 100644
>>> --- a/crypto/Kconfig
>>> +++ b/crypto/Kconfig
>>> @@ -1278,48 +1278,72 @@ config CRYPTO_DF80090A
>>>     tristate
>>>     select CRYPTO_AES
>>>     select CRYPTO_CTR
>>>   
>>> endmenu
>>> -menu "Userspace interface"
>>> +menu "Userspace interface (deprecated)"
>>>   
>>> config CRYPTO_USER_API
>>>     tristate
>>>   
>>> config CRYPTO_USER_API_HASH
>>> -    tristate "Hash algorithms"
>>> +    tristate "Hash algorithms (deprecated)"
>>>     depends on NET
>>>     select CRYPTO_HASH
>>>     select CRYPTO_USER_API
>>>     help
>>> -      Enable the userspace interface for hash algorithms.
>>> +      Enable the AF_ALG userspace interface for hash algorithms.  This
>>> +      provides unprivileged userspace programs access to arbitrary hash
>>> +      algorithms implemented in the kernel's privileged execution context.
>>>   
>>> -      See Documentation/crypto/userspace-if.rst and
>>> -      https://www.chronox.de/libkcapi/html/index.html
>>> +      This interface is deprecated and is supported only for backwards
>>> +      compatibility.  It regularly has vulnerabilities, and the capabilities
>>> +      it provides are redundant with userspace crypto libraries.
>>> +
>>> +      Enable this only if needed for support for a program that
>>> hasn't yet
>>> +      been converted to userspace crypto, for example iwd.
>>> +
>>> +      See also Documentation/crypto/userspace-if.rst
>>>   
>>> config CRYPTO_USER_API_SKCIPHER
>>> -    tristate "Symmetric key cipher algorithms"
>>> +    tristate "Symmetric key cipher algorithms (deprecated)"
>>>     depends on NET
>>>     select CRYPTO_SKCIPHER
>>>     select CRYPTO_USER_API
>>>     help
>>> -      Enable the userspace interface for symmetric key cipher algorithms.
>>> +      Enable the AF_ALG userspace interface for symmetric key algorithms.
>>> +      This provides unprivileged userspace programs access to arbitrary
>>> +      symmetric key algorithms implemented in the kernel's privileged
>>> +      execution context.
>>> +
>>> +      This interface is deprecated and is supported only for backwards
>>> +      compatibility.  It regularly has vulnerabilities, and the capabilities
>>> +      it provides are redundant with userspace crypto libraries.
>>> +
>>> +      Enable this only if needed for support for a program that
>>> hasn't yet
>>> +      been converted to userspace crypto, for example iwd, or cryptsetup
>>> +      with certain algorithms.
>>>   
>>> -      See Documentation/crypto/userspace-if.rst and
>>> -      https://www.chronox.de/libkcapi/html/index.html
>>> +      See also Documentation/crypto/userspace-if.rst
>>>   
>>> config CRYPTO_USER_API_RNG
>>> -    tristate "RNG (random number generator) algorithms"
>>> +    tristate "Random number generation algorithms (deprecated)"
>>>     depends on NET
>>>     select CRYPTO_RNG
>>>     select CRYPTO_USER_API
>>>     help
>>> -      Enable the userspace interface for RNG (random number generator)
>>> -      algorithms.
>>> +      Enable the AF_ALG userspace interface for random number generation
>>> +      (RNG) algorithms.  This provides unprivileged userspace programs
>>> +      access to arbitrary RNG algorithms implemented in the kernel's
>>> +      privileged execution context.
>>>   
>>> -      See Documentation/crypto/userspace-if.rst and
>>> -      https://www.chronox.de/libkcapi/html/index.html
>>> +      This interface is deprecated and is supported only for backwards
>>> +      compatibility.  It regularly has vulnerabilities, and the capabilities
>>> +      it provides are redundant with userspace crypto libraries as
>>> well as
>>> +      the normal kernel RNG (e.g., /dev/urandom and getrandom(2)).
>>> +
>>> +      See also Documentation/crypto/userspace-if.rst
>>>   
>>> config CRYPTO_USER_API_RNG_CAVP
>>>     bool "Enable CAVP testing of DRBG"
>>>     depends on CRYPTO_USER_API_RNG && CRYPTO_DRBG
>>>     help
>>> @@ -1330,20 +1354,29 @@ config CRYPTO_USER_API_RNG_CAVP
>>>   
>>>       This should only be enabled for CAVP testing. You should say
>>>       no unless you know what this is.
>>>   
>>> config CRYPTO_USER_API_AEAD
>>> -    tristate "AEAD cipher algorithms"
>>> +    tristate "AEAD cipher algorithms (deprecated)"
>>>     depends on NET
>>>     select CRYPTO_AEAD
>>>     select CRYPTO_SKCIPHER
>>>     select CRYPTO_USER_API
>>>     help
>>> -      Enable the userspace interface for AEAD cipher algorithms.
>>> +      Enable the AF_ALG userspace interface for authenticated encryption
>>> +      with associated data (AEAD) algorithms.  This provides unprivileged
>>> +      userspace programs access to arbitrary AEAD algorithms
>>> implemented in
>>> +      the kernel's privileged execution context.
>>> +
>>> +      This interface is deprecated and is supported only for backwards
>>> +      compatibility.  It regularly has vulnerabilities, and the capabilities
>>> +      it provides are redundant with userspace crypto libraries.
>>> +
>>> +      Enable this only if needed for support for a program that
>>> hasn't yet
>>> +      been converted to userspace crypto, for example iwd.
>>>   
>>> -      See Documentation/crypto/userspace-if.rst and
>>> -      https://www.chronox.de/libkcapi/html/index.html
>>> +      See also Documentation/crypto/userspace-if.rst
>>>   
>>> config CRYPTO_USER_API_ENABLE_OBSOLETE
>>>     bool "Obsolete cryptographic algorithms"
>>>     depends on CRYPTO_USER_API
>>>     default y
>>>   
>>> base-commit: 57b8e2d666a31fa201432d58f5fe3469a0dd83ba
>>> --
>>> 2.54.0
>>>   
>>>   
>>
> 


