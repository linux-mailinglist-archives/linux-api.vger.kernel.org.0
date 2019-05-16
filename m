Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB6202C7
	for <lists+linux-api@lfdr.de>; Thu, 16 May 2019 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfEPJnD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 May 2019 05:43:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36233 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfEPJmm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 May 2019 05:42:42 -0400
Received: by mail-wr1-f67.google.com with SMTP id s17so2626474wru.3
        for <linux-api@vger.kernel.org>; Thu, 16 May 2019 02:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVnbcHKCSN58gborHO3ol7EK02u5KFHxun0EUOWl0vk=;
        b=hQ+0kAJqpqtOCodfZ0FIlBoq66NEuM5P+adyR4kHZ5VNrN3IRTq4CPTG345dlF2qF6
         yd2OQxoD8UDqmNE1wihFSMKS3DuPCSz9meI+1r/p0Z9xyXB3uaYxvzoi/vSlL01nUTNU
         UP6vJYq31mMuOrvhHymO2r6nF+qW+/cDNLFhrK4ziC9UgwKM/jAXm5xkTvEEuKaJ+OD8
         iH5m319Ml6V2Ex4vtUacfa4yaa01l2UCtgOHPMPHeJsj0ZXxL+NWJX5X8qEUFPFfi0lJ
         0WPMDgbf0AuOBWl+k8GKFRtt5/SSvTPORliMA4OQU2kD+qfKKlQMGYXtzUd4Bpt++9kO
         vcKw==
X-Gm-Message-State: APjAAAU+T7duNkZOXFu5kmaX+P641qfIcQwsCpGjrO/it7vWvmqWq+iS
        a7c8R0SRKTJoEIDfl3Ow1LDcEQ==
X-Google-Smtp-Source: APXvYqwl58jVVB/evRftpSSgIkEdQu3pDWBXBnUiYvoeLvTMFHBb+KM6NeJY7cXdaHqSSVbMh3vTNg==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr13708219wru.223.1557999761707;
        Thu, 16 May 2019 02:42:41 -0700 (PDT)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n63sm4614805wmn.38.2019.05.16.02.42.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 02:42:40 -0700 (PDT)
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
Subject: [PATCH RFC 3/5] mm/ksm: introduce ksm_madvise_unmerge() helper
Date:   Thu, 16 May 2019 11:42:32 +0200
Message-Id: <20190516094234.9116-4-oleksandr@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190516094234.9116-1-oleksandr@redhat.com>
References: <20190516094234.9116-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Move MADV_UNMERGEABLE part of ksm_madvise() into a dedicated helper
since it will be further used for unmerging VMAs forcibly.

This does not bring any functional changes.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 include/linux/ksm.h |  2 ++
 mm/ksm.c            | 32 ++++++++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index e824b3141677..a91a7cfc87a1 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -21,6 +21,8 @@ struct mem_cgroup;
 #ifdef CONFIG_KSM
 int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
 		unsigned long *vm_flags);
+int ksm_madvise_unmerge(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, unsigned long *vm_flags);
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags);
 int __ksm_enter(struct mm_struct *mm);
diff --git a/mm/ksm.c b/mm/ksm.c
index 1fdcf2fbd58d..e0357e25e09f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2478,6 +2478,25 @@ int ksm_madvise_merge(struct mm_struct *mm, struct vm_area_struct *vma,
 	return 0;
 }
 
+int ksm_madvise_unmerge(struct vm_area_struct *vma, unsigned long start,
+		unsigned long end, unsigned long *vm_flags)
+{
+	int err;
+
+	if (!(*vm_flags & VM_MERGEABLE))
+		return 0;		/* just ignore the advice */
+
+	if (vma->anon_vma) {
+		err = unmerge_ksm_pages(vma, start, end);
+		if (err)
+			return err;
+	}
+
+	*vm_flags &= ~VM_MERGEABLE;
+
+	return 0;
+}
+
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, unsigned long *vm_flags)
 {
@@ -2492,16 +2511,9 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		break;
 
 	case MADV_UNMERGEABLE:
-		if (!(*vm_flags & VM_MERGEABLE))
-			return 0;		/* just ignore the advice */
-
-		if (vma->anon_vma) {
-			err = unmerge_ksm_pages(vma, start, end);
-			if (err)
-				return err;
-		}
-
-		*vm_flags &= ~VM_MERGEABLE;
+		err = ksm_madvise_unmerge(vma, start, end, vm_flags);
+		if (err)
+			return err;
 		break;
 	}
 
-- 
2.21.0

