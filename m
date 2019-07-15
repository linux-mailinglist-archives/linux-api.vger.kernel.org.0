Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1701C69C3E
	for <lists+linux-api@lfdr.de>; Mon, 15 Jul 2019 22:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730964AbfGOUCd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 15 Jul 2019 16:02:33 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:34424 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbfGOUAM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 15 Jul 2019 16:00:12 -0400
Received: by mail-pf1-f202.google.com with SMTP id i2so10860818pfe.1
        for <linux-api@vger.kernel.org>; Mon, 15 Jul 2019 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=AxSl7ByC571hgB4NOLtS7SsxUTZj2nJz1kjFEvu6QXZNWkTAq4ckIZ3uMUWLg+omXa
         gQCF60SO+5FhvuloODfitEKxnqK2Ud9Ke7Ut2KXrASynck2/yJDhEmUCv/SiCL/LnS6Z
         foFn7LR0MludcBbwvt/rK79Awp3YN1kE+UStUw6ZmdDsTm4ffGswjufyLrxfXF6AE/NN
         7a+spbgSULZAlT5LjRxTXyiyoO5QMa8kyRslayysR0pLUMt4Sna3aoVdhhA3DgT6uj94
         DwwivdBwt/SuDS6eAWJhtbrGn7o2yongnexmhT6mrymBMoRm2BEZbfvlnh4PW+U/EQ41
         XlvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ze1m51/U9qyeKdYZTkURxXHO7/2Jq1vWiS2UsV2hr9c=;
        b=RHnblrwo20QQ0MX+2Ulx4skDKTnJE1SM/G17xsTR2/mpgp81BcL/Q85DNlCzWNz9mi
         mpmm/b2z+SDXASsHniRAAri1njurE/+YcEwyY74XMrGZYSZ88CMzmVCaIhKgwUfjMxcB
         /sPuoS9fmNnyMu8WkRUHpjejRdTdQaB7rhjzNZV0A95UZF7X73nsDQXisOwPJnBPHmIj
         +BLXE8oZIvKqkSQ0RtU8o7GDUbF9kcRWb5QOVG9iQ6/NaYPCGCgNxeoewygilBu6xTbU
         zNXrzrEDCICuHyGwqpLbyYv6EddphazRASll7ntmyX32zYwdz8SlyBr2/HddV8xfd/7L
         NnhA==
X-Gm-Message-State: APjAAAVGvrSEX5lOP4P28gTNJnsFC1frMr7FCyfsX42wHYVJTMbXK3+N
        J41PMQNdFz3/Q8Y7CCyIs7C/DN1qv6xnur0n++C0ZQ==
X-Google-Smtp-Source: APXvYqw3kz8vxqJr04RTj1gLbL27dI8ApTISQuqjlO54p7acDyqHccEy7zqlCPthKqcQRy7/95xxR7ZdHBOEJmGBPjFQUA==
X-Received: by 2002:a63:2ad5:: with SMTP id q204mr15899633pgq.140.1563220811612;
 Mon, 15 Jul 2019 13:00:11 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:59:24 -0700
In-Reply-To: <20190715195946.223443-1-matthewgarrett@google.com>
Message-Id: <20190715195946.223443-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190715195946.223443-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.510.g264f2c817a-goog
Subject: [PATCH V35 07/29] Copy secure_boot flag in boot params across kexec reboot
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

