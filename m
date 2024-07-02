Return-Path: <linux-api+bounces-1819-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD170924104
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44E0CB2750E
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037C41B582F;
	Tue,  2 Jul 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FtlD4jZv"
X-Original-To: linux-api@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317CE1E50F;
	Tue,  2 Jul 2024 14:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930949; cv=none; b=IUIQR8wr+d8EhzCl4SCNmO2yO4rgVH4o1fl+qeix6xBRS0DwJrDPub22xB2E3sxxjooLFwuFAa1ke6kjVtY9Om3my8LMEd/S+896H6WMUEdBIFYpI0l1aRJuZjJZpD3p7wvD4mWwwGmlpgBekV9jM1SO205+0PolDf8+1ORuF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930949; c=relaxed/simple;
	bh=WX5kDqC4tJpN29x0TQP8aggg4HMYizhSJ7+/HkfdHwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJeNTn7EwWJRvyfo8mqnx/lMVPXiEhpQYwbsOQ5i82A4k1q9lYoC6xQMP1LufjHHCKPQVcTMLseoF1Rz0k6ECafmD8RSiljr3p7tkJPsj453cpoh0Y7f3s6Nmx0nZ0ccuDVXD5YqgSS7QbnEVLGo8cXK/SQ8gAP1PbNehMCCe9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FtlD4jZv; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719930944;
	bh=WX5kDqC4tJpN29x0TQP8aggg4HMYizhSJ7+/HkfdHwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FtlD4jZvXq217zYnd/L5G9ScVzmrDJTpOBnDM4WKRtXaeZ9tAAh42XBiudMdP+L6c
	 v3PrjxkCa6qkpji5bCsYuot8IdJyhOtPSIsvhgK6HIJr3rx4uumJ1chLTH7RQWqofW
	 YzeBtYcJ6wfsiLTXLjyfZ9LX8jo5z86HBCJwUEsxezJl0wNH/fYxX7aASSdDvhHPWM
	 2byCcOOcQFPQShT4crZ7sMBqIABOjFHAG9HkKugXsJN3sUTHQs3+bE3VVD1/OXP2pA
	 FvOWqhfi6EnnN2fkB8OA995ejiSM+J7tv8fVqUkOiQiIgpGBihmBRkODHR83QkNUJ8
	 WzmdQKdJlItdA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WD5745522z17vy;
	Tue,  2 Jul 2024 10:35:44 -0400 (EDT)
Message-ID: <9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
Date: Tue, 2 Jul 2024 10:36:03 -0400
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
To: Steven Rostedt <rostedt@goodmis.org>, "Dmitry V. Levin" <ldv@strace.io>
Cc: Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
 david@redhat.com, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-4-vdonnefort@google.com>
 <20240630105322.GA17573@altlinux.org>
 <20240630084053.0b506916@rorschach.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240630084053.0b506916@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-30 08:40, Steven Rostedt wrote:
> On Sun, 30 Jun 2024 13:53:23 +0300
> "Dmitry V. Levin" <ldv@strace.io> wrote:
> 
>> On Fri, May 10, 2024 at 03:04:32PM +0100, Vincent Donnefort wrote:
>> [...]
>>> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
>>> index b682e9925539..bd1066754220 100644
>>> --- a/include/uapi/linux/trace_mmap.h
>>> +++ b/include/uapi/linux/trace_mmap.h
>>> @@ -43,4 +43,6 @@ struct trace_buffer_meta {
>>>   	__u64	Reserved2;
>>>   };
>>>   
>>> +#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
>>> +
>>
>> I'm sorry but among all the numbers this one was probably the least
>> fortunate choice because it collides with TCGETS on most of architectures.
> 
> Hmm, that is unfortunate.
> 
>>
>> For example, this is how strace output would look like when
>> TRACE_MMAP_IOCTL_GET_READER support is added:
>>
>> $ strace -e ioctl stty
>> ioctl(0, TCGETS or TRACE_MMAP_IOCTL_GET_READER, {c_iflag=ICRNL|IXON, c_oflag=NL0|CR0|TAB0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=B38400|CS8|CREAD, c_lflag=ISIG|ICANON|ECHO|ECHOE|ECHOK|IEXTEN|ECHOCTL|ECHOKE, ...}) = 0
>>
>> Even though ioctl numbers are inherently not unique, TCGETS is
>> a very traditional one, so it would be great if you could change
>> TRACE_MMAP_IOCTL_GET_READER to avoid this collision.
>>
>> Given that _IO('T', 0x1) is _IOC(_IOC_NONE, 'T', 0x1, 0),
>> something like _IOC(_IOC_NONE, 'T', 0x1, 0x1) should be OK.
> 
> Well, it may not be too late to update this as it hasn't been
> officially released in 6.10 yet. It's still only in the -rc and the
> library doesn't rely on this yet (I've been holding off until 6.10 was
> officially released before releasing the library that uses it).
> 
> I can send a patch this week to update it. Or feel free to send a patch
> yourself.

You need to reserve an unused ioctl Code and Seq# range within:

Documentation/userspace-api/ioctl/ioctl-number.rst

Otherwise this duplicate will confuse all system call instrumentation
tooling.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


