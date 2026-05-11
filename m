Return-Path: <linux-api+bounces-6312-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMOUDCVEAmofpwEAu9opvQ
	(envelope-from <linux-api+bounces-6312-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 23:03:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3411516138
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 23:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CB0D3034B16
	for <lists+linux-api@lfdr.de>; Mon, 11 May 2026 21:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F9F4BCABB;
	Mon, 11 May 2026 21:03:27 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D0428851
	for <linux-api@vger.kernel.org>; Mon, 11 May 2026 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778533407; cv=none; b=bhIHPaGiQwwQ+YLWTIaohZDomQ/UEhNzyt8Jvl8xYJGgywMRorhHEcvPShmwlRguUR/406X9ZrpKt4GMlk4rAQRvpBKKT5YqWcF8dlXNR6tij5py4FcI50E5G+5I9/yBmY6zrB61ByncA65uQoV6fDeh1Vj7No42YzaC/Y8P294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778533407; c=relaxed/simple;
	bh=+NPExyxgo8HU6B6S+16brBkL/23BFRjYZRCRMSCRDlY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Kb+u4Q9MAd4iCYFcR3wkfLZmP12yA8SO1/oGlGWTxT/Xe5Qj9HKsQ4FwLSStn1fCjhfMlPUcvXzMhsDt47Km8Wxxhhu22m4A2Tcxuuxz9XJjidcSRmkLjKAprdIFYmtvasHw8X2KJsJpt7iM78JWXDdx8gGcrDJnlD7pcwkxwBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso33245465e9.0
        for <linux-api@vger.kernel.org>; Mon, 11 May 2026 14:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778533404; x=1779138204;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jz3M0PDIssZI97ILfGYCglTutVrokgfI2vbgfWrvds4=;
        b=f/w2GAAIvGCyzMVUvlfzDPZKo5rUlZjG12vlh3OXCU7VGwQ8vyDjcYjjjvUwWZU2KW
         3OhBMp9zd/NBb107DA5SH2ZRnQt2QRW1wNsI5GLcFEkrbUwc46nz+v/hftXwmrZB/21E
         CfbKgOSdTjnmijjN8dUTezSjUQv2W80EZzVQ4VL+lTyVbnKgPY227whQPSD31K+s5WtU
         KaEJBQajcHujgR6GANyomo14GnYj6s5eJuMsAjDvtQI/UWAkZrq95Iuw+EwRNUAc46or
         3lbvwCF0uiHJ0miqgWS8KuM6C4Ig3VdcEmzF1QTlrwPlDaaLqMQ2Psn7azd/81hqLZKr
         SJWw==
X-Forwarded-Encrypted: i=1; AFNElJ+jrxi2/mDUtrlM6uBlJBq9NvuZA/7CN8mFXm6amx/X9kxRTSIEiJ8vzCrY1IYq/2k6HOYHE+25yDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzG2+pH0nv9hqpSlygzOvd4L+AMuRvgEJVylUoDu3w35SwIIt/
	0e8ISfdM9N+0nUPuz7UpfpcUYHAvQ7R47ArLy+ggAc5/+xzRGx7Mvzjq
X-Gm-Gg: Acq92OHd+gbpaWS/Hxer4EXng8Jy8PjtkMBprczYn7YR8otAk2xeQGu4GKgIKyIcymF
	2w2G/g0KJwHX1iVnvjwRAil4g2uhwjWpTOJWjHuou+8fewTnitz77CgYv+gcI5Bw+W1j9PMq/NS
	wnFcDCCIMrk4g6l7vhb707q08mMAJLTY5iWnVZNJemH9l1H7NijJToTaos7Y3iLZkqTa4RIvFZd
	FOIytb5RFm4zfIRp4Yt2jG3tJfrNr70V9jp6v3BViPOy6O5W2wnCFp5+aKOHatcRMB7FqTsj/Oq
	oJCm60xOrjDE+Cghdw0XUuyqb9p2F9AjJQjoB2ffe/Jv8bdvnCZ4cPrbmBgKP7lj+eELFb91uQs
	DnxjAGr6Puin386uGkTyN1+BOiszhsDPdg5Kw8efyGHUJgF5in/7LQUMj59Qrskbz40itZZ5ObM
	WbiyuRs9w85pzg5LPhz93OfITNAz57sLqR4CQ8J0D8PPiormWgEuOhTcdYr3j5vU5udKX68cfHb
	Lc=
X-Received: by 2002:a05:600c:8b62:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e6748afe8mr234131845e9.5.1778533403812;
        Mon, 11 May 2026 14:03:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:96b:a101:6f5c:d416:bfa6:dfbd? ([2a0a:ef40:96b:a101:6f5c:d416:bfa6:dfbd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f4389a6sm2225605e9.22.2026.05.11.14.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 14:03:23 -0700 (PDT)
Message-ID: <3bfcf406-fdde-4303-9bd6-0d8d21ddba37@linux.win>
Date: Mon, 11 May 2026 22:03:21 +0100
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ignat Korchagin <ignat@linux.win>
Subject: Re: [PATCH] crypto: af_alg - Document the deprecation of AF_ALG
To: Eric Biggers <ebiggers@kernel.org>, Kamran Khan <kz@inspirated.com>
Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>,
 Andy Lutomirski <luto@amacapital.net>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <CALCETrVqG+1yErRJjkxvJrf=A+Vu84HTR4Bx1Pcd8G1C0PJcMA@mail.gmail.com>
 <14A441D8-5370-44BE-8732-99BF8107C3FD@getmailspring.com>
 <0b8bba44-f6bb-4d69-b9d4-5787c276d41a@inspirated.com>
 <20260510163204.GA2279@sol>
Content-Language: en-GB
In-Reply-To: <20260510163204.GA2279@sol>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D3411516138
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6312-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux.win];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ignat@linux.win,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 10/05/2026 17:32, Eric Biggers wrote:

> On Sun, May 10, 2026 at 08:54:07AM -0700, Kamran Khan wrote:
>> Hi,
>>
>> AF_ALG is useful not just for hardware-offloading, but also for memory
>> isolation so that applications only get oracle access to the crypto keys and
>> a memory-safety vulnerability in user applications would not immediately put
>> the secret key material at risk.
> Note that if that memory-safety vulnerability leads to code execution in
> the application, then it doesn't matter that it "only" has oracle
> access.  It can still decrypt any data encrypted by that key.


I don't think fully discounting hardware offloading is beneficial here. 
HW accelerators will be produced and without a common interface vendors 
would start implementing their own "bespoke" drivers with bespoke 
userspace interfaces (we already had such proposals), which in turn may 
introduce more attack surface. Yes, AF_ALG needs substantial 
improvement, but at least it can be a standardisation point.


> The relevant threat model would be arbitrary reads, not any
> "memory-safety vulnerability".
>
>> I understand and appreciate the concern with complex attack surface and the
>> increased frequency of attacks in this area. But I fear that completely
>> removing AF_ALG increases the risk for userspace applications relying on it
>> for memory isolation.
>>
>> What alternatives do userspace applications have on Linux for ensuring
>> crypto keys are not exposed in user memory? That is, FreeBSD and NetBSD
>> natively provide /dev/crypto; removing AF_ALG would kill the only equivalent
>> option on the Linux side for kernel-delegated cryptography.
> The standard solution is simply to use an isolated userspace process
> like ssh-agent.  Yes, the keys will be in "user memory".  But "not
> exposed in user memory" is *not* a correct statement of the problem.
>
> (Also note that protecting not-actively-in-use data from arbitrary read
> primitives doesn't require cryptography at all.  That can be done simply
> by using mprotect() to remove read permission from the memory, then
> temporarily adding it back when it needs to be accessed.)
>
> In any case, any hypothetical security benefit provided by AF_ALG would
> have to be *very high* to outweigh the continuous stream of
> vulnerabilities in it.  I understand that people using AF_ALG might not
> be familiar with that continuous stream of vulnerabilities, but it would


Is it actually that much compared to other features/subsystems, like 
eBPF or user namespaces? But we don't rush to deprecate those - instead 
trying to harden them and come up with better design.


> be worth spending some time researching what has been going on.
>
> - Eric


Ignat


