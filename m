Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D598952A7
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfHTAUU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:20:20 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41510 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbfHTASc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:32 -0400
Received: by mail-pl1-f201.google.com with SMTP id ci3so2936403plb.8
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bC7ewIpOD7kKRv4zgEwcJ/YudS1s9NTZWLzeTQRmanE=;
        b=URfPq3ODlEY2xBjCdcYfrSPpu5TgIjKf8zYvzddN03jGNVkCBho81L6lWf1m027tUQ
         HkA1v54fNVgVAY5G5597pvwIpHxmuqdLgZX56kdiMWiLQjHN3h6tcmJxQkjKQfGBaDuy
         2ENi4+VmUWVTHHDq/fCJNxRwsmp4hVzFCDF43Sh+PJ1o+U57tsaoSNlbtGS8O+LHjcco
         irvf5qbgvO+/1IWbmyFQ4cte+zOHPxJf/KT3TsLI+vwOcLgnz3RwAICV07tJHoDfP2YZ
         cMAzwfG+gQXXsNMVB7md0Tp0mE6ngM71Yks5gtjVGhb7PvMZ1F2Mrguz08HumraiPB9q
         qEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bC7ewIpOD7kKRv4zgEwcJ/YudS1s9NTZWLzeTQRmanE=;
        b=IQwv5Ps4VIVOM/6Hepk6QdwtFwZ7su5CHtwbxYav47PPUXa6CjTfAdi22izddFRr7u
         5JWs+2wu1DYh4oJICaIcif7++YEuAZrEFFXCsHUFq5A3AqNPYXTYgmC8oOfW4SR0KzA8
         bP8Tnihxc+juc6y1js9tw3wzpxBOOq2R3f/Ui04v3slcZdleX6vrZTq1bb82qtYCG6kI
         3WUctjAS3c5mbBeVtgq1zqqmP7C29P5RByWgT2xPNeaJ0lEk2PB6dQmBiE/hw1SoMh5o
         u/lr5MlvW+WWJ4wqE/CALzT3FCerNmrqGFXMBMsokaD1hbFmN7k0/e8PR9GlWwuGdgTQ
         SDvw==
X-Gm-Message-State: APjAAAUZW9boNc+JLBt9z2wT8Q6QGN3/qohZi7ifb+6L9nkrFreN+wZZ
        yyvTcisfWAfSkxiyrzpjihx3upI1b83n4X44/N4bFA==
X-Google-Smtp-Source: APXvYqwIhWHZGyd8iGulecMwl621eBwYwjIu2poTs2trYo9QmU74aijoZ+0dXwjmZLzmdC5xxDfld7Wqi+WYZt4J1YODpw==
X-Received: by 2002:a63:2043:: with SMTP id r3mr22349910pgm.311.1566260311059;
 Mon, 19 Aug 2019 17:18:31 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:44 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 08/29] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG
 and KEXEC_SIG_FORCE
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Jiri Bohac <jbohac@suse.cz>

This is a preparatory patch for kexec_file_load() lockdown.  A locked down
kernel needs to prevent unsigned kernel images from being loaded with
kexec_file_load().  Currently, the only way to force the signature
verification is compiling with KEXEC_VERIFY_SIG.  This prevents loading
usigned images even when the kernel is not locked down at runtime.

This patch splits KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE.
Analogous to the MODULE_SIG and MODULE_SIG_FORCE for modules, KEXEC_SIG
turns on the signature verification but allows unsigned images to be
loaded.  KEXEC_SIG_FORCE disallows images without a valid signature.

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
cc: kexec@lists.infradead.org
---
 arch/arm64/Kconfig                      |  6 +--
 arch/s390/Kconfig                       |  2 +-
 arch/s390/configs/debug_defconfig       |  2 +-
 arch/s390/configs/defconfig             |  2 +-
 arch/s390/configs/performance_defconfig |  2 +-
 arch/s390/kernel/kexec_elf.c            |  4 +-
 arch/s390/kernel/kexec_image.c          |  4 +-
 arch/s390/kernel/machine_kexec_file.c   |  4 +-
 arch/x86/Kconfig                        | 20 ++++++---
 arch/x86/kernel/ima_arch.c              |  4 +-
 crypto/asymmetric_keys/verify_pefile.c  |  4 +-
 include/linux/kexec.h                   |  4 +-
 kernel/kexec_file.c                     | 60 +++++++++++++++++++++----
 security/integrity/ima/Kconfig          |  2 +-
 security/integrity/ima/ima_main.c       |  2 +-
 15 files changed, 88 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 697ea0510729..f940500a941b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -961,7 +961,7 @@ config KEXEC_FILE
 	  for kernel and initramfs as opposed to list of segments as
 	  accepted by previous system call.
 
-config KEXEC_VERIFY_SIG
+config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
 	help
@@ -976,13 +976,13 @@ config KEXEC_VERIFY_SIG
 config KEXEC_IMAGE_VERIFY_SIG
 	bool "Enable Image signature verification support"
 	default y
