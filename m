Return-Path: <linux-api+bounces-6358-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YM37Epi/DGqJlgUAu9opvQ
	(envelope-from <linux-api+bounces-6358-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 21:52:56 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A245A58459C
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 21:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E880300BC84
	for <lists+linux-api@lfdr.de>; Tue, 19 May 2026 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE4B2BDC1C;
	Tue, 19 May 2026 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="TQqxe7kz"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8DD21D5B0;
	Tue, 19 May 2026 19:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779220063; cv=none; b=Sl53cDKnUjDAt/ZyqsMdpDI6LqUUmN1v+487ie0578qDrRk/O1zkTNVBo24gUjh0DXeXA46vgeREpY1CbJ+iBwuxSGNPargKFLg+Zov/ZLkDWeGPXVhPLxkUdAF3MlkvtZby3xGyScW4RdoEbj7bpIpgxzz5ajRj7FXHjXuncFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779220063; c=relaxed/simple;
	bh=i33o9ezfdH2ITEIPc3x/F45yGlLSi23k912tIvNLUI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsIyNweMIiWmfQwDKlPXIleuwPrCc/Xemh1iAa6CzjfRxOcFHURrjEcXqRy2CD7wbhwdHwPBck7HXmX85LMySZ7z2HVN0XlRjMGDbWfjO87SButOmPFstQXnihGXxi9db1RAqDl5HWcf+Nto21UEZ4PbZjZaIRpE2NY9rmQ2Dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=TQqxe7kz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rulbKwFB5t9+i4HSuYZTS79H6o4XLdanavcWBockdOs=; b=TQqxe7kzHq2AhEgd84M7ojJSag
	MNdlPvAL9a0Ab/tQwxBDtwX3c8xKGXRSsJnfv/AAylGGujR1wYKNiS0eF/Rj7590vLfiUJ9367bL1
	8FEKZLng2C+QWHn5rW6wZFcSeI66yytrlW+6qHbrpBaa9rXaFt1NUOO69OyDSbUqLQrY9bAIFY/Mw
	iqVpsZpF2JFCy2s1GjAPoVFDKQbMHrUWDBlYfUhJwHlWf2B5K5fQRhn1XxOsdVbgzdIIxBZPM1ox3
	cnbxvhYG5NqedMmbGp0zROfn2NkJ4lkC95Z8ORImcQMp0MM3ZyGtIFLR2fp4fRfdFXV0HOCXe6Tnp
	wjlyaeaQ==;
Received: from [179.193.2.40] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wPQPJ-003Mu7-PV; Tue, 19 May 2026 21:47:14 +0200
Message-ID: <471b5b42-974c-441a-9afb-13e1baba5c44@igalia.com>
Date: Tue, 19 May 2026 16:47:05 -0300
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
 <d4d6cf61-568e-478e-88d6-01b769d7eded@igalia.com>
 <20260518193843.7bde8d53@pumpkin>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260518193843.7bde8d53@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6358-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,goodmis.org,kernel.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[godbolt.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,igalia.com:mid,igalia.com:email]
X-Rspamd-Queue-Id: A245A58459C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Em 18/05/2026 15:38, David Laight escreveu:
> On Mon, 18 May 2026 11:36:49 -0300
> André Almeida <andrealmeid@igalia.com> wrote:
> 
>> Hi David, thanks for the feedback!
>>
>> Em 17/05/2026 18:34, David Laight escreveu:
>>> On Sun, 17 May 2026 15:36:13 -0300
>>> André Almeida <andrealmeid@igalia.com> wrote:
>>>    
>>>> Some parts of the kernel uses memcpy() instead of strscpy() because they
>>>> are performance sensitive and doesn't care about the return value of
>>>> strscpy(). One such common case is to copy current->comm to a different
>>>> buffer.
>>>>
>>>> As the command name is guaranteed to be NUL-terminated in the range of
>>>> TASK_COMM_LEN, this is safe enough and doesn't create unterminated
>>>> strings. However, in order to expand the size of current->comm, this
>>>> expectation will be broken and those memcpy() could create such strings
>>>> without trailing NUL byte.
>>>>
>>>> In order to support a fast and safe string copy, create strtostr(), to copy
>>>> a NUL-terminated string to a new string buffer. If the destination buffer
>>>> is bigger than the source, no pad is applied, but the string is
>>>> NUL-terminated. If the destination buffer is smaller, the string is
>>>> truncated. The last byte of the destination is always set to NUL for safety.
>>>>
>>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>>>> ---
>> [...]>> +/**
>>>> + * strtostr - Copy NUL-terminanted string to NUL-terminate string
>>>> + *
>>>> + * @dest: Pointer of destination string
>>>> + * @src: Pointer to NUL-terminates string
>>>> + *
>>>> + * This is a replacement for strcpy() where the caller doesn't care about the
>>>> + * return value and if the string is going to be truncated, albeit it needs
>>>> + * to mark sure that it will be NUL-terminated. Intended for performance
>>>> + * sensitive cases, such as tracing.
>>>
>>> If you care about performance, and the destination isn't smaller (especially
>>> if the sizes are the same) then just use memcpy().
>>>      
>>
>> The problem is that as I'm expanding current->comm, the source buffer
>> might be bigger than destination, and when we truncate the string, it
>> won't have the termination NUL byte. So we need an extra dest[len-1] =
>> \0 after the memcpy.
> 
> It depends on other access to the destination.
> If it might be being concurrently read it is vital that it is always
> terminated.
> So you can't even temporarily have a non-zero byte at the end.
> 

I don't think this is the case here, as far as I can tell all the 
callers of strtostr will wait the end of the copy before using it.

>>
>>>> + *
>>>> + * If the destination is bigger than the source, no padding happens. It it's
>>>> + * smaller the strings gets truncated.
>>>> + *
>>>> + * Both arguments needs to be arrays with lengths discoverable by the compiler.
>>>> + */
>>>> +#define strtostr(dest, src)	do {					\
>>>> +	const size_t _dest_len = __must_be_cstr(dest) +			\
>>>> +				 ARRAY_SIZE(dest);			\
>>>> +	const size_t _src_len = __must_be_cstr(src) +			\
>>>> +				__builtin_object_size(src, 1);		\
>>>> +									\
>>>> +	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||		\
>>>> +		     _dest_len == (size_t)-1);				\
>>>> +	memcpy(dest, src, strnlen(src, min(_src_len, _dest_len)));	\
>>>> +	dest[_dest_len - 1] = '\0';						\
>>>> +} while (0)
>>>
>>> That doesn't work (for all sorts of reasons).
>>> _dest_len can be the size of a pointer - no array check.
>>> You need to use __is_array() and sizeof () for both dest and src.
>>> You might have meant to check that _src_len is constant, not _dest_len.
>>> You must not leave the destination unterminated.
>>>
>>> __builtin_object_size(x->y,1) is also entirely useless!
>>> If you have a pointer to a structure that ends in an array then the
>>> object size of that array is SIZE_MAX (as if the array continues past
>>> the end of the structure).
>>> See https://godbolt.org/z/csenjfvxe (which I happened to prepare earlier today).
>>>
>>> __builtin_object_size(x->y,0) also seems to always return SIZE_MAX.
>>> You do get a sane answer for (x->y,3) on recent clang - but nowhere else.
>>>    
>>
>> Oops, you are right, thanks for pointing that out. This is how it would
>> look like checking that both args are arrays and using sizeof to get
>> their length, if it sounds good I can apply for the v2:
>>
>> #define strtostr(dest, src)	do {				\
>> 	const size_t _dest_len = __must_be_array(dest) +	\
>> 				 sizeof(dest);			\
>> 	const size_t _src_len = __must_be_array(src) +		\
>> 				sizeof(src);			\
>> 								\
>> 	BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||	\
>> 		     _dest_len == (size_t)-1);			\
> 
> That test can never fail.
> 
>> 	memcpy(dest, src, min(_src_len, _dest_len)));		\
>> 	dest[_dest_len - 1] = '\0';				\
> 
> You are expending 'dest' twice.
> Where it (p++)->array then the two values would be different and the final
> value of 'p' incorrect.
> Much better to assign both pointers to local variables.
> Here you can use their required types to get type checking (I wouldn't bother
> about the extra checks that _must_be_cstr() does).
> 

