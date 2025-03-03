Return-Path: <linux-api+bounces-3363-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC09AA4C7CB
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC523A500B
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF192505BC;
	Mon,  3 Mar 2025 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyI/gIrY"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C724EF86
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019453; cv=none; b=h5h3Gqq7VIhtmBXONiebQKsDKycKlNS98IjMA+FMQEc8iIYIaVcmYV8u0fYYYES+xr41q2i0RcOfzLdSlbfszN7qVH+ctD5gDFaVGDzIxlVVAP0Gc6D71YLiJ5mGtmYO73Ymzfj2Z7IgzdAd/f9FHKllL0DC/MYBD2PfqNNB7tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019453; c=relaxed/simple;
	bh=Ycu3g93agHZ5+lzaLOnuhINjqTNBvJJTMooJF9ouEus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xr6KCrJR0tw0T6kb4PecjiW7HhBL4IaqV2Vp//gdauueXFHCT3sfOPDQ8Ze5fyrGyHGiF0LcLCmEHJeh1lyZ6IXJwbvGPt7ClCo81U2RZXAv8kVHhrfwGLrLaaYA+UhmAQRrfhcgRAxt+J8MQiC+dbh5fYhGmOseaER0N4y4fwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EyI/gIrY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
	b=EyI/gIrYIXSiYBp2egkvzZji/hCAFomH+ajSiiEgQjqt4EZLD4l0FpIObMJeIf8SZlLcDt
	rncfIFQLoKTJVmLRS0i71VhQ/AO3UgXHNNQ+0u/Ro02uP35WjyXbwORw1lidyQwgWWlvMA
	3sE8mj3/IbkL6afnfpr6KLZmAO1n7Yg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-33iMGzRgP7eTuRPWCW95KA-1; Mon, 03 Mar 2025 11:30:39 -0500
X-MC-Unique: 33iMGzRgP7eTuRPWCW95KA-1
X-Mimecast-MFC-AGG-ID: 33iMGzRgP7eTuRPWCW95KA_1741019438
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43bc5a18c52so4619155e9.3
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:30:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019438; x=1741624238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cb8Ah8lJoOkHJddlEV7mqidKdKB3PYdRohUjXTfR2AA=;
        b=peqG5LBCrLxN3dtz31cy3bVqyHR7QQ/ebKt0t/vDPX+9Rt/wA0ZjcS/K+zZBaXlf+U
         nUezMzez6sLeILRFx+ThPRYTCAr43d2bQ4BgIeniZuERwhqrvfHLNAfiW68O8TqEUIh2
         5Cf+DnlzBEu6GzK+g9jtCreJOGfoRWUlDGwZ5AITdMGG3TtNkBX+jH+psmDJPIcivRx2
         NTDvCsoTuFV0KyLEKqLxjScw/f1AanNbdpQbakVSVRVeAD/AhoM+gA12eVxM+h7/wrYC
         ZQjwbfErnfuHrP2j5tAL+bQrv6H6Pt3nat4SAfP1Bn7sXlYOnD5mZX3UEGgJ4kvmj6Rd
         GXhg==
X-Forwarded-Encrypted: i=1; AJvYcCUoX/2AcYmEgp2hEOJVJUoz1KMhno9oBdcgeAMLOegs6vA9PU3TD11RH2UFYhM+S3msicjWnX8KQUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjCzj5QbMlL/F23w/MfZX5B3lD9OwI8sEtzIFlwhGFgbFIWgDm
	Nm4wxjSzBdDdI4MMPZbYdYEDdqD2UUWCjBmnbVvkxzqH3bIvxXCuUDKX7CooEFG+F4kxWDw4vqR
	GEK+Q0z79miVCmAU9hflNlzRwKcajmG1oT8F2cGBPJryRK557WGOEjSMB1w==
X-Gm-Gg: ASbGncvFmHIh/E+eZe2/nSntn/8AZ26kKxyrAHWEa3/ttOj0BMhwlOoUatDZIApz4wt
	coiT//Wuu9VHpqeMe6/jnc9Dt0gReKHKPgtj6ibdFaxmQaKbXHY1BgTw89KU2BYAz8LzUdyTR2J
	MrFXXffOKR1zuGqk+BBbOHhYgEgMjXCfzYPdMdcZxLxUB8i92bFClZfM3qWwYZirzYuMwMC4fqb
	GLhkCxYaZkoos2zenL34i8XJpDJ5PNm+L3vWaiwFba4HJCNy2M1Dl9TV3UqFWur1+HH84qJ+la9
	2QZAx1oOXt7HdJ6bEcVfr36l4yY7IMxYjSuPJocHtBR5M545zj8zY14ey7bQiv1Y/FmBWjmmm1u
	s
X-Received: by 2002:a05:600c:4f0c:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43ba66e1f3amr118908075e9.10.1741019438220;
        Mon, 03 Mar 2025 08:30:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdpz0gqig8RUNxdVw3Ebkq3f5eeFacb1rX/1/2my2Nw7/Vx42fOquiEWgwrBfEGJjD+4uhoA==
