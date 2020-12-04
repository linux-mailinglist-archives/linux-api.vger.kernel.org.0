Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A9E2CEAA5
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 10:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgLDJQl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Dec 2020 04:16:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:30529 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgLDJQl (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Dec 2020 04:16:41 -0500
IronPort-SDR: Dt0TPe/VYFR7rWNtL0bBdbf0/f7I6gMbQwQciKIfYMaTTrZWO6iYy42ggQM63DPQ1rrNi0YgK7
 5+y6R2CnkKMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="170782858"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="170782858"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 01:15:55 -0800
IronPort-SDR: mr3ZlqUTIVb4q01Y8bYFcGc7DlSPk1NYe3aLoAsL1ACoNptIQJPUbeYEwco8ur2IdZ1BRjhMfs
 rCdQc26eTcwQ==
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="550879507"
Received: from unknown (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 01:15:51 -0800
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
Subject: [PATCH -V7 2/3] NOT kernel/man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
Date:   Fri,  4 Dec 2020 17:15:33 +0800
Message-Id: <20201204091534.72239-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204091534.72239-1-ying.huang@intel.com>
References: <20201204091534.72239-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
---
 man2/set_mempolicy.2 | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
index 68011eecb..fb2e6fd96 100644
--- a/man2/set_mempolicy.2
+++ b/man2/set_mempolicy.2
@@ -113,6 +113,15 @@ A nonempty
 .I nodemask
 specifies node IDs that are relative to the set of
 node IDs allowed by the process's current cpuset.
+.TP
+.BR MPOL_F_NUMA_BALANCING " (since Linux 5.11)"
+When
+.I mode
+is MPOL_BIND, enable the Linux kernel NUMA balancing for the task if
+it is supported by kernel.
+If the flag isn't supported by Linux kernel, or is used with
+.I mode
+other than MPOL_BIND, return -1 and errno is set to EINVAL.
 .PP
 .I nodemask
 points to a bit mask of node IDs that contains up to
@@ -293,6 +302,11 @@ argument specified both
 .B MPOL_F_STATIC_NODES
 and
 .BR MPOL_F_RELATIVE_NODES .
+Or, the
+.B MPOL_F_NUMA_BALANCING
+isn't supported by the Linux kernel, or is used with
+.I mode
+other than MPOL_BIND.
 .TP
 .B ENOMEM
 Insufficient kernel memory was available.
-- 
2.29.2

