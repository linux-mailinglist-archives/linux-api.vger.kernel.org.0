Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D162DD4EF5
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 12:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbfJLKVh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 06:21:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49726 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfJLKVg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 06:21:36 -0400
Received: from [185.81.136.17] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iJEWZ-0006w3-Ut; Sat, 12 Oct 2019 10:21:24 +0000
Date:   Sat, 12 Oct 2019 12:21:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     jannh@google.com
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@kellner.me, ckellner@redhat.com, cyphar@cyphar.com,
        elena.reshetova@intel.com, guro@fb.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] pidfd: add NSpid entries to fdinfo
Message-ID: <20191012102119.qq2adlnxjxrkslca@wittgenstein>
References: <CAG48ez1hk9d-qAPcRy9QOgNuO8u3Y_hu_3=GZoFYLY+oMdo8xg@mail.gmail.com>
 <20191012101922.24168-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191012101922.24168-1-christian.brauner@ubuntu.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Oct 12, 2019 at 12:19:22PM +0200, Christian Brauner wrote:
> Currently, the fdinfo file of contains the field Pid:
> It contains the pid a given pidfd refers to in the pid namespace of the
> opener's procfs instance.
> If the pid namespace of the process is not a descendant of the pid
> namespace of the procfs instance 0 will be shown as its pid. This is
> similar to calling getppid() on a process who's parent is out of it's
> pid namespace (e.g. when moving a process into a sibling pid namespace
> via setns()).
> 
> Add an NSpid field for easy retrieval of the pid in all descendant pid
> namespaces:
> If pid namespaces are supported this field will contain the pid a given
> pidfd refers to for all descendant pid namespaces starting from the
> current pid namespace of the opener's procfs instance, i.e. the first
> pid entry for Pid and NSpid will be identical.
> If the pid namespace of the process is not a descendant of the pid
> namespace of the procfs instance 0 will be shown as its first NSpid and
> no other NSpid entries will be shown.
> Note that this differs from the Pid and NSpid fields in
> /proc/<pid>/status where Pid and NSpid are always shown relative to the
> pid namespace of the opener's procfs instace. The difference becomes
> obvious when sending around a pidfd between pid namespaces from
> different trees, i.e. where no ancestoral relation is present between
> the pid namespaces:
> 1. sending around pidfd:
> - create two new pid namespaces ns1 and ns2 in the initial pid namespace
>   (Also take care to create new mount namespaces in the new pid
>   namespace and mount procfs.)
> - create a process with a pidfd in ns1
> - send pidfd from ns1 to ns2
> - read /proc/self/fdinfo/<pidfd> and observe that Pid and NSpid entry
>   are 0
> - create a process with a pidfd in
> - open a pidfd for a process in the initial pid namespace
> 2. sending around /proc/<pid>/status fd:
> - create two new pid namespaces ns1 and ns2 in the initial pid namespace
>   (Also take care to create new mount namespaces in the new pid
>   namespace and mount procfs.)
> - create a process in ns1
> - open /proc/<pid>/status in the initial pid namespace for the process
>   you created in ns1
> - send statusfd from initial pid namespace to ns2
> - read statusfd and observe:
>   - that Pid will contain the pid of the process as seen from the init
>   - that NSpid will contain the pids of the process for all descendant
>     pid namespaces starting from the initial pid namespace
> 
> Cc: Jann Horn <jannh@google.com>
> Cc: linux-api@vger.kernel.org
> Co-Developed-by: Christian Kellner <christian@kellner.me>
> Signed-off-by: Christian Kellner <christian@kellner.me>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

I think this might be more what we want.
I tried to think of cases where the first entry of Pid is not identical
to the first entry of NSpid but I came up with none. Maybe you do, Jann?

Christian, this is just a quick stab I took. Feel free to pick this up
as a template.

Thanks!
Christian

> ---
>  kernel/fork.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1f6c45f6a734..b155bad92d9c 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1695,12 +1695,83 @@ static int pidfd_release(struct inode *inode, struct file *file)
>  }
>  
>  #ifdef CONFIG_PROC_FS
> +/**
> + * pidfd_show_fdinfo - print information about a pidfd
> + * @m: proc fdinfo file
> + * @f: file referencing a pidfd
> + *
> + * Pid:
> + * This function will print the pid a given pidfd refers to in the pid
> + * namespace of the opener's procfs instance.
> + * If the pid namespace of the process is not a descendant of the pid
> + * namespace of the procfs instance 0 will be shown as its pid. This is
> + * similar to calling getppid() on a process who's parent is out of it's
> + * pid namespace (e.g. when moving a process into a sibling pid namespace
> + * via setns()).
> + *
> + * NSpid:
> + * If pid namespaces are supported then this function will also print the
> + * pid a given pidfd refers to for all descendant pid namespaces starting
> + * from the current pid namespace of the opener's procfs instance, i.e. the
> + * first pid entry for Pid and NSpid will be identical.
> + * If the pid namespace of the process is not a descendant of the pid
> + * namespace of the procfs instance 0 will be shown as its first NSpid and
> + * no other NSpid entries will be shown.
> + * Note that this differs from the Pid and NSpid fields in
> + * /proc/<pid>/status where Pid and NSpid are always shown relative to the
> + * pid namespace of the opener's procfs instace. The difference becomes
> + * obvious when sending around a pidfd between pid namespaces from
> + * different trees, i.e. where no ancestoral relation is present between
> + * the pid namespaces:
> + * 1. sending around pidfd:
> + * - create two new pid namespaces ns1 and ns2 in the initial pid namespace
> + *   (Also take care to create new mount namespaces in the new pid
> + *   namespace and mount procfs.)
> + * - create a process with a pidfd in ns1
> + * - send pidfd from ns1 to ns2
> + * - read /proc/self/fdinfo/<pidfd> and observe that Pid and NSpid entry
> + *   are 0
> + * - create a process with a pidfd in
> + * - open a pidfd for a process in the initial pid namespace
> + * 2. sending around /proc/<pid>/status fd:
> + * - create two new pid namespaces ns1 and ns2 in the initial pid namespace
> + *   (Also take care to create new mount namespaces in the new pid
> + *   namespace and mount procfs.)
> + * - create a process in ns1
> + * - open /proc/<pid>/status in the initial pid namespace for the process
> + *   you created in ns1
> + * - send statusfd from initial pid namespace to ns2
> + * - read statusfd and observe:
> + *   - that Pid will contain the pid of the process as seen from the init
> + *   - that NSpid will contain the pids of the process for all descendant
> + *     pid namespaces starting from the initial pid namespace
> + */
>  static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  {
>  	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
>  	struct pid *pid = f->private_data;
> +	pid_t nr = pid_nr_ns(pid, ns);
> +
> +	seq_put_decimal_ull(m, "Pid:\t", nr);
> +
> +#ifdef CONFIG_PID_NS
> +	seq_puts(m, "\nNSpid:");
> +	if (nr == 0) {
> +		/*
> +		 * If nr is zero the pid namespace of the procfs and the
> +		 * pid namespace of the pidfd are neither the same pid
> +		 * namespace nor are they ancestors. Since NSpid and Pid
> +		 * are always identical in their first entry shortcut it
> +		 * and simply print 0.
> +		 */
> +		seq_put_decimal_ull(m, "\t", nr);
> +	} else {
> +		int i;
> +		for (i = ns->level; i <= pid->level; i++)
> +			seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, pid->numbers[i].ns));
> +	}
> +#endif
>  
> -	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
>  	seq_putc(m, '\n');
>  }
>  #endif
> -- 
> 2.23.0
> 
