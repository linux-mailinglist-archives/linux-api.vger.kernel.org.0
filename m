Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393673DB4CE
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 10:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhG3IA0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jul 2021 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbhG3IA0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Jul 2021 04:00:26 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F783C0613CF
        for <linux-api@vger.kernel.org>; Fri, 30 Jul 2021 01:00:21 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id o13so8628765qkk.9
        for <linux-api@vger.kernel.org>; Fri, 30 Jul 2021 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Y7HX5YFqqvflWtOAFdHp5v6MXY/OcEeQOaBTkBgwruM=;
        b=u8YUNlG7+lu5Is9eMpdvivobPs3T+0kbTL+S17t5SgHQK7ZI42wPzwim0p5Qj9MV7u
         2bU9YmpRo2bxZv0e7RZC0bKrCIrL2hx3bFOEZ6pFcNGTALYst0tCHVstlt4tlGIRQQdX
         YBJkVxUcLZYwRKs5+DEOoB5RT6WXu3viAXutpX6d0PengNqn+KpyfxmeUiJktHHuDf9S
         wz6YT+4+y452/F7EFITeaClRAPZZk6ry5z+Bi8M8uGzUp3dTwWg0eb8/yMP9X5qjqoH0
         P/262T7dGLXaXcsIuhno7w4OQvYVMVnVrxPySbDDf0a4bY6qGegqMAGl1aNtMhFP5DZ/
         8ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Y7HX5YFqqvflWtOAFdHp5v6MXY/OcEeQOaBTkBgwruM=;
        b=X8rQQvtnxpMzzPaPHZ+Qdc3+10nUiZK7hnP+tgp5lxtbFp6Vla+bsoEa26Gfq2Q/c4
         pO1iEiCt8ReF6iwSZI12cQaiDMlix4i06VBvnk+1sq8iM+bpVFEMi77b9Uahgi2FOu5y
         RmpWBuePUuuRH8DO6QNkZAVT8MkRwtobG5v5bWcqyHpdkjn/WqiaITjNgGy81BE7g1qX
         eHaD53sRlvjiygGQSmMKxbMWPYfWbM7surxwbp0CRWNH1oZ+CmV9bGAS+d4KSy2rQruj
         a8ZMjbrrpQj6oMrowPnQJr4ACKb8uAeCC9HmAO4S6XvJPgcRHA7C0m/7EjioH/gKhX9Q
         qGvQ==
X-Gm-Message-State: AOAM531A7JISJmyvwGDzLD0IYlllQq6KgwKido4b3veZHFCaxuD34eAg
        e3R9mJnQm5775QOlh2l1+51Cmg==
X-Google-Smtp-Source: ABdhPJxX+FZqmUvFbB6LFhFizDSmok15mmV3G7aae8zfjyp+xlKCEmRsFFggV9F2XDQhme81TddiHg==
X-Received: by 2002:a05:620a:13a1:: with SMTP id m1mr1061123qki.91.1627632020050;
        Fri, 30 Jul 2021 01:00:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m80sm536727qke.98.2021.07.30.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:00:18 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:00:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 12/16] tmpfs: refuse memlock when fallocated beyond i_size
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <3e5b2999-a27d-3590-46d9-80841b9427a9@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

F_MEM_LOCK is accounted by i_size, but fallocate(,FALLOC_FL_KEEP_SIZE,,)
could have added many pages beyond i_size, which would also be held as
Unevictable from memory. The mlock_ucounts check in shmem_fallocate() is
fine, but shmem_memlock_fcntl() needs to check fallocend too. We could
change F_MEM_LOCK accounting to use the max of i_size and fallocend, but
fallocend is obscure: I think it's better just to refuse the F_MEM_LOCK
(with EPERM) if fallocend exceeds (page-rounded) i_size.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6e53dabe658b..35c0f5c7120e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2304,7 +2304,10 @@ static int shmem_memlock_fcntl(struct file *file, unsigned int cmd)
 
 	inode_lock(inode);
 	if (cmd == F_MEM_LOCK) {
-		if (!info->mlock_ucounts) {
+		if (info->fallocend > DIV_ROUND_UP(inode->i_size, PAGE_SIZE)) {
+			/* locking is accounted by i_size: disallow excess */
+			retval = -EPERM;
+		} else if (!info->mlock_ucounts) {
 			struct ucounts *ucounts = current_ucounts();
 			/* capability/rlimit check is down in user_shm_lock */
 			retval = shmem_lock(file, 1, ucounts);
@@ -2854,9 +2857,10 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	spin_unlock(&inode->i_lock);
 
 	/*
-	 * info->fallocend is only relevant when huge pages might be
+	 * info->fallocend is mostly relevant when huge pages might be
 	 * involved: to prevent split_huge_page() freeing fallocated
 	 * pages when FALLOC_FL_KEEP_SIZE committed beyond i_size.
+	 * But it is also checked in F_MEM_LOCK validation.
 	 */
 	undo_fallocend = info->fallocend;
 	if (info->fallocend < end)
-- 
2.26.2

