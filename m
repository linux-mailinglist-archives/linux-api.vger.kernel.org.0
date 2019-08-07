Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEE8851DA
	for <lists+linux-api@lfdr.de>; Wed,  7 Aug 2019 19:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389053AbfHGRQV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 13:16:21 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33827 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389050AbfHGRQV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 13:16:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id i2so41792738plt.1
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RUBxnyz640QfvTz6lz/Tqs2pyOPmGqnxC24rkQCQqR8=;
        b=qUcsAiEOKB0kyiDTK9YasOF7A4ofZDbfv+p8AIH2GkVHqwEwA1IA/h3IzTFeMkODCy
         rbSy4s5NCnbvnUouu7MfVETepWhtmKX5MsEvPzADXzvQqfRMT3AznSoRGnX5bZHxlply
         d1709s86c+06D6w3zpjya8G4jJGHYnl8N2mVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RUBxnyz640QfvTz6lz/Tqs2pyOPmGqnxC24rkQCQqR8=;
        b=pe3/jh7B8V9+JqbTlDY/+YJ6Ntj6W8ru3Q2qkQjK4hoUQghxix4T/JxPTl2kR/BreL
         +WlOoH6RQyKZ3Q/J9t/5rPJyi5QdatLIO6rN3RnmUZiJfa4zXWNlyxG/r+TlnymN/+47
         2TCEQ03GcbuRg0+tt+//RBAsZVGlsRWqcKzl5j989MKD+1Ky4tag62HKFlEwf728NVfM
         mwGsZ1Jhip/ek8I12xtiG7P2NWQmry7v6VC09gd6oGHIKZ0NLup20phwgfkUX9Tw2DnD
         LOaRpBIWfRCoKe9cHmSqE34oAB7QViY+Kt62JRJO6Ys8H9NWw4Xy1QjZZ0sTM34Xa4vK
         nkGw==
X-Gm-Message-State: APjAAAXBjTW9VKeVG4G7zhSWiH5eAImUXz9XHHOwbWxG1N8VyKB1iHet
        AgWhFaLJFi8ClZK8lJY8XnPE9w==
X-Google-Smtp-Source: APXvYqyljthmaedQMd1J+PXKwGtyBWQtdiL8Gz9KlrlERrf+UnJhUAJEITHMkjgMGR3wYbFETkajsg==
X-Received: by 2002:a17:902:b497:: with SMTP id y23mr9265019plr.68.1565198179959;
        Wed, 07 Aug 2019 10:16:19 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a1sm62692130pgh.61.2019.08.07.10.16.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 10:16:19 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brendan Gregg <bgregg@netflix.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>, minchan@kernel.org,
        namhyung@google.com, paulmck@linux.ibm.com,
        Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        Thomas Gleixner <tglx@linutronix.de>, tkjos@google.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>
Subject: [PATCH v5 4/6] [RFC] arm64: Add support for idle bit in swap PTE
Date:   Wed,  7 Aug 2019 13:15:57 -0400
Message-Id: <20190807171559.182301-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807171559.182301-1-joel@joelfernandes.org>
References: <20190807171559.182301-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This bit will be used by idle page tracking code to correctly identify
if a page that was swapped out was idle before it got swapped out.
Without this PTE bit, we lose information about if a page is idle or not
since the page frame gets unmapped.

In this patch we reuse PTE_DEVMAP bit since idle page tracking only
works on user pages in the LRU. Device pages should not consitute those
so it should be unused and safe to use.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/pgtable-prot.h |  1 +
 arch/arm64/include/asm/pgtable.h      | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3adcec05b1f6..9d1412c693d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -128,6 +128,7 @@ config ARM64
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS if COMPAT
 	select HAVE_ARCH_PREL32_RELOCATIONS
+	select HAVE_ARCH_PTE_SWP_PGIDLE
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_STACKLEAK
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 92d2e9f28f28..917b15c5d63a 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -18,6 +18,7 @@
 #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
 #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
 #define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
+#define PTE_SWP_PGIDLE		PTE_DEVMAP		 /* for idle page tracking during swapout */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 3f5461f7b560..558f5ebd81ba 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -212,6 +212,21 @@ static inline pte_t pte_mkdevmap(pte_t pte)
 	return set_pte_bit(pte, __pgprot(PTE_DEVMAP));
 }
 
+static inline int pte_swp_page_idle(pte_t pte)
+{
+	return 0;
+}
+
+static inline pte_t pte_swp_mkpage_idle(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(PTE_SWP_PGIDLE));
+}
+
+static inline pte_t pte_swp_clear_page_idle(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(PTE_SWP_PGIDLE));
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	WRITE_ONCE(*ptep, pte);
-- 
2.22.0.770.g0f2c4a37fd-goog

