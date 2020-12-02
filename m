Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE592CB772
	for <lists+linux-api@lfdr.de>; Wed,  2 Dec 2020 09:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgLBIn3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 2 Dec 2020 03:43:29 -0500
Received: from mga09.intel.com ([134.134.136.24]:6200 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728138AbgLBIn3 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 2 Dec 2020 03:43:29 -0500
IronPort-SDR: hngSES8WVCAQGSR+myztLaosCtDSqC7fBoeLlALn032Mo8Dpb6W9UF2RSh1r2w2vTycPqy6T3T
 GQ8j5ML6Ap/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="173139133"
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="173139133"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 00:42:45 -0800
IronPort-SDR: ck9wfVEYEuqh+5W1FN2nFOOAjksmVctGqCsbS/9+8CATF4FPPl5A8ZqQvXQ1ky2ToM2W/ShC+T
 uL+WdzkNsC/w==
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="539590044"
Received: from yhuang6-mobl1.sh.intel.com (HELO yhuang6-MOBL1.intel.com) ([10.238.5.184])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2020 00:42:41 -0800
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
Subject: [PATCH -V6 RESEND 0/3] numa balancing: Migrate on fault among multiple bound nodes
Date:   Wed,  2 Dec 2020 16:42:31 +0800
Message-Id: <20201202084234.15797-1-ying.huang@intel.com>
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
