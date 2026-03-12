Return-Path: <linux-api+bounces-5937-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEM4FqLBsmmvPAAAu9opvQ
	(envelope-from <linux-api+bounces-5937-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 14:37:38 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1339272B7C
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 14:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68FE130870F6
	for <lists+linux-api@lfdr.de>; Thu, 12 Mar 2026 13:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4D375F88;
	Thu, 12 Mar 2026 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gnU7sgX+"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6FC287247;
	Thu, 12 Mar 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322654; cv=none; b=M5nOrS9EMvN78pM6bMLKVnnJYRLWJ2RRYxxO0lV74taxWmTI9vqlotNaGiz7MxPZgTMG/HCM0D7JGWa6eqKlHKfUo+NipGUht/JUEZFcKd3ZNgl8YwNHw9wMjQekwPZzCvm8K0yXbhhnFgAIZ9qBmygNvU0KnNllPwtIIPM4Fss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322654; c=relaxed/simple;
	bh=W/3UFYIepCKQNDtRw7KGgna9mxPbYPPxgbvCola4FIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZc+404MZT+BYc9Jv3W/v7l9qY1Z4+t2DrbipLcV1U7qOp69WgB3xZifrO1fqtQEgYQUeqP9zpaJsRwXCcHXCrx4EPkm1Rgqh4UHTMsAyg0ly+23rMXTFdVRqA/w1TwPyaz/88Dqbeq4EnHpbFfjolAl0Hu+uwy2g/OYcKXYcRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gnU7sgX+; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=QW/VJ5bXYT9+L2/lKaOGraKsrdVJllj+7+KwPHSB56E=; b=gnU7sgX+CMrostikPINY0eG1gJ
	1INgJK04QTFcfB+uuFS65uojx5gsaWzxDqUsVGH6HoW6Bmo80/ibIeQkM+/TEKJPWaS4/C+DmTJBy
	G7X9rsvnCMzF5+vtVrppljX9rChENuA2U/PLh7eAvnLiiERCYHBhNY7p/J/e7jFyjtZeJEKAVmhh6
	/cqrmexhExqw7tU5zwexHc5Zn18uTVPzVRw30bWymZ1Og8C+URG0ldcfcxqTzccGYtYnxck0vTeP/
	3yO5kRao7etThNNakXD7FBIPN1z/SCipmkfGYECayw8A4PGqQrdcxh+py8/Ar771CLL4lOfMSzMqz
	B96Wh6lw==;
Received: from [187.57.51.179] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w0gDe-00EWDd-6d; Thu, 12 Mar 2026 14:36:54 +0100
Message-ID: <a4ce33c5-af38-4f50-9358-056950a67b43@igalia.com>
Date: Thu, 12 Mar 2026 10:36:47 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH 1/2] futex: Create reproducer for robust_list race
 condition
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, Florian Weimer <fweimer@redhat.com>,
 Rich Felker <dalias@aerifal.cx>, Torvald Riegel <triegel@redhat.com>,
 Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, kernel-dev@igalia.com,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260220202620.139584-1-andrealmeid@igalia.com>
 <20260220202620.139584-2-andrealmeid@igalia.com>
 <20260312090445.4Zabebfp@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260312090445.4Zabebfp@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5937-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[igalia.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.428];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1339272B7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Em 12/03/2026 06:04, Sebastian Andrzej Siewior escreveu:
> On 2026-02-20 17:26:19 [-0300], André Almeida wrote:
>> --- /dev/null
>> +++ b/robust_bug.c
> …
>> +	new->value = ((uint64_t) value << 32) + value;
>> +
>> +	/* Create a backup of the current value */
>> +	original_val = new->value;
> 
> Now that I finally got it and I might have understood the issue.
> 
> You exit before unlocking the futex. You free this block and this new
> memory (address) is the same as the old one. Your corruption comes from
> the fact that the old content is the same as the new content.
> 
> If the thread does unlock in userland (or kernel) but the lock remains
> on the robust_list while it gets killed then the kernel will attempt to
> unlock the lock. But this requires that the futex value matches the
> value.
> So if it is unlocked (0x0) or used again then nothing happens. Unless
> the new memory gets the same value assigned as the pid value by
> accident. Then it gets changed…
> 
> If the unlock did not happen and is still owned by the thread, that is
> killed, then the "fixup" here is the right thing to do. The memory
> should not be free()ed because the lock was still owned by the thread.
> The misunderstanding here might be "once the thread is gone, the lock is
> free we can throw away the memory". At the very least, it was a locked
> mutex and I think pthread_mutex_destroy() would complain here.
> 
> So is the issue here that the "new" value is the same as the "old" value
> and the robust-death-handle part in the kernel does its job? Or did I
> over simplify something?
> Let me continue with the thread…
> 

Yes, this is exactly what I understood as well.

User thread A releases the lock, but exits before setting op_pending = 
NULL. Thread B can free the lock after using it, and by chance needs to 
use the same value as the PID in the same memory. Then thread A do the 
robust list handle inside the kernel and the corruption happens.

