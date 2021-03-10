Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE743334722
	for <lists+linux-api@lfdr.de>; Wed, 10 Mar 2021 19:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhCJSuV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Mar 2021 13:50:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233301AbhCJSuP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Mar 2021 13:50:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615402214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ujgHC2APsB8R2uAWzIAh2HLokjAekCL0UgQUy4oA9CY=;
        b=L56K0bKBiFyC97iMybfm5jPe1GT8hMnQD9L7G1BAw0OIZGHvvKqPz921Zg4U327lgMZacQ
        Dos2U2FcRcw/6ITSQ/56TU7S1AHcs53FndJBDfoHtS3pJCpJd977zCwHxQGiZE53h1qn46
        vjXKVpG/B7zGlFU4nyKuhRQ+65INLOs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-huHmzua5PeKRAYpDhp0a9Q-1; Wed, 10 Mar 2021 13:50:10 -0500
X-MC-Unique: huHmzua5PeKRAYpDhp0a9Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6891618D6A40;
        Wed, 10 Mar 2021 18:50:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id A5BA177BF0;
        Wed, 10 Mar 2021 18:50:03 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 10 Mar 2021 19:50:08 +0100 (CET)
Date:   Wed, 10 Mar 2021 19:50:02 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Piotr Figiel <figiel@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mathieu.desnoyers@efficios.com, peterz@infradead.org,
        paulmck@kernel.org, boqun.feng@gmail.com, ldv@altlinux.org,
        fweimer@redhat.com, Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        posk@google.com, kyurtsever@google.com, ckennelly@google.com,
        pjt@google.com, emmir@google.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Message-ID: <20210310185001.GD8973@redhat.com>
References: <20210226135156.1081606-1-figiel@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226135156.1081606-1-figiel@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I don't think I can review this patch, I don't understand the problem space
well enough. But just in case, I see nothing wrong in this simple patch.

Feel free to add

Acked-by: Oleg Nesterov <oleg@redhat.com>



On 02/26, Piotr Figiel wrote:
>
> For userspace checkpoint and restore (C/R) a way of getting process state
> containing RSEQ configuration is needed.
> 
> There are two ways this information is going to be used:
>  - to re-enable RSEQ for threads which had it enabled before C/R
>  - to detect if a thread was in a critical section during C/R
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
> v2:
> Applied review comments:
>  - changed return value from the ptrace request to the size of the
>    configuration structure
>  - expanded configuration structure with the flags field and
>    the rseq abi structure size
> 
> v1:
>  https://lore.kernel.org/lkml/20210222100443.4155938-1-figiel@google.com/
> 
> ---
>  include/uapi/linux/ptrace.h | 10 ++++++++++
>  kernel/ptrace.c             | 25 +++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index 83ee45fa634b..3747bf816f9a 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -102,6 +102,16 @@ struct ptrace_syscall_info {
>  	};
>  };
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
>  /*
>   * These values are stored in task->ptrace_message
>   * by tracehook_report_syscall_* to describe the current syscall-stop.
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 61db50f7ca86..76f09456ec4b 100644
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
> @@ -779,6 +780,24 @@ static int ptrace_peek_siginfo(struct task_struct *child,
>  	return ret;
>  }
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
>  #ifdef PTRACE_SINGLESTEP
>  #define is_singlestep(request)		((request) == PTRACE_SINGLESTEP)
>  #else
> @@ -1222,6 +1241,12 @@ int ptrace_request(struct task_struct *child, long request,
>  		ret = seccomp_get_metadata(child, addr, datavp);
>  		break;
>  
> +#ifdef CONFIG_RSEQ
> +	case PTRACE_GET_RSEQ_CONFIGURATION:
> +		ret = ptrace_get_rseq_configuration(child, addr, datavp);
> +		break;
> +#endif
> +
>  	default:
>  		break;
>  	}
> -- 
> 2.30.1.766.gb4fecdf3b7-goog
> 

