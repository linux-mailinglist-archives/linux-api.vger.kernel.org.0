Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1135A1786C0
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 00:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgCCX4i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 18:56:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbgCCX4i (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 3 Mar 2020 18:56:38 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0CE20866;
        Tue,  3 Mar 2020 23:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583279796;
        bh=zVphD0+lmSoeVpHjFG+9E8QBcLMbSzrDZweDit/0a3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mKX2B+3Z4/Y3P1GhdlDAWkLGvdkB4LlgxiGgntPi5hOBIqR2WrXc9JXX6poU7TrMV
         cEundsxK66IXugFeyld+uQrp9pohnxnbQX59yQL2EuOZk1/yhU7spdZ4FOUvxmx5lM
         r9RKtAxbCENPTEEc3nwAF40vIVuo105k3JRu8dAs=
Date:   Tue, 3 Mar 2020 15:56:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] mm/compaction: Disable
 compact_unevictable_allowed on RT
Message-Id: <20200303155635.1955cb90451abd3ef8bfba63@linux-foundation.org>
In-Reply-To: <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
        <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
        <20200302173516.iysuejilava37psk@linutronix.de>
        <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
        <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
        <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
        <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 3 Mar 2020 21:22:25 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Since commit
>     5bbe3547aa3ba ("mm: allow compaction of unevictable pages")
> 
> it is allowed to examine mlocked pages and compact them by default.
> On -RT even minor pagefaults are problematic because it may take a few
> 100us to resolve them and until then the task is blocked.
> 
> Make compact_unevictable_allowed = 0 default and issue a warning on RT
> if it is changed.

Fair enough, I guess.

> @@ -2572,6 +2577,26 @@ int proc_dointvec(struct ctl_table *table, int write,
>  	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
>  }
>  
> +#ifdef CONFIG_COMPACTION
> +static int proc_dointvec_warn_RT_change(struct ctl_table *table, int write,
> +					void __user *buffer, size_t *lenp,
> +					loff_t *ppos)
> +{
> +	int ret, old;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
> +		return proc_dointvec(table, write, buffer, lenp, ppos);
> +
> +	old = *(int *)table->data;
> +	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +	WARN_ONCE(old != *(int *)table->data, "sysctl attribute %s changed.",
> +		  table->procname);

The WARN will include a stack trace which just isn't interesting.  A
pr_warn() would be better?

> +	return ret;
> +}
> +#endif

