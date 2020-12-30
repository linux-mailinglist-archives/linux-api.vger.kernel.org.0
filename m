Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146BB2E7C33
	for <lists+linux-api@lfdr.de>; Wed, 30 Dec 2020 20:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgL3Tvl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Dec 2020 14:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgL3Tvl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Dec 2020 14:51:41 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94127C061573;
        Wed, 30 Dec 2020 11:51:00 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jx16so23090566ejb.10;
        Wed, 30 Dec 2020 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mKxK7c/i9edMW2MkDUdzuhwXiBdPDjRFgTh0pB6nplY=;
        b=DICzUnxEGmUqq5BUt3Dn44W4zx+bNXZavMLQF1Tq/SwYxm8vpgW2Bzdu09KIVr4ldl
         Q8d8DjKePACY1ZvuxOi1hKCuLtfydLn0sYIBbY56ICd2voAvlQLLhLX2wxpwA+mWR3HD
         K2VvtlLeFYEeRMhGQsDeXWHazJPZf+j5CT3tazh74VjnsBOHfyzjYvTCkPwNo2c4NcGJ
         /TWWGa3emUfJ5wgXvbFn0vXjO00dU2pcW8LzdVAVKD3hblLYR9krdFAUj7ibRMrZBT2B
         EfJd4pqwmz3OZ+qO44YlXoXR2GJmUtnZ45lnmYbM5sMPL3BUQkbPub0iI4QBJCm/cb/+
         BEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mKxK7c/i9edMW2MkDUdzuhwXiBdPDjRFgTh0pB6nplY=;
        b=jXJhUPKgLqSAaFoPrunTtR9V2IFAYQXq7kRybWe03pm/amZOG5mBAD2z/WBBrvDLrT
         825IAgxjPXJkYiC6ZUD7lXZ/Tp1OYXu4rLTrl31+/QBhP1bgfbHm9z6SzaOI/qS+SEy7
         UXFpZvZToISQK5x48xSb98m1/ZSPDs3v7jpxOraDrwzTV7iINjFNfs9K3EgN/Iv/b/EZ
         UILCci1Jj+mfMc7E06pY7gQaum3s+XmCwXHpySiXjflpyIDHplWn7qJYru0OVo4WdIDa
         iTxXUWpyTudiH9/jVNTDRu+zq4qDzn91vFu61VRR049yScY8ZNwnNJEQMbMI11GSF+Wo
         PUVA==
X-Gm-Message-State: AOAM533IeX+mUWuCAIeyPPyOFkyzuHIFKblxBjUykAI/sX5++ED6oCrf
        cbhTKfgKEmYNNtkDepIyif/yB3my7jk=
X-Google-Smtp-Source: ABdhPJxgjnpv3aZLEziOblUKIaU/V5SyHkNTA12+kYzv1Sn1T7pb2q9kvFnEIb0LGqqvP/vIEshVLQ==
X-Received: by 2002:a17:906:8617:: with SMTP id o23mr50669718ejx.274.1609357858877;
        Wed, 30 Dec 2020 11:50:58 -0800 (PST)
Received: from ?IPv6:2001:a61:2467:2f01:faca:3d43:5e40:30d1? ([2001:a61:2467:2f01:faca:3d43:5e40:30d1])
        by smtp.gmail.com with ESMTPSA id v18sm38390214edx.30.2020.12.30.11.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Dec 2020 11:50:57 -0800 (PST)
Cc:     mtk.manpages@gmail.com, alx.manpages@gmail.com,
        linux-man@vger.kernel.org, kernel@collabora.com,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v6] prctl.2: Document Syscall User Dispatch
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
References: <20201228173832.347794-1-krisman@collabora.com>
 <5da9a8bc-e034-1ab4-3f87-328108c1b27d@gmail.com>
 <87wnwz5jae.fsf@collabora.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <c9ebe73d-b75e-b3a6-a435-577bfd4a92e1@gmail.com>
Date:   Wed, 30 Dec 2020 20:50:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <87wnwz5jae.fsf@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[CC += linux-api]

Hi Gabriel,

