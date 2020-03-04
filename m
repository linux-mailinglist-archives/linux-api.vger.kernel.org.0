Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB5A2178D64
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 10:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgCDJ1x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 04:27:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgCDJ1w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Mar 2020 04:27:52 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j9QJg-0007su-3L; Wed, 04 Mar 2020 10:27:48 +0100
Date:   Wed, 4 Mar 2020 10:27:48 +0100
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
Message-ID: <20200304092748.dz5m57hmwirpk65y@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
 <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
 <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
 <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
 <20200303155635.1955cb90451abd3ef8bfba63@linux-foundation.org>
 <bb5bdf8a-67f0-565b-33a1-8cff6f205f2e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb5bdf8a-67f0-565b-33a1-8cff6f205f2e@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-03-04 09:19:21 [+0100], Vlastimil Babka wrote:
> >> +	WARN_ONCE(old != *(int *)table->data, "sysctl attribute %s changed.",
> >> +		  table->procname);
> > 
> > The WARN will include a stack trace which just isn't interesting.  A
> > pr_warn() would be better?
> 
> Yeah, the only interesting part of full WARN would possibly be, which process
> changed it. That might be useful to print.

Yes, the stack trace and register dump isn't interesting. But as
Vlastimil says, the task and pid are informative. So if that is too much
I could extract those two informations and include it in a pr_warn().

Sebastian
