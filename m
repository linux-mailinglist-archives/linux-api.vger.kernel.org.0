Return-Path: <linux-api+bounces-3297-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F0A42874
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 17:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1771189A24A
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 697AF264A6D;
	Mon, 24 Feb 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHOuOyOT"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927842641E9
	for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 16:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416175; cv=none; b=CQHN963XmDTncp6dGe6sFcX92iqfLbHQp/MtJLP4Y1R+FSiHP6+KZ0tYcWkq4AC3PV9X3YFv2oK9wUc/vQaruNnyybHynOWCfrhHPc8QuSNZIabSy/+vrA/TuMO3pYpmIl8+Fr6CL3j7InKsFUL6Uclp974zqTjYUmiSOaaD548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416175; c=relaxed/simple;
	bh=VmpdZSRRUc/hbRQ4rkKLLuRh8r6J0srT0ICzqEnE21Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIcHs1yWT6/+PhVMfQy1AP8A5Co6j3pSq/fb3kWBxoeigCvDkfL2KV2FRDt7vxMYK6PUBx4z7AXDXz+nxhiiVVZNtESjGrS/Mwilzw+FIv+gYL1L+0g+bcD5kT7rGyrGBzKdTT6RZQUK9Dd7HKqdD3CIr95XI6e6XtWgfhLTG/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHOuOyOT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Yy4w/XZlsv8uxY4mojETBma8CfgELpSYNnd4DKCaPQ=;
	b=LHOuOyOTQSbeoMqpXA8sww8uEXmkDa18AyXEF+vUEhRsHy5c/xCXizE5QrULPCM0D7tOs9
	7QevbV70Io+rOIIlw3G6Iz5O9BISzZ/4uA7gkMFkxtJ8hZqTsfip5fp4k6EvwQTQz+SrcF
	m1EIAiwjhPwook0hhECd5qWGr+btFRE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-1s219n2fPEG978s9crV4tw-1; Mon, 24 Feb 2025 11:56:08 -0500
X-MC-Unique: 1s219n2fPEG978s9crV4tw-1
X-Mimecast-MFC-AGG-ID: 1s219n2fPEG978s9crV4tw_1740416168
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43947a0919aso40361045e9.0
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 08:56:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416168; x=1741020968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Yy4w/XZlsv8uxY4mojETBma8CfgELpSYNnd4DKCaPQ=;
        b=JelDB2m1R1QtgcYtInFt69rcol2dmRnFYK3pEmGj+mHi4KrTQ4P1ZZGuilIsc5HThF
         5JV4puaU89bX86IA5K8lnEIm4s9UL6u6EalGd/eaup1Yf3fR0mpFz0/ae5th5ObclVza
         Fl+Th+Ol5DSR2JEDAW+T3AYFXieeVWXb74ccXBLtiIb3duHtdQ+Y2K63GzLOfbkUseit
         FSY2Ex3W33LrYaWVNLspKa4oOZ5KtPxTxneeKIiefSV5QgivRcgzD4jThB3ygshhVwNj
         F2Tzzf4BcKzk92v2ylPxHxLiB+lOxRXhR0EaZ8nc6TynFx3Smoe6LMMZIIBkv/y6chWO
         uvWA==
X-Forwarded-Encrypted: i=1; AJvYcCVNgE17Ds9dCDsZw/JFmZQPDgRKtwh3jbdL0cXwtCjkY6W67ph+CsMBFXTrdLIR2qFNZK4Uc2nfTKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjMjSvcjwkbKW39Y2upb31yrUf1WKjBs8gpNgfmPJCbvLEttKV
	4RcrcFyw8wBXpR5lbJrqPzehr3WfZ0bcYUf2GBxC1jcfSuuU6xi51yJWVZlitgd9dOvlFpe9Gq+
	VgSKc+x3ISNwN1ZPR1dYQzcaJcqYrJ0fL0LmfWSfOkFZpplGR3FOzYZFFtg==
X-Gm-Gg: ASbGncvALdr+/Vk6CCEwRCFeorZ2peM3rdo69lu8mAGb6kKbnLpGaSUvlBPCYqUJ/z9
	UnwkcLQsQmhmpNqdCgrLt2WDIjlQo5m5dP/b/cz82cBGM23feOUChjJafit1GlLVxklPsXHZ/u/
	WX1N/UaBfpk5mTqmqM1VRNxXl5f37KlX8iBIderJNGVgxtwCgj7JmmGYvJ4d4hl6Lyl1v98kP3U
	NjFkp7lNsVo0T3H94iRUIEfjdhgPbcCyJszMpPp3II6GWepgZd/JrxiRodnZJ3RhYD33Q+Mik1U
	jE3PZM/mtTmXyUI8WPSG6duNielPpboS9MOHjJPVBg==
X-Received: by 2002:a05:6000:1ac7:b0:38f:2a99:b377 with SMTP id ffacd0b85a97d-38f6f0c4523mr13709698f8f.53.1740416167616;
        Mon, 24 Feb 2025 08:56:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrYsCtuTnI9EW4wn4ZrbygGJqAwQI73Wf+OvRO5jakiYr702W8tJwU3BfJXILKECpWzIC3lQ==
X-Received: by 2002:a05:6000:1ac7:b0:38f:2a99:b377 with SMTP id ffacd0b85a97d-38f6f0c4523mr13709656f8f.53.1740416167205;
        Mon, 24 Feb 2025 08:56:07 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38f259d5e92sm32611493f8f.66.2025.02.24.08.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:06 -0800 (PST)
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
	Jann Horn <jannh@google.com>,
	Lance Yang <ioworker0@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 01/20] mm: factor out large folio handling from folio_order() into folio_large_order()
Date: Mon, 24 Feb 2025 17:55:43 +0100
Message-ID: <20250224165603.1434404-2-david@redhat.com>
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

Let's factor it out into a simple helper function. This helper will
also come in handy when working with code where we know that our
folio is large.

Maybe in the future we'll have the order readily available for small and
large folios; in that case, folio_large_order() would simply translate to
folio_order().

Reviewed-by: Lance Yang <ioworker0@gmail.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d82feabbe44f8..d00214e22a174 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1194,6 +1194,11 @@ struct inode;
 
 extern void prep_compound_page(struct page *page, unsigned int order);
 
+static inline unsigned int folio_large_order(const struct folio *folio)
+{
+	return folio->_flags_1 & 0xff;
+}
+
 /*
  * compound_order() can be called without holding a reference, which means
  * that niceties like page_folio() don't work.  These callers should be
@@ -1207,7 +1212,7 @@ static inline unsigned int compound_order(struct page *page)
 
 	if (!test_bit(PG_head, &folio->flags))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 /**
@@ -1223,7 +1228,7 @@ static inline unsigned int folio_order(const struct folio *folio)
 {
 	if (!folio_test_large(folio))
 		return 0;
-	return folio->_flags_1 & 0xff;
+	return folio_large_order(folio);
 }
 
 #include <linux/huge_mm.h>
@@ -2139,7 +2144,7 @@ static inline long folio_nr_pages(const struct folio *folio)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
@@ -2164,7 +2169,7 @@ static inline unsigned long compound_nr(struct page *page)
 #ifdef CONFIG_64BIT
 	return folio->_folio_nr_pages;
 #else
-	return 1L << (folio->_flags_1 & 0xff);
+	return 1L << folio_large_order(folio);
 #endif
 }
 
-- 
2.48.1


