Return-Path: <linux-api+bounces-1930-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F8592ED78
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81773286940
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D9C16D9BE;
	Thu, 11 Jul 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X/X7+0TS"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FE16D4E7;
	Thu, 11 Jul 2024 17:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717784; cv=none; b=alD53J28DAQLoo4nLMS4MeCwP7MmkqnsJU4/cXk+hYl7ZrGsR3mrGtrpDnD/IzaVmYtzjoNCUPQS2C/RvE57IKtl3oSA7NZOR0+A34d7Weqd+VYvxGoXK7aozq8vV4qwqM4zVcwnT20aZ2mXKqQSBe8gyHUPWFXAHpVO9TJ+mrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717784; c=relaxed/simple;
	bh=VJps8YRyXPgmkQL/Oc0nWeCbG5EJcOqKrcAnZRcok64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyBAz/WlAamYdEoVpRgzlPEEAhmO+DK5yPuhrPPZWfXuQuo+l8JpzmuXwO8odDgjEblTaX9DQBm2RymkP7vVDePo+ZdLMxKgXfCEFM1+Hr8EwX8vfbNLTrt702zWhTzPy8C9UwD4ZT/FnpZ8KyyRwuy8wGG4mzbwblE+umoMrEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=X/X7+0TS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2E2C116B1;
	Thu, 11 Jul 2024 17:09:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X/X7+0TS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720717780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b5Zk8ILabTM/NFQk7obBb2+60sqv1qoyRRStBSjez0M=;
	b=X/X7+0TSXxHpmN9PMnqrKgXgKx72kEhINEQYzolMUKcDfR1Vzh5V+MOSwdpOdnflOrEggY
	zwuFsiGiSZePB7MRot1uPuwaJvzoEreWrxF6ZujhbuOrACxJggMXynn87lCnleNNjeWH5z
	uh/2WYxRcos75n4JpPgbhTxfBYbgRw4=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 229a906f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 17:09:39 +0000 (UTC)
Date: Thu, 11 Jul 2024 19:09:36 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, tglx@linutronix.de,
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
	x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZpAR0CgLc28gEkV3@zx2c4.com>
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com>
 <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>

Hi Linus, David,

On Wed, Jul 10, 2024 at 10:07:03PM -0700, Linus Torvalds wrote:
> The other approach might be to just let all the dirty handling happen
> - make droppable pages have a "page->mapping" (and not be anonymous),
> and have the mapping->a_ops->writepage() just always return success
> immediately.

When I was working on this patchset this year with the syscall, this is
similar somewhat to the initial approach I was taking with setting up a
special mapping. It turned into kind of a mess and I couldn't get it
working. There's a lot of functionality built around anonymous pages
that would need to be duplicated (I think?). I'll revisit it if need be,
but let's see if I can make avoiding the dirty bit propagation work.

> It's mainly the pte_dirty games in mm/vmscan.c that does it
> (walk_pte_range), but also the tear-down in mm/memory.c
> (zap_present_folio_ptes). Possibly others that I didn't think of.
> 
> Both do have access to the vma, although in the case of
> walk_pte_range() we don't actually pass it down because we haven't
> needed it).

Actually, it's there hanging out in args->vma, and the function makes
use of that member already. So not so bad.

> 
> There's also page_vma_mkclean_one(), try_to_unmap_one() and
> try_to_migrate_one().  And possibly many others I haven't even thought
> about.
> 
> So quite a few places that do that "transfer dirty bit from pte to folio".

Alright, an hour later of fiddling, and it doesn't actually work (yet?)
-- the selftest fails. A diff follows below.

So, hmm... The swapbacked thing really seemed so simple... I wonder if
there's a way of recovering that.

Jason


diff --git a/mm/gup.c b/mm/gup.c
index ca0f5cedce9b..38745cc4fa06 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -990,7 +990,8 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
 	}
 	if (flags & FOLL_TOUCH) {
 		if ((flags & FOLL_WRITE) &&
-		    !pte_dirty(pte) && !PageDirty(page))
+		    !pte_dirty(pte) && !PageDirty(page) &&
+		    !(vma->vm_flags & VM_DROPPABLE))
 			set_page_dirty(page);
 		/*
 		 * pte_mkyoung() would be more correct here, but atomic care
diff --git a/mm/ksm.c b/mm/ksm.c
index 34c4820e0d3d..2401fc4203ba 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1339,7 +1339,7 @@ static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
 			goto out_unlock;
 		}

-		if (pte_dirty(entry))
+		if (pte_dirty(entry) && !(vma->vm_flags & VM_DROPPABLE))
 			folio_mark_dirty(folio);
 		entry = pte_mkclean(entry);

@@ -1518,7 +1518,7 @@ static int try_to_merge_one_page(struct vm_area_struct *vma,
 			 * Page reclaim just frees a clean page with no dirty
 			 * ptes: make sure that the ksm page would be swapped.
 			 */
-			if (!PageDirty(page))
+			if (!PageDirty(page) && !(vma->vm_flags & VM_DROPPABLE))
 				SetPageDirty(page);
 			err = 0;
 		} else if (pages_identical(page, kpage))
