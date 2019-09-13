Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E63B21E4
	for <lists+linux-api@lfdr.de>; Fri, 13 Sep 2019 16:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfIMO0H (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Sep 2019 10:26:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:41478 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfIMO0H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Sep 2019 10:26:07 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 14C8E2D12C2;
        Fri, 13 Sep 2019 10:26:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id TKAnLymlFryo; Fri, 13 Sep 2019 10:26:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8746D2D12BF;
        Fri, 13 Sep 2019 10:26:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8746D2D12BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1568384764;
        bh=+vbUIGNxdYrEinf4GDuz93FUN8w4SV2XoMp2J6S3Sz4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RZXNJsTJTtt6//1I2PmkVWYSHMy7nLbwpCDGfcrFthFVVJQf+ObLq4Mhu8fsJjAsE
         Tc26sOYoFmQqfR2dNtyACKyeheH6/fm9OxknwV67R4+/nwmSCGFrDuIZ6l9DwBSXLc
         rajLqONs80PR7fhJ3lmm6z/Ft4BVUHaKFpH24/JghhKk+o+HKrPRz3am9iFWbywcUc
         AlwJv3mF+UUbJlvLamSaXHH5TNw+iKWAxlv0e3/4JKOWWidHOcPpBgnlkxjKpqvRl1
         h2vAiZBY61NIJu9sFSmAtjnxl/4Y77qUJVhEQx8iB3/Pa/Ve/GTcZFWvDPKl8AMW4/
         XqcUkygDhRztg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 4M6WUh3A1TuS; Fri, 13 Sep 2019 10:26:04 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6F6052D12B6;
        Fri, 13 Sep 2019 10:26:04 -0400 (EDT)
Date:   Fri, 13 Sep 2019 10:26:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <2136508123.2398.1568384764381.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190911002744.8690-3-mathieu.desnoyers@efficios.com>
References: <20190911002744.8690-1-mathieu.desnoyers@efficios.com> <20190911002744.8690-3-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH 3/4] rseq: Introduce unreg_clone_flags
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.15_GA_3847 (ZimbraWebClient - FF69 (Linux)/8.8.15_GA_3847)
Thread-Topic: rseq: Introduce unreg_clone_flags
Thread-Index: 3gtmfNwQV8V2jD0UQsjLKl9iGsMFRA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

----- On Sep 10, 2019, at 8:27 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Considering that some custom libc could possibly choose not to use
> CLONE_SETTLS, we should allow the libc to override the choice of clone
> flags meant to unregister rseq. This is a policy decision which should
> not be made by the kernel.
> 
> Therefore, introduce a new RSEQ_FLAG_UNREG_CLONE_FLAGS, which makes the
> rseq system call expect an additional 5th argument: a mask of all the
> clone flags which may each ensure rseq is unregistered upon clone.
> 
> So even if CLONE_SETTLS is eventually replaced by some other flag in the
> future, the libc will be able to adapt and pass this new flag upon rseq
> registration as well.
> 
> The default when RSEQ_FLAG_UNREG_CLONE_FLAGS is unset is to unregister
> rseq on clone with CLONE_SETTLS.

Now that I think about this a bit more, perhaps it's better to just
clear on clone CLONE_SETTLS, and wait until a libc actually requires this
unreg_clone_flags override before introducing it.

Anyway, a "custom" libc could unregister / re-register around clone()
as a stopgap solution.

So I am tempted to drop this specific patch for now until actual libc
requiring it show up.

Thoughts ?

Thanks,

Mathieu

