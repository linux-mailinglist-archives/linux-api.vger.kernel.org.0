Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589B079BBB
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfG2V6d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54243 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfG2V6b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so55203233wmj.3
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3MjEHvnSKKqtqfjPruFAI4NMd2j71wVzmmWx9wAlQuc=;
        b=K3YZLTWnOhf9uJPUr1iQ87BSk5m9pfk0LQyZSfVvG/3zHnum6jcfJs/niIFFRVn7Wk
         ZyiuRJE0z3pZSrJZnl3vJoU7znYGhcJZU016YnXI5L8d9FBV5wqmKUDLVJGnNlshvmU6
         ln5pxw4cUpvOEp2RAoz2B85ngRKuO/0iRLtUsRDz9uUnjdciIXp7L9Fchfdu2ip6BT5H
         Gt0iObe/GQoNpJjwmZBroAmMmOcGibN5hPgsQkiqsbGb0x71aexNdlve45nROsPPgSla
         TSDYviucQQHMJ+z+AvlR1at+BZFIausmWWI55UK9BTk8jaJmJiW40eFE/R9gldOycy2s
         qJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3MjEHvnSKKqtqfjPruFAI4NMd2j71wVzmmWx9wAlQuc=;
        b=I5/xtELNijfItESIJuDYAew18Zu6N7G/KksLTqWVN1U5eN4tN67TukruWbOxGZlyjY
         K4mXosAWugWY2ySUCa6Hd9w1q26pKV+8k8+sFY+DYqheqX2y9DojlrPp9OBgzd4xiTkV
         vEhsLqajwXcQReW9c5RpU26dOcBJUHYa3SJbji7D1YgegJdX5rie9RZD0CXk6NC49s+A
         jgA9OCScHVtH6LCKEt4yRDFGWsRKwokrR3ZkQTyOSdkED2/DoqoLpBgncW08o8ILTaQN
         2dVm6FePtukcyNi/692RlSLb6zuPXDa57m64a7mAlCZc8zzxJeZTK/3RS2bfUrVrD5rM
         x05g==
X-Gm-Message-State: APjAAAWTzkIYTuCCArVPofajv6IUOJj8xfk/BiNWJpowdqTDwLIJfUWN
        zdv8+o7WORrn/IUmOmQq2e3DrpBh0tzadnzIa3p0vgvy3p03kv8irfIRC8PeVriQufx+p5VY0sP
        PTCdx4EUjjouOrky/RUdkE4grtYGhjePLYtv1I+l+1SqXVRBlMr9Gloa1Np08rox9L6iPvYVvm5
        T17EtGUnTfiHbr9EW29Xwk8DNMKw==
X-Google-Smtp-Source: APXvYqy+v04cNfd4RJctLqUo6ZeyXSD8ECZHh591uGR9Ntn/QZseT7nfkt1SZHQmdPRXi4AKP1fgPg==
X-Received: by 2002:a1c:6555:: with SMTP id z82mr103936726wmb.129.1564437509377;
        Mon, 29 Jul 2019 14:58:29 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:28 -0700 (PDT)
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
Subject: [PATCHv5 21/37] x86/vdso: Restrict splitting VVAR VMA
Date:   Mon, 29 Jul 2019 22:57:03 +0100
Message-Id: <20190729215758.28405-22-dima@arista.com>
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

