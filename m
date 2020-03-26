Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBDE51948BD
	for <lists+linux-api@lfdr.de>; Thu, 26 Mar 2020 21:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgCZUY1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Mar 2020 16:24:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46984 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgCZUY1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 26 Mar 2020 16:24:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id q3so3339595pff.13
        for <linux-api@vger.kernel.org>; Thu, 26 Mar 2020 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zBgzqhTqK1mBdkfW2kfeNGpuWAOmIlYkjSer/QpmXaY=;
        b=hF44TNvRZS6fP/TBLQ+eTUo65LcFLunCU56NfImQ9qkk/KI1S64ZjFJSV50o8oFjHP
         4PBkXGevimND9FPv2cJfP75rxrLTvh+CrIpjNYOVCRga33pXkPBdAYg71WGGmp0AINsY
         J1gYrtnzja8jNB2exIZLkNLJW/rbvxpuJ3mhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zBgzqhTqK1mBdkfW2kfeNGpuWAOmIlYkjSer/QpmXaY=;
        b=Ga34AnIvIJ/AV1SYZ68gDDKwQIvnZmSY65frjaMvL2dz8R2cUvi2E0m+se8mBbPwCv
         GO2+OYAuIlxCmYw51UfuiQh+UEdwIPFU218nLRo0DpwOp99yf9dsce9VmDJNrl5VSip3
         sv93cO7753nbL/4JB69FmRIWwIuXvg0i8INphEUKcanpCARefwfzKQuWJs8nAQvkm+Rg
         Tj25AOEUWKyFeJN63aN37dQcAC9tF4JB27gTeIzgkbmIxaP/1klI8WbNuqr/1hC2zGcM
         Wqo12azIuPHYU5oDT6hyJc3XEaD6tnEUTeaWFR6sYrnBHh/xY0vmhwcpxJaqQF4Tkzu0
         vwkQ==
X-Gm-Message-State: ANhLgQ2GW91iIwuGSRPAps9ORvpHE9Q7wRtd0l1tH7U1bsOG7Hf+svvd
        SCnkrlGYrlV3IsZAHc+bVcCTsA==
X-Google-Smtp-Source: ADFU+vutXGwaXmeKf8yD5wYFArutZREIVw5lpPEfxULQO9/7LswEhDltNx5M2vIOpo+19JNWKYCvVQ==
X-Received: by 2002:a62:7c15:: with SMTP id x21mr11286758pfc.132.1585254263685;
        Thu, 26 Mar 2020 13:24:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y22sm2377221pfr.68.2020.03.26.13.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:24:21 -0700 (PDT)
Date:   Thu, 26 Mar 2020 13:24:20 -0700
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
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>
Subject: Re: [RFC v3 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003261256.950F1E5@keescook>
References: <20200326181606.7027-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326181606.7027-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 26, 2020 at 07:16:05PM +0100, Vlastimil Babka wrote:
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
> Changes in v3:
> - use temporary procfs mount as Eric suggested. Seems to be the better option
>   after all. Naming wise it simply converts all . to / - according to strace the
>   sysctl tool seems to be doing the same.
> 
> Since the major change, I'm sending another RFC. If this approach is ok, then
> it probably needs just some tweaks to the various error prints, and then
> converting the rest of existing on-off aliases (if I come up with an idea how
> to find them all). Thanks for all the feedback so far.

Yeah, I think you can drop "RFC" from this in the next version -- you're
well into getting this finalized IMO.

> 
>  .../admin-guide/kernel-parameters.txt         |  9 ++
>  fs/proc/proc_sysctl.c                         | 90 +++++++++++++++++++
>  include/linux/sysctl.h                        |  4 +
>  init/main.c                                   |  2 +
>  4 files changed, 105 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..0c7e032e7c2e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4793,6 +4793,15 @@
>  
>  	switches=	[HW,M68k]
>  
> +	sysctl.*=	[KNL]
> +			Set a sysctl parameter, right before loading the init
> +			process, as if the value was written to the respective
> +			/proc/sys/... file. Unrecognized parameters and invalid
> +			values are reported in the kernel log. Sysctls
> +			registered later by a loaded module cannot be set this
> +			way.

Maybe add: "Both '.' and '/' are recognized as separators."

> +			Example: sysctl.vm.swappiness=40
> +
>  	sysfs.deprecated=0|1 [KNL]
>  			Enable/disable old style sysfs layout for old udev
>  			on older distributions. When this option is enabled
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index c75bb4632ed1..8ee3273e4540 100644
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
> @@ -1725,3 +1726,92 @@ int __init proc_sys_init(void)
>  
>  	return sysctl_init();
>  }
> +
> +struct vfsmount *proc_mnt = NULL;

