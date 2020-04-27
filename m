Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41A51BACD1
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgD0Sde (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:33:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:47972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgD0Sde (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 Apr 2020 14:33:34 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C91E3205C9;
        Mon, 27 Apr 2020 18:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588012412;
        bh=Kvl1vZC9kDd1F7eq2SkykbjVcxFidxJg+IWcZRfXVAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vTUbWzE5YKsAhGIfXoRp6hDQedTaAGNp8/huMp2MGwjrnBnIXHcBAq0/WY8QdQVWP
         3fwbk784z3Nv1x9AHPRORRmxK1OEK6hOa6dlldVISf/+5WX+j/LhXOW/uH1RlqCgSk
         CTNRshvUm2K2Rpl2z+NivnJNaxfo+daK65RoGEYo=
Date:   Mon, 27 Apr 2020 11:33:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
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
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v3 1/5] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-Id: <20200427113331.f0c1e8e7cee98644260448d3@linux-foundation.org>
In-Reply-To: <20200427180433.7029-2-vbabka@suse.cz>
References: <20200427180433.7029-1-vbabka@suse.cz>
        <20200427180433.7029-2-vbabka@suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 27 Apr 2020 20:04:29 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:

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
> ...
>  
> +	sysctl.*=	[KNL]
> +			Set a sysctl parameter, right before loading the init
> +			process, as if the value was written to the respective
> +			/proc/sys/... file. Both '.' and '/' are recognized as
> +			separators. Unrecognized parameters and invalid values
> +			are reported in the kernel log. Sysctls registered
> +			later by a loaded module cannot be set this way.
> +			Example: sysctl.vm.swappiness=40

Why support "."?  I think only supporting "/" is perfectly adequate and
simplifies documentation.  It aligns the command-line syntax with the
rest of the sysctl documentation.  I'm not seeing the need to provide
two ways of doing the same thing?