On 12/30/20 5:51 PM, Gabriel Krisman Bertazi wrote:
> "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com> writes:
> 
>> Hello Gabriel
>>
>> This is looking much better. Thank you! I have a few more
>> comments still.
>>
>> On 12/28/20 6:38 PM, Gabriel Krisman Bertazi wrote:
>>> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>>>
>>> ---
>>> Changes since v5:
>>> (suggested by Michael Kerrisk)
>>>   - Change () punctuation
>>>   - fix grammar
>>>   - Add information about interception, return and return value
>>>
>>> Changes since v4:
>>> (suggested by Michael Kerrisk)
>>>   - Modify explanation of what dispatch to user space means.
>>>   - Drop references to emulation.
>>>   - Document suggestion about placing libc in allowed-region.
>>>   - Comment about avoiding syscall cost.
>>> Changes since v3:
>>> (suggested by Michael Kerrisk)
>>>   - Explain what dispatch to user space means.
>>>   - Document the fact that the memory region is a single consecutive
>>>   range.
>>>   - Explain failure if *arg5 is set to a bad value.
>>>   - fix english typo.
>>>   - Define what 'invalid memory region' means.
>>>
>>> Changes since v2:
>>> (suggested by Alejandro Colomar)
>>>   - selective -> selectively
>>>   - Add missing oxford comma.
>>>
>>> Changes since v1:
>>> (suggested by Alejandro Colomar)
>>>   - Use semantic lines
>>>   - Fix usage of .{B|I}R and .{B|I}
>>>   - Don't format literals
>>>   - Fix preferred spelling of userspace
>>>   - Fix case of word
>>> ---
>>>  man2/prctl.2 | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 159 insertions(+)
>>>
>>> diff --git a/man2/prctl.2 b/man2/prctl.2
>>> index f25f05fdb593..0a0abfb78055 100644
>>> --- a/man2/prctl.2
>>> +++ b/man2/prctl.2
>>> @@ -1533,6 +1533,135 @@ For more information, see the kernel source file
>>>  (or
>>>  .I Documentation/arm64/sve.txt
>>>  before Linux 5.3).
>>> +.TP
>>> +.\" prctl PR_SET_SYSCALL_USER_DISPATCH
>>> +.\" commit 1446e1df9eb183fdf81c3f0715402f1d7595d4
>>> +.BR PR_SET_SYSCALL_USER_DISPATCH " (since Linux 5.11, x86 only)"
>>> +.IP
>>> +Configure the Syscall User Dispatch mechanism
>>> +for the calling thread.
>>> +This mechanism allows an application
>>> +to selectively intercept system calls
>>> +so that they can be handled within the application itself.
>>> +Interception takes the form of a thread-directed
>>> +.B SIGSYS
>>> +signal that is delivered to the thread
>>> +when it makes a system call.
>>> +If intercepted,
>>> +the system call is not executed by the kernel.
>>> +.IP
>>> +The current Syscall User Dispatch mode is selected via
>>> +.IR arg2 ,
>>> +which can either be set to
>>> +.B PR_SYS_DISPATCH_ON
>>> +to enable the feature,
>>> +or to
>>> +.B PR_SYS_DISPATCH_OFF
>>> +to turn it off.
>>
>> So, I realize now that I'm slightly confused.
>>
>> The value of arg2 can be either PR_SYS_DISPATCH_ON or
>> PR_SYS_DISPATCH_OFF. The value of the selector pointed to by
>> arg5 can likewise be R_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.
>> What is the relationship between these two attributes? For example,
>> what does it mean if arg2 isP R_SYS_DISPATCH_ON and, at the time of
>> the prctl() call, the selector has the value PR_SYS_DISPATCH_OFF?
> 
> Hi Michael,
> 
> arg2 turns SUD on and off, thread-wide.  arg5 is what is used to filter
> syscalls when SUD is on.  Based on the value of arg5, syscalls will be
> intercepted, iff SUD is enabled for that thread.

Okay -- I suspected as much, but I wanted to confirm.

So, I want to say that in API design terms this feels wrong. You 
are using the same name(s) to mean two different things:
1. Define/clear SUD/the non-SUD memory region
2. Enable/disable SUD filtering in the SUD memory region (i.e., the 
part of the virtual address space outside the region defined in 1).

My terms here may not be the best, but I guess the distinction that
I make is clear.

My point is that these are different things, and I think they 
really should have different names (though of course the numbers
could stay the same). Otherwise, people fall into the confusion
that I ran into. Given that this feature is not yet released, and
that the numbers don't need to change, I'd like to suggest that
the names should change before 5.11 is released

For arg2, maybe:
    PR_SYS_DISPATCH_SET_REGION / PR_SYS_DISPATCH_CLEAR_REGION
or
    PR_SYS_DISPATCH_SET / PR_SYS_DISPATCH_CLEAR
or
    PR_SYS_DISPATCH_ON / PR_SYS_DISPATCH_OFF

For the selector (pointed to by arg5), maybe stay with what you
have:

    PR_SYS_DISPATCH_ON / PR_SYS_DISPATCH_OFF

or (maybe better, and would also fit well with keeping
arg2 as PR_SYS_DISPATCH_ON / PR_SYS_DISPATCH_OFF):

    PR_SYS_DISPATCH_FILTER_ON / PR_SYS_DISPATCH_FILTER_OFF

Do you see what I mean? We live with APIs for a long time, and I
think it serves us to make them as clear as possible.

Thanks,

