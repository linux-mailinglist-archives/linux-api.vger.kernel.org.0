Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA58198298
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgC3Rn3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 13:43:29 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41653 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgC3Rn3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 13:43:29 -0400
Received: by mail-pf1-f194.google.com with SMTP id a24so2107522pfc.8
        for <linux-api@vger.kernel.org>; Mon, 30 Mar 2020 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAZJzRt7fuqaSj+7HicEUO63r6qcWUEADIAna3qwLDs=;
        b=dF49PPbEaBBAIakmxJGfH4zdz1EarD3UK9HHLVKkyMv3TfMpe6uEid/u1o00U8uISw
         +jMjg1dnPsE/lkzCZBlV3+UsnmQv7/ya8oEP7SuUFOX6Mqkgfo9AR7gsx4Inp4EDmhT/
         Qzhi67TS9ZFS/EziBdF1M/V1cW2IN5FCwMU8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JAZJzRt7fuqaSj+7HicEUO63r6qcWUEADIAna3qwLDs=;
        b=Dpua7dsh4qPRNIpJPrOTKMRTUlo2aNNdQeO1Fn62Xy7KMnrZy1IvxRor9Eqaa70nkN
         HLVrRKp/Ny/yssAqRVZUHQUxxN2xvx0eBIXu6DYJwBDrwPjfywwXnGrnxi51vdYQPenq
         Oyp/TuSm0As+922/1dwcKFTZM3orDdaGd618RIME80XNW9K1mgPFaF0cRJLbesalKnL3
         oYeAsPSWKyH41NVvGRlz6SPQBcwklmKxnzJL1aJSBE4oONy5Uzf/3hOgbsGPEbe5SeaM
         HrkotPxXWS3y+HAxIyBd5H1g7STN5tt+ElVT289Uz4h01MUbNm/lBq8UvuI4RS0bZz7S
         7FIg==
X-Gm-Message-State: ANhLgQ1dbht60pK8YF6LmJEIp8EDXpZO1y1zOyQAVlspkGs/2rJ6t9+6
        aMeJmzJt15W8lZPOfuXk7wFRLA==
X-Google-Smtp-Source: ADFU+vsi0e3UarNlqpbTS7I7SsjeqBAthl6X9Kptox1ndXG/A6U3/rU8cIh4ts0jiI17uPGOP22EBQ==
X-Received: by 2002:a63:1862:: with SMTP id 34mr14099661pgy.191.1585590207804;
        Mon, 30 Mar 2020 10:43:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k3sm10598303pfp.142.2020.03.30.10.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:43:27 -0700 (PDT)
Date:   Mon, 30 Mar 2020 10:43:26 -0700
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
Subject: Re: [PATCH 3/3] kernel/hung_task convert hung_task_panic boot
 parameter to sysctl
Message-ID: <202003301042.97F3B00@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330115535.3215-4-vbabka@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 30, 2020 at 01:55:35PM +0200, Vlastimil Babka wrote:
> We can now handle sysctl parameters on kernel command line and have
> infrastructure to convert legacy command line options that duplicate sysctl
> to become a sysctl alias.
> 
> This patch converts the hung_task_panic parameter. Note that the sysctl handler
> is more strict and allows only 0 and 1, while the legacy parameter allowed
> any non-zero value. But there is little reason anyone would not be using 1.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

I'll let others double-check, but I think this change should be okay. If
not, we can adjust the sysctl handler to accept an arbitrary int.

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  fs/proc/proc_sysctl.c                           |  1 +
>  kernel/hung_task.c                              | 10 ----------
>  3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 81ff626fc700..e0b8840404a1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1457,7 +1457,7 @@
>  			[KNL] Should the hung task detector generate panics.
>  			Format: <integer>
>  
> -			A nonzero value instructs the kernel to panic when a
> +			A value of 1 instructs the kernel to panic when a
>  			hung task is detected. The default value is controlled
>  			by the CONFIG_BOOTPARAM_HUNG_TASK_PANIC build-time
>  			option. The value selected by this boot parameter can
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 97eb0b552bf8..77b1b844b02b 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -1743,6 +1743,7 @@ struct sysctl_alias {
>   */
>  static const struct sysctl_alias sysctl_aliases[] = {
>  	{"numa_zonelist_order",		"vm.numa_zonelist_order" },
> +	{"hung_task_panic",		"kernel.hung_task_panic" },
>  	{ }
>  };
>  
> diff --git a/kernel/hung_task.c b/kernel/hung_task.c
> index 14a625c16cb3..b22b5eeab3cb 100644
> --- a/kernel/hung_task.c
> +++ b/kernel/hung_task.c
> @@ -63,16 +63,6 @@ static struct task_struct *watchdog_task;
>  unsigned int __read_mostly sysctl_hung_task_panic =
>  				CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE;
>  
> -static int __init hung_task_panic_setup(char *str)
> -{
> -	int rc = kstrtouint(str, 0, &sysctl_hung_task_panic);
> -
> -	if (rc)
> -		return rc;
> -	return 1;
> -}
> -__setup("hung_task_panic=", hung_task_panic_setup);
> -
>  static int
>  hung_task_panic(struct notifier_block *this, unsigned long event, void *ptr)
>  {
> -- 
> 2.25.1
> 

-- 
Kees Cook
