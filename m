Return-Path: <linux-api+bounces-3300-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03229A42893
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C49A83AFD59
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 16:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD59326560A;
	Mon, 24 Feb 2025 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWW06DQS"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB382264F8F
	for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416179; cv=none; b=JiKB27E1uul/Fad7pgXH+s0A8Q94ODtT/mmLOM33+RQkbLz+YKoQmR4t0szr1jeybvzUZR2gdW//Duyki3W3s/tWjPzlpDLeWg+8XnFu7resdvAwR37DlWAQu9HZBmsvBQkIbuUhH2HePhJ+wpiNF+pc5N9UO/2jaT7EgMHdjXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416179; c=relaxed/simple;
	bh=2+hWsKxtAvrobFrzRh+8Ehcyr57/khonaGBhd7DELH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TN6VKqK45urxUJzku5dbXg4MP4vdq1RjpYH/o3ucAGQpPkvD7CxYgStYWK+nBpq7oxzZW8Bfq12veSKnoUQBqYBDjkEZRRNcglehIGdNAk6i72i0tdRnayLWnC9PbsCpx6+5Oe7zjxUZPufF//4LGW3M6qg6qGZxdkWv3gKp8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bWW06DQS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2J0EAZe5fI1EPFno0gWSdFeb6AH1J2rAdhMuBREbwsI=;
	b=bWW06DQSBiPOIrnTrNo/ebNbaVO+xH0tuVbWOCC3M5qyYoMjtfPD53vxvYYvDT4rDTjLQb
	L6aJgk10TA1hT2Q1tUF8+86gDYEF92Y3BV7QOMen9d539FiK7YA0nZhM3ePvgPXLbFe9HL
	yYxErvSsdhat/Zk9DRA08UGi49kLFys=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-GIXwVUMuMBCvhkiweEawuw-1; Mon, 24 Feb 2025 11:56:15 -0500
X-MC-Unique: GIXwVUMuMBCvhkiweEawuw-1
X-Mimecast-MFC-AGG-ID: GIXwVUMuMBCvhkiweEawuw_1740416174
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f34b3f9f1so3474683f8f.0
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 08:56:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416174; x=1741020974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2J0EAZe5fI1EPFno0gWSdFeb6AH1J2rAdhMuBREbwsI=;
        b=QY/vAamyzlHpVb17rspfp4rvzcLTpW+O457lAgeocBDyOE/KCOaXgupeD/ovDsy4rv
         THzgJjyIe30d6/C8Gf0UW3HrMn7Wbb6t42kA93dxz3n5/2jQbHyBZglmZp6CcxkEVp4z
         qbymaBy5QQvfXuY/BgwD641r/XA8joWwsz5rn7heTAABj8y6Hizvv/t+itfsVdp+BHLO
         GpG7svob4ch/XLKREY6yknUivoI60w2QjnPeigTSgJP/7/Ui7HvoYdxw9aMMkXJRSQhE
         GrdtC3j+C3it9W3bHcoRrUBZm5VeKO3LWcm0rg1j+Qb/vdN+GGAeXZX2utVwz7MxM2qw
         szTw==
X-Forwarded-Encrypted: i=1; AJvYcCVTs4fINYRc2V6YMMLanzkSXqPYZLny8K1hzBn9I7GKX779bl0DiL4iTyyKYZp8Yv/ZLoUlzkVZtWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxHX1sYgiLQFWUhlwwxTZv8GGU/KjWVvtGiP8Im+u5RG8ve/A
	TS8HZQPY2bf2PTXoOrRhiKSLl1QXzvbQwZQM546qTB8C3szJ3kblD3jWw9BxMQVqVDvZZPcdzXL
	pJk4kXrAH3tWD4d1LnEjz1lAqU/yMGomR6kudWYxWzo+fTnkiTxb3I2QGgQ==
X-Gm-Gg: ASbGnctfDvz3PGTEY3aWxAuEgC4nm332nPs1WrFo4kCWBtYy31rD0MtoSquFCtIGL00
	86C9OwyyQ4l9YeQ5BD+Z/eCbn8LvaCcBTV4MAGpq8I5az73seKN8CAbgYWxtbPz5UWmyqkwgyUv
	fznM15DkLGQUV86otpxAaszKXL7uTmSM9M4tzJjTrGdVS3AitSuV53cfr+d73m50qtmQQd9cUXS
	KoB4la4OEysDn2SJ78btop5clCb+2mCtlyXdReipNEDFs+V21xSy5X5t8JR9/XWp7WpgxSMkw4a
	1DuyZXx+Gjao7JXH+YodHDo1BUgLWGB32WwqhrfvMA==
