Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2C1F178D5B
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 10:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgCDJZq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Wed, 4 Mar 2020 04:25:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46394 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgCDJZq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Mar 2020 04:25:46 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j9QHb-0007pN-KO; Wed, 04 Mar 2020 10:25:39 +0100
Date:   Wed, 4 Mar 2020 10:25:39 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] mm/compaction: Disable
 compact_unevictable_allowed on RT
Message-ID: <20200304092539.tku4tuvlzvrmfnep@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
 <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
 <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
 <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
 <f3a9d2ce-1e19-c4cb-3c53-9e118ebc86fb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <f3a9d2ce-1e19-c4cb-3c53-9e118ebc86fb@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-03-04 09:18:21 [+0100], Vlastimil Babka wrote:
> > @@ -2572,6 +2577,26 @@ int proc_dointvec(struct ctl_table *table, int write,
> >  	return do_proc_dointvec(table, write, buffer, lenp, ppos, NULL, NULL);
> >  }
> >  
> > +#ifdef CONFIG_COMPACTION
> > +static int proc_dointvec_warn_RT_change(struct ctl_table *table, int write,
> > +					void __user *buffer, size_t *lenp,
> > +					loff_t *ppos)
> > +{
> > +	int ret, old;
> > +
> > +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || !write)
> > +		return proc_dointvec(table, write, buffer, lenp, ppos);
> 
> Shouldn't you use her proc_dointvec_minmax() per Patch 1/2 ?
> 
> > +
> > +	old = *(int *)table->data;
> > +	ret = proc_dointvec(table, write, buffer, lenp, ppos);
> 
> And here.

Yes, thank you for noticing. It didn't make from editor to disk after
rebasing…

Sebastian
