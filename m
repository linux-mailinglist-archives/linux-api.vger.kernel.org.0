Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546B8114D9C
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 09:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfLFIZr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 03:25:47 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37843 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbfLFIZp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 03:25:45 -0500
Received: from [79.140.121.144] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1id8vl-0001H9-FY; Fri, 06 Dec 2019 08:25:41 +0000
Date:   Fri, 6 Dec 2019 09:25:40 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>, oleg@redhat.com
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        tycho@tycho.ws
Subject: Re: [RFC PATCH] ptrace: add PTRACE_GETFD request
Message-ID: <20191206082539.gmefytwu3ylixj5d@wittgenstein>
References: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191205234450.GA26369@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[+ Oleg, the maintainer. This needs to see his review before anything
 can happen to this series.]

On Thu, Dec 05, 2019 at 11:44:53PM +0000, Sargun Dhillon wrote:
> PTRACE_GETFD is a generic ptrace API that allows the tracer to
> get file descriptors from the traceee.
> 
> The primary reason to use this syscall is to allow sandboxers to
> take action on an FD on behalf of the tracee. For example, this
> can be combined with seccomp's user notification feature to extract
> a file descriptor and call privileged syscalls, like binding
> a socket to a privileged port.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  include/uapi/linux/ptrace.h |  5 +++++
>  kernel/ptrace.c             | 39 +++++++++++++++++++++++++++++++++++--
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/ptrace.h b/include/uapi/linux/ptrace.h
> index a71b6e3b03eb..2b69f759826a 100644
> --- a/include/uapi/linux/ptrace.h
> +++ b/include/uapi/linux/ptrace.h
> @@ -101,6 +101,11 @@ struct ptrace_syscall_info {
>  	};
>  };
>  
> +/* This gets a file descriptor from a running process. It doesn't require the
> + * process to be stopped.
> + */
> +#define PTRACE_GETFD	0x420f
> +
>  /*
>   * These values are stored in task->ptrace_message
>   * by tracehook_report_syscall_* to describe the current syscall-stop.
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index cb9ddcc08119..a1d7b289fe8e 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -31,6 +31,7 @@
>  #include <linux/cn_proc.h>
>  #include <linux/compat.h>
>  #include <linux/sched/signal.h>
> +#include <linux/fdtable.h>
>  
>  #include <asm/syscall.h>	/* for syscall_get_* */
>  
> @@ -994,6 +995,37 @@ ptrace_get_syscall_info(struct task_struct *child, unsigned long user_size,
>  }
>  #endif /* CONFIG_HAVE_ARCH_TRACEHOOK */
>  
> +static int ptrace_getfd(struct task_struct *child, unsigned long fd)
> +{
> +	struct files_struct *files;
> +	struct file *file;
> +	int ret = 0;
> +
> +	files = get_files_struct(child);
> +	if (!files)
> +		return -ENOENT;
> +
> +	spin_lock(&files->file_lock);
> +	file = fcheck_files(files, fd);
> +	if (!file)
> +		ret = -EBADF;
> +	else
> +		get_file(file);
> +	spin_unlock(&files->file_lock);
> +	put_files_struct(files);
> +
> +	if (ret)
> +		goto out;
> +
> +	ret = get_unused_fd_flags(0);
> +	if (ret >= 0)
> +		fd_install(ret, file);
> +
> +	fput(file);
> +out:
> +	return ret;
> +}
> +
>  int ptrace_request(struct task_struct *child, long request,
>  		   unsigned long addr, unsigned long data)
>  {
> @@ -1222,7 +1254,9 @@ int ptrace_request(struct task_struct *child, long request,
>  	case PTRACE_SECCOMP_GET_METADATA:
>  		ret = seccomp_get_metadata(child, addr, datavp);
>  		break;
> -
> +	case PTRACE_GETFD:
> +		ret = ptrace_getfd(child, data);
> +		break;
>  	default:
>  		break;
>  	}
> @@ -1265,7 +1299,8 @@ SYSCALL_DEFINE4(ptrace, long, request, long, pid, unsigned long, addr,
>  	}
>  
>  	ret = ptrace_check_attach(child, request == PTRACE_KILL ||
> -				  request == PTRACE_INTERRUPT);
> +				  request == PTRACE_INTERRUPT ||
> +				  request == PTRACE_GETFD);
>  	if (ret < 0)
>  		goto out_put_task_struct;
>  
> -- 
> 2.20.1
> 