Michael



> 
> arg5 is checked only upon syscall entry, so it doesn't have any effect
> on the prctl itself, SUD was off at that time.
> 
> I'm not sure how to add this information to the man page, but I will try
> to clarify it further.
> 
>>> +.IP
>>> +When
>>> +.I arg2
>>> +is set to
>>> +.BR PR_SYS_DISPATCH_ON ,
>>> +.I arg3
>>> +and
>>> +.I arg4
>>> +respectively identify the
>>> +.I offset
>>> +and
>>> +.I length
>>> +of a single contiguous memory region in the process map
>>
>> Better: s/map/address space/ ?
>>
>>> +from where system calls are always allowed to be executed,
>>> +regardless of the switch variable
>>
>> s/variable/variable./
>>
>>> +(Typically, this area would include the area of memory
>>> +containing the C library.)
>>
>> I think just to ease readability (smaller paragraphs), insert
>> .IP
>> here.
>>
>>> +.I arg5
>>> +points to a char-sized variable
>>> +that is a fast switch to enable/disable the mechanism
>>> +without the overhead of doing a system call.
>>> +The variable pointed by
>>> +.I arg5
>>> +can either be set to
>>> +.B PR_SYS_DISPATCH_ON
>>> +to enable the mechanism
>>> +or to
>>> +.B PR_SYS_DISPATCH_OFF
>>> +to temporarily disable it.
>>> +This value is checked by the kernel
>>> +on every system call entry,
>>> +and any unexpected value will raise
>>> +an uncatchable
>>> +.B SIGSYS
>>> +at that time,
>>> +killing the application.
>>> +.IP
>>> +When a system call is intercepted,
>>> +the kernel sends a thread-directed
>>> +.B SIGSYS
>>> +signal to the triggering thread.
>>> +Various fields will be set in the
>>> +.I siginfo_t
>>> +structure (see
>>> +.BR sigaction (2))
>>> +associated with the signal:
>>> +.RS
>>> +.IP * 3
>>> +.I si_signo
>>> +will contain
>>> +.BR SIGSYS .
>>> +.IP *
>>> +.IR si_call_addr
>>> +will show the address of the system call instruction.
>>> +.IP *
>>> +.IR si_syscall
>>> +and
>>> +.IR si_arch
>>> +will indicate which system call was attempted.
>>> +.IP *
>>> +.I si_code
>>> +will contain
>>> +.BR SYS_USER_DISPATCH .
>>> +.IP *
>>> +.I si_errno
>>> +will be set to 0.
>>> +.RE
>>> +.IP
>>> +The program counter will be as though the system call happened
>>> +(i.e., the program counter will not point to the system call instruction).
>>> +.IP
>>> +When the signal handler returns to the kernel,
>>> +the system call completes immediately
>>> +and returns to the calling thread,
>>> +without actually being executed.
>>> +If necessary
>>> +(i.e., when emulating the system call on user space.),
>>> +the signal handler should set the system call return value
>>> +to a sane value,
>>> +by modifying the register context stored in the
>>> +.I ucontext
>>> +argument of the signal handler.
>>
>> Just for my own education, do you have any example code somewhere
>> that demonstrates setting the syscall return value?
> 
> I though I had this exemplified in the kselftests, but I just saw that
> is not the case.  Something to fix there...
> 
> In the following signal handler code (untested, adapted from an old test
> case of mine), SUD is used as a poor-man strace (x86 specific):
> 
> static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
> {
> 	struct ucontext_t *ctx = ucontext;
> 	mcontext_t *mctx = &ctx->uc_mcontext;
> 	char buf[1024];
> 	unsigned long long r;
>        	int len;
> 
>         *arg5 = PR_SYS_DISPATCH_OFF;
> 
> 	len = snprintf(buf, 1024, "sys_%d(%d,%d,%d,%d,%d,%d)\n",
> 		       mctx->gregs[REG_RAX], mctx->gregs[REG_RDI],
> 		       mctx->gregs[REG_RSI], mctx->gregs[REG_RDX],
> 		       mctx->gregs[REG_R10], mctx->gregs[REG_R8],
> 		       mctx->gregs[REG_R9]);
> 
> 	write(2, buf, len);
> 
> 	r = syscall(mctx->gregs[REG_RAX], mctx->gregs[REG_RDI],
> 		    mctx->gregs[REG_RSI], mctx->gregs[REG_RDX],
> 		    mctx->gregs[REG_R10], mctx->gregs[REG_R8],
> 		    mctx->gregs[REG_R9]);
> 
> 	/* Set the return value. */
> 	mctx->gregs[REG_RAX] = r;
> 
>         *arg5 = PR_SYS_DISPATCH_ON;
> 
>         /* Assumes the return trampoline is in the allowed region */
> }
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
