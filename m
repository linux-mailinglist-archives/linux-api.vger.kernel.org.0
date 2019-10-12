Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE45DD5209
	for <lists+linux-api@lfdr.de>; Sat, 12 Oct 2019 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbfJLTQj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 12 Oct 2019 15:16:39 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51024 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfJLTQX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 12 Oct 2019 15:16:23 -0400
Received: by mail-pf1-f201.google.com with SMTP id q127so10217468pfc.17
        for <linux-api@vger.kernel.org>; Sat, 12 Oct 2019 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iOxLSyvauwwhumHzgnG9xPoY+bBy9JSBRyXvMmFSrNY=;
        b=vU+VS9/Xc5ZZqcPsDEq08NdpvWhOfJ7V11CiZ4nhL2PcL/QGvs8KlCAI5hMoeF6KXe
         J22BspMsEAuiLiJIPH9KeY/UtlpL5m2+iYdd2QjCwngE1+BYX4B5aB6DBGTGa51xcRRZ
         p7auEWHT1k/rJ01trWIMLQO1ktUHOm7ANrHV+EA5oZSdYDeUGDY3HHR10CbCtI6QG7oQ
         FBllhGH81W5jXFSqnF65x0M2rxSJwcQ8Ng0mS9KTEI40+Mi263JknxSzFdEPG2lk53hR
         pxOLF0KEwfV3qblCcW2h0SnwDGbQdhR13Xq+gSVwFlRPNwOmkP1KRthADORsOvx3xHVR
         wpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iOxLSyvauwwhumHzgnG9xPoY+bBy9JSBRyXvMmFSrNY=;
        b=Xh6HitSZ4fqMY9xZkjqqI/DstvaY4Pd3TiVlKLRQpJN+gohGuErw9YmePsEY/1dV8a
         9te+XHcbJY9hSBv2hm2PqNYuT5pCAANxrRR0wLcxGW7Fy7VTd6kQoohWgjR1Dugtfrfz
         OxDMMJsy0gYGfY/qxYEkDfnvVBKwAzaLKoABBSylb/9J0gHOAmzNAluWNhDZALmLRuca
         GTEpoyD1pDuqfM0OxfM8bb08KOEryOb9+rHSmsvP20AFtmeksaE8hLv12WVxwcacAHB9
         i/48QiR1Rj1xQfAC9zJqCmAvpd4U5GW1VoZyReNnBigBfD2ipYNoM9C+lj18xEi04BWp
         0dlA==
X-Gm-Message-State: APjAAAWFPwCwZnEs4y82w4T41+I0tFSOAslmyy0MaZTZiZQ0GZyJwOdI
        5wAdXXnzsCgTfSkgjIiSV5JH6Xj05uKCtgonS72qasYvDGOlZdbulvzaAs7t4VLo7LRqg+Rb7Hp
        D1KXhlFZwLFp1bSW1OXEJ92GicuIR0L56nvATmDOkErF6ljuK2d/LF/s2he9AOiOYXw==
X-Google-Smtp-Source: APXvYqyFl3qNDCqMy0PcJvX0enVhF6M9h9yutHE9ydYGe5euA4uri/08PLCdEMnDDfadqf0JFdrojOzW2zo=
X-Received: by 2002:a63:1e1f:: with SMTP id e31mr3212172pge.303.1570907781014;
 Sat, 12 Oct 2019 12:16:21 -0700 (PDT)
Date:   Sat, 12 Oct 2019 12:16:00 -0700
In-Reply-To: <20191012191602.45649-1-dancol@google.com>
Message-Id: <20191012191602.45649-6-dancol@google.com>
Mime-Version: 1.0
References: <20191012191602.45649-1-dancol@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 5/7] Let userfaultfd opt out of handling kernel-mode faults
From:   Daniel Colascione <dancol@google.com>
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        lokeshgidra@google.com, dancol@google.com, nnk@google.com
Cc:     nosh@google.com, timmurray@google.com
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
 fs/userfaultfd.c                 | 5 ++++-
 include/uapi/linux/userfaultfd.h | 6 ++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 1123089c3d55..986d23b2cd33 100644
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
@@ -1959,7 +1962,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 {
 	struct userfaultfd_ctx *ctx;
 	int fd;
-	static const int uffd_flags = UFFD_SECURE;
+	static const int uffd_flags = UFFD_SECURE | UFFD_USER_MODE_ONLY;
 
 	if (!sysctl_unprivileged_userfaultfd && !capable(CAP_SYS_PTRACE))
 		return -EPERM;
diff --git a/include/uapi/linux/userfaultfd.h b/include/uapi/linux/userfaultfd.h
index 12d7d40d7f25..eadd1497e7b5 100644
--- a/include/uapi/linux/userfaultfd.h
+++ b/include/uapi/linux/userfaultfd.h
@@ -239,4 +239,10 @@ struct uffdio_zeropage {
  * Create a userfaultfd with MAC security checks enabled.
  */
 #define UFFD_SECURE 1
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 2
+
 #endif /* _LINUX_USERFAULTFD_H */
-- 
2.23.0.700.g56cf767bdb-goog

