Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45C238F0F5
	for <lists+linux-api@lfdr.de>; Thu, 15 Aug 2019 18:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbfHOQjS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Aug 2019 12:39:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34552 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732497AbfHOQjS (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Aug 2019 12:39:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id e8so1362352wme.1
        for <linux-api@vger.kernel.org>; Thu, 15 Aug 2019 09:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3ZGp+O5Ehj19vRAvPpbkUB/uST+294xCc8onpK96D4=;
        b=DYldfjmQdrS3/Nic11gx6IbW0hwHzuMkPcCibSgv0ZEWEv/J5sPieL9JTIBU1rXHC5
         YVqNE1FDmBz3G3W3cNj79vjOE1IFlRJlyUImoxz8x+TH1Qh/UW6wuszD1e4Sl+DPlS1s
         dlgvPWlskQkZH5FefTdjFdXebehsr7ShrZjDajk2qLnuS3u1FGRSUXMlUJcA8Iy4yJpG
         owD5sDN15d3aOpggyNGwEnerlO4DJcylKS0tVSe5azGDQHIdXua45Z1uEw2YEqPcsfHX
         dxz37lZ3ey5CIFP5RYHmmJ9356CAmUG5KTd7ocQJnkYf3kz2eBdUBF4be76DosDih7qe
         eAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3ZGp+O5Ehj19vRAvPpbkUB/uST+294xCc8onpK96D4=;
        b=D19f02/DaqMe6uXoCSSZ2C3Z6SUUKQUx7IjVHlLkZ9GyORrxjb2S0t/BfYBsBsyyFz
         pC2sVwZd399YFJ4HBvHADm0JawagDL1GIZ8EVejUW3fK0eFLjawOqsWeY+EVwPxvUaye
         tvLNptp+8587+6w76oNoOx7SabiEt/g/3PTSbYXYWPGk/s9mAdIQVtqT3p9qZeUSN3R7
         s7U32hAz95V/SiEA8PsDKj6n4gbWd84ImQN5hQ1W5gLMjlnsZeKTCGBArYDhpvj3bmhi
         9PU5/6/1OQJerFpE/aQYPjWzEuSHbUVkM+6Ar0Je5PA6r78XTBUC6YANqQuT7jy1nMXo
         TBRA==
X-Gm-Message-State: APjAAAWS2/20eFn4Aaf6NzYV5WZippkFnS7s/Pk5yVGoRKAqs0mnp6Hw
        gzkycc3LVinTmvdGPrg/027xfw==
X-Google-Smtp-Source: APXvYqyCKmlUYyAo3J++9qHLAADZg/a2QTxqtIK8Q4sLng0OsdV650l2YHvcHR1rqS8YTW4Kcwn3Ag==
X-Received: by 2002:a1c:2015:: with SMTP id g21mr3509819wmg.33.1565887155519;
        Thu, 15 Aug 2019 09:39:15 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id f7sm5755046wrf.8.2019.08.15.09.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 09:39:15 -0700 (PDT)
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
Subject: [PATCHv6 25/36] vdso: Introduce vdso_static_branch_unlikely()
Date:   Thu, 15 Aug 2019 17:38:25 +0100
Message-Id: <20190815163836.2927-26-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190815163836.2927-1-dima@arista.com>
References: <20190815163836.2927-1-dima@arista.com>
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
index 8589c66ff3e7..7df8fa6c03fa 100644
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

