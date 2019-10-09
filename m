Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25006D166A
	for <lists+linux-api@lfdr.de>; Wed,  9 Oct 2019 19:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732503AbfJIR3u (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Oct 2019 13:29:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49541 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732184AbfJIR3t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Oct 2019 13:29:49 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iIFmU-0002kv-Qn; Wed, 09 Oct 2019 17:29:46 +0000
Date:   Wed, 9 Oct 2019 19:29:46 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christian Kellner <ckellner@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Christian Kellner <christian@kellner.me>,
        Christian Brauner <christian@brauner.io>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v2 1/2] pidfd: show pids for nested pid namespaces in
 fdinfo
Message-ID: <20191009172944.if5x3rpkb54zs4ry@wittgenstein>
References: <20191008133641.23019-1-ckellner@redhat.com>
 <20191009160532.20674-1-ckellner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191009160532.20674-1-ckellner@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 09, 2019 at 06:05:30PM +0200, Christian Kellner wrote:
> From: Christian Kellner <christian@kellner.me>
> 
> The fdinfo file for a process file descriptor already contains the
> pid of the process in the callers namespaces. Additionally, if pid
> namespaces are configured, show the process ids of the process in
> all nested namespaces in the same format as in the procfs status
> file, i.e. "NSPid:\t%d\%d...". This allows the easy identification
> of the processes in nested namespaces.
> 
> Signed-off-by: Christian Kellner <christian@kellner.me>
> ---
> 
> Changes in v2:
> - Moved into separate function to avoid multiple ifdefs as suggested
>   by Michal Hocko
> 
>  kernel/fork.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 5a0fd518e04e..f7a59ef046e9 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1681,12 +1681,27 @@ static int pidfd_release(struct inode *inode, struct file *file)
>  }
>  
>  #ifdef CONFIG_PROC_FS
> +static void pidfd_nspid(struct seq_file *m, struct pid *pid)

If it has to be a separate helper then please make it:

static inline void print_pidfd_nspid(struct seq_file *m, struct pid_namespace *ns, struct pid *pid)
{
#ifdef CONFIG_PID_NS
	int i;

	seq_puts(m, "\nNSpid:");
	for (i = ns->level; i <= pid->level; i++) {
		ns = pid->numbers[i].ns;
		seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
	}
#endif
}

It's called nowhere else and we've already retrieved the pid_namespace
in pidfd_show_fdinfo().

> +{
> +#ifdef CONFIG_PID_NS
> +	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
> +	int i;
> +
> +	seq_puts(m, "\nNSpid:");
> +	for (i = ns->level; i <= pid->level; i++) {
> +		ns = pid->numbers[i].ns;
> +		seq_put_decimal_ull(m, "\t", pid_nr_ns(pid, ns));
> +	}
> +#endif
> +}
> +
>  static void pidfd_show_fdinfo(struct seq_file *m, struct file *f)
>  {
>  	struct pid_namespace *ns = proc_pid_ns(file_inode(m->file));
>  	struct pid *pid = f->private_data;
>  
>  	seq_put_decimal_ull(m, "Pid:\t", pid_nr_ns(pid, ns));
> +	pidfd_nspid(m, pid);
>  	seq_putc(m, '\n');
>  }
>  #endif
> -- 
> 2.21.0
> 
