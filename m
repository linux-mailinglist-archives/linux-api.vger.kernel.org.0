Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C7321A95
	for <lists+linux-api@lfdr.de>; Mon, 22 Feb 2021 15:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhBVOyB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Feb 2021 09:54:01 -0500
Received: from mail.efficios.com ([167.114.26.124]:59458 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbhBVOx7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Feb 2021 09:53:59 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D507D31DF0A;
        Mon, 22 Feb 2021 09:53:17 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ca3vCMVfCG51; Mon, 22 Feb 2021 09:53:17 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 81FBE31DBB8;
        Mon, 22 Feb 2021 09:53:17 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 81FBE31DBB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1614005597;
        bh=6xJbeMon0dIAFE3SLnFpwTdE+1lQ2x9RG9sZfdE1baU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=OFY3uxzFj7QsDxpsDR58t7bhmYRW92G6K1GIBgVee3xxSGkxcCKWWbnZ83tRZXcHv
         89DjYBrDrD7z0imyKg0ftZM1UivWXgbcFqFnHFfeNIa9bTi7ObY0xaELfw5Cy9AA1S
         10Dn1oE/IkVy4sJ4inU1U5ohKw5obX9jCpewAgbQ5lYNXMQHGzZO23oVtnDqQo1GzX
         xVUpzfZWciMtH96ocu3UX6kQj3FC1uof62aXvipKQvlFGZJLyYz6eYjppy60T+zvCb
         XhjlSQ9ArdvmhOj1swtb50ZHHYIn3YFdy2YTiGJB6ALQ/SEyaw0YvN1XHuJig/i+Fd
         zjow1xf2/70PA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1g2gAGYrIqFT; Mon, 22 Feb 2021 09:53:17 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7094831DE13;
        Mon, 22 Feb 2021 09:53:17 -0500 (EST)
Date:   Mon, 22 Feb 2021 09:53:17 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir@google.com,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1521573573.29432.1614005597395.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210222100443.4155938-1-figiel@google.com>
References: <20210222100443.4155938-1-figiel@google.com>
Subject: Re: [PATCH] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF85 (Linux)/8.8.15_GA_3996)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: J6EdGRcHXkxVmrSqn5lvar9/UgoNWw==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



----- On Feb 22, 2021, at 5:04 AM, Piotr Figiel figiel@google.com wrote:

> For userspace checkpoint and restore (C/R) a way of getting process state
> containing RSEQ configuration is needed.
> 
> There are two ways this information is going to be used:
> - to re-enable RSEQ for threads which had it enabled before C/R
> - to detect if a thread was in a critical section during C/R
> 
> Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
> using the address registered before C/R.
> 
> Detection whether the thread is in a critical section during C/R is needed
> to enforce behavior of RSEQ abort during C/R. Attaching with ptrace()
> before registers are dumped itself doesn't cause RSEQ abort.
> Restoring the instruction pointer within the critical section is
> problematic because rseq_cs may get cleared before the control is passed
> to the migrated application code leading to RSEQ invariants not being
> preserved. C/R code will use RSEQ ABI address to find the abort handler
> to which the instruction pointer needs to be set.
> 
> To achieve above goals expose the RSEQ ABI address and the signature value
> with the new ptrace request PTRACE_GET_RSEQ_CONFIGURATION.
> 
> This new ptrace request can also be used by debuggers so they are aware
> of stops within restartable sequences in progress.
> 
> Signed-off-by: Piotr Figiel <figiel@google.com>
> Reviewed-by: Michal Miroslaw <emmir@google.com>
> 
> ---
> include/uapi/linux/ptrace.h |  8 ++++++++
> kernel/ptrace.c             | 23 +++++++++++++++++++++++
> 2 files changed, 31 insertions(+)
> 
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 83ee45fa634b..d54cf6b6ce7c 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -102,6 +102,14 @@ struct ptrace_syscall_info {
> 	};
> };
> 
> +#define PTRACE_GET_RSEQ_CONFIGURATION	0x420f
> +
> +struct ptrace_rseq_configuration {
> +	__u64 rseq_abi_pointer;
> +	__u32 signature;
> +	__u32 pad;
> +};

I notice that other structures defined in this UAPI header are not packed as well.
Should we add an attribute packed on new structures ? It seems like it is
generally a safer course of action, even though each field is naturally aligned
here (there is no padding/hole in the structure).

> +
> /*
>  * These values are stored in task->ptrace_message
>  * by tracehook_report_syscall_* to describe the current syscall-stop.
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 61db50f7ca86..a936af66cf6f 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -31,6 +31,7 @@
> #include <linux/cn_proc.h>
> #include <linux/compat.h>
> #include <linux/sched/signal.h>
> +#include <linux/minmax.h>
> 
> #include <asm/syscall.h>	/* for syscall_get_* */
> 
> @@ -779,6 +780,22 @@ static int ptrace_peek_siginfo(struct task_struct *child,
> 	return ret;
> }
> 
> +#ifdef CONFIG_RSEQ
> +static long ptrace_get_rseq_configuration(struct task_struct *task,
> +					  unsigned long size, void __user *data)
> +{
> +	struct ptrace_rseq_configuration conf = {
> +		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
> +		.signature = task->rseq_sig,
> +	};
> +
> +	size = min_t(unsigned long, size, sizeof(conf));
> +	if (copy_to_user(data, &conf, size))
> +		return -EFAULT;
> +	return size;

See other email about returning 0 here.

Thanks,

Mathieu

> +
> 	default:
> 		break;
> 	}
> --
> 2.30.0.617.g56c4b15f3c-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
