Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024C02B57BD
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 04:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgKQDRg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 22:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgKQDRf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 22:17:35 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA6C0613CF
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:17:35 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t13so10650224plo.16
        for <linux-api@vger.kernel.org>; Mon, 16 Nov 2020 19:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HuMspXIQ1vn0+ZumsLYjmGAwT+zGOwAT2v6OIPNSsT0=;
        b=uFaM/YxQUDATljb5DcWZr3qKob3St2pMqUOQg88VWbjSTsDum+IS9ohXmhW3Wn53vs
         Y2qB0OmWgOorDg1fGE4CaRg69UhOQVlD7OUTv3uiS0snh0qxfSJh2lM/LBvEecxi9rjC
         B7d5azTwTnP7uKwhJ5r52je5aAODT0p9ZV3HGuwfiOxfNcAlhawzfNaGCe3+IT/qRku0
         ugijBxuOF1KZxc6MnxyPxffLzd4c3ETWF5drrrvFtUJaHDSLZOuQ8CscJy/cXIHA9z6o
         oRPk4Z8xgomZGSWmh6o7oZKlfU5l5w7BWKsbUwD3mMgOEXbQ9wZYWhwQWfHlCsfU1JjV
         UF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HuMspXIQ1vn0+ZumsLYjmGAwT+zGOwAT2v6OIPNSsT0=;
        b=e+34sweRXVCYPDvQUBN5Uhv5XVSO5+++bPyYIXvmlVlG2nhQBJKIbRIGDPo/vyu6Z6
         ZASQZwvaX1vaa9xGMZPSa7i/4pSXOp4zAIrRQy2ZT5wEbkf7UABH51UCwH9t31HipavX
         8Edd83aeQPNRt7FyBPe65Wub41zMvAYFrV68TInsiodtJBRqjNOUxHtrR2bOJMZdwr05
         Ri/jpGkpx+tNWSufAi6Cg3xylhgllSNqWrV9n8pRlVdxKwlebIuKFK62/TK9kdZqF7Oe
         KuEOaMNL0vgSEZ8SvVm/RfuxCoWcPpK6A8C4GAipmpJmjMVySlH/js1vIAfBZFVIfGf3
         myrg==
X-Gm-Message-State: AOAM532yQ/JrU9T86jE0ohmedELvbq60xI5NDfAQGEtmQpEXbzBCRZL+
        21Uab+62wQaGlCr2j8J8TpxfpTU=
X-Google-Smtp-Source: ABdhPJznLr5RckPvsSEPyZ7t77ewqqdyK65KCvVE16OkknBRcsvR3X4WQUBiu8bqRK2IQsHfIpLlITE=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a17:902:a504:b029:d8:ebc7:a864 with SMTP id
 s4-20020a170902a504b02900d8ebc7a864mr6768825plq.60.1605583055418; Mon, 16 Nov
 2020 19:17:35 -0800 (PST)
Date:   Mon, 16 Nov 2020 19:17:24 -0800
In-Reply-To: <cover.1605582887.git.pcc@google.com>
Message-Id: <198c8b68c76bf3ed73117d817c7cdf9bc0eb174f.1605582887.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605582887.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v17 1/3] arch: provide better documentation for the
 arch-specific SA_* flags
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Instead of documenting the arch-specific flag values in a comment at
the top where they may be easily overlooked, document them in comments
inline with the definitions in numerical order so that it is clear
why specific values must be chosen for new generic flags and to reduce
the likelihood of conflicts between generic and arch-specific flags.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I40a129cf7c3a71ba1bfd6d936c544072ee3b7ce6
---
 include/uapi/asm-generic/signal-defs.h | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 493953fe319b..44f070982752 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -17,9 +17,6 @@
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
- *
- * The following bits are used in architecture-specific SA_* definitions and
- * should be avoided for new generic flags: 3, 4, 5, 6, 7, 8, 9, 16, 24, 25, 26.
  */
 #ifndef SA_NOCLDSTOP
 #define SA_NOCLDSTOP	0x00000001
@@ -30,6 +27,20 @@
 #ifndef SA_SIGINFO
 #define SA_SIGINFO	0x00000004
 #endif
+/* 0x00000008 used on alpha, mips, parisc */
+/* 0x00000010 used on alpha, parisc */
+/* 0x00000020 used on alpha, parisc, sparc */
+/* 0x00000040 used on alpha, parisc */
+/* 0x00000080 used on parisc */
+/* 0x00000100 used on sparc */
+/* 0x00000200 used on sparc */
+/* 0x00010000 used on mips */
+/* 0x01000000 used on x86 */
+/* 0x02000000 used on x86 */
+/*
+ * New architectures should not define the obsolete
+ *	SA_RESTORER	0x04000000
+ */
 #ifndef SA_ONSTACK
 #define SA_ONSTACK	0x08000000
 #endif
@@ -46,11 +57,6 @@
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
 
-/*
- * New architectures should not define the obsolete
- *	SA_RESTORER	0x04000000
- */
-
 #ifndef SIG_BLOCK
 #define SIG_BLOCK          0	/* for blocking signals */
 #endif
-- 
2.29.2.299.gdc1121823c-goog

