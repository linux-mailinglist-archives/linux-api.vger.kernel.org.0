Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 041DC202BE
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 11:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfEPJmm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 05:42:42 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35200 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfEPJml (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 05:42:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so2436474wrv.2
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 02:42:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YN77z8gKHSuM2XjFecvZy0A0ECsUV7zC1Q0pr8QKOlY=;
        b=Ieo+PbAxms/aLtzllpfsySkvA4GtzgcPB3RFNaMritFVkAKy5dYjD+yrgHz+ypXZ58
         T42xTTDg0mBI35fwKiTN0YF5EAO5z9QAE60Yy1cM6+q9vZV1o+0b3jKjqVgk5JLdm6pe
         uRqpkaet4NZS5KSmV3cylu5pv9rS2kaz13rBoUiBduwBeh1kPIb3wnvkeQ/gXlMxSXLJ
         Ee8f+2QP+WJovZ8JIzK6koLS5bpXP7mStN+8/VyfkZwgs6cRsGdOTZA86TgmxZwy0Cbz
         584P1rAgN/57ML1hh61FiC91lQ1lEtYxcwNOnetSvT0dnZQ8RGPhgrwGsn6ufxUfw9ol
         BTUA==
X-Gm-Message-State: APjAAAWp1m1ZpqG1j0Cyb/L+LDI0ofq+ekP0gTX4uNVu/RACouX0ocgx
        1HoAgTCsxM+oUTq+D+GcPhWzUg==
X-Google-Smtp-Source: APXvYqys469LpVWfYxPlfxZW3I0nW/iuorQWcrS5tP7pLu+XZ/hJioroCE9kOeMmFNuO1N+8Ds8oZA==
X-Received: by 2002:adf:f9c3:: with SMTP id w3mr20196436wrr.271.1557999759998;
        Thu, 16 May 2019 02:42:39 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s3sm7204729wre.97.2019.05.16.02.42.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:39 -0700 (PDT)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Hugh Dickins <hughd@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Greg KH <greg@kroah.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Timofey Titovets <nefelim4ag@gmail.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Grzegorz Halat <ghalat@redhat.com>, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: [PATCH RFC 2/5] mm/ksm: introduce ksm_madvise_merge() helper
Date:   Thu, 16 May 2019 11:42:31 +0200
Message-Id: <20190516094234.9116-3-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Move MADV_MERGEABLE part of ksm_madvise() into a dedicated helper since
it will be further used for marking VMAs to be merged forcibly.

This does not bring any functional changes.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 include/linux/ksm.h |  2 ++
 mm/ksm.c            | 60 +++++++++++++++++++++++++++------------------
 2 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index e48b1e453ff5..e824b3141677 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -19,6 +19,8 @@ struct stable_node;
 struct mem_cgroup;
 
 #ifdef CONFIG_KSM
+int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *vm_flags);
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
diff --git a/mm/ksm.c b/mm/ksm.c
index fc64874dc6f4..1fdcf2fbd58d 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2442,41 +2442,53 @@ static int ksm_scan_thread(void *nothing)
 	return 0;
 }
 
-int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
-		unsigned long end, int advice, unsigned long *vm_flags)
+int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
+		unsigned long *vm_flags)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	int err;
 
-	switch (advice) {
-	case MADV_MERGEABLE:
-		/*
-		 * Be somewhat over-protective for now!
-		 */
-		if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
-				 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
-				 VM_HUGETLB | VM_MIXEDMAP))
-			return 0;		/* just ignore the advice */
+	/*
+	 * Be somewhat over-protective for now!
+	 */
+	if (*vm_flags & (VM_MERGEABLE | VM_SHARED  | VM_MAYSHARE   |
+			 VM_PFNMAP    | VM_IO      | VM_DONTEXPAND |
+			 VM_HUGETLB | VM_MIXEDMAP))
+		return 0;		/* just ignore the advice */
 
-		if (vma_is_dax(vma))
-			return 0;
+	if (vma_is_dax(vma))
+		return 0;
 
 #ifdef VM_SAO
-		if (*vm_flags & VM_SAO)
-			return 0;
+	if (*vm_flags & VM_SAO)
+		return 0;
 #endif
 #ifdef VM_SPARC_ADI
-		if (*vm_flags & VM_SPARC_ADI)
-			return 0;
+	if (*vm_flags & VM_SPARC_ADI)
+		return 0;
 #endif
 
-		if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
-			err = __ksm_enter(mm);
-			if (err)
-				return err;
-		}
+	if (!test_bit(MMF_VM_MERGEABLE, &mm->flags)) {
+		err = __ksm_enter(mm);
+		if (err)
+			return err;
+	}
+
+	*vm_flags |= VM_MERGEABLE;
+
+	return 0;
+}
 
-		*vm_flags |= VM_MERGEABLE;
+int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, int advice, unsigned long *vm_flags)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	int err;
+
+	switch (advice) {
+	case MADV_MERGEABLE:
+		err = ksm_madvise_merge(mm, vma, vm_flags);
+		if (err)
+			return err;
 		break;
 
 	case MADV_UNMERGEABLE:
-- 
2.21.0

