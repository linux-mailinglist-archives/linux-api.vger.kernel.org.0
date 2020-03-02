Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D761765ED
	for <lists+linux-api@lfdr.de>; Mon,  2 Mar 2020 22:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgCBVZc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 Mar 2020 16:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:54420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgCBVZc (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 2 Mar 2020 16:25:32 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2BD0208C3;
        Mon,  2 Mar 2020 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583184332;
        bh=irH+qIz7RQAX8VNOn4osnuiinNKfwvRGDRqgNDX/JKk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=veaCjF2SKyTQH/NZgidyCbSQloTu1GBH7jEg4PH2gAtPsw1kfiuemamqB9QJuq7eb
         IwbcA7ag3CnHZhzVlTlbYOVMOSPV+rPms4rRA/1mL53MzpksBbXBQUnNmsaikzpvud
         t3AobnNzWI8oXZ1IRmv+g3CAJu4r+adKsjSsEFjc=
Date:   Mon, 2 Mar 2020 13:25:31 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] mm/compaction: Disable compact_unevictable_allowed
 on RT
Message-Id: <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
In-Reply-To: <20200302173516.iysuejilava37psk@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
        <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
        <20200302173516.iysuejilava37psk@linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 2 Mar 2020 18:35:16 +0100 Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Since commit
>     5bbe3547aa3ba ("mm: allow compaction of unevictable pages")
> 
> it is allowed to examine mlocked pages and compact them by default.
> On -RT even minor pagefaults are problematic because it may take a few
> 100us to resolve them and until then the task is blocked.
> 
> Make compact_unevictable_allowed = 0 default and RO on RT.

hm, that's a bit sad but I guess it's tolerable.

> ...
>
> index 64aeee1009cab..bbfa59d25eec3 100644
> --- a/Documentation/admin-guide/sysctl/vm.rst
> +++ b/Documentation/admin-guide/sysctl/vm.rst
> @@ -128,6 +128,7 @@ allowed to examine the unevictable lru (mlocked pages) for pages to compact.
>  This should be used on systems where stalls for minor page faults are an
>  acceptable trade for large contiguous free memory.  Set to 0 to prevent
>  compaction from moving pages that are unevictable.  Default value is 1.
> +On CONFIG_PREEMPT_RT the default value is 0.

This doesn't mention that the file is unwritable on -rt, and it doesn't
explain *why* -rt has different behaviour.

> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1483,7 +1483,11 @@ static struct ctl_table vm_table[] = {
>  		.procname	= "compact_unevictable_allowed",
>  		.data		= &sysctl_compact_unevictable_allowed,
>  		.maxlen		= sizeof(int),
> +#ifdef CONFIG_PREEMPT_RT
> +		.mode		= 0444,
> +#else
>  		.mode		= 0644,
> +#endif

This is non-backward-compatible and introduces a possibility that
tested-on-non-rt userspace will fail on -rt kernels.  It might be
better to accept the writes, but to ignore them.  Probably with a
pr_warn_once() to let people know what we did.

But do we really need to take the option away from -rt users?  Perhaps
someone wants this feature and can accept the latency hit.  How about
switching the default and otherwise leaving the kernel behaviour as-is
and simply emitting a warning letting -rt users know that they might
not want to enable this?

