Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E478A79C0D
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfG2WBM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:01:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38336 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbfG2V6d (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so63468206wrr.5
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LDD6ysbcq8/fi6dGyfg9N1McraInCy0n2bZF6snhbRo=;
        b=EpBU7HALHo/0prm0kDfzdl0bU0rQpQKOoyZSoBM+J7OmIVjRHfpVuWLNkzhcPowZY+
         k9d0CDSiCtfqacVU4TgScSmWmtVEfImaFyxBJe1kGWqjjn0ZMnIztBuGUR2bL/av9yT4
         Ik05GnFG1prEjOT5QsovvkETKtADtnWl8K3/apL2r6D5amay3q56MR+MlvR3yxKlSlir
         lakli4HgTueUyKJrcQBajw/nZPKH8FmWMM4aokg33I1UEth+FtROkn1PGcb2LHewvUw5
         YmhIpDYd1jeqqzf/P0TBwIOP00WLWNwVCq9sFiMsuLnPcVN57rz8xwSh3o3A8UrbxmYa
         MesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LDD6ysbcq8/fi6dGyfg9N1McraInCy0n2bZF6snhbRo=;
        b=eCf/yO0MIzRjUl/GXZlEtffGZZ1qyUV6L+fBxs7NP/8e495q49T8DfxhfU4c/w7VGe
         siJS+7W1oqn4rPBviLOsLd5MLi/zi+7Ot46INs/KJaSJnrF3TKkG6+xH/YHc/48IooMb
         P5ZzZIMe0j/k/9gcjptP7O4PkQM7zJJ0lFjZlMdgigl14ulGz7u//aQ4NcGD1ifvxwA5
         hB4Lo6uRsBHxOGTwRrl+JMt5XTdNBtD+JRGwSbBZYkhT8jV5AV2gAR+Tqwn7cjv369j8
         tWqlQMY30dGVFXI86aCThqzphfDeUPS3YGtAMat1q1gD4UrLZdVnCB2H1hG+NdwHiFBX
         kdzA==
X-Gm-Message-State: APjAAAWojKdq9z+7oFnWzZ20O8Sqzl+th1VmVediw8D70El9DRc1UFJA
        AZfQp3lcbotao6km3T5Ywn1XJurH6kGvbhXU3tk2NnUuSHy+1eKeqMFJr3MfcEHjbJ1/pwWJJ9w
        GHkKciIGQCv1HO8blQOdV4lvnpmO1ufvFY1xAmca2N2JsvDkbzLJyDf0hQwR/u7pz0H/5IjD7xG
        ZsYvWLfCYsI5Zg0aF1YTtiNHzRwg==
X-Google-Smtp-Source: APXvYqxoEWpgwKDwrBGamkwnMV/z+4IT1Oqc7hGPBGvJ46pfHt3zj7agrcSjojOAIKIzkyrrQX2M4w==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr19655699wrl.281.1564437510818;
        Mon, 29 Jul 2019 14:58:30 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:30 -0700 (PDT)
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
Subject: [PATCHv5 22/37] x86/vdso: Rename vdso_image {.data=>.text}
Date:   Mon, 29 Jul 2019 22:57:04 +0100
Message-Id: <20190729215758.28405-23-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
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

