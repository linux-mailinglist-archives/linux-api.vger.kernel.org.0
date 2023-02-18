Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE40469B70F
	for <lists+linux-api@lfdr.de>; Sat, 18 Feb 2023 01:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBRAo4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 17 Feb 2023 19:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjBRAoy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 17 Feb 2023 19:44:54 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FEC54D25
        for <linux-api@vger.kernel.org>; Fri, 17 Feb 2023 16:44:26 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5366c11a9e2so12624237b3.17
        for <linux-api@vger.kernel.org>; Fri, 17 Feb 2023 16:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a9HoC/OaMmMmyFwGFTweDzsomxpTI5zBveAVKH/mxUs=;
        b=p4J50SCYcCeG3qGRpHChFsOtrnkHXhTK4OUQeA7csD+WhBd4bepBHtG/cyOfbbTSC+
         lCFAqzmMUFKlMigeUVQiWbej8Gu0AWjDX2DuN4h3rP0oUlDEosc+NJ4U87QAa5/PzCNE
         CCI6mGg0jUZFutFG4yOh79Uont3On7YTn2CT4elMJDE1FfadxmUYwEME2piTlq5az1Mq
         9aZyrgkj9RfvKY2E3TqhjPL810vpjoE3FXu/K+4aGPj7XXrOfXVxw+yab5AlL0F/7lnv
         mwMmGTIisoVBNs8uCuNHuCp5dmw5ILOZjOHaFdx58TbpMJJ+4truEcCA49DA7ssvncOM
         ZPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9HoC/OaMmMmyFwGFTweDzsomxpTI5zBveAVKH/mxUs=;
        b=Wx1bVsbB+20vJAKT1FoWcvmA5QEE2X59xjOl4GFXGKVBgKVp3hJa84g0/kPJf7pqMz
         bV1INmyYzxkTBONKYBbtqH1+2NmyhKdzVKHT1XX24IK5KcAPDLHvehBDyfQSpff/1USM
         dEuND2kOOWXe3SFJSH1MsqSOE49FkyLtwY5PCfHixI8yOVj92IWYUEiViTj0kVnXuqb2
         I7HcDack+YtQgSzq7oOeGVJVxoWphq3Nlt/ioD7k1G1MlmrS7XcZKUapGUaUuSFAa1CQ
         rS/fFaYmPkWYsymsV+iZ3XGkdpynL+eqzjF8QIzaQTv8MTyeg90XPQzzc22wxSwwM0Sw
         oXfg==
X-Gm-Message-State: AO0yUKVU70ACAArxC6mNaiz6N13q+W0Cw45WGnTnhrCW5LIaL6EaZkW3
        H3l5mpwNnZt0HIm1JG1GAKoZABrmLQqfnRmktw==
X-Google-Smtp-Source: AK7set/gCiyNU2zsSUQcnpfweO59d4+LMWomYJ6sq6DKFLDhVfbtMpiT7MZoq2d4nExGworQhG3UEyTFbFT8aAYUHA==
X-Received: from ackerleytng-cloudtop.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1f5f])
 (user=ackerleytng job=sendgmr) by 2002:a05:6902:1024:b0:8fc:686c:cf87 with
 SMTP id x4-20020a056902102400b008fc686ccf87mr57267ybt.4.1676680995496; Fri,
 17 Feb 2023 16:43:15 -0800 (PST)
Date:   Sat, 18 Feb 2023 00:43:01 +0000
In-Reply-To: <cover.1676680548.git.ackerleytng@google.com>
Mime-Version: 1.0
References: <cover.1676680548.git.ackerleytng@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <4ea08e03d57152d505b747a6a570752dd698e315.1676680548.git.ackerleytng@google.com>
Subject: [RFC PATCH 1/2] mm: restrictedmem: Add flag as THP allocation hint
 for memfd_restricted() syscall
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Allow userspace to hint the kernel to use Transparent HugePages to
back restricted memory on a per-file basis.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 include/uapi/linux/restrictedmem.h |  1 +
 mm/restrictedmem.c                 | 27 +++++++++++++++++----------
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/restrictedmem.h b/include/uapi/linux/restrictedmem.h
index 9f108dd1ac4c..f671ccbb43bc 100644
--- a/include/uapi/linux/restrictedmem.h
+++ b/include/uapi/linux/restrictedmem.h
@@ -4,5 +4,6 @@
 
 /* flags for memfd_restricted */
 #define RMFD_TMPFILE		0x0001U
+#define RMFD_HUGEPAGE		0x0002U
 
 #endif /* _UAPI_LINUX_RESTRICTEDMEM_H */
diff --git a/mm/restrictedmem.c b/mm/restrictedmem.c
index 97f3e2159e8b..87c829960b31 100644
--- a/mm/restrictedmem.c
+++ b/mm/restrictedmem.c
@@ -190,19 +190,25 @@ static struct file *restrictedmem_file_create(struct file *memfd)
 	return file;
 }
 
-static int restrictedmem_create(struct vfsmount *mount)
+static int restrictedmem_create(unsigned int flags, struct vfsmount *mount)
 {
 	struct file *file, *restricted_file;
 	int fd, err;
+	unsigned long shmem_setup_flags = VM_NORESERVE;
 
 	fd = get_unused_fd_flags(0);
 	if (fd < 0)
 		return fd;
 
-	if (mount)
-		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem", 0, VM_NORESERVE);
-	else
-		file = shmem_file_setup("memfd:restrictedmem", 0, VM_NORESERVE);
+	if (flags & RMFD_HUGEPAGE)
+		shmem_setup_flags |= VM_HUGEPAGE;
+
+	if (mount) {
+		file = shmem_file_setup_with_mnt(mount, "memfd:restrictedmem",
+						 0, shmem_setup_flags);
+	} else {
+		file = shmem_file_setup("memfd:restrictedmem", 0, shmem_setup_flags);
+	}
 
 	if (IS_ERR(file)) {
 		err = PTR_ERR(file);
@@ -230,7 +236,8 @@ static bool is_shmem_mount(struct vfsmount *mnt)
 	return mnt->mnt_sb->s_magic == TMPFS_MAGIC;
 }
 
-static int restrictedmem_create_from_path(const char __user *mount_path)
+static int restrictedmem_create_from_path(unsigned int flags,
+					  const char __user *mount_path)
 {
 	int ret;
 	struct path path;
@@ -250,7 +257,7 @@ static int restrictedmem_create_from_path(const char __user *mount_path)
 	if (unlikely(ret))
 		goto out;
 
-	ret = restrictedmem_create(path.mnt);
+	ret = restrictedmem_create(flags, path.mnt);
 
 	mnt_drop_write(path.mnt);
 out:
@@ -261,16 +268,16 @@ static int restrictedmem_create_from_path(const char __user *mount_path)
 
 SYSCALL_DEFINE2(memfd_restricted, unsigned int, flags, const char __user *, mount_path)
 {
-	if (flags & ~RMFD_TMPFILE)
+	if (flags & ~(RMFD_TMPFILE | RMFD_HUGEPAGE))
 		return -EINVAL;
 
 	if (flags == RMFD_TMPFILE) {
 		if (!mount_path)
 			return -EINVAL;
 
-		return restrictedmem_create_from_path(mount_path);
+		return restrictedmem_create_from_path(flags, mount_path);
 	} else {
-		return restrictedmem_create(NULL);
+		return restrictedmem_create(flags, NULL);
 	}
 }
 
-- 
2.39.2.637.g21b0678d19-goog

