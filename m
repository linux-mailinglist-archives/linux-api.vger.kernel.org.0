Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFE04DEAA
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfFUBWL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:22:11 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:48380 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfFUBUI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:08 -0400
Received: by mail-pf1-f202.google.com with SMTP id u21so3241527pfn.15
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2dHU4Tub8Mw51WubQY0+f1WFuiV7G7JVcg3MNEWFHGI=;
        b=DcoLgEt5A4OXMMxB3KsPyPjlVq8a9yZ/1rcZyg2Gsl7fBvGHwQOiqHiovRrhxfQPC2
         bftopU//yMze+/rWMpRCa89ueElnT/VCGJfGg24Tn5eaXCyP9i5GCjCtx157oQg+1y70
         FEcGN5wxf3gGSS+PqdDFhVeiseElKeK8q8HcMq0d5PObKNgjOulcRhdKIWSxFnGHr8lG
         wKmwNb3qG2+nDV7FyIVoTxsR6YVgIPvMmW4NjmYdtCF3fWCY06+dzCzjT9UgyhEhLRmi
         v5eM940kQGLdKD1y2WU1H8R33pDlGGMeym8UeFcmlfFtQrMQoomcdF56Z3V5sYM9uD+z
         StNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2dHU4Tub8Mw51WubQY0+f1WFuiV7G7JVcg3MNEWFHGI=;
        b=XsXbulbvW4p31SD8MHMqwloqsO8Gx7VDS8Mt4pxs6ex+0gFzd+zR1w4qcTyGaNZK2b
         c2PDlomd9BIJQXOe97BY24nnT+SO1fHMKunNi3QuQtJ5C716xNcyQ00NMTI0cx/KKFBA
         O9bd9sN9K/RpQK2xjVsrqcX+7DKnmhq1shGGEyiFE7LLzhTxVt5ZGhtBloxosUZPnOsn
         IpmXQYP5lppTDd1GKiFuNfaDyPSTEYPkVK3c03r0SnokLIIdAXTkcCUeULCyMb0nytrl
         oIfC0S7Yk7XgbUBymqwdgUpsOnc2h693MREV9DnaDjXOmab7PMLEiIirrbu3tN7i7CHN
         Xbcw==
X-Gm-Message-State: APjAAAXWUquQl6Qv7+EqtR0CTGH1HLDVLdKJi2a/ejGOLNyjXqzmR+Gz
        KfdxzcjSLUD5qaigXUC8ehA67MdkM+iEMyzssQCVGw==
X-Google-Smtp-Source: APXvYqyiDaucN95L+jPq8JOLfXO3N68mJWteHAXK6z5jdCpWFQP31Oeacqz73UyrdLsXQOnIdoOsumhQ5iANNAi6WUG3bg==
X-Received: by 2002:a63:595e:: with SMTP id j30mr14535261pgm.2.1561080006823;
 Thu, 20 Jun 2019 18:20:06 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:19 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-9-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 08/30] kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG
 and KEXEC_SIG_FORCE
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Jiri Bohac <jbohac@suse.cz>,
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

 (2) kexec fails with EKEYREJECTED and logs an appropriate message if
     signature checking is enforced and an signature is not found, uses
     unsupported crypto or has no matching key.

 (3) kexec fails with EKEYREJECTED if there is a signature for which we
     have a key, but signature doesn't match - even if in non-forcing mode.

 (4) kexec fails with EBADMSG or some other error if there is a signature
     which cannot be parsed - even if in non-forcing mode.

 (5) kexec fails with ELIBBAD if the PE file cannot be parsed to extract
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
 kernel/kexec_file.c                    | 48 ++++++++++++++++++++++----
 4 files changed, 61 insertions(+), 15 deletions(-)

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
index f1d0e00a3971..67f3a866eabe 100644
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
 
@@ -207,15 +208,48 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
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
+			ret = -EKEYREJECTED;
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

