Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D542149ED0
	for <lists+linux-api@lfdr.de>; Mon, 27 Jan 2020 06:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbgA0FbJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 00:31:09 -0500
Received: from mail-vk1-f202.google.com ([209.85.221.202]:42354 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgA0FbJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 00:31:09 -0500
Received: by mail-vk1-f202.google.com with SMTP id i1so4022165vkn.9
        for <linux-api@vger.kernel.org>; Sun, 26 Jan 2020 21:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=DI0Lh6q9irgWn+IO9tpXRLACEMIkrMuflR08fFBz6r4=;
        b=pI71r8dSdD44XMVUvUhi7UqeZJ/7Mpi/EmVb+iICB+EryfZn+dv7YyWzZfd8B4/OoI
         K85VRP2TqR3qk4Xgqmv0mvqGYPhzU4lOdDVESqkbWTF4xI6NnTQciyO7zEBiOpK8139q
         8GI82lSq/qYWaE2TexNDH99hLcSvrySrOhxfgMXt80JsvY1M04jx8LgiZiHpK0DOqUFI
         CuBsrbfM6mnTiTR7vG998LXps6/wSgF4Z7d5KLpD9j1GAuvCTVN3xCzO5UzDsgYCOOPE
         DtBU5qvgERwToxxUHyck+25YtCV5hxrbEAAZttfpyKgvD9GshDGx+rIuwEGR4ZBsz3+4
         m0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=DI0Lh6q9irgWn+IO9tpXRLACEMIkrMuflR08fFBz6r4=;
        b=IK8w7JLABuDNvVwG0M5qn9o/5KOPGI9/HXEhhVeOiuXL6VDQDI6snzl/z0GCqbzuwe
         7H9FwxLc+OfgmqTjcqpE9M497EHG65DUFGoc3FShaAiDzCwU1YhWHexPAgcosaJ+smxF
         c/yWV+Ok0IzAWjNA9tpMGP1vGV20mtMoUVCOCPupkK4WXv/JiYKYmiiSKf6fsrrsvM7d
         pGEfpB0IadKBBZSKiqFrDfET28tMjcnRQ1lb44ErdDGZkf++IkOv9GGSMqafsCZuPc8o
         JYNfalOlsEze9mkv4TWkj4f+Lx4jdGqONXI6h7vL7Z1H/uYsRT5Nb0aTLM7OcYew54tu
         SjIA==
X-Gm-Message-State: APjAAAWR+Gj62Vv+LiI3+K4fNJdFtlwJiqebQxkNqeyyPfxFpp7+l2Su
        6HIpeIk5vlmRGqEcbkFkijYD+sW3zqMI
X-Google-Smtp-Source: APXvYqxatu41pGjPUZtHzfqsdCcxTqfDNWthU11S26MvvQEtN6JcGExq0ge+WiPsE9O4XFLqZJSqf2dYjSpM
X-Received: by 2002:ab0:6509:: with SMTP id w9mr8912067uam.121.1580103067944;
 Sun, 26 Jan 2020 21:31:07 -0800 (PST)
Date:   Sun, 26 Jan 2020 21:30:56 -0800
In-Reply-To: <20200123014627.71720-1-bgeffon@google.com>
Message-Id: <20200127053056.213679-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20200123014627.71720-1-bgeffon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v3] mm: Add MREMAP_DONTUNMAP to mremap().
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
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
set, the source mapping will not be removed. Instead it will be
cleared as if a brand new anonymous, private mapping had been created
atomically as part of the mremap() call. =C2=A0If a userfaultfd was watchin=
g
the source, it will continue to watch the new mapping. =C2=A0For a mapping
that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
mremap() call to fail. MREMAP_DONTUNMAP requires that MREMAP_FIXED is
also used. The final result is two equally sized VMAs where the
destination contains the PTEs of the source.
=C2=A0 =C2=A0
We hope to use this in Chrome OS where with userfaultfd we could write
an anonymous mapping to disk without having to STOP the process or worry
about VMA permission changes.
=C2=A0 =C2=A0
This feature also has a use case in Android, Lokesh Gidra has said
that "As part of using userfaultfd for GC, We'll have to move the physical
pages of the java heap to a separate location. For this purpose mremap
will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
heap, its virtual mapping will be removed as well. Therefore, we'll
require performing mmap immediately after. This is not only time consuming
but also opens a time window where a native thread may call mmap and
reserve the java heap's address range for its own usage. This flag
solves the problem."
=C2=A0 =C2=A0
Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 include/uapi/linux/mman.h |  5 +++--
 mm/mremap.c               | 38 +++++++++++++++++++++++++++++++-------
 2 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index fc1a64c3447b..923cc162609c 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -5,8 +5,9 @@
 #include <asm/mman.h>
 #include <asm-generic/hugetlb_encode.h>
