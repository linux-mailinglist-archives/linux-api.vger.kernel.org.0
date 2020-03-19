Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23B18BD08
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 17:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCSQtj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 12:49:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:60220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgCSQtj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Mar 2020 12:49:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 1ECE8B42C;
        Thu, 19 Mar 2020 16:49:37 +0000 (UTC)
Subject: Re: [PATCH 2/2 v4] mm/compaction: Disable compact_unevictable_allowed
 on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
 <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
 <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
 <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
 <20200303155635.1955cb90451abd3ef8bfba63@linux-foundation.org>
 <20200319163931.ioaslbduokhtprfw@linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a0d90818-9a70-1024-b2ac-4e3b2b00c190@suse.cz>
Date:   Thu, 19 Mar 2020 17:49:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319163931.ioaslbduokhtprfw@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/19/20 5:39 PM, Sebastian Andrzej Siewior wrote:
> Since commit
>     5bbe3547aa3ba ("mm: allow compaction of unevictable pages")
> 
> it is allowed to examine mlocked pages and compact them by default.
> On -RT even minor pagefaults are problematic because it may take a few
> 100us to resolve them and until then the task is blocked.
> 
> Make compact_unevictable_allowed = 0 default and issue a warning on RT
> if it is changed.
> 
> Link: https://lore.kernel.org/linux-mm/20190710144138.qyn4tuttdq6h7kqx@linutronix.de/
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> @@ -2572,6 +2577,28 @@ int proc_dointvec(struct ctl_table *table, int write,
>  	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
>  }
>  
> +#ifdef CONFIG_COMPACTION
> +static int proc_dointvec_minmax_warn_RT_change(struct ctl_table *table,
> +					       int write, void __user *buffer,
> +					       size_t *lenp, loff_t *ppos)
> +{
> +	int ret, old;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
> +		return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +
> +	old = *(int *)table->data;
> +	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> +	if (ret)
> +		return ret;
> +	if (old != *(int *)table->data)
> +		pr_warn_once("sysctl attribute %s changed changed by %s[%d]\n",

						  ^ "changed" twice

> +			     table->procname, current->comm,
> +			     task_pid_nr(current));
> +	return ret;
> +}
> +#endif
> +
>  /**
>   * proc_douintvec - read a vector of unsigned integers
>   * @table: the sysctl table
