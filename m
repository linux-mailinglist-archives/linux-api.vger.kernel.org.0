Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B6819328F
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgCYVVe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 17:21:34 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37499 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCYVVd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 17:21:33 -0400
Received: by mail-pj1-f65.google.com with SMTP id o12so1542132pjs.2
        for <linux-api@vger.kernel.org>; Wed, 25 Mar 2020 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9liG+PpIPwwDCvgt6E2rUgbegdoZ31C+iCrJNrlhNEc=;
        b=DT0+pyA47nJ7MK71VSJPumxfG2lqW2oArVgsLTr2rx/5CoQmjuvqd0Rcg7n8rx928n
         EtgJetc2fThx2g1ofj6fP9cSYkOT2Gd7FYH8N5gJXfP8f7ThrmvHZcGYY24FEEK5dbtL
         PNCVFzt2UkvKHU56IvQjJsUclB7YmlSNlNPX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9liG+PpIPwwDCvgt6E2rUgbegdoZ31C+iCrJNrlhNEc=;
        b=VXKkI3vA5U20npg4rMWemrCz3E/ffK8Y76rSMEmqpGPieQrsEO2YCv+eC41rVFBIpr
         NBgcH/B43kstFAQdiYRzGNhBxGF3bpAp1Tiwyq+sRFBdLBZHCw0fHD5ER+UJtS2JCVKT
         dMP9yoT65cI4P2s4mJTXMsYd+3IAVlP1OzegTq5FVgEPaPrk40hNJS6j5NUEwyzBAnl+
         UKgGzZ1z98ONYhrzmoftIQ7o46HfEe60ut9fLhftIaLHch5TZ2+8sAHAZ13l0izFswDm
         d02JQl1gwbS556H/7RsGr6hE2JEPS/WazF4ZZxMH6xQoKRhOEXiF436vp8iMV2pRTkhw
         Gp/A==
X-Gm-Message-State: ANhLgQ3nqCb4EwyvjSEAuy1pYPrPd8qcej2Z013Uv86Sh87wO7sgurUd
        BSme+6QmiDe6q7+Pt6BbRz3vQKczeU0=
X-Google-Smtp-Source: ADFU+vsDVJpxz3HF4XTa2rABYMAkOr77hHybFaaHhI5rT7uUiBodZnyi3/yo+Lp3tivLX0SvO/AmhQ==
X-Received: by 2002:a17:90a:2103:: with SMTP id a3mr5886451pje.181.1585171291242;
        Wed, 25 Mar 2020 14:21:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s61sm153903pjd.33.2020.03.25.14.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 14:21:30 -0700 (PDT)