-	depends on KEXEC_VERIFY_SIG
+	depends on KEXEC_SIG
 	depends on EFI && SIGNED_PE_FILE_VERIFICATION
 	help
 	  Enable Image signature verification support.
 
 comment "Support for PE file signature verification disabled"
-	depends on KEXEC_VERIFY_SIG
+	depends on KEXEC_SIG
 	depends on !EFI || !SIGNED_PE_FILE_VERIFICATION
 
 config CRASH_DUMP
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 109243fdb6ec..c4a423f30d49 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -555,7 +555,7 @@ config ARCH_HAS_KEXEC_PURGATORY
 	def_bool y
 	depends on KEXEC_FILE
 
-config KEXEC_VERIFY_SIG
+config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE && SYSTEM_DATA_VERIFICATION
 	help
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index b0920b35f87b..525e0a6addb9 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -64,7 +64,7 @@ CONFIG_NUMA=y
 CONFIG_PREEMPT=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
-CONFIG_KEXEC_VERIFY_SIG=y
+CONFIG_KEXEC_SIG=y
 CONFIG_EXPOLINE=y
 CONFIG_EXPOLINE_AUTO=y
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c59b922cb6c5..4c37279acdb4 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -39,7 +39,7 @@ CONFIG_NR_CPUS=256
 CONFIG_NUMA=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
-CONFIG_KEXEC_VERIFY_SIG=y
+CONFIG_KEXEC_SIG=y
 CONFIG_CRASH_DUMP=y
 CONFIG_HIBERNATION=y
 CONFIG_PM_DEBUG=y
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index 09aa5cb14873..158ad0f0d433 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -65,7 +65,7 @@ CONFIG_NR_CPUS=512
 CONFIG_NUMA=y
 CONFIG_HZ_100=y
 CONFIG_KEXEC_FILE=y
-CONFIG_KEXEC_VERIFY_SIG=y
+CONFIG_KEXEC_SIG=y
 CONFIG_EXPOLINE=y
 CONFIG_EXPOLINE_AUTO=y
 CONFIG_MEMORY_HOTPLUG=y
diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 6d0635ceddd0..9b4f37a4edf1 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -130,7 +130,7 @@ static int s390_elf_probe(const char *buf, unsigned long len)
 const struct kexec_file_ops s390_kexec_elf_ops = {
 	.probe = s390_elf_probe,
 	.load = s390_elf_load,
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC__SIG
 	.verify_sig = s390_verify_sig,
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 };
diff --git a/arch/s390/kernel/kexec_image.c b/arch/s390/kernel/kexec_image.c
index 58318bf89fd9..af23eff5774d 100644
--- a/arch/s390/kernel/kexec_image.c
+++ b/arch/s390/kernel/kexec_image.c
@@ -59,7 +59,7 @@ static int s390_image_probe(const char *buf, unsigned long len)
 const struct kexec_file_ops s390_kexec_image_ops = {
 	.probe = s390_image_probe,
 	.load = s390_image_load,
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 	.verify_sig = s390_verify_sig,
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 };
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index fbdd3ea73667..c0f33ba49a9a 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -22,7 +22,7 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
 	NULL,
 };
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 /*
  * Module signature information block.
  *
@@ -90,7 +90,7 @@ int s390_verify_sig(const char *kernel, unsigned long kernel_len)
 				      VERIFYING_MODULE_SIGNATURE,
 				      NULL, NULL);
 }
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 
 static int kexec_file_update_purgatory(struct kimage *image,
 				       struct s390_load_data *data)
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2bbbd4d1ba31..cd41998aa6e6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2006,20 +2006,30 @@ config KEXEC_FILE
 config ARCH_HAS_KEXEC_PURGATORY
 	def_bool KEXEC_FILE
 
-config KEXEC_VERIFY_SIG
+config KEXEC_SIG
 	bool "Verify kernel signature during kexec_file_load() syscall"
 	depends on KEXEC_FILE
 	---help---
-	  This option makes kernel signature verification mandatory for
-	  the kexec_file_load() syscall.
 
-	  In addition to that option, you need to enable signature
+	  This option makes the kexec_file_load() syscall check for a valid
+	  signature of the kernel image.  The image can still be loaded without
+	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
+	  there's a signature that we can check, then it must be valid.
+
+	  In addition to this option, you need to enable signature
 	  verification for the corresponding kernel image type being
 	  loaded in order for this to work.
 
+config KEXEC_SIG_FORCE
+	bool "Require a valid signature in kexec_file_load() syscall"
+	depends on KEXEC_SIG
+	---help---
+	  This option makes kernel signature verification mandatory for
+	  the kexec_file_load() syscall.
+
 config KEXEC_BZIMAGE_VERIFY_SIG
 	bool "Enable bzImage signature verification support"
-	depends on KEXEC_VERIFY_SIG
+	depends on KEXEC_SIG
 	depends on SIGNED_PE_FILE_VERIFICATION
 	select SYSTEM_TRUSTED_KEYRING
 	---help---
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 64b973f0e985..b98890894731 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -66,9 +66,9 @@ bool arch_ima_get_secureboot(void)
 
 /* secureboot arch rules */
 static const char * const sb_arch_rules[] = {
-#if !IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG)
+#if !IS_ENABLED(CONFIG_KEXEC_SIG)
 	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
-#endif /* CONFIG_KEXEC_VERIFY_SIG */
+#endif /* CONFIG_KEXEC_SIG */
 	"measure func=KEXEC_KERNEL_CHECK",
 #if !IS_ENABLED(CONFIG_MODULE_SIG)
 	"appraise func=MODULE_CHECK appraise_type=imasig",
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index 3b303fe2f061..cc9dbcecaaca 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -96,7 +96,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 
 	if (!ddir->certs.virtual_address || !ddir->certs.size) {
 		pr_debug("Unsigned PE binary\n");
-		return -EKEYREJECTED;
+		return -ENODATA;
 	}
 
 	chkaddr(ctx->header_size, ddir->certs.virtual_address,
@@ -403,6 +403,8 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
  *  (*) 0 if at least one signature chain intersects with the keys in the trust
  *	keyring, or:
  *
+ *  (*) -ENODATA if there is no signature present.
+ *
  *  (*) -ENOPKG if a suitable crypto module couldn't be found for a check on a
  *	chain.
  *
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index b9b1bc5f9669..58b27c7bdc2b 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -125,7 +125,7 @@ typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
 			     unsigned long cmdline_len);
 typedef int (kexec_cleanup_t)(void *loader_data);
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 typedef int (kexec_verify_sig_t)(const char *kernel_buf,
 				 unsigned long kernel_len);
 #endif
@@ -134,7 +134,7 @@ struct kexec_file_ops {
 	kexec_probe_t *probe;
 	kexec_load_t *load;
 	kexec_cleanup_t *cleanup;
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 	kexec_verify_sig_t *verify_sig;
 #endif
 };
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index ef7b951a8087..972931201995 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -88,7 +88,7 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
 					  unsigned long buf_len)
 {
@@ -177,6 +177,51 @@ void kimage_file_post_load_cleanup(struct kimage *image)
 	image->image_loader_data = NULL;
 }
 