Er, I had a bunch of comments about how this should be declared static
etc, but decided on a different suggestion entirely. See below...

> +
> +/* Set sysctl value passed on kernel command line. */
> +static int process_sysctl_arg(char *param, char *val,
> +			       const char *unused, void *arg)
> +{
> +	char *path;
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
> +		proc_fs_type = get_fs_type("proc");
> +		if (!proc_fs_type) {
> +			pr_err("Failed to mount procfs to set sysctl from command line");
> +			return 0;
> +		}
> +		proc_mnt = kern_mount(proc_fs_type);
> +		put_filesystem(proc_fs_type);
> +		if (IS_ERR(proc_mnt)) {
> +			pr_err("Failed to mount procfs to set sysctl from command line");
> +			proc_mnt = NULL;
> +			return 0;
> +		}
> +	}
> +
> +	len = 4 + strlen(param) + 1;
> +	path = kmalloc(len, GFP_KERNEL);
> +	if (!path)
> +		panic("%s: Failed to allocate %d bytes t\n", __func__, len);
> +
> +	strcpy(path, "sys/");
> +	strcat(path, param);
> +	strreplace(path, '.', '/');

You can do the replacement against the param directly, and also avoid
all the open-coded string manipulations:

	strreplace(param, '.', '/');
	path = kasprintf(GFP_KERNEL, "sys/%s", param);
	if (!path)
		panic("%s: Failed to allocate path for %s\n", __func__, param);

> +
> +	file = file_open_root(proc_mnt->mnt_root, proc_mnt, path, O_WRONLY, 0);
> +	if (IS_ERR(file)) {
> +		err = PTR_ERR(file);
> +		pr_err("Error %d opening proc file %s to set sysctl parameter '%s=%s'",
> +			err, path, param, val);
> +		goto out;
> +	}
> +	len = strlen(val);
> +	wret = kernel_write(file, val, len, &pos);
> +	if (wret < 0) {
> +		err = wret;
> +		pr_err("Error %d writing to proc file %s to set sysctl parameter '%s=%s'",
> +			err, path, param, val);
> +	} else if (wret != len) {
> +		pr_err("Wrote only %ld bytes of %d  writing to proc file %s to set sysctl parameter '%s=%s'",
> +			wret, len, path, param, val);
> +	}
> +
> +	filp_close(file, NULL);

Please check the return value of filp_close() and treat that as an error
for this function too.

> +out:
> +	kfree(path);
> +	return 0;
> +}
> +
> +void do_sysctl_args(void)
> +{
> +	char *command_line;
> +
> +	command_line = kstrdup(saved_command_line, GFP_KERNEL);
> +	if (!command_line)
> +		panic("%s: Failed to allocate copy of command line\n", __func__);
> +
> +	parse_args("Setting sysctl args", command_line,
> +		   NULL, 0, -1, -1, NULL, process_sysctl_arg);
> +
> +	if (proc_mnt)
> +		kern_unmount(proc_mnt);

I don't recommend sharing allocation lifetimes between two functions
(process_sysctl_arg() allocs proc_mnt, and do_sysctl_args() frees it).
And since you have a scoped lifetime, why allocate it or have it as a
global at all? It can be stack-allocated and passed to the handler:

void do_sysctl_args(void)
{
	struct file_system_type *proc_fs_type;
	struct vfsmount *proc_mnt;
	char *command_line;

	proc_fs_type = get_fs_type("proc");
	if (!proc_fs_type) {
		pr_err("Failed to mount procfs to set sysctl from command line");
		return;
	}
	proc_mnt = kern_mount(proc_fs_type);
	put_filesystem(proc_fs_type);
	if (IS_ERR(proc_mnt)) {
		pr_err("Failed to mount procfs to set sysctl from command line");
		return;
	}

	command_line = kstrdup(saved_command_line, GFP_KERNEL);
	if (!command_line)
		panic("%s: Failed to allocate copy of command line\n",
			__func__);

	parse_args("Setting sysctl args", command_line,
		   NULL, 0, -1, -1, proc_mnt, process_sysctl_arg);

	kfree(command_line);
	kern_unmount(proc_mnt);
}

And then pull the mount from (the hilariously overloaded name) "arg":

static int process_sysctl_arg(char *param, char *val,
			       const char *unused, void *arg)
{
	struct vfsmount *proc_mnt = (struct vfsmount *)arg;
	char *path;

	if (!arg)
		...fread out...

	etc

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

Looking good! I'm excited to see the next version. :)

-- 
Kees Cook
