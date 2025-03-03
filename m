Return-Path: <linux-api+bounces-3354-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A79A4C7A1
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 17:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E59677AE28E
	for <lists+linux-api@lfdr.de>; Mon,  3 Mar 2025 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B57217F40;
	Mon,  3 Mar 2025 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOIPTglZ"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC70237702
	for <linux-api@vger.kernel.org>; Mon,  3 Mar 2025 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019430; cv=none; b=l+IK8xgesEGP8qtedA96QZhU9tQC4o1UZcJvADCream+0cvD3uFlrBmpSpyDjvyi1KkOSyvljidkT80WjfLvFY4EUlW5+VKmfzbIhMMVsghsG7Vtp7ElV6eCYijOi0dek6OAawbeM0XT1UqOfaN4rPK6M7gcVwfmCv/IjsgciYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019430; c=relaxed/simple;
	bh=3SmHXztWFIDnuQM+XInecxapotD7TtFOOmhMRtX7whw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bj7ipQUFW9+MmNvV9XkRJ8g7E2EqOYRLzcznnszYpPo3K6Ut4WCryA3YVu5MCwlgPWtvk4Cp7/05/qPwquKGwp+C3gIH1ywak5Bk3xp+wmkrG+MhxnCmOxVE7ENFnLXARqxaJTt55emF3vPBHbtPV4s6qfXbSA55Xc1u3uYJIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOIPTglZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741019427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
	b=eOIPTglZGmAp5nYqjLZy9VJDRV8StWiab8EP31uHk3hCO9qMOr7eNBU7C5dIowhnYzxRHP
	WTNNTF9LcAyBZMjjc59Sh/B2POV6BypxP+ySn2Zh03qAejCXldfwKGvRqoup+9ruqoIOjp
	4lCof+Jyz0crXL7/KSEPGYnntJ2QJt4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-D2P7O8tAOHKSJcIUtTuRlQ-1; Mon, 03 Mar 2025 11:30:20 -0500
X-MC-Unique: D2P7O8tAOHKSJcIUtTuRlQ-1
X-Mimecast-MFC-AGG-ID: D2P7O8tAOHKSJcIUtTuRlQ_1741019419
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39101511442so704076f8f.1
        for <linux-api@vger.kernel.org>; Mon, 03 Mar 2025 08:30:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019419; x=1741624219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8IqquS7ke+4+XOv5L24m6qSx7K0PzdfhIUdS/cnqyVA=;
        b=aCxz5g4S9q1G2ihN11NcBFuTKceUq9bC6uiOYcv7f+QkeWxeiwIHC/O69YTkqEJJlB
         WpCoGJkZ3Hz048gKf9fXDcbJSodx/jq+k36nreUOkQ8bfn9xhOp5RtAGdnFIzRXSrA91
         rBFBtpNAQMT/w3wTnErMB6cerzqof/Z2DPW6DxrUrLw1xIestGhjtRndJFRka2eH8kPF
         GbBnkHvR+PDhqKhRKGtjMxiDpaxTTFXwB3um1A8pS7Rl8uxyZuPCsMAo1eDX4k2SOorB
         /pXPS9/Zck0HruKZltjfVMiit3i51YuFNQ+kR3FJVvP/28BwYgBuIOEF7ATiBKz0D9wS
         92+w==
X-Forwarded-Encrypted: i=1; AJvYcCUFp+M0GkH1Hk43EYdAnhTI7IwedYhVVMUdCNcELLLc7diGJV9OxjPc+xeh2TfPUNZprArpBO/fjBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmCFvIKaLO/1woCA/7LcyPDQ07a947RpdE1Y87Usi4Uhapn5AD
	aOl2wHl81Ds1SLSJ2iaMuiA+rqpDYh7gqFZlzPCxOEiB1/Hk0tWphfXg1HFjcLHGURJz4aOeDwl
	V0HSBcHj/EN6ZDCybDfFFtccQcFlS9nuAr0DxfkFF0YDIFAfNfTH/lz858w==
X-Gm-Gg: ASbGncu2DZMxkjSqCUptD2Kd3KeeDivyy+CtJJUkvAsNaLWPoXSaMbC3WN5B6hIZtCy
	YCQbsxdVoas1iOK5q2UER/JzbWkaGw6Q4g8qS3IIhaeYNlMN083as7+pbt/Hs/PLM0xTz14xrv6
	bfKyGeKHS8rTqU/cg/M0WfwxNEBteTTwK9sDm+qu6pFOQCIezVB3wbO9RVd3SdUAQIrh0lbeEKf
	JE4lDmkz5cbWfjlDBHqqGhq+5Lt7RE+9oAQlyn3CYR6CJG2ORu55fLE+iOM//NHlGW8wcNdiq/c
	xohrLAv0iiqjHXTJEz1CG5yd+DMlGfxzOdk16I71O7BBy5HfXEyXgaY9IVCA5p0io02XwiYY47Y
	F
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547278f8f.13.1741019419252;
        Mon, 03 Mar 2025 08:30:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXzBd/+KVXhEWpKLy7bok4As8+LKdGdnCV2QCwLiXkX4QDGRFFrxDGOYHa7Hz+LJLKECZ5dQ==
X-Received: by 2002:a05:6000:156e:b0:390:f9d0:5e7 with SMTP id ffacd0b85a97d-390f9d00782mr6547256f8f.13.1741019418889;
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
Received: from localhost (p200300cbc7349600af274326a2162bfb.dip0.t-ipconnect.de. [2003:cb:c734:9600:af27:4326:a216:2bfb])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e47a6a5esm15196816f8f.35.2025.03.03.08.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:30:18 -0800 (PST)
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
Subject: [PATCH v3 01/20] mm: factor out large folio handling from folio_order() into folio_large_order()
Date: Mon,  3 Mar 2025 17:29:54 +0100
Message-ID: <20250303163014.1128035-2-david@redhat.com>
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
index 7b21b48627b05..b2903bc705997 100644
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


