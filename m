Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C978F0F4
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbfHOQjL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43290 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732443AbfHOQjJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so2741055wrn.10
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDD6ysbcq8/fi6dGyfg9N1McraInCy0n2bZF6snhbRo=;
        b=b4qBCjuTQdhVT0a0DmGBDt27OIcVE/oifHPx8Xk2ziMixcZTCNurZMkB9t7p6ykFMo
         cJoRdjNKK3NerjMF6YNTgxQXPO5lwrT6E+zIBjXnxsMGJiRbiwov3m35vt5TCmlwODsS
         S7WOCJ75wVaTHiAGrQHQpbe475zAQ1bQzlC8/2rE3OLLUzNvVqaJstgGu/lWFOzSJTTL
         pbhnWdgDVm7rfw9leeSIDakdIFUYdpezD8CPifJ9pSF6ltpAEb6bLC3/UZPwWcQWTP3m
         nKpowXB9iObJ6wmavFsae0yVN0IJgILdn90r7D9XrpA1w1D1PX9//0GRx1tyP5mLbTYz
         IjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDD6ysbcq8/fi6dGyfg9N1McraInCy0n2bZF6snhbRo=;
        b=lYXmWQbV4TbprH/7y7EpTHOgHvtgvay5XhtmMXLeIToLMdQ+oHaCmGcdW9cO3uMFPf
         Sq+l5Pi7Na0LsJVsGtjRhqel2qtvDV6yAePzGMKmrbV5/maRj1YffbGm+/LjZdeuZbcI
         7K1skoGKSourlhUuu/LnAFwlbiEXCivHj7qPGzYWM30IoiEFqx4DfRA3PYPp77W9z2nO
         MuthjR/BqjnfY4QpHSEcOkeZv/t7L2kwSsTnagkb0C11Oi9BXez3D3nhU5ODnBjU3eEU
         y9moT++3sOhNF1byOOXzs5nyrx4xLYxdhb+mI/9F6IJ/a2WzcyOAd97KRtEKdG0r/0I1
         E/0A==
X-Gm-Message-State: APjAAAVu4Z3yVYPzcZE3JB+2QBqg8HV+m7Bx+1919FPXSGJ1yK5G5Vy7
        YzCPwzUjWWUImNBBOu+G7rOs6Q==
X-Google-Smtp-Source: APXvYqwF6j5VaRNoIPJFWV8Tckhi+PRI/dVzMoI+OPEinPS+a5V1GrKb0SAQztAOJ/JdBaxD6XREkw==
X-Received: by 2002:adf:e790:: with SMTP id n16mr6224693wrm.120.1565887148204;
        Thu, 15 Aug 2019 09:39:08 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:07 -0700 (PDT)
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
Subject: [PATCHv6 21/36] x86/vdso: Rename vdso_image {.data=>.text}
Date:   Thu, 15 Aug 2019 17:38:21 +0100
Message-Id: <20190815163836.2927-22-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

To avoid any confusion with VVAR.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 2 +-
 arch/x86/entry/vdso/vma.c    | 6 +++---
 arch/x86/include/asm/vdso.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 80be339ee93e..7556bb70ed8b 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -158,7 +158,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile, "\n};\n\n");
 
 	fprintf(outfile, "const struct vdso_image %s = {\n", image_name);
-	fprintf(outfile, "\t.data = raw_data,\n");
+	fprintf(outfile, "\t.text = raw_data,\n");
 	fprintf(outfile, "\t.size = %lu,\n", mapping_size);
 	if (alt_sec) {
 		fprintf(outfile, "\t.alt = %lu,\n",
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 3f05418642a8..2dc4f0b5481c 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -32,8 +32,8 @@ void __init init_vdso_image(const struct vdso_image *image)
 {
 	BUG_ON(image->size % PAGE_SIZE != 0);
 
-	apply_alternatives((struct alt_instr *)(image->data + image->alt),
-			   (struct alt_instr *)(image->data + image->alt +
+	apply_alternatives((struct alt_instr *)(image->text + image->alt),
+			   (struct alt_instr *)(image->text + image->alt +
 						image->alt_len));
 }
 
@@ -47,7 +47,7 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 	if (!image || (vmf->pgoff << PAGE_SHIFT) >= image->size)
 		return VM_FAULT_SIGBUS;
 
-	vmf->page = virt_to_page(image->data + (vmf->pgoff << PAGE_SHIFT));
+	vmf->page = virt_to_page(image->text + (vmf->pgoff << PAGE_SHIFT));
 	get_page(vmf->page);
 	return 0;
 }
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 230474e2ddb5..dffdc12cc7d6 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -11,7 +11,7 @@
 #include <linux/mm_types.h>
 
 struct vdso_image {
-	void *data;
+	void *text;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
-- 
2.22.0

