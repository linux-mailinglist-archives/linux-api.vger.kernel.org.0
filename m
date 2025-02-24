Return-Path: <linux-api+bounces-3315-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3692A428E5
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C25C44403D9
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E79264A89;
	Mon, 24 Feb 2025 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPryXaiq"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8E267F68
	for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416211; cv=none; b=C96DhoFf6Hl9n6xGL1A6lx7hJ2vU3aISdiDJPnr9p0U/L8RU/AJh7ywW7zDR0+x19LKfaLbqVIlMYv9qS+QyflvFtADApxVXnHguREkhmglTPvYLhbViCWBd09EZBwln0Bo2OjV7L9xiXvala7ylPmBWNCHKaAvRMAQowwudDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416211; c=relaxed/simple;
	bh=9KDOJkYIHHSmS8EWVgHad+sJWVwCwusKqKnGhETdnT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6V4Eyd9YnSoQvmHSrShBUisqp9mN4lJ0t0hHwRxslvZf0Zhia+dGcJgc3LnZ5OOhzb8tWvdJrISG2P6ITPwMDi8hucx6CEFcgzzpnUCT4vT8GGZ+aWgBhFrufnBU1GZMfmsmZ8l3TH7dFEV2hvHu0/FkB26CUkUb73PTXBjumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPryXaiq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYLglXDyFMXUmuyPM7L4Wt5NI1TaS59XhalfSABwrEE=;
	b=DPryXaiqE2nXdM6aAX03qT/KRobjuXPgcdhA2sYFqMHeWgbDTq756lhjIi5c6DsS4/2Y94
	Ndx2COVaTXlodCmlniCQIoa68ML6qt8+F3V170VCbV2SJDBgBh/xDBxbsTkOKN3LFvIdzq
	hypoBqiWGypXvOxp8cpp577T6IqzzOE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-Q93cXYWSPSmqfThVhcrblA-1; Mon, 24 Feb 2025 11:56:47 -0500
X-MC-Unique: Q93cXYWSPSmqfThVhcrblA-1
X-Mimecast-MFC-AGG-ID: Q93cXYWSPSmqfThVhcrblA_1740416206
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f20b530dfso4998618f8f.3
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 08:56:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416206; x=1741021006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYLglXDyFMXUmuyPM7L4Wt5NI1TaS59XhalfSABwrEE=;
        b=DFmkAyP8mezEsEaNrnOIUsmpK6xiVJSTXWXH+3tLiEIeMJqSPZCX2bIIBvmyRRxd7S
         wTWc94Fv5vxt0kVa6KQxSD3PAYyfIJcnwTL6Wx4+3wjD+bzgPAmRtFcXWg9IeZhaovxi
         fz4Y+ymzbaykTCd2bSNsGdw/oB+XA2Nygk9mqULNFO0MK8sw0wgTlLpojyfRDGmu5dDM
         nHYkf622aIDrIYV+r/xJJQHNYOWhz42btyrg4HXHPA3Fw29oNYcDJ+SuF7DS9D94CJRX
         EVNUzKGoIoUqtZEkpTalYWI/E+ytYm/+e3/c13Io03JBqXGK4Ho2kFVQFfa0g1+4+dFy
         vr1g==
X-Forwarded-Encrypted: i=1; AJvYcCXEBBdUsHIxTMp3DvOI8FHCQZcrFCdULZL6R6XGD9PT4pLSkWzz9CSIlOwwrI9cFWHs4KuUPpv+LF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX7di3Fpdpf6IoabB4ukp5CbyyxxvQu+qUwkwAYooiALgHy5dF
	RzlnlSzlBCL66vcdEpu4Rnx5xQRVGAzi0ece/p/yQyKIX/x8cCPIk3pjP1rxWiFUsHUVgECOsMY
	ZbC6hsD4WsfPosWmNXkqRgnxu7467Ve/97z+wcZAPg1tnWgpEqQHF0dbt3Q==
X-Gm-Gg: ASbGnctlmeBkxaHZ5abqahK989Lsy4TOa3QkqdC7z08Ima0F3YLNf39xGRWqtlGUCFt
	lwOofMcMVbgaYadyJfC6KmywbTApvAqdPgR9il26XuqJ0XhKwoSeQm25ZR6qRwkKROMhC79eGAR
	vcgQLzsEnuHnGgS5MhyFuqQ/jNfveq7If1Ih57JVFjOhfLAu/fV9vlJ9lhwxqvGbYY51QY5u9qY
	kwrlc4RKfnUWB8+84uHphM+NABnnxxr92odGytjvGGepkF8dJ8s+wNv31Q2O9sOvvjlOVD782Xl
	dSpnJmVPMAfes8tg3AAd8vU8B2RVtMM91g6zMUokyA==
X-Received: by 2002:a5d:6da5:0:b0:38d:cf33:31a1 with SMTP id ffacd0b85a97d-38f707afc79mr12824172f8f.23.1740416206023;
        Mon, 24 Feb 2025 08:56:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7oc6/f/Omy9ecKXhn6XnBr6bqzxs+GSFB5uGM8J4SWQqdkeD7RWsCxWskwEhPaUkzkpZm0Q==
