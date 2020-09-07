Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6916625FC82
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgIGPAw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 11:00:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39782 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgIGOz7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 10:55:59 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFIYl-0003o4-3d; Mon, 07 Sep 2020 14:55:55 +0000
Date:   Mon, 7 Sep 2020 16:55:54 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>
Cc:     linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RESEND RFC PATCH 5/5] pidfd_mem: implemented remote memory
 mapping system call
Message-ID: <20200907145554.5yxgrdi6b3gkmt5t@wittgenstein>
References: <20200904113116.20648-1-alazar@bitdefender.com>
 <20200904113116.20648-6-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904113116.20648-6-alazar@bitdefender.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 02:31:16PM +0300, Adalbert Lazăr wrote:
> From: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
> 
> This system call returns 2 fds for inspecting the address space of a
> remote process: one for control and one for access. Use according to
> remote mapping specifications.
> 
> Cc: Christian Brauner <christian@brauner.io>
> Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
> Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |  1 +
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  include/linux/pid.h                    |  1 +
>  include/linux/syscalls.h               |  1 +
>  include/uapi/asm-generic/unistd.h      |  2 +
>  kernel/exit.c                          |  2 +-
>  kernel/pid.c                           | 55 ++++++++++++++++++++++++++
>  7 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 54581ac671b4..ca1b5a32dbc5 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -440,5 +440,6 @@
>  433	i386	fspick			sys_fspick
>  434	i386	pidfd_open		sys_pidfd_open
>  435	i386	clone3			sys_clone3
> +436     i386    pidfd_mem               sys_pidfd_mem
>  437	i386	openat2			sys_openat2
>  438	i386	pidfd_getfd		sys_pidfd_getfd
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 37b844f839bc..6138d3d023f8 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -357,6 +357,7 @@
>  433	common	fspick			sys_fspick
>  434	common	pidfd_open		sys_pidfd_open
>  435	common	clone3			sys_clone3
> +436     common  pidfd_mem               sys_pidfd_mem
>  437	common	openat2			sys_openat2
>  438	common	pidfd_getfd		sys_pidfd_getfd
>  
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index cc896f0fc4e3..9ec23ab23fd4 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -76,6 +76,7 @@ extern const struct file_operations pidfd_fops;
>  
>  struct file;
>  
> +extern struct pid *pidfd_get_pid(unsigned int fd);
>  extern struct pid *pidfd_pid(const struct file *file);
>  
>  static inline struct pid *get_pid(struct pid *pid)
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1815065d52f3..621f3d52ed4e 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -934,6 +934,7 @@ asmlinkage long sys_clock_adjtime32(clockid_t which_clock,
>  asmlinkage long sys_syncfs(int fd);
>  asmlinkage long sys_setns(int fd, int nstype);
>  asmlinkage long sys_pidfd_open(pid_t pid, unsigned int flags);
> +asmlinkage long sys_pidfd_mem(int pidfd, int __user *fds, unsigned int flags);
>  asmlinkage long sys_sendmmsg(int fd, struct mmsghdr __user *msg,
>  			     unsigned int vlen, unsigned flags);
>  asmlinkage long sys_process_vm_readv(pid_t pid,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index 3a3201e4618e..2663afc03c86 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -850,6 +850,8 @@ __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
>  #define __NR_clone3 435
>  __SYSCALL(__NR_clone3, sys_clone3)
>  #endif
> +#define __NR_pidfd_mem 436
> +__SYSCALL(__NR_pidfd_mem, sys_pidfd_mem)
>  
>  #define __NR_openat2 437
>  __SYSCALL(__NR_openat2, sys_openat2)
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 389a88cb3081..37cd8949e606 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1464,7 +1464,7 @@ static long do_wait(struct wait_opts *wo)
>  	return retval;
>  }
>  
> -static struct pid *pidfd_get_pid(unsigned int fd)
> +struct pid *pidfd_get_pid(unsigned int fd)
>  {
>  	struct fd f;
>  	struct pid *pid;
> diff --git a/kernel/pid.c b/kernel/pid.c
> index c835b844aca7..c9c49edf4a8a 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -42,6 +42,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
> +#include <linux/remote_mapping.h>
>  
>  struct pid init_struct_pid = {
>  	.count		= REFCOUNT_INIT(1),
> @@ -565,6 +566,60 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>  	return fd;
>  }
>  
> +/**
> + * pidfd_mem() - Allow access to process address space.
> + *
> + * @pidfd: pid file descriptor for the target process
> + * @fds:   array where the control and access file descriptors are returned
> + * @flags: flags to pass
> + *
> + * This creates a pair of file descriptors used to gain access to the
> + * target process memory. The control fd is used to establish a linear
> + * mapping between an offset range and a userspace address range.
> + * The access fd is used to mmap(offset range) on the client side.
> + *
> + * Return: On success, 0 is returned.
> + *         On error, a negative errno number will be returned.
> + */
> +SYSCALL_DEFINE3(pidfd_mem, int, pidfd, int __user *, fds, unsigned int, flags)
> +{
> +	struct pid *pid;
> +	struct task_struct *task;
> +	int ret_fds[2];
> +	int ret;
> +
> +	if (pidfd < 0)
> +		return -EINVAL;

This needs to be EBADF.

> +	if (!fds)
> +		return -EINVAL;

If this API holds up, I think similar to what Florian suggested, a
struct would be nicer for userspace. Sm like:

struct rmemfds {
	s32 memfd1;
	s32 memfd2;
}

and passing it a size

pidfd_mem(int pidfd, struct rmemfd *fds, size_t size, unsigned int, flags)

and then copy_struct_from_user() will take care to do the right thing
for you.

> +	if (flags)
> +		return -EINVAL;
> +
> +	pid = pidfd_get_pid(pidfd);
> +	if (IS_ERR(pid))
> +		return PTR_ERR(pid);
> +
> +	task = get_pid_task(pid, PIDTYPE_PID);
> +	put_pid(pid);
> +	if (IS_ERR(task))
> +		return PTR_ERR(task);
> +
> +	ret = -EPERM;
> +	if (unlikely(task == current) || capable(CAP_SYS_PTRACE))
> +		ret = task_remote_map(task, ret_fds);
> +	put_task_struct(task);
> +	if (IS_ERR_VALUE((long)ret))
> +		return ret;
> +
> +	if (copy_to_user(fds, ret_fds, sizeof(ret_fds))) {
> +		put_unused_fd(ret_fds[0]);
> +		put_unused_fd(ret_fds[1]);
> +		return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
>  void __init pid_idr_init(void)
>  {
>  	/* Verify no one has done anything silly: */
