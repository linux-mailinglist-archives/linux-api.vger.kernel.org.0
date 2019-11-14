Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8551FD148
	for <lists+linux-api@lfdr.de>; Fri, 15 Nov 2019 00:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfKNXBj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 14 Nov 2019 18:01:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42315 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfKNXBj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 14 Nov 2019 18:01:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so8761065wrf.9;
        Thu, 14 Nov 2019 15:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+WgT5Q3HHhQdCUcfI5uxkWBbqKa2O/MldQW0CGmuwAs=;
        b=JjXkDFEhSuIvqvjC4U1tk7VpSYQr83RQY3WAsYFaduW/u8J6LjaE8r5M5JDVxyw6eS
         dhu6w7LMu/9T4OH62ADHwxRROfR3fCGlBxsn5sRnJYZvvWyifpCGyXGJZUdI/rtcUgDG
         q617JZ0iyt4cZlwQB0kNY8uV7cmWsPrDP9LOP8KjIrah5wib+BkfXVJM/j0CcBIFhD89
         wdjfzhCIdTwGI4dqHPvoXuLkjwPbwDOr+imx4de5jhTqp1u3CdRImcEBqLMCfMwAxhGv
         MJkBz9ppoagecmwqQyzfRWGKZrg5LSPLRUk9PTUyRWJO3s3A1FtR7Yq3zD1hZkozTQjn
         mtTg==
X-Gm-Message-State: APjAAAWsOO9N4H32vPWqBmcsELSbjaeQNyWEpwGhCKQw9JNuXwFHqPUh
        7llVVvxdOQOqL0QQerRzvKw=
X-Google-Smtp-Source: APXvYqxXlmlbHfNw0IQnWLxkBs2JxxUTB6yNXe7gbTZ+lZ5Tmz7FvTG6KCpz+oFBG2pm+IqBaXiUjg==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr5161428wrv.216.1573772496547;
        Thu, 14 Nov 2019 15:01:36 -0800 (PST)
Received: from ryzen.lan ([81.196.112.181])
        by smtp.gmail.com with ESMTPSA id p4sm9300216wrx.71.2019.11.14.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 15:01:35 -0800 (PST)
Date:   Fri, 15 Nov 2019 01:01:27 +0200
From:   Abel Vesa <abelvesa@linux.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038@lists.linaro.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        zhengbin <zhengbin13@huawei.com>,
        Li RongQing <lirongqing@baidu.com>, linux-api@vger.kernel.org
Subject: Re: [PATCH 17/23] y2038: time: avoid timespec usage in settimeofday()
Message-ID: <20191114230127.GA3580@ryzen.lan>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108211323.1806194-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191108211323.1806194-8-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 19-11-08 22:12:16, Arnd Bergmann wrote:
> The compat_get_timeval() and timeval_valid() interfaces
> are deprecated and getting removed along with the definition
> of struct timeval itself.
> 
> Change the two implementations of the settimeofday()
> system call to open-code these helpers and completely
> avoid references to timeval.
> 

I get the following rcu stalls due to this patch on riscv64 (on qemu):

	[root@riscv ~]# uname -a
	Linux riscv 5.4.0-rc6-00018-gadde74306a4b #112 SMP Fri Nov 15 00:46:20 EET 2019 riscv64 riscv64 riscv64 GNU/Linux
	[root@riscv ~]# [  420.135710] rcu: INFO: rcu_sched self-detected stall
	on CPU
	[  420.136839] rcu:     3-....: (99702 ticks this GP) idle=482/1/0x4000000000000002 softirq=3322/3322 fqs=48784 
	[  420.138917]  (t=99768 jiffies g=4985 q=8343)
	[  420.139772] Task dump for CPU 3:
	[  420.140236] rdate           R  running task        0   254      1 0x00000008
	[  420.142226] Call Trace:
	[  420.142791] [<ffffffe000037954>] walk_stackframe+0x0/0xa6
	[  420.143911] [<ffffffe000037aba>] show_stack+0x2a/0x34
	[  420.145010] [<ffffffe0000569c8>] sched_show_task+0xf0/0x116
	[  420.145996] [<ffffffe00005b502>] dump_cpu_task+0x3e/0x48
	[  420.147073] [<ffffffe000084e5e>] rcu_dump_cpu_stacks+0x7c/0xb4
	[  420.148243] [<ffffffe0000842f6>] rcu_sched_clock_irq+0x3d6/0x582
	[  420.149349] [<ffffffe0000897b4>] update_process_times+0x1e/0x42
	[  420.150306] [<ffffffe000093a34>] tick_sched_handle.isra.0+0x2a/0x3a
	[  420.150997] [<ffffffe000093ce8>] tick_sched_timer+0x4e/0x92
	[  420.151603] [<ffffffe000089eb6>] __hrtimer_run_queues+0xae/0x108
	[  420.152639] [<ffffffe00008a5ac>] hrtimer_interrupt+0xca/0x1d4
	[  420.153629] [<ffffffe0004de564>] riscv_timer_interrupt+0x32/0x3a
	[  420.154629] [<ffffffe000612ad4>] do_IRQ+0xa4/0xb8
	[  420.155294] [<ffffffe000036814>] ret_from_exception+0x0/0xc
	[  420.156073] [<ffffffe000036814>] ret_from_exception+0x0/0xc
	[  451.556189] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-... } 100725 jiffies s: 53 root: 0x8/.
	[  451.558689] rcu: blocking rcu_node structures:
	[  451.559501] Task dump for CPU 3:
	[  451.560518] rdate           R  running task        0   254      1 0x00000008
	[  451.561396] Call Trace:
	[  451.561675] [<ffffffe00060ed48>] __schedule+0x158/0x36a
	[  483.147733] rcu: INFO: rcu_sched self-detected stall on CPU
	[  483.148723] rcu:     3-....: (115448 ticks this GP) idle=482/1/0x4000000000000002 softirq=3322/3322 fqs=56510 
	[  483.150220]  (t=115521 jiffies g=4985 q=8400)
	[  483.150885] Task dump for CPU 3:
	[  483.151392] rdate           R  running task        0   254      1 0x00000008
	[  483.152321] Call Trace:
	[  483.152755] [<ffffffe000037954>] walk_stackframe+0x0/0xa6
	[  483.153600] [<ffffffe000037aba>] show_stack+0x2a/0x34
	[  483.154428] [<ffffffe0000569c8>] sched_show_task+0xf0/0x116
	[  483.155325] [<ffffffe00005b502>] dump_cpu_task+0x3e/0x48
	[  483.156199] [<ffffffe000084e5e>] rcu_dump_cpu_stacks+0x7c/0xb4
	[  483.157163] [<ffffffe0000842f6>] rcu_sched_clock_irq+0x3d6/0x582
	[  483.158166] [<ffffffe0000897b4>] update_process_times+0x1e/0x42
	[  483.159257] [<ffffffe000093a34>] tick_sched_handle.isra.0+0x2a/0x3a
	[  483.160240] [<ffffffe000093ce8>] tick_sched_timer+0x4e/0x92
	[  483.160992] [<ffffffe000089eb6>] __hrtimer_run_queues+0xae/0x108
	[  483.161881] [<ffffffe00008a5ac>] hrtimer_interrupt+0xca/0x1d4
	[  483.162778] [<ffffffe0004de564>] riscv_timer_interrupt+0x32/0x3a
	[  483.163542] [<ffffffe000612ad4>] do_IRQ+0xa4/0xb8
	[  483.164241] [<ffffffe000036814>] ret_from_exception+0x0/0xc
	[  483.165108] [<ffffffe000036814>] ret_from_exception+0x0/0xc
	[  515.044254] rcu: INFO: rcu_sched detected expedited stalls on CPUs/tasks: { 3-... } 116597 jiffies s: 53 root: 0x8/.
	[  515.046221] rcu: blocking rcu_node structures:
	[  515.046799] Task dump for CPU 3:
	[  515.047180] rdate           R  running task        0   254      1 0x00000008
	[  515.048476] Call Trace:
	[  515.048895] [<ffffffe00060ed48>] __schedule+0x158/0x36a

