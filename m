Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F6219878C
	for <lists+linux-api@lfdr.de>; Tue, 31 Mar 2020 00:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgC3Wo0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 18:44:26 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42307 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728876AbgC3Wo0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 18:44:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id e1so7332698plt.9;
        Mon, 30 Mar 2020 15:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zIVHIPyFepzfZUX75CBdVbhO8aGU7tSC+kd801sJlmc=;
        b=TOXesQZ2ofBr16pUddABz//wl+hUPRvk2N8UHC3iLoHzt8SCm7RO+n0TQb+C30dWX4
         YxNiKyxrtqOmLfPguX3PDb79kttE1ME60bIdcLXo/UFbJ2FQoKpCl4Rjp3NrLOq5JHXe
         SQMMpI9Gp7E35EVEm01B2P5DMb4Iug+n2z84mfTJAud7HrsSFjnDIvaQwg3JHf6Tjq8N
         SY/3tQni5EG0QDFkym3ec0Xsad/qCMU/0hYJFB6djStmfA1/bI8aRpaXZWeVVs4pH4dk
         JQ4ReIpeuU5jHA2AnJDI6vRUENYwHETkUDnk0TfUoczNj65aGiz9t3qwv4t3IoFTfJO9
         xJ0w==
X-Gm-Message-State: AGi0PuZ73x3NhGK9Pfi7JCooBwW/RzENjJ5tstMLXht8m60bKhSucEDe
        h/XVOwUC8xBFLSXos6oBXnQ=
X-Google-Smtp-Source: APiQypJADzH/Ace/QXQfphPpu7Lz2Cb5WQMNav01Upd2YzrgxP5azW+0hWE3tJROjYtwwnnyMw643A==
X-Received: by 2002:a17:90a:26e1:: with SMTP id m88mr424940pje.60.1585608264089;
        Mon, 30 Mar 2020 15:44:24 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h11sm11031312pfn.125.2020.03.30.15.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:44:22 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 197C7404B0; Mon, 30 Mar 2020 22:44:22 +0000 (UTC)
Date:   Mon, 30 Mar 2020 22:44:22 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200330224422.GX11244@42.do-not-panic.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330115535.3215-2-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sorry to be late to the apocalypse review party for this, feedback below.

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
> registered sysctl tables.

"even though we don't handle modular sysctls" might be safer to add.

> Errors due to e.g. invalid parameter name or value
> are reported in the kernel log.
> 
> The processing is hooked right before the init process is loaded, as some
> handlers might be more complicated than simple setters and might need some
> subsystems to be initialized. At the moment the init process can be started and
> eventually execute a process writing to /proc/sys/ then it should be also fine
> to do that from the kernel.

This is wonderful when we think about existing sysctls which have
corresponding silly boot params that do the same thing. However, shoving
a boot param capability down every possible built-in sysctl brings
forward support considerations we should take serious, as this would
add a new user interface and we'll have to support it.

Simply put, not all sysctls should be born to be boot params. I suggest
we white-list which ones we can process, so that only sysctls we *do*
review and agree are good candidates get allowed to also be boot params.
Calling a proc hanlder early might seem functional, but if the subsystem
defers evaluation of a setting later, then any boot param set would be
lifted anyway. I think each syscl would need to be reviewed for this to
be supported in a way that doesn't create odd unexpected system settings
which we later have to support forever.

Should we not do this, we'll have to live with the consequences of
supporting the full swoop of sysctls are boot params, whatever
consequences those may be.

> Sysctls registered later on module load time are not set by this mechanism -
> it's expected that in such scenarios, setting sysctl values from userspace is
> practical enough.

I'm just not sure if its worth supporting these, for modules we have
module params, but those with more creative userspace might have a
better idea as to why we'd want to support this. I just can't see it
yet.

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
> +			pr_err("Failed to find procfs to set sysctl from command line");
> +			return 0;
> +		}
> +		proc_mnt = kern_mount(proc_fs_type);
> +		put_filesystem(proc_fs_type);
> +		if (IS_ERR(proc_mnt)) {
> +			pr_err("Failed to mount procfs to set sysctl from command line");
> +			return 0;
> +		}
> +		*((struct vfsmount **)arg) = proc_mnt;
> +	}
> +
> +	path = kasprintf(GFP_KERNEL, "sys/%s", param);
> +	if (!path)
> +		panic("%s: Failed to allocate path for %s\n", __func__, param);
> +	strreplace(path, '.', '/');
> +
> +	file = file_open_root(proc_mnt->mnt_root, proc_mnt, path, O_WRONLY, 0);
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

can you use kstrndup() ? And then use kfree_const()? Yes, feel free to
move __kstrncpy() to a generic kstrncpy().

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

Then, can we get this tested as part of lib/test_sysctl.c with its
respective tools/testing/selftests/sysctl/sysctl.sh ?

  Luis
