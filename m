Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0170836CEF2
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 00:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhD0Wyt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Apr 2021 18:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236936AbhD0Wxr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Apr 2021 18:53:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48BDC061346
        for <linux-api@vger.kernel.org>; Tue, 27 Apr 2021 15:53:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y5-20020a2586050000b02904ee36d3b170so2853846ybk.10
        for <linux-api@vger.kernel.org>; Tue, 27 Apr 2021 15:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0MvC5tupusYzhdgaolaLRpQ8PyV4lZ/ImbJZgGlOabs=;
        b=UD9B1PD9EF4/Bwq85aduxwK7rowJYh6r/31d4maWYo5P/jjmN0NPvIR56qWNSkcgYZ
         SRRQiyuZiULPRrCrqdwVtCmh1xFyGGmSSnB9MR2SjbBTaK2X/uP9m7mb+ncyj+F93/Bc
         hHZhSwvEzOPWN19Ln+Gy+ck0uEww6TkRxo1d5b3oOyf510VtVuMzmFZOgpixt58g5xTs
         lyYroeYU8goBXIB0bYg6JfXqEhnFgH0Ti+2Ncc97l0dhq3zh5/9s0VjJQqtuTw2GsKjB
         hz5taWikfbWCuRzvH7pUlPsOj+0L6zLSq0ETsBeJqgXig+Uepra47c9ho4nyjIVOFnu7
         ulHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0MvC5tupusYzhdgaolaLRpQ8PyV4lZ/ImbJZgGlOabs=;
        b=I8kg4GUYMXFbagtXoloSKjrZ3ShZa28agYpC9GZPxIarz152VRYNh4T0C0lJdHYoGj
         OrdRyOp69Ho6iwkx6d6FWMed+mkyZ6zfww3N1jcHRy1bqduaCXrvp4ONrYJbLLlVPGlJ
         v60AvM4lHeSnu+yNajTa+scaL3+BAOc/o3QrisesvhQNneFPmTG6QUFsthyMkBRupXhx
         mU/Cgflx1HotztVOKo/OtsndTAjOJ+fQFsX9VrjYRol/qnYE5AC10VAi/tFpduH3zMOH
         piM5SJ4fCBeaMfWH2XMyL82lc0bne/mnbodz4KVSEl7KKoOjbW1le/Pr/GOSBtKSOVA9
         ntrg==
X-Gm-Message-State: AOAM531TtAWYJG5CyXu1gOSRL5DPwXGUFksyjOKMSPORmkH5dmEkB0HR
        yl17FFT+kzD/b0X/CF31r1gKcfUy57phvt67tLl1
X-Google-Smtp-Source: ABdhPJxyeDxtrZNR0i/uwmYsi2L24RU/UpWGHF0s/k7sOiDf4uxXLk9YYpvxrEGEBVr/QNsO1vTdNjkv+W1/l8z/jJ/3
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:c423:570b:b823:c33e])
 (user=axelrasmussen job=sendgmr) by 2002:a25:870b:: with SMTP id
 a11mr39561417ybl.498.1619563983153; Tue, 27 Apr 2021 15:53:03 -0700 (PDT)
Date:   Tue, 27 Apr 2021 15:52:42 -0700
In-Reply-To: <20210427225244.4326-1-axelrasmussen@google.com>
Message-Id: <20210427225244.4326-9-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210427225244.4326-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
Subject: [PATCH v5 08/10] userfaultfd/selftests: create alias mappings in the
 shmem test
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

Previously, we just allocated two shm areas: area_src and area_dst. With
this commit, change this so we also allocate area_src_alias, and
area_dst_alias.

area_*_alias and area_* (respectively) point to the same underlying
physical pages, but are different VMAs. In a future commit in this
series, we'll leverage this setup to exercise minor fault handling
support for shmem, just like we do in the hugetlb_shared test.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index fc40831f818f..1f65c4ab7994 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -278,13 +278,29 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
-	unsigned long offset =
-		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+	void *area_alias = NULL;
+	bool is_src = alloc_area == (void **)&area_src;
+	unsigned long offset = is_src ? 0 : nr_pages * page_size;
 
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
 		err("mmap of memfd failed");
+
+	area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
+			  MAP_SHARED, shm_fd, offset);
+	if (area_alias == MAP_FAILED)
+		err("mmap of memfd alias failed");
+
+	if (is_src)
+		area_src_alias = area_alias;
+	else
+		area_dst_alias = area_alias;
+}
+
+static void shmem_alias_mapping(__u64 *start, size_t len, unsigned long offset)
+{
+	*start = (unsigned long)area_dst_alias + offset;
 }
 
 struct uffd_test_ops {
@@ -314,7 +330,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 	.expected_ioctls = SHMEM_EXPECTED_IOCTLS,
 	.allocate_area	= shmem_allocate_area,
 	.release_pages	= shmem_release_pages,
-	.alias_mapping = noop_alias_mapping,
+	.alias_mapping = shmem_alias_mapping,
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-- 
2.31.1.498.g6c1eba8ee3d-goog

