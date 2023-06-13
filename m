Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3A872D663
	for <lists+linux-api@lfdr.de>; Tue, 13 Jun 2023 02:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjFMATC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Jun 2023 20:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239327AbjFMARg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Jun 2023 20:17:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F87F199E;
        Mon, 12 Jun 2023 17:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615253; x=1718151253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xI4pbs3PiOhFQEbuDUq+4GewOhti2Nle1TQJwXiYqGs=;
  b=hu8F+oRkUA9SufUWd3i53q2VvFFsKCZw7iZl7c/I4VeIQoJKiyTlfduS
   F2YiwOgJvJOgmJpBVZ6VLsDMRjLJXhitb4CkdAZzs+ebTSgG7Rg/41+It
   Xx9GdUMWm1jfvOrHJLnSRhh8YZzN3+Bu9PmFs10hWoS0f/DKx/4qx9gWk
   WOgO+2Yduwx7KtzTwK0NnZ7qkRu9g7VKQjqPoIWmdgTTqSN043dfzDtRJ
   CB41KWAYViTKvcGK7TzR3I+cW+dGhxa+mfhRMvlSP/AeB3pru90PrCA2S
   sC6AxQDYieCiP7oi7/fKGBhKGbo1g+c9K5Q38YglvS/myT1D0j6Sb21V/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557540"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557540"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671152"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671152"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:39 -0700
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
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 37/42] x86/shstk: Wire in shadow stack interface
Date:   Mon, 12 Jun 2023 17:11:03 -0700
Message-Id: <20230613001108.3040476-38-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

The kernel now has the main shadow stack functionality to support
applications. Wire in the WRSS and shadow stack enable/disable functions
into the existing shadow stack API skeleton.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/shstk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index ea0bf113f9cf..d723cdc93474 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -502,9 +502,17 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 		return -EINVAL;
 
 	if (option == ARCH_SHSTK_DISABLE) {
+		if (features & ARCH_SHSTK_WRSS)
+			return wrss_control(false);
+		if (features & ARCH_SHSTK_SHSTK)
+			return shstk_disable();
 		return -EINVAL;
 	}
 
 	/* Handle ARCH_SHSTK_ENABLE */
+	if (features & ARCH_SHSTK_SHSTK)
+		return shstk_setup();
+	if (features & ARCH_SHSTK_WRSS)
+		return wrss_control(true);
 	return -EINVAL;
 }
-- 
2.34.1

