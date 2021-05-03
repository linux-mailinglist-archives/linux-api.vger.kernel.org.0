Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E0371F36
	for <lists+linux-api@lfdr.de>; Mon,  3 May 2021 20:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbhECSIt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 May 2021 14:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbhECSIn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 May 2021 14:08:43 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2A7C06138B
        for <linux-api@vger.kernel.org>; Mon,  3 May 2021 11:07:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id f20-20020a0caa940000b02901c5058e5813so4883300qvb.23
        for <linux-api@vger.kernel.org>; Mon, 03 May 2021 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B2Y1PjHbI7aJoqQQgo4Vnp4m6n0XR/I22GG3IBxep44=;
        b=gTsFZvf1qsTwVhu74lp9LkD4evRddnT0OUCq2nktgrb7Qeqfhtqry+E72YR++T84jj
         FXO/yrAwTZLbPQiAAwfvf+aY5r3B+UVXp4W+z4eCVdecIu2KlkEWmJ+eEDTsnajop9KT
         hod3LhJUwoDlsuDkjH6nvfEyBxo2prHq/2niF4ikBsp1fVCf7ubjwJI2Sbd/I7z+CzoO
         08wNutl5oqSAMliZ/wvffe/EPSYnMJoN93ATlRsVdEBqx0kc4GxVW4CfIU1H4OANm343
         BG/ERYek+C20/S9UsylvbaAOgQSKEWJUxx/0wKow/xe2GzjB7U3gDEfnlKV66ErHLrQc
         8/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B2Y1PjHbI7aJoqQQgo4Vnp4m6n0XR/I22GG3IBxep44=;
        b=L29DTJU2NuZj1gkijZq0bgi4Ca1JcOhhrkSmz4d38U8HyPovmW1ShG8GjqIVMrXi+i
         6QdMbIZ/ytGywERifVIpobNLVV3RTmcCpIHp2Y7iTvvP/fYEawykL3JE5WP79TSyaA2x
         Cp2NLzf+eAC6ohpZJpwIkukctBUX7QuvmIEaDVfVMYFfopSiKrem/ULAUPbk5aATgmZF
         Ws97QX67OIJAnqGO6VDdIefxi/nJDH5i5voDF0xVfpME+hoGHHsU62g3UWlmiXIKq2a+
         SlL+2Xt+OzBDC/pL2NaCL6QNi0tvJ6rywo0jj6S9OE4n+71MCl/JH/QWnZKAXgcBIX4p
         zwng==
X-Gm-Message-State: AOAM531lhapBMP+kEUWJWVzu+5h4XgyaMpPCbkECNkDS4tTdpLtTsf4l
        BvsQ9ufFmHZZaG6pyEuYZ48TzvvPeTwDgDTvbQ7E
X-Google-Smtp-Source: ABdhPJxnNCpEjYHIgZNcvbAUN1MjTKtSfxHgbzP+NuN4wp02yOZHfaGQB6Fjg9bx44bW+nF3M5O2miOL9kS1DE+zUYFi
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:c446:: with SMTP id
 t6mr11124075qvi.3.1620065268499; Mon, 03 May 2021 11:07:48 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:30 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 03/10] userfaultfd/shmem: support minor fault registration
 for shmem
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

This patch allows shmem-backed VMAs to be registered for minor faults.
Minor faults are appropriately relayed to userspace in the fault path,
for VMAs with the relevant flag.

This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
minor faults, though, so userspace doesn't yet have a way to resolve
such faults.

Because of this, we also don't yet advertise this as a supported
feature. That will be done in a separate commit when the feature is
fully implemented.

Acked-by: Peter Xu <peterx@redhat.com>
Acked-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 fs/userfaultfd.c |  3 +--
 mm/memory.c      |  8 +++++---
 mm/shmem.c       | 12 +++++++++++-
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 14f92285d04f..468556fb04a9 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1267,8 +1267,7 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
 	}
 
 	if (vm_flags & VM_UFFD_MINOR) {
-		/* FIXME: Add minor fault interception for shmem. */
-		if (!is_vm_hugetlb_page(vma))
+		if (!(is_vm_hugetlb_page(vma) || vma_is_shmem(vma)))
 			return false;
 	}
 
diff --git a/mm/memory.c b/mm/memory.c
index 86ba6c1f6821..9a536cfde7c8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3972,9 +3972,11 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * something).
 	 */
 	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		ret = do_fault_around(vmf);
-		if (ret)
-			return ret;
+		if (likely(!userfaultfd_minor(vmf->vma))) {
+			ret = do_fault_around(vmf);
+			if (ret)
+				return ret;
+		}
 	}
 
 	ret = __do_fault(vmf);
diff --git a/mm/shmem.c b/mm/shmem.c
index 04de845b50b3..e361f1d81c8d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1785,7 +1785,7 @@ static int shmem_swapin_page(struct inode *inode, pgoff_t index,
  * vm. If we swap it in we mark it dirty since we also free the swap
  * entry since a page cannot live in both the swap and page cache.
  *
- * vmf and fault_type are only supplied by shmem_fault:
+ * vma, vmf, and fault_type are only supplied by shmem_fault:
  * otherwise they are NULL.
  */
 static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
@@ -1820,6 +1820,16 @@ static int shmem_getpage_gfp(struct inode *inode, pgoff_t index,
 
 	page = pagecache_get_page(mapping, index,
 					FGP_ENTRY | FGP_HEAD | FGP_LOCK, 0);
+
+	if (page && vma && userfaultfd_minor(vma)) {
+		if (!xa_is_value(page)) {
+			unlock_page(page);
+			put_page(page);
+		}
+		*fault_type = handle_userfault(vmf, VM_UFFD_MINOR);
+		return 0;
+	}
+
 	if (xa_is_value(page)) {
 		error = shmem_swapin_page(inode, index, &page,
 					  sgp, gfp, vma, fault_type);
-- 
2.31.1.527.g47e6f16901-goog

