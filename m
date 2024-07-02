Return-Path: <linux-api+bounces-1822-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7678F924272
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0541D1F21949
	for <lists+linux-api@lfdr.de>; Tue,  2 Jul 2024 15:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934BF1BBBD9;
	Tue,  2 Jul 2024 15:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="h2n2xVeH"
X-Original-To: linux-api@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FA1AD9E7;
	Tue,  2 Jul 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719934358; cv=none; b=MDxhIMAQEOeaSTy1PlvtKQJB+dWoT2ffgovXKqgw2IHZSqtN4d1pmpWBxhJws1+NRQ1KCUeBMdI8M2TcKENdQr+OokVA0aaJVDJe89HlMjwS28zEmkuf2d7c0+qCqOMmpIDxe0CH21f1TkTdXn/zCu8jlWyvB9fKnkVpO+FefUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719934358; c=relaxed/simple;
	bh=QwdTvN2w8magt7NV4w0a71FnxDWn0zOLPn5PX026wl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Na58O1Zq13M9YnVoWXJ2UrJu0Jtk6tGWXqzQz84BFL1jQKc48N4XQZkEnXshfvx38PY86WC8rSApRBMZ+fdNcqX0+i0WuTitgMFVRJvuV+TGMDppuZv7vNxrX70AYn+FsxFIxG71wd+ysO4Yu3sFMVDG2V6g3TNRWtrsjCDRKCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=h2n2xVeH; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1719934355;
	bh=QwdTvN2w8magt7NV4w0a71FnxDWn0zOLPn5PX026wl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h2n2xVeHYDmTWHWbKVMllVb6cRZHs5fiOSf7bi9PYgEEZVm8jkjVKod71hfQo6A8h
	 XOtbqnDjrQM199DOGtUHU0k+x0qCU/Jk+9MmKQu4Yzyms6RZI33rgZpgM79N3JvsmF
	 0JLefZAE/V21nGW2O1ueXJci2nWV0F6nGXj2gtVI0CwhvGn7RAf7sUrxlOi2w8lgGi
	 dFCUWA6NSwRAjSanmGa5gOymcS3If55BMuGO0XHrC061gV/UkyzJB8F5ZFvyU7PAnn
	 A6DFpOp+4p69y/H6tG8L9YXTRWZ6BLlN6asisrhYM3jRxKDQZELszKKzYq2VXEGBSo
	 8Bzgy9TUScy5A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WD6Ng1CKcz187J;
	Tue,  2 Jul 2024 11:32:35 -0400 (EDT)
Message-ID: <cb02f5a0-d6a3-4228-9cbb-473fd392ee48@efficios.com>
Date: Tue, 2 Jul 2024 11:32:53 -0400
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v23 3/5] tracing: Allow user-space mapping of the
 ring-buffer
To: Steven Rostedt <rostedt@goodmis.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Cc: "Dmitry V. Levin" <ldv@strace.io>,
 Vincent Donnefort <vdonnefort@google.com>, mhiramat@kernel.org,
 kernel-team@android.com, rdunlap@infradead.org, rppt@kernel.org,
 david@redhat.com, linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <20240510140435.3550353-1-vdonnefort@google.com>
 <20240510140435.3550353-4-vdonnefort@google.com>
 <20240630105322.GA17573@altlinux.org>
 <20240630084053.0b506916@rorschach.local.home>
 <9a9c8ea4-8e17-4e7e-95fe-7b51441a228c@efficios.com>
 <20240702111807.13d2dd2c@rorschach.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240702111807.13d2dd2c@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-02 11:18, Steven Rostedt wrote:
> On Tue, 2 Jul 2024 10:36:03 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>>> I can send a patch this week to update it. Or feel free to send a patch
>>> yourself.
>>
>> You need to reserve an unused ioctl Code and Seq# range within:
>>
>> Documentation/userspace-api/ioctl/ioctl-number.rst
> 
> Ug, it's been so long, I completely forgot about that file.
> 
> Thanks for catching this.
> 
>>
>> Otherwise this duplicate will confuse all system call instrumentation
>> tooling.
> 
> Agreed, what if we did this then:
> 
> -- Steve
> 
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index a141e8e65c5d..9a97030c6c8d 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -186,6 +186,7 @@ Code  Seq#    Include File                                           Comments
>   'Q'   all    linux/soundcard.h
>   'R'   00-1F  linux/random.h                                          conflict!
>   'R'   01     linux/rfkill.h                                          conflict!
> +'R'   20-2F  linux/trace_mmap.h
>   'R'   C0-DF  net/bluetooth/rfcomm.h
>   'R'   E0     uapi/linux/fsl_mc.h
>   'S'   all    linux/cdrom.h                                           conflict!
> diff --git a/include/uapi/linux/trace_mmap.h b/include/uapi/linux/trace_mmap.h
> index bd1066754220..c102ef35d11e 100644
> --- a/include/uapi/linux/trace_mmap.h
> +++ b/include/uapi/linux/trace_mmap.h
> @@ -43,6 +43,6 @@ struct trace_buffer_meta {
>   	__u64	Reserved2;
>   };
>   
> -#define TRACE_MMAP_IOCTL_GET_READER		_IO('T', 0x1)
> +#define TRACE_MMAP_IOCTL_GET_READER		_IO('R', 0x20)

Note that user events also has this issue: the ioctl is not reserved in
the ioctl-number.rst list. See include/uapi/linux/user_events.h:

#define DIAG_IOC_MAGIC '*'

/* Request to register a user_event */
#define DIAG_IOCSREG _IOWR(DIAG_IOC_MAGIC, 0, struct user_reg *)

/* Request to delete a user_event */
#define DIAG_IOCSDEL _IOW(DIAG_IOC_MAGIC, 1, char *)

/* Requests to unregister a user_event */
#define DIAG_IOCSUNREG _IOW(DIAG_IOC_MAGIC, 2, struct user_unreg*)

Where '*' maps to Code 0x2A. Looking at the list I don't see any
conflicts there, but we should definitely add it.

If we use '*' for user events already, perhaps we'd want to consider
using the same range for the ring buffer ioctls ? Arguably one is
about instrumentation and the other is about ring buffer interaction
(data transport), but those are both related to tracing.

Thanks,

Mathieu

>   
>   #endif /* _TRACE_MMAP_H_ */

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


