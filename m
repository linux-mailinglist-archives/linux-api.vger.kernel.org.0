Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 282A216853F
	for <lists+linux-api@lfdr.de>; Fri, 21 Feb 2020 18:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgBURmx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Feb 2020 12:42:53 -0500
Received: from mail-qv1-f73.google.com ([209.85.219.73]:33462 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgBURmx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Feb 2020 12:42:53 -0500
Received: by mail-qv1-f73.google.com with SMTP id g6so1841480qvp.0
        for <linux-api@vger.kernel.org>; Fri, 21 Feb 2020 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=tKKzpIYEZ1wjEgRebo7n3KKwZB1Wchq//EZaD/oF5fA=;
        b=bJojeRcbrBN4fbxnWJACaJ9k5wxxxl8D7Gpl5hEf4gp58TEvomqJ8hAP7/Wh14EjOg
         GAqPqwSLGiV5lo7y9ymx9mOlNzgL7fflwsDMeRoWl4wWkhsJ8G/8QPeAvDIp+hBUNAC0
         Zpobv21XpngKvYrqY7sCeeRc/ipREO1AYP+ixxHKYQJjajC+kXW6QwHekvTHgT+jjVsK
         Cm36hv31/TjRePh2IkiZQXCBDSs8TllR3b093rlb6j1PU3KMjQAO9m26BWCJjpiogUrB
         qwmXjK2nWEoa6AUalrjVWr2B8pJaz7+vOjZpE7iy75q/8aOew19EsaMZ1d2I//ZSua0c
         j+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=tKKzpIYEZ1wjEgRebo7n3KKwZB1Wchq//EZaD/oF5fA=;
        b=bITB2uIsaJ8GGeLSaiyf45PotmdhoEAwXc2tkgAWode/IEmpYFPhZnW4ZWSSIvSy3E
         XjUmsk4Aaimg1BTYHU6xU6u+AwAnYxUMB0zODYtnLTNUZcC5rfCm2cnlARUFziNfp+7h
         ROsk9mPgt2qGyVk4vo9pGE10P7U0+jwUusxOWfGAzIfpahaRvBqtIT8cS5v0A5o/rU67
         EPMfMM7nBG7T/O1ImMAETTWvgD7d4QrRXjob1qx0f8ybB0bV85WhXBQD9Py2WunhGU3k
         Q54XvEeoPxTRjnRW14OjJ7V60GLoqoJhc9rOXlHGmC15cNDFPECidvWe15a+Lv2qATVj
         bguA==
X-Gm-Message-State: APjAAAXN95ELgdwHjSoCEPSrnmqHlgvRaQ2hr12BZk2LrF4L8iZB+/BD
        1kHDukomoSb5teV1b6ALSAGe/bOsK9bz
X-Google-Smtp-Source: APXvYqy35vlGP+Kw6pV+bv6foJ/PRdBUo8WZ4dechdUmpN6fj37ZNaAvJL+yawtM3+sLuS6w++I8Aw/S2R/p
X-Received: by 2002:a0c:b920:: with SMTP id u32mr30047034qvf.173.1582306971986;
 Fri, 21 Feb 2020 09:42:51 -0800 (PST)
Date:   Fri, 21 Feb 2020 09:42:46 -0800
Message-Id: <20200221174248.244748-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v7 1/2] mm: Add MREMAP_DONTUNMAP to mremap().
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        Lokesh Gidra <lokeshgidra@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
set, the source mapping will not be removed. The remap operation
will be performed as it would have been normally by moving over the
page tables to the new mapping. The old vma will have any locked
flags cleared, have no pagetables, and any userfaultfds that were
watching that range will continue watching it.

For a mapping that is shared or not anonymous, MREMAP_DONTUNMAP will cause
the mremap() call to fail. Because MREMAP_DONTUNMAP always results in movin=
g
a VMA you MUST use the MREMAP_MAYMOVE flag, it's not possible to resize
a VMA while also moving with MREMAP_DONTUNMAP so old_len must always
be equal to the new_len otherwise it will return -EINVAL.

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

  v6 -> v7:
    - Don't allow resizing VMA as part of MREMAP_DONTUNMAP.
      There is no clear use case at the moment and it can be added
      later as it simplifies the implementation for now.

  v5 -> v6:
    - Code cleanup suggested by Kirill.

  v4 -> v5:
    - Correct commit message to more accurately reflect the behavior.
    - Clear VM_LOCKED and VM_LOCKEDONFAULT on the old vma.
        =C2=A0 =C2=A0
Signed-off-by: Brian Geffon <bgeffon@google.com>
Reviewed-by: Minchan Kim <minchan@kernel.org>
Tested-by: Lokesh Gidra <lokeshgidra@google.com>
---
 include/uapi/linux/mman.h |  5 ++-
 mm/mremap.c               | 90 ++++++++++++++++++++++++++++++---------
 2 files changed, 72 insertions(+), 23 deletions(-)

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
index 1fc8a29fbe3f..8b7bf3845e50 100644
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
@@ -408,11 +408,32 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 	if (unlikely(vma->vm_flags & VM_PFNMAP))
 		untrack_pfn_moved(vma);
=20
+	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		if (vm_flags & VM_ACCOUNT) {
+			/* Always put back VM_ACCOUNT since we won't unmap */
+			vma->vm_flags |=3D VM_ACCOUNT;
+
+			vm_acct_memory(vma_pages(new_vma));
+		}
+
+		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
+		vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+
+		/* Because we won't unmap we don't need to touch locked_vm */
+		goto out;
+	}
+
 	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_unacct_memory(excess >> PAGE_SHIFT);
 		excess =3D 0;
 	}
