Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4A2130EC
	for <lists+linux-api@lfdr.de>; Fri,  3 Jul 2020 03:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgGCBUW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Jul 2020 21:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGCBUV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Jul 2020 21:20:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E83C08C5C1;
        Thu,  2 Jul 2020 18:20:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id o22so8197580pjw.2;
        Thu, 02 Jul 2020 18:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o8LwC+qktyP8ZqLNY6wHCDbWY3Ky3sWMv7KAmaONrVU=;
        b=XvguNpRZTZP/h71d93R73VBOlM08LPuaeOBlneU63ne/L7GLBObyffyWirquXwzInf
         59t68Sik6FbFSfnqXHjB9LmnXjakPzB8VDLhS/RbAAziGzaIv+Sncs0FV3mfuwzt7AFX
         gLIt/5rvF/ONaC+jkxf2MHxcxslGczknFLwtC238Vw3nzbqnGFqV8b/1ZJa8Y8QQIItG
         9Q/OubfWO1HtogwuIrDelys65tKh+KSZwYhYusdsiQpYyLUqDXDGhCJ8eqvU0LILRmeB
         jRgxPziUKmXugrRCu8qc6vh58u4756iZfl8/VXOQRfMPFab7InZAUaLJIz7aueuRVuYF
         x2bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o8LwC+qktyP8ZqLNY6wHCDbWY3Ky3sWMv7KAmaONrVU=;
        b=ZsOa3KokECfez7PciHxB5zVj/wwEgFVXXXQSyorriSn5jYE6Ag2gpFmwDI5IEC7bNT
         lGKkxpCVV6FbnDItKTUpmPr9PQH8JYHBM8yZsV1xH+ipcMxt6i6rsc3tmTlE/EyNpUyU
         tfwOQfTjspHuapb6bXeF8HKY8c4qsPQVp88XmGLUrPIet2Kd2VOpHEhclhCKYqa1VEM9
         6YzK3dm8Tgj8aMEqMtmSov51FeYdBmJZWtvDfO5uycdsB6vkIkMIryGHsYlpxI2hnRTk
         RXfoMbKt9tWSOygP35AdCapeXpoEUqRZ4JfRJZG2+/05BRnHsYE4zS18U+gMIO1GTPVO
         bMzQ==
X-Gm-Message-State: AOAM53375p0guHK8dS5Z3BxbbOAepFkLhtecaNpqdYAKgbAqyVCsyKgi
        S7TQfF3ySs9oxE+IaRG3ars=
X-Google-Smtp-Source: ABdhPJzjRaAlp7XO//YM/8n2zmmXsVRaggi4uCA028UZFvDs8+H+qXrObFXTvNH00boHgly3COvZYw==
X-Received: by 2002:a17:90a:e618:: with SMTP id j24mr4699964pjy.41.1593739221038;
        Thu, 02 Jul 2020 18:20:21 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-186-125.tpgi.com.au. [61.68.186.125])
        by smtp.gmail.com with ESMTPSA id v186sm10094222pfv.141.2020.07.02.18.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 18:20:20 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: [PATCH v2 3/3] powerpc/64s/hash: disable subpage_prot syscall by default
Date:   Fri,  3 Jul 2020 11:19:58 +1000
Message-Id: <20200703011958.1166620-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200703011958.1166620-1-npiggin@gmail.com>
References: <20200703011958.1166620-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The subpage_prot syscall was added for specialised system software
(Lx86) that has been discontinued for about 7 years, and is not thought
to be used elsewhere, so disable it by default.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/Kconfig                   | 7 +++++--
 arch/powerpc/configs/powernv_defconfig | 1 -
 arch/powerpc/configs/pseries_defconfig | 1 -
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 9fa23eb320ff..04c6ca17661a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -833,13 +833,16 @@ config FORCE_MAX_ZONEORDER
 	  this in mind when choosing a value for this option.
 
 config PPC_SUBPAGE_PROT
-	bool "Support setting protections for 4k subpages"
+	bool "Support setting protections for 4k subpages (subpage_prot syscall)"
+	default n
 	depends on PPC_BOOK3S_64 && PPC_64K_PAGES
 	help
-	  This option adds support for a system call to allow user programs
+	  This option adds support for system call to allow user programs
 	  to set access permissions (read/write, readonly, or no access)
 	  on the 4k subpages of each 64k page.
 
+	  If unsure, say N here.
+
 config PPC_COPRO_BASE
 	bool
 
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 2de9aadf0f50..afc0dd73a1e6 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -64,7 +64,6 @@ CONFIG_HWPOISON_INJECT=m
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
 CONFIG_PPC_64K_PAGES=y
-CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
 CONFIG_PM=y
 CONFIG_HOTPLUG_PCI=y
diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index dfa4a726333b..894e8d85fb48 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -57,7 +57,6 @@ CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_PPC_64K_PAGES=y
-CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
 CONFIG_HOTPLUG_PCI=y
 CONFIG_HOTPLUG_PCI_RPA=m
-- 
2.23.0

