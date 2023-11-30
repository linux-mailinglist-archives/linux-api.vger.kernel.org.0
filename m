Return-Path: <linux-api+bounces-192-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE67D7FFA9C
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 20:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BB3280F75
	for <lists+linux-api@lfdr.de>; Thu, 30 Nov 2023 19:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5470F5FEEC;
	Thu, 30 Nov 2023 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Erxk7VjU"
X-Original-To: linux-api@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A996ED48;
	Thu, 30 Nov 2023 11:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1701370803;
	bh=BObGTsR9eRsXFgPPmYkraabswwf/jPu4KRxicRxkChU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Erxk7VjUY2Kbt018z3ZmFmTM9vr57N350YYaSOx5StFL+loZ7obXN/CNymA3OUi8T
	 388Ir8uxLj1GE86rTpqPOEzLpI0x7yuMoEnxKS4yAH7GwMhQCA0mY2ebt+Sz7vkvDr
	 VbMs9YowhH0VKhDjK86puxnrTcLKlkuwtPmoJu+e7LvUmHqeJ0lJAaSP1prXJS9weE
	 TOqzp2Cy7Kxk+mrdbkVgau10xt7CGFw9N3UoPQR7wISQUhbYS9SDr+X6mCxcB/A3+/
	 9mD9SP+BbbEAk72WUbla8U+hnZvb3DOOpbYtO7236++YFJiOvYqZxwbqx1U2OQHkIM
	 ftg5W9IHkxg9w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sh59H21LLz1f02;
	Thu, 30 Nov 2023 14:00:03 -0500 (EST)
Message-ID: <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
Date: Thu, 30 Nov 2023 14:00:01 -0500
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
Content-Language: en-US
To: Tycho Andersen <tycho@tycho.pizza>, Florian Weimer <fweimer@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 "Eric W . Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, Tycho Andersen <tandersen@netflix.com>
References: <20231130163946.277502-1-tycho@tycho.pizza>
 <874jh3t7e9.fsf@oldenburg.str.redhat.com> <ZWjaSAhG9KI2i9NK@tycho.pizza>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <ZWjaSAhG9KI2i9NK@tycho.pizza>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-30 13:54, Tycho Andersen wrote:
> On Thu, Nov 30, 2023 at 07:37:02PM +0100, Florian Weimer wrote:
>> * Tycho Andersen:
>>
>>> From: Tycho Andersen <tandersen@netflix.com>
>>>
>>> We are using the pidfd family of syscalls with the seccomp userspace
>>> notifier. When some thread triggers a seccomp notification, we want to do
>>> some things to its context (munge fd tables via pidfd_getfd(), maybe write
>>> to its memory, etc.). However, threads created with ~CLONE_FILES or
>>> ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
>>> purpose, since their fd table or mm are distinct from the thread group
>>> leader's. In this patch, we relax this restriction for pidfd_open().
>>
>> Does this mean that pidfd_getfd cannot currently be used to get
>> descriptors for a TID if that TID doesn't happen to share its descriptor
>> set with the thread group leader?
> 
> Correct, that's what I'm trying to solve.
> 
>> I'd like to offer a userspace API which allows safe stashing of
>> unreachable file descriptors on a service thread.
> 
> By "safe" here do you mean not accessible via pidfd_getfd()?

For the LTTng-UST use-case, we need to be able to create and
use a file descriptor from an agent thread injected within the target
process in a way that is safe against patterns where the application
blindly close all file descriptors (for-loop doing close(2),
closefrom(2) or closeall(2)).

The main issue here is that even though we could handle errors
(-1, errno=EBADF) in the sendmsg/recvmsg calls, re-use of a file
descriptor by the application can lead to data corruption, which
is certainly an unwanted consequence.

AFAIU glibc has similar requirements with respect to io_uring
file descriptors.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