=20
-#define MREMAP_MAYMOVE	1
-#define MREMAP_FIXED	2
+#define MREMAP_MAYMOVE		1
+#define MREMAP_FIXED		2
+#define MREMAP_DONTUNMAP	4
=20
 #define OVERCOMMIT_GUESS		0
 #define OVERCOMMIT_ALWAYS		1
diff --git a/mm/mremap.c b/mm/mremap.c
index 122938dcec15..1d164e5fdff0 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -318,8 +318,8 @@ unsigned long move_page_tables(struct vm_area_struct *v=
ma,
 static unsigned long move_vma(struct vm_area_struct *vma,
 		unsigned long old_addr, unsigned long old_len,
 		unsigned long new_len, unsigned long new_addr,
-		bool *locked, struct vm_userfaultfd_ctx *uf,
-		struct list_head *uf_unmap)
+		bool *locked, unsigned long flags,
+		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *new_vma;
@@ -408,6 +408,13 @@ static unsigned long move_vma(struct vm_area_struct *v=
ma,
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn_moved(vma);
=20
+	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		if (vm_flags & VM_ACCOUNT)
+			vma->vm_flags |=3D VM_ACCOUNT;
+
+		goto out;
+	}
+
 	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_unacct_memory(excess >> PAGE_SHIFT);
@@ -422,6 +429,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
 	}
=20
+out:
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm +=3D new_len >> PAGE_SHIFT;
 		*locked =3D true;
@@ -497,7 +505,7 @@ static struct vm_area_struct *vma_to_resize(unsigned lo=
ng addr,
=20
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		unsigned long new_addr, unsigned long new_len, bool *locked,
-		struct vm_userfaultfd_ctx *uf,
+		unsigned long flags, struct vm_userfaultfd_ctx *uf,
 		struct list_head *uf_unmap_early,
 		struct list_head *uf_unmap)
 {
@@ -551,6 +559,17 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 		goto out;
 	}
=20
+	/*
+	 * MREMAP_DONTUNMAP expands by old_len + (new_len - old_len), we will
+	 * check that we can expand by old_len and vma_to_resize will handle
+	 * the vma growing.
+	 */
+	if (unlikely(flags & MREMAP_DONTUNMAP && !may_expand_vm(mm,
+				vma->vm_flags, old_len >> PAGE_SHIFT))) {
+		ret =3D -ENOMEM;
+		goto out;
+        }
+
 	map_flags =3D MAP_FIXED;
 	if (vma->vm_flags & VM_MAYSHARE)
 		map_flags |=3D MAP_SHARED;
@@ -561,7 +580,7 @@ static unsigned long mremap_to(unsigned long addr, unsi=
gned long old_len,
 	if (IS_ERR_VALUE(ret))
 		goto out1;
=20
-	ret =3D move_vma(vma, addr, old_len, new_len, new_addr, locked, uf,
+	ret =3D move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf=
,
 		       uf_unmap);
 	if (!(offset_in_page(ret)))
 		goto out;
@@ -609,12 +628,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	addr =3D untagged_addr(addr);
 	new_addr =3D untagged_addr(new_addr);
=20
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP)) {
 		return ret;
+	}
=20
 	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
 		return ret;
=20
+	if (flags & MREMAP_DONTUNMAP && !(flags & MREMAP_FIXED))
+		return ret;
+
 	if (offset_in_page(addr))
 		return ret;
=20
@@ -634,7 +657,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned l=
ong, old_len,
=20
 	if (flags & MREMAP_FIXED) {
 		ret =3D mremap_to(addr, old_len, new_addr, new_len,
-				&locked, &uf, &uf_unmap_early, &uf_unmap);
+				&locked, flags, &uf, &uf_unmap_early,
+				&uf_unmap);
 		goto out;
 	}
=20
@@ -712,7 +736,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned l=
ong, old_len,
 		}
=20
 		ret =3D move_vma(vma, addr, old_len, new_len, new_addr,
-			       &locked, &uf, &uf_unmap);
+			       &locked, flags, &uf, &uf_unmap);
 	}
 out:
 	if (offset_in_page(ret)) {
--=20
2.25.0.341.g760bfbb309-goog

