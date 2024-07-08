Return-Path: <linux-api+bounces-1876-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A424B92A4E3
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D71F221C3
	for <lists+linux-api@lfdr.de>; Mon,  8 Jul 2024 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C134A13212E;
	Mon,  8 Jul 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D+7UqdX4"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F64A1C06;
	Mon,  8 Jul 2024 14:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720449620; cv=none; b=sg6QoOiOKzgDENQnYN506SZmCWIP/AQ8JWJEYe+yc/oAJbJNk/GrDJ0gAtvB0bj9/L0S85YwZm1I10um48RYGyqeNVh9ttAeLYJnVIuCe9QoMeEfoGEMXIWjgQnB8nngkkZiPeso+S4U7y11VV7B5lnMC+dferQLk8qQdGw1yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720449620; c=relaxed/simple;
	bh=EotIE2EkIcCGEg0bpwtB7upShPJL9YI3mkVALm6kvQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWpSW2VXwocHHCdcQGrrhakRLdFQpLzrepg9zHYO6o7lHPzm9lg420wwGy6nUa0vZJ0YefkivdHdE736u95u5bBsjkB9CtYSmEn//B38cliqRrYWIisN4grdEjYjtPvv5ag9i++IjQDyKxq03od3hFMXoi7mfvjy9IY47PQk7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=D+7UqdX4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8716BC116B1;
	Mon,  8 Jul 2024 14:40:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D+7UqdX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720449617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0SVD6RYkTCza/OjXuqE4YQ/CLLC7BL/wZbBa6QC5Nrc=;
	b=D+7UqdX4S41qYEPlxYdtc5sdLpbHcUWJLWFBchA8QpkcMrzJ6naGFIFnFW+bv7OFTRJ5TN
	X1boeGv+DE0zXLWSyKeSAHPkq4sBCwiCd3RLO2SmG7U3Vb4Gh1WNSqn5seigTA4ciGXXGm
	8//4T7XZREEJMIQ2JoxezeEkzywtsUc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 58b436e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jul 2024 14:40:16 +0000 (UTC)
Date: Mon, 8 Jul 2024 16:40:09 +0200
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
Subject: Re: [PATCH v21 1/4] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
Message-ID: <Zov6SZZCKrqmigua@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
 <20240707002658.1917440-2-Jason@zx2c4.com>
 <1583c837-a4d5-4a8a-9c1d-2c64548cd199@redhat.com>
 <CAHk-=wjs-9DVeoc430BDOv+dkpDkdVvkEsSJxNVZ+sO51H1dJA@mail.gmail.com>
 <e2f104ac-b6d9-4583-b999-8f975c60d469@redhat.com>
 <CAHk-=wibRRHVH5D4XvX1maQDCT-o4JLkANXHMoZoWdn=tN0TLA@mail.gmail.com>
 <6705c6c8-8b6a-4d03-ae0f-aa83442ec0ab@redhat.com>
 <CAHk-=wi=XvCZ9r897LjEb4ZarLzLtKN1p+Fyig+F2fmQDF8GSA@mail.gmail.com>
 <7439da2e-4a60-4643-9804-17e99ce6e312@redhat.com>
 <Zovv4lzM38EHtnms@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zovv4lzM38EHtnms@zx2c4.com>

Hi David, Linus,

Below is what I understand the suggestions about the UX to be. The full
commit is in https://git.zx2c4.com/linux-rng/log/ but here's the part
we've been discussing. I've held off on David's suggestion changing
"DROPPABLE" to "VOLATILE" to give Linus some time to wake up on the west
coast and voice his preference for "DROPPABLE". But the rest is in
place.

Jason

diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
index a246e11988d5..e89d00528f2f 100644
--- a/include/uapi/linux/mman.h
+++ b/include/uapi/linux/mman.h
@@ -17,6 +17,7 @@
 #define MAP_SHARED	0x01		/* Share changes */
 #define MAP_PRIVATE	0x02		/* Changes are private */
 #define MAP_SHARED_VALIDATE 0x03	/* share + validate extension flags */
+#define MAP_DROPPABLE	0x08		/* Zero memory under memory pressure. */
 
 /*
  * Huge page size encoding when MAP_HUGETLB is specified, and a huge page
diff --git a/mm/madvise.c b/mm/madvise.c
index a77893462b92..cba5bc652fc4 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1068,13 +1068,16 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		new_flags |= VM_WIPEONFORK;
 		break;
 	case MADV_KEEPONFORK:
+		if (vma->vm_flags & VM_DROPPABLE)
+			return -EINVAL;
 		new_flags &= ~VM_WIPEONFORK;
 		break;
 	case MADV_DONTDUMP:
 		new_flags |= VM_DONTDUMP;
 		break;
 	case MADV_DODUMP:
-		if (!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL)
+		if ((!is_vm_hugetlb_page(vma) && new_flags & VM_SPECIAL) ||
+		    (vma->vm_flags & VM_DROPPABLE))
 			return -EINVAL;
 		new_flags &= ~VM_DONTDUMP;
 		break;
diff --git a/mm/mlock.c b/mm/mlock.c
index 30b51cdea89d..b87b3d8cc9cc 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -485,7 +485,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 
 	if (newflags == oldflags || (oldflags & VM_SPECIAL) ||
 	    is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
-	    vma_is_dax(vma) || vma_is_secretmem(vma))
+	    vma_is_dax(vma) || vma_is_secretmem(vma) || (oldflags & VM_DROPPABLE))
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
diff --git a/mm/mmap.c b/mm/mmap.c
index 83b4682ec85c..b3d38179dd42 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1369,6 +1369,34 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 			pgoff = 0;
 			vm_flags |= VM_SHARED | VM_MAYSHARE;
 			break;
+		case MAP_DROPPABLE:
+			/*
+			 * A locked or stack area makes no sense to be droppable.
+			 *
+			 * Also, since droppable pages can just go away at any time
+			 * it makes no sense to copy them on fork or dump them.
+			 *
+			 * And don't attempt to combine with hugetlb for now.
+			 */
+			if (flags & (MAP_LOCKED | MAP_HUGETLB))
+			        return -EINVAL;
+			if (vm_flags & (VM_GROWSDOWN | VM_GROWSUP))
+			        return -EINVAL;
+
+			vm_flags |= VM_DROPPABLE;
+
+			/*
+			 * If the pages can be dropped, then it doesn't make
+			 * sense to reserve them.
+			 */
+			vm_flags |= VM_NORESERVE;
+
+			/*
+			 * Likewise, they're volatile enough that they
+			 * shouldn't survive forks or coredumps.
+			 */
+			vm_flags |= VM_WIPEONFORK | VM_DONTDUMP;
+			fallthrough;
 		case MAP_PRIVATE:
 			/*
 			 * Set pgoff according to addr for anon_vma.


