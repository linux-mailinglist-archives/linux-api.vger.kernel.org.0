Return-Path: <linux-api+bounces-1940-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D2292EF36
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 20:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAE11F23586
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 18:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1542B16DEC8;
	Thu, 11 Jul 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="klUTpteH"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D691428FF;
	Thu, 11 Jul 2024 18:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724086; cv=none; b=oPJO4Ebu0mLgYIzxfBT1F2ixcoMDjnNVQiCSW34bzLg9lqXDS9A6G+BXUP1lQCUxwgxJc4iJ69+oA0S4MLgy7bLGZpDQs78NZpprtCjXDZ5gv7bl24JbCRu6uQGXGqvD4QGRGszKtPtqduc+TUmg/6gGwVKXn9c0b/G18zHrMHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724086; c=relaxed/simple;
	bh=MfPVZ8SwNsg2b1Wx75ro72PafLeZUyS8oV4KCinIHoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aztRwZsAhsTzxcPqT23UInCVAPsJ3FzXpyzmIJiAkyC2a2vPgnWKsyW6+2PTR3FxF9c1jHxYoK5kHxBijB5k/F/LfKK2sxMWZ/ma3EQh8H5MTN8u/nda23pdCCVkYnPxkomYluJJd8kbuYYhPN4CIYLBMpqK05EwWXR1USlwBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=klUTpteH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5ACC116B1;
	Thu, 11 Jul 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="klUTpteH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720724082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hF+3z5UiUkBzxLE2MWTvPzkBeBx1F35CrkpoATtAvH0=;
	b=klUTpteHhlYFjt5i9Uxa+JDW827nLqbHIXxDsRFWVsoUOdmLhVZKq87UIao1H1qXD+1hCf
	7sRdozUl1084JtxXpTDHU+UvtkKFrmYC8MLe84dz2Zx+NJlm8gCXpk7NOjYQ0ZVcXxptiK
	lp4bYSdKO+ttMb3gE2qxqRWRG8dq3GA=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff525a5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 18:54:40 +0000 (UTC)
Date: Thu, 11 Jul 2024 20:54:38 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: David Hildenbrand <david@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <ZpAqbh3TnB9hIRRh@zx2c4.com>
References: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com>
 <ZpAc118_U7p3u2gZ@zx2c4.com>
 <ZpAfigBHfHdVeyNO@zx2c4.com>
 <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>

On Thu, Jul 11, 2024 at 08:24:07PM +0200, David Hildenbrand wrote:
> > And PG_large_rmappable seems to only be used for hugetlb branches.
> 
> It should be set for THP/large folios.

And it's tested too, apparently.

Okay, well, how disappointing is this below? Because I'm running out of
tricks for flag reuse.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b9e914e1face..c1ea49a7f198 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -110,6 +110,7 @@ enum pageflags {
 	PG_workingset,
 	PG_error,
 	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
+	PG_owner_priv_2,
 	PG_arch_1,
 	PG_reserved,
 	PG_private,		/* If pagecache, has fs-private data */
@@ -190,6 +191,9 @@ enum pageflags {
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_error,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
+
+	/* Zero page under memory pressure. */
+	PG_droppable = PG_owner_priv_2,
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -549,6 +553,8 @@ PAGEFLAG(Private, private, PF_ANY)
 PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
 PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
 	TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
+PAGEFLAG(OwnerPriv2, owner_priv_2, PF_ANY)
+	TESTCLEARFLAG(OwnerPriv2, owner_priv_2, PF_ANY)
 
 /*
  * Only test-and-set exist for PG_writeback.  The unconditional operators are
@@ -640,6 +646,8 @@ FOLIO_TEST_CLEAR_FLAG_FALSE(young)
 FOLIO_FLAG_FALSE(idle)
 #endif
 
+FOLIO_FLAG(droppable, FOLIO_SECOND_PAGE)
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index b63d211bd141..986551588805 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -108,6 +108,7 @@
 	DEF_PAGEFLAG_NAME(active),					\
 	DEF_PAGEFLAG_NAME(workingset),					\
 	DEF_PAGEFLAG_NAME(owner_priv_1),				\
+	DEF_PAGEFLAG_NAME(owner_priv_2),				\
 	DEF_PAGEFLAG_NAME(arch_1),					\
 	DEF_PAGEFLAG_NAME(reserved),					\
 	DEF_PAGEFLAG_NAME(private),					\
diff --git a/mm/rmap.c b/mm/rmap.c
index 1f9b5a9cb121..73b4052b2f82 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1403,6 +1403,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	 */
 	if (!(vma->vm_flags & VM_DROPPABLE))
 		__folio_set_swapbacked(folio);
+	else
+		folio_set_droppable(folio);
 	__folio_set_anon(folio, vma, address, true);
 
 	if (likely(!folio_test_large(folio))) {
@@ -1852,7 +1854,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				      * ones can be dropped even if they've
 				      * been dirtied.
 				      */
-				     (vma->vm_flags & VM_DROPPABLE))) {
+				      folio_test_droppable(folio))) {
 					dec_mm_counter(mm, MM_ANONPAGES);
 					goto discard;
 				}
@@ -1866,7 +1868,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 * Unlike MADV_FREE mappings, VM_DROPPABLE ones
 				 * never get swap backed on failure to drop.
 				 */
-				if (!(vma->vm_flags & VM_DROPPABLE))
+				if (!folio_test_droppable(folio))
 					folio_set_swapbacked(folio);
 				ret = false;
 				page_vma_mapped_walk_done(&pvmw);
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..41340f2a12c7 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4266,7 +4266,8 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* dirty lazyfree */
-	if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
+	if (type == LRU_GEN_FILE && folio_test_anon(folio) &&
+	    folio_test_dirty(folio) && !folio_test_droppable(folio)) {
 		success = lru_gen_del_folio(lruvec, folio, true);
 		VM_WARN_ON_ONCE_FOLIO(!success, folio);
 		folio_set_swapbacked(folio);


