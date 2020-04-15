Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2871A916C
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 05:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgDODIN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Apr 2020 23:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728080AbgDODIM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Apr 2020 23:08:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF667C061A0F
        for <linux-api@vger.kernel.org>; Tue, 14 Apr 2020 20:08:11 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a22so1720329pjk.5
        for <linux-api@vger.kernel.org>; Tue, 14 Apr 2020 20:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RbbRN4tTRukw580GXICKlOJNz09EKjClZZ/US2LlT6I=;
        b=K80hv/+EtlcxxLahv4TCOQN4Ugh4Av64A25eGFGlpFjrXOTgdcfh/Fg3F4Nb4DFZ46
         QOd6LO/KatUftee9UsZneaDdFhe2krjrdax37G5WzNGOAYsgB8OTXuZWQ1sYf+fsW+rk
         g3cDz4nbQhQXb+WbD742RRFu+guHxdODbyV/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RbbRN4tTRukw580GXICKlOJNz09EKjClZZ/US2LlT6I=;
        b=FFzw9KLTcSK2jywaUe69pNT6yZP5oXTHZgu9jUy++xUQBzdwcPfxuHMNmSpb1qqUB/
         gLrOBPVO7m1+C+CKAzKphmnx+T+3+6F0DneI2bwxXchpkix0Yp+HS1LevK1tGAhlc4EA
         920wSmqGdjmvvv3zkRVSGVIPxJsGVdI+/1Qg1t7b4XZA05Rx+qaZG44gAeGm3ehFMftO
         ic1XXfP4SEeXPon5vKnhKa75jpXxZzH6uQMQIYuflCAdZlyx0wCfBaHBCDGY2RxsT8Yz
         W9qf8B9mwhCuWYzQC2vRf/hYdubrudjwZ7Z6kJB3S3FFvxVFfNrJqypDjb9uXn9xM9ya
         Mtgw==
X-Gm-Message-State: AGi0PuaSraTaSqOR55dG6XbZJ2itylSxWRiyIPQt17snAOP2rjZkA1XI
        zzuGPUlVSVaVTkkWb99rdE+NRg==
X-Google-Smtp-Source: APiQypLfwKP3MCm6TccPOuS/DIxG/Wy8YL+JNdiVTrNS5bSIKIgvD6zUr3m8KOo4PICmkbrpBws8ow==
X-Received: by 2002:a17:902:342:: with SMTP id 60mr3049777pld.29.1586920091183;
        Tue, 14 Apr 2020 20:08:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a17sm309337pfr.24.2020.04.14.20.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 20:08:09 -0700 (PDT)
Date:   Tue, 14 Apr 2020 20:08:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202004142007.3C2818CD@keescook>
References: <20200414113222.16959-1-vbabka@suse.cz>
 <20200414113222.16959-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414113222.16959-2-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Apr 14, 2020 at 01:32:20PM +0200, Vlastimil Babka wrote:
