Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC248F0F8
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfHOQkY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:40:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38048 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732408AbfHOQjI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so2773133wrr.5
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MjEHvnSKKqtqfjPruFAI4NMd2j71wVzmmWx9wAlQuc=;
        b=HTX4yiF/8+vOl2kB9AjOV8v3S0ymXWxUbgor0coQs6Z6ML/gnhxu3P7Jl0dN6QrYJP
         QJTCt+JrZfwMH+NiJyVtVKL8pLzAra/ndZieH5m1vvQq+mdZx8aShXuJ65iuhloPTRSP
         UmMSME5KxJsBw3csLO3NWXjWPZM1EIP66gBXgQDLHbpJGz/Agyt9M/J7OG+ARK/l83/k
         LHOaVUNi7wxliPwstNd3a16Il5na8q8gMT2qoX4KTwyljtoZzPyhpBMYEBi70SRkASPf
         5KDkK7uj9d3smbdMl2Z6dj7e3zmdXAPUC51/vqI1n0daaKGoVDppgdqTMw4kOP+Hd5P2
         DTrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MjEHvnSKKqtqfjPruFAI4NMd2j71wVzmmWx9wAlQuc=;
        b=raVKBy7SbtCOKcEvIYByvrau1oxYA1wa/S7xhhNqb8Ij/9AYlvWxe+rilyUWQzFC5M
         fot6LUgV2nYRTAFvjdSBhra3UUJqFqIeA0cQ/cBntSzv4vMH8EYxBLWMR69vVsNoDJvX
         BdXAUwYqeVNDG+gkQX0QEcJkCotoDmpTTxfSuKERsPZBhJFbd1DZzlz/YHIHvamtizhg
         2KKclCDZQYhfQcKdLsGgbEeB3xu8X59sPSX55Azj3Zysghs01uR8UACoVgBlFI+RLEcM
         Qa54usDcl/V59U8RI03lKcCSDn9Wob1krWF1r/YXVAGSer9CkELw1hX1TTjVs5cZlZ9M
         NDSg==
X-Gm-Message-State: APjAAAWOy+Htv7WrHxaSsaA7F147dqcmJ+SMdG6LKs9cytQ8MF6RPUNK
        lVCYADDHEmdFDa7uZS/zlR+mvQ==
X-Google-Smtp-Source: APXvYqwBe20vok0kApLfxr7HsPa/CVcwxmWsogHcS+yIh3lMtGKys7opBB9vgJdwmvCYVkPNdBaQaA==
X-Received: by 2002:adf:8bd8:: with SMTP id w24mr6435577wra.273.1565887146840;
        Thu, 15 Aug 2019 09:39:06 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:06 -0700 (PDT)
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv6 20/36] x86/vdso: Restrict splitting VVAR VMA
Date:   Thu, 15 Aug 2019 17:38:20 +0100
Message-Id: <20190815163836.2927-21-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Although, time namespace can work with VVAR VMA split, it seems worth
to forbid splitting VVAR resulting in stricter ABI and reducing amount
of corner-cases to consider while working further on VDSO.

I don't think there is any use-case for partial mremap() of vvar,
but if there is any - this patch can be easily reverted.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 349a61d8bf34..3f05418642a8 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -84,6 +84,18 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
+static int vvar_mremap(const struct vm_special_mapping *sm,
+		struct vm_area_struct *new_vma)
+{
+	unsigned long new_size = new_vma->vm_end - new_vma->vm_start;
+	const struct vdso_image *image = new_vma->vm_mm->context.vdso_image;
+
+	if (new_size != -image->sym_vvar_start)
+		return -EINVAL;
+
+	return 0;
+}
+
 static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 		      struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -136,6 +148,7 @@ static const struct vm_special_mapping vdso_mapping = {
 static const struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
+	.mremap = vvar_mremap,
 };
 
 /*
-- 
2.22.0

