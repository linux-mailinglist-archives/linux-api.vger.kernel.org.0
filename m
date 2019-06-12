Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4ED4300E
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbfFLT2M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:28:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36703 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfFLT0u (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so18179686wrs.3
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4nDl/CUmCqqh37N3cXS8r+aNsaHvCoXX3q5gpIkIcXw=;
        b=cP3ve+V2cqLDHqdmmZWEIRkLThECV8dV9CpQoJNIPFK0OOyl/ECobu8g3pVyvDlF/5
         N75tP0MJFDZSkg+g0Shq9KGffobsEPGgPJk11TBMBvqgLSYNqFDaW4asBO2bzEQqYn4Q
         aboNx7HWRw1FAXssQZ2KToQglqdWfu/Zy6LJqzbTQVUn5GBTfKW5q4ZoOo+KfSj2fgDm
         FehmyhHpObVdhb7DKtYfbdJ8BtyNp9ccDg6GkgIbxSd7su5z0qXpRHf/rTftjbH+mNaO
         XLQ+vggFv8tm6QMbsuOqCXaCX85efXP2r8VMLnArHWepTMd7UJhqN4A+oNNaGUMSQgQr
         4tAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4nDl/CUmCqqh37N3cXS8r+aNsaHvCoXX3q5gpIkIcXw=;
        b=TPUMFyAxDQcNZxh9hELqJtercCCJPlCemySMiJguUGilQZ2Cw7mlJ4QiwRBTIDh9gc
         eEkPS6+mTysB3iBGHwRcUwPscHfQvhznFm8+yPOXqLE3WwtitvvO6nmiRF6lZec6kCer
         gOrzg8OZBXmi9tQvrOZN+7sphGwRZec0SW0vI70sRXdJV12Qm9PUUjR8qqUXO50uX8Dt
         gxRPgpE5nVchuVtH/JaDMmds5QR5/ag8rzfTI5z80Gps3Ay+JcQqW1PQ0dd+B6e6/Frz
         AujYiZqVjCpLCVJ8cLXMQhuE6Ul/waIPOAlgOYawsQK3EioyDfHlZOb6K1DB5DVMo146
         pETg==
X-Gm-Message-State: APjAAAVNXC6T8dIZF/G8xKdR+GVyciobOI4Ib4vuD7KrZ/SK4jNy7x7y
        ZWjJG5TDcz272XByrZyfeYIUrg==
X-Google-Smtp-Source: APXvYqzvFvZKw4czh3fj4IC0HCIsTNt0UN8B6+q4hgTO1PoZvnQtXhK6OsfwFtRQLTAdWfRhowlMWg==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr19501473wru.264.1560367608606;
        Wed, 12 Jun 2019 12:26:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:48 -0700 (PDT)
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
Subject: [PATCHv4 13/28] x86/vdso: Restrict splitting VVAR VMA
Date:   Wed, 12 Jun 2019 20:26:12 +0100
Message-Id: <20190612192628.23797-14-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
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
index 8db1f594e8b1..d2b421233ba5 100644
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

