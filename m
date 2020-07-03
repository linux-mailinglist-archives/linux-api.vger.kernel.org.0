Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECE2130E8
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 03:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbgGCBUO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Jul 2020 21:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgGCBUO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Jul 2020 21:20:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773CC08C5C1;
        Thu,  2 Jul 2020 18:20:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k71so9668942pje.0;
        Thu, 02 Jul 2020 18:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pmg18ZVtz+aHnPcYNR/ar+KZfsU0xgw5dZN9uFapXrc=;
        b=ix7QrYTkhbDElBDQK97dD1ZIli7OvLW/q7YCa37dgxZSpEvoqvj/NxJqsufWECEq3S
         XSXfix0vvdAjZrZo/tEINlw/lEf9zvilReHVhtnVH+m30hJKBgbcMQkV1J0aWFUbb5KI
         mVn4lAk/ruolbBf+cVKfHymLp1+q2DDJ4S7C48wPGgVaHq3Z4QHjZkA9OxLHA3sEivvx
         3wHYXv0G89NH3Ct7j7NZBHWcqBJ+tG9nSD8QDzP8Y5oJVWCgxwSKjpHutopLdgqblx73
         lKyGbJUndXKYW4TSufT1Ci6JX1PVnu/D7zg9L0k8Wh1+WQDpqcqPHRe0ZH7oOYNzjvr5
         5I+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pmg18ZVtz+aHnPcYNR/ar+KZfsU0xgw5dZN9uFapXrc=;
        b=tmfvzZZ44MjqMWGZf3Vp8p6JKf+lGeKKrZ9F1tAlvtPBeSjyoHOCCJiNcyURFZGTgg
         Vr8MiHg+GlZnLEoecTK2fQchivArCrww/PBMyr6xOiRybcWApdVJnZ16vnu7wlfCS/XS
         ZL1FJIFM2pIHgKtpR2RX10DRl8UWXjNDHjNsFM5JLJfbVFpNdH9Q9gLeidWWbCymoicv
         JYRX5ni5eQknzonX+IJn5BneVXBYfW7EGhNjg0ru78QcDvRrhehmGM95eYTAD+TYgrYl
         jiA3/Kone+gPiHeamZ3ketFJNx1RESmbT+Buq4D9YPWFZTud7de3s/cHz94/Ne6h+ntt
         Gr1g==
X-Gm-Message-State: AOAM531jesAhexCQECK11/j9B7yHuhW6ogeXLpU4h7hwG6BBSAXBsj14
        LmOt/m5QOAdOLqcmKomvoRdBJCgr
X-Google-Smtp-Source: ABdhPJycoMHaJ6keUkaICJE+J9qDkLH3KGkWOscF7Ui+Q5MY7bumj4st46Jo8k4jaioh/RUFY3o5GQ==
X-Received: by 2002:a17:90b:405:: with SMTP id v5mr10594146pjz.226.1593739213943;
        Thu, 02 Jul 2020 18:20:13 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id v186sm10094222pfv.141.2020.07.02.18.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 18:20:13 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: [PATCH v2 1/3] powerpc: remove stale calc_vm_prot_bits comment
Date:   Fri,  3 Jul 2020 11:19:56 +1000
Message-Id: <20200703011958.1166620-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200703011958.1166620-1-npiggin@gmail.com>
References: <20200703011958.1166620-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This comment is wrong, we wouldn't use calc_vm_prot_bits here because
we are being called by calc_vm_prot_bits to modify its behaviour.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/mman.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index d610c2e07b28..4ba303ea27f5 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,10 +13,6 @@
 #include <linux/pkeys.h>
 #include <asm/cpu_has_feature.h>
 
-/*
- * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
- * here.  How important is the optimization?
- */
 static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 		unsigned long pkey)
 {
-- 
2.23.0