+
+	if (vm_flags & VM_LOCKED) {
+		mm->locked_vm +=3D new_len >> PAGE_SHIFT;
+		*locked =3D true;
+	}
+out:
 	mm->hiwater_vm =3D hiwater_vm;
=20
 	/* Restore VM_ACCOUNT if one or two pieces of vma left */
@@ -422,16 +443,12 @@ static unsigned long move_vma(struct vm_area_struct *=
vma,
 			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	if (vm_flags & VM_LOCKED) {
-		mm->locked_vm +=3D new_len >> PAGE_SHIFT;
-		*locked =3D true;
-	}
-
 	return new_addr;
 }
=20
 static struct vm_area_struct *vma_to_resize(unsigned long addr,
-	unsigned long old_len, unsigned long new_len, unsigned long *p)
+	unsigned long old_len, unsigned long new_len, unsigned long flags,
+	unsigned long *p)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma =3D find_vma(mm, addr);
@@ -453,6 +470,10 @@ static struct vm_area_struct *vma_to_resize(unsigned l=
ong addr,
 		return ERR_PTR(-EINVAL);
 	}
=20
+	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
+			vma->vm_flags & VM_SHARED))
+		return ERR_PTR(-EINVAL);
+
 	if (is_vm_hugetlb_page(vma))
 		return ERR_PTR(-EINVAL);
=20
@@ -497,7 +518,7 @@ static struct vm_area_struct *vma_to_resize(unsigned lo=
ng addr,
=20
 static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		unsigned long new_addr, unsigned long new_len, bool *locked,
-		struct vm_userfaultfd_ctx *uf,
+		unsigned long flags, struct vm_userfaultfd_ctx *uf,
 		struct list_head *uf_unmap_early,
 		struct list_head *uf_unmap)
 {
@@ -505,7 +526,7 @@ static unsigned long mremap_to(unsigned long addr, unsi=
gned long old_len,
 	struct vm_area_struct *vma;
 	unsigned long ret =3D -EINVAL;
 	unsigned long charged =3D 0;
-	unsigned long map_flags;
+	unsigned long map_flags =3D 0;
=20
 	if (offset_in_page(new_addr))
 		goto out;
@@ -534,9 +555,11 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 	if ((mm->map_count + 2) >=3D sysctl_max_map_count - 3)
 		return -ENOMEM;
=20
-	ret =3D do_munmap(mm, new_addr, new_len, uf_unmap_early);
-	if (ret)
-		goto out;
+	if (flags & MREMAP_FIXED) {
+		ret =3D do_munmap(mm, new_addr, new_len, uf_unmap_early);
+		if (ret)
+			goto out;
+	}
=20
 	if (old_len >=3D new_len) {
 		ret =3D do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
@@ -545,13 +568,22 @@ static unsigned long mremap_to(unsigned long addr, un=
signed long old_len,
 		old_len =3D new_len;
 	}
=20
-	vma =3D vma_to_resize(addr, old_len, new_len, &charged);
+	vma =3D vma_to_resize(addr, old_len, new_len, flags, &charged);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		goto out;
 	}
=20
-	map_flags =3D MAP_FIXED;
+	/* MREMAP_DONTUNMAP expands by old_len since old_len =3D=3D new_len */
+	if (flags & MREMAP_DONTUNMAP &&
+		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
+		ret =3D -ENOMEM;
+		goto out;
+	}
+
+	if (flags & MREMAP_FIXED)
+		map_flags |=3D MAP_FIXED;
+
 	if (vma->vm_flags & VM_MAYSHARE)
 		map_flags |=3D MAP_SHARED;
=20
@@ -561,10 +593,16 @@ static unsigned long mremap_to(unsigned long addr, un=
signed long old_len,
 	if (offset_in_page(ret))
 		goto out1;
=20
-	ret =3D move_vma(vma, addr, old_len, new_len, new_addr, locked, uf,
+	/* We got a new mapping */
+	if (!(flags & MREMAP_FIXED))
+		new_addr =3D ret;
+
+	ret =3D move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf=
,
 		       uf_unmap);
+
 	if (!(offset_in_page(ret)))
 		goto out;
+
 out1:
 	vm_unacct_memory(charged);
=20
@@ -609,12 +647,21 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	addr =3D untagged_addr(addr);
 	new_addr =3D untagged_addr(new_addr);
=20
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE))
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return ret;
=20
 	if (flags & MREMAP_FIXED && !(flags & MREMAP_MAYMOVE))
 		return ret;
=20
+	/*
+	 * MREMAP_DONTUNMAP is always a move and it does not allow resizing
+	 * in the process.
+	 */
+	if (flags & MREMAP_DONTUNMAP &&
+			(!(flags & MREMAP_MAYMOVE) || old_len !=3D new_len))
+		return ret;
+
+
 	if (offset_in_page(addr))
 		return ret;
=20
@@ -632,9 +679,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned =
long, old_len,
 	if (down_write_killable(&current->mm->mmap_sem))
 		return -EINTR;
=20
-	if (flags & MREMAP_FIXED) {
+	if (flags & (MREMAP_FIXED | MREMAP_DONTUNMAP)) {
 		ret =3D mremap_to(addr, old_len, new_addr, new_len,
-				&locked, &uf, &uf_unmap_early, &uf_unmap);
+				&locked, flags, &uf, &uf_unmap_early,
+				&uf_unmap);
 		goto out;
 	}
=20
@@ -662,7 +710,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned l=
ong, old_len,
 	/*
 	 * Ok, we need to grow..
 	 */
-	vma =3D vma_to_resize(addr, old_len, new_len, &charged);
+	vma =3D vma_to_resize(addr, old_len, new_len, flags, &charged);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		goto out;
@@ -712,7 +760,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned l=
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
2.25.0.265.gbab2e86ba0-goog