> A recently proposed patch to add vm_swappiness command line parameter in
> addition to existing sysctl [1] made me wonder why we don't have a general
> support for passing sysctl parameters via command line. Googling found only
> somebody else wondering the same [2], but I haven't found any prior discussion
> with reasons why not to do this.
> 
> Settings the vm_swappiness issue aside (the underlying issue might be solved in
> a different way), quick search of kernel-parameters.txt shows there are already
> some that exist as both sysctl and kernel parameter - hung_task_panic,
> nmi_watchdog, numa_zonelist_order, traceoff_on_warning. A general mechanism
> would remove the need to add more of those one-offs and might be handy in
> situations where configuration by e.g. /etc/sysctl.d/ is impractical.
> 
> Hence, this patch adds a new parse_args() pass that looks for parameters
> prefixed by 'sysctl.' and tries to interpret them as writes to the
> corresponding sys/ files using an temporary in-kernel procfs mount. This
> mechanism was suggested by Eric W. Biederman [3], as it handles all dynamically
> registered sysctl tables, even though we don't handle modular sysctls. Errors
> due to e.g. invalid parameter name or value are reported in the kernel log.
> 
> The processing is hooked right before the init process is loaded, as some
> handlers might be more complicated than simple setters and might need some
> subsystems to be initialized. At the moment the init process can be started and
> eventually execute a process writing to /proc/sys/ then it should be also fine
> to do that from the kernel.
> 
> Sysctls registered later on module load time are not set by this mechanism -
> it's expected that in such scenarios, setting sysctl values from userspace is
> practical enough.
> 
> [1] https://lore.kernel.org/r/BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com/
> [2] https://unix.stackexchange.com/questions/558802/how-to-set-sysctl-using-kernel-command-line-parameter
> [3] https://lore.kernel.org/r/87bloj2skm.fsf@x220.int.ebiederm.org/
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Looks great!

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  .../admin-guide/kernel-parameters.txt         |   9 ++
>  fs/proc/proc_sysctl.c                         | 107 ++++++++++++++++++
>  include/linux/sysctl.h                        |   4 +
>  init/main.c                                   |   2 +
>  4 files changed, 122 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index f2a93c8679e8..fd38f1e8a2bf 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4891,6 +4891,15 @@
>  
>  	switches=	[HW,M68k]
>  
> +	sysctl.*=	[KNL]
> +			Set a sysctl parameter, right before loading the init
> +			process, as if the value was written to the respective
> +			/proc/sys/... file. Both '.' and '/' are recognized as
> +			separators. Unrecognized parameters and invalid values
> +			are reported in the kernel log. Sysctls registered
> +			later by a loaded module cannot be set this way.
> +			Example: sysctl.vm.swappiness=40
> +
>  	sysfs.deprecated=0|1 [KNL]
>  			Enable/disable old style sysfs layout for old udev
>  			on older distributions. When this option is enabled
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b6f5d459b087..7804da5f5be0 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -14,6 +14,7 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/bpf-cgroup.h>
> +#include <linux/mount.h>
>  #include "internal.h"
>  
>  static const struct dentry_operations proc_sys_dentry_operations;
> @@ -1692,3 +1693,109 @@ int __init proc_sys_init(void)
>  
>  	return sysctl_init();
>  }
> +
> +/* Set sysctl value passed on kernel command line. */
> +static int process_sysctl_arg(char *param, char *val,
> +			       const char *unused, void *arg)
> +{
> +	char *path;
> +	struct vfsmount **proc_mnt = arg;
> +	struct file_system_type *proc_fs_type;
> +	struct file *file;
> +	int len;
> +	int err;
> +	loff_t pos = 0;
> +	ssize_t wret;
> +
> +	if (strncmp(param, "sysctl", sizeof("sysctl") - 1))
> +		return 0;
> +
> +	param += sizeof("sysctl") - 1;
> +
> +	if (param[0] != '/' && param[0] != '.')
> +		return 0;
> +
> +	param++;
> +
> +	/*
> +	 * To set sysctl options, we use a temporary mount of proc, look up the
> +	 * respective sys/ file and write to it. To avoid mounting it when no
> +	 * options were given, we mount it only when the first sysctl option is
> +	 * found. Why not a persistent mount? There are problems with a
> +	 * persistent mount of proc in that it forces userspace not to use any
> +	 * proc mount options.
> +	 */
> +	if (!*proc_mnt) {
> +		proc_fs_type = get_fs_type("proc");
> +		if (!proc_fs_type) {
> +			pr_err("Failed to find procfs to set sysctl from command line\n");
> +			return 0;
> +		}
> +		*proc_mnt = kern_mount(proc_fs_type);
> +		put_filesystem(proc_fs_type);
> +		if (IS_ERR(*proc_mnt)) {
> +			pr_err("Failed to mount procfs to set sysctl from command line\n");
> +			return 0;
> +		}
> +	}
> +
> +	path = kasprintf(GFP_KERNEL, "sys/%s", param);
> +	if (!path)
> +		panic("%s: Failed to allocate path for %s\n", __func__, param);
> +	strreplace(path, '.', '/');
> +
> +	file = file_open_root((*proc_mnt)->mnt_root, *proc_mnt, path, O_WRONLY, 0);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		if (err == -ENOENT)
> +			pr_err("Failed to set sysctl parameter '%s=%s': parameter not found\n",
> +				param, val);
> +		else if (err == -EACCES)
> +			pr_err("Failed to set sysctl parameter '%s=%s': permission denied (read-only?)\n",
> +				param, val);
> +		else
> +			pr_err("Error %pe opening proc file to set sysctl parameter '%s=%s'\n",
> +				file, param, val);
> +		goto out;
> +	}
> +	len = strlen(val);
> +	wret = kernel_write(file, val, len, &pos);
> +	if (wret < 0) {
> +		err = wret;
> +		if (err == -EINVAL)
> +			pr_err("Failed to set sysctl parameter '%s=%s': invalid value\n",
> +				param, val);
> +		else
> +			pr_err("Error %pe writing to proc file to set sysctl parameter '%s=%s'\n",
> +				ERR_PTR(err), param, val);
> +	} else if (wret != len) {
> +		pr_err("Wrote only %zd bytes of %d writing to proc file %s to set sysctl parameter '%s=%s\n",
> +			wret, len, path, param, val);
> +	}
> +
> +	err = filp_close(file, NULL);
> +	if (err)
> +		pr_err("Error %pe closing proc file to set sysctl parameter '%s=%s\n",
> +			ERR_PTR(err), param, val);
> +out:
> +	kfree(path);
> +	return 0;
> +}
> +
> +void do_sysctl_args(void)
> +{
> +	char *command_line;
> +	struct vfsmount *proc_mnt = NULL;
> +
> +	command_line = kstrdup(saved_command_line, GFP_KERNEL);
> +	if (!command_line)
> +		panic("%s: Failed to allocate copy of command line\n", __func__);
> +
> +	parse_args("Setting sysctl args", command_line,
> +		   NULL, 0, -1, -1, &proc_mnt, process_sysctl_arg);
> +
> +	if (proc_mnt)
> +		kern_unmount(proc_mnt);
> +
> +	kfree(command_line);
> +}
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 02fa84493f23..bee62d30ebdb 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -206,6 +206,7 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
>  void unregister_sysctl_table(struct ctl_table_header * table);
>  
>  extern int sysctl_init(void);
> +void do_sysctl_args(void);
>  
>  extern struct ctl_table sysctl_mount_point[];
>  
> @@ -236,6 +237,9 @@ static inline void setup_sysctl_set(struct ctl_table_set *p,
>  {
>  }
>  
> +static inline void do_sysctl_args(void)
> +{
> +}
>  #endif /* CONFIG_SYSCTL */
>  
>  int sysctl_max_threads(struct ctl_table *table, int write,
> diff --git a/init/main.c b/init/main.c
> index a48617f2e5e5..7b43118215d6 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1372,6 +1372,8 @@ static int __ref kernel_init(void *unused)
>  
>  	rcu_end_inkernel_boot();
>  
> +	do_sysctl_args();
> +
>  	if (ramdisk_execute_command) {
>  		ret = run_init_process(ramdisk_execute_command);
>  		if (!ret)
> -- 
> 2.26.0
> 

-- 
Kees Cook
