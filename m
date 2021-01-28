Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95508307B47
	for <lists+linux-api@lfdr.de>; Thu, 28 Jan 2021 17:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbhA1Qrz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Jan 2021 11:47:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232705AbhA1QrL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Jan 2021 11:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611852344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LrbBbrZjgAv/B1wjq2Km74Xb+2VP5Qkal75C1Cc+NeE=;
        b=Hy7eBveUQJWbfNOLEtZp2SBaBgJ62/8wdZOAhgOHKKgroeN17uud4D7pVftgyooYJD9wZa
        ua1wx/drWy+ZqNFtGsIs7oFaI3Jvfn0iWSRUUXry5AT+wMoByd7TEnqMWijuDatgqyIbTY
        VtX/5uBGfWX6E45+v3Ee/orJa4qJoHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-Sc0k_4bSOiuTVbO9hkQWLQ-1; Thu, 28 Jan 2021 11:45:42 -0500
X-MC-Unique: Sc0k_4bSOiuTVbO9hkQWLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FAC459;
        Thu, 28 Jan 2021 16:45:40 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-207.ams2.redhat.com [10.36.113.207])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3E5C910027A5;
        Thu, 28 Jan 2021 16:45:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        linux-api@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: count CMA pages per zone and print them in /proc/zoneinfo
Date:   Thu, 28 Jan 2021 17:45:33 +0100
Message-Id: <20210128164533.18566-1-david@redhat.com>
In-Reply-To: <20210127101813.6370-3-david@redhat.com>
References: <20210127101813.6370-3-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Let's count the number of CMA pages per zone and print them in
/proc/zoneinfo.

Having access to the total number of CMA pages per zone is helpful for
debugging purposes to know where exactly the CMA pages ended up, and to
figure out how many pages of a zone might behave differently, even after
some of these pages might already have been allocated.

As one example, CMA pages part of a kernel zone cannot be used for
ordinary kernel allocations but instead behave more like ZONE_MOVABLE.

For now, we are only able to get the global nr+free cma pages from
/proc/meminfo and the free cma pages per zone from /proc/zoneinfo.

Example after this patch when booting a 6 GiB QEMU VM with
"hugetlb_cma=2G":
  # cat /proc/zoneinfo | grep cma
          cma      0
        nr_free_cma  0
          cma      0
        nr_free_cma  0
          cma      524288
        nr_free_cma  493016
          cma      0
          cma      0
  # cat /proc/meminfo | grep Cma
  CmaTotal:        2097152 kB
  CmaFree:         1972064 kB

Note: We track/print only with CONFIG_CMA; "nr_free_cma" in /proc/zoneinfo
is currently also printed without CONFIG_CMA.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: linux-api@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Print/track only with CONFIG_CMA
- Extend patch description

---
 include/linux/mmzone.h | 6 ++++++
 mm/page_alloc.c        | 1 +
 mm/vmstat.c            | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ae588b2f87ef..27d22fb22e05 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -503,6 +503,9 @@ struct zone {
 	 * bootmem allocator):
 	 *	managed_pages = present_pages - reserved_pages;
 	 *
+	 * cma pages is present pages that are assigned for CMA use
+	 * (MIGRATE_CMA).
+	 *
 	 * So present_pages may be used by memory hotplug or memory power
 	 * management logic to figure out unmanaged pages by checking
 	 * (present_pages - managed_pages). And managed_pages should be used
@@ -527,6 +530,9 @@ struct zone {
 	atomic_long_t		managed_pages;
 	unsigned long		spanned_pages;
 	unsigned long		present_pages;
+#ifdef CONFIG_CMA
+	unsigned long		cma_pages;
+#endif
 
 	const char		*name;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b031a5ae0bd5..9a82375bbcb2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2168,6 +2168,7 @@ void __init init_cma_reserved_pageblock(struct page *page)
 	}
 
 	adjust_managed_page_count(page, pageblock_nr_pages);
+	page_zone(page)->cma_pages += pageblock_nr_pages;
 }
 #endif
 
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 7758486097f9..957680db41fa 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1650,6 +1650,11 @@ static void zoneinfo_show_print(struct seq_file *m, pg_data_t *pgdat,
 		   zone->spanned_pages,
 		   zone->present_pages,
 		   zone_managed_pages(zone));
+#ifdef CONFIG_CMA
+	seq_printf(m,
+		   "\n        cma      %lu",
+		   zone->cma_pages);
+#endif
 
 	seq_printf(m,
 		   "\n        protection: (%ld",
-- 
2.29.2

