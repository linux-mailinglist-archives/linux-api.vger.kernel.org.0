Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F59189054
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2020 22:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgCQV3S (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Mar 2020 17:29:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42189 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbgCQV3R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Mar 2020 17:29:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id x2so12299925pfn.9
        for <linux-api@vger.kernel.org>; Tue, 17 Mar 2020 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/sMRI0VauACLkjZfQ1o3jN9W5PKGT8cUGk4UrrBBSoY=;
        b=d0FzwdKBK/YLXE8t1dRwjWvwQAKoJA3Rdt0dlgdhOYEpbdmU1Sr8kMU8PlYHslXyrN
         Dl7axC2i8WKhmyeYVweidZW/Rhhiu7O+SOdo+V4jZ/KBu0vMK/RecBtvJWAODcHUR0sj
         Rcg+ZMWAbCYCbJ1Wl7lTadlUjov4RrFpki+jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/sMRI0VauACLkjZfQ1o3jN9W5PKGT8cUGk4UrrBBSoY=;
        b=N8869+EXHPEbaA0GgUMRi2eb06e6zhIUSCkiBg/VhBHiJWswX+8tF09QVrhVWaGDQu
         MKTP7f6J9adCGaqfo1jw9Fh564nyH68+PJOP7Q9njhzzMD4lUsiABBZMh3nWDZwADNOC
         yhhk6UKoo3SeG/ejUKFkJHW3WOVxVvto+wuExVKqgwGbbxJYU+gWM/+tOliv5nIxaScj
         IO9nIOUx28f4Li6V8Knadd9oaIfGCjysmtJZmNm8xAMCQdmdlz4YRAndf3kkSKU3NJwh
         rQ8Xsw4vuJnebSxjNj8ryuO+XKIX9Mhg0vvlA5yf2w96HsfeE2qKQNmATksC2UsFKGPx
         1nGg==
X-Gm-Message-State: ANhLgQ1QnkFLtDZuC+kG8Sla24mrZXfe26Z8nPCvPM82dNuilsPpW9UW
        p/26a/5X0hmj8CSBJ+aoO8muOw==
X-Google-Smtp-Source: ADFU+vsdTrJfNhFNSnd9VpKTXB8MOOw8+ctzgV60WPiq4OrJkGbsOrygehOkVlGSrUBxYLy/u8L+rw==
X-Received: by 2002:aa7:8709:: with SMTP id b9mr814465pfo.138.1584480554898;
        Tue, 17 Mar 2020 14:29:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gn11sm286309pjb.42.2020.03.17.14.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 14:29:13 -0700 (PDT)
Date:   Tue, 17 Mar 2020 14:29:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [RFC] kernel/sysctl: support setting sysctl parameters from
 kernel command line
Message-ID: <202003171421.5DCADF51@keescook>
References: <20200317132105.24555-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317132105.24555-1-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 17, 2020 at 02:21:05PM +0100, Vlastimil Babka wrote:
> A recently proposed patch to add vm_swappiness command line parameter in
> addition to existing sysctl [1] made me wonder why we don't have a general
> support for passing sysctl parameters via command line. Googling found only
> somebody else wondering the same [2], but I haven't found any prior discussion
> with reasons why not to do this.

I'd like to see stuff like this (as you say, you've found some
redundancies here which could be cleaned up a bit). I think the reason
it hasn't happened before is that the answers have mostly revolved
around "just set it in your initramfs". :P

> [...]
> Hence, this patch adds a new parse_args() pass that looks for parameters
> prefixed by 'sysctl.' and searches for them in the sysctl ctl_tables. When
> found, the respective proc handler is invoked. The search is just a naive
> linear one, to avoid using the whole procfs layer. It should be acceptable,
> as the cost depends on number of sysctl. parameters passed.

I think this needs reconsidering: this RFC only searches 1 level deep,
but sysctls are a tree. For example:

kernel.yama.ptrace_scope
mm.transparent_hugepage.enabled
net.ipv4.conf.default.rp_filter
...etc

