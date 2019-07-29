Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4579C11
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfG2WBZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:01:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389271AbfG2V61 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so10302220wrt.6
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=NLaEBoeZTwPxMkgcmIz5vSw3SbBuMmx/qS0b8Fx5gte/oiZ6F7BusGo71S2hsYxYyw
         sCGf03gIKzWNLG9ZQnZGG6eDBUB2135zeGJVOsz5PBAJB5ktk+pgZsPvz61NPGxoWDI5
         YLxbKs4dYFOJ8UP08nBW1oVqMURXEC1usMeQhF751DA0+4mER4w+tWpmCthUvwc3hlhE
         3p6lNCce1osI3dY8leTznQTuFZw4DFCLtC8+mhPG2bjfDUK/lMInpJlm/BiU06Ej3/4x
         IHkz0Pp9OjVWjp3apin3No/JflZaIYZNa6FCI2f+8oZ33ex7ea8+V5qVLDGV9hTUhw/g
         T1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQTvfg8Tpo4N8AzFTEat5V09DvUQksH5vgyoMyK5UTo=;
        b=o37pbihZOJp5WLIAUN8vfbUjtC8bv1d+F/7nFxt17al699UHhQ4MOsHfZkYq9H9D8B
         QW0D7GrkqDwLOuXpBhgk0feE5ip1DWtA5JQbAgZJjclVRAV/ZD3YoAmajv46GElocfWF
         pyzbbxy5fYHvvKUTL10uZSC5KV9e9uzsHfl1keE+4yx/K6n1uUuD/35CTqjKgulzxJkW
         CxPhDRnTVu9O98C6p6eDBmCkaXbpxSsFaikSU8QLOwFK3xKBrw8tzyjm7FWs0735eDyA
         9NPL+od8wcgTHvOedfCH26P8L3AYPNs3dGpko62IfTUp+NwHN1LMU8WwxB0W2IOjn7sG
         Wgtw==
X-Gm-Message-State: APjAAAXDo57A8DxkkmO1G175FQt0sF7az4aohNByP2RDca6Q3c9yLf5r
        CfhTYwrbV8Zqph1v9HXF+LluP41uruTALKyWeroGv9KjYM5qY2Pc+uyoHHI2m65EeYMWVB+cR3V
        y0FSh9KSyv+mRoaBYknUa0JWIQr4aZdELawdI2lmNZIYeP5X4aTV0t1i8JudG/fucnsiINimCmB
        xru20g8S6LFAjXFbbycsVJzbYaRg==
X-Google-Smtp-Source: APXvYqw7JuvakPP3L9h8/7x/ktyciKK0UqTWtoa9A4x8UUTtY1gHos1WvIOBr2xACzdJnnLxdgNNCw==
X-Received: by 2002:adf:c803:: with SMTP id d3mr48994066wrh.130.1564437506554;
        Mon, 29 Jul 2019 14:58:26 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:25 -0700 (PDT)
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
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCHv5 19/37] x86/vdso2c: Convert iterator to unsigned
Date:   Mon, 29 Jul 2019 22:57:01 +0100
Message-Id: <20190729215758.28405-20-dima@arista.com>
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

