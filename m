Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7FD6148E33
	for <lists+linux-api@lfdr.de>; Fri, 24 Jan 2020 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389819AbgAXTGc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jan 2020 14:06:32 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:48049 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389735AbgAXTGc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jan 2020 14:06:32 -0500
Received: by mail-pl1-f201.google.com with SMTP id h3so1572841plt.14
        for <linux-api@vger.kernel.org>; Fri, 24 Jan 2020 11:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=krkqAlKRhIMp0ArvlpDhRd7dHWq318OqpoSyF8/KVxw=;
        b=GAywwj8UJhwxiqNgWIKKSNIBEkjgCb13ZvmIkbgvw3a62UZT9wx4bs2L9qmSU3ApoM
         7PD72PhLgZhEqmrQVMDh0QfmdpfL80pW8KBieoiCd48rL/OjP5j5lFKCOP1sfKkvwNJA
         +xGfaRc8hQxhz5oQ4dGwxqy8O6hIBiF13MIyAYLgOv42e3kfnTOe2fqkw2sbIYg6MsZP
         iI9O/XCli30VFBvTFH6miWnkPrkRzCYFM3vOhPNmLi4bnaFG9Ex0KnGovbb+71Wf73kA
         zOxsE8QnPRM9HVyNDzafepg3w8FlTAiCFQPW5FOKe3uaMrHWxo/bUFwHk53FhRpWl42j
         gV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=krkqAlKRhIMp0ArvlpDhRd7dHWq318OqpoSyF8/KVxw=;
        b=rsnTLGTD8Ar8qjcr0Kp5ukI97S3XLmbVfoYKHZN0GoNUGrW+KAR0GgcQCN2Wj9HfX4
         ZLORAY+8F4qa8VU2juudydbw2g2JPtteGZmY7NGREP5937QsUNPoRVuRoBG7+gdcvF6N
         hvRRaRVL/zo5/cQalVKE56oECGPgSNPd/hBb2CdZv6YtYdxqxM60uCxAXf+zyGeP972q
         lq+RsrLnDdoge/neq791G+iHwpQlCMki0jKd8c1YoPnvr/PwwpuJeZwQG0dDDWXgWFEM
         U4rBCEsDjWgUReiMyTu6jtJ8rT+rxx3gh3wQ31b+70xDy3VUPMzdPh82s/oAHQ0ubD2n
         RmnA==
X-Gm-Message-State: APjAAAVAJ9m3hGKcQDcnGAEd5lADOd6Jh/g0EsFNRI5E2JwLK1KV/HlE
        h0J6nrvg/VD5pvkU0r+FeA2e8zK/Fy9o
X-Google-Smtp-Source: APXvYqwUGyYBQ1naFt1fLtO0IzJ+NPIeVbJYvV7OkP/zeyNBFbhu8a6UF1qp1yGFe6Wf4852PPxO11lrb/vb
X-Received: by 2002:a63:6d05:: with SMTP id i5mr5925764pgc.120.1579892791226;
 Fri, 24 Jan 2020 11:06:31 -0800 (PST)
Date:   Fri, 24 Jan 2020 11:06:25 -0800
In-Reply-To: <20200123014627.71720-1-bgeffon@google.com>
Message-Id: <20200124190625.257659-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] mm: Add MREMAP_DONTUNMAP to mremap().
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>, Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
set, the source mapping will not be removed. Instead it will be
cleared as if a brand new anonymous, private mapping had been created
atomically as part of the mremap() call.  If a userfaultfd was watching
the source, it will continue to watch the new mapping.  For a mapping
that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
mremap() call to fail. MREMAP_DONTUNMAP implies that MREMAP_FIXED is
also used. The final result is two equally sized VMAs where the
destination contains the PTEs of the source.

We hope to use this in Chrome OS where with userfaultfd we could write
an anonymous mapping to disk without having to STOP the process or worry
about VMA permission changes.

