Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 546F2178D3E
	for <lists+linux-api@lfdr.de>; Wed,  4 Mar 2020 10:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387707AbgCDJR1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Mar 2020 04:17:27 -0500
Received: from outbound-smtp17.blacknight.com ([46.22.139.234]:53721 "EHLO
        outbound-smtp17.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387699AbgCDJR0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Mar 2020 04:17:26 -0500
X-Greylist: delayed 324 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Mar 2020 04:17:25 EST
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp17.blacknight.com (Postfix) with ESMTPS id AB0B61C3C83
        for <linux-api@vger.kernel.org>; Wed,  4 Mar 2020 09:12:00 +0000 (GMT)
Received: (qmail 4557 invoked from network); 4 Mar 2020 09:12:00 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Mar 2020 09:12:00 -0000
Date:   Wed, 4 Mar 2020 09:11:59 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] mm/compaction: Disable
 compact_unevictable_allowed on RT
Message-ID: <20200304091159.GN3818@techsingularity.net>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
 <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
 <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
 <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200303202225.nhqc3v5gwlb7x6et@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 03, 2020 at 09:22:25PM +0100, Sebastian Andrzej Siewior wrote:
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
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

(caveat: I do not spend very much some on RT-specific topics)

While I ack'd this, an RT application using THP is playing with fire,
I know the RT extension for SLE explicitly disables it from being enabled
at kernel config time. At minimum the critical regions should be mlocked
followed by prctl to disable future THP faults that are non-deterministic,
both from an allocation point of view, and a TLB access point of view. It's
still reasonable to expect a smaller TLB reach for huge pages than
base pages.

It's a similar hazard with NUMA balancing, an RT application should either
disable balancing globally or set a memory policy that forces it to be
ignored. They should be doing this anyway to avoid non-deterministic
memory access costs due to NUMA artifacts but it wouldn't surprise me
if some applications got it wrong.  In that case, the SLE RT extension
disables balancing by default and it probably should warn if it's enabled
like this patch does.

It wouldn't surprise me to see patches like this in the future (completely
untested, illustrative only).

diff --git a/init/Kconfig b/init/Kconfig
index 452bc1835cd4..7a406e2b5580 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -797,7 +797,7 @@ config NUMA_BALANCING
 config NUMA_BALANCING_DEFAULT_ENABLED
 	bool "Automatically enable NUMA aware memory/task placement"
 	default y
-	depends on NUMA_BALANCING
+	depends on NUMA_BALANCING && !PREEMPT_RT
 	help
 	  If set, automatic NUMA balancing will be enabled if running on a NUMA
 	  machine.
diff --git a/mm/Kconfig b/mm/Kconfig
index ab80933be65f..313a5d794491 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -385,7 +385,7 @@ config TRANSPARENT_HUGEPAGE
 
 choice
 	prompt "Transparent Hugepage Support sysfs defaults"
-	depends on TRANSPARENT_HUGEPAGE
+	depends on TRANSPARENT_HUGEPAGE && !PREEMPT_RT
 	default TRANSPARENT_HUGEPAGE_ALWAYS
 	help
 	  Selects the sysfs defaults for Transparent Hugepage Support.

I would hope that a user of an RT kernel with an RT-aware application
would be aware of this anyway but ..... uhhhh.

Point for Andrew is that I would not be too surprised if there were more
RT-specific checks in the future that sanity checked some configuration
options in response to RT-specific bugs that were down to insane
configurations (be they kernel configs or sysctls)

-- 
Mel Gorman
SUSE Labs
