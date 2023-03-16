Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9966BC28D
	for <lists+linux-api@lfdr.de>; Thu, 16 Mar 2023 01:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjCPAba (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Mar 2023 20:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbjCPAb2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Mar 2023 20:31:28 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D494CA02B7
        for <linux-api@vger.kernel.org>; Wed, 15 Mar 2023 17:31:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z4-20020a25bb04000000b00b392ae70300so81160ybg.21
        for <linux-api@vger.kernel.org>; Wed, 15 Mar 2023 17:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678926677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rreqZKmQJtCTOHmDtxKTKEfGS9dImrAo0RCl95Sk/EE=;
        b=JJueoK7sdFHQHbdAl5nsqaNs4KCHm7sHzvLB42MnoY5lkfM6ZyYxqRBfJSJa8Yj0AO
         a2uaVznX+a7AGF4HtGGnVlQphXnV9jEi1nR4tPRumBxVDCE+WOnyJKaxZt8wQIJXoXkp
         loUdl05RrEtBxZJ1mxGOVb+Igf7OXAXS6g5lENKD5GhCbaaHIbFWr/+X13ZJvgEAeOrT
         ejL8r4WfIiMkFavlKyXDdwKqsnArh0+uyWf18MM3tbJLCmk8NSuRhA6hTr60P2bZx80K
         jj0hiuo3QlpYfzngCqcd5OQKvr0RQN1Z1ORNuOh1qFkI0/mHIDpESFq+n7v7NaT1lIXl
         wVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678926677;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rreqZKmQJtCTOHmDtxKTKEfGS9dImrAo0RCl95Sk/EE=;
        b=qDpG21rwlMhziJOaXWJlC8lvc4SBKbQ3du89ST2FLfwD5QmZug83xF3u3YFp8gw6Vj
         whWLlOF0ljSx1n6PjL/uKiY9tzIxcO+8qnMaRBM2FVSu1GqGlhJgmuUdajQ8DnIaBbnl
         1xng+Wc0+8DCbsXvNGbRnKutm8aZuRVEL3h4qWIS6ki/lBealm+cJj98w5bBJ6LtJzAn
         A7RvDk9ahlVlDa10SkwnorqgamLYeDBHtSCT61k5Wxlx99uJDiL71TnI1mpBRv+nhj2D
         L59STPKU0cww6le4ZiO3UusODuK5xZBzLMyl/IGlJyCG1k1RCrpLfiqeAzXnyTO/hGOT
         KnaA==
X-Gm-Message-State: AO0yUKWyQC4RyeGUkSGozIbD+KdXvwCiU1FLI+XS9yZtW02WzIiEqiO7
        8PuG49NKxopKdlq9CKGqM1DT5rkaaRSclbtmGg==
X-Google-Smtp-Source: AK7set+ivCVtWOdQbcZQUI9O6fTh7qxu3KKcJWd7M8I6rNN0cLeTsP1prymLMADMTsLDtTPgMIN1PCmQzWdKXvBTyw==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a25:e201:0:b0:b2e:f387:b428 with SMTP
 id h1-20020a25e201000000b00b2ef387b428mr12671962ybe.5.1678926677076; Wed, 15
 Mar 2023 17:31:17 -0700 (PDT)
Date:   Thu, 16 Mar 2023 00:30:54 +0000
In-Reply-To: <cover.1678926164.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1678926164.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <017a3f68ef7007d72f167f937fabd6d64efb9edc.1678926164.git.ackerleytng@google.com>
Subject: [RFC PATCH 01/10] KVM: selftests: Test error message fixes for
 memfd_restricted selftests
From:   Ackerley Tng <ackerleytng@google.com>
To:     kvm@vger.kernel.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, qemu-devel@nongnu.org
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        arnd@arndb.de, bfields@fieldses.org, bp@alien8.de,
        chao.p.peng@linux.intel.com, corbet@lwn.net, dave.hansen@intel.com,
        david@redhat.com, ddutile@redhat.com, dhildenb@redhat.com,
        hpa@zytor.com, hughd@google.com, jlayton@kernel.org,
        jmattson@google.com, joro@8bytes.org, jun.nakajima@intel.com,
        kirill.shutemov@linux.intel.com, linmiaohe@huawei.com,
        luto@kernel.org, mail@maciej.szmigiero.name, mhocko@suse.com,
        michael.roth@amd.com, mingo@redhat.com, naoya.horiguchi@nec.com,
        pbonzini@redhat.com, qperret@google.com, rppt@kernel.org,
        seanjc@google.com, shuah@kernel.org, steven.price@arm.com,
        tabba@google.com, tglx@linutronix.de, vannapurve@google.com,
        vbabka@suse.cz, vkuznets@redhat.com, wanpengli@tencent.com,
        wei.w.wang@intel.com, x86@kernel.org, yu.c.zhang@linux.intel.com,
        Ackerley Tng <ackerleytng@google.com>
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

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 tools/testing/selftests/vm/memfd_restricted.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/memfd_restricted.c b/tools/testing/selftests/vm/memfd_restricted.c
index 3a556b570129..43a512f273f7 100644
--- a/tools/testing/selftests/vm/memfd_restricted.c
+++ b/tools/testing/selftests/vm/memfd_restricted.c
@@ -49,12 +49,12 @@ static void test_file_size(int fd)
 	}
 
 	if (sb.st_size != page_size) {
-		fail("unexpected file size after ftruncate");
+		fail("unexpected file size after ftruncate\n");
 		return;
 	}
 
 	if (!ftruncate(fd, page_size * 2)) {
-		fail("unexpected ftruncate\n");
+		fail("size of file cannot be changed once set\n");
 		return;
 	}
 
-- 
2.40.0.rc2.332.ga46443480c-goog

