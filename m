Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E164D69BC52
	for <lists+linux-api@lfdr.de>; Sat, 18 Feb 2023 22:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBRVQf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 18 Feb 2023 16:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjBRVQJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 18 Feb 2023 16:16:09 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1570116336;
        Sat, 18 Feb 2023 13:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676754961; x=1708290961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=taTLN9jgTVYTLY9Eitvg4bLvIT9+A18uF00hT2wXoJs=;
  b=G7QHn+Mi8+/+zr8XBFuVtSRHxtVrRHK/SbNGVlpVWKUN78sHmGLX3MLk
   8+UkXNhdXmSsnCR9fXyn0VIwoRE1ti3CJJylfQgzdDZ05MbBHbrB5gxCD
   Q8M0v5H0VLWHkbvlb3i7d/nnSwpOozYHv0ytiETTQ3njGLa+cU+aZfGmT
   ayhsz14KcDW67+j4+n8UiL8y4aAWJz6nEs5QGhOwANbIoTLIZI9YEvUFp
   qtoU6yiVEllhUzr6t7GWVEUB3Gd+KLCOoseAAmPgMjaamZ3C+6M7/fqAH
   1/nOAB9UW7GYAteAhJuCKr1KhjVTQRWc8RKxaL00NleGRRY+Lv/rPoPXi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427138"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427138"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:15:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241580"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241580"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:15:58 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v6 03/41] x86/cpufeatures: Add CPU feature flags for shadow stacks
Date:   Sat, 18 Feb 2023 13:13:55 -0800
Message-Id: <20230218211433.26859-4-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The Control-Flow Enforcement Technology contains two related features,
one of which is Shadow Stacks. Future patches will utilize this feature
for shadow stack support in KVM, so add a CPU feature flags for Shadow
Stacks (CPUID.(EAX=7,ECX=0):ECX[bit 7]).

To protect shadow stack state from malicious modification, the registers
are only accessible in supervisor mode. This implementation
context-switches the registers with XSAVES. Make X86_FEATURE_SHSTK depend
on XSAVES.

The shadow stack feature, enumerated by the CPUID bit described above,
encompasses both supervisor and userspace support for shadow stack. In
near future patches, only userspace shadow stack will be enabled. In
expectation of future supervisor shadow stack support, create a software
CPU capability to enumerate kernel utilization of userspace shadow stack
support. This user shadow stack bit should depend on the HW "shstk"
capability and that logic will be implemented in future patches.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>

---
v5:
 - Drop "shstk" from cpuinfo (Boris)
 - Remove capitalization on shadow stack (Boris)

v3:
 - Add user specific shadow stack cpu cap (Andrew Cooper)
 - Drop reviewed-bys from Boris and Kees due to the above change.

v2:
 - Remove IBT reference in commit log (Kees)
 - Describe xsaves dependency using text from (Dave)

v1:
 - Remove IBT, can be added in a follow on IBT series.
---
 arch/x86/include/asm/cpufeatures.h       | 2 ++
 arch/x86/include/asm/disabled-features.h | 8 +++++++-
 arch/x86/kernel/cpu/cpuid-deps.c         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index fdb8e09234ba..af4178e0d76a 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -309,6 +309,7 @@
 #define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
 #define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
 #define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
+#define X86_FEATURE_USER_SHSTK		(11*32+23) /* Shadow stack support for user mode applications */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
@@ -375,6 +376,7 @@
 #define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
 #define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
 #define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
+#define X86_FEATURE_SHSTK		(16*32+ 7) /* "" Shadow stack */
 #define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
 #define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
 #define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 5dfa4fb76f4b..505f78ddca82 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -99,6 +99,12 @@
 # define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
 #endif
 
+#ifdef CONFIG_X86_USER_SHADOW_STACK
+#define DISABLE_USER_SHSTK	0
+#else
+#define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
+#endif
+
 /*
  * Make sure to add features to the correct mask
  */
@@ -114,7 +120,7 @@
 #define DISABLED_MASK9	(DISABLE_SGX)
 #define DISABLED_MASK10	0
 #define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
-			 DISABLE_CALL_DEPTH_TRACKING)
+			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
 #define DISABLED_MASK12	0
 #define DISABLED_MASK13	0
 #define DISABLED_MASK14	0
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index f6748c8bd647..e462c1d3800a 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -81,6 +81,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
+	{ X86_FEATURE_SHSTK,			X86_FEATURE_XSAVES    },
 	{}
 };
 
-- 
2.17.1

