Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683AD3F338B
	for <lists+linux-api@lfdr.de>; Fri, 20 Aug 2021 20:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238236AbhHTSYa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Aug 2021 14:24:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:48048 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238868AbhHTSYT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 20 Aug 2021 14:24:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="203964954"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="203964954"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:23:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="523799170"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:23:08 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v29 06/10] x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
Date:   Fri, 20 Aug 2021 11:22:41 -0700
Message-Id: <20210820182245.1188-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820182245.1188-1-yu-cheng.yu@intel.com>
References: <20210820182245.1188-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

Update ARCH_X86_CET_STATUS and ARCH_X86_CET_DISABLE for Indirect Branch
Tracking.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/cet_prctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index b426d200e070..bd3c80d402e7 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -22,6 +22,9 @@ static int cet_copy_status_to_user(struct thread_shstk *shstk, u64 __user *ubuf)
 		buf[2] = shstk->size;
 	}
 
+	if (shstk->ibt)
+		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_IBT;
+
 	return copy_to_user(ubuf, buf, sizeof(buf));
 }
 
@@ -46,6 +49,8 @@ int prctl_cet(int option, u64 arg2)
 			return -EINVAL;
 		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 			shstk_disable();
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			ibt_disable();
 		return 0;
 
 	case ARCH_X86_CET_LOCK:
-- 
2.21.0

