Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1EE159CAA
	for <lists+linux-api@lfdr.de>; Tue, 11 Feb 2020 23:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBKW4Y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Feb 2020 17:56:24 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:44294 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgBKW4Y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Feb 2020 17:56:24 -0500
Received: by mail-pj1-f74.google.com with SMTP id c31so32430pje.9
        for <linux-api@vger.kernel.org>; Tue, 11 Feb 2020 14:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to;
        bh=zuajClpY4n8pjVJyU4VcQsX18SP0Y8Sji2fDd6chARE=;
        b=WeWDMgIwDwbj7/AXWD1nXsQn6GX/nkkwQPg4D8SaZzdpux/IoFOYqW+cPEdoZXKA+z
         KeyUCv3fQ3BRHWHWuuiFxseX9APuVA3h8PGUbRZUh0l3He+njmrEg5cSm/IGa4tv+6Tm
         I50x1iyZueTqfd07v6Uq2TOxUr049ueKUeUSlpfmn1QnCWByi3jR0lnGyH60rSEo5Ri9
         +r05f2myW4dtsdTS2k9fi5i5grbiS2UUw7IMdRJU2i1ST+/XyzYGRpXwXW2Y5w0D9TbP
         fsD2J9d+UsZnC4Cc7LQtwcEX9aAg8yO14OPMXom6LPmXosZmilC9gWbzfXSkRwxCCAPx
         85QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to;
        bh=zuajClpY4n8pjVJyU4VcQsX18SP0Y8Sji2fDd6chARE=;
        b=jojAHRbHBcSC64hoiUAnAOB7a07/LUJNgML3RuLx+ko0Z5iW1uUeuUiEZ0bN817qlo
         +rsh8NLxTsx8SdhztOjElLmTukRcdpsyM+xWcvfkv0PvGfZwKy2/48Vpuo5ofaM94Ps1
         NjIGHpW/nTagDSljpASZoWoHPKrsy3pzKXEgQAOqJbstwgC39n3ehydBZJkNA1dvAvUf
         SInPopoIpyPpdatnM2jSb4u7vfVPzxjT2Umc2atBBtzdUFwG7fBVrCizaONxtFNOOg6O
         P0zVvP9IhdLVnSvSmP66elD+kqeBhdBCctnLAemYgOwGEUqMYj49k6cwXE37/w8joo2b
         ndog==
X-Gm-Message-State: APjAAAW6FYDKnAcOP4TkYqeM2eTcB82ic+5Z4aOwJBuMByeiAgjZRfdl
        ZRY/kLjpxl8bTFLABvSU9RUZIK8aylE=
X-Google-Smtp-Source: APXvYqxGjLt1U5Fk+LSI+2JB0pVm97WGbcPVZqZFDRBBOx6SwjGavrdX+xsJLI7S/No1RnNsl9FHCebL6nw=
X-Received: by 2002:a63:4525:: with SMTP id s37mr9086010pga.418.1581461781964;
 Tue, 11 Feb 2020 14:56:21 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:55:46 -0800
In-Reply-To: <20200211225547.235083-1-dancol@google.com>
Message-Id: <20200211225547.235083-6-dancol@google.com>
Mime-Version: 1.0
References: <20200211225547.235083-1-dancol@google.com>
X-Mailer: git-send-email 2.25.0.225.g125e21ebc7-goog
Subject: [PATCH v2 5/6] Let userfaultfd opt out of handling kernel-mode faults
From:   Daniel Colascione <dancol@google.com>
To:     dancol@google.com, timmurray@google.com, nosh@google.com,
        nnk@google.com, lokeshgidra@google.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

userfaultfd handles page faults from both user and kernel code.  Add a
new UFFD_USER_MODE_ONLY flag for userfaultfd(2) that makes the
resulting userfaultfd object refuse to handle faults from kernel mode,
treating these faults as if SIGBUS were always raised, causing the
kernel code to fail with EFAULT.

A future patch adds a knob allowing administrators to give some
processes the ability to create userfaultfd file objects only if they
pass UFFD_USER_MODE_ONLY, reducing the likelihood that these processes
will exploit userfaultfd's ability to delay kernel page faults to open
timing windows for future exploits.

Signed-off-by: Daniel Colascione <dancol@google.com>
---
 fs/userfaultfd.c                 | 7 ++++++-
 include/uapi/linux/userfaultfd.h | 9 +++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 11227b94a5a7..47825a804d63 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -389,6 +389,9 @@ vm_fault_t handle_userfault(struct vm_fault *vmf, unsigned long reason)
 
 	if (ctx->features & UFFD_FEATURE_SIGBUS)
 		goto out;
+	if ((vmf->flags & FAULT_FLAG_USER) == 0 &&
+	    ctx->flags & UFFD_USER_MODE_ONLY)
+		goto out;
 
 	/*
 	 * If it's already released don't get it. This avoids to loop
@@ -1945,6 +1948,7 @@ static void init_once_userfaultfd_ctx(void *mem)
 
 SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
+	static const int uffd_flags = UFFD_USER_MODE_ONLY;
 	struct userfaultfd_ctx *ctx;
 	int fd;
 
@@ -1954,10 +1958,11 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	BUG_ON(!current->mm);
 
 	/* Check the UFFD_* constants for consistency.  */
+	BUILD_BUG_ON(uffd_flags & UFFD_SHARED_FCNTL_FLAGS);
 	BUILD_BUG_ON(UFFD_CLOEXEC != O_CLOEXEC);
 	BUILD_BUG_ON(UFFD_NONBLOCK != O_NONBLOCK);
 
-	if (flags & ~UFFD_SHARED_FCNTL_FLAGS)
+	if (flags & ~(UFFD_SHARED_FCNTL_FLAGS | uffd_flags))
 		return -EINVAL;
 
 	ctx = kmem_cache_alloc(userfaultfd_ctx_cachep, GFP_KERNEL);
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 48f1a7c2f1f0..fe3565eae617 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -231,4 +231,13 @@ struct uffdio_zeropage {
 	__s64 zeropage;
 };
 
+/*
+ * Flags for the userfaultfd(2) system call itself.
+ */
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 1
+
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.25.0.225.g125e21ebc7-goog

