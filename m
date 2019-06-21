Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44C594DEAB
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfFUBWQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:22:16 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43969 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfFUBUF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:20:05 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so2664772plo.10
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YHpf3S+LawhmDVzX+FQxCcCkHwySWAOsiAjcN5bQy70=;
        b=dq5dOVkTOdSfd0FozM7Ov5Two6lGpbsR9AIOljld75nkqE2lD/l+iezTZzt+6Y1dad
         ajewcxBR5TXOQ2MN7iZdTNQcKQW9uSzqEeRy2TCvlLe9cj2jtJKL0nXIRKVLMPXn2emB
         GtlmnJlfE10Ez4ixgSaP1hoFApm53GG9eyXdFrREvn58r656tGslWsX0Hzvrop1nrH2b
         3a1jUtUphr7GGQa/goikEO0OK1cRwDXw0GkKAckn+gZ+UCDSsYc+yUAE7L08JYQOux9R
         0ilcy8SDSxFLe0XGp982UV2SduOe5LFmh5WpOqpQsk9rt6Rcsh+IrCa9OezND7wkz/E9
         3oCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YHpf3S+LawhmDVzX+FQxCcCkHwySWAOsiAjcN5bQy70=;
        b=PsFOsXW60zdCUPyWQcVM1jyKiTYGoFXESEzT+0gVIqk5u9c7T/M71AVBwDXdZBr/lN
         teBDNYA7vHKvDqKBx1B2wPYSJtSQTZ8cv+DQSFwC5zv2uJkG1V9py6UEszVbx5S7coW1
         iqZJNW2mGhr2+MwcBDmG7N45i4HvHD3/ZLER0uLXAaFprq61yfneC+p361po0J7W83qf
         OGGhX++pPYPofociUIKYKk25ohr1AOnJK1BagWY9Nd7VQuqEpxJvnhdkCLazWEnkDyQc
         jeIZ8oD2ci5nvKlieuycyVNg3WnRfcoj1SS86+a5595eoBPRikyEhRSSFevl/h+WdG0E
         o0sQ==
X-Gm-Message-State: APjAAAUfZ6GxZEdZg5fJkKKVWYXgkbef3Y9O7Ew/musts68ThDQgKm1q
        xE4rud1ADNNneoDG2soUMzLParLYb/OVKGa0R6HKxQ==
X-Google-Smtp-Source: APXvYqz/OQUUp0959AnAoGMtRG/cQFqGYBYMlIWvKDLKvTKI+fS5zJyEZlJutm42bS3uVQCm+ZHnp+17hJOPftREHMlZYA==
X-Received: by 2002:a63:757:: with SMTP id 84mr4150003pgh.288.1561080004266;
 Thu, 20 Jun 2019 18:20:04 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:18 -0700
In-Reply-To: <20190621011941.186255-1-matthewgarrett@google.com>
Message-Id: <20190621011941.186255-8-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 07/30] Copy secure_boot flag in boot params across kexec reboot
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>, kexec@lists.infradead.org
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
cc: kexec@lists.infradead.org
---
 arch/x86/kernel/kexec-bzimage64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 22f60dd26460..4243359ac509 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -182,6 +182,7 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
 	if (efi_enabled(EFI_OLD_MEMMAP))
 		return 0;
 
+	params->secure_boot = boot_params.secure_boot;
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
 	ei->efi_systab_hi = current_ei->efi_systab_hi;
-- 
2.22.0.410.gd8fdbe21b5-goog

