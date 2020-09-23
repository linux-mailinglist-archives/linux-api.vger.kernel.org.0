Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24994276479
	for <lists+linux-api@lfdr.de>; Thu, 24 Sep 2020 01:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgIWX32 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Sep 2020 19:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgIWX31 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Sep 2020 19:29:27 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8695C0613CE
        for <linux-api@vger.kernel.org>; Wed, 23 Sep 2020 16:29:27 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d19so599929pld.0
        for <linux-api@vger.kernel.org>; Wed, 23 Sep 2020 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRM2RxYevz4ZLx42XYlJ4AIQPGby+e+r+LDyrwiMJmY=;
        b=YImT8s0t4ro5HLSsWUw0wPm9p8M2rMPRr1XMLfBu5tvvY24Y3b7+SScvQCxYa+mKnA
         hgoYM5/ccPMAXnlw70N83Y9+Cl38QLui9PJIpibXpOgNKL6n5KQ4soHzwx2kGWb3WXCm
         Jnq0DOeHpwfCyW/oH3OOX/dvAtuDKFlbXMpdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRM2RxYevz4ZLx42XYlJ4AIQPGby+e+r+LDyrwiMJmY=;
        b=mecVl1CcBHAElhY22p3jnF7G0he4E6fCHyTGkH73/Kd59j+/yhLGMOTKG6fAaDgIOt
         ZETivF8H06HYueC5Huzy3ApZ55dMsn+cOVSm16kuRU5Xm+SacDpJ3raqUEJkVOZq4CEb
         x3tjNjwuULzCftx9PJhylnXviv7jrktLi6xEZ3gqqOpNa+GHUnU6SwSjamwxlAGmOYeB
         hVGmYIQkAaw/nMQxDKhQWcpLNV+zSu8qA4XRxnQoWHMjjqGKFKWsAvpRyETcRRbXlfcD
         c/ClwEruvsWkoDanxz6Q1spHsCAWlN7LFaDBXpHHzT6mWRzjWzpuTPdgpqRlUlDNQqet
         eXrQ==
X-Gm-Message-State: AOAM532Tbhm2WYHjSMy1h+ODxj9bDY70V/baTzykZocUOryXV/X3Gxex
        mY4YuLAubkrIFWu2rzijwJb8aw==
X-Google-Smtp-Source: ABdhPJxLRLuysYMwMBl98TDjJXH+A1GJK5BYJ/9bxber4JuLQfhK8FiL18o08N5dn4Gk6n7figNXTQ==
X-Received: by 2002:a17:90a:4046:: with SMTP id k6mr1441778pjg.11.1600903767231;
        Wed, 23 Sep 2020 16:29:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c186sm828427pga.61.2020.09.23.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:29:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] x86: Enable seccomp architecture tracking
Date:   Wed, 23 Sep 2020 16:29:19 -0700
Message-Id: <20200923232923.3142503-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923232923.3142503-1-keescook@chromium.org>
References: <20200923232923.3142503-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Provide seccomp internals with the details to calculate which syscall
table the running kernel is expecting to deal with. This allows for
efficient architecture pinning and paves the way for constant-action
bitmaps.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/seccomp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 2bd1338de236..38181e20e1d3 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -16,6 +16,20 @@
 #define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
 #endif
 
+#ifdef CONFIG_X86_64
+# define SECCOMP_ARCH					AUDIT_ARCH_X86_64
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT				AUDIT_ARCH_I386
+# endif
+# ifdef CONFIG_X86_X32_ABI
+#  define SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH	AUDIT_ARCH_X86_64
+#  define SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK	__X32_SYSCALL_BIT
+#  define SECCOMP_MULTIPLEXED_SYSCALL_TABLE_SHIFT	29
+#endif
+#else /* !CONFIG_X86_64 */
+# define SECCOMP_ARCH					AUDIT_ARCH_I386
+#endif
+
 #include <asm-generic/seccomp.h>
 
 #endif /* _ASM_X86_SECCOMP_H */
-- 
2.25.1

