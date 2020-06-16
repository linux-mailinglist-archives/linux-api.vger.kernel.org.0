Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7621FAA66
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2020 09:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgFPHuI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Jun 2020 03:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgFPHt5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Jun 2020 03:49:57 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52A2C00862D
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:49 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d8so8013521plo.12
        for <linux-api@vger.kernel.org>; Tue, 16 Jun 2020 00:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZajOneOdlQKQYlo8Wv9k+OekhqsO1R3/YXgaBEECIjE=;
        b=iqIaqckVAQUEvZtp4+/qsmQGE37BQNoO7PPWo/5IR2umOLzuafxrc36ojsqisBA3bi
         4zDJkmA8POCcTYB6xD7jmfglS/ATrJpAhXrtlCt2PRv4l86gJXFiKqXPxzD8cJrtBfyx
         OCYp+xbwpnhRS2dDLpCWXdlx5v5ovlS/TJnjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZajOneOdlQKQYlo8Wv9k+OekhqsO1R3/YXgaBEECIjE=;
        b=ACIXQR5VHYG6zAC7vjc6zHmjA5BMgjainPRD1uq1UC3tWE0ycoIMAZl10YBibo+bIe
         dO/8sq8Nuccq5MxMbJEnuX94VWYATEqh3c/ruh/OBZSpqaHktvSxtv0cokpnxQW5M1lb
         f6NhOP81quOl6Isv/nZZRBeeKks+I83hu1G/mrvpbw94O6qC8SLjQaW1dxYRWt2TGcJZ
         Hyc/YDjuuXNfNLOifKHs009vjEKsj1cXWsUk2vbykBqV6u7CU318TsegnaAHhKx6/ePJ
         3vhb2RCgK/fqvfhAX0SWEc1zw2BUL0519AQ79Ik6MxbquwFsq3oTFN/oSFWuvyPMztu+
         VWTg==
X-Gm-Message-State: AOAM532T0QiqiKX1+2ETzr25jA5GHIESf0l+PXeFjHKQ64vJLwrwnk8w
        v3e5KCLBT2tw3jP7m+hCe9eu6g==
X-Google-Smtp-Source: ABdhPJzFGf3zdAH2lmOL+oV+0KAfuNbBFFTLvoCLw3Vpzi0gDjZEe/FxPo59Sd/M81CmJjESIzVUVw==
X-Received: by 2002:a17:90a:f508:: with SMTP id cs8mr1719058pjb.16.1592293789402;
        Tue, 16 Jun 2020 00:49:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m22sm17139899pfk.216.2020.06.16.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:49:46 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.ws>, Jann Horn <jannh@google.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Chris Palmer <palmer@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Hehuazhen <hehuazhen@huawei.com>, x86@kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 6/8] x86: Provide API for local kernel TLB flushing
Date:   Tue, 16 Jun 2020 00:49:32 -0700
Message-Id: <20200616074934.1600036-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200616074934.1600036-1-keescook@chromium.org>
References: <20200616074934.1600036-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The seccomp constant action bitmap filter evaluation routine depends
on being able to quickly clear the PTE "accessed" bit for a temporary
allocation. Provide access to the existing CPU-local kernel memory TLB
flushing routines.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/tlbflush.h |  2 ++
 arch/x86/mm/tlb.c               | 12 +++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e0b660..ae853e77d6bc 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -228,6 +228,8 @@ extern void flush_tlb_all(void);
 extern void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables);
+extern void local_flush_tlb_kernel_range(unsigned long start,
+					 unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
 static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long a)
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1a3569b43aa5..ffcf2bd0ce1c 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -959,16 +959,22 @@ void flush_tlb_all(void)
 	on_each_cpu(do_flush_tlb_all, NULL, 1);
 }
 
-static void do_kernel_range_flush(void *info)
+void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	struct flush_tlb_info *f = info;
 	unsigned long addr;
 
 	/* flush range by one by one 'invlpg' */
-	for (addr = f->start; addr < f->end; addr += PAGE_SIZE)
+	for (addr = start; addr < end; addr += PAGE_SIZE)
 		flush_tlb_one_kernel(addr);
 }
 
+static void do_kernel_range_flush(void *info)
+{
+	struct flush_tlb_info *f = info;
+
+	local_flush_tlb_kernel_range(f->start, f->end);
+}
+
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
 	/* Balance as user space task's flush, a bit conservative */
-- 
2.25.1

