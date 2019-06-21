Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 478134E086
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 08:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfFUGeO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Jun 2019 02:34:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfFUGeO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 Jun 2019 02:34:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F27781E05;
        Fri, 21 Jun 2019 06:34:13 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-101.pek2.redhat.com [10.72.12.101])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6005660852;
        Fri, 21 Jun 2019 06:34:06 +0000 (UTC)
Date:   Fri, 21 Jun 2019 14:34:02 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, Jiri Bohac <jbohac@suse.cz>,
        linux-api@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        luto@kernel.org
Subject: Re: [PATCH V31 06/25] kexec_file: split KEXEC_VERIFY_SIG into
 KEXEC_SIG and KEXEC_SIG_FORCE
Message-ID: <20190621063402.GA4528@localhost.localdomain>
References: <20190326182742.16950-1-matthewgarrett@google.com>
 <20190326182742.16950-7-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326182742.16950-7-matthewgarrett@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 21 Jun 2019 06:34:13 +0000 (UTC)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 03/26/19 at 11:27am, Matthew Garrett wrote:
> From: Jiri Bohac <jbohac@suse.cz>
> 
> This is a preparatory patch for kexec_file_load() lockdown.  A locked down
> kernel needs to prevent unsigned kernel images from being loaded with
> kexec_file_load().  Currently, the only way to force the signature
> verification is compiling with KEXEC_VERIFY_SIG.  This prevents loading
> usigned images even when the kernel is not locked down at runtime.
> 
> This patch splits KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE.
> Analogous to the MODULE_SIG and MODULE_SIG_FORCE for modules, KEXEC_SIG
> turns on the signature verification but allows unsigned images to be
> loaded.  KEXEC_SIG_FORCE disallows images without a valid signature.
> 
> [Modified by David Howells such that:
> 
>  (1) verify_pefile_signature() differentiates between no-signature and
>      sig-didn't-match in its returned errors.
> 
>  (2) kexec fails with EKEYREJECTED and logs an appropriate message if
>      signature checking is enforced and an signature is not found, uses
>      unsupported crypto or has no matching key.
> 
>  (3) kexec fails with EKEYREJECTED if there is a signature for which we
>      have a key, but signature doesn't match - even if in non-forcing mode.
> 
>  (4) kexec fails with EBADMSG or some other error if there is a signature
>      which cannot be parsed - even if in non-forcing mode.
> 
>  (5) kexec fails with ELIBBAD if the PE file cannot be parsed to extract
>      the signature - even if in non-forcing mode.
> 
> ]
> 
> Signed-off-by: Jiri Bohac <jbohac@suse.cz>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Reviewed-by: Jiri Bohac <jbohac@suse.cz>
> cc: kexec@lists.infradead.org
> ---
>  arch/x86/Kconfig                       | 20 ++++++++---
>  crypto/asymmetric_keys/verify_pefile.c |  4 ++-
>  include/linux/kexec.h                  |  4 +--
>  kernel/kexec_file.c                    | 48 ++++++++++++++++++++++----
>  4 files changed, 61 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 4b4a7f32b68e..735d04a4b18f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -2016,20 +2016,30 @@ config KEXEC_FILE
>  config ARCH_HAS_KEXEC_PURGATORY
>  	def_bool KEXEC_FILE
>  
> -config KEXEC_VERIFY_SIG
> +config KEXEC_SIG
>  	bool "Verify kernel signature during kexec_file_load() syscall"
>  	depends on KEXEC_FILE
>  	---help---
> -	  This option makes kernel signature verification mandatory for
> -	  the kexec_file_load() syscall.
>  
> -	  In addition to that option, you need to enable signature
> +	  This option makes the kexec_file_load() syscall check for a valid
> +	  signature of the kernel image.  The image can still be loaded without
> +	  a valid signature unless you also enable KEXEC_SIG_FORCE, though if
> +	  there's a signature that we can check, then it must be valid.
> +
> +	  In addition to this option, you need to enable signature
>  	  verification for the corresponding kernel image type being
>  	  loaded in order for this to work.
>  
> +config KEXEC_SIG_FORCE
> +	bool "Require a valid signature in kexec_file_load() syscall"
> +	depends on KEXEC_SIG
> +	---help---
> +	  This option makes kernel signature verification mandatory for
> +	  the kexec_file_load() syscall.
> +
>  config KEXEC_BZIMAGE_VERIFY_SIG
>  	bool "Enable bzImage signature verification support"
> -	depends on KEXEC_VERIFY_SIG
> +	depends on KEXEC_SIG
>  	depends on SIGNED_PE_FILE_VERIFICATION
>  	select SYSTEM_TRUSTED_KEYRING
>  	---help---
> diff --git a/crypto/asymmetric_keys/verify_pefile.c b/crypto/asymmetric_keys/verify_pefile.c
> index d178650fd524..4473cea1e877 100644
> --- a/crypto/asymmetric_keys/verify_pefile.c
> +++ b/crypto/asymmetric_keys/verify_pefile.c
> @@ -100,7 +100,7 @@ static int pefile_parse_binary(const void *pebuf, unsigned int pelen,
>  
>  	if (!ddir->certs.virtual_address || !ddir->certs.size) {
>  		pr_debug("Unsigned PE binary\n");
> -		return -EKEYREJECTED;
> +		return -ENODATA;
>  	}
>  
>  	chkaddr(ctx->header_size, ddir->certs.virtual_address,
> @@ -408,6 +408,8 @@ static int pefile_digest_pe(const void *pebuf, unsigned int pelen,
>   *  (*) 0 if at least one signature chain intersects with the keys in the trust
>   *	keyring, or:
>   *
> + *  (*) -ENODATA if there is no signature present.
> + *
>   *  (*) -ENOPKG if a suitable crypto module couldn't be found for a check on a
>   *	chain.
>   *
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index b9b1bc5f9669..58b27c7bdc2b 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -125,7 +125,7 @@ typedef void *(kexec_load_t)(struct kimage *image, char *kernel_buf,
>  			     unsigned long cmdline_len);
>  typedef int (kexec_cleanup_t)(void *loader_data);
>  
> -#ifdef CONFIG_KEXEC_VERIFY_SIG
> +#ifdef CONFIG_KEXEC_SIG
>  typedef int (kexec_verify_sig_t)(const char *kernel_buf,
>  				 unsigned long kernel_len);
>  #endif
> @@ -134,7 +134,7 @@ struct kexec_file_ops {
>  	kexec_probe_t *probe;
>  	kexec_load_t *load;
>  	kexec_cleanup_t *cleanup;
> -#ifdef CONFIG_KEXEC_VERIFY_SIG
> +#ifdef CONFIG_KEXEC_SIG
>  	kexec_verify_sig_t *verify_sig;
>  #endif
>  };
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1d0e00a3971..67f3a866eabe 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -90,7 +90,7 @@ int __weak arch_kimage_file_post_load_cleanup(struct kimage *image)
>  	return kexec_image_post_load_cleanup_default(image);
>  }
>  
> -#ifdef CONFIG_KEXEC_VERIFY_SIG
> +#ifdef CONFIG_KEXEC_SIG
>  static int kexec_image_verify_sig_default(struct kimage *image, void *buf,
>  					  unsigned long buf_len)
>  {
> @@ -188,7 +188,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			     const char __user *cmdline_ptr,
>  			     unsigned long cmdline_len, unsigned flags)
>  {
> -	int ret = 0;
> +	const char *reason;
> +	int ret;
>  	void *ldata;
>  	loff_t size;
>  
> @@ -207,15 +208,48 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	if (ret)
>  		goto out;
>  
> -#ifdef CONFIG_KEXEC_VERIFY_SIG
> +#ifdef CONFIG_KEXEC_SIG
>  	ret = arch_kexec_kernel_verify_sig(image, image->kernel_buf,
>  					   image->kernel_buf_len);
> -	if (ret) {
> -		pr_debug("kernel signature verification failed.\n");
> +#else
> +	ret = -ENODATA;
> +#endif
> +
> +	switch (ret) {
> +	case 0:
> +		break;
> +
> +		/* Certain verification errors are non-fatal if we're not
> +		 * checking errors, provided we aren't mandating that there
> +		 * must be a valid signature.
> +		 */
> +	case -ENODATA:
> +		reason = "kexec of unsigned image";
> +		goto decide;
> +	case -ENOPKG:
> +		reason = "kexec of image with unsupported crypto";
> +		goto decide;
> +	case -ENOKEY:
> +		reason = "kexec of image with unavailable key";
> +	decide:
> +		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)) {
> +			pr_notice("%s rejected\n", reason);
> +			ret = -EKEYREJECTED;

Force use -EKEYREJECTED is odd,  why not just use original "ret"?

> +			goto out;
> +		}
> +
> +		ret = 0;
> +		break;
> +
> +		/* All other errors are fatal, including nomem, unparseable
> +		 * signatures and signature check failures - even if signatures
> +		 * aren't required.
> +		 */
> +	default:
> +		pr_notice("kernel signature verification failed (%d).\n", ret);
>  		goto out;
>  	}
> -	pr_debug("kernel signature verification successful.\n");
> -#endif
> +
>  	/* It is possible that there no initramfs is being loaded */
>  	if (!(flags & KEXEC_FILE_NO_INITRAMFS)) {
>  		ret = kernel_read_file_from_fd(initrd_fd, &image->initrd_buf,
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec

Thanks
Dave
