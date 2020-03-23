Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96C4518F092
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 09:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgCWIFO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 04:05:14 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:11001 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgCWIFN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Mar 2020 04:05:13 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200323080511epoutp03bd3dcf98bb3c73e6ad08d8ea38a4612d~_4EZpX0FB1284012840epoutp03t
        for <linux-api@vger.kernel.org>; Mon, 23 Mar 2020 08:05:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200323080511epoutp03bd3dcf98bb3c73e6ad08d8ea38a4612d~_4EZpX0FB1284012840epoutp03t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584950711;
        bh=dSYUW03bHzrs9o67DnwnF349vBuzWA6AMzTlkUXfLWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c/Cq70XueTavKVS2yaajtyGQISate4WyZ7oZSqtZQFwf4a6DvwjItBfnkm0OR2LVw
         2VX/3auCyY7O2C7mw8yH5jkZ7Hswc50BfXw6jn/HRihKV0o0yrU0hAWDq5zfoShaHe
         krQpzu0Er2Cio6ru0MQmbAPIkhGgH0m+j9xLR008=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200323080511epcas1p1e045fa882c46a59520affd8470248956~_4EZAIXBi2159621596epcas1p1G;
        Mon, 23 Mar 2020 08:05:11 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48m6PJ58TyzMqYkg; Mon, 23 Mar
        2020 08:05:08 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.70.04145.4BD687E5; Mon, 23 Mar 2020 17:05:08 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200323080508epcas1p2dfe6517169a65936e5ab10c4e63a19a7~_4EWKChal2331623316epcas1p28;
        Mon, 23 Mar 2020 08:05:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200323080508epsmtrp1e95a6cc4a2e1e35601c95ad2b01b48c9~_4EWIopZ50063700637epsmtrp1f;
        Mon, 23 Mar 2020 08:05:08 +0000 (GMT)
X-AuditID: b6c32a35-2a5ff70000001031-37-5e786db4bb01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C7.73.04024.4BD687E5; Mon, 23 Mar 2020 17:05:08 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200323080507epsmtip1af2b09b7d835e20c46018369fa326f2f~_4EV5mw5Z3157831578epsmtip1N;
        Mon, 23 Mar 2020 08:05:07 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     gregkh@linuxfoundation.org, leon@kernel.org, vbabka@suse.cz,
        adobriyan@gmail.com, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [RFC PATCH v2 2/3] mm: zsmalloc: include zs page size in meminfo
 extra
