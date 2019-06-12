Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C432643004
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 21:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfFLT1A (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 15:27:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46382 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbfFLT07 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 15:26:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so18091546wrw.13
        for <linux-api@vger.kernel.org>; Wed, 12 Jun 2019 12:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QoqR4Yh8ez+L/IuucB5QLRW/ecUbgr4klE57NZBSo9k=;
        b=hMp/A5m4SF6KCiiHF50uiyxjP9azcDzUBHKUVNpbv+2JX7NHda8ZvnmKJaTNU9hGow
         JU7T2BIPfVaPjtBgox7paJTR0IUt1v4J3pfKhSZFRn4+SYh4J7hWHIUNojU51rre+/7U
         w8JLwfdqfkWrpXuEYdQZs1WAzOsyqLruObUsz7mARZ5LBHy+HdjPTirqVEpoAWNiGsB3
         cN8EK/mjV2qLiPy+QdlLxKPXw7EIOLr7UypgxJB9Z7bwl3LbVlfyRTzyQ51+kTRKPVTn
         WznunnN1NPr1y38QgadnVI+Q2HddpdINBo/XP6F6ZHg6HpPMA8KBJQ/w/oOomVYdd3rB
         H2XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QoqR4Yh8ez+L/IuucB5QLRW/ecUbgr4klE57NZBSo9k=;
        b=oOfGcLJqBhb0xv9v+v0S1cdI+G9LQqOanKLUJIuWN48CIU5juxCLeS5RCKlx+hFbLM
         myqu8gt86ul7dXVXViJJw+dzblWkuwu9Z57NbKWvC1xVhYjpG4njC04Xq3G6JX5kRw8M
         XnuiXEYAgjtVjnOLMAJRBHkVREOJgHGcYri54PIztMvawjBj7P4641N3ff571/TDIena
         KEFjaaLGLbvg4KLw4s1PuvgkfRgblQBSgL+3KS1zL2Jo+CiUUIRvCIXPHhKZwghLM+Ec
         6JS7+bkBLo9k3005KH8881PGj1/F7U/TAXejX5PEZzJvuaKWwHWVQu80xHKlTcSVZRAP
         jFNw==
X-Gm-Message-State: APjAAAUz8TqPyMGNNq3p/rEaf0xkvOJqgQhp0y1fAPv7LW/hMvWeI+rf
        GBR5+qDaAnzLeTebb/Mb0iXJTA==
X-Google-Smtp-Source: APXvYqwnLKgYvY+Cxdk19LniPYmmY1jskvOVCeZNisXH6RnBK4GRyWmSJD9F1KpSYT5mmSDI+hCfow==
X-Received: by 2002:a5d:67cd:: with SMTP id n13mr43626748wrw.138.1560367615988;
        Wed, 12 Jun 2019 12:26:55 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r5sm612526wrg.10.2019.06.12.12.26.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 12:26:55 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: [PATCHv4 18/28] vdso: introduce timens_static_branch
Date:   Wed, 12 Jun 2019 20:26:17 +0100
Message-Id: <20190612192628.23797-19-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612192628.23797-1-dima@arista.com>
References: <20190612192628.23797-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

This patch introduces timens_static_branch(), which is similar with
static_branch_unlikely.

The timens code in vdso looks like this:

       if (timens_static_branch()) {
               clk_to_ns(clk, ts);
       }

The version of vdso which is compiled from sources will never execute
clk_to_ns(). And then we can patch the 'no-op' in the straight-line
codepath with a 'jump' instruction to the out-of-line true branch and
get the timens version of the vdso library.

While cooking the patch, an alternative approach has being considered:
to omit no-ops - memcpy() the following asm ret sequience on the place of
a function call: https://github.com/0x7f454c46/linux/commit/4cc0180f6d65
Having in mind possible issues with different toolchains, the usual
static_branch() approach was choosen.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vclock_gettime.c  |  9 +++++--
 arch/x86/entry/vdso/vdso-layout.lds.S |  1 +
 arch/x86/entry/vdso/vdso2c.h          | 11 +++++++-
 arch/x86/entry/vdso/vma.c             | 37 ++++++++++++++++++++++-----
 arch/x86/include/asm/jump_label.h     | 14 ++++++++++
 arch/x86/include/asm/vdso.h           |  1 +
 include/linux/jump_label.h            |  5 ++++
 7 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index e2d93628c0dd..21b7153cf2b0 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -18,6 +18,7 @@
 #include <asm/msr.h>
 #include <asm/pvclock.h>
 #include <asm/mshyperv.h>
+#include <asm/jump_label.h>
 #include <linux/math64.h>
 #include <linux/time.h>
 #include <linux/kernel.h>
@@ -174,8 +175,10 @@ notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts
 		ts->tv_sec--;
 	}
 }
+#define _timens_static_branch_unlikely timens_static_branch_unlikely
 #else
 notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts) {}
+notrace static __always_inline bool _timens_static_branch_unlikely(void) { return false; }
 #endif
 
 notrace static int do_hres(clockid_t clk, struct timespec *ts)
