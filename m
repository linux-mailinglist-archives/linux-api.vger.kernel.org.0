Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054EA1783D7
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 21:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbgCCUVD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 15:21:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgCCUVD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Mar 2020 15:21:03 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1j9E2A-0005uZ-As; Tue, 03 Mar 2020 21:20:54 +0100
Date:   Tue, 3 Mar 2020 21:20:54 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH 1/2] =?utf-8?B?PT9VVEYtOD9xP21tL2NvbXBhY3Rpb246PTIwUmVh?=
 =?utf-8?B?bGx5PTIwbGltaXQ9MjBjb21wYWN0Pz0gPT9VVEYtOD9xPz01RnVuZXZpY3Rh?=
 =?utf-8?B?YmxlPTVGYWxsb3dlZD0yMHRvPTIwMD1FMj04MD1BNjE/PQ==?=
Message-ID: <20200303202054.gsosv7fsx2ma3cic@linutronix.de>
References: <20200115161035.893221-1-bigeasy@linutronix.de>
 <4cf4507b-0632-34e6-5985-df933559af9f@suse.cz>
 <20200302173516.iysuejilava37psk@linutronix.de>
 <20200302132531.59a2c9dffe2515d78abaf909@linux-foundation.org>
 <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200303175910.ichnkjkgmz5y2ipb@linutronix.de>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The proc file `compact_unevictable_allowed' should allow 0 and 1 only,
the `extra*' attribues have been set properly but without
proc_dointvec_minmax() as the `proc_handler' the limit will not be
enforced.

Use proc_dointvec_minmax() as the `proc_handler' to enfoce the valid
specified range.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index ad5b88a53c5a8..982203101f961 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1484,7 +1484,7 @@ static struct ctl_table vm_table[] = {
 		.data		= &sysctl_compact_unevictable_allowed,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
+		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-- 
2.25.1

