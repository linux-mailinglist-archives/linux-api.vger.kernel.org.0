Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0932D1A97C7
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2020 11:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393825AbgDOJEE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Apr 2020 05:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390645AbgDOJEC (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 15 Apr 2020 05:04:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98A0120775;
        Wed, 15 Apr 2020 09:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586941441;
        bh=6Uf+FHmo8nvRfSiHPdrZgA/7AJpQX7o1hOkc3xcNH5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=whw9AE1FcCYHqiqYow7YdaN0KuUEpYhHQmobiTs2rs34TaCZrbGc+BCL5rwKSJJQx
         0xvzItctDZoQc90DshDkCR1jfedSWYbvNDvDOXWDHI/NCRnEGyvssM+5XtRsfRFd0f
         vwpw6v/8zFe88LhTTbrQmJb0U2YE2DJfJzVCSEwU=
Date:   Wed, 15 Apr 2020 18:03:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
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
Message-Id: <20200415180355.00bc828ea726c421638db871@kernel.org>
In-Reply-To: <20200414113222.16959-2-vbabka@suse.cz>
References: <20200414113222.16959-1-vbabka@suse.cz>
        <20200414113222.16959-2-vbabka@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 14 Apr 2020 13:32:20 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

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
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

[...]

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

Ah, I see. Since the sysctl is designed to be called after all __init calls were
done, it shouldn't use bootconfig directly because bootconfig is full of __init
call. OK, anyway we can use "kernel.sysctl" prefixed bootconfig for these.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
