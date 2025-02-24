Return-Path: <linux-api+bounces-3306-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A329A428B2
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F37E03BCA1B
	for <lists+linux-api@lfdr.de>; Mon, 24 Feb 2025 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F27E266B71;
	Mon, 24 Feb 2025 16:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXSIAcDw"
X-Original-To: linux-api@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D682266B43
	for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416192; cv=none; b=cz7cBNERFNKHDYQduqAkThfPRdMfvxHyKFAgywD+Y4BJwf4UkRbCd6+7hQdL8NcNBtVhqHqou95htE7oN29k3RUbw948GGmRM19P/06h7s1vhIhYdXyLKZ59buyQ+UdurQCm9IhV2aYIKrsWnT4TcFiVqhMapY02qtkqml3ohMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416192; c=relaxed/simple;
	bh=OBXpWDsR7o4dKf8NkhRON4PwL/H6iQiwplPc25GckEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsYTxZ+kVZ/wA1DhdE3QUmT1romVOCdr0hwb6MUmaIDn1CFdMNh5fukVrj4B8RUdEU5mUGK1pQOKEBJoQjdYzhjBkfFl5gfAy26PoHtLZO104HgZ1i0HI7iWGUPuY2NMSoOnz6Y8o0WASfSOaERVSZBJJBztcev5LSSwagG4dfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXSIAcDw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740416189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
	b=GXSIAcDwufAWg0YwVWCfMZiIy83ilr2g1jbMeBNqunZoCZT1v8vMm9a900zGlqzaqjp7FU
	aUuB8pP8/FVzp9VoHHh6y6pgmArEiutiuD9MFakCNsJ/RVb/zKVIUEvDJc44C0/+MtwEs7
	s82O6p+Usyu5W2foCj12MZ3EALznRcM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-lk_T2L6PNPupXKfahTWA1Q-1; Mon, 24 Feb 2025 11:56:27 -0500
X-MC-Unique: lk_T2L6PNPupXKfahTWA1Q-1
X-Mimecast-MFC-AGG-ID: lk_T2L6PNPupXKfahTWA1Q_1740416186
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4393e873962so23628845e9.3
        for <linux-api@vger.kernel.org>; Mon, 24 Feb 2025 08:56:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416186; x=1741020986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VusPlBbKEOGpL4wS1BqoWY6CYb2f4HQ+/wIDh8p+vAo=;
        b=lkDtuWr/PoXufDYM5/o5jm8EUb44jvcOMga3L2nEAl1xKltUb1F2BdA9hxJyi+eAdc
         IE0cQmRkXXzN2rJgACD5/7Gxqbb55YgckejCekHH/R4R3Vk/oknMGKctk3BZcVtE0nBN
         tFj3f9YVihzRZ8Wev6dd71i2uNOpm6LUGH6N2dXAv60Rkwmh6TP6sKu6Ab9K0D4QTxMP
         nCJy1KEwOgXaEx+5NyIZ2opBCEEBPMQd8d2BviedBgwuJVktWnFP6czj0L44kVONU1Rj
         KQylzk4+CxDZxuVJSwLigVo/R9aic35O4mq2X7XaoUUNH408VoA5/aSG1YUn/wH+0Gqc
         OE7A==
X-Forwarded-Encrypted: i=1; AJvYcCWavqHS2KznAQylYEJOysXuEa2XAtPcS2JHXI6Mh4wHb5i1fz3qzbwwgRBVfaQ6mLAYPqSC+awR/uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhfUgXwSijF4lgm19f9nGlpaXyeb5iPaZaxZaE3+sKx8JDlaJ
	ROiqlr53vijwHVe1Zol/3fUUkoSX6+rW+8s8yvNTGiD2upcho2jH/848/H3E8GuN3rCwbHdX2xY
	G474gKYlnYuWsWcnPTO29CXnAYO/NtTik50OQGH6qulzHrqqHMzIBahHvxQ==
X-Gm-Gg: ASbGncsNRe41HL1LCqPKzE4ELssILZSbTInc1Orxuyrx7R8wCiuEDxF+WovsfUJATJI
	V31qi4yFNm4b58eJ+0MYvrgl1zvIIv48gxOXrVCCqIQFH4Xv26sBvPE0f8kcsQ6lwnTVmGFq7zg
	kUmrlJQOiNJkO7Fc4bwVtuxFg9fcKqXsPMHAUecCD/U1xPf2PeBmUn3WZbm8ZmiAMSgFyG4bDMS
	688G9uzHCII1J5EQBlF38bbsrpIFfEHJA84EmsfE4umXPvof5WG0stK5D8lO9m3zvT2PSbU1np4
	/5d6eflQ4Zey2LDrZD5YF/G9DYX5cNlX3/vrghpWzA==
X-Received: by 2002:a05:600c:4f43:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ab0f2db61mr336735e9.7.1740416186365;
        Mon, 24 Feb 2025 08:56:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWfaIC9jLsYbcLXi3Fdeg1qCi0/sJNUC8bLA+3qaJ5mWtkIjQvv3YtNjkQQj/btQBGxQxPlw==
X-Received: by 2002:a05:600c:4f43:b0:439:9828:c425 with SMTP id 5b1f17b1804b1-43ab0f2db61mr336445e9.7.1740416185910;
        Mon, 24 Feb 2025 08:56:25 -0800 (PST)
Received: from localhost (p4ff234b6.dip0.t-ipconnect.de. [79.242.52.182])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-439b030b347sm111391345e9.26.2025.02.24.08.56.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 08:56:25 -0800 (PST)
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
Subject: [PATCH v2 10/20] bit_spinlock: __always_inline (un)lock functions
Date: Mon, 24 Feb 2025 17:55:52 +0100
Message-ID: <20250224165603.1434404-11-david@redhat.com>
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

The compiler might decide that it is a smart idea to not inline
bit_spin_lock(), primarily when a couple of functions in the same file end
up calling it. Especially when used in RMAP map/unmap code next, the
compiler sometimes decides to not inline, which is then observable in
some micro-benchmarks.

Let's simply flag all lock/unlock functions as __always_inline;
arch_test_and_set_bit_lock() and friends are already tagged like that
(but not test_and_set_bit_lock() for some reason).

If ever a problem, we could split it into a fast and a slow path, and
only force the fast path to be inlined. But there is nothing
particularly "big" here.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/bit_spinlock.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
index bbc4730a6505c..c0989b5b0407f 100644
--- a/include/linux/bit_spinlock.h
+++ b/include/linux/bit_spinlock.h
@@ -13,7 +13,7 @@
  * Don't use this unless you really need to: spin_lock() and spin_unlock()
  * are significantly faster.
  */
-static inline void bit_spin_lock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_lock(int bitnum, unsigned long *addr)
 {
 	/*
 	 * Assuming the lock is uncontended, this never enters
@@ -38,7 +38,7 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
 /*
  * Return true if it was acquired
  */
-static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
+static __always_inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 {
 	preempt_disable();
 #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
@@ -54,7 +54,7 @@ static inline int bit_spin_trylock(int bitnum, unsigned long *addr)
 /*
  *  bit-based spin_unlock()
  */
-static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
@@ -71,7 +71,7 @@ static inline void bit_spin_unlock(int bitnum, unsigned long *addr)
  *  non-atomic version, which can be used eg. if the bit lock itself is
  *  protecting the rest of the flags in the word.
  */
-static inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
+static __always_inline void __bit_spin_unlock(int bitnum, unsigned long *addr)
 {
 #ifdef CONFIG_DEBUG_SPINLOCK
 	BUG_ON(!test_bit(bitnum, addr));
-- 
2.48.1


