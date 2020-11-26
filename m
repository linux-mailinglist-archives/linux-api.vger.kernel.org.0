Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A34DB2C4E6A
	for <lists+linux-api@lfdr.de>; Thu, 26 Nov 2020 06:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387768AbgKZFcs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 26 Nov 2020 00:32:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:40400 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387735AbgKZFcs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 26 Nov 2020 00:32:48 -0500
IronPort-SDR: BeZD+hD+hmP0pSE8nhV2Cr2pWPC+QiGIdn3oGXuhJv7oFPNOWj87zKo3MsVsrD2Mv2+BMWPqJC
 7DnEhLSaI+fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="160007887"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="160007887"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 21:32:47 -0800
IronPort-SDR: xgqke7dAppScMuIsvRo6UmwSkkY/2FFD0yGGDrsMYGekEWwPnKUXm8mDxaINLG9wbIPV9e1A4l
 fZ1jjjqxr7pg==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; 
   d="scan'208";a="537179253"
Received: from yhuang-mobile.sh.intel.com ([10.238.5.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 21:32:44 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: [PATCH -V6 0/3] autonuma: Migrate on fault among multiple bound nodes
Date:   Thu, 26 Nov 2020 13:32:16 +0800
Message-Id: <20201126053219.234793-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

To make it possible to optimize cross-socket memory accessing with
AutoNUMA even if the memory of the application is bound to multiple
NUMA nodes.

Patch [2/3] and [3/3] are NOT kernel patches.  Instead, they are
patches for man-pages and numactl respectively.  They are sent
together to make it easy to review the newly added kernel API.

Changes:

v6:

- Rebased on latest upstream kernel 5.10-rc5

- Added some benchmark data and example in patch description of [1/3]

- Rename AutoNUMA to NUMA Balancing

- Add patches to man-pages [2/3] and numactl [3/3]

v5:

- Remove mbind() support, because it's not clear that it's necessary.

v4:

- Use new flags instead of reuse MPOL_MF_LAZY.

v3:

- Rebased on latest upstream (v5.10-rc3)

- Revised the change log.

v2:

- Rebased on latest upstream (v5.10-rc1)

Best Regards,
Huang, Ying
