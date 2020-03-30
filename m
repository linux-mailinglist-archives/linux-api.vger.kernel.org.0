Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA705198284
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 19:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgC3Rjw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 13:39:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36961 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgC3Rjv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 13:39:51 -0400
Received: by mail-pf1-f196.google.com with SMTP id h72so8945557pfe.4
        for <linux-api@vger.kernel.org>; Mon, 30 Mar 2020 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zuZsbdVDQCfR2Ns3FiP6U9GsK2CJ/bgMt0HZKKCU9XM=;
        b=PhwDNvOZtoN+K2YwYy4Wtvi8APmim6kBORKKOxm5Y00S37slWl2++yrkZgYaxr85jx
         EtuxWsIucN5ODVhcZuYyzo8+1Joc6NymcBJdIRYupA5Ucs6Q/DpqJaOpjQWU9tZrqJ8M
         1hzdHvOuT9+p93sICbxFef8aP0Bi+5SaByFqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zuZsbdVDQCfR2Ns3FiP6U9GsK2CJ/bgMt0HZKKCU9XM=;
        b=ZASeC+NEOUrrfJrxAiu1AUfKxoNUXGwmhxFUbPF+ic0XXJSZK3o7tJkP7L5JkVGwxH
         nmoxM3Tvm2KdmJDs6Em3XxMpLfhQqpeEoyFoU/CdeV/hbWUsJodU0Djmd2F6G3/tYKOe
         wjN52JaU0hx75eq44vT6zdgDuiX0Y2TBv6NtIzwYh84j5VVy8OGeF2B0cFSsKQwyz0P8
         O8CLe1iXP2Tgtq2AmY6qsJsXt6i53Z9MZTXHXjtCqU34sMnpp7MOxnOPEQEEW3dMnsIB
         ullsaQW8ogDwTllAuoXlmbcTjlhp6NukyWTXyrM3vjJhzQg6XrfEpYjrOjgiQ9r2rBvb
         1rvw==
X-Gm-Message-State: ANhLgQ3Rt9cUD2uZMkTZljqailca10mBDSkmHzW0uzxtRl0QLetru8zF
        iFg0RzFBKLY3rVSpQE6GOYy67Q==
X-Google-Smtp-Source: ADFU+vvLgDpr0Kmtok+NiSOwmrtkpT0fKaHmBS4/cMN5Dgi4fWbQWcyjXLmCXjtOJuI4K6EIZjCQ1w==
X-Received: by 2002:a62:18cf:: with SMTP id 198mr14270160pfy.277.1585589990028;
        Mon, 30 Mar 2020 10:39:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s14sm10090709pgl.4.2020.03.30.10.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:39:48 -0700 (PDT)
Date:   Mon, 30 Mar 2020 10:39:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003301035.8688FCE5@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330115535.3215-2-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 30, 2020 at 01:55:33PM +0200, Vlastimil Babka wrote:
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
> registered sysctl tables. Errors due to e.g. invalid parameter name or value
> are reported in the kernel log.
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
> ---
>  .../admin-guide/kernel-parameters.txt         |   9 ++
>  fs/proc/proc_sysctl.c                         | 100 ++++++++++++++++++
>  include/linux/sysctl.h                        |   4 +
>  init/main.c                                   |   2 +
>  4 files changed, 115 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..81ff626fc700 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4793,6 +4793,15 @@
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
> index c75bb4632ed1..653188c9c4c9 100644
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
> @@ -1725,3 +1726,102 @@ int __init proc_sys_init(void)
>  
>  	return sysctl_init();
>  }
> +
> +/* Set sysctl value passed on kernel command line. */
> +static int process_sysctl_arg(char *param, char *val,
> +			       const char *unused, void *arg)
> +{
> +	char *path;
> +	struct vfsmount *proc_mnt = *((struct vfsmount **)arg);

I would just make this:

	struct vfsmount **proc_mnt = (struct vfsmount **)arg;


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
> +	if (!proc_mnt) {

	if (!*proc_mnt) {

I would also add a comment here to explain that this is doing an
on-demand mount so that it doesn't have to mount proc if there are not
sysctl parameters.

> +		proc_fs_type = get_fs_type("proc");
> +		if (!proc_fs_type) {
> +			pr_err("Failed to find procfs to set sysctl from command line");
> +			return 0;
> +		}
> +		proc_mnt = kern_mount(proc_fs_type);

		*proc_mnt = kern_mount(proc_fs_type);

> +		put_filesystem(proc_fs_type);
> +		if (IS_ERR(proc_mnt)) {

		if (IS_ERR(*proc_mnt)) {

> +			pr_err("Failed to mount procfs to set sysctl from command line");
> +			return 0;
> +		}
> +		*((struct vfsmount **)arg) = proc_mnt;

Then drop this line.

> +	}
> +
> +	path = kasprintf(GFP_KERNEL, "sys/%s", param);
> +	if (!path)
> +		panic("%s: Failed to allocate path for %s\n", __func__, param);
> +	strreplace(path, '.', '/');
> +
> +	file = file_open_root(proc_mnt->mnt_root, proc_mnt, path, O_WRONLY, 0);

	file = file_open_root((*proc_mnt)->mnt_root, *proc_mnt, path, O_WRONLY, 0);

> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		if (err == -ENOENT)
> +			pr_err("Failed to set sysctl parameter '%s=%s': parameter not found",
> +				param, val);
> +		else if (err == -EACCES)
> +			pr_err("Failed to set sysctl parameter '%s=%s': permission denied (read-only?)",
> +				param, val);
> +		else
> +			pr_err("Error %pe opening proc file to set sysctl parameter '%s=%s'",
> +				file, param, val);
> +		goto out;
> +	}
> +	len = strlen(val);
> +	wret = kernel_write(file, val, len, &pos);
> +	if (wret < 0) {
> +		err = wret;
> +		if (err == -EINVAL)
> +			pr_err("Failed to set sysctl parameter '%s=%s': invalid value",
> +				param, val);
> +		else
> +			pr_err("Error %pe writing to proc file to set sysctl parameter '%s=%s'",
> +				ERR_PTR(err), param, val);
> +	} else if (wret != len) {
> +		pr_err("Wrote only %ld bytes of %d writing to proc file %s to set sysctl parameter '%s=%s'",
> +			wret, len, path, param, val);
> +	}
> +
> +	err = filp_close(file, NULL);
> +	if (err)
> +		pr_err("Error %pe closing proc file to set sysctl parameter '%s=%s'",
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
> index 02fa84493f23..5f3f2a00d75f 100644
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
> +void do_sysctl_args(void)

As with the others in the no-op case:

static inline void do_sysctl_args(void)

> +{
> +}
>  #endif /* CONFIG_SYSCTL */
>  
>  int sysctl_max_threads(struct ctl_table *table, int write,
> diff --git a/init/main.c b/init/main.c
> index ee4947af823f..a91ea166a731 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1367,6 +1367,8 @@ static int __ref kernel_init(void *unused)
>  
>  	rcu_end_inkernel_boot();
>  
> +	do_sysctl_args();
> +
>  	if (ramdisk_execute_command) {
>  		ret = run_init_process(ramdisk_execute_command);
>  		if (!ret)
> -- 
> 2.25.1
> 

Otherwise, yes, looks good!

-- 
Kees Cook
