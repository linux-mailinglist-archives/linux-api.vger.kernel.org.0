Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C67E301BE7
	for <lists+linux-api@lfdr.de>; Sun, 24 Jan 2021 13:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbhAXMoA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 24 Jan 2021 07:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbhAXMnn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 24 Jan 2021 07:43:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1232C06174A;
        Sun, 24 Jan 2021 04:43:02 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a12so5763473lfb.1;
        Sun, 24 Jan 2021 04:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z7teIBDKIhcgBPY/liVEk9zmA7Nx4bGejJjM0IUv55g=;
        b=fqXxPtXlobtVpi6/B08a8S/K4Z6BblxpfILu/yHUBVC4AsIFULvIIePcVUT2uVLf+x
         fNVo6jgITGjOYIODAuAIsqVV2NHhhIVSNagMfA+8XVRN2kRGLuQFx9iPJs8dQ7te+g69
         uubrHayI6WqzAyvUqR3bARcmWkhocDPUI3kLDAz7Dtn1O365Dx9nHyZu58fdkHcF4ZX8
         JupKLODY+KXwUmyQ4pKfPXdPDItqYmULsC/SWJSQTssohSWlUvWC/hGl/kxjM1aEDlR7
         xCeLVaYcWYCjvSolkcFRm/sEcWkZ98hWEg6UUrA4fEuXtyBWHASycD4zTuZ5mRcgGlyx
         hG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z7teIBDKIhcgBPY/liVEk9zmA7Nx4bGejJjM0IUv55g=;
        b=mzjBC4UDYDgPtpxdMc09uClf5FgNJyg+q+AVSw6cq1M0K9NPRscTt8avSfXd1UWrhp
         5uK9ZIjq4bgCXx70LZcn9dj5cjmdTbTJq9EYrN3sQs3yfYho2NDBm9mS6GU9izLlUFH2
         LYiwJMzY1UXZ/9IOPBi0HP5oGH32symhCwtLgYoUgo94wWk6rUg7HvMPwI3eH6JuyWbn
         xHWSUyS0ByCV4BCQdJisd0mjB5V+5IZOvcl77kynFvbCHUR9Y2OkziaDn8qZ15Z9fgf2
         Ipnt6U5hjo/HR8SWTdjVA393q5hhOFV1QygHYrElZgCQQpeXxL4MDvzjV2ISI5PpGzAL
         S0fg==
X-Gm-Message-State: AOAM531PzxC6nuiwhDfDX4+sVo5I/2vD0tUStJdOSuR+1tx43Am39+Is
        RIlWxIidAu6O+Q1Uujtp9he5ftxNwTE=
X-Google-Smtp-Source: ABdhPJyVor3VzWEfUE5wNYmJza3j7FdVBDUmVSsCrbF/z37ekHoGf7jotbezEuPkR091xfdN4rAKIQ==
X-Received: by 2002:a19:5510:: with SMTP id n16mr37649lfe.543.1611492181102;
        Sun, 24 Jan 2021 04:43:01 -0800 (PST)
Received: from localhost.localdomain (88-114-221-222.elisa-laajakaista.fi. [88.114.221.222])
        by smtp.gmail.com with ESMTPSA id o14sm928250lfi.257.2021.01.24.04.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 04:43:00 -0800 (PST)
From:   Topi Miettinen <toiwoton@gmail.com>
To:     linux-hardening@vger.kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Topi Miettinen <toiwoton@gmail.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: [PATCH v10 2/2] mm/mremap: optionally randomize mremap(..., MREMAP_MAYMOVE)
Date:   Sun, 24 Jan 2021 14:42:46 +0200
Message-Id: <20210124124246.19566-2-toiwoton@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210124124246.19566-1-toiwoton@gmail.com>
References: <20210124124246.19566-1-toiwoton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

New sysctl kernel.randomize_mremap, when set, can be used to force
mremap(..., MREMAP_MAYMOVE) to always move the mappings even if not
necessary. In addition to improved address space layout randomization,
this can expose bugs where the caller is not actually expecting a
moved mapping, even though this may sometimes happen without this
flag.

Example:
$ cat mremap.c
 #define _GNU_SOURCE
 #include <stddef.h>
 #include <sys/mman.h>

