Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4411F415E5B
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 14:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbhIWMaA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 08:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241010AbhIWM37 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 23 Sep 2021 08:29:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7462260F4C;
        Thu, 23 Sep 2021 12:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632400108;
        bh=Os5LXya4yRMgFGSZwh+5l9dBxaDCc5Hf5BRdOqzikTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qIqDmD2hM77r8GfB2HCKg3sY9UhopIZAfU1DUkeprNtxtiHDrjSE++43XK0h4vWpD
         PHnyvPS+BrNHbgg9a3B2UvsWvdyDuOVEYkAT6KETC/v4rMBdvaGePN1Y5119p3imx5
         MbdyunX9Vh1R04xj210trvbaSZB0/CWAz33X9s/A=
Date:   Thu, 23 Sep 2021 14:28:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     x86@kernel.org, Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 10/13] x86/uintr: Introduce user IPI sender syscalls
Message-ID: <YUxy6XqMB1+DYJtP@kroah.com>
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <20210913200132.3396598-11-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913200132.3396598-11-sohil.mehta@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 13, 2021 at 01:01:29PM -0700, Sohil Mehta wrote:
> Add a registration syscall for a task to register itself as a user
> interrupt sender using the uintr_fd generated by the receiver. A task
> can register multiple uintr_fds. Each unique successful connection
> creates a new entry in the User Interrupt Target Table (UITT).
> 
> Each entry in the UITT table is referred by the UITT index (uipi_index).
> The uipi_index returned during the registration syscall lets a sender
> generate a user IPI using the 'SENDUIPI <uipi_index>' instruction.
> 
> Also, add a sender unregister syscall to unregister a particular task
> from the uintr_fd. Calling close on the uintr_fd will disconnect all
> threads in a sender process from that FD.
> 
> Currently, the UITT size is arbitrarily chosen as 256 entries
> corresponding to a 4KB page. Based on feedback and usage data this can
> either be increased/decreased or made dynamic later.
> 
> Architecturally, the UITT table can be unique for each thread or shared
> across threads of the same thread group. The current implementation
> keeps the UITT as unique for the each thread. This makes the kernel
> implementation relatively simple and only threads that use uintr get
> setup with the related structures. However, this means that the
> uipi_index for each thread would be inconsistent wrt to other threads.
> (Executing 'SENDUIPI 2' on threads of the same process could generate
> different user interrupts.)
> 
> Alternatively, the benefit of sharing the UITT table is that all threads
> would see the same view of the UITT table. Also the kernel UITT memory
> allocation would be more efficient if multiple threads connect to the
> same uintr_fd. However, this would mean the kernel needs to keep the
> UITT table size MISC_MSR[] in sync across these threads. Also the
> UPID/UITT teardown flows might need additional consideration.
> 
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
>  arch/x86/include/asm/processor.h |   2 +
>  arch/x86/include/asm/uintr.h     |  15 ++
>  arch/x86/kernel/process.c        |   1 +
>  arch/x86/kernel/uintr_core.c     | 355 ++++++++++++++++++++++++++++++-
>  arch/x86/kernel/uintr_fd.c       | 133 ++++++++++++
>  5 files changed, 495 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index d229bfac8b4f..3482c3182e39 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -10,6 +10,7 @@ struct mm_struct;
>  struct io_bitmap;
>  struct vm86;
>  struct uintr_receiver;
> +struct uintr_sender;
>  
>  #include <asm/math_emu.h>
>  #include <asm/segment.h>
> @@ -533,6 +534,7 @@ struct thread_struct {
>  #ifdef CONFIG_X86_USER_INTERRUPTS
>  	/* User Interrupt state*/
>  	struct uintr_receiver	*ui_recv;
> +	struct uintr_sender	*ui_send;
>  #endif
>  
>  	/* Floating point and extended processor state */
> diff --git a/arch/x86/include/asm/uintr.h b/arch/x86/include/asm/uintr.h
> index 1f00e2a63da4..ef3521dd7fb9 100644
> --- a/arch/x86/include/asm/uintr.h
> +++ b/arch/x86/include/asm/uintr.h
> @@ -8,6 +8,7 @@ struct uintr_upid_ctx {
>  	struct task_struct *task;	/* Receiver task */
>  	struct uintr_upid *upid;
>  	refcount_t refs;
> +	bool receiver_active;		/* Flag for UPID being mapped to a receiver */
>  };
>  
>  struct uintr_receiver_info {
> @@ -16,12 +17,26 @@ struct uintr_receiver_info {
>  	u64 uvec;				/* Vector number */
>  };
>  
> +struct uintr_sender_info {
> +	struct list_head node;
> +	struct uintr_uitt_ctx *uitt_ctx;
> +	struct task_struct *task;
> +	struct uintr_upid_ctx *r_upid_ctx;	/* Receiver's UPID context */
> +	struct callback_head twork;		/* Task work head */
> +	unsigned int uitt_index;
> +};
> +
>  bool uintr_arch_enabled(void);
>  int do_uintr_register_handler(u64 handler);
>  int do_uintr_unregister_handler(void);
>  int do_uintr_register_vector(struct uintr_receiver_info *r_info);
>  void do_uintr_unregister_vector(struct uintr_receiver_info *r_info);
>  
> +int do_uintr_register_sender(struct uintr_receiver_info *r_info,
> +			     struct uintr_sender_info *s_info);
> +void do_uintr_unregister_sender(struct uintr_receiver_info *r_info,
> +				struct uintr_sender_info *s_info);
> +
>  void uintr_free(struct task_struct *task);
>  
>  /* TODO: Inline the context switch related functions */
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index 83677f76bd7b..9db33e467b30 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -92,6 +92,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
>  #ifdef CONFIG_X86_USER_INTERRUPTS
>  	/* User Interrupt state is unique for each task */
>  	dst->thread.ui_recv = NULL;
> +	dst->thread.ui_send = NULL;
>  #endif
>  
>  	return fpu_clone(dst);
> diff --git a/arch/x86/kernel/uintr_core.c b/arch/x86/kernel/uintr_core.c
> index 9dcb9f60e5bc..8f331c5fe0cf 100644
> --- a/arch/x86/kernel/uintr_core.c
> +++ b/arch/x86/kernel/uintr_core.c
> @@ -21,6 +21,11 @@
>  #include <asm/msr-index.h>
>  #include <asm/uintr.h>
>  
> +/*
> + * Each UITT entry is 16 bytes in size.
> + * Current UITT table size is set as 4KB (256 * 16 bytes)
> + */
> +#define UINTR_MAX_UITT_NR 256
>  #define UINTR_MAX_UVEC_NR 64
>  
>  /* User Posted Interrupt Descriptor (UPID) */
> @@ -44,6 +49,27 @@ struct uintr_receiver {
>  	u64 uvec_mask;	/* track active vector per bit */
>  };
>  
> +/* User Interrupt Target Table Entry (UITTE) */
> +struct uintr_uitt_entry {
> +	u8	valid;			/* bit 0: valid, bit 1-7: reserved */

Do you check that the other bits are set to 0?

> +	u8	user_vec;
> +	u8	reserved[6];

What is this reserved for?

> +	u64	target_upid_addr;

If this is a pointer, why not say it is a pointer?

> +} __packed __aligned(16);
> +
> +struct uintr_uitt_ctx {
> +	struct uintr_uitt_entry *uitt;
> +	/* Protect UITT */
> +	spinlock_t uitt_lock;
> +	refcount_t refs;

Again, a kref please.

thanks,

greg k-h
