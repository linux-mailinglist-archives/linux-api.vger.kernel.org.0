Return-Path: <linux-api+bounces-1931-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB292ED99
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3873F1F21187
	for <lists+linux-api@lfdr.de>; Thu, 11 Jul 2024 17:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A3616D9CB;
	Thu, 11 Jul 2024 17:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PUxXa+Bz"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633216D9C1;
	Thu, 11 Jul 2024 17:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720718286; cv=none; b=eh7S2gl6xjyDXaKHarQm7Hniz+oiBkJ6SBKCr1BVBKTnwr6Dy+6Nyzy1LmP8DjapoobTN1HoegDy4Jt9nb0fXRbUKHrQeJrOFXEMuLwniQNd0FZae5hONOV59Fn5RkfvlSGg+bUDpyFi/FWZ3RJfk4vZx4pY+qlV/EOB35+Ferg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720718286; c=relaxed/simple;
	bh=fbxSzES3EkRROFfKWzTcyQ0fdfc0M9p9scwHnSqIB6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tw3Ggh8bWCnVhNaRda6e7fS++GECVnm8wxts2DeIpGWlEIT4Fo1v2LrvSyWtG9KZBBK8TtuWqhTjnshqVn3hbTZZTyDsWe47tiEXVP/y8hxvgW7y/Qqe8MahEzWzjZZpzZmcGEYw5bZiH/k7CCfb7fX2of0eXzMOzocZ1NkegI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=PUxXa+Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4685BC116B1;
	Thu, 11 Jul 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PUxXa+Bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720718282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7H7av5e6HFgdmTlU6/3eCrEUP3JrRh9v2SnfP+d8vw=;
	b=PUxXa+Bzc7MW8ip1keVkzSXe7jtM60InB9Za5eFt1LyO9x9UnYGqVPriBpZNdVW7KElscA
	Ux8NkEsV94bbIJw4fWeDc48tGWW5wGutAkHfajK6cCx6ZixffFWrKo6jm2eKgVOZ6Hg8V8
	iEXn9a+OmamnYLo+V0ManMwBDhXYfNY=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5be0f329 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Jul 2024 17:18:02 +0000 (UTC)
Date: Thu, 11 Jul 2024 19:17:59 +0200
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
Message-ID: <ZpATx21F_01SBRnO@zx2c4.com>
References: <20240709130513.98102-1-Jason@zx2c4.com>
 <20240709130513.98102-2-Jason@zx2c4.com>
 <378f23cb-362e-413a-b221-09a5352e79f2@redhat.com>
 <9b400450-46bc-41c7-9e89-825993851101@redhat.com>
 <Zo8q7ePlOearG481@zx2c4.com>
 <Zo9gXAlF-82_EYX1@zx2c4.com>
 <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZpAR0CgLc28gEkV3@zx2c4.com>

On Thu, Jul 11, 2024 at 07:09:36PM +0200, Jason A. Donenfeld wrote:
> So, hmm... The swapbacked thing really seemed so simple... I wonder if
> there's a way of recovering that.

Not wanting to introduce a new bitflag, I went looking and noticed this:

/*
 * Private page markings that may be used by the filesystem that owns the page
 * for its own purposes.
 * - PG_private and PG_private_2 cause release_folio() and co to be invoked
 */
PAGEFLAG(Private, private, PF_ANY)
PAGEFLAG(Private2, private_2, PF_ANY) TESTSCFLAG(Private2, private_2, PF_ANY)
PAGEFLAG(OwnerPriv1, owner_priv_1, PF_ANY)
        TESTCLEARFLAG(OwnerPriv1, owner_priv_1, PF_ANY)

The below +4/-1 diff is pretty hacky and might be illegal in the state
of California, but I think it does work. The idea is that if that bit is
normally only used for filesystems, then in the anonymous case, it's
free to be used for this.

Any opinions about this, or a suggestion on how to do that in a less
ugly way?

Jason


diff --git a/mm/rmap.c b/mm/rmap.c
index 1f9b5a9cb121..090554277e4a 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1403,6 +1403,8 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 	 */
 	if (!(vma->vm_flags & VM_DROPPABLE))
 		__folio_set_swapbacked(folio);
+	else
+		folio_set_owner_priv_1(folio);
 	__folio_set_anon(folio, vma, address, true);

 	if (likely(!folio_test_large(folio))) {
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2e34de9cd0d4..398b46027e8f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4266,7 +4266,8 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}

 	/* dirty lazyfree */
-	if (type == LRU_GEN_FILE && folio_test_anon(folio) && folio_test_dirty(folio)) {
+	if (type == LRU_GEN_FILE && folio_test_anon(folio) &&
+	    folio_test_dirty(folio) && !folio_test_owner_priv_1(folio)) {
 		success = lru_gen_del_folio(lruvec, folio, true);
 		VM_WARN_ON_ONCE_FOLIO(!success, folio);
 		folio_set_swapbacked(folio);