> 
> Suggested-by: "H . Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: linux-api@vger.kernel.org
> ---
> include/linux/sched.h     |  9 +++++++--
> include/linux/syscalls.h  |  2 +-
> include/uapi/linux/rseq.h |  1 +
> kernel/rseq.c             | 14 +++++++++++---
> 4 files changed, 20 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index deb4154dbf11..c8faa6f8493d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1138,6 +1138,7 @@ struct task_struct {
> 	 * with respect to preemption.
> 	 */
> 	unsigned long rseq_event_mask;
> +	int rseq_unreg_clone_flags;
> #endif
> 
> 	struct tlbflush_unmap_batch	tlb_ubc;
> @@ -1919,18 +1920,21 @@ static inline void rseq_migrate(struct task_struct *t)
> 
> /*
>  * If parent process has a registered restartable sequences area, the
> - * child inherits. Unregister rseq for a clone with CLONE_TLS set.
> + * child inherits, except if it has been required to be explicitly
> + * unregistered when any of the rseq_unreg_clone_flags are passed to clone.
>  */
> static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
> {
> -	if (clone_flags & CLONE_TLS) {
> +	if (clone_flags & t->rseq_unreg_clone_flags) {
> 		t->rseq = NULL;
> 		t->rseq_sig = 0;
> 		t->rseq_event_mask = 0;
> +		t->rseq_unreg_clone_flags = 0;
> 	} else {
> 		t->rseq = current->rseq;
> 		t->rseq_sig = current->rseq_sig;
> 		t->rseq_event_mask = current->rseq_event_mask;
> +		t->rseq_unreg_clone_flags = current->rseq_unreg_clone_flags;
> 	}
> }
> 
> @@ -1939,6 +1943,7 @@ static inline void rseq_execve(struct task_struct *t)
> 	t->rseq = NULL;
> 	t->rseq_sig = 0;
> 	t->rseq_event_mask = 0;
> +	t->rseq_unreg_clone_flags = 0;
> }
> 
> #else
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 88145da7d140..6a242cfcc360 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -987,7 +987,7 @@ asmlinkage long sys_pkey_free(int pkey);
> asmlinkage long sys_statx(int dfd, const char __user *path, unsigned flags,
> 			  unsigned mask, struct statx __user *buffer);
> asmlinkage long sys_rseq(struct rseq __user *rseq, uint32_t rseq_len,
> -			 int flags, uint32_t sig);
> +			 int flags, uint32_t sig, int unreg_clone_flags);
> asmlinkage long sys_open_tree(int dfd, const char __user *path, unsigned flags);
> asmlinkage long sys_move_mount(int from_dfd, const char __user *from_path,
> 			       int to_dfd, const char __user *to_path,
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index 9a402fdb60e9..d71e3c6b7fdb 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -20,6 +20,7 @@ enum rseq_cpu_id_state {
> 
> enum rseq_flags {
> 	RSEQ_FLAG_UNREGISTER = (1 << 0),
> +	RSEQ_FLAG_UNREG_CLONE_FLAGS = (1 << 1),
> };
> 
> enum rseq_cs_flags_bit {
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index a4f86a9d6937..c59b8d3dc275 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -304,8 +304,8 @@ void rseq_syscall(struct pt_regs *regs)
> /*
>  * sys_rseq - setup restartable sequences for caller thread.
>  */
> -SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
> -		int, flags, u32, sig)
> +SYSCALL_DEFINE5(rseq, struct rseq __user *, rseq, u32, rseq_len,
> +		int, flags, u32, sig, int, unreg_clone_flags)
> {
> 	int ret;
> 
> @@ -324,12 +324,16 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> rseq_len,
> 			return ret;
> 		current->rseq = NULL;
> 		current->rseq_sig = 0;
> +		current->rseq_unreg_clone_flags = 0;
> 		return 0;
> 	}
> 
> -	if (unlikely(flags))
> +	if (unlikely(flags & ~RSEQ_FLAG_UNREG_CLONE_FLAGS))
> 		return -EINVAL;
> 
> +	if (!(flags & RSEQ_FLAG_UNREG_CLONE_FLAGS))
> +		unreg_clone_flags = CLONE_SETTLS;
> +
> 	if (current->rseq) {
> 		/*
> 		 * If rseq is already registered, check whether
> @@ -338,6 +342,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> rseq_len,
> 		 */
> 		if (current->rseq != rseq || rseq_len != sizeof(*rseq))
> 			return -EINVAL;
> +		if ((flags & RSEQ_FLAG_UNREG_CLONE_FLAGS) &&
> +		    current->rseq_unreg_clone_flags != unreg_clone_flags)
> +			return -EINVAL;
> 		if (current->rseq_sig != sig)
> 			return -EPERM;
> 		/* Already registered. */
> @@ -355,6 +362,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32,
> rseq_len,
> 		return -EFAULT;
> 	current->rseq = rseq;
> 	current->rseq_sig = sig;
> +	current->rseq_unreg_clone_flags = unreg_clone_flags;
> 	/*
> 	 * If rseq was previously inactive, and has just been
> 	 * registered, ensure the cpu_id_start and cpu_id fields
> --
> 2.17.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
