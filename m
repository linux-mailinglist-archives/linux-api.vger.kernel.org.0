Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B4135D704
	for <lists+linux-api@lfdr.de>; Tue, 13 Apr 2021 07:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbhDMFRr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Apr 2021 01:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbhDMFRq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Apr 2021 01:17:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AA2C061756
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 22:17:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i2so15206860ybl.21
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 22:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7IsD7HjruBMaXlDcpK+xWb/mDcOHfsbhyhaTVcaMXIo=;
        b=asitBK9IDUdqhqBMnTf3/VipUC7M2aaIQQs7sv0xyYYt371OtKGXrONa+F0lx1P+KT
         KTpoEb+KheSn7A9cy2oB31SQFh6akvHSYhTE1TiV9A77EkJFEoVDjaBgoo5FELWdcFmI
         TvO0F5s/1dS8PioNTfEBj0UqNw7Qsn7v2iw5ftkyvi4gt+5Bquw2aftPfrKY3F8rLJa7
         vv1gbn4LzDC9Zr4VGIQWEz7FPYmc3H8R50tG/LGiydvL/QBd+jACJ2eXXWNISn2dC6nN
         IAwP45gQULqUkHMFlpqQX8hxKqR5B8QpyTNw0a7F1sCV/nqmkMRDPvR+CPRV1fbjctU+
         dv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7IsD7HjruBMaXlDcpK+xWb/mDcOHfsbhyhaTVcaMXIo=;
        b=iAEI3/d1w+X6o5Jiyaq21as0onWw10FgW3UnHSSzup8+WJuARMczk6Fui73JEdMXfx
         gWuz/9m2Wf1JeieTIC/kl15LTMHXCk72soS/aFPyB63Yx28zr7nprIf0G45XSBIH7td0
         PxyTixrg/mlQrAetykzPqNanPK7BHQFptz8rHjiRxGm8dNX02vsmPmobUC0K7u92BckM
         xW9B2n985JyaN9OXMUCTyfN1CZuhw3NQV1gDtbudVAE42bvgPEtITu8gfbeTka8BoAjg
         EXGSVZNpzQyk5MLG2BZdTCaMn5kaKiwoLsJW4hhc3SBTrKtwKnZu7OrqwDw1ND2rK2zT
         OsOg==
X-Gm-Message-State: AOAM530/tT7DaHnEI6wWVQtxJD+uwJbM7thvI+UFCm2DJQBQV2gU4QMM
        CkMcqB7Yzmv+kjErKTrCna57Si+aP9z9I3qwul6K
X-Google-Smtp-Source: ABdhPJyz9QBQ88AmwHLvA8FDzBJ9G2LsvkkvXa8PeJPYpxpPPFJBCAj1fQFfNhZcwUrzO1eaxHBhkrIST0IYRA6i27qb
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d508:eee5:2d57:3e32])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6902:1024:: with SMTP id
 x4mr23587740ybt.13.1618291046988; Mon, 12 Apr 2021 22:17:26 -0700 (PDT)
Date:   Mon, 12 Apr 2021 22:17:13 -0700
In-Reply-To: <20210413051721.2896915-1-axelrasmussen@google.com>
Message-Id: <20210413051721.2896915-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210413051721.2896915-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 1/9] userfaultfd/hugetlbfs: avoid including userfaultfd_k.h
 in hugetlb.h
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Minimizing header file inclusion is desirable. In this case, we can do
so just by forward declaring the enumeration our signature relies upon.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 include/linux/hugetlb.h | 4 +++-
 mm/hugetlb.c            | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 09f1fd12a6fa..3f47650ab79b 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -11,7 +11,6 @@
 #include <linux/kref.h>
 #include <linux/pgtable.h>
 #include <linux/gfp.h>
-#include <linux/userfaultfd_k.h>
 
 struct ctl_table;
 struct user_struct;
@@ -135,6 +134,8 @@ void hugetlb_show_meminfo(void);
 unsigned long hugetlb_total_pages(void);
 vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, unsigned int flags);
+
+enum mcopy_atomic_mode;
 #ifdef CONFIG_USERFAULTFD
 int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				struct vm_area_struct *dst_vma,
@@ -143,6 +144,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm, pte_t *dst_pte,
 				enum mcopy_atomic_mode mode,
 				struct page **pagep);
 #endif /* CONFIG_USERFAULTFD */
+
 bool hugetlb_reserve_pages(struct inode *inode, long from, long to,
 						struct vm_area_struct *vma,
 						vm_flags_t vm_flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 54d81d5947ed..b1652e747318 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -40,6 +40,7 @@
 #include <linux/hugetlb_cgroup.h>
 #include <linux/node.h>
 #include <linux/page_owner.h>
+#include <linux/userfaultfd_k.h>
 #include "internal.h"
 
 int hugetlb_max_hstate __read_mostly;
-- 
2.31.1.295.g9ea45b61b8-goog

