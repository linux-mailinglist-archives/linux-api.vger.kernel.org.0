Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E127196ABF
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 05:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgC2DKx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Mar 2020 23:10:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33630 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgC2DKw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Mar 2020 23:10:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id x200so3915813lff.0
        for <linux-api@vger.kernel.org>; Sat, 28 Mar 2020 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CAYqJ2L9pgxOOLuY6Zx/KWHLN9INKRlM0+JHPK6lpa0=;
        b=bYHQmUhxUUGWWSF7gp3BLGZ3wd/pBbLbCUm5xAwnOJyOP7ZmGtrFIEGQr2SdI3EnOS
         6huRoHeh/Gy9dQIdV3ov1h6Ue67QqzGjYZipvuCYoy7DQiBQOl9rnIVnMKtonGmBRj82
         sH8ExNnAuxLmkgwjPoHA4Wl5Qw2zovnIfTCPeRabf1Nf3XybBEd5hoKXUulHiy/kaUD4
         AmBm3SU36ueipT5w+SVZ8+31RL10t/fP1livOEr4/TPU62iy3DNrVrB2zkx1hW0FwYlc
         aDI2gALJNFE0xxRehC9GjEEuA+bfgtB4APLTr0j2J/vYOAWL3cbRY+KlNDPY6MwYa30Y
         Jicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CAYqJ2L9pgxOOLuY6Zx/KWHLN9INKRlM0+JHPK6lpa0=;
        b=Zhb0cf5Fla2bL3FEQkvervld2g5x9QWCwA3gmagKW0N4AEDuonabCOrLUjrBaHMW1c
         0N62h7BzWo05mTAJVXu5A4IGgi6X6oFbfPsZ7Q+1UYK/hcQbeJhqlpP3N9gaWmm5i+0M
         xesUeyVYOhRBXQXiOkgj5MF6Sd6CQfI5dTeYNjIjAJ5Wr8zItKALNly/G+05rLij94C5
         OUloJ2cElb5abhA7yVQLO1YPezCEGXTsVO4bGMlDtY9VFlbNp5DCv/uaoNbv0QO0tx0y
         zxf0EqbzjZporxIbFD5ElQkyj5HixlOmOuLR5x+jwt205aRJmSKkkb4JaHk/nl7YX8bu
         zrzA==
X-Gm-Message-State: AGi0Pua4Bj0QgKRag2u6nnIEdaMN6Se3FDF1m/E4ZIz1avlAH7uH8al3
        HoojK/PkWv7Y/uWuqp8SFyU=
X-Google-Smtp-Source: APiQypIE2W6sxu6iZ7if6zeX6twP3WphJkiTDF92AmZDpwK72QPDIK7/56s5kyhUp9RtTj2JTXUqGQ==
X-Received: by 2002:a05:6512:46a:: with SMTP id x10mr4148242lfd.193.1585451449996;
        Sat, 28 Mar 2020 20:10:49 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([131.228.2.21])
        by smtp.gmail.com with ESMTPSA id z9sm5911154lfh.45.2020.03.28.20.10.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Mar 2020 20:10:49 -0700 (PDT)
From:   Li Xinhai <lixinhai.lxh@gmail.com>
To:     linux-mm@kvack.org
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] mm: allow checking length for hugetlb mapping in mmap()
Date:   Sun, 29 Mar 2020 03:08:15 +0000
Message-Id: <1585451295-22302-1-git-send-email-lixinhai.lxh@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

In current code, the vma related call of hugetlb mapping, except mmap,
are all consider not correctly aligned length as invalid parameter,
including mprotect,munmap, mlock, etc., by checking through
hugetlb_vm_op_split. So, user will see failure, after successfully call
mmap, although using same length parameter to other mapping syscall.

It is desirable for all hugetlb mapping calls have consistent behavior,
without mmap as exception(which round up length to align underlying
hugepage size). In current Documentation/admin-guide/mm/hugetlbpage.rst,
the description is:
"
Syscalls that operate on memory backed by hugetlb pages only have their
lengths aligned to the native page size of the processor; they will
normally fail with errno set to EINVAL or exclude hugetlb pages that
extend beyond the length if not hugepage aligned. For example, munmap(2)
will fail if memory is backed by a hugetlb page and the length is smaller
than the hugepage size.
"
which express the consistent behavior.

Signed-off-by: Li Xinhai <lixinhai.lxh@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
changes:
0. patch which introduce new flag for mmap()
   The new flag should be avoided.
   https://lore.kernel.org/linux-mm/1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com/

 mm/mmap.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d681a20..b2aa102 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1560,20 +1560,12 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
 		file = fget(fd);
 		if (!file)
 			return -EBADF;
-		if (is_file_hugepages(file))
-			len = ALIGN(len, huge_page_size(hstate_file(file)));
 		retval = -EINVAL;
 		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
 			goto out_fput;
 	} else if (flags & MAP_HUGETLB) {
 		struct user_struct *user = NULL;
-		struct hstate *hs;
 
-		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
-		if (!hs)
-			return -EINVAL;
-
-		len = ALIGN(len, huge_page_size(hs));
 		/*
 		 * VM_NORESERVE is used because the reservations will be
 		 * taken when vm_ops->mmap() is called
-- 
1.8.3.1

