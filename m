Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 888E61780E0
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 20:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387576AbgCCR7S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Tue, 3 Mar 2020 12:59:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45089 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387558AbgCCR7R (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Mar 2020 12:59:17 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j9Bp0-0002vG-V7; Tue, 03 Mar 2020 18:59:10 +0100
Date:   Tue, 3 Mar 2020 18:59:10 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] mm/compaction: Disable compact_unevictable_allowed on
 RT
Message-ID: <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2020-03-02 13:25:31 [-0800], Andrew Morton wrote:
> > index 64aeee1009cab..bbfa59d25eec3 100644
> > --- a/Documentation/admin-guide/sysctl/vm.rst
> > +++ b/Documentation/admin-guide/sysctl/vm.rst
> > @@ -128,6 +128,7 @@ allowed to examine the unevictable lru (mlocked pages) for pages to compact.
> >  This should be used on systems where stalls for minor page faults are an
> >  acceptable trade for large contiguous free memory.  Set to 0 to prevent
> >  compaction from moving pages that are unevictable.  Default value is 1.
> > +On CONFIG_PREEMPT_RT the default value is 0.
> 
> This doesn't mention that the file is unwritable on -rt, and it doesn't
> explain *why* -rt has different behaviour.

I updated this bit.

> > --- a/kernel/sysctl.c
> > +++ b/kernel/sysctl.c
> > @@ -1483,7 +1483,11 @@ static struct ctl_table vm_table[] = {
> >  		.procname	= "compact_unevictable_allowed",
> >  		.data		= &sysctl_compact_unevictable_allowed,
> >  		.maxlen		= sizeof(int),
> > +#ifdef CONFIG_PREEMPT_RT
> > +		.mode		= 0444,
> > +#else
> >  		.mode		= 0644,
> > +#endif
> 
> This is non-backward-compatible and introduces a possibility that
> tested-on-non-rt userspace will fail on -rt kernels.  It might be
> better to accept the writes, but to ignore them.  Probably with a
> pr_warn_once() to let people know what we did.

Hmm.

> But do we really need to take the option away from -rt users?  Perhaps
> someone wants this feature and can accept the latency hit.  How about
> switching the default and otherwise leaving the kernel behaviour as-is
> and simply emitting a warning letting -rt users know that they might
> not want to enable this?

I don't think that RT people can live with the latency spike. The
problem is that it is not deterministic in terms *when* it happens and
*how*long* does it need to complete. Also it is not visible so you end
up with additional 100us and you have no idea why.
compaction is "okay" in the setup / configuration phase when the mlock()
pages aren't around / the RT task is disabled. So it does not disturb
the RT load.

Allowing the user to change the knob and spitting a warning is probably
good. So we have a preferred default and the user is aware if it is
changed with or without his knowledge.
Let me send a patch in a bit…

Sebastian
