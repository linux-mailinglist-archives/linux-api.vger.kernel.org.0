Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A1B1BACF0
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2020 20:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgD0SjR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Apr 2020 14:39:17 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35501 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgD0SjR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Apr 2020 14:39:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id f8so7324303plt.2;
        Mon, 27 Apr 2020 11:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aJjRKvHUuurfa5tTmPiIRcId8pwnjrxFIxb83E9PK2E=;
        b=AmBeZg4ogyDXViRd+K5MEwZbI0pEyaSp2z8HPSU30HCLcekCTgxigVAwlOSOg66pR3
         mlEiyxzsXLTOhUV7UBnYP7zzq3vN4Pr3VsI/5y/5GbwPHpc74EZmqQGbHlnir+mZoe0C
         /QIQxLAuGG0NfZNk4oJf4WLU/nmUhZnHvXKhcS18Ovv1iYCEWlSbl84kBM4voqQO756X
         COD3H4TPyX/YxyBrF1uW33uB1pLOD3TzaRvgYlXG/HgPOUAH9Kjnib4Z/s7C/yC06Pth
         zeUisTP1JKS6m4j1jjMdusCPHu6EeIliY3qoSqy2qusthJh5CaXfgecNuom7G6/vN0fC
         1Aag==
X-Gm-Message-State: AGi0PuYWWQcpuHuqU34YQQ7jJMhsHCrWYX2vE69L++G7DVLp/w3SM+aJ
        zP/9LvT2Y2XaTiY44selJg0=
X-Google-Smtp-Source: APiQypJXPXTBI691XNB890WMBtVuzThUhN2h6cKf1GRBcpDHp6H/0dkj0d9MxWqJ3k40ylJ/xg6sQQ==
X-Received: by 2002:a17:902:a40e:: with SMTP id p14mr23117257plq.297.1588012755305;
        Mon, 27 Apr 2020 11:39:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v127sm12730060pfv.77.2020.04.27.11.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 11:39:14 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 53962403AB; Mon, 27 Apr 2020 18:39:13 +0000 (UTC)
Date:   Mon, 27 Apr 2020 18:39:13 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v3 5/5] lib/test_sysctl: support testing of sysctl. boot
 parameter
Message-ID: <20200427183913.GH11244@42.do-not-panic.com>
References: <20200427180433.7029-1-vbabka@suse.cz>
 <20200427180433.7029-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427180433.7029-6-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 27, 2020 at 08:04:33PM +0200, Vlastimil Babka wrote:
> Testing is done by a new parameter debug.test_sysctl.boot_int which defaults to
> 0 and it's expected that the tester passes a boot parameter that sets it to 1.
> The test checks if it's set to 1. To distinguish true failure from parameter
> not being set, the test checks /proc/cmdline for the expected parameter, and
> whether test_sysctl is built-in and not a module.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  lib/test_sysctl.c                        | 13 +++++++++
>  tools/testing/selftests/sysctl/sysctl.sh | 36 ++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> index 566dad3f4196..84eaae22d3a6 100644
> --- a/lib/test_sysctl.c
> +++ b/lib/test_sysctl.c
> @@ -44,6 +44,8 @@ struct test_sysctl_data {
>  	int int_0002;
>  	int int_0003[4];
>  
> +	int boot_int;
> +
>  	unsigned int uint_0001;
>  
>  	char string_0001[65];
> @@ -61,6 +63,8 @@ static struct test_sysctl_data test_data = {
>  	.int_0003[2] = 2,
>  	.int_0003[3] = 3,
>  
> +	.boot_int = 0,
> +
>  	.uint_0001 = 314,
>  
>  	.string_0001 = "(none)",
> @@ -91,6 +95,15 @@ static struct ctl_table test_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname	= "boot_int",
> +		.data		= &test_data.boot_int,
> +		.maxlen		= sizeof(test_data.boot_int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2         = SYSCTL_ONE,
> +	},
>  	{
>  		.procname	= "uint_0001",
>  		.data		= &test_data.uint_0001,
> diff --git a/tools/testing/selftests/sysctl/sysctl.sh b/tools/testing/selftests/sysctl/sysctl.sh
> index ce1eeea6f769..ef6417b8067b 100755
> --- a/tools/testing/selftests/sysctl/sysctl.sh
> +++ b/tools/testing/selftests/sysctl/sysctl.sh
> @@ -39,6 +39,7 @@ ALL_TESTS="$ALL_TESTS 0003:1:1:int_0002"
>  ALL_TESTS="$ALL_TESTS 0004:1:1:uint_0001"
>  ALL_TESTS="$ALL_TESTS 0005:3:1:int_0003"
>  ALL_TESTS="$ALL_TESTS 0006:50:1:bitmap_0001"
> +ALL_TESTS="$ALL_TESTS 0007:1:1:boot_int"
>  
>  test_modprobe()
>  {
> @@ -752,6 +753,40 @@ sysctl_test_0006()
>  	run_bitmaptest
>  }
>  
> +sysctl_test_0007()
> +{
> +	TARGET="${SYSCTL}/boot_int"
> +	if [ -d $DIR ]; then
> +		echo "Boot param test only possible sysctl_test is built-in, not module:"
> +		cat $TEST_DIR/config >&2
> +		return 0
> +	fi

Nice, also we could just require

diff --git a/tools/testing/selftests/sysctl/config b/tools/testing/selftests/sysctl/config
index 6ca14800d755..34461cc99a2b 100644
--- a/tools/testing/selftests/sysctl/config
+++ b/tools/testing/selftests/sysctl/config
@@ -1 +1,3 @@
 CONFIG_TEST_SYSCTL=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y

tools/testing/selftests/firmware/fw_lib.sh then has a kconfig_has()
which can verify the exact config.

> +
> +	echo -n "Testing if $TARGET is set to 1 ..."
> +	ORIG=$(cat "${TARGET}")

This would fail if someone uses this script to test an older kernel, and
the scripts in selftests are supposed to work with older kernels. One
way to address this would be to just see if the file exists first and
ignore the test if the $SYSCTL directory exists but the file $TARGET
does not.

For now we can just do this:

if [ ! -d $TARGET ]; then
	echo "Skipping test for $TARGET as it is not present ..."
	return 0
fi

  Luis