diff --git a/mm/memory.c b/mm/memory.c
index d10e616d7389..6a02d16309be 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1479,7 +1479,7 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,

 	if (!folio_test_anon(folio)) {
 		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
-		if (pte_dirty(ptent)) {
+		if (pte_dirty(ptent) && !(vma->vm_flags & VM_DROPPABLE)) {
 			folio_mark_dirty(folio);
 			if (tlb_delay_rmap(tlb)) {
 				delay_rmap = true;
@@ -6140,7 +6140,8 @@ static int __access_remote_vm(struct mm_struct *mm, unsigned long addr,
 			if (write) {
 				copy_to_user_page(vma, page, addr,
 						  maddr + offset, buf, bytes);
-				set_page_dirty_lock(page);
+				if (!(vma->vm_flags & VM_DROPPABLE))
+					set_page_dirty_lock(page);
 			} else {
 				copy_from_user_page(vma, page, addr,
 						    buf, maddr + offset, bytes);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index aecc71972a87..72d3f8eaae6e 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -216,7 +216,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			migrate->cpages++;

 			/* Set the dirty flag on the folio now the pte is gone. */
-			if (pte_dirty(pte))
+			if (pte_dirty(pte) && !(vma->vm_flags & VM_DROPPABLE))
 				folio_mark_dirty(folio);

 			/* Setup special migration page table entry */
diff --git a/mm/rmap.c b/mm/rmap.c
index 1f9b5a9cb121..1688d06bb617 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1397,12 +1397,7 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 	VM_BUG_ON_VMA(address < vma->vm_start ||
 			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);
-	/*
-	 * VM_DROPPABLE mappings don't swap; instead they're just dropped when
-	 * under memory pressure.
-	 */
-	if (!(vma->vm_flags & VM_DROPPABLE))
-		__folio_set_swapbacked(folio);
+	__folio_set_swapbacked(folio);
 	__folio_set_anon(folio, vma, address, true);

 	if (likely(!folio_test_large(folio))) {
@@ -1777,7 +1772,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		pte_install_uffd_wp_if_needed(vma, address, pvmw.pte, pteval);

 		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
+		if (pte_dirty(pteval) && !(vma->vm_flags & VM_DROPPABLE))
 			folio_mark_dirty(folio);

 		/* Update high watermark before we lower rss */
@@ -1822,7 +1817,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			}

 			/* MADV_FREE page check */
-			if (!folio_test_swapbacked(folio)) {
+			if (!folio_test_swapbacked(folio) || (vma->vm_flags & VM_DROPPABLE)) {
 				int ref_count, map_count;

 				/*
@@ -1846,13 +1841,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * plus the rmap(s) (dropped by discard:).
 				 */
 				if (ref_count == 1 + map_count &&
-				    (!folio_test_dirty(folio) ||
-				     /*
-				      * Unlike MADV_FREE mappings, VM_DROPPABLE
-				      * ones can be dropped even if they've
-				      * been dirtied.
-				      */
-				     (vma->vm_flags & VM_DROPPABLE))) {
+				    !folio_test_dirty(folio)) {
 					dec_mm_counter(mm, MM_ANONPAGES);
 					goto discard;
 				}
@@ -1862,12 +1851,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * discarded. Remap the page to page table.
 				 */
 				set_pte_at(mm, address, pvmw.pte, pteval);
-				/*
-				 * Unlike MADV_FREE mappings, VM_DROPPABLE ones
-				 * never get swap backed on failure to drop.
-				 */
-				if (!(vma->vm_flags & VM_DROPPABLE))
-					folio_set_swapbacked(folio);
+				folio_set_swapbacked(folio);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
 				break;
@@ -2151,7 +2135,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		}

 		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
+		if (pte_dirty(pteval) && !(vma->vm_flags & VM_DROPPABLE))
 			folio_mark_dirty(folio);

 		/* Update high watermark before we lower rss */
@@ -2397,7 +2381,7 @@ static bool page_make_device_exclusive_one(struct folio *folio,
 		pteval = ptep_clear_flush(vma, address, pvmw.pte);

 		/* Set the dirty flag on the folio now the pte is gone. */
-		if (pte_dirty(pteval))
+		if (pte_dirty(pteval) && !(vma->vm_flags & VM_DROPPABLE))
 			folio_mark_dirty(folio);

 		/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..cf5b26bd067a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3396,6 +3396,7 @@ static bool walk_pte_range(pmd_t *pmd, unsigned long start, unsigned long end,
 		walk->mm_stats[MM_LEAF_YOUNG]++;

 		if (pte_dirty(ptent) && !folio_test_dirty(folio) &&
+		    !(args->vma->vm_flags & VM_DROPPABLE) &&
 		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
 		      !folio_test_swapcache(folio)))
 			folio_mark_dirty(folio);
@@ -3476,6 +3477,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 		walk->mm_stats[MM_LEAF_YOUNG]++;

 		if (pmd_dirty(pmd[i]) && !folio_test_dirty(folio) &&
+		    !(vma->vm_flags && VM_DROPPABLE) &&
 		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
 		      !folio_test_swapcache(folio)))
 			folio_mark_dirty(folio);
@@ -4076,6 +4078,7 @@ void lru_gen_look_around(struct page_vma_mapped_walk *pvmw)
 		young++;

 		if (pte_dirty(ptent) && !folio_test_dirty(folio) &&
+		    !(vma->vm_flags & VM_DROPPABLE) &&
 		    !(folio_test_anon(folio) && folio_test_swapbacked(folio) &&
 		      !folio_test_swapcache(folio)))
 			folio_mark_dirty(folio);