X-Received: by 2002:a05:600c:4f0c:b0:439:91dd:cf9c with SMTP id 5b1f17b1804b1-43ba66e1f3amr118907545e9.10.1741019437826;
        Mon, 03 Mar 2025 08:30:37 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bc06eba55sm45297035e9.21.2025.03.03.08.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:37 -0800 (PST)
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
Subject: [PATCH v3 09/20] mm/rmap: abstract large mapcount operations for large folios (!hugetlb)
Date: Mon,  3 Mar 2025 17:30:02 +0100
Message-ID: <20250303163014.1128035-10-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250303163014.1128035-1-david@redhat.com>
References: <20250303163014.1128035-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's abstract the operations so we can extend these operations easily.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/rmap.h | 32 ++++++++++++++++++++++++++++----
 mm/rmap.c            | 14 ++++++--------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index e795610bade80..d1e888cc97a58 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -173,6 +173,30 @@ static inline void anon_vma_merge(struct vm_area_struct *vma,
 
 struct anon_vma *folio_get_anon_vma(const struct folio *folio);
 
+static inline void folio_set_large_mapcount(struct folio *folio, int mapcount,
+		struct vm_area_struct *vma)
+{
+	/* Note: mapcounts start at -1. */
+	atomic_set(&folio->_large_mapcount, mapcount - 1);
+}
+
+static inline void folio_add_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_add(diff, &folio->_large_mapcount);
+}
+
+static inline void folio_sub_large_mapcount(struct folio *folio,
+		int diff, struct vm_area_struct *vma)
+{
+	atomic_sub(diff, &folio->_large_mapcount);
+}
+
+#define folio_inc_large_mapcount(folio, vma) \
+	folio_add_large_mapcount(folio, 1, vma)
+#define folio_dec_large_mapcount(folio, vma) \
+	folio_sub_large_mapcount(folio, 1, vma)
+
 /* RMAP flags, currently only relevant for some anon rmap operations. */
 typedef int __bitwise rmap_t;
 
@@ -352,12 +376,12 @@ static __always_inline void __folio_dup_file_rmap(struct folio *folio,
 		do {
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 }
@@ -451,7 +475,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 				ClearPageAnonExclusive(page);
 			atomic_inc(&page->_mapcount);
 		} while (page++, --nr_pages > 0);
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, dst_vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -461,7 +485,7 @@ static __always_inline int __folio_try_dup_anon_rmap(struct folio *folio,
 			ClearPageAnonExclusive(page);
 		}
 		atomic_inc(&folio->_entire_mapcount);
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, dst_vma);
 		break;
 	}
 	return 0;
diff --git a/mm/rmap.c b/mm/rmap.c
index 8a7d023b02e0c..08846b7eced60 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1266,7 +1266,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 		    atomic_add_return_relaxed(first, mapped) < ENTIRELY_MAPPED)
 			nr = first;
 
-		atomic_add(orig_nr_pages, &folio->_large_mapcount);
+		folio_add_large_mapcount(folio, orig_nr_pages, vma);
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
@@ -1290,7 +1290,7 @@ static __always_inline unsigned int __folio_add_rmap(struct folio *folio,
 				nr = 0;
 			}
 		}
-		atomic_inc(&folio->_large_mapcount);
+		folio_inc_large_mapcount(folio, vma);
 		break;
 	}
 	return nr;
@@ -1556,14 +1556,12 @@ void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
 				SetPageAnonExclusive(page);
 		}
 
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, nr - 1);
+		folio_set_large_mapcount(folio, nr, vma);
 		atomic_set(&folio->_nr_pages_mapped, nr);
 	} else {
 		/* increment count (starts at -1) */
 		atomic_set(&folio->_entire_mapcount, 0);
-		/* increment count (starts at -1) */
-		atomic_set(&folio->_large_mapcount, 0);
+		folio_set_large_mapcount(folio, 1, vma);
 		atomic_set(&folio->_nr_pages_mapped, ENTIRELY_MAPPED);
 		if (exclusive)
 			SetPageAnonExclusive(&folio->page);
@@ -1665,7 +1663,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 			break;
 		}
 
-		atomic_sub(nr_pages, &folio->_large_mapcount);
+		folio_sub_large_mapcount(folio, nr_pages, vma);
 		do {
 			last += atomic_add_negative(-1, &page->_mapcount);
 		} while (page++, --nr_pages > 0);
@@ -1678,7 +1676,7 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 		break;
 	case RMAP_LEVEL_PMD:
 	case RMAP_LEVEL_PUD:
-		atomic_dec(&folio->_large_mapcount);
+		folio_dec_large_mapcount(folio, vma);
 		last = atomic_add_negative(-1, &folio->_entire_mapcount);
 		if (last) {
 			nr = atomic_sub_return_relaxed(ENTIRELY_MAPPED, mapped);
-- 
2.48.1


