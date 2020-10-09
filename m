Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F452890D8
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 20:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbgJISdf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Oct 2020 14:33:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:9542 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390459AbgJISdT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:19 -0400
IronPort-SDR: 04fE+ChKsQu3p/aJBoyhu8hQwiO9K1E20Eart5p8h1TSo0gM2+/hRLsD+i5fGfp5N36ZSgM4i6
 7OvgK6BhjFrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164736612"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164736612"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:18 -0700
IronPort-SDR: ZezoQJ05eDgw6I0oJZ6LzLHRpzb3pJ0AakUzzEnLudImgnnOD7Fp76Q6AMoR8O/qLcDqD2M5bY
 pD0HC0v/c10A==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529031158"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:17 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 11/26] x86/mm: Update ptep_set_wrprotect() and pmdp_set_wrprotect() for transition from _PAGE_DIRTY_HW to _PAGE_COW
Date:   Fri,  9 Oct 2020 11:32:15 -0700
Message-Id: <20201009183230.26717-12-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201009183230.26717-1-yu-cheng.yu@intel.com>
References: <20201009183230.26717-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When shadow stack is introduced, [R/O + _PAGE_DIRTY_HW] PTE is reserved
for shadow stack.  Copy-on-write PTEs have [R/O + _PAGE_COW].

When a PTE goes from [R/W + _PAGE_DIRTY_HW] to [R/O + _PAGE_COW], it could
become a transient shadow stack PTE in two cases:

The first case is that some processors can start a write but end up seeing
a read-only PTE by the time they get to the Dirty bit, creating a transient
shadow stack PTE.  However, this will not occur on processors supporting
shadow stack, therefore we don't need a TLB flush here.

The second case is that when the software, without atomic, tests & replaces
_PAGE_DIRTY_HW with _PAGE_COW, a transient shadow stack PTE can exist.
This is prevented with cmpxchg.

Dave Hansen, Jann Horn, Andy Lutomirski, and Peter Zijlstra provided many
insights to the issue.  Jann Horn provided the cmpxchg solution.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>

v10:
- Replace bit shift with pte_wrprotect()/pmd_wrprotect(), which use bit
  test & shift.
- Move READ_ONCE of old_pte into try_cmpxchg() loop.
- Change static_cpu_has() to cpu_feature_enabled().

v9:
- Change compile-time conditionals to runtime checks.
- Fix parameters of try_cmpxchg(): change pte_t/pmd_t to
  pte_t.pte/pmd_t.pmd.

v4:
- Implement try_cmpxchg().
---
 arch/x86/include/asm/pgtable.h | 52 ++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 8d4c09831e67..8e637a5ed9e4 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1230,6 +1230,32 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 static inline void ptep_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pte_t *ptep)
 {
+	/*
+	 * Some processors can start a write, but end up seeing a read-only
+	 * PTE by the time they get to the Dirty bit.  In this case, they
+	 * will set the Dirty bit, leaving a read-only, Dirty PTE which
+	 * looks like a shadow stack PTE.
+	 *
+	 * However, this behavior has been improved and will not occur on
+	 * processors supporting shadow stack.  Without this guarantee, a
+	 * transition to a non-present PTE and flush the TLB would be
+	 * needed.
+	 *
+	 * When changing a writable PTE to read-only and if the PTE has
+	 * _PAGE_DIRTY_HW set, move that bit to _PAGE_COW so that the
+	 * PTE is not a shadow stack PTE.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pte_t old_pte, new_pte;
+
+		do {
+			old_pte = READ_ONCE(*ptep);
+			new_pte = pte_wrprotect(old_pte);
+
+		} while (!try_cmpxchg(&ptep->pte, &old_pte.pte, new_pte.pte));
+
+		return;
+	}
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
 }
 
@@ -1286,6 +1312,32 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
 static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 				      unsigned long addr, pmd_t *pmdp)
 {
+	/*
+	 * Some processors can start a write, but end up seeing a read-only
+	 * PMD by the time they get to the Dirty bit.  In this case, they
+	 * will set the Dirty bit, leaving a read-only, Dirty PMD which
+	 * looks like a Shadow Stack PMD.
+	 *
+	 * However, this behavior has been improved and will not occur on
+	 * processors supporting Shadow Stack.  Without this guarantee, a
+	 * transition to a non-present PMD and flush the TLB would be
+	 * needed.
+	 *
+	 * When changing a writable PMD to read-only and if the PMD has
+	 * _PAGE_DIRTY_HW set, we move that bit to _PAGE_COW so that the
+	 * PMD is not a shadow stack PMD.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_SHSTK)) {
+		pmd_t old_pmd, new_pmd;
+
+		do {
+			old_pmd = READ_ONCE(*pmdp);
+			new_pmd = pmd_wrprotect(old_pmd);
+
+		} while (!try_cmpxchg((pmdval_t *)pmdp, (pmdval_t *)&old_pmd, pmd_val(new_pmd)));
+
+		return;
+	}
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)pmdp);
 }
 
-- 
2.21.0

