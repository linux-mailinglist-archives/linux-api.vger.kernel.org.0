Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B067C6D4FF
	for <lists+linux-api@lfdr.de>; Thu, 18 Jul 2019 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391576AbfGRToi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 18 Jul 2019 15:44:38 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:40733 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391569AbfGRToi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 18 Jul 2019 15:44:38 -0400
Received: by mail-pg1-f202.google.com with SMTP id m19so2807642pgv.7
        for <linux-api@vger.kernel.org>; Thu, 18 Jul 2019 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=gJjhUT6gQ/zQNCY6elSDV6M1tQCeC0P5Tp4UAQyfBx3bH4p1ifDoKIdCUkhGhE/+gg
         1BYrEJUjZpq1lci7thr1J+jRZPv78zvcXe0wmCNbM+HBWEYXopMbBeSzpPtfVoUzVLk3
         pujXzLMr6fRScyxTI3Haqr4j2hTxpLfQ6HsQowNOgyplYLOfo3yUrKFDJokCeo5/2PKy
         FwUf46Shg+19/eA24HYXmwakU6FgvCH1rsx/twSxIE8e9p1SMqOpYC5sjsn8o8C0psq/
         OjMiRQ74r0yKmCrXaugmRON5LDzCp9Ky2OgcvlOWQFtleomMDWsvtTmBy0Cz29VGfC9M
         iF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=f0B0niHkwbteVtNNEcf4fEA55Nqfl8eTIyWRPkDtNgEcXT6JOomzX9oieClteE44aI
         5ZDVB5/vwckR66+ZZ3l3P4SoYnTwKeht5e1Sp9pSRU0Pa5dIXfIS5U0Y3/hAj4+fU+Nr
         ICuHcy1npRvObtddvOCYXBHsKsszAoBtIgSZvI5RbRrVNemm3cttLfwPTrJ23EiXeXRU
         t0Dn7/raNdOMbiPou3lUSQt8MgqUcIt0dVysKw+0F9eHFPsRESPwA8dRZ4qSPvpzA/wZ
         sSa4FqtamFG9qLGwRVLJW+9x63W78/3g09Mzm71RrZuMg9dv9C9cMv+XOVtKNB2vniIJ
         jgJg==
X-Gm-Message-State: APjAAAVyJ3V3b8Q11YWqWx6DCM0wsmfPof5fuASjG24qMfyD6bZt6eM9
        AKRppsVNnfVzk+RMB1kYvR7QKnV5g4e5+lBub6lOqA==
X-Google-Smtp-Source: APXvYqzrK8iF6hcgKRXBxAlD2H7TfZZ22Mkvge4q89mEFnRwAMWXxSRoqJN7TQmQtZur9PR4mpbHHV2qq0UGBlX+3fC93g==
X-Received: by 2002:a63:1950:: with SMTP id 16mr49329324pgz.312.1563479076972;
 Thu, 18 Jul 2019 12:44:36 -0700 (PDT)
Date:   Thu, 18 Jul 2019 12:43:53 -0700
In-Reply-To: <20190718194415.108476-1-matthewgarrett@google.com>
Message-Id: <20190718194415.108476-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190718194415.108476-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V36 07/29] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Kees Cook <keescook@chromium.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Dave Young <dyoung@redhat.com>

Kexec reboot in case secure boot being enabled does not keep the secure
boot mode in new kernel, so later one can load unsigned kernel via legacy
kexec_load.  In this state, the system is missing the protections provided
by secure boot.

Adding a patch to fix this by retain the secure_boot flag in original
kernel.

secure_boot flag in boot_params is set in EFI stub, but kexec bypasses the
stub.  Fixing this issue by copying secure_boot flag across kexec reboot.

Signed-off-by: Dave Young <dyoung@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
cc: kexec@lists.infradead.org
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 5ebcd02cbca7..d2f4e706a428 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -180,6 +180,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.22.0.510.g264f2c817a-goog

