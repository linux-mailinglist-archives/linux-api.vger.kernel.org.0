Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7514621F81D
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 19:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgGNRY4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 13:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgGNRY4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 13:24:56 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5537DC061755
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 10:24:56 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id d198so8929904vsc.1
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 10:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1xTgHLpduq9c9JN/ikTOg527pQJsOTf1rQHTQ4WlTZg=;
        b=MyewALBadXpPPljrz1yTNnZ5p2YE7I3mogDQDHYcHhbaIkJYMuInIwUfKqL1hPINCt
         Q4NiEXOTJ77+8e3rowUdC3ahYRy4JF3gV2pZWSN2AfyMON0FliW6wSeEvVACsSyeZNBm
         PNyoiOOk+NgRLNo/eRJVH0861frqubO1JboItfjc/0Ad1OigW2O4IxVNs3LYAVfsmRy2
         XDHUs9bidaZBFZE2oj6I+6jFzIsH9fWEGt2EN5vH08MAZ1fMNVej4NT8bFZVV4jGXSC5
         kd12ibATFlT9NAzdT+GC5hAnGKp93Y5w0cg7+KlOAPF3TUlLvJSzFwjebOGidjVWKU0i
         uKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1xTgHLpduq9c9JN/ikTOg527pQJsOTf1rQHTQ4WlTZg=;
        b=JLlE6aMo+oiRpO3bmPYfwZaA6MWmv9xZrZ2E6T7d+EagCQmvyWbkTZsRdi+7Zmzbru
         YDoGEUmGlQLzbnGbkW9AqzUa6VvMVNOFfs5kl9lA6ljaLoMsHGZ17RQpkhwbg6rv1QQ9
         mVz94fkFnv4mMJD8RdVgjt89Cji8K7tPgxQHoZKofxGppC5rRKILMPPb2DRc3RX3B2ow
         gjJdrc10mKej6XGP31EGHYHBcgS+Mjw0SDHKtFDth1L4D3h2m9+MS4E5JQJeqRmGYTuN
         fESX8+mzdAN2204gkOewFRhoDHZ/Nv8h0xpBQyvbfrpQpAENpG5WVldymkPGVX2BmaRc
         haDA==
X-Gm-Message-State: AOAM533GiP78zLQjqxcdZpnC57EGouuRjWmeQskWBm0x1yAmjfDrfndp
        8VGNViIcCI7GXr2ARh5KCYOcfkmtZg0sGXMLCYe9Hw==
X-Google-Smtp-Source: ABdhPJzzAkTiAPrsbSd2jw38wHWDvRjhFd+YRpNsM3eJDkj2N8Y7BiW13HUOeW2cs/HupIR5e/1lCsry5PKVucgkDxA=
X-Received: by 2002:a67:c90c:: with SMTP id w12mr4227101vsk.86.1594747495295;
 Tue, 14 Jul 2020 10:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com> <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
In-Reply-To: <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
From:   Peter Oskolkov <posk@posk.io>
Date:   Tue, 14 Jul 2020 10:24:43 -0700
Message-ID: <CAFTs51UHaUqaKj5bEj0vQtEZrww9gnrqb-kGVk7DAgQJPBAR+w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, carlos@redhat.com,
        Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

At Google, we actually extended struct rseq (I will post the patches
here once they are fully deployed and we have specific
benefits/improvements to report). We did this by adding several fields
below __u32 flags (the last field currently), and correspondingly
increasing rseq_len in rseq() syscall. If the kernel does not know of
this extension, it will return -EINVAL due to an unexpected rseq_len;
then the application can either fall-back to the standard/upstream
rseq, or bail. If the kernel does know of this extension, it accepts
it. If the application passes the old rseq_len (32), the kernel knows
that this is an old application and treats it as such.

I looked through the archives, but I did not find specifically why the
pretty standard approach described above is considered inferior to the
one taken in this patch (freeze rseq_len at 32, add additional length
fields to struct rseq). Can these be summarized?

Thanks,
Peter

