Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A3D43028
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbfFLTaK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:30:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37155 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728734AbfFLT0v (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14so18131852wrr.4
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPIuEHDSoxOxKmo/+FURVEIw3vOuo9up5XrlOV13hU0=;
        b=IA6asvF1Rc7iSE5mgDCvQFKnU2Wd9kLTzUgENZgoS4uzBD6kaeAaAKpxF1cKGzO/H3
         0piFvm6hUINvyEhX1kNdfKERtWIyNybl5vWnbu6dmHHNVIfZxhWttDGB9PE8QOtivM37
         L/Fz59o05TpJ+u4DoIdyfHJFaCY9UvGkLVuFnguXhN6p1dK/MG5LK3hiDPdheqS9oF1z
         5hd4ztmsMKxs/8msoaR/MOH5YgB3ZmMZcPs+mdSTxumLpxr5z4bLHy2yMMO5S23SLm/0
         Wvi9gSQbV9qdDhkHYrGZ0s8+cGNTCTZ8M6GL+G9L3C5jkVbsnHU8sziNykKoPHhVBMPX
         eMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPIuEHDSoxOxKmo/+FURVEIw3vOuo9up5XrlOV13hU0=;
        b=Q3EW4AxA9Btwvd7l93ec6sfyEatwfuAB6iP9g42rMOAFAPFyxBiEhGIwJvBfr7d8HR
         a3KLw4BJaq23RfCfM5c3rUf4rT6HsWCkIoWWqtuYU6n9rbv7Z6a4n+jZvgAmyH0F/S+8
         u7kCWM+Od6nq237vHRLOC7riUT2fPCkWz1+7PUZ2vYHcRoqImofcGX6dpUZIVoRimH4I
         GUVtDaFt7uFBYhu70KwQWlzu2yIAkA67geV/xyw9j0VVbhUgen3N0Ig9TTvxrQIywtCZ
         vNbsOs0cUoTRwki5ScS08TwW2WuAncfWJip51LCd5azcFNCK9Ps0xsgNHtDjIdSDDXOI
         EMnA==
X-Gm-Message-State: APjAAAVJkpNihzQA7JbJJJ6cCKMietBu+wNSVMMjOxtbRy46CzDFW61n
        n+5Cpg2zzIcmflb883aIx40HSA==
X-Google-Smtp-Source: APXvYqwL5oKsKpzakG2xNA9f9ZXT2SwooD+CBKorfGAmtVXIgGit+ZgmHDDgcByAr3/ys1emcMpKEg==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr9949406wrx.80.1560367610127;
        Wed, 12 Jun 2019 12:26:50 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:49 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
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
Subject: [PATCHv4 14/28] x86/vdso: Rename vdso_image {.data=>.text}
Date:   Wed, 12 Jun 2019 20:26:13 +0100
Message-Id: <20190612192628.23797-15-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
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
index d2b421233ba5..c30a33b2963b 100644
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

