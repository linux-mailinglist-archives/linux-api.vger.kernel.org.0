Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 954187DDB7
	for <lists+linux-api@lfdr.de>; Thu,  1 Aug 2019 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfHAOWM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 1 Aug 2019 10:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbfHAOWM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 1 Aug 2019 10:22:12 -0400
Received: from linux-8ccs (unknown [95.90.219.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FD3420644;
        Thu,  1 Aug 2019 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564669331;
        bh=vULIrOd1ehcCy4iM3E99fM48cHPr2vPexsYqFK5z9tg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDdVcPmOglb7VfOP3ACFpX1kDMti1QwBqkMqLxaKnT4R3WQiUUHuj+2YIN68LUqeG
         GVgGvf4AHcaBiytwRlmXp9MIenKq4hzTKLUvTYqdTm1zWSBt3LlOk0nu6YK3yNjXZo
         qaXM61xDgz5cbbwCNNzfd2CKwbhnfHRAn7O/6640=
Date:   Thu, 1 Aug 2019 16:21:58 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V37 04/29] Enforce module signatures if the kernel is
 locked down
Message-ID: <20190801142157.GA5834@linux-8ccs>
References: <20190731221617.234725-1-matthewgarrett@google.com>
 <20190731221617.234725-5-matthewgarrett@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190731221617.234725-5-matthewgarrett@google.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+++ Matthew Garrett [31/07/19 15:15 -0700]:
>From: David Howells <dhowells@redhat.com>
>
>If the kernel is locked down, require that all modules have valid
>signatures that we can verify.
>
>I have adjusted the errors generated:
>
> (1) If there's no signature (ENODATA) or we can't check it (ENOPKG,
>     ENOKEY), then:
>
>     (a) If signatures are enforced then EKEYREJECTED is returned.
>
>     (b) If there's no signature or we can't check it, but the kernel is
>	 locked down then EPERM is returned (this is then consistent with
>	 other lockdown cases).
>
> (2) If the signature is unparseable (EBADMSG, EINVAL), the signature fails
>     the check (EKEYREJECTED) or a system error occurs (eg. ENOMEM), we
>     return the error we got.
>
>Note that the X.509 code doesn't check for key expiry as the RTC might not
>be valid or might not have been transferred to the kernel's clock yet.
>
> [Modified by Matthew Garrett to remove the IMA integration. This will
>  be replaced with integration with the IMA architecture policy
>  patchset.]
>
>Signed-off-by: David Howells <dhowells@redhat.com>
>Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
>Reviewed-by: Kees Cook <keescook@chromium.org>
>Cc: Jessica Yu <jeyu@kernel.org>
>---
> include/linux/security.h     |  1 +
> kernel/module.c              | 37 +++++++++++++++++++++++++++++-------
> security/lockdown/lockdown.c |  1 +
> 3 files changed, 32 insertions(+), 7 deletions(-)
>
>diff --git a/include/linux/security.h b/include/linux/security.h
>index 54a0532ec12f..8e70063074a1 100644
>--- a/include/linux/security.h
>+++ b/include/linux/security.h
>@@ -103,6 +103,7 @@ enum lsm_event {
>  */
> enum lockdown_reason {
> 	LOCKDOWN_NONE,
>+	LOCKDOWN_MODULE_SIGNATURE,
> 	LOCKDOWN_INTEGRITY_MAX,
> 	LOCKDOWN_CONFIDENTIALITY_MAX,
> };
>diff --git a/kernel/module.c b/kernel/module.c
>index cd8df516666d..318209889e26 100644
>--- a/kernel/module.c
>+++ b/kernel/module.c
>@@ -2771,8 +2771,9 @@ static inline void kmemleak_load_module(const struct module *mod,
> #ifdef CONFIG_MODULE_SIG
> static int module_sig_check(struct load_info *info, int flags)
> {
>-	int err = -ENOKEY;
>+	int err = -ENODATA;
> 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
>+	const char *reason;
> 	const void *mod = info->hdr;
>
> 	/*
>@@ -2787,16 +2788,38 @@ static int module_sig_check(struct load_info *info, int flags)
> 		err = mod_verify_sig(mod, info);
> 	}
>
>-	if (!err) {
>+	switch (err) {
>+	case 0:
> 		info->sig_ok = true;
> 		return 0;
>-	}
>
>-	/* Not having a signature is only an error if we're strict. */
>-	if (err == -ENOKEY && !is_module_sig_enforced())
>-		err = 0;
>+		/* We don't permit modules to be loaded into trusted kernels
>+		 * without a valid signature on them, but if we're not
>+		 * enforcing, certain errors are non-fatal.
>+		 */
>+	case -ENODATA:
>+		reason = "Loading of unsigned module";
>+		goto decide;
>+	case -ENOPKG:
>+		reason = "Loading of module with unsupported crypto";
>+		goto decide;
>+	case -ENOKEY:
>+		reason = "Loading of module with unavailable key";
>+	decide:
>+		if (is_module_sig_enforced()) {
>+			pr_notice("%s is rejected\n", reason);
>+			return -EKEYREJECTED;
>+		}
>
>-	return err;
>+		return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
>+
>+		/* All other errors are fatal, including nomem, unparseable
>+		 * signatures and signature check failures - even if signatures
>+		 * aren't required.
>+		 */
>+	default:
>+		return err;
>+	}
> }
> #else /* !CONFIG_MODULE_SIG */
> static int module_sig_check(struct load_info *info, int flags)

Hi Matthew!

Apologies if this was addressed in another patch in your series (I've
only skimmed the first few), but what should happen if the kernel is
locked down, but CONFIG_MODULE_SIG=n? Or shouldn't CONFIG_SECURITY_LOCKDOWN_LSM
depend on CONFIG_MODULE_SIG? Otherwise I think we'll end up calling
the empty !CONFIG_MODULE_SIG module_sig_check() stub even though
lockdown is enabled.


Thanks,

Jessica

>diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
>index d30c4d254b5f..2c53fd9f5c9b 100644
>--- a/security/lockdown/lockdown.c
>+++ b/security/lockdown/lockdown.c
>@@ -18,6 +18,7 @@ static enum lockdown_reason kernel_locked_down;
>
> static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
> 	[LOCKDOWN_NONE] = "none",
>+	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
> 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
> 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
> };
>-- 
>2.22.0.770.g0f2c4a37fd-goog
>