X-Received: by 2002:a05:6000:178c:b0:38f:32ac:7e55 with SMTP id ffacd0b85a97d-38f6f0bd36dmr13581418f8f.48.1740416173934;
        Mon, 24 Feb 2025 08:56:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHEK4+EskiCQe6b4Tt/1yywMxIN3N8u+em5znQyoHp6oO/UQ3gXRmnxMS/Oum/lKFSKXiOoHw==
X-Received: by 2002:a05:6000:178c:b0:38f:32ac:7e55 with SMTP id ffacd0b85a97d-38f6f0bd36dmr13581391f8f.48.1740416173570;
        Mon, 24 Feb 2025 08:56:13 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f258ddbe0sm32403003f8f.39.2025.02.24.08.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:13 -0800 (PST)
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
Subject: [PATCH v2 04/20] mm: move hugetlb specific things in folio to page[3]
Date: Mon, 24 Feb 2025 17:55:46 +0100
Message-ID: <20250224165603.1434404-5-david@redhat.com>
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

Let's just move the hugetlb specific stuff to a separate page, and stop
letting it overlay other fields for now.

This frees up some space in page[2], which we will use on 32bit to free
up some space in page[1]. While we could move these things to page[3]
instead, it's cleaner to just move the hugetlb specific things out of
the way and pack the core-folio stuff as tight as possible. ... and we
can minimize the work required in dump_folio.

We can now avoid re-initializing &folio->_deferred_list in hugetlb code.

Hopefully dynamically allocating "strut folio" in the future will further
clean this up.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm_types.h | 27 +++++++++++++++++----------
 mm/hugetlb.c             |  1 -
 mm/page_alloc.c          |  5 +++++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e81be20bbabc6..1d9c68c551d42 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -405,20 +405,23 @@ struct folio {
 			unsigned long _flags_2;
 			unsigned long _head_2;
 	/* public: */
-			void *_hugetlb_subpool;
-			void *_hugetlb_cgroup;
-			void *_hugetlb_cgroup_rsvd;
-			void *_hugetlb_hwpoison;
+			struct list_head _deferred_list;
 	/* private: the union with struct page is transitional */
 		};
+		struct page __page_2;
+	};
+	union {
 		struct {
-			unsigned long _flags_2a;
-			unsigned long _head_2a;
+			unsigned long _flags_3;
+			unsigned long _head_3;
 	/* public: */
-			struct list_head _deferred_list;
+			void *_hugetlb_subpool;
+			void *_hugetlb_cgroup;
+			void *_hugetlb_cgroup_rsvd;
+			void *_hugetlb_hwpoison;
 	/* private: the union with struct page is transitional */
 		};
-		struct page __page_2;
+		struct page __page_3;
 	};
 };
 
@@ -455,8 +458,12 @@ FOLIO_MATCH(_refcount, _refcount_1);
 			offsetof(struct page, pg) + 2 * sizeof(struct page))
 FOLIO_MATCH(flags, _flags_2);
 FOLIO_MATCH(compound_head, _head_2);
-FOLIO_MATCH(flags, _flags_2a);
-FOLIO_MATCH(compound_head, _head_2a);
+#undef FOLIO_MATCH
+#define FOLIO_MATCH(pg, fl)						\
+	static_assert(offsetof(struct folio, fl) ==			\
+			offsetof(struct page, pg) + 3 * sizeof(struct page))
+FOLIO_MATCH(flags, _flags_3);
+FOLIO_MATCH(compound_head, _head_3);
 #undef FOLIO_MATCH
 
 /**
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9faa1034704ff..2ad5c292568ab 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1646,7 +1646,6 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 
 	folio_ref_unfreeze(folio, 1);
 
-	INIT_LIST_HEAD(&folio->_deferred_list);
 	hugetlb_free_folio(folio);
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdfc954dab9aa..05a2a9492cdb0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -971,6 +971,11 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 			goto out;
 		}
 		break;
+	case 3:
+		/* the third tail page: hugetlb specifics overlap ->mappings */
+		if (IS_ENABLED(CONFIG_HUGETLB_PAGE))
+			break;
+		fallthrough;
 	default:
 		if (page->mapping != TAIL_MAPPING) {
 			bad_page(page, "corrupted mapping in tail page");
-- 
2.48.1