Also, all those memcpy() that I replaced had explicitly the dest size. I 
think I could reuse it for strtostr() to simplify a bit things, what do 
you think?

> I'd also create function that is explicitly for copying process names.
> (Or replace the one that is already there - saves a lot of churn.)
> then you know (and can check) the sizes are the expected ones.
> 

I don't have strong feeling about get_task_comm(), but Linus said that 
"I'd rather aim to get rid of get_task_comm() entirely"[1] so for me 
it's fine to get a new function for that.

[1] 
https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/

> It might even be worth making the #define (needed to get the array sizes)
> call out to different functions for the different cases.
> 
> Thinks more...
> On 64bit the 16 byte copy can be 'load; store; load; mask; store' provided
> the buffer is aligned (copying u64 on 32bit will work the same).
> But that requires that all the buffers be aligned.
> So you'd need to check _Alignof(dest) >= _Alignof(u64) as well.
> (Probably with a fallback to get things to compile.)
> 
> Whether that is best for the longer 64 byte copy is anybodies guess.
> 
> I also suspect it would be best to zero fill when copying a 16 byte
> name into a 64 byte buffer.
> (If you zero fill first then you can just copy 16 bytes over.)
> 
> -- David
> 
>> } while (0)
>>
>>
>>> -- David
>>>
>>>    
>>
> 


