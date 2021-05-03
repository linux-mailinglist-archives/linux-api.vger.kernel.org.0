Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC8F371F3C
	for <lists+linux-api@lfdr.de>; Mon,  3 May 2021 20:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhECSJB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 May 2021 14:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhECSIt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 May 2021 14:08:49 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B63AC061348
        for <linux-api@vger.kernel.org>; Mon,  3 May 2021 11:07:53 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h190-20020a3785c70000b02902e022511825so5754645qkd.7
        for <linux-api@vger.kernel.org>; Mon, 03 May 2021 11:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rLicbgjBW9z9eKVcQKp4wHRRLj2JzrLl40NiB/ljX8M=;
        b=dYQbKoRMU91hOrSaWBLxUpTQ05+ZNfEo4S7tV4qClTWooCDGneergtpY8tZcI1BeJI
         p7UfIOb8j3uR/uAa9q8apWqtTdzN4eBG7l9w+JZzDYVvVL2ASJrPke57fAPMEYTbG2C4
         ERRpFY0fjyF+GYSCPN9PK1DEf5KFkY2NBN83AazVqyRCWDvahiveuMsHe5fgjDew4TOj
         dC81tnwmnFaEYCEAwYH+M3YmqOjN7jNU+SND9kXKVx1GFSpkFTiBrhVvuwcemQgfWDDd
         YHuVEWNXez6FTpwpAMYamSg5JI28GO4eDmoPjy66uTbUhczB7zLfdC2un3/a+fpgilm0
         YWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rLicbgjBW9z9eKVcQKp4wHRRLj2JzrLl40NiB/ljX8M=;
        b=HBHEcHpT4uOCDqgc+s7POuHsRB3FaL0TpsmwjvYeoirWIeLgl68p5hjxjz4vEUYFIp
         BkLBov/OTLPzb3DtmKr6sBRP5pKmDpTJ/Q7CBionK1IVBvRYAvOtRutP6ALTGRUBcoKR
         cwtSq4LbfFURvmTr/HzQtCJpr901xuxXeuwX8MupmAndjpVvKT4Nm2nFJkuxp5cpF02o
         2qmkx3qNjN4boyDwt95Nmd18S2EwiTeEDZZLdBmD0fRu+U1nSqNhKpjwTD9xnDvxstg8
         OvCiSmb5QdMgct+e47BgM3Ob4HyVTjcnZpVEiHZbuaU/mbvJjaXV2bf0qUrdds0y9Zy8
         K0Kg==
X-Gm-Message-State: AOAM5306zGxuAwY43btzI2h3EJ03r2xVBhT+OGg3zsaTS/Ti32Bd89Zn
        mOFiqDoKIjs87FRyDP8Hna88D1zDOZARdtEX0jHy
X-Google-Smtp-Source: ABdhPJy1xqLPQr/XdBSNr2qNlen7wPq5zImtLkaKsKj5y77xMMSUpDG+ZJHsvmvO9ip76I57W6uNh5GMDPom3sfr5b8/
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d79:e69a:a4f9:ef0])
 (user=axelrasmussen job=sendgmr) by 2002:ad4:4441:: with SMTP id
 l1mr20459035qvt.1.1620065272357; Mon, 03 May 2021 11:07:52 -0700 (PDT)
Date:   Mon,  3 May 2021 11:07:32 -0700
In-Reply-To: <20210503180737.2487560-1-axelrasmussen@google.com>
Message-Id: <20210503180737.2487560-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210503180737.2487560-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v6 05/10] userfaultfd/shmem: advertise shmem minor fault support
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

Now that the feature is fully implemented (the faulting path hooks exist
so userspace is notified, and the ioctl to resolve such faults is
available), advertise this as a supported feature.

Acked-by: Hugh Dickins <hughd@google.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 Documentation/admin-guide/mm/userfaultfd.rst | 3 ++-
 fs/userfaultfd.c                             | 3 ++-
 include/uapi/linux/userfaultfd.h             | 7 ++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/userfaultfd.rst b/Documentation/admin-guide/mm/userfaultfd.rst
index 3aa38e8b8361..6528036093e1 100644
--- a/Documentation/admin-guide/mm/userfaultfd.rst
+++ b/Documentation/admin-guide/mm/userfaultfd.rst
@@ -77,7 +77,8 @@ events, except page fault notifications, may be generated:
 
 - ``UFFD_FEATURE_MINOR_HUGETLBFS`` indicates that the kernel supports
   ``UFFDIO_REGISTER_MODE_MINOR`` registration for hugetlbfs virtual memory
-  areas.
+  areas. ``UFFD_FEATURE_MINOR_SHMEM`` is the analogous feature indicating
+  support for shmem virtual memory areas.
 
 The userland application should set the feature flags it intends to use
 when invoking the ``UFFDIO_API`` ioctl, to request that those features be
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 468556fb04a9..9f3b8684cf3c 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1940,7 +1940,8 @@ static int userfaultfd_api(struct userfaultfd_ctx *ctx,
 	/* report all available features and ioctls to userland */
 	uffdio_api.features = UFFD_API_FEATURES;
 #ifndef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
-	uffdio_api.features &= ~UFFD_FEATURE_MINOR_HUGETLBFS;
+	uffdio_api.features &=
+		~(UFFD_FEATURE_MINOR_HUGETLBFS | UFFD_FEATURE_MINOR_SHMEM);
 #endif
 	uffdio_api.ioctls = UFFD_API_IOCTLS;
 	ret = -EFAULT;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index bafbeb1a2624..159a74e9564f 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -31,7 +31,8 @@
 			   UFFD_FEATURE_MISSING_SHMEM |		\
 			   UFFD_FEATURE_SIGBUS |		\
 			   UFFD_FEATURE_THREAD_ID |		\
-			   UFFD_FEATURE_MINOR_HUGETLBFS)
+			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_MINOR_SHMEM)
 #define UFFD_API_IOCTLS				\
 	((__u64)1 << _UFFDIO_REGISTER |		\
 	 (__u64)1 << _UFFDIO_UNREGISTER |	\
@@ -185,6 +186,9 @@ struct uffdio_api {
 	 * UFFD_FEATURE_MINOR_HUGETLBFS indicates that minor faults
 	 * can be intercepted (via REGISTER_MODE_MINOR) for
 	 * hugetlbfs-backed pages.
+	 *
+	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
+	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
 	 */
 #define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
 #define UFFD_FEATURE_EVENT_FORK			(1<<1)
@@ -196,6 +200,7 @@ struct uffdio_api {
 #define UFFD_FEATURE_SIGBUS			(1<<7)
 #define UFFD_FEATURE_THREAD_ID			(1<<8)
 #define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
+#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
 	__u64 features;
 
 	__u64 ioctls;
-- 
2.31.1.527.g47e6f16901-goog