On Mon, Jul 13, 2020 at 8:04 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Add a __rseq_abi.flags "RSEQ_TLS_FLAG_SIZE", which indicates support for
> extending struct rseq. This adds two new fields to struct rseq:
> user_size and kernel_size.
>
> The user_size field allows the size of the __rseq_abi definition (which
> can be overridden by symbol interposition either by a preloaded library
> or by the application) to be handed over to the kernel at registration.
> This registration can be performed by a library, e.g. glibc, which does
> not know there is interposition taking place.
>
> The kernel_size is populated by the kernel when the "RSEQ_TLS_FLAG_SIZE"
> flag is set in __rseq_abi.flags to the minimum between user_size and
> the offset of the "end" field of struct rseq as known by the kernel.
> This allows user-space to query which fields are effectively populated
> by the kernel.
>
> A rseq_size field is added to the task struct to keep track of the
> "kernel_size" effective for each thread.
>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/sched.h     |  4 ++++
>  include/uapi/linux/rseq.h | 37 ++++++++++++++++++++++++++++++++--
>  kernel/rseq.c             | 42 +++++++++++++++++++++++++++++++++------
>  3 files changed, 75 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 692e327d7455..5d61a3197987 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1147,6 +1147,7 @@ struct task_struct {
>  #ifdef CONFIG_RSEQ
>         struct rseq __user *rseq;
>         u32 rseq_sig;
> +       u32 rseq_size;
>         /*
>          * RmW on rseq_event_mask must be performed atomically
>          * with respect to preemption.
> @@ -1976,10 +1977,12 @@ static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
>         if (clone_flags & CLONE_VM) {
>                 t->rseq = NULL;
>                 t->rseq_sig = 0;
> +               t->rseq_size = 0;
>                 t->rseq_event_mask = 0;
>         } else {
>                 t->rseq = current->rseq;
>                 t->rseq_sig = current->rseq_sig;
> +               t->rseq_size = current->rseq_size;
>                 t->rseq_event_mask = current->rseq_event_mask;
>         }
>  }
> @@ -1988,6 +1991,7 @@ static inline void rseq_execve(struct task_struct *t)
>  {
>         t->rseq = NULL;
>         t->rseq_sig = 0;
> +       t->rseq_size = 0;
>         t->rseq_event_mask = 0;
>  }
>
> diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
> index e11d9df5e564..03c0b5e9a859 100644
> --- a/include/uapi/linux/rseq.h
> +++ b/include/uapi/linux/rseq.h
> @@ -37,6 +37,15 @@ enum rseq_cs_flags {
>                 (1U << RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
>  };
>
> +enum rseq_tls_flags_bit {
> +       /* enum rseq_cs_flags reserves bits 0-2. */
> +       RSEQ_TLS_FLAG_SIZE_BIT = 3,
> +};
> +
> +enum rseq_tls_flags {
> +       RSEQ_TLS_FLAG_SIZE = (1U << RSEQ_TLS_FLAG_SIZE_BIT),
> +};
> +
>  /* The rseq_len expected by rseq registration is always 32 bytes. */
>  enum rseq_len_expected {
>         RSEQ_LEN_EXPECTED = 32,
> @@ -133,8 +142,9 @@ struct rseq {
>          *
>          * This field should only be updated by the thread which
>          * registered this data structure. Read by the kernel.
> -        * Mainly used for single-stepping through rseq critical sections
> -        * with debuggers.
> +        *
> +        * The RSEQ_CS flags are mainly used for single-stepping through rseq
> +        * critical sections with debuggers.
>          *
>          * - RSEQ_CS_FLAG_NO_RESTART_ON_PREEMPT
>          *     Inhibit instruction sequence block restart on preemption
> @@ -145,8 +155,31 @@ struct rseq {
>          * - RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE
>          *     Inhibit instruction sequence block restart on migration for
>          *     this thread.
> +        *
> +        * - RSEQ_TLS_FLAG_SIZE
> +        *     Extensible struct rseq ABI. This flag should be statically
> +        *     initialized.
>          */
>         __u32 flags;
> +       /*
> +        * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, user_size should be
> +        * statically initialized to offsetof(struct rseq, end).
> +        */
> +       __u16 user_size;
> +       /*
> +        * With __rseq_abi.flags RSEQ_TLS_FLAG_SIZE set, if the kernel supports
> +        * extensible struct rseq ABI, the kernel_size field is populated by
> +        * the kernel to the minimum between user_size and the offset of the
> +        * "end" field within the struct rseq supported by the kernel on
> +        * successful registration. Should be initialized to 0.
> +        */
> +       __u16 kernel_size;
> +
> +       /*
> +        * Very last field of the structure, to calculate size excluding padding
> +        * with offsetof().
> +        */
> +       char end[];
>  } __attribute__((aligned(4 * sizeof(__u64))));
>
>  #endif /* _UAPI_LINUX_RSEQ_H */
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index a4f86a9d6937..bbc57fc18573 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -96,6 +96,7 @@ static int rseq_update_cpu_id(struct task_struct *t)
>  static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>  {
>         u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
> +       u16 kernel_size = 0;
>
>         /*
>          * Reset cpu_id_start to its initial state (0).
> @@ -109,6 +110,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>          */
>         if (put_user(cpu_id, &t->rseq->cpu_id))
>                 return -EFAULT;
> +       /*
> +        * Reset kernel_size to its initial state (0).
> +        */
> +       if (put_user(kernel_size, &t->rseq->kernel_size))
> +               return -EFAULT;
>         return 0;
>  }
>
> @@ -266,7 +272,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>
>         if (unlikely(t->flags & PF_EXITING))
>                 return;
> -       if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
> +       if (unlikely(!access_ok(t->rseq, t->rseq_size)))
>                 goto error;
>         ret = rseq_ip_fixup(regs);
>         if (unlikely(ret < 0))
> @@ -294,7 +300,7 @@ void rseq_syscall(struct pt_regs *regs)
>
>         if (!t->rseq)
>                 return;
> -       if (!access_ok(t->rseq, sizeof(*t->rseq)) ||
> +       if (!access_ok(t->rseq, t->rseq_size) ||
>             rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
>                 force_sig(SIGSEGV);
>  }
> @@ -308,6 +314,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>                 int, flags, u32, sig)
>  {
>         int ret;
> +       u32 tls_flags;
>
>         if (flags & RSEQ_FLAG_UNREGISTER) {
>                 if (flags & ~RSEQ_FLAG_UNREGISTER)
> @@ -315,7 +322,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>                 /* Unregister rseq for current thread. */
>                 if (current->rseq != rseq || !current->rseq)
>                         return -EINVAL;
> -               if (rseq_len != sizeof(*rseq))
> +               if (rseq_len != RSEQ_LEN_EXPECTED)
>                         return -EINVAL;
>                 if (current->rseq_sig != sig)
>                         return -EPERM;
> @@ -323,6 +330,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>                 if (ret)
>                         return ret;
>                 current->rseq = NULL;
> +               current->rseq_size = 0;
>                 current->rseq_sig = 0;
>                 return 0;
>         }
> @@ -336,7 +344,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>                  * the provided address differs from the prior
>                  * one.
>                  */
> -               if (current->rseq != rseq || rseq_len != sizeof(*rseq))
> +               if (current->rseq != rseq || rseq_len != RSEQ_LEN_EXPECTED)
>                         return -EINVAL;
>                 if (current->rseq_sig != sig)
>                         return -EPERM;
> @@ -349,10 +357,32 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
>          * ensure the provided rseq is properly aligned and valid.
>          */
>         if (!IS_ALIGNED((unsigned long)rseq, __alignof__(*rseq)) ||
> -           rseq_len != sizeof(*rseq))
> +           rseq_len != RSEQ_LEN_EXPECTED)
>                 return -EINVAL;
> -       if (!access_ok(rseq, rseq_len))
> +       if (!access_ok(rseq, RSEQ_LEN_EXPECTED))
>                 return -EFAULT;
> +
> +       /* Handle extensible struct rseq ABI. */
> +       ret = get_user(tls_flags, &rseq->flags);
> +       if (ret)
> +               return ret;
> +       if (tls_flags & RSEQ_TLS_FLAG_SIZE) {
> +               u16 user_size, kernel_size;
> +
> +               ret = get_user(user_size, &rseq->user_size);
> +               if (ret)
> +                       return ret;
> +               if (user_size < offsetof(struct rseq, kernel_size) + sizeof(u16))
> +                       return -EINVAL;
> +               kernel_size = min_t(u16, user_size, offsetof(struct rseq, end));
> +               ret = put_user(kernel_size, &rseq->kernel_size);
> +               if (ret)
> +                       return ret;
> +               current->rseq_size = kernel_size;
> +       } else {
> +               current->rseq_size = offsetof(struct rseq, user_size);
> +       }
> +
>         current->rseq = rseq;
>         current->rseq_sig = sig;
>         /*
> --
> 2.17.1
>
