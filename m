Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA88C4F22E
	for <lists+linux-api@lfdr.de>; Sat, 22 Jun 2019 02:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfFVAEY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 20:04:24 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:39472 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbfFVAEX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Jun 2019 20:04:23 -0400
Received: by mail-vk1-f202.google.com with SMTP id d14so3042332vka.6
        for <linux-api@vger.kernel.org>; Fri, 21 Jun 2019 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JmNS4ODZhP4tqRO/RxP5G6pk+LirfBLlUIpOIP1ejs0=;
        b=LrS/GEtxYSWy5V5lSSSkypawT3ziX+e+iwl5hyWr7WuoG+uOVxg3ENCp/E+0EKQ/m1
         wLh2rna6AGXIPRXSE6R9mFGSM76tar1Lnn1Qg4eY9u1OlIftNDOYR3k6BCL3vowUNBia
         r5TXGSS+gb68I4TajH8scxYIK/5CIGXE08f0ymCeet27fbhkjplLarU36pC4pO6EpVYE
         Nj5dUxdVfcCbiOc/BRQDB4+Iq90TRNGuiwd3V4BPQCCcbOts4XuOBBpDNmwhRNMeg8Y2
         4jjZp5j7lYfmnnYiDbiLk8Du01RGLYO95t6rOYz0U5bTSNGjZiM2kjbQOQuh9KqbVg9w
         zk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JmNS4ODZhP4tqRO/RxP5G6pk+LirfBLlUIpOIP1ejs0=;
        b=ROw1yvZnw1ry7+zfxjXOfD3wOJ+DVl2NiLfdxmWzCkpc3ilt1yPAm7fyKkrvZU2BxC
         FJhU56nH0j3XL4R7EQV/DKSYon9zvCQ+qMlrAF/2WrF56i1TO/Or3wb090bNWM2I412r
         nDRZDQbYlp6Z48ys0+zG5n7uVmeYansE+cmQ2E14ekGAemWzvTAQWcArOylZOSIVsmy+
         KCjw5PmkVblj4XoFrt8ap6TT4NIV+cwXHIPuKFKyMJm2IjTpnXErbVgndX14/LrTNaZK
         UwcyqCoE2Tg14k82DUB5xgIQo2aCW4VV6PXi8Wh4zXOLxoq6iveltjjgDdOkmVlzUVTC
         J/bQ==
X-Gm-Message-State: APjAAAXKLiMEZG3Wu9f0GeoV10NUeR5GK5aYRMK7k6aRbxaRZmTnxLau
        FyK2/b8ve6RfHRLRmFzAgMUflbT1bJrKuthz+SeyPA==
X-Google-Smtp-Source: APXvYqwo/PtymngVXtHoT30ArfHxZDBFk0n3Z8uFf75BZcfFo0WVOnqrdayTydmypSbRpZvs+wMC2pa5qpy3kfHvDHaQfg==
X-Received: by 2002:ab0:7848:: with SMTP id y8mr54058505uaq.58.1561161862038;
 Fri, 21 Jun 2019 17:04:22 -0700 (PDT)
Date:   Fri, 21 Jun 2019 17:03:37 -0700
In-Reply-To: <20190622000358.19895-1-matthewgarrett@google.com>
Message-Id: <20190622000358.19895-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190622000358.19895-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V34 08/29] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG
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

[Modified by David Howells such that:

 (1) verify_pefile_signature() differentiates between no-signature and
     sig-didn't-match in its returned errors.

 (2) kexec fails with EKEYREJECTED if there is a signature for which we
     have a key, but signature doesn't match - even if in non-forcing mode.

 (3) kexec fails with EBADMSG or some other error if there is a signature
     which cannot be parsed - even if in non-forcing mode.

 (4) kexec fails with ELIBBAD if the PE file cannot be parsed to extract
     the signature - even if in non-forcing mode.

]

Signed-off-by: Jiri Bohac <jbohac@suse.cz>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
cc: kexec@lists.infradead.org
---
 arch/x86/Kconfig                       | 20 ++++++++---
 crypto/asymmetric_keys/verify_pefile.c |  4 ++-
 include/linux/kexec.h                  |  4 +--
 kernel/kexec_file.c                    | 47 ++++++++++++++++++++++----
 4 files changed, 60 insertions(+), 15 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c1f9b3cf437c..84381dd60760 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2012,20 +2012,30 @@ config KEXEC_FILE
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
diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
index d178650fd524..4473cea1e877 100644
--- a/crypto/asymmetric_keys/verify_pefile.c
+++ b/crypto/asymmetric_keys/verify_pefile.c
@@ -100,7 +100,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
 
 	if (!ddir->certs.virtual_address || !ddir->certs.size) {
 		pr_debug("Unsigned PE binary\n");
-		return -EKEYREJECTED;
+		return -ENODATA;
 	}
 
 	chkaddr(ctx->header_size, ddir->certs.virtual_address,
@@ -408,6 +408,8 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
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
index f1d0e00a3971..eec7e5bb2a08 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -90,7 +90,7 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
 					  unsigned long buf_len)
 {
@@ -188,7 +188,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
 			     unsigned long cmdline_len, unsigned flags)
 {
-	int ret = 0;
+	const char *reason;
+	int ret;
 	void *ldata;
 	loff_t size;
 
@@ -207,15 +208,47 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
 					   image->kernel_buf_len);
-	if (ret) {
-		pr_debug("kernel signature verification failed.\n");
+#else
+	ret = -ENODATA;
+#endif
+
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
+			goto out;
+		}
+
+		ret = 0;
+		break;
+
+		/* All other errors are fatal, including nomem, unparseable
+		 * signatures and signature check failures - even if signatures
+		 * aren't required.
+		 */
+	default:
+		pr_notice("kernel signature verification failed (%d).\n", ret);
 		goto out;
 	}
-	pr_debug("kernel signature verification successful.\n");
-#endif
+
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
 		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
-- 
2.22.0.410.gd8fdbe21b5-goog

