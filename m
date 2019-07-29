Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D079C04
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfG2V6k (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:40 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56135 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730425AbfG2V6k (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:40 -0400
Received: by mail-wm1-f66.google.com with SMTP id a15so55190830wmj.5
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJkPu9y+gmExeCUpCA066mqgvfW2S/OqiamBX4Wlaac=;
        b=RQXI05dku4fJ8r2oqnqNf/9NtEAGKp/k38XUdulMZlu8JNkOLGaqwCBnGvnnefJhtt
         j0kSEsyUTnjhkOssr/JYXs4a9aVojBdgA1b7B3uxvYtTyssni/zvWB/AJj0aS1ze9Rbt
         iFooZfYAOfO3pQumT9mLGGg17rntF8nn0g8PosgM+Noncni4ntHsRN+v0sNh59waXBFT
         sJkZ9OhdcyM/Ji5Bmd+DbANCojNGYDzhgpv9CxUd2ApB9OEd4a8lMbnd6ttAuyhioJ1c
         wdMhghFrcls5LRpF+YoxX0Db852sS9EXb9dm1XyWAj8Q2T3YTEOhITUtW2E3KbkQ/oQG
         4uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJkPu9y+gmExeCUpCA066mqgvfW2S/OqiamBX4Wlaac=;
        b=p8+iezfkb/1nQafGd423uagVg9IbxlG5J5r2wBtBfynH6xKbSldxmoRokhbN0RZYwH
         mf1v2BPm+6O0PoA6BFBuXpz+n0IS5DknwXbmrSwA59qZdUUtiNUwxpmnzifIWQjpFtEX
         diXZJNyt6Tjt2Jts5rVXr4i4JhHwG78vv2Hc4/26Di91SMmbtDv1694Cr7tN6+8KLRg0
         UbIHuykabSALUzajRyspCSNq1pOqa8YSSVFHW12ZqOsq9ucV3Fvn5axLn4yL6gbDrxxt
         xomG4WFa7o6Lr/VUatqWSOoQS3kL8pDXFd0WvMtfJQ8/7TeB7wnHMZf4wuWnpaftpTgl
         BX9Q==
X-Gm-Message-State: APjAAAU1U3KMtvyHktruFl2BJnjmnX0TS+dlMsguPdzSgBpinAaGk7ma
        T5CIe3tCL4FcjDRuTzJU7jzokH7YWqQgx/+piZnz/twWReRQOpC7HcY2UN5509GkR759Hmwjf33
        JMCDlsC1DuhPEDBoBRrPN5PwO9+WQuReyvtT3nPKAIeiHMw0+UCmnXSA+WuBNmkdwLVnujqblmA
        85woRqpYmF/5WRmZi8km4vX0C8cQ==
X-Google-Smtp-Source: APXvYqzlo+ErKLnV+mIUOt+HBmu0++8ZYqKngGxYeK6whrKBE9XLsuUPttEBceyQw8CdQznTk6AjmA==
X-Received: by 2002:a1c:5f87:: with SMTP id t129mr106499814wmb.150.1564437517690;
        Mon, 29 Jul 2019 14:58:37 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:37 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCHv5 27/37] x86/vdso2c: Process jump tables
Date:   Mon, 29 Jul 2019 22:57:09 +0100
Message-Id: <20190729215758.28405-28-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729215758.28405-1-dima@arista.com>
References: <20190729215758.28405-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside time
namespace with clk_to_ns() that subtracts offsets from host's time.

The timens code in vdso looks like this:

      if (timens_static_branch()) {
              clk_to_ns(clk, ts);
      }

Static branch mechanism adds a __jump_table section into vdso.
Vdso's linker script drops all unwanted sections in compile time.

Preserve __jump_table section and add it into (struct vdso_image),
as it's needed for enabling (patching) static branches that are
present on vdso.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso-layout.lds.S | 1 +
 arch/x86/entry/vdso/vdso2c.h          | 9 ++++++++-
 arch/x86/include/asm/vdso.h           | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index ba216527e59f..69dbe4821aa5 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -45,6 +45,7 @@ SECTIONS
 	.gnu.version	: { *(.gnu.version) }
 	.gnu.version_d	: { *(.gnu.version_d) }
 	.gnu.version_r	: { *(.gnu.version_r) }
+	__jump_table	: { *(__jump_table) }	:text
 
 	.dynamic	: { *(.dynamic) }		:text	:dynamic
 
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 885b988aea19..318b278ca396 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -14,7 +14,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
 	unsigned int i, syms_nr;
-	unsigned long j;
+	unsigned long j, jump_table_addr = -1UL, jump_table_size = -1UL;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
@@ -78,6 +78,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
 			    ".altinstructions"))
 			alt_sec = sh;
+		if (!strcmp(secstrings + GET_LE(&sh->sh_name), "__jump_table")) {
+			jump_table_addr = GET_LE(&sh->sh_offset);
+			jump_table_size = GET_LE(&sh->sh_size);
+		}
 	}
 
 	if (!symtab_hdr)
@@ -166,6 +170,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		fprintf(outfile, "\t.alt_len = %lu,\n",
 			(unsigned long)GET_LE(&alt_sec->sh_size));
 	}
+	fprintf(outfile, "\t.jump_table = %luUL,\n", jump_table_addr);
+	fprintf(outfile, "\t.jump_table_len = %luUL,\n", jump_table_size);
+
 	for (i = 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index ccf89dedd04f..5e83bd3cda22 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -16,6 +16,7 @@ struct vdso_image {
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
+	unsigned long jump_table, jump_table_len;
 
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 
-- 
2.22.0

