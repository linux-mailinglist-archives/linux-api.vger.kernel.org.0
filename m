Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE535D71A
	for <lists+linux-api@lfdr.de>; Tue, 13 Apr 2021 07:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbhDMFSE (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Apr 2021 01:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344506AbhDMFSA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Apr 2021 01:18:00 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC78C061357
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 22:17:36 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j10so9365027qvp.11
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 22:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s2g9RRcT2CZqZhffih5hZD9fStRZlDgnV7MgQKwbAwI=;
        b=coyrsbU8xiEUY7cpu36WYT9x7Fa0axW22svWvL7n5nF1c6ADdd6k/Lyx3E+NBrPBQW
         VeipYvBh20HBak55G747CI4QraHrM5sP2UK+55spfq+enOAQADrPKnGvKiEAiG9EOWsc
         X+zPS7ACj9F9bIkIvAMtEBuLHV3heIbmpeUzRjR4G60Nq3mkE+k0QGi+nMBBMluk1O63
         3gLFfVdQvJ7HBhSZc5YuN0sbjQO18VVA81elmDmwcOU8PLGVdl9EXeTaCXy9bMT8qzl4
         8/yILRcNVzoYpWpCq7rWHZ0cPgtGilbL1wm//boL85BFYbhoxd7IYdxE7mZ6zkVGwlbL
         GFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s2g9RRcT2CZqZhffih5hZD9fStRZlDgnV7MgQKwbAwI=;
        b=AYgcDTzOER9wIV33Nherf9q/il7wc4xDRee73pP6YIuMjdQzTfBtewGB964dDrVRgd
         0l/WI94rc5GC46lSdDCNd8b7uMH9rQxlD1ogT33LJyCS8aZMqadOq65kXqcNSihf5HnO
         rtsIo82JYBFctGmwPz7nKo6ecPuupc8Oc8SFGZ3UbTXHKk5sxYrClYL2z2yT2qyRRhVC
         30vlgTN9nf7ZAmD7JQar+qVSC8res2ICds4h+XYE7ziyvJTYvPhaiVQ/5bgB0FFlverH
         soXOm58W69XMKsJ/nI3LpmX6r6tFXozFgHt4jtaIqwP3kcLWOcEeYf3oYFA/9LQDh+XI
         mbbQ==
X-Gm-Message-State: AOAM531TJwDcESbFbhHzEIo59xCSI9N9F8hSvWhsJMV6BAMT6x+w29p3
        nN6nJ9+huLGqNRXZNOQLBUr0eTNCqDMgjJGem57M
X-Google-Smtp-Source: ABdhPJxyr4ePMnTKYlm+ORxtBvKMef9bgZGyGXdFEgIRmGOpc7cwskM194jb6eswjWbyti669WfTVAyHWhRx5C4KA2ze
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:d508:eee5:2d57:3e32])
 (user=axelrasmussen job=sendgmr) by 2002:a0c:c3cd:: with SMTP id
 p13mr31643953qvi.4.1618291055996; Mon, 12 Apr 2021 22:17:35 -0700 (PDT)
Date:   Mon, 12 Apr 2021 22:17:18 -0700
In-Reply-To: <20210413051721.2896915-1-axelrasmussen@google.com>
Message-Id: <20210413051721.2896915-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210413051721.2896915-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH v2 6/9] userfaultfd/selftests: create alias mappings in the
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
2.31.1.295.g9ea45b61b8-goog

