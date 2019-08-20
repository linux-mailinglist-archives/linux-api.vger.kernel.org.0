Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE995256
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbfHTASa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:18:30 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:44826 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbfHTAS3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:18:29 -0400
Received: by mail-pf1-f201.google.com with SMTP id j22so3523514pfe.11
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2LlLKA7xilo57KgJ9aBUFbPNJv3YWGuiG9UEU7t1Rzg=;
        b=dNREMDP+TG2C/LXVb2y5pqTvco3iRS0dhBeVXMI8yStBmDaDACn0KU8WoFg0ZtiOXp
         +1T4zFY7wH7Hw2KCv+l3gjoQjRE/73lZVZEUW/AxAXh5v8A/u/MA69OZI3mABCI5gjeV
         HrllyORU7+ymSitKrwkt1XKnOTXejRQnccT/TflwDunzx9Gwi8xnTdCF/J87R4Dcn7wJ
         zhSsHEU1M6/OXOYC0CsCHnWyZYtewSK+4HWUGPTxGmxYYU+8IZ8m4D7NiVEtuaekKsia
         XKn86Aw95n02in30KWH/5BMISqdYFuHokAcKWfBMQBNqA6fB+Me65VVB9TyV7Q/5MjKD
         Zmqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2LlLKA7xilo57KgJ9aBUFbPNJv3YWGuiG9UEU7t1Rzg=;
        b=LC2F9E/Zmok+ASeW3gG9mEMfNfK+35iw9yCRczKrcXZ0HQBFwoYxnTMZ81NSXj2Lac
         uAhpfGqMXjbIgHgnMZ+XS+CdvCP1q57voCGHeSod6C6Y7LiRDjfWpuU25Q9tJtEiuw4n
         W6qpR0sWzcPX8xZxf8WlW/2k+uaoPj2SOkXwSb/3h245Xj3p0jMx192PG7OlWVpZ3AiX
         HWEpcM60q5/VvTqu4+YAl14NTJ1kf6FawuNb8Myh+aDq/oD2vevUBi5XCcTA3qWuS2v0
         A2lpzK7WoAeobxZ1Sy7VZJ200ARq3k3ndFW7PTxRNssptwPIewP5FuaLRI/2dFx23Uzh
         4IFA==
X-Gm-Message-State: APjAAAVoTOnB546rMQbc1khjHwJ3ZEzseELCf7PnVJkoRvl3dKhDndeB
        9nYGakcw6xvbbX1XOf/4K8R3VQMQihU8JzBFnHLqEA==
X-Google-Smtp-Source: APXvYqys7jvt/D4+3SJ797I1FFI7U+j4sGn8mLnpJ7BQ8OG5PHg/+H0I5jr+bCp39lsh1kkHfvuUfXaGpWqewAvzA3nz+w==
X-Received: by 2002:a63:5b52:: with SMTP id l18mr22232462pgm.21.1566260308483;
 Mon, 19 Aug 2019 17:18:28 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:43 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 07/29] lockdown: Copy secure_boot flag in boot params
 across kexec reboot
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
Signed-off-by: James Morris <jmorris@namei.org>
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index f03237e3f192..5d64a22f99ce 100644
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
2.23.0.rc1.153.gdeed80330f-goog

