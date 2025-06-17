Return-Path: <linux-api+bounces-3937-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90964ADDF42
	for <lists+linux-api@lfdr.de>; Wed, 18 Jun 2025 00:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E77A2EFA
	for <lists+linux-api@lfdr.de>; Tue, 17 Jun 2025 22:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C19295510;
	Tue, 17 Jun 2025 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBkrJwz9"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732E9220F34;
	Tue, 17 Jun 2025 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750201114; cv=none; b=K9WgMtvLdn8pnNw9NRjCAgim1GOuLqFmZRMymBuCEbLWoWdOa1QyuFGFZmZ6PzWqVrJ9ISy/iF7RCEdTfAY/88tMqB6kX8eN0EbTp2oPnZrYg1aG/p1gkzlloWCWDD15KF7bWPqQJXrgPQMQFCdMW3JzNilXHC8344eeG9kccNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750201114; c=relaxed/simple;
	bh=BdwoZeNM5/0Ep9Pp4VW6C4HoCuzrt5Y/V9ouutt5P94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJCehXunarD6LlPiLA5cETRwG47FaEU+9OVyyDOh/8exjQcvi/sSy8GgtuxyqjGBAxAz3k2uXuQdIu2yG/oUF9OFlhouf5dOYs9kcj7CmAdxgGs8Ls8mJKtahYNHWJeWd3SFxJQF5cCvoxQQIRzLepdS+JJfM61jnaGBxvJA4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBkrJwz9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B6DC4CEE3;
	Tue, 17 Jun 2025 22:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750201114;
	bh=BdwoZeNM5/0Ep9Pp4VW6C4HoCuzrt5Y/V9ouutt5P94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBkrJwz9hXYFjh2NDc3FKTXk24TTZXmrUGleW3w75JH2Qr4XxotNWoPo0gdOUk4J3
	 zvM2xe1JtKF5j8glSdx6uCstHtjJHhmi9CnF7yFKILpb6J2k2z+Muy5B2gUOytjgwF
	 3ciCKG6iQ5Hsp8R82WGd3kygik5Px5FjgV9SlgcdFuoeG2pDJBYGtbMJMg+1k+jDxf
	 fElbEUgGVM2q7tseIuIs35KgO5tw+VxCNK2Nz9bSrKAL8QC9b0/6MfWYxdMr0OHBWX
	 nWm4SRSq7sSJbT0MkNILVc8PKsDrqFaruFrb9Ykz8m4fry0LzbcuPc0a6Z5pIJztrw
	 VgYNcZsCSyW5A==
Date: Tue, 17 Jun 2025 18:58:32 -0400
From: Sasha Levin <sashal@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC 08/19] exec: add API specification for execve
Message-ID: <aFHzGBsf5RAQtttc@lappy>
References: <20250614134858.790460-1-sashal@kernel.org>
 <20250614134858.790460-9-sashal@kernel.org>
 <87ikkvv018.fsf@oldenburg.str.redhat.com>
 <aFDKHhaqB75Qi212@lappy>
 <87y0tqu9g7.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87y0tqu9g7.fsf@oldenburg.str.redhat.com>

On Tue, Jun 17, 2025 at 09:13:44AM +0200, Florian Weimer wrote:
>* Sasha Levin:
>
>> On Mon, Jun 16, 2025 at 11:39:31PM +0200, Florian Weimer wrote:
>>>* Sasha Levin:
>>>
>>>> +	KAPI_RETURN("long", "Does not return on success; returns -1 on error")
>>>> +		.type = KAPI_TYPE_INT,
>>>> +		.check_type = KAPI_RETURN_ERROR_CHECK,
>>>> +	KAPI_RETURN_END
>>>
>>>Is the -1 part correct?
>>
>> Maybe :) That's one of the things I wasn't sure about: we're documenting
>> the execve syscall rather than the function itself. A user calling
>> execve() will end up with -1 on failure, and errno set with the error
>> code.
>
>Well, it doesn't say execve, it says sys_execve.
>
>> You could argue that it's libc that sets errno and we're trying to spec
>> the kernel here, not the userspace interface to it.
>
>And I think this would be appropriate.
>
>Note that in the future, the glibc version of execve will not be a
>straightforward system call wrapper because we need to obtain a
>consistent snapshot of the environment array.  That is actually pretty
>hard because we cannot atomically replace the process image, unblock
>signals, and unmap a copy of the environment.
>
>So I think it's best for the kernel to stick with the system call
>interface and not try to document what libcs are doing.

I hear you - it sounds like the "right" solution technically.


Switching back to signals, how does something like the below look as far
as expanding the execve() spec:

+       /* SIGSEGV sent on point of no return failure */
+       KAPI_SIGNAL(9, SIGSEGV, "SIGSEGV", KAPI_SIGNAL_SEND, KAPI_SIGNAL_ACTION_COREDUMP)
+               KAPI_SIGNAL_TARGET("Current process")
+               KAPI_SIGNAL_CONDITION("Exec fails after point of no return")
+               KAPI_SIGNAL_DESC("If exec fails after the point of no return (when the old "
+                                "process image has been destroyed), force_fatal_sig(SIGSEGV) "
+                                "is called to terminate the process since it cannot continue.")
+               KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_EXIT)
+               KAPI_SIGNAL_PRIORITY(0)
+               KAPI_SIGNAL_STATE_FORBID(KAPI_SIGNAL_STATE_ZOMBIE | KAPI_SIGNAL_STATE_DEAD)
+       KAPI_SIGNAL_END
+
+       /* Signal mask preserved */
+       KAPI_SIGNAL(10, 0, "SIGNAL_MASK", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_CUSTOM)
+               KAPI_SIGNAL_CONDITION("Process has blocked signals")
+               KAPI_SIGNAL_DESC("The signal mask (blocked signals) is preserved across exec. "
+                                "This allows processes to block signals before exec and have "
+                                "them remain blocked in the new program.")
+               KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+       KAPI_SIGNAL_END
+
+       /* Realtime signal queues cleared */
+       KAPI_SIGNAL(11, 0, "REALTIME_SIGNALS", KAPI_SIGNAL_HANDLE, KAPI_SIGNAL_ACTION_DISCARD)
+               KAPI_SIGNAL_CONDITION("Realtime signals queued")
+               KAPI_SIGNAL_DESC("All queued realtime signals (SIGRTMIN to SIGRTMAX) are "
+                                "discarded during exec. The realtime signal queue is cleared.")
+               KAPI_SIGNAL_TIMING(KAPI_SIGNAL_TIME_DURING)
+               KAPI_SIGNAL_QUEUE(KAPI_SIGNAL_QUEUE_REALTIME)
+       KAPI_SIGNAL_END

What's missing for me is that while we now go into more detail, we
should also check this during runtime, but I'm still trying to come up
with something that is not ugly.

-- 
Thanks,
Sasha