+#ifdef CONFIG_KEXEC_SIG
+static int
+kimage_validate_signature(struct kimage *image)
+{
+	const char *reason;
+	int ret;
+
+	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
+					   image->kernel_buf_len);
+	switch (ret) {
+	case 0:
+		break;
+
+		/* Certain verification errors are non-fatal if we're not
+		 * checking errors, provided we aren't mandating that there
+		 * must be a valid signature.
+		 */
+	case -ENODATA:
+		reason = "kexec of unsigned image";
+		goto decide;
+	case -ENOPKG:
+		reason = "kexec of image with unsupported crypto";
+		goto decide;
+	case -ENOKEY:
+		reason = "kexec of image with unavailable key";
+	decide:
+		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
+			pr_notice("%s rejected\n", reason);
+			return ret;
+		}
+
+		return 0;
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		pr_notice("kernel signature verification failed (%d).\n", ret);
+	}
+
+	return ret;
+}
+#endif
+
 /*
  * In file mode list of segments is prepared by kernel. Copy relevant
  * data from user space, do error checking, prepare segment list
@@ -186,7 +231,7 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
 			     unsigned long cmdline_len, unsigned flags)
 {
-	int ret = 0;
+	int ret;
 	void *ldata;
 	loff_t size;
 
@@ -205,14 +250,11 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
-	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
-					   image->kernel_buf_len);
-	if (ret) {
-		pr_debug("kernel signature verification failed.\n");
+#ifdef CONFIG_KEXEC_SIG
+	ret = kimage_validate_signature(image);
+
+	if (ret)
 		goto out;
-	}
-	pr_debug("kernel signature verification successful.\n");
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 2692c7358c2c..32cd25fa44a5 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -160,7 +160,7 @@ config IMA_APPRAISE
 
 config IMA_ARCH_POLICY
         bool "Enable loading an IMA architecture specific policy"
-        depends on KEXEC_VERIFY_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
+        depends on KEXEC_SIG || IMA_APPRAISE && INTEGRITY_ASYMMETRIC_KEYS
         default n
         help
           This option enables loading an IMA architecture specific policy
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f556e6c18f9b..1cffda4412b7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -541,7 +541,7 @@ int ima_load_data(enum kernel_load_data_id id)
 
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
-		if (IS_ENABLED(CONFIG_KEXEC_VERIFY_SIG)
+		if (IS_ENABLED(CONFIG_KEXEC_SIG)
 		    && arch_ima_get_secureboot()) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;
-- 
2.23.0.rc1.153.gdeed80330f-goog

