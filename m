Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B86B79BBF
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfG2V6i (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 17:58:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54793 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730397AbfG2V6h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 17:58:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so55158888wme.4
        for <linux-api@vger.kernel.org>; Mon, 29 Jul 2019 14:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OW8GU+t0fVJSjUItOBj5d09rAdyjVelz1gsjEuXxZec=;
        b=cnnrX+qQPbDjALwPI2qY855GbxStpPeJEe4VSbOhOsWfQuUQnzCWREC6/j9snCQmKa
         RROusgDqPPUGhhKbvW5F8lFniaBh5s+zwA/qveINFjliT+xfLuXpI4I0xps2YbGGeHAL
         +IYMZFC7rDJmKxcMOidg5CurG+/VtroXnxhkbsje4890o4QD4ab4zX+kb28GIvnFw4et
         vflBBeqa9FFfdFH8F/fTo4HUxFWF77VZRnFDxhBpNIf59eGi9I7N/cog2/sDEZDfyKWa
         W+N9z1BsMA19ifqP9qgIHuYsSbZ/zBoBoS51YF9Fa4OzgMcUyAceyEvW0cXdj7GkdeXW
         Rqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OW8GU+t0fVJSjUItOBj5d09rAdyjVelz1gsjEuXxZec=;
        b=inskRF3rF7l3bjj/ZE8z65Egmbmk1f+t+pnAixx6VjoI/HUIn8OzL08eWW4LJYXMIF
         56UFatKs82cPvadtoY0jV1uH3iMZpXsfOd5kuxCG/elpOJ9Ma97tny04MA6SHIONWNrl
         Fyo1gPyKEe+B48bq7gNV+wbjb+qhUGKqPenhFUcs+g5N544YT7dhVDIejI3oKiuPNCxx
         iGoWIEtu3IMFkF2mUNkuRUdrz7A2bds4Quw7BhdIb13fwVl5YQaG1NYQJqpO6EGjbMmX
         gGwT4pwsH37MXtRJwMk8TcylrnUordjccVhSWrftmFJsHe1+OeoRevb2WxTM5bG9l0Iw
         DagA==
X-Gm-Message-State: APjAAAXsSL1hFhBNH7bWbNrJrqXlSDBS2GpmdmaS5Yqi5/26Q/mKUK6L
        UqSXFUFQdL5scw7R/uujVzFfDNaCmFnozYJkVKlwvm8w7G0lRnRyLZ56aPlovHL6X/p4dG9Wl36
        gcilH/x9N/V7TVO+tau9NJ/tf/E9B6voPv1wW8UCSGL0X0EY4hLaGUClNKpQyq+FUHReeuN7FF5
        aiHTtt0kEiO2qssgnI5rlQdPTpFQ==
X-Google-Smtp-Source: APXvYqyczyvBs3sJHc3Xzg6CfJWOstD//re4woLcTGWNV6okiSkW8WG8Kt7KZT7qqzD3u1HHO47bNQ==
X-Received: by 2002:a7b:c251:: with SMTP id b17mr27134664wmj.143.1564437516291;
        Mon, 29 Jul 2019 14:58:36 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x20sm49230728wmc.1.2019.07.29.14.58.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 14:58:35 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
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
Subject: [PATCHv5 26/37] vdso: Introduce vdso_static_branch_unlikely()
Date:   Mon, 29 Jul 2019 22:57:08 +0100
Message-Id: <20190729215758.28405-27-dima@arista.com>
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

From: Andrei Vagin <avagin@gmail.com>

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Introduce vdso_static_branch_unlikely(), which is similar to
static_branch_unlikely(); alias it with timens_static_branch_unlikely()
under CONFIG_TIME_NS.

The timens code in vdso will look like this:

   if (timens_static_branch_unlikely()) {
	   clk_to_ns(clk, ts);
   }

The version of vdso which is compiled from sources will never execute
clk_to_ns(). And then we can patch the 'no-op' in the straight-line
codepath with a 'jump' instruction to the out-of-line true branch and
get the timens version of the vdso library.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/include/asm/jump_label.h | 14 ++++++++++++++
 lib/vdso/gettimeofday.c           | 10 ++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 06c3cc22a058..376efb53183b 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -53,6 +53,20 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
+static __always_inline bool vdso_static_branch_unlikely(void)
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
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 7525433f8ba4..605bdb92055d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/hrtimer_defs.h>
 #include <linux/timens_offsets.h>
+#include <linux/jump_label.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
@@ -43,6 +44,8 @@ u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 extern u8 timens_page
 	__attribute__((visibility("hidden")));
 
+#define timens_static_branch_unlikely vdso_static_branch_unlikely
+
 notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts)
 {
 	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
@@ -79,6 +82,7 @@ notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_tim
 }
 #else
 notrace static __always_inline void clk_to_ns(clockid_t clk, struct __kernel_timespec *ts) {}
+notrace static __always_inline bool timens_static_branch_unlikely(void) { return false; }
 #endif
 
 static int do_hres(const struct vdso_data *vd, clockid_t clk,
@@ -108,7 +112,8 @@ static int do_hres(const struct vdso_data *vd, clockid_t clk,
 	ts->tv_sec = sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec = ns;
 
-	clk_to_ns(clk, ts);
+	if (timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 
 	return 0;
 }
@@ -125,7 +130,8 @@ static void do_coarse(const struct vdso_data *vd, clockid_t clk,
 		ts->tv_nsec = vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
-	clk_to_ns(clk, ts);
+	if (timens_static_branch_unlikely())
+		clk_to_ns(clk, ts);
 }
 
 static __maybe_unused int
-- 
2.22.0

