Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7D713D7D3
	for <lists+linux-api@lfdr.de>; Thu, 16 Jan 2020 11:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgAPKWs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Jan 2020 05:22:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51115 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgAPKWs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Jan 2020 05:22:48 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1is2IR-0003rz-Ht; Thu, 16 Jan 2020 11:22:39 +0100
Date:   Thu, 16 Jan 2020 11:22:39 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH] mm/compaction: Disable compact_unevictable_allowed on RT
Message-ID: <20200116102239.m2trw3cvosn7q5a5@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-01-15 23:04:19 [+0100], Vlastimil Babka wrote:
> On 1/15/2020 5:10 PM, Sebastian Andrzej Siewior wrote:
> > Since commit
> >     5bbe3547aa3ba ("mm: allow compaction of unevictable pages")
> > 
> > it is allowed to examine mlocked pages and compact them by default.
> > On -RT even minor pagefaults are problematic because it may take a few
> > 100us to resolve them and until then the task is blocked.
> 
> Fine, this makes sense on RT I guess. There might be some trade-off for
> high-order allocation latencies though. We could perhaps migrate such mlocked
> pages to pages allocated without __GFP_MOVABLE during the mlock() to at least
> somewhat prevent them being scattered all over the zones. For MCL_FUTURE,
> allocate them as unmovable from the beginning. But that can wait until issues
> are reported.
> I assume you have similar solution for NUMA balancing and whatever else can
> cause minor faults?

I've found this one while testing. Could you please point to the NUMA
balancing that might be an issue?

> > Make compact_unevictable_allowed = 0 default and remove it from /proc on
> > RT.
> 
> Removing it is maybe going too far in terms of RT kernel differences confusing
> users? Change the default sure, perhaps making it read-only, but removing?

Okay. I will make it RO then. 

> > Link: https://lore.kernel.org/linux-mm/20190710144138.qyn4tuttdq6h7kqx@linutronix.de/
> 
> In any case the sysctl Documentation/ should be updated? And perhaps also the
> mlock manpage as you noted in the older thread above?

Sure. Let me add the sysctl documentation to this patch and then I will
look into the manpage.

> Thanks,
> Vlastimil

Sebastian