I will dig up some more into this tomorrow since it's way past by midnight here.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/syscalls.h |  2 +-
>  kernel/time/time.c       | 20 +++++++++-----------
>  2 files changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index e665920fa359..d0391cc2dae9 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -734,7 +734,7 @@ asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, struct g
>  /* kernel/time.c */
>  asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
>  				struct timezone __user *tz);
> -asmlinkage long sys_settimeofday(struct timeval __user *tv,
> +asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
>  				struct timezone __user *tz);
>  asmlinkage long sys_adjtimex(struct __kernel_timex __user *txc_p);
>  asmlinkage long sys_adjtimex_time32(struct old_timex32 __user *txc_p);
> diff --git a/kernel/time/time.c b/kernel/time/time.c
> index bc114f0be8f1..6bfbe640fd3b 100644
> --- a/kernel/time/time.c
> +++ b/kernel/time/time.c
> @@ -196,22 +196,21 @@ int do_sys_settimeofday64(const struct timespec64 *tv, const struct timezone *tz
>  	return 0;
>  }
>  
> -SYSCALL_DEFINE2(settimeofday, struct timeval __user *, tv,
> +SYSCALL_DEFINE2(settimeofday, struct __kernel_old_timeval __user *, tv,
>  		struct timezone __user *, tz)
>  {
>  	struct timespec64 new_ts;
> -	struct timeval user_tv;
>  	struct timezone new_tz;
>  
>  	if (tv) {
> -		if (copy_from_user(&user_tv, tv, sizeof(*tv)))
> +		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
> +		    get_user(new_ts.tv_nsec, &tv->tv_usec))
>  			return -EFAULT;
>  
> -		if (!timeval_valid(&user_tv))
> +		if (tv->tv_usec > USEC_PER_SEC)
>  			return -EINVAL;
>  
> -		new_ts.tv_sec = user_tv.tv_sec;
> -		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
> +		new_ts.tv_nsec *= NSEC_PER_USEC;
>  	}
>  	if (tz) {
>  		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
> @@ -245,18 +244,17 @@ COMPAT_SYSCALL_DEFINE2(settimeofday, struct old_timeval32 __user *, tv,
>  		       struct timezone __user *, tz)
>  {
>  	struct timespec64 new_ts;
> -	struct timeval user_tv;
>  	struct timezone new_tz;
>  
>  	if (tv) {
> -		if (compat_get_timeval(&user_tv, tv))
> +		if (get_user(new_ts.tv_sec, &tv->tv_sec) ||
> +		    get_user(new_ts.tv_nsec, &tv->tv_usec))
>  			return -EFAULT;
>  
> -		if (!timeval_valid(&user_tv))
> +		if (new_ts.tv_nsec > USEC_PER_SEC)
>  			return -EINVAL;
>  
> -		new_ts.tv_sec = user_tv.tv_sec;
> -		new_ts.tv_nsec = user_tv.tv_usec * NSEC_PER_USEC;
> +		new_ts.tv_nsec *= NSEC_PER_USEC;
>  	}
>  	if (tz) {
>  		if (copy_from_user(&new_tz, tz, sizeof(*tz)))
> -- 
> 2.20.0
> 
