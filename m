Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD9085720
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 02:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbfHHAJh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 7 Aug 2019 20:09:37 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:42708 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389353AbfHHAHn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Aug 2019 20:07:43 -0400
Received: by mail-qt1-f202.google.com with SMTP id e22so18206935qtp.9
        for <linux-api@vger.kernel.org>; Wed, 07 Aug 2019 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=AQ32ZYFy04wA4mb2XkzJMu41uBwdTPJVCQkZLoSqoG5BPESh7PtahcJElB42fN7yCa
         RgpAdVhcQ5fuL4/xbllTjDfI2lyqus7qV8tRpcqdDJ/VX1SpE4XMZ3HvF0pfgCWIcmbA
         Zz9a2qpUoHBQ5fw1br+vqmDeXDCgSck943n71lbq0K8fl99KDPL9Cr+apC6baNZBDpqB
         yetG9rfVr7XgiWV+oEMuvXWmxki7WHMWAVAgsDWQ3kUNYceMtvrIEGX+u90sxOg52+xU
         WwDTm3LZ/jev4cFV6SJG2fghnPLj1QbrnL9bCZ9OKuqjQneM4UxIH4SbmaYnC+fTKyUe
         xoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I/5rlFVBONd1Ka7/QUlhE63dhV+4TxEgC7HKPRr7Vsc=;
        b=gV8/w5ufCbkUzTQ8Nw+13JqnvpinP4HVAF5sq57/iSF5Wa3U5jL5yqnrf3RWXhGgGS
         k3iqSJ9ZFfiDWiiweGxs9vTkpgSYbSYUb8+1rbIDwSERyNtX3Qf8fdU0DzdcsqvKDWMw
         3Cyb9b5rWPBVf1WJ1gV31estmdw4WH++JKpcnOxVciutuftTX3zYtgSb7IhcZS6NaaPp
         ySAnlAcss14PImFEl56mbSrajaxSfdq636coXiloD77zrabvCMWQxPFSWeM2wj3fmBF0
         enGafgqUBVF2tY+bG1F1387HlFFNkIXL83h0FRvleyLd7wQyf8aIUv5UA/XdcXFnpJ+k
         dQrg==
X-Gm-Message-State: APjAAAXtpd9050MCRCuDBI39UYe6ow3/+3DrvsSOzRweZbr4BDVYh4k9
        d7ENmxkqfcXQdl9/bL++DDKuy9LMpEdENS6rM2x7pA==
X-Google-Smtp-Source: APXvYqwbxMXMHnAWnMCnOqh54UKVOkglSwlrJqk2yQseIK/mHSAACIPxF2yMxL4MhNvEpmU0x5PUPo+FVwhaY2V8uK4ABw==
X-Received: by 2002:a0c:eec2:: with SMTP id h2mr10594442qvs.189.1565222862448;
 Wed, 07 Aug 2019 17:07:42 -0700 (PDT)
Date:   Wed,  7 Aug 2019 17:06:59 -0700
In-Reply-To: <20190808000721.124691-1-matthewgarrett@google.com>
Message-Id: <20190808000721.124691-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
Subject: [PATCH V38 07/29] Copy secure_boot flag in boot params across kexec reboot
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
2.22.0.770.g0f2c4a37fd-goog