If this goes in, it'll need to do full traversal.

> The main limitation of avoiding the procfs layer is however that sysctls
> dynamically registered by register_sysctl_table() or register_sysctl_paths()
> cannot be set by this method.

Correct. And I like what you've done in the code: announce any unhandled
sysctls.

> The processing is hooked right before the init process is loaded, as some
> handlers might be more complicated than simple setters and might need some
> subsystems to be initialized. At the moment the init process can be started and
> eventually execute a process writing to /proc/sys/ then it should be also fine
> to do that from the kernel.

I agree about placement.

> 
> [1] https://lore.kernel.org/linux-doc/BL0PR02MB560167492CA4094C91589930E9FC0@BL0PR02MB5601.namprd02.prod.outlook.com/
> [2] https://unix.stackexchange.com/questions/558802/how-to-set-sysctl-using-kernel-command-line-parameter
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
> Hi,
> 
> this is an early RFC so I can get feedback whether to pursue this idea further,
> before trying the more complicated stuff with dynamically registered sysctls.
> For those I have some unanswered questions:
> - Support them at all?

Maybe? It seems excessive for the initial version.

> - Do so by an internal procfs mount again, that was removed by 61a47c1ad3a4 ?
>   Or try to keep it simple.

I think you can walk the registered sysctl structures themselves, yes?

> - If sysctls are dynamically registered at module load, process the command
>   line sysctl arguments again? - this would be rather complicated I guess.

If it does get supported, perhaps saving them somewhere for
register_sysctl_table() to walk when it gets called?

I like the idea if just for having to build less boiler plate for
supporting things that I've had to plumb to both boot_params and sysctl.
:)

-Kees

> 
> Vlastimil
> 
>  include/linux/sysctl.h |  1 +
>  init/main.c            | 21 ++++++++++++++
>  kernel/sysctl.c        | 66 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
> 
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
> index ad5b88a53c5a..0444656c259d 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1980,6 +1980,72 @@ int __init sysctl_init(void)
>  	return 0;
>  }
>  
> +/* Set sysctl value passed on kernel command line. */
> +int process_sysctl_arg(char *param, char *val,
> +			       const char *unused, void *arg)
> +{
> +	size_t count;
> +	char *tmp;
> +	int err;
> +	loff_t ppos = 0;
> +	struct ctl_table *base, *child = NULL, *found = NULL;
> +
> +	if (strncmp(param, "sysctl.", sizeof("sysctl.") - 1))
> +		return 0;
> +
> +	param += (sizeof("sysctl.") - 1);
> +
> +	tmp = strchr(param, '.');
> +	if (!tmp) {
> +		pr_warn("Invalid sysctl param '%s' on command line", param);
> +		return 0;
> +	}
> +
> +	*tmp = '\0';
> +
> +	for (base = &sysctl_base_table[0]; base->procname != 0; base++) {
> +		if (strcmp(param, base->procname) == 0) {
> +			child = base->child;
> +			break;
> +		}
> +	}
> +
> +	if (!child) {
> +		pr_warn("Unknown sysctl prefix '%s' on command line", param);
> +		return 0;
> +	}
> +
> +	tmp++;
> +
> +	for (; child->procname != 0; child++) {
> +		if (strcmp(tmp, child->procname) == 0) {
> +			found = child;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		pr_warn("Unknown sysctl param '%s.%s' on command line", param, tmp);
> +		return 0;
> +	}
> +
> +	if (!(found->mode & 0200)) {
> +		pr_warn("Cannot set sysctl '%s.%s=%s' from command line - not writable",
> +			param, tmp, val);
> +		return 0;
> +	}
> +
> +
> +	count = strlen(val);
> +	err = found->proc_handler(found, 1, val, &count, &ppos);
> +
> +	if (err)
> +		pr_warn("Error %d setting sysctl '%s.%s=%s' from command line",
> +			err, param, tmp, val);
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

-- 
Kees Cook
