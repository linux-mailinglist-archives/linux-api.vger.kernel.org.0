Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD0C25D7A1
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 13:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgIDLle (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 07:41:34 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:49580 "EHLO
        mx01.bbu.dsd.mx.bitdefender.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730069AbgIDLlc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 07:41:32 -0400
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
        by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id F224430747C6;
        Fri,  4 Sep 2020 14:31:05 +0300 (EEST)
Received: from localhost.localdomain (unknown [195.189.155.252])
        by smtp.bitdefender.com (Postfix) with ESMTPSA id 2140C3072786;
        Fri,  4 Sep 2020 14:31:05 +0300 (EEST)
From:   =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
To:     linux-mm@kvack.org
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Mihai=20Don=C8=9Bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Adalbert=20Laz=C4=83r?= <alazar@bitdefender.com>
Subject: [RESEND RFC PATCH 1/5] mm: add atomic capability to zap_details
Date:   Fri,  4 Sep 2020 14:31:12 +0300
Message-Id: <20200904113116.20648-2-alazar@bitdefender.com>
In-Reply-To: <20200904113116.20648-1-alazar@bitdefender.com>
References: <20200904113116.20648-1-alazar@bitdefender.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Mircea Cirjaliu <mcirjaliu@bitdefender.com>

Force zap_xxx_range() functions to loop without rescheduling.
Useful for unmapping memory in an atomic context, although no
checks for atomic context are being made.

Signed-off-by: Mircea Cirjaliu <mcirjaliu@bitdefender.com>
Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
---
 include/linux/mm.h |  6 ++++++
 mm/memory.c        | 11 +++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5a323422d783..1be4482a7b81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1601,8 +1601,14 @@ struct zap_details {
 	struct address_space *check_mapping;	/* Check page->mapping if set */
 	pgoff_t	first_index;			/* Lowest page->index to unmap */
 	pgoff_t last_index;			/* Highest page->index to unmap */
+	bool atomic;				/* Do not sleep. */
 };
 
+static inline bool zap_is_atomic(struct zap_details *details)
+{
+	return (unlikely(details) && details->atomic);
+}
+
 struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t pte);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
diff --git a/mm/memory.c b/mm/memory.c
index f703fe8c8346..8e78fb151f8f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1056,7 +1056,7 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 		if (pte_none(ptent))
 			continue;
 
-		if (need_resched())
+		if (!zap_is_atomic(details) && need_resched())
 			break;
 
 		if (pte_present(ptent)) {
@@ -1159,7 +1159,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 	}
 
 	if (addr != end) {
-		cond_resched();
+		if (!zap_is_atomic(details))
+			cond_resched();
 		goto again;
 	}
 
@@ -1195,7 +1196,8 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 			goto next;
 		next = zap_pte_range(tlb, vma, pmd, addr, next, details);
 next:
-		cond_resched();
+		if (!zap_is_atomic(details))
+			cond_resched();
 	} while (pmd++, addr = next, addr != end);
 
 	return addr;
@@ -1224,7 +1226,8 @@ static inline unsigned long zap_pud_range(struct mmu_gather *tlb,
 			continue;
 		next = zap_pmd_range(tlb, vma, pud, addr, next, details);
 next:
-		cond_resched();
+		if (!zap_is_atomic(details))
+			cond_resched();
 	} while (pud++, addr = next, addr != end);
 
 	return addr;
