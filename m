Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E92FCAF7
	for <lists+linux-api@lfdr.de>; Wed, 20 Jan 2021 07:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbhATGOj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 20 Jan 2021 01:14:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:39834 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728907AbhATGOE (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 20 Jan 2021 01:14:04 -0500
IronPort-SDR: E8BRTE5uocQn6uiFp9UvE8X+fLuVSpBw/Kd5ujtMY4FvP5HpA9KitHZIhCQqiRaTZQLNAkj7MH
 tIeOswAD/fXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="263861777"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="263861777"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 22:13:21 -0800
IronPort-SDR: cb/LPdqap+NBCBq8dn8vJUVttOnSwklJfB9TdxDaLVeKn0SURH1SP3VtA7RNRInWqFmRQmrZ1B
 R8jsSofSnEHQ==
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="384449244"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 22:13:17 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>, linux-api@vger.kernel.org
Subject: [PATCH -V9 0/3] numa balancing: Migrate on fault among multiple bound nodes
Date:   Wed, 20 Jan 2021 14:12:32 +0800
Message-Id: <20210120061235.148637-1-ying.huang@intel.com>
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

v9:

- Rebased on latest mmotm kernel v5.11-rc3-mmots-2021-01-12-02-00

v8:

- Rebased on latest upstream kernel v5.11-rc2

v7:

- Make set_mempolicy() return -1 with errno is set to EINVAL if mode
  isn't MPOL_BIND per Mel's comments.  Revise document accordingly
  too.

v6:

- Rebased on latest upstream kernel v5.10-rc5

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
