Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 015DD3F3335
	for <lists+linux-api@lfdr.de>; Fri, 20 Aug 2021 20:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhHTSVR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Aug 2021 14:21:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:22456 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236384AbhHTSUj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 20 Aug 2021 14:20:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="302407822"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="302407822"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:49 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="533074733"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:49 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v29 17/32] mm: Fixup places that call pte_mkwrite() directly
Date:   Fri, 20 Aug 2021 11:11:46 -0700
Message-Id: <20210820181201.31490-18-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820181201.31490-1-yu-cheng.yu@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When serving a page fault, maybe_mkwrite() makes a PTE writable if it is in
a writable vma.  A shadow stack vma is writable, but its PTEs need
_PAGE_DIRTY to be set to become writable.  For this reason, maybe_mkwrite()
has been updated.

There are a few places that call pte_mkwrite() directly, but have the
same result as from maybe_mkwrite().  These sites need to be updated for
shadow stack as well.  Thus, change them to maybe_mkwrite():

- do_anonymous_page() and migrate_vma_insert_page() check VM_WRITE directly
  and call pte_mkwrite(), which is the same as maybe_mkwrite().  Change
  them to maybe_mkwrite().

- In do_numa_page(), if the numa entry was writable, then pte_mkwrite()
  is called directly.  Fix it by doing maybe_mkwrite().  Make the same
  changes to do_huge_pmd_numa_page().

- In change_pte_range(), pte_mkwrite() is called directly.  Replace it with
  maybe_mkwrite().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v25:
- Apply same changes to do_huge_pmd_numa_page() as to do_numa_page().
---
 mm/huge_memory.c | 2 +-
 mm/memory.c      | 5 ++---
 mm/migrate.c     | 3 +--
 mm/mprotect.c    | 2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c8dd5913884e..b9a6fc7af693 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1515,7 +1515,7 @@ vm_fault_t do_huge_pmd_numa_page(struct vm_fault *vmf)
 	pmd = pmd_modify(oldpmd, vma->vm_page_prot);
 	pmd = pmd_mkyoung(pmd);
 	if (was_writable)
-		pmd = pmd_mkwrite(pmd);
+		pmd = maybe_pmd_mkwrite(pmd, vma);
 	set_pmd_at(vma->vm_mm, haddr, vmf->pmd, pmd);
 	update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 	spin_unlock(vmf->ptl);
diff --git a/mm/memory.c b/mm/memory.c
index 25fc46e87214..5f8a84c17fa6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3781,8 +3781,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	entry = mk_pte(page, vma->vm_page_prot);
 	entry = pte_sw_mkyoung(entry);
-	if (vma->vm_flags & VM_WRITE)
-		entry = pte_mkwrite(pte_mkdirty(entry));
+	entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
 			&vmf->ptl);
@@ -4416,7 +4415,7 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
 	if (was_writable)
-		pte = pte_mkwrite(pte);
+		pte = maybe_mkwrite(pte, vma);
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
diff --git a/mm/migrate.c b/mm/migrate.c
index 7e240437e7d9..8c90eb4ab3b1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2794,8 +2794,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		}
 	} else {
 		entry = mk_pte(page, vma->vm_page_prot);
-		if (vma->vm_flags & VM_WRITE)
-			entry = pte_mkwrite(pte_mkdirty(entry));
+		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
 	}
 
 	ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 883e2cc85cad..9b424f2fd3a9 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -135,7 +135,7 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			if (dirty_accountable && pte_dirty(ptent) &&
 					(pte_soft_dirty(ptent) ||
 					 !(vma->vm_flags & VM_SOFTDIRTY))) {
-				ptent = pte_mkwrite(ptent);
+				ptent = maybe_mkwrite(ptent, vma);
 			}
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 			pages++;
-- 
2.21.0

