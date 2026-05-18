Return-Path: <linux-api+bounces-6345-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLGYJkEmC2pAEAUAu9opvQ
	(envelope-from <linux-api+bounces-6345-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 16:46:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C9256F282
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11AEE31A99E1
	for <lists+linux-api@lfdr.de>; Mon, 18 May 2026 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B06332EA2;
	Mon, 18 May 2026 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RZAGle6y"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8903EE1FD;
	Mon, 18 May 2026 14:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115038; cv=none; b=E9yGC3IDGt2U5IcHR+P9gBvtx2huCdLk/bBOG/zNYxARHQwJlqflvJfXyTwOJbBOwjJivSgWGpPdB9LCz5i5P7HNeVAJlRz22eIjCuwkFc/Cpw7hPkcntwdA91wt35rnUOENXA8N60Ei7CQ1adWkoVRcsRoqhzuiRW8Z6WLG5p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115038; c=relaxed/simple;
	bh=xMBRVz6JPEwn0lMrqhaTFeSb+4QAHpfTmiehoPGdyoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3P9Lz7gaq44gZlFiKxJG6uLzd6pyAxSpWby5dSRz/n8RV5Tjb/7kkYWND7uSumZtc3DTKsMZGVkVlR7ZlnrhDTVSUTAyu2W1wd2lSzccVxctrzij/2f96s612bORRGYOSfntQCaKDZCl/MigqDAEvognm0RRbxHsLDmUwJiC2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RZAGle6y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bi2zvXfPAC7MJR8uzPMdJCazlbOhH6F/9nDgowFYtgM=; b=RZAGle6yUybfFFRqyTgdwKikN/
	4UvKUDTU/31CaUzfsm8lzVNS+niZfXUNPFuIOKbNoMNau/b++KD8beTftcUw4U7gQaLSqoQYQc4xG
	ofu9JZltw32GalJ7F/D5yGAq16YiDFoFyVceaHEiEW3/6yCapx7P/1QCGA3olSQuERSAvFVAO7Mvu
	Vt38hUbTI4rk7ZtqGh28tlEnBcF0mHv/DpcS1DqO4Z+/KdZiaYAJzRE6QvQOj9q/iPVUoTbWcymx1
	W/13AL20oJ5Effj0Tf3y51/HIGbj8LygXvbV12cJSIwf537GH2YG13WJq9HOmsJN+4HPmf+hkCNgN
	nNfIxaaQ==;
Received: from [179.193.2.40] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wOz5V-002fuQ-2L; Mon, 18 May 2026 16:36:57 +0200
Message-ID: <d4d6cf61-568e-478e-88d6-01b769d7eded@igalia.com>
Date: Mon, 18 May 2026 11:36:49 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] string: Introduce strtostr() for safe and performance
 string copies
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Christian Brauner
 <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, willy@infradead.org,
 mathieu.desnoyers@efficios.com,
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com,
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org,
 linux-api@vger.kernel.org
References: <20260517-tonyk-long_name-v1-0-3c282eaa91e2@igalia.com>
 <20260517-tonyk-long_name-v1-3-3c282eaa91e2@igalia.com>
 <20260517223419.3262de7c@pumpkin>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260517223419.3262de7c@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6345-lists,linux-api=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,igalia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,godbolt.org:url]
X-Rspamd-Queue-Id: E2C9256F282
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi David, thanks for the feedback!

Em 17/05/2026 18:34, David Laight escreveu:
> On Sun, 17 May 2026 15:36:13 -0300
> André Almeida <andrealmeid@igalia.com> wrote:
> 
>> Some parts of the kernel uses memcpy() instead of strscpy() because they
>> are performance sensitive and doesn't care about the return value of
>> strscpy(). One such common case is to copy current->comm to a different
>> buffer.
>>
>> As the command name is guaranteed to be NUL-terminated in the range of
>> TASK_COMM_LEN, this is safe enough and doesn't create unterminated
>> strings. However, in order to expand the size of current->comm, this
>> expectation will be broken and those memcpy() could create such strings
>> without trailing NUL byte.
>>
>> In order to support a fast and safe string copy, create strtostr(), to copy
>> a NUL-terminated string to a new string buffer. If the destination buffer
>> is bigger than the source, no pad is applied, but the string is
>> NUL-terminated. If the destination buffer is smaller, the string is
>> truncated. The last byte of the destination is always set to NUL for safety.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
[...]>> +/**
>> + * strtostr - Copy NUL-terminanted string to NUL-terminate string
>> + *
>> + * @dest: Pointer of destination string
>> + * @src: Pointer to NUL-terminates string
>> + *
>> + * This is a replacement for strcpy() where the caller doesn't care about the
>> + * return value and if the string is going to be truncated, albeit it needs
>> + * to mark sure that it will be NUL-terminated. Intended for performance
>> + * sensitive cases, such as tracing.
> 
> If you care about performance, and the destination isn't smaller (especially
> if the sizes are the same) then just use memcpy().
>   

The problem is that as I'm expanding current->comm, the source buffer 
might be bigger than destination, and when we truncate the string, it 
won't have the termination NUL byte. So we need an extra dest[len-1] = 
\0 after the memcpy.

>> + *
>> + * If the destination is bigger than the source, no padding happens. It it's
>> + * smaller the strings gets truncated.
>> + *
>> + * Both arguments needs to be arrays with lengths discoverable by the compiler.
>> + */
>> +#define strtostr(dest, src)	do {					\
>> +	const size_t _dest_len = __must_be_cstr(dest) +			\
>> +				 ARRAY_SIZE(dest);			\
>> +	const size_t _src_len = __must_be_cstr(src) +			\
>> +				__builtin_object_size(src, 1);		\
>> +									\
>> +	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
>> +		     _dest_len == (size_t)-1);				\
>> +	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
>> +	dest[_dest_len - 1] = '\0';						\
>> +} while (0)
> 
> That doesn't work (for all sorts of reasons).
> _dest_len can be the size of a pointer - no array check.
> You need to use __is_array() and sizeof () for both dest and src.
> You might have meant to check that _src_len is constant, not _dest_len.
> You must not leave the destination unterminated.
> 
> __builtin_object_size(x->y,1) is also entirely useless!
> If you have a pointer to a structure that ends in an array then the
> object size of that array is SIZE_MAX (as if the array continues past
> the end of the structure).
> See https://godbolt.org/z/csenjfvxe (which I happened to prepare earlier today).
> 
> __builtin_object_size(x->y,0) also seems to always return SIZE_MAX.
> You do get a sane answer for (x->y,3) on recent clang - but nowhere else.
> 

Oops, you are right, thanks for pointing that out. This is how it would 
look like checking that both args are arrays and using sizeof to get 
their length, if it sounds good I can apply for the v2:

#define strtostr(dest, src)	do {				\
	const size_t _dest_len = __must_be_array(dest) +	\
				 sizeof(dest);			\
	const size_t _src_len = __must_be_array(src) +		\
				sizeof(src);			\
								\
	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||	\
		     _dest_len == (size_t)-1);			\
	memcpy(dest, src, min(_src_len, _dest_len)));		\
	dest[_dest_len - 1] = '\0';				\
} while (0)


> -- David
> 
> 


