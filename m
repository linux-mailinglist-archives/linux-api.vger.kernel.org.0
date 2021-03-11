Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5178A337631
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhCKOwP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 09:52:15 -0500
Received: from mail.efficios.com ([167.114.26.124]:44810 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhCKOv6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Mar 2021 09:51:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7740B28D5BE;
        Thu, 11 Mar 2021 09:51:57 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Qu3OP2STmJ-C; Thu, 11 Mar 2021 09:51:57 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 074B828D5BD;
        Thu, 11 Mar 2021 09:51:57 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 074B828D5BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1615474317;
        bh=PL+Do3RiU8ZwEmjPMN8oQVW2UGeiF+zVdGoFeQ4cSx4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jv175HtwimfwS6DkFe8T/vS1w1bh0NcwlXqk7dKpjlAdALUXNOm0OxIBhSrG8E089
         +zL5DwJnGgFZSdvbxppMoC0G2xvtdfPH1o25no1tybqqaafn7NploK0Z92jNLQ8wTG
         IsrhCsE9JbEoBIU4bHgdz7xEGUiYv3ONY2VeFkDPA4L7W0utgb2HVu/DWHIbVL76X3
         GtWmueKFYIA/4tPn+ed+IVNgqh13+9CGEPMFS4TMrQuzV5QMaPPZpIzxlrkzy0FCwT
         1HLOfQldbUxoRsHn9KpYOo0/yRntRFKBJ23AMi0EOiqOpKtQ0ZDNHtCMQfPPqrUx8U
         OG759MevL+Ckw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mKGBq-sN7b6l; Thu, 11 Mar 2021 09:51:56 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id E842128D62F;
        Thu, 11 Mar 2021 09:51:56 -0500 (EST)
Date:   Thu, 11 Mar 2021 09:51:56 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Florian Weimer <fweimer@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir <emmir@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <1173189328.5477.1615474316906.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210226135156.1081606-1-figiel@google.com>
References: <20210226135156.1081606-1-figiel@google.com>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF86 (Linux)/8.8.15_GA_4007)
Thread-Topic: ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Thread-Index: lCuYtmkZYQcWdMyqmX3XXApDYL6h2g==
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



----- On Feb 26, 2021, at 8:51 AM, Piotr Figiel figiel@google.com wrote:

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

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

Thanks!

Mathieu


> 
> ---
> v2:
> Applied review comments:
> - changed return value from the ptrace request to the size of the
>   configuration structure
> - expanded configuration structure with the flags field and
>   the rseq abi structure size
> 
> v1:
> https://lore.kernel.org/lkml/20210222100443.4155938-1-figiel@google.com/
> 
> ---
> include/uapi/linux/ptrace.h | 10 ++++++++++
> kernel/ptrace.c             | 25 +++++++++++++++++++++++++
> 2 files changed, 35 insertions(+)
> 
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 83ee45fa634b..3747bf816f9a 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -102,6 +102,16 @@ struct ptrace_syscall_info {
> 	};
> };
> 
> +#define PTRACE_GET_RSEQ_CONFIGURATION	0x420f
> +
> +struct ptrace_rseq_configuration {
> +	__u64 rseq_abi_pointer;
> +	__u32 rseq_abi_size;
> +	__u32 signature;
> +	__u32 flags;
> +	__u32 pad;
> +};
> +
> /*
>  * These values are stored in task->ptrace_message
>  * by tracehook_report_syscall_* to describe the current syscall-stop.
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 61db50f7ca86..76f09456ec4b 100644
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
> @@ -779,6 +780,24 @@ static int ptrace_peek_siginfo(struct task_struct *child,
> 	return ret;
> }
> 
> +#ifdef CONFIG_RSEQ
> +static long ptrace_get_rseq_configuration(struct task_struct *task,
> +					  unsigned long size, void __user *data)
> +{
> +	struct ptrace_rseq_configuration conf = {
> +		.rseq_abi_pointer = (u64)(uintptr_t)task->rseq,
> +		.rseq_abi_size = sizeof(*task->rseq),
> +		.signature = task->rseq_sig,
> +		.flags = 0,
> +	};
> +
> +	size = min_t(unsigned long, size, sizeof(conf));
> +	if (copy_to_user(data, &conf, size))
> +		return -EFAULT;
> +	return sizeof(conf);
> +}
> +#endif
> +
> #ifdef PTRACE_SINGLESTEP
> #define is_singlestep(request)		((request) == PTRACE_SINGLESTEP)
> #else
> @@ -1222,6 +1241,12 @@ int ptrace_request(struct task_struct *child, long
> request,
> 		ret = seccomp_get_metadata(child, addr, datavp);
> 		break;
> 
> +#ifdef CONFIG_RSEQ
> +	case PTRACE_GET_RSEQ_CONFIGURATION:
> +		ret = ptrace_get_rseq_configuration(child, addr, datavp);
> +		break;
> +#endif
> +
> 	default:
> 		break;
> 	}
> --
> 2.30.1.766.gb4fecdf3b7-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
