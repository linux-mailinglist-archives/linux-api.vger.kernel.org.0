Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35912CEAA0
	for <lists+linux-api@lfdr.de>; Fri,  4 Dec 2020 10:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgLDJQb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Dec 2020 04:16:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:30511 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgLDJQb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Dec 2020 04:16:31 -0500
IronPort-SDR: 4un7yKbDsvttNj1ukDoKUjbWtodBcKKNqjyG0VUmK25a3Ktj6xkxBAGvhs8+G2wkumW4+XeRDZ
 EqSiHbF03CMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9824"; a="170782849"
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="170782849"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 01:15:47 -0800
IronPort-SDR: EwRX6H772fvKtoAZfuwHxnpbTtdkq+BjZrWJlmm8+DAxFXFT++ZPoLFyuz8SUzx2UB+1oYIBCU
 VTmok+nuy47g==
X-IronPort-AV: E=Sophos;i="5.78,392,1599548400"; 
   d="scan'208";a="550879466"
Received: from unknown (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.254])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2020 01:15:43 -0800
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
Subject: [PATCH -V7 0/3] numa balancing: Migrate on fault among multiple bound nodes
Date:   Fri,  4 Dec 2020 17:15:31 +0800
Message-Id: <20201204091534.72239-1-ying.huang@intel.com>
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

v7:

- Make set_mempolicy() return -1 with errno is set to EINVAL if mode
  isn't MPOL_BIND per Mel's comments.  Revise document accordingly
  too.

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
