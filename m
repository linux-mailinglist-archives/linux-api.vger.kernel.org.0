Return-Path: <linux-api+bounces-6452-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Pu3JyXJGWpXzAgAu9opvQ
	(envelope-from <linux-api+bounces-6452-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 19:13:09 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 162B9606338
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 19:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA753335E58C
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 16:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6B53F1AD1;
	Fri, 29 May 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cF9LekIV"
X-Original-To: linux-api@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB91F3EFFD5;
	Fri, 29 May 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780073061; cv=none; b=RaD2UIXAEvRLUpQlAhY5i+Cxz73dsbCN1Je1uQaU5NxanuDlLZaLI1LJ0u5MCUibiegSdiJBKjyg8HXftK7jv+MCf+fwwMOMayo3wVij9VSI2qMWncxX1liw1t8t7XTDxKMeXIK0kCyDZR1vIpdzFstOGLivG6J9gjxLQrCuQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780073061; c=relaxed/simple;
	bh=TFY3wcbjavobRXt8V3AJbaXza2LRIuQUPXVLp2tD5e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwBkQn5WtkzIvxf+Z0Dl3JDFtnstPkInDyhkImWVjVihNpvgkjcXlvZ2giGNT0dwtTCX7M/8JjYf1kEZiOl5IxckBLnrIwGMYAqW05Vj8zWD8nWdvItAnS9CDcCbCHx+HYStMyUvQPQKMjBU0gWMI6eqg6PBPvvFReA8+zDz5ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cF9LekIV; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vjSZpRRKFfq6gFxbgWO1ruANO7yleaf1A8CefXQR1II=; b=cF9LekIVsQvhOQcmC5OwaE8co8
	IpKFGDbwPmvmtYdWvDuQa0fI2iOe2CDy+bThTpd5R5rjOBJyR1SX7qZWTUWY4EjjPT73n1ic6+Tbm
	8a8SnmSDlVXboU+sN1sUu9W62v2F5vhfEQpgiCBoc2a5iKaEmXaVaflqKLZGWa1KgaTI163RnRjQB
	mxkLC0/9KTdn0LiZ3a5TQ6xdx3e0uQP78N1pCW/wlYsaSZ5FLF9FMwJUE+z2gRF14jz/xQnt8FfHh
	hPD4PiErj6dzAqTcvu+vWS2OgwSZqikTTlss7KiUzt5B6PtgvKnLwC0mrOFsD/yUI9oKg4Km98zWx
	HJohMJNQ==;
Received: from [179.118.191.12] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wT0JV-009x66-G6; Fri, 29 May 2026 18:44:01 +0200
Message-ID: <2a7566cd-3d64-40f9-b746-ac8ca0409846@igalia.com>
Date: Fri, 29 May 2026 13:43:51 -0300
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] sched: Extend task command name to 64 bytes
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Shuah Khan <shuah@kernel.org>, willy@infradead.org,
 Steven Rostedt <rostedt@goodmis.org>, mathieu.desnoyers@efficios.com,
 Linus Torvalds <torvalds@linux-foundation.org>, akpm@linux-foundation.org,
 Yafang Shao <laoar.shao@gmail.com>, andrii.nakryiko@gmail.com,
 arnaldo.melo@gmail.com, Petr Mladek <pmladek@suse.com>,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com, linux-mm@kvack.org,
 linux-api@vger.kernel.org, Bhupesh <bhupesh@igalia.com>
References: <20260524-tonyk-long_name-v2-0-332f6bd041c4@igalia.com>
 <20260524-tonyk-long_name-v2-4-332f6bd041c4@igalia.com>
 <20260525114107.7fa5b4c1@pumpkin> <20260525114241.4b6f3050@pumpkin>
 <20260526123103.4facbaed@gandalf.local.home>
 <20260527094221.2f5b49d9@pumpkin>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20260527094221.2f5b49d9@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6452-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	NEURAL_HAM(-0.00)[-0.751];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrealmeid@igalia.com,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,linaro.org,kernel.org,goodmis.org,efficios.com,linux-foundation.org,gmail.com,suse.com,vger.kernel.org,igalia.com,kvack.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,goodmis.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 162B9606338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Em 27/05/2026 05:42, David Laight escreveu:
> On Tue, 26 May 2026 12:31:03 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Mon, 25 May 2026 11:42:41 +0100
>> David Laight <david.laight.linux@gmail.com> wrote:
>>
>>>>>   	error = security_task_prctl(option, arg2, arg3, arg4, arg5);
>>>>> @@ -2601,16 +2601,16 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>>>>>   			error = -EINVAL;
>>>>>   		break;
>>>>>   	case PR_SET_NAME:
>>>>> -		comm[sizeof(me->comm) - 1] = 0;
>>>>> +		comm[TASK_COMM_LEN - 1] = 0;
>>>>>   		if (strncpy_from_user(comm, (char __user *)arg2,
>>>>> -				      sizeof(me->comm) - 1) < 0)
>>>>> +				      TASK_COMM_LEN - 1) < 0)
>>>>
>>>> Nak - you can't do that.
>>>> You are reading data that the application doesn't expect you to read.
>>>
>>> Or have I got confused over the names...
>>
>> You may have gotten confused by names, as sizeof(me->comm) is the same as
>> TASK_COMM_LEN. Basically, the above doesn't change anything.
> 
> The name of the patch doesn't help:
> 	sched: Extend task command name to 64 bytes
> 

well, I will try to make it clear next time :)


> If you want to catch/check all the uses I suspect that all the
> occurrences of TASK_COMM_LEN need changing.
> For clarity this one should probably be TASK_COMM_LEN_OLD.
> (that might be problematic for the uapi headers)
> 

That works for me as well, and I don't see TASK_COMM_LEN being used at 
include/uapi/.

> -- David
> 
>>
>> -- Steve
> 


