Return-Path: <linux-api+bounces-1938-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED3992EE76
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 20:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEDD281DAB
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 18:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ED517165C;
	Thu, 11 Jul 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GG5fdtTA"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9193D16EB46;
	Thu, 11 Jul 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721296; cv=none; b=D87ILJ0t9YXyBJH/SXJ+fFTAjidrADiB88CWGQmx5SIL0DR5cHnXobspVsmuFN3SdZ9/gTyPC59rIa6zr7MUSjw+DEVCI/T1kJR/Z9VwZtapRP+p7PtIw5ZrBbYiJwD0RZ+l//6eiYEldKX0T3orelZ/pXaoOVGmIETPdoy1SGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721296; c=relaxed/simple;
	bh=kCEqjpo+ZVR6xK/Dc/PdG5Yks8sL5srMtDfZOT3AIdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQVSD5mrrrK6AhwMGNPHWZzeV1D/QnLehnsuH92lzB4zXuQ/gEVUTrX8HQST/4mvSmsdE0Ow38TtwVnt2DSpzEsLcZ1DP60T2SmBmYMuCUTKmmkgylmc3t7GP7tvI0oTr3Ka6D0RH0r0/QhGe/eBZF099ZgrpuJPmiuUMEAUccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=GG5fdtTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7F0C116B1;
	Thu, 11 Jul 2024 18:08:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GG5fdtTA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720721293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vrbjgfDMzIE2fcJdddHdiUI6Z2R4tJHcA1zxYRpyDQo=;
	b=GG5fdtTA1zCjARiOc0JT2QSJVFEpN+jrCTd4q+NR1JZpl6ubGktju4Q7+hV3hbjaAVoVxw
	p7Px6jD7dDn9VczXfHDjzPwm2sWOSlLNWsok1IGTQyQKEw8jT3tF2M1TUt51rUnMTjwOyu
	hlHzl8eqdhiSplPQ21B8RBPD+k0vyqk=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a8ed7bc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 18:08:13 +0000 (UTC)
Date: Thu, 11 Jul 2024 20:08:10 +0200
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
Message-ID: <ZpAfigBHfHdVeyNO@zx2c4.com>
References: <Zo8q7ePlOearG481@zx2c4.com>
 <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
 <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com>
 <ZpAc118_U7p3u2gZ@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpAc118_U7p3u2gZ@zx2c4.com>

On Thu, Jul 11, 2024 at 07:56:39PM +0200, Jason A. Donenfeld wrote:
> On Thu, Jul 11, 2024 at 07:54:34PM +0200, Jason A. Donenfeld wrote:
> > On Thu, Jul 11, 2024 at 07:27:27PM +0200, David Hildenbrand wrote:
> > > > PG_owner_priv_1 maps to PG_swapcache? :)
> > > 
> > > Maybe the combination !swapbacked && swapcache could be used to indicate 
> > > such folios. (we will never set swapbacked)
> > > 
> > > But likely we have to be a bit careful here. We don't want 
> > > folio_test_swapcache() to return for folios that ... are not in the 
> > > swapcache.
> > 
> > I was thinking that too, but I'm afraid it's going to be another
> > whack-a-mole nightmare. Even for things like task_mmu in procfs that
> > show stats, that's going to be wonky.
> > 
> > Any other flags we can overload that aren't going to be already used in
> > our case?
> 
> PG_error / folio_set_error seems unused in the non-IO case.

And PG_large_rmappable seems to only be used for hugetlb branches.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b9e914e1face..7fdc03197438 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -190,6 +190,7 @@ enum pageflags {
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_error,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
+	PG_droppable = PG_error, /* anon droppable, not hugetlb */
 };

 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -640,6 +641,8 @@ FOLIO_TEST_CLEAR_FLAG_FALSE(young)
 FOLIO_FLAG_FALSE(idle)
 #endif

+FOLIO_FLAG(droppable, FOLIO_SECOND_PAGE)
+
 /*
  * PageReported() is used to track reported free pages within the Buddy
  * allocator. We can use the non-atomic version of the test and set
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

