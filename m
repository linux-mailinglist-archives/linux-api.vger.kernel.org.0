Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED45872BD
	for <lists+linux-api@lfdr.de>; Mon,  1 Aug 2022 23:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbiHAVKn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 1 Aug 2022 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiHAVKl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 1 Aug 2022 17:10:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D983612D3C
        for <linux-api@vger.kernel.org>; Mon,  1 Aug 2022 14:10:39 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id k4-20020a63ff04000000b0041beb6ea9bbso1815043pgi.21
        for <linux-api@vger.kernel.org>; Mon, 01 Aug 2022 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KL3c87ruB0ymX0jSv32942oFvhIYzdHqFNkGFEIua/8=;
        b=gDv+x1MaW0q4itUhOty9KtQFH3rn+38zjhyw39LajomZ3bqfVNAiip5CCmU1Qc6c1l
         5l3Dfqh1QQyglYnkmKujQsy9dEg9Gif8JXMkEjvj6nuPH4PjF/wAnA47tTQVah2DyW3s
         d3mdG17rP9EP/IsHkXFh4rnevkmZDf6MHO/m5np3SY2w0sF2vA5SEUQ1Y4YUOARQe+ht
         LEZrbovL+hfZoBN3l7aW9kTsDJWhmsrBBOzXgkuRliGXrUH6TaVDYD2Ud+OXwlFwD/cf
         lND037pswgBPiVpoqHgTj1y359JbAE8zClUjqrmPgxeBDoiWVDmnnRslnAXdTv5amivu
         FEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KL3c87ruB0ymX0jSv32942oFvhIYzdHqFNkGFEIua/8=;
        b=f5y2McWAWoVBWNFLq8eZ4RlHutcGy4LM6LjjlBHGdV0u/5nXkjIE5XZUBuejYDGrz9
         QdJrtH/IPLb2hadh9+jiitT8bFgmzxwbgYUn4w0CibXgSSA60lobsze2HzFXKeJM6Qlr
         EPXsIWgqTgLL+fas8wi+e50O2f2h2m4kz0bhETtl+iXtdJzC3aTP0Unw41zm6oOYAwfm
         VAxq9Y+67QDh8srJTAJpfbvLnz2xYxQTLl6DEoJFh1pPL5bVHaeWu1jw8qaBksCd6Vw6
         eYcaCYyxhQkTzdxWmZkhJD7WwOLCtmfyA8jYflpkdQqSTX4vNI80xIHIvFAWGVNv0rSH
         Jz1w==
X-Gm-Message-State: AJIora9lfk2EXvCYoeUaL5JPr8ftVqO/CQEHgPvjyd+iHE9SLM91cp4X
        Wj/eSJuLNu+Nt0TFWDRD5LShZTs8ZrMD
X-Google-Smtp-Source: AGRyM1skHXU43IOBJT0QFPsSd+aD0Ri8/sHejHzRcXCCizH8vRYYDPN81WNYC0Tpk5hlL0wyz52QS7AYf6bg
X-Received: from zokeefe3.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1b6])
 (user=zokeefe job=sendgmr) by 2002:a05:6a00:2312:b0:52b:928:99dd with SMTP id
 h18-20020a056a00231200b0052b092899ddmr17511637pfh.77.1659388239374; Mon, 01
 Aug 2022 14:10:39 -0700 (PDT)
Date:   Mon,  1 Aug 2022 14:09:46 -0700
Message-Id: <20220801210946.3069083-1-zokeefe@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH mm-unstable] mm/madvise: remove CAP_SYS_ADMIN requirement for process_madvise(MADV_COLLAPSE)
From:   "Zach O'Keefe" <zokeefe@google.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        SeongJae Park <sj@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chris Kennelly <ckennelly@google.com>,
        Chris Zankel <chris@zankel.net>, Helge Deller <deller@gmx.de>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Patrick Xia <patrickx@google.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Zach O'Keefe" <zokeefe@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

process_madvise(MADV_COLLAPSE) currently requires CAP_SYS_ADMIN when not
acting on the caller's own mm.  This is maximally restrictive, and
perpetuates existing issues with CAP_SYS_ADMIN.  Remove this requirement.

When acting on an external process' memory, the biggest concerns for
process_madvise(MADV_COLLAPSE) are (1) being able to influence process
performance by moving memory, possibly between nodes, that is mapped
into the address space of external process(es), (2) defeat of
address-space-layout randomization, and (3), being able to increase
process RSS and memcg usage, possibly causing memcg OOM.

process_madvise(2) already enforces CAP_SYS_NICE and PTRACE_MODE_READ (in
PTRACE_MODE_FSCREDS mode).  A process with these credentials can already
accomplish (1) and (2) via move_pages(MPOL_MF_MOVE_ALL), and (3) via
process_madvise(MADV_WILLNEED).

process_madvise(MADV_COLLAPSE) may also circumvent sysfs THP settings.
When acting on one's own memory (which is equivalent to
madvise(MADV_COLLAPSE)), this is deemed acceptable, since aside from the
possibility of hoarding available hugepages (which is currently already
possible) no harm to the system can be done.  When acting on an external
process' memory, circumventing sysfs THP settings should provide no
additional threat compared to the ones listed.  As such, imposing
additional capabilities (such as CAP_SETUID, as a way to ensure the
caller could have just altered the sysfs THP settings themselves)
provides no extra protection.

Fixes: 7ec952341312 ("mm/madvise: add MADV_COLLAPSE to process_madvise()")
Signed-off-by: Zach O'Keefe <zokeefe@google.com>
---
 mm/madvise.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index f9e11b6c9916..af97100a0727 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1170,16 +1170,14 @@ madvise_behavior_valid(int behavior)
 	}
 }
 
-static bool
-process_madvise_behavior_valid(int behavior, struct task_struct *task)
+static bool process_madvise_behavior_valid(int behavior)
 {
 	switch (behavior) {
 	case MADV_COLD:
 	case MADV_PAGEOUT:
 	case MADV_WILLNEED:
-		return true;
 	case MADV_COLLAPSE:
-		return task == current || capable(CAP_SYS_ADMIN);
+		return true;
 	default:
 		return false;
 	}
@@ -1457,7 +1455,7 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 		goto free_iov;
 	}
 
-	if (!process_madvise_behavior_valid(behavior, task)) {
+	if (!process_madvise_behavior_valid(behavior)) {
 		ret = -EINVAL;
 		goto release_task;
 	}
-- 
2.37.1.455.g008518b4e5-goog

