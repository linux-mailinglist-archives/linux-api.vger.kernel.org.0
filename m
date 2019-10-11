Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6A4D370C
	for <lists+linux-api@lfdr.de>; Fri, 11 Oct 2019 03:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfJKBYN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 10 Oct 2019 21:24:13 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37886 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbfJKBYM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 10 Oct 2019 21:24:12 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so8514486wmc.2
        for <linux-api@vger.kernel.org>; Thu, 10 Oct 2019 18:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYMfxuYafYA15ogjer2QokPPquY/p6/+qp/AHoWSBKg=;
        b=KRF0RDQW8fNf4SrQJ/BJe77i7hG/VBLhOnS1pS7U5xdnRZ127l5a7U8pa8wF/27xTt
         V7m+VhiXUL8VvW3A89FP5ynREeyWGhn6DxVIO6OD7r22+3i7rtkUMNeGEvtZsldBXXQZ
         UURRZDKzaodNRm7GDlSliJ1oJIoBe3p1Yq3z+83N+182BdZuRNFNfx5xgFMFJPOeFeaM
         OrNmIPnWYZH/D9PAVEIfnPTBMAzqvsMs+8aim8fta2yioJMir3A7M2W1y+ZW/m3UZbps
         Vf2g8szA/LZ4BkRxUOqmsQjIQfImg806W2wltGdeO+O6xTsj6YysJ9TzRXfTT84bCnlU
         9q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYMfxuYafYA15ogjer2QokPPquY/p6/+qp/AHoWSBKg=;
        b=hT88TTELsom+xtR1+hgz4VM7Tg6hHKHH3t2zQKXj/Ev9yNBV9VpoV0DhMx59JS8Zx2
         c8/FSo0gZEwJMybTBTTvZqqBCF6xq8nGB01G/p5jz9ovTbvF0XYMPl0G6AB16s/ZSQxR
         Kmafrjyp/oWmhNlSFrfEt0DhXLikyMdc0MR/VVyZTvctYO3s7N5ZI4fhduaLIKrBG04n
         yBiZT3ifYI/YN+SneN8b1tYz+HIRrIFtZscTrIZnFjhi2KLU0xkqNIMruRaoIkkI7aOc
         8fH/bQrzEeZCJ3RtbtLpt+zWPU9HKOJ6U/MPKNHiVg/tGT2nokkGpSl6NZbqL5Bqco6v
         vvZg==
X-Gm-Message-State: APjAAAWFodbA8gGGPHZdIik2NevJKcOg8xGLvXn0F2eLhYduOyy8bmYj
        /OCuLSb7GumYwJVdLb4dK6Ml9Q==
X-Google-Smtp-Source: APXvYqzLSjse8Wf03RVf0lGrZ/pUjmmgECDppkbi+ynK/RnTDv4C5ECtxTzBn4dLKupFArlF53/QGw==
X-Received: by 2002:a1c:f201:: with SMTP id s1mr895956wmc.59.1570757051151;
        Thu, 10 Oct 2019 18:24:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:ea2:c100:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l13sm7699795wmj.25.2019.10.10.18.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 18:24:10 -0700 (PDT)
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
Subject: [PATCHv7 17/33] x86/vdso: Restrict splitting VVAR VMA
Date:   Fri, 11 Oct 2019 02:23:25 +0100
Message-Id: <20191011012341.846266-18-dima@arista.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191011012341.846266-1-dima@arista.com>
References: <20191011012341.846266-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Forbid splitting VVAR resulting in stricter ABI and reducing amount
of corner-cases to consider while working further on VDSO.

As offset from timens to VVAR page is computed compile-time,
the pages in VVAR should stay together and not being partically
mremap()'ed.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f5937742b290..000db8282cc8 100644
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
2.23.0

