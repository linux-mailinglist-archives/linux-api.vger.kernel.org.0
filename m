Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B387243010
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbfFLT0r (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:26:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46361 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbfFLT0r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so18091056wrw.13
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=VlXoC4OJvgPVQSvv3/OUXNAQAaphb+hnyt0euoP89ggnl3AS2fPxmRFhJgpKGz0deK
         43UuuOn6i/PQH+kbDg1w+idcC0H1tCCEKQiN+EcxpOFDT+iP1bW3zTXL8K3f6HCTXFlX
         xQszSB4m5BnKGRdPdyKSWPD2mJxVI9pEkfWn4b3te9o59clJx6v4hNPNBfj6oG+yWD6Z
         m2/sM2POrjD4VSjS6ZLyRuRuAVMr1xQmssRFzt7KTPlueUJEzmUisok+qdgB2MZ8Vh2y
         6Z9WkhiTNtkHQ5dGqB0ssztFosDhrcoT+h2KoM0ESg7vtuGCctVlZuCtIvkS5/MCnsHv
         67zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=SztaECrXB26Fd+Vfv21uV66RTq06x8IYWOhkDdDBMFAVnrksr0faohOLt92zoEBCi0
         XAx129ForAgl7Hs1aaV5jy45Hfseb4PkRuM92C3mU9L/a0Dp5lSWoKJdhhrH4nytxyJX
         NS6RgSXf2qkWd8vo5xwtDo1+hH49G8kALvx5yIbkU2FGaCOIvR0hX+9BsFbN+xT100/S
         eJLvDfLXUuloePa0cT137SsPNoTPVGezuVd9FkEAiElKOEZ8GuPcGGOa5UGsviKEMk3W
         yrEWUDnd5nlGf09e++x0hKNaA6rapOXO7UiQhwDhOuOZEK/75PTRlpCP+4YJhcYSEoDC
         OzQA==
X-Gm-Message-State: APjAAAUnLxoK3fJ9JgTmq6SFw6GjL4FV3rkmaBs7HyKqKdu0BomqNgum
        wl4lcHZwyAoHK0Ii7Dn2DmQWQA==
X-Google-Smtp-Source: APXvYqzqxJJh+TcPUGfWE7o/3hDSArrr7ndoGURZcvlBJ53+Si+juwQGHwh6g2vk5jA1VO0bPBh3mQ==
X-Received: by 2002:adf:a201:: with SMTP id p1mr24494679wra.113.1560367605839;
        Wed, 12 Jun 2019 12:26:45 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:45 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv4 11/28] x86/vdso2c: Convert iterator to unsigned
Date:   Wed, 12 Jun 2019 20:26:10 +0100
Message-Id: <20190612192628.23797-12-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

i and j are used everywhere with unsigned types.
Cleanup and prettify the code a bit.

Introduce syms_nr for readability and as a preparation for allocating an
array of vDSO entries that will be needed for creating two vdso .so's:
one for host tasks and another for processes inside time namespace.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index a20b134de2a8..80be339ee93e 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -13,7 +13,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long load_size = -1;  /* Work around bogus warning */
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
-	int i;
+	unsigned int i, syms_nr;
 	unsigned long j;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
@@ -86,11 +86,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	strtab_hdr = raw_addr + GET_LE(&hdr->e_shoff) +
 		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
 
+	syms_nr = GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
 	/* Walk the symbol table */
-	for (i = 0;
-	     i < GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
-	     i++) {
-		int k;
+	for (i = 0; i < syms_nr; i++) {
+		unsigned int k;
 		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
 			GET_LE(&symtab_hdr->sh_entsize) * i;
 		const char *sym_name = raw_addr +
-- 
2.22.0

