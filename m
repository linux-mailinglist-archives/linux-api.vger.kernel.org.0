Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8962CB787
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 09:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387775AbgLBIoB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 03:44:01 -0500
Received: from mga09.intel.com ([134.134.136.24]:6200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387700AbgLBIoA (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 Dec 2020 03:44:00 -0500
IronPort-SDR: T8Tz0CKOxnNj2InxYyyV5jIGgBGk051L6g25/SI7RmQlc+VUDNc13xYz1Edc0Mex0GRH6R8SKV
 Zdvk7QZw633g==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="173139164"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="173139164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 00:42:54 -0800
IronPort-SDR: 59lfLOZMG1FRpT/zHmSkEXl1OymOw7dey734xunXqss8j0lU8MlQNWGrVeKXXmuHopTIfawP2M
 AtqxpwR531jA==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="539590119"
Received: from yhuang6-mobl1.sh.intel.com (HELO yhuang6-MOBL1.intel.com) ([10.238.5.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 00:42:49 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: [PATCH -V6 RESEND 2/3] NOT kernel/man-pages: man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
Date:   Wed,  2 Dec 2020 16:42:33 +0800
Message-Id: <20201202084234.15797-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202084234.15797-1-ying.huang@intel.com>
References: <20201202084234.15797-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 man2/set_mempolicy.2 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
index 68011eecb..3754b3e12 100644
--- a/man2/set_mempolicy.2
+++ b/man2/set_mempolicy.2
@@ -113,6 +113,12 @@ A nonempty
 .I nodemask
 specifies node IDs that are relative to the set of
 node IDs allowed by the process's current cpuset.
+.TP
+.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
+Enable the Linux kernel NUMA balancing for the task if it is supported
+by kernel.
+If the flag isn't supported by Linux kernel, return -1 and errno is
+set to EINVAL.
 .PP
 .I nodemask
 points to a bit mask of node IDs that contains up to
@@ -293,6 +299,9 @@ argument specified both
 .B MPOL_F_STATIC_NODES
 and
 .BR MPOL_F_RELATIVE_NODES .
+Or, the
+.B MPOL_F_NUMA_BALANCING
+isn't supported by the Linux kernel.
 .TP
 .B ENOMEM
 Insufficient kernel memory was available.
-- 
2.29.2