@@ -204,7 +207,8 @@ notrace static int do_hres(clockid_t clk, struct timespec *ts)
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	clk_to_ns(clk, ts);
+	if (_timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 
 	return 0;
 }
@@ -220,7 +224,8 @@ notrace static void do_coarse(clockid_t clk, struct timespec *ts)
 		ts->tv_nsec = base->nsec;
 	} while (unlikely(gtod_read_retry(gtod, seq)));
 
-	clk_to_ns(clk, ts);
+	if (_timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 }
 
 notrace int __vdso_clock_gettime(clockid_t clock, struct timespec *ts)
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
index 885b988aea19..392031258315 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -16,7 +16,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned int i, syms_nr;
 	unsigned long j;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
-		*alt_sec = NULL;
+		*alt_sec = NULL, *jump_table_sec = NULL;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
 	const char *secstrings;
 	INT_BITS syms[NSYMS] = {};
@@ -78,6 +78,9 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
 			    ".altinstructions"))
 			alt_sec = sh;
+		if (!strcmp(secstrings + GET_LE(&sh->sh_name),
+			    "__jump_table"))
+			jump_table_sec  = sh;
 	}
 
 	if (!symtab_hdr)
@@ -166,6 +169,12 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		fprintf(outfile, "\t.alt_len = %lu,\n",
 			(unsigned long)GET_LE(&alt_sec->sh_size));
 	}
+	if (jump_table_sec) {
+		fprintf(outfile, "\t.jump_table = %lu,\n",
+			(unsigned long)GET_LE(&jump_table_sec->sh_offset));
+		fprintf(outfile, "\t.jump_table_len = %lu,\n",
+			(unsigned long)GET_LE(&jump_table_sec->sh_size));
+	}
 	for (i = 0; i < NSYMS; i++) {
 		if (required_syms[i].export && syms[i])
 			fprintf(outfile, "\t.sym_%s = %" PRIi64 ",\n",
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 3ed5bf4932af..12cf73aa0aec 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -15,6 +15,7 @@
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
 #include <linux/time_namespace.h>
+#include <linux/jump_label.h>
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
 #include <asm/proto.h>
@@ -31,20 +32,44 @@
 unsigned int __read_mostly vdso64_enabled = 1;
 #endif
 
-void __init init_vdso_image(struct vdso_image *image)
+#ifdef CONFIG_TIME_NS
+static __init void apply_jump_tables(struct vdso_jump_entry *ent, unsigned long nr)
 {
-	BUG_ON(image->size % PAGE_SIZE != 0);
+	while (nr--) {
+		void *code_addr	= (void *)ent + ent->code;
+		long target_addr = (long) ent->target - (ent->code + JUMP_LABEL_NOP_SIZE);
+		((char *)code_addr)[0] = 0xe9; /* JMP rel32 */
+		*((long *)(code_addr + 1)) = (long)target_addr;
+
+		ent++;
+	}
+}
+
+static __init void init_timens(struct vdso_image *image)
+{
+	struct vdso_jump_entry *entries;
 
-	apply_alternatives((struct alt_instr *)(image->text + image->alt),
-			   (struct alt_instr *)(image->text + image->alt +
-						image->alt_len));
-#ifdef CONFIG_TIME_NS
 	image->text_timens = vmalloc_32(image->size);
 	if (WARN_ON(image->text_timens == NULL))
 		return;
 
 	memcpy(image->text_timens, image->text, image->size);
+
+	entries = image->text_timens + image->jump_table;
+	apply_jump_tables(entries, image->jump_table_len / sizeof(struct vdso_jump_entry));
+}
+#else
+static inline void init_timens(struct vdso_image *image) {}
 #endif
+
+void __init init_vdso_image(struct vdso_image *image)
+{
+	BUG_ON(image->size % PAGE_SIZE != 0);
+
+	apply_alternatives((struct alt_instr *)(image->text + image->alt),
+			   (struct alt_instr *)(image->text + image->alt +
+						image->alt_len));
+	init_timens(image);
 }
 
 struct linux_binprm;
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 65191ce8e1cf..1784aa49cc82 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -51,6 +51,20 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
+static __always_inline bool timens_static_branch_unlikely(void)
+{
+	asm_volatile_goto("1:\n\t"
+		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
+		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 "2: .word 1b - 2b, %l[l_yes] - 2b\n\t"
+		 ".popsection\n\t"
+		 : :  :  : l_yes);
+
+	return false;
+l_yes:
+	return true;
+}
+
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index ccf89dedd04f..5e83bd3cda22 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -16,6 +16,7 @@ struct vdso_image {
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
 
 	unsigned long alt, alt_len;
+	unsigned long jump_table, jump_table_len;
 
 	long sym_vvar_start;  /* Negative offset to the vvar area */
 
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 3e113a1fa0f1..69854a05d2f2 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -125,6 +125,11 @@ struct jump_entry {
 	long key;	// key may be far away from the core kernel under KASLR
 };
 
+struct vdso_jump_entry {
+	u16 code;
+	u16 target;
+};
+
 static inline unsigned long jump_entry_code(const struct jump_entry *entry)
 {
 	return (unsigned long)&entry->code + entry->code;
-- 
2.22.0