Date:   Wed, 25 Mar 2020 14:21:29 -0700
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
Subject: Re: [RFC v2 1/2] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202003251404.12A69348@keescook>
References: <20200325120345.12946-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325120345.12946-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Mar 25, 2020 at 01:03:44PM +0100, Vlastimil Babka wrote:
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
> Also after 61a47c1ad3a4 ("sysctl: Remove the sysctl system call") the only way
> to set sysctl is via procfs, so this would eventually allow small systems to be
> built without CONFIG_PROC_SYSCTL and still be able to change sysctl parameters.
> 
> Hence, this patch adds a new parse_args() pass that looks for parameters
> prefixed by 'sysctl.' and searches for them in the sysctl ctl_tables. When
> found, the respective proc handler is invoked. The search is just a naive
> linear one, to avoid using the whole procfs layer. It should be acceptable,
> as the cost depends on number of sysctl. parameters passed.
> 
> The main limitation of avoiding the procfs layer is however that sysctls
> dynamically registered by register_sysctl_table() or register_sysctl_paths()
> cannot currently be set by this method.
> 
> The processing is hooked right before the init process is loaded, as some
> handlers might be more complicated than simple setters and might need some
> subsystems to be initialized. At the moment the init process can be started and
> eventually execute a process writing to /proc/sys/ then it should be also fine
> to do that from the kernel.
> 
> [1] https://lore.kernel.org/linux-doc/BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com/
> [2] https://unix.stackexchange.com/questions/558802/how-to-set-sysctl-using-kernel-command-line-parameter
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> v2: - handle any nesting level of parameter name
>  - add Documentation/admin-guide/kernel-parameters.txt blurb
>  - alias support for legacy one-off parameters, with first conversion (patch 2)
>  - still no support for dynamically registed sysctls
> 
>  .../admin-guide/kernel-parameters.txt         |  9 +++
>  include/linux/sysctl.h                        |  1 +
>  init/main.c                                   | 21 +++++++
>  kernel/sysctl.c                               | 62 +++++++++++++++++++
>  4 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c07815d230bc..5076e288f93f 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4793,6 +4793,15 @@
>  
>  	switches=	[HW,M68k]
>  
> +	sysctl.*=	[KNL]
> +			Set a sysctl parameter right before loading the init
> +			process, as if the value was written to the respective
> +			/proc/sys/... file. Currently a subset of sysctl
> +			parameters is supported that is not registered
> +			dynamically. Unrecognized parameters and invalid values
> +			are reported in the kernel log.
> +			Example: sysctl.vm.swappiness=40
> +
>  	sysfs.deprecated=0|1 [KNL]
>  			Enable/disable old style sysfs layout for old udev
>  			on older distributions. When this option is enabled
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 02fa84493f23..62ae963a5c0c 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -206,6 +206,7 @@ struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
>  void unregister_sysctl_table(struct ctl_table_header * table);
>  
>  extern int sysctl_init(void);
> +int process_sysctl_arg(char *param, char *val, const char *unused, void *arg);
>  
>  extern struct ctl_table sysctl_mount_point[];
>  
> diff --git a/init/main.c b/init/main.c
> index ee4947af823f..74a094c6b8b9 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1345,6 +1345,25 @@ void __weak free_initmem(void)
>  	free_initmem_default(POISON_FREE_INITMEM);
>  }
>  
> +static void do_sysctl_args(void)
> +{
> +#ifdef CONFIG_SYSCTL
> +	size_t len = strlen(saved_command_line) + 1;
> +	char *command_line;
> +
> +	command_line = kzalloc(len, GFP_KERNEL);
> +	if (!command_line)
> +		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
> +
> +	strcpy(command_line, saved_command_line);

No need to open-code this:

	char *command_line;

	command_line = kstrdup(saved_command_line, GFP_KERNEL);
	if (!command_line)
		panic("%s: Failed to allocate %zu bytes\n", __func__, len);

> +
> +	parse_args("Setting sysctl args", command_line,
> +		   NULL, 0, -1, -1, NULL, process_sysctl_arg);
> +
> +	kfree(command_line);
> +#endif
> +}
> +
>  static int __ref kernel_init(void *unused)
>  {
>  	int ret;
> @@ -1367,6 +1386,8 @@ static int __ref kernel_init(void *unused)
>  
>  	rcu_end_inkernel_boot();
>  
> +	do_sysctl_args();
> +
>  	if (ramdisk_execute_command) {
>  		ret = run_init_process(ramdisk_execute_command);
>  		if (!ret)
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ad5b88a53c5a..18c7f5606d55 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1980,6 +1980,68 @@ int __init sysctl_init(void)
>  	return 0;
>  }
>  
> +/* Set sysctl value passed on kernel command line. */
> +int process_sysctl_arg(char *param, char *val,
> +			       const char *unused, void *arg)
> +{
> +	size_t count;
> +	char *remaining;
> +	int err;
> +	loff_t ppos = 0;
> +	struct ctl_table *ctl, *found = NULL;
> +
> +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> +		return 0;
> +
> +	param += sizeof("sysctl.") - 1;
> +
> +	remaining = param;
> +	ctl = &sysctl_base_table[0];
> +
> +	while(ctl->procname != 0) {
> +		int len = strlen(ctl->procname);
> +		if (strncmp(remaining, ctl->procname, len)) {
> +			ctl++;
> +			continue;
> +		}

I think you need to validate that "len" is within "remaining" here
first.

> +		if (ctl->child) {
> +			if (remaining[len] == '.') {
> +				remaining += len + 1;

And that "len + 1" is still valid.

> +				ctl = ctl->child;
> +				continue;
> +			}
> +		} else {
> +			if (remaining[len] == '\0') {
> +				found = ctl;
> +				break;
> +			}
> +		}
> +		ctl++;
> +	}
> +
> +	if (!found) {
> +		pr_warn("Unknown sysctl param '%s' on command line", param);
> +		return 0;
> +	}
> +
> +	if (!(found->mode & 0200)) {
> +		pr_warn("Cannot set sysctl '%s=%s' from command line - not writable",
> +			param, val);
> +		return 0;
> +	}

Oh yes; good call about this writable mode test.

> +
> +	count = strlen(val);
> +	err = found->proc_handler(found, 1, val, &count, &ppos);
> +
> +	if (err)
> +		pr_warn("Error %d setting sysctl '%s=%s' from command line",
> +			err, param, val);
> +
> +	pr_debug("Set sysctl '%s=%s' from command line", param, val);
> +
> +	return 0;
> +}
> +
>  #endif /* CONFIG_SYSCTL */
>  
>  /*
> -- 
> 2.25.1
> 

Outside of the nits and missing bounds check, I like it! :) 

-- 
Kees Cook
