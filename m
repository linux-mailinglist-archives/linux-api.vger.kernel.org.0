Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F8E23916
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390874AbfETOA5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 10:00:57 -0400
Received: from relay.sw.ru ([185.231.240.75]:39828 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387488AbfETOA5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 May 2019 10:00:57 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hSiq4-00083Y-T0; Mon, 20 May 2019 17:00:29 +0300
Subject: [PATCH v2 5/7] mm: Introduce may_mmap_overlapped_region() helper
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 20 May 2019 17:00:28 +0300
Message-ID: <155836082877.2441.3415778176783960096.stgit@localhost.localdomain>
In-Reply-To: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Extract address space limit check for overlapped regions
in a separate helper.

v2: New

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/mmap.c |   33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e4ced5366643..260e47e917e6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -583,6 +583,24 @@ static unsigned long count_vma_pages_range(struct mm_struct *mm,
 	return nr_pages;
 }
 
+/*
+ * Check against address space limit, whether we may expand mm
+ * with a new mapping. Currently mapped in the given range pages
+ * are not accounted in the limit.
+ */
+static bool may_mmap_overlapped_region(struct mm_struct *mm,
+		unsigned long vm_flags, unsigned long addr, unsigned long len)
+{
+	unsigned long nr_pages = len >> PAGE_SHIFT;
+
+	if (!may_expand_vm(mm, vm_flags, nr_pages)) {
+		nr_pages -= count_vma_pages_range(mm, addr, addr + len);
+		if (!may_expand_vm(mm, vm_flags, nr_pages))
+			return false;
+	}
+	return true;
+}
+
 void __vma_link_rb(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct rb_node **rb_link, struct rb_node *rb_parent)
 {
@@ -1697,19 +1715,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	unsigned long charged = 0;
 
 	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, addr + len);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
+	if (!may_mmap_overlapped_region(mm, vm_flags, addr, len))
+		return -ENOMEM;
 
 	/* Clear old maps */
 	while (find_vma_links(mm, addr, addr + len, &prev, &rb_link,

