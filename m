Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1F53F3349
	for <lists+linux-api@lfdr.de>; Fri, 20 Aug 2021 20:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhHTSVu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Aug 2021 14:21:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:22601 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236312AbhHTSVJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 20 Aug 2021 14:21:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="302407832"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="302407832"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:50 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="533074752"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:18:50 -0700
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
Subject: [PATCH v29 21/32] mm/mprotect: Exclude shadow stack from preserve_write
Date:   Fri, 20 Aug 2021 11:11:50 -0700
Message-Id: <20210820181201.31490-22-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820181201.31490-1-yu-cheng.yu@intel.com>
References: <20210820181201.31490-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In change_pte_range(), when a PTE is changed for prot_numa, _PAGE_RW is
preserved to avoid the additional write fault after the NUMA hinting fault.
However, pte_write() now includes both normal writable and shadow stack
(RW=0, Dirty=1) PTEs, but the latter does not have _PAGE_RW and has no need
to preserve it.

Exclude shadow stack from preserve_write test, and apply the same change to
change_huge_pmd().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
v25:
- Move is_shadow_stack_mapping() to a separate line.

v24:
- Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().
---
 mm/huge_memory.c | 7 +++++++
 mm/mprotect.c    | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d35acb59dde9..bb38ecdf992f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1776,6 +1776,13 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		return 0;
 
 	preserve_write = prot_numa && pmd_write(*pmd);
+
+	/*
+	 * Preserve only normal writable huge PMD, but not shadow
+	 * stack (RW=0, Dirty=1).
+	 */
+	if (is_shadow_stack_mapping(vma->vm_flags))
+		preserve_write = false;
 	ret = 1;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 9b424f2fd3a9..94cb799216ec 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -77,6 +77,13 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 			pte_t ptent;
 			bool preserve_write = prot_numa && pte_write(oldpte);
 
+			/*
+			 * Preserve only normal writable PTE, but not shadow
+			 * stack (RW=0, Dirty=1).
+			 */
+			if (is_shadow_stack_mapping(vma->vm_flags))
+				preserve_write = false;
+
 			/*
 			 * Avoid trapping faults against the zero or KSM
 			 * pages. See similar comment in change_huge_pmd.
-- 
2.21.0

