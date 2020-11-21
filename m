Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97D22BBE4E
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 10:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgKUJ7R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 21 Nov 2020 04:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgKUJ7Q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 21 Nov 2020 04:59:16 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E32C0613CF
        for <linux-api@vger.kernel.org>; Sat, 21 Nov 2020 01:59:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so15058933ybm.13
        for <linux-api@vger.kernel.org>; Sat, 21 Nov 2020 01:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WsUEi0z7Dz1bXAOmQFYUbblVTp6z5WKIjT4H2OhRZ68=;
        b=s3QDryrbltRJk8zKcIElUF32zdgNc8BkPT6ab64oRstGNPHQ9R/E7+KGLUQKVHM95/
         tWE8mquVCh87Nvk5zBgvLs9cJx15NLV7ORuiIgrkwYoe96Xuoz3MZjHFiGJ/fZ5sKNWk
         0doNapBW8uAZoM2pYgyZOqmQGmpbG1ADbuz9Mlkz7x8lZDzCIGHRYpwkYL6Qt8DTAvEC
         7mEl6uJxpSu+If1fgSLJlA/CTYTB+ioiZ+CJ/Dc5nGG8/aSozMx1sPdkoF+QK9158srZ
         dfDuzdqlPkvicRzBsWMtTJ7g80uOOEeDjsHVrz5TusTR6t8Tk6WGS7lGMLrcx+3yIB7o
         PUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WsUEi0z7Dz1bXAOmQFYUbblVTp6z5WKIjT4H2OhRZ68=;
        b=MQJUK1u9a7jLz4IgHbu6KVONvDTKG1sQxKxdnc9mUQdjtBI85rUOXZ7QmjliEHX6sE
         t/h4SIt2t7gHTsIY/v9aogWUlJkAprOBn2gOykkSN8zgjjinsILeICJIWtdLfKX1HjuK
         C9+UgbMmQcOcNnlozDhYJH15faTZunGrACV2irnweW5NWwAD5+1dy4awkgbR6AOV0Kqm
         LWDEcF+RnMZ4hT6OcHanEnLOTQPwKOwHPQSUX9qho2PYLUHtwL9X77Z1cxYg26nD7IFt
         xG5ShVK+HGqGK+b7Q6gEbfZfN3Z5H0OFe3gbXoW5cFfOJF05KHct7VWHQaz/Nm17ARVS
         6bEQ==
X-Gm-Message-State: AOAM530MuGnVHV2sUgg0nAfGWTwnvheAv45ENTBlNycSkerOharboYj8
        ji7QPak6Jm1cAoQ4ENgK0Sb/yLY=
X-Google-Smtp-Source: ABdhPJwpMi8YpdlPVDbGMRvK6mmXDOOcxdGseF1dACwdw8lxl7n8LLdTIpImechooRrzXDxVZYzz0kY=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:cb55:: with SMTP id b82mr36207818ybg.334.1605952754258;
 Sat, 21 Nov 2020 01:59:14 -0800 (PST)
Date:   Sat, 21 Nov 2020 01:59:02 -0800
Message-Id: <20f64e26fc8a1309caa446fffcb1b4e2fe9e229f.1605952129.git.pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 1/2] kasan: arm64: set TCR_EL1.TBID1 when enabled
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On hardware supporting pointer authentication, we previously ended up
enabling TBI on instruction accesses when tag-based ASAN was enabled,
but this was costing us 8 bits of PAC entropy, which was unnecessary
since tag-based ASAN does not require TBI on instruction accesses. Get
them back by setting TCR_EL1.TBID1.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I3dded7824be2e70ea64df0aabab9598d5aebfcc4
---
 arch/arm64/include/asm/pgtable-hwdef.h | 1 +
 arch/arm64/mm/proc.S                   | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
index 01a96d07ae74..42442a0ae2ab 100644
--- a/arch/arm64/include/asm/pgtable-hwdef.h
+++ b/arch/arm64/include/asm/pgtable-hwdef.h
@@ -260,6 +260,7 @@
 #define TCR_TBI1		(UL(1) << 38)
 #define TCR_HA			(UL(1) << 39)
 #define TCR_HD			(UL(1) << 40)
+#define TCR_TBID1		(UL(1) << 52)
 #define TCR_NFD0		(UL(1) << 53)
 #define TCR_NFD1		(UL(1) << 54)
 #define TCR_E0PD0		(UL(1) << 55)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 23c326a06b2d..97a97a61a8dc 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -40,7 +40,7 @@
 #define TCR_CACHE_FLAGS	TCR_IRGN_WBWA | TCR_ORGN_WBWA
 
 #ifdef CONFIG_KASAN_SW_TAGS
-#define TCR_KASAN_FLAGS TCR_TBI1
+#define TCR_KASAN_FLAGS TCR_TBI1 | TCR_TBID1
 #else
 #define TCR_KASAN_FLAGS 0
 #endif
-- 
2.29.2.454.gaff20da3a2-goog

