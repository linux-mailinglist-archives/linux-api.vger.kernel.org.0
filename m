Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B66C8178C7B
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 09:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCDITW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 03:19:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:57416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgCDITW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Mar 2020 03:19:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7B386AE6F;
        Wed,  4 Mar 2020 08:19:21 +0000 (UTC)
Subject: Re: [PATCH 2/2 v3] mm/compaction: Disable compact_unevictable_allowed
 on RT
To:     Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <bb5bdf8a-67f0-565b-33a1-8cff6f205f2e@suse.cz>
Date:   Wed, 4 Mar 2020 09:19:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303155635.1955cb90451abd3ef8bfba63@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/4/20 12:56 AM, Andrew Morton wrote:
>> @@ -2572,6 +2577,26 @@ int proc_dointvec(struct ctl_table *table, int write,
>>  	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
>>  }
>>  
>> +#ifdef CONFIG_COMPACTION
>> +static int proc_dointvec_warn_RT_change(struct ctl_table *table, int write,
>> +					void __user *buffer, size_t *lenp,
>> +					loff_t *ppos)
>> +{
>> +	int ret, old;
>> +
>> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
>> +		return proc_dointvec(table, write, buffer, lenp, ppos);
>> +
>> +	old = *(int *)table->data;
>> +	ret = proc_dointvec(table, write, buffer, lenp, ppos);
>> +	if (ret)
>> +		return ret;
>> +	WARN_ONCE(old != *(int *)table->data, "sysctl attribute %s changed.",
>> +		  table->procname);
> 
> The WARN will include a stack trace which just isn't interesting.  A
> pr_warn() would be better?

Yeah, the only interesting part of full WARN would possibly be, which process
changed it. That might be useful to print.

>> +	return ret;
>> +}
>> +#endif
> 

