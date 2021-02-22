Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97CB1321595
	for <lists+linux-api@lfdr.de>; Mon, 22 Feb 2021 12:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBVL6K (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 22 Feb 2021 06:58:10 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:55208 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBVL6J (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 22 Feb 2021 06:58:09 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 39B5672C8B3;
        Mon, 22 Feb 2021 14:57:26 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 29E067CC89C; Mon, 22 Feb 2021 14:57:26 +0300 (MSK)
Date:   Mon, 22 Feb 2021 14:57:26 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Piotr Figiel <figiel@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@kernel.org, boqun.feng@gmail.com, oleg@redhat.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com, emmir@google.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Message-ID: <20210222115726.GA30843@altlinux.org>
References: <20210222100443.4155938-1-figiel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222100443.4155938-1-figiel@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Feb 22, 2021 at 11:04:43AM +0100, Piotr Figiel wrote:
[...]
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -102,6 +102,14 @@ struct ptrace_syscall_info {
>  	};
>  };
>  
> +#define PTRACE_GET_RSEQ_CONFIGURATION	0x420f
> +
> +struct ptrace_rseq_configuration {
> +	__u64 rseq_abi_pointer;
> +	__u32 signature;
> +	__u32 pad;
> +};
> +
>  /*
>   * These values are stored in task->ptrace_message
>   * by tracehook_report_syscall_* to describe the current syscall-stop.
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 61db50f7ca86..a936af66cf6f 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -31,6 +31,7 @@
>  #include <linux/cn_proc.h>
>  #include <linux/compat.h>
>  #include <linux/sched/signal.h>
> +#include <linux/minmax.h>
>  
>  #include <asm/syscall.h>	/* for syscall_get_* */
>  
> @@ -779,6 +780,22 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>  	return ret;
>  }
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
> +}
> +#endif

From API perspective I suggest for such interfaces to return the amount of
data that could have been written if there was enough room specified, e.g.
in this case it's sizeof(conf) instead of size.


-- 
ldv
