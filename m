Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAB6D371E
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfJKBZJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:25:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41166 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfJKBYY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id q9so9954166wrm.8
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vmqV2OM13rN8g9gqwuFQcG1AzY2kvl68qXweRe9btYY=;
        b=RKtDHonTyK0sInyXe7q4IAP0UAFPpt2iYIJSb4NBAyqX4KDr2rkltPXrZXLKCAn31t
         Lf1kCT4wGGXqCRuEmtvRsHfkBnaf/9lHVNdkmCGG3HNKJ/ItU/vQClHo/qjb1MexbkbZ
         O5agLhB9srSGfpRqN7jq4pFEGxwcv3dFki7/cFpIKsvwS0oId6J8FQFGKHjsO0FwhkwU
         XeabN3inSXjkfULEysQLgjGlCXEVB779fXrlAFpk/PRHeXPh4IArrMUQKCVIY8JudJ9R
         HrOan2FF5oOrQNm2BvRgCe9yTEVaaQwc34y+PzWX/kmuA1e338AY9rS/u2XnQf7gpiJi
         ZBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vmqV2OM13rN8g9gqwuFQcG1AzY2kvl68qXweRe9btYY=;
        b=qHSlgi4S+D2PC8oKA90lVAmkbisvpLWp3E/bux98hMjH1nVApPYaD8DTmmnWHucdYD
         CptbJGVFFKN2d2cJZ3tkYQ0cN6TV5aTyrIET2BWSSzCG9SbX6LMww5qhuKavtsmpyCNh
         fmue+cz6FsP0ldCLeEN1r40oaRzxXFVoQsFqbSsVOLA3aqHPEcLXnpmX2pu06dok9kd9
         mnuY/JAjFE3Lb6CfqyGowCyhWDnu+IBu2181vV7YZhJQBWtEwv1c/ktGQkt+/rR0F6ED
         y++aPfAH8bzdxKR70z0mOYCZYyqWPKEL2q6KPM/CNUh3Ng9QlamDi8rcH9ByNa6BMpPM
         3ltg==
X-Gm-Message-State: APjAAAVAnH8nZkC8CkEVqNU3B1WV6jlscf5Ch/IKxAOTabt8pOIDPZQl
        6WrTNwNjWCbUcLKRVamEAXuJCw==
X-Google-Smtp-Source: APXvYqxjMvKf23uxoAePg8zl7LYOV5o9nNZkcYnQ2Q4YPUsDdmCOTGtfRnbYn3XkuqD0FGyTthfm+Q==
X-Received: by 2002:a5d:6942:: with SMTP id r2mr10262902wrw.363.1570757061939;
        Thu, 10 Oct 2019 18:24:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:21 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv7 24/33] x86/vdso: On timens page fault prefault also VVAR page
Date:   Fri, 11 Oct 2019 02:23:32 +0100
Message-Id: <20191011012341.846266-25-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As timens page has offsets to data on VVAR page VVAR is going
to be accessed shortly. Set it up with timens in one page fault
as optimization.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f6e13ab29d94..d6cb8a16f368 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -169,8 +169,23 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		 * offset.
 		 * See also the comment near timens_setup_vdso_data().
 		 */
-		if (timens_page)
+		if (timens_page) {
+			unsigned long addr;
+			vm_fault_t err;
+
+			/*
+			 * Optimization: inside time namespace pre-fault
+			 * VVAR page too. As on timens page there are only
+			 * offsets for clocks on VVAR, it'll be faulted
+			 * shortly by VDSO code.
+			 */
+			addr = vmf->address + (image->sym_timens_page - sym_offset);
+			err = vmf_insert_pfn(vma, addr, pfn);
+			if (unlikely(err & VM_FAULT_ERROR))
+				return err;
+
 			pfn = page_to_pfn(timens_page);
+		}
 
 		return vmf_insert_pfn(vma, vmf->address, pfn);
 	} else if (sym_offset == image->sym_pvclock_page) {
-- 
2.23.0