Date:   Mon, 23 Mar 2020 17:05:02 +0900
Message-Id: <20200323080503.6224-3-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200323080503.6224-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOube994J23FzdPEHC2E1mgkuhtbScTViWaLabQRRjJHFZYDfl
        hBJvP9JbFPWHVAmyQqUSDaPSBT9QqRBMSwYodqaSjAzn5xgTrVF/qJhAFYcayOZabs3273nf
        93nO877vOYchuVEqk6mxubDTJko8la766UquVjtgravQ9UVzUbv7a9TZ30uh6w8WKHTgZD+F
        msMdAHnjzwh0ZnYcoIvj8wTqGXlDoCML3SQKv26i0O0LnRS63/tWjU7Px2l0vsFPo0e+NgL9
        GntJo2PuQ+ALThj2x2ghFPyeEkJzbbRw748RShj7YVEl/BzopYXwqX1CPDJBCYcGgkC42jVK
        C8NzYbXwMpRdtvwbqciCxSrszME2s72qxlZdzJdsrdxQaTTp9Fr9p6iQz7GJVlzMbywt035Z
        IyXG43N2ilJtIlUmyjKf/3mR017rwjkWu+wq5rGjSnLodY48WbTKtbbqPLPd+plep1tnTDC/
        kyyNU09phy+97vn0qKoe+BkPSGMgWwAPejoJD0hnOHYIwOGLbiJZ4Ng5AA9PqJXCKwC9U63g
        neJFrDNVuATg/vHrKiV4DWD97BMqyaLYT2C8q22JtZJtJeCJ2IklFsn2ARj0xBImDLOC3QJv
        +oxJgYr9GPqaB1VJrGGLYE/PPVWSAtkP4fG3ZDKdxhbDyK0pKnkMZE/TcLTPSygtbYTT4XgK
        r4DPfhmgFZwJp1sbaUVwAMCZjjBQggYAYyFvaiAD9LbcIJNuJJsL+y/kK+mP4PBiYIlCsu/B
        2fkWtdKQBjY1cgplDWx4PK9WcBb8+5/HKSzAxdlQakU+AM/NdRM+kO3/z6ELgCD4ADtkazWW
        9Q79/+8sBJZe8FrjEDhyrTQKWAbwyzX1zbsqOLW4U95tjQLIkPxKTRjXVXCaKnH3Huy0Vzpr
        JSxHgTGxysNk5vtme+I/2FyVeuM6g8GACkyFJqOBX6U5OilVcGy16MI7MHZg5zsdwaRl1oOj
        sa82ZbU8dEz8uHDwxeWSZXvLs65uXVVwNyCdyXgzacLrh8rkSx3b1U+ORcby71vcm7f9XhKM
        lP95xx8wB/ZM0Z5vm0YGTv11Zf/g5l3tbq7UTOS96mhvHrycPrHBGiHLjzeYMnonM8gZnpnZ
        d3fHpq5u9W9j0ezpG/Tq8kItc5ZXyRZRv5Z0yuK/EJa4iNcDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFLMWRmVeSWpSXmKPExsWy7bCSnO6W3Io4g5f3mC2mN3pZzFm/hs3i
        /INfbBbNi9ezWXRvnslo0fv+FZPF8nenGS12n/7KZLFyzw8miym/ljJbbP7ewWZxedccNot7
        a/6zWiz7+p7dYkPLLHaLRxMmMVmcuvuZ3WJ2Yx+jg5DHzll32T02repk89j0aRK7x51re9g8
        Tsz4zeKxf+4ado/NS+o93u+7yubRt2UVo8eZBUfYPXZ+2szq8XmTXABPFJdNSmpOZllqkb5d
        AldG260X7AUTuCo+vDzC0sA4i6OLkZNDQsBE4uPdOaxdjFwcQgK7GSWebX3NBpGQkXhz/ilL
        FyMHkC0scfhwMUhYSOAro8Tcy/EgNpuAtsT7BZNYQWwRgflMEv3t/CBzmAU2M0pMXNrMApIQ
        FvCXmDJpITOIzSKgKjGheztYnFfARmLlyjtQ8+UlFv4HK+EUsJXYd+kWG8QuG4mt3c+YJzDy
        LWBkWMUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwjWpo7GC8viT/EKMDBqMTDe6O3
        PE6INbGsuDL3EKMEB7OSCO/m1Io4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxP845FCgmkJ5ak
        ZqemFqQWwWSZODilGhgdq2s3egb8jnmwbmcVnwPrn7bpync2HNa5MafyhfgS6edT4ltYw5nm
        zBU/Yb5BoDM7bEOEDW9Jz3f/Le90Nk2pOv774ZETNY5uDx62PYg9qRaYsfd19sGqubEuNxW1
        nBp7zT2bEjTnK2jOZWzY9tp2upARu4BGpjXD8hWmHksYlxU3We7U7VRiKc5INNRiLipOBACx
        /fqvjQIAAA==
X-CMS-MailID: 20200323080508epcas1p2dfe6517169a65936e5ab10c4e63a19a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200323080508epcas1p2dfe6517169a65936e5ab10c4e63a19a7
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
        <CGME20200323080508epcas1p2dfe6517169a65936e5ab10c4e63a19a7@epcas1p2.samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On most of recent Android device use DRAM memory based compressed swap
to save free memory. And the swap device size is also big enough.

The zsmalloc page size is alread shown on vmstat by commit 91537fee0013
("mm: add NR_ZSMALLOC to vmstat"). If the size is also shown in
/proc/meminfo_extra, it will be better to see system wide memory usage at a
glance.

To include heap size, use register_meminfo_extra introduced in previous
patch.

i.e) cat /proc/meminfo_extra | grep ZsPages
IonSystemHeap:    242620 kB
ZsPages:          203860 kB

i.e.) show_mem on oom
<6>[  420.856428]  Mem-Info:
<6>[  420.856433]  ZsPages:44114kB

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 mm/zsmalloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 22d17ecfe7df..9d5682aa44ac 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -2566,6 +2566,7 @@ static int __init zs_init(void)
 
 	zs_stat_init();
 
+	register_meminfo_extra(&vm_zone_stat[NR_ZSPAGES], 0, "ZsPages");
 	return 0;
 
 hp_setup_fail:
@@ -2583,6 +2584,7 @@ static void __exit zs_exit(void)
 	cpuhp_remove_state(CPUHP_MM_ZS_PREPARE);
 
 	zs_stat_exit();
+	unregister_meminfo_extra(&vm_zone_stat[NR_ZSPAGES]);
 }
 
 module_init(zs_init);
-- 
2.13.7