X-Received: by 2002:a5d:6da5:0:b0:38d:cf33:31a1 with SMTP id ffacd0b85a97d-38f707afc79mr12824140f8f.23.1740416205579;
        Mon, 24 Feb 2025 08:56:45 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259f7998sm31659273f8f.82.2025.02.24.08.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:45 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>
Subject: [PATCH v2 19/20] fs/proc/task_mmu: remove per-page mapcount dependency for smaps/smaps_rollup (CONFIG_NO_PAGE_MAPCOUNT)
Date: Mon, 24 Feb 2025 17:56:01 +0100
Message-ID: <20250224165603.1434404-20-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224165603.1434404-1-david@redhat.com>
References: <20250224165603.1434404-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's implement an alternative when per-page mapcounts in large folios are
no longer maintained -- soon with CONFIG_NO_PAGE_MAPCOUNT.

When computing the output for smaps / smaps_rollups, in particular when
calculating the USS (Unique Set Size) and the PSS (Proportional Set Size),
we still rely on per-page mapcounts.

To determine private vs. shared, we'll use folio_likely_mapped_shared(),
similar to how we handle PM_MMAP_EXCLUSIVE. Similarly, we might now
under-estimate the USS and count pages towards "shared" that are
actually "private" ("exclusively mapped").

When calculating the PSS, we'll now also use the average per-page
mapcount for large folios: this can result in both, an over-estimation
and an under-estimation of the PSS. The difference is not expected to
matter much in practice, but we'll have to learn as we go.

We can now provide folio_precise_page_mapcount() only with
CONFIG_PAGE_MAPCOUNT, and remove one of the last users of per-page
mapcounts when CONFIG_NO_PAGE_MAPCOUNT is enabled.

Document the new behavior.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/filesystems/proc.rst | 13 +++++++++++++
 fs/proc/internal.h                 |  8 ++++++++
 fs/proc/task_mmu.c                 | 17 +++++++++++++++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1aa190017f796..57d55274a1f42 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -506,6 +506,19 @@ Note that even a page which is part of a MAP_SHARED mapping, but has only
 a single pte mapped, i.e.  is currently used by only one process, is accounted
 as private and not as shared.
 
+Note that in some kernel configurations, all pages part of a larger allocation
+(e.g., THP) might be considered "shared" if the large allocation is
+considered "shared": if not all pages are exclusive to the same process.
+Further, some kernel configurations might consider larger allocations "shared",
+if they were at one point considered "shared", even if they would now be
+considered "exclusive".
+
+Some kernel configurations do not track the precise number of times a page part
+of a larger allocation is mapped. In this case, when calculating the PSS, the
+average number of mappings per page in this larger allocation might be used
+as an approximation for the number of mappings of a page. The PSS calculation
+will be imprecise in this case.
+
 "Referenced" indicates the amount of memory currently marked as referenced or
 accessed.
 
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 16aa1fd260771..70205425a2daa 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -143,6 +143,7 @@ unsigned name_to_int(const struct qstr *qstr);
 /* Worst case buffer size needed for holding an integer. */
 #define PROC_NUMBUF 13
 
+#ifdef CONFIG_PAGE_MAPCOUNT
 /**
  * folio_precise_page_mapcount() - Number of mappings of this folio page.
  * @folio: The folio.
@@ -173,6 +174,13 @@ static inline int folio_precise_page_mapcount(struct folio *folio,
 
 	return mapcount;
 }
+#else /* !CONFIG_PAGE_MAPCOUNT */
+static inline int folio_precise_page_mapcount(struct folio *folio,
+		struct page *page)
+{
+	BUILD_BUG();
+}
+#endif /* CONFIG_PAGE_MAPCOUNT */
 
 /**
  * folio_average_page_mapcount() - Average number of mappings per page in this
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d7ee842367f0f..7ca0bc3bf417d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -707,6 +707,8 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 	struct folio *folio = page_folio(page);
 	int i, nr = compound ? compound_nr(page) : 1;
 	unsigned long size = nr * PAGE_SIZE;
+	bool exclusive;
+	int mapcount;
 
 	/*
 	 * First accumulate quantities that depend only on |size| and the type
@@ -747,18 +749,29 @@ static void smaps_account(struct mem_size_stats *mss, struct page *page,
 				      dirty, locked, present);
 		return;
 	}
+
+	if (IS_ENABLED(CONFIG_NO_PAGE_MAPCOUNT)) {
+		mapcount = folio_average_page_mapcount(folio);
+		exclusive = !folio_maybe_mapped_shared(folio);
+	}
+
 	/*
 	 * We obtain a snapshot of the mapcount. Without holding the folio lock
 	 * this snapshot can be slightly wrong as we cannot always read the
 	 * mapcount atomically.
 	 */
 	for (i = 0; i < nr; i++, page++) {
-		int mapcount = folio_precise_page_mapcount(folio, page);
 		unsigned long pss = PAGE_SIZE << PSS_SHIFT;
+
+		if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT)) {
+			mapcount = folio_precise_page_mapcount(folio, page);
+			exclusive = mapcount < 2;
+		}
+
 		if (mapcount >= 2)
 			pss /= mapcount;
 		smaps_page_accumulate(mss, folio, PAGE_SIZE, pss,
-				dirty, locked, mapcount < 2);
+				dirty, locked, exclusive);
 	}
 }
 
-- 
2.48.1