This feature also has a use case in Android, Lokesh Gidra has said
that "As part of using userfaultfd for GC, We'll have to move the physical
pages of the java heap to a separate location. For this purpose mremap
will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
heap, its virtual mapping will be removed as well. Therefore, we'll
require performing mmap immediately after. This is not only time consuming
but also opens a time window where a native thread may call mmap and
reserve the java heap's address range for its own usage. This flag
solves the problem."

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 include/uapi/linux/mman.h |  5 +++--
 mm/mremap.c               | 37 ++++++++++++++++++++++++++++++-------
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index fc1a64c3447b..923cc162609c 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -5,8 +5,9 @@
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
 
-#define MREMAP_MAYMOVE	1
-#define MREMAP_FIXED	2
+#define MREMAP_MAYMOVE		1
+#define MREMAP_FIXED		2
+#define MREMAP_DONTUNMAP	4
 
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
diff --git a/mm/mremap.c b/mm/mremap.c
index 122938dcec15..bf97c3eb538b 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -318,8 +318,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 static unsigned long move_vma(struct vm_area_struct *vma,
 		unsigned long old_addr, unsigned long old_len,
 		unsigned long new_len, unsigned long new_addr,
-		bool *locked, struct vm_userfaultfd_ctx *uf,
-		struct list_head *uf_unmap)
+		bool *locked, unsigned long flags,
+		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
 {
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma;
@@ -408,6 +408,13 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn_moved(vma);
 
+	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		if (vm_flags & VM_ACCOUNT)
+			vma->vm_flags |= VM_ACCOUNT;
+
+		goto out;
+	}
+
 	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_unacct_memory(excess >> PAGE_SHIFT);
@@ -422,6 +429,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			vma->vm_next->vm_flags |= VM_ACCOUNT;
 	}
 
+out:
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
 		*locked = true;
@@ -497,7 +505,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		unsigned long new_addr, unsigned long new_len, bool *locked,
-		struct vm_userfaultfd_ctx *uf,
+		unsigned long flags, struct vm_userfaultfd_ctx *uf,
 		struct list_head *uf_unmap_early,
 		struct list_head *uf_unmap)
 {
@@ -545,6 +553,17 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		old_len = new_len;
 	}
 
+	/*
+	 * MREMAP_DONTUNMAP expands by old_len + (new_len - old_len), we will
+	 * check that we can expand by old_len and vma_to_resize will handle
+	 * the vma growing.
+	 */
+	if (unlikely(flags & MREMAP_DONTUNMAP && !may_expand_vm(mm,
+				vma->vm_flags, old_len >> PAGE_SHIFT))) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
 	vma = vma_to_resize(addr, old_len, new_len, &charged);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
@@ -561,7 +580,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if (IS_ERR_VALUE(ret))
 		goto out1;
 
-	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, uf,
+	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
 		       uf_unmap);
 	if (!(offset_in_page(ret)))
 		goto out;
@@ -609,12 +628,15 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	addr = untagged_addr(addr);
 	new_addr = untagged_addr(new_addr);
 
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return ret;
 
 	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
 		return ret;
 
+	if (flags & MREMAP_DONTUNMAP && !(flags & MREMAP_FIXED))
+		return ret;
+
 	if (offset_in_page(addr))
 		return ret;
 
@@ -634,7 +656,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 
 	if (flags & MREMAP_FIXED) {
 		ret = mremap_to(addr, old_len, new_addr, new_len,
-				&locked, &uf, &uf_unmap_early, &uf_unmap);
+				&locked, flags, &uf, &uf_unmap_early,
+				&uf_unmap);
 		goto out;
 	}
 
@@ -712,7 +735,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		}
 
 		ret = move_vma(vma, addr, old_len, new_len, new_addr,
-			       &locked, &uf, &uf_unmap);
+			       &locked, flags, &uf, &uf_unmap);
 	}
 out:
 	if (offset_in_page(ret)) {
-- 
2.25.0.341.g760bfbb309-goog

