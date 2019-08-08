Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6CD8571E
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbfHHAJb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:09:31 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:41400 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389504AbfHHAHp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:07:45 -0400
Received: by mail-pf1-f201.google.com with SMTP id q14so57849201pff.8
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0e260YowI9CRqgpWSZnFK5vaM3jseidaVbkh9lNaqp8=;
        b=aQ4wn3P9fS1u1ewjS8eJttkaghjcu/R7h1tnuxyy/xeWvKDpKhjRvgSO7RrLNEHUMU
         LED5o+fo7q5eEFGAl73Pz60kkKwy/GrW8qw1oEV2SHeE2sI7LIQ4aAFc63hmJEjqA8m4
         VT4HU+lTU2wrfeWBNWy8WDDHjMcqhXhNl83ARfBqIbLW0IPeWRAKV5IJJlCrz2yppmDS
         aULni2rAGpooCIwkn1sqHk0efejrXxf7Mr71tkaQJTJ1IG31RD4g4dKGErCCu1TQy4t9
         qw8Ok6B7ti9N0+AqXpyBmDQcEx/zO20mRtWnibGRBhWH8hWl9LVRKnBMyU0RT5aVX/6n
         NSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0e260YowI9CRqgpWSZnFK5vaM3jseidaVbkh9lNaqp8=;
        b=J5ullXB3q/GZmf/SCroNfScn7dHHI9XRO8GaNXPxH9aA9uMgHVyFsAkcn8FbknhUzL
         9Sw0Oc837cN7O/nudEtFHfYJZOaTbdXMxH+7teXqky+M3qGY07yUhptuv0atSb81Ix3s
         zWxgSmjfU4NUwxWqStDTAzVGePHj149FoNjsghXl+aOMPS7vT53kfHg6Cyy9eZFahOh4
         90YLbr1imotrULRGxE9yjVH3+Hqha0BS0GOlGaA3jgFJssiMkY22zH+MkW0e+vo+8O7y
         cXqVqHFt1dLz1viHuE3diOO3iOyD5A9bESlFz8CpBeHz+CQYXlWlVwZb9XE/49lQZWfd
         s7EA==
X-Gm-Message-State: APjAAAUyizUBPZY3mEdQ+daFV3TFwzxyEq6oDH1TbPggbhnbGJr5/7KP
        hhpbEvFkH0fQ4mzu/LDoxAIBhDW8+pDKnDrlE821wQ==
X-Google-Smtp-Source: APXvYqwZ4ajQSAuE3qXrhA8Gc7seQj1zeG29UnjPxKFv05XUEhTP1zFNAl6GAxE4FJArwTQ46bx/Ulzzlgi1s4LMx+ZfwQ==
X-Received: by 2002:a63:f926:: with SMTP id h38mr10014401pgi.80.1565222864875;
 Wed, 07 Aug 2019 17:07:44 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:07:00 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 08/29] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG
 and KEXEC_SIG_FORCE
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jiri Bohac <jbohac@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org
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
Reviewed-by: Jiri Bohac <jbohac@suse.cz>
Reviewed-by: Dave Young <dyoung@redhat.com>
cc: kexec@lists.infradead.org
---
 arch/x86/Kconfig                       | 20 +++++++++----
 crypto/asymmetric_keys/verify_pefile.c |  4 ++-
 include/linux/kexec.h                  |  4 +--
 kernel/kexec_file.c                    | 41 ++++++++++++++++++++++----
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 05e78acb187c..fd2cd4f861cc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2032,20 +2032,30 @@ config KEXEC_FILE
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
index 305f6a5ca4fe..998f77c3a0e1 100644
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
index b8cc032d5620..875482c34154 100644
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
@@ -186,7 +186,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 			     const char __user *cmdline_ptr,
 			     unsigned long cmdline_len, unsigned flags)
 {
-	int ret = 0;
+	const char *reason;
+	int ret;
 	void *ldata;
 	loff_t size;
 
@@ -202,14 +203,42 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
 	if (ret)
 		goto out;
 
-#ifdef CONFIG_KEXEC_VERIFY_SIG
+#ifdef CONFIG_KEXEC_SIG
 	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
 					   image->kernel_buf_len);
-	if (ret) {
-		pr_debug("kernel signature verification failed.\n");
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
 #endif
 	/* It is possible that there no initramfs is being loaded */
 	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
-- 
2.22.0.770.g0f2c4a37fd-goog

