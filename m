Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B28F0EC
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732545AbfHOQjU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:20 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32890 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732504AbfHOQjU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id u16so2796735wrr.0
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uJkPu9y+gmExeCUpCA066mqgvfW2S/OqiamBX4Wlaac=;
        b=J4KpZPS7wXz88Nni6ZpvxnXX+K2uvbYds1TcLpaXL/Z5uwIBXN9Ddc2tqoExyKQriq
         PBnjY59uAnaLurHOas1TkBVD5whYXEK7z70a6i247qXRE2ZmKXcmu3tbIO/qJwCyMCGN
         pl5AUYGdrWLH4lpzdGUA664DWH9bwRj5ahw75ilzSbAEdMvoqCajxBi6UrEIildjsaDX
         QBHSEaUhLlWhojYHjvrvxWw1EJaL8HC4aLWkqE9jxz1jPvYCHbwzwA5xjq6X0/ZhEJ1p
         fQa8sJRo+F9elMn+jv5nu9BPstAlDQxFi08QAAv9n64DpKpDzTzSCUF5y0xlrw9GQ+8/
         G5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uJkPu9y+gmExeCUpCA066mqgvfW2S/OqiamBX4Wlaac=;
        b=rSFXtP2RgHzyPqEdZZKKiH3AxDrwqK3LcS9XQQOcBatOu4mrwIQe70XLYJR29cW3T+
         L2CX7H/PUAm5Gm3HJ/NnWB94TRvl8vmZn8KzCMu2sovjguf8Sa+nQJTyihMoaI2B/H1g
         Ry5oPI/fpMk3iYt2ccETgdzWlUuwll+YZWOyjbHFi8sL9IDTgIiOhfmxdjc9VpVhO4VF
         cUGDZrhWfLdiCXXUXBROCXTG4lh8NZwfdNNqH6rzk5jtBqrRO2VvIQXS9tnZPe5SFjYn
         m24F3Ju7HRsQNV6Tgq7DbdB75wX6o7ERTAqNWWedHzPFHwS++bsgQRq3i9PsylFepDT5
         57vg==
X-Gm-Message-State: APjAAAV6//BRG3/HL7HcA2UrV69P9wLYDTdRIfxCvrR4BNDKhvZQF+ix
        gWmVRqyBnC7SN1uduCVE/R/L5A==
X-Google-Smtp-Source: APXvYqzG58GHqWhQt3O95EMpBPl+rbS/dCB4xX33X5WCtgl71eUCMz5eZqiwPYk9hteRQJy1ao79eQ==
X-Received: by 2002:adf:db49:: with SMTP id f9mr6487168wrj.112.1565887156941;
        Thu, 15 Aug 2019 09:39:16 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:16 -0700 (PDT)
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
Subject: [PATCHv6 26/36] x86/vdso2c: Process jump tables
Date:   Thu, 15 Aug 2019 17:38:26 +0100
Message-Id: <20190815163836.2927-27-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

