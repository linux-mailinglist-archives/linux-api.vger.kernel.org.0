Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684AC36CCBC
	for <lists+linux-api@lfdr.de>; Tue, 27 Apr 2021 22:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbhD0Upg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Apr 2021 16:45:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:31779 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239075AbhD0UpT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Apr 2021 16:45:19 -0400
IronPort-SDR: JHh6iZnp6fe7VB8sv+Nmu45my5AViKH/jhbxDo42Z4UC5dsyRxWLzE6WFD/2dC7te9HygKdRbf
 sXD5Q+x5GNdQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="281922470"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="281922470"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:14 -0700
IronPort-SDR: rSbJOHYWKU44KGErZE0rybPPRTg8QpnuigGhKK94jTQw0kWk+G1SMwD+BpPauzXKgkBonA1TEU
 3QrunAR6FGIQ==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="465623486"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:44:13 -0700
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
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v26 12/30] x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for transition from _PAGE_DIRTY to _PAGE_COW
Date:   Tue, 27 Apr 2021 13:42:57 -0700
Message-Id: <20210427204315.24153-13-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204315.24153-1-yu-cheng.yu@intel.com>
References: <20210427204315.24153-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When Shadow Stack is introduced, [R/O + _PAGE_DIRTY] PTE is reserved for
shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].

When a PTE goes from [R/W + _PAGE_DIRTY] to [R/O + _PAGE_COW], it could
become a transient shadow stack PTE in two cases:

The first case is that some processors can start a write but end up seeing
a read-only PTE by the time they get to the Dirty bit, creating a transient
shadow stack PTE.  However, this will not occur on processors supporting
Shadow Stack, and a TLB flush is not necessary.

The second case is that when _PAGE_DIRTY is replaced with _PAGE_COW non-
atomically, a transient shadow stack PTE can be created as a result.
Thus, prevent that with cmpxchg.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue.  Jann Horn provided the cmpxchg solution.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/pgtable.h | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e1739f590ca6..46d9394b884f 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1306,6 +1306,24 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+	/*
+	 * If Shadow Stack is enabled, pte_wrprotect() moves _PAGE_DIRTY
+	 * to _PAGE_COW (see comments at pte_wrprotect()).
+	 * When a thread reads a RW=1, Dirty=0 PTE and before changing it
+	 * to RW=0, Dirty=0, another thread could have written to the page
+	 * and the PTE is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
+	 * PTE changes and update old_pte, then try again.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pte_t old_pte, new_pte;
+
+		old_pte = READ_ONCE(*ptep);
+		do {
+			new_pte = pte_wrprotect(old_pte);
+		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
+
+		return;
+	}
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
 }
 
@@ -1350,6 +1368,24 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+	/*
+	 * If Shadow Stack is enabled, pmd_wrprotect() moves _PAGE_DIRTY
+	 * to _PAGE_COW (see comments at pmd_wrprotect()).
+	 * When a thread reads a RW=1, Dirty=0 PMD and before changing it
+	 * to RW=0, Dirty=0, another thread could have written to the page
+	 * and the PMD is RW=1, Dirty=1 now.  Use try_cmpxchg() to detect
+	 * PMD changes and update old_pmd, then try again.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pmd_t old_pmd, new_pmd;
+
+		old_pmd = READ_ONCE(*pmdp);
+		do {
+			new_pmd = pmd_wrprotect(old_pmd);
+		} while (!try_cmpxchg((pmdval_t *)pmdp, (pmdval_t *)&old_pmd, pmd_val(new_pmd)));
+
+		return;
+	}
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
-- 
2.21.0