int main(void) {
        void *addr = mmap(NULL, 4096, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
        addr = mremap(addr, 4096, 8192, MREMAP_MAYMOVE);
        mremap(addr, 4096, 4096, MREMAP_MAYMOVE);
        return 0;
}
$ gcc -o mremap mremap.c
$ strace -e mmap,mremap ./mremap
mmap(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x68a16298d000
mremap(0x68a16298d000, 4096, 8192, MREMAP_MAYMOVE) = 0x68a16298d000
mremap(0x68a16298d000, 4096, 4096, MREMAP_MAYMOVE) = 0x68a16298d000

Setting the sysctl enables randomization:
$ sudo sysctl kernel.randomize_mremap=1
$ strace -e mmap,mremap ./mremap
mmap(NULL, 4096, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x6366429cf000
mremap(0x6366429cf000, 4096, 8192, MREMAP_MAYMOVE) = 0x70aa47ad0000
mremap(0x70aa47ad0000, 4096, 4096, MREMAP_MAYMOVE) = 0x5b37dc166000

CC: Andrew Morton <akpm@linux-foundation.org>
CC: Jann Horn <jannh@google.com>
CC: Kees Cook <keescook@chromium.org>
CC: Matthew Wilcox <willy@infradead.org>
CC: Mike Rapoport <rppt@kernel.org>
CC: Linux API <linux-api@vger.kernel.org>
Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
---
 Documentation/admin-guide/sysctl/kernel.rst |  9 +++++++
 include/linux/mm.h                          |  2 ++
 kernel/sysctl.c                             |  7 ++++++
 mm/mremap.c                                 | 26 +++++++++++++++++++--
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index c13f865c806c..eeca8c8f96d0 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1029,6 +1029,15 @@ defined, these additional entries are present:
   number of cycles between interrupts used to feed the pool.
 
 
+randomize_mremap
+==================
+
+This option, when set, can be used to force mremap(...,
+MREMAP_MAYMOVE) to always move the mappings even if not necessary.
+In addition to improved address space layout randomization, this can
+expose bugs where the caller is not actually expecting a moved
+mapping, even though this may sometimes happen without this flag.
+
 randomize_va_space
 ==================
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b4915412abbe..98aa466c2901 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2990,6 +2990,8 @@ void drop_slab_node(int nid);
 extern int randomize_va_space;
 #endif
 
+extern int randomize_mremap;
+
 const char * arch_vma_name(struct vm_area_struct *vma);
 #ifdef CONFIG_MMU
 void print_vma_addr(char *prefix, unsigned long rip);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085960b8..02bd9ba89f27 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2429,6 +2429,13 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "randomize_mremap",
+		.data		= &randomize_mremap,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
 #endif
 #if defined(CONFIG_S390) && defined(CONFIG_SMP)
 	{
diff --git a/mm/mremap.c b/mm/mremap.c
index 138abbae4f75..386da905f39f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -648,6 +648,14 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	return 1;
 }
 
+/*
+ * Force mremap(..., MREMAP_MAYMOVE) to always move the mappings even
+ * if not necessary. This can expose bugs where the caller is not
+ * actually expecting a moved mapping, even though this may sometimes
+ * happen without this flag.
+ */
+int randomize_mremap __read_mostly = 0;
+
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -665,6 +673,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	unsigned long charged = 0;
 	bool locked = false;
 	bool downgraded = false;
+	bool randomize = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
 	LIST_HEAD(uf_unmap_early);
 	LIST_HEAD(uf_unmap);
@@ -720,6 +729,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	randomize = (flags & MREMAP_MAYMOVE) && randomize_mremap;
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
@@ -730,7 +740,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		int retval;
 
 		retval = __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
+				     &uf_unmap, !randomize);
 		if (retval < 0 && old_len != new_len) {
 			ret = retval;
 			goto out;
@@ -738,6 +748,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		} else if (retval == 1)
 			downgraded = true;
 		ret = addr;
+
+		/*
+		 * Caller is happy with a new address, so let's move
+		 * even if not necessary
+		 */
+		if (randomize)
+			ret = mremap_to(addr, new_len, 0, new_len,
+					&locked, flags, &uf, &uf_unmap_early,
+					&uf_unmap);
+
 		goto out;
 	}
 
@@ -751,8 +771,10 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	}
 
 	/* old_len exactly to the end of the area..
+	 * But when randomizing, don't just expand the mapping if
+	 * caller is happy with a moved and resized mapping
 	 */
-	if (old_len == vma->vm_end - addr) {
+	if (old_len == vma->vm_end - addr && !randomize) {
 		/* can we just expand the current mapping? */
 		if (vma_expandable(vma, new_len - old_len)) {
 			int pages = (new_len - old_len) >> PAGE_SHIFT;
-- 
2.29.2

