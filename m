Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6FE290FCE
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436889AbgJQGBj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411580AbgJQGBg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:01:36 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62054C0613DB
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id e19so2370373qtq.17
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=beJYRcTSMXl+ssB1hZRLQHWjWaa0LSzrjyL4rY4lfCE=;
        b=IdbWwjq/b+TLNtozI5kF+btUmTLlcbzVYXEGi1AU7DQGBpTF9aUlKXoyMLkzHkNYVx
         zF15uNRB5iKTJMqlEfG/VHAhK8M7AfhiIbi9Jj6ada9NwjlQqiU2WpSwg1hwShMhSSdX
         QN/Y7I3sqFvccG9a91KgIk1+oLceZh4SOTWzygKmHTta8SsCwGl6MOHwgsdNUkjKvbr4
         dgrtJ30VpDPdGq1LFmvKGkQob5Aj12dxZpIr00Gqy1CvU8nNVae8FN7Y83M3bwxBoeuC
         kAomeqgPWXk/Pqadyt1O7ld1Fwvuhp5lcb0xs6sH3iymOp2JGVlPmueooCh6G24SG0q2
         KdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=beJYRcTSMXl+ssB1hZRLQHWjWaa0LSzrjyL4rY4lfCE=;
        b=LOxrAxk2fILmQJEDO22zGIdYZvpXtuWwj2Y0JN6i77nUROB0pmD2T3IW2mHT8AE7dH
         3pgrExxYXBD2dIhRiO8Vq1epThgPRTXqFtayQgnYFDTmmei0nPNNiGTbHVQD9u7MmPve
         Dqw0+53cCj5xikXkDvtmT8ENKsRwWRA+YEmnVYb/dYlz8NZPvnTFAEpjYehctXGDseaW
         vi0ABQy2t7TSZgir620BKDa0ah7DcJFsy4p0C0qXabPQul+vw7SB0fOHnaKUDwaDXZuF
         mFXm7TbTbOJoEuhHHsChHebW7cyfBEaiv3aWcUO0SivyqxHdGAPZZ+MipGh/j6KqwmCJ
         jqHg==
X-Gm-Message-State: AOAM533418K+TS2j8isqDY60djcL3DIHl/EpbmSHx10mWYYWi6iiDnEi
        kKEE/6m0g0TGKkzByPevLVPG9MM=
X-Google-Smtp-Source: ABdhPJyzLwra6WILfeSqbZO3wb7k45mAfs3gB0fAOYaCDrkAeUSkn5dFszU06PBpEUlPQCRTQ9Yf86c=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a0c:aa98:: with SMTP id f24mr6581581qvb.62.1602893574439;
 Fri, 16 Oct 2020 17:12:54 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:12:30 -0700
In-Reply-To: <cover.1602892799.git.pcc@google.com>
Message-Id: <b0ef91feb52d05bf95174f78b4f1d3ae322dc03a.1602892799.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602892799.git.pcc@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v12 5/8] signal: define the SA_UNSUPPORTED bit in sa_flags
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
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Define a sa_flags bit, SA_UNSUPPORTED, which will never be supported
in the uapi. The purpose of this flag bit is to allow userspace to
distinguish an old kernel that does not clear unknown sa_flags bits
from a kernel that supports every flag bit.

In other words, if userspace does something like:

  act.sa_flags |= SA_UNSUPPORTED;
  sigaction(SIGSEGV, &act, 0);
  sigaction(SIGSEGV, 0, &oldact);

and finds that SA_UNSUPPORTED remains set in oldact.sa_flags, it means
that the kernel cannot be trusted to have cleared unknown flag bits
from sa_flags, so no assumptions about flag bit support can be made.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
Link: https://linux-review.googlesource.com/id/Ic2501ad150a3a79c1cf27fb8c99be342e9dffbcb
---
v11:
- clarify the commit message

 include/uapi/asm-generic/signal-defs.h | 7 +++++++
 kernel/signal.c                        | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 493953fe319b..0126ebda4d31 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -14,6 +14,12 @@
  * SA_RESTART flag to get restarting signals (which were the default long ago)
  * SA_NODEFER prevents the current signal from being masked in the handler.
  * SA_RESETHAND clears the handler when the signal is delivered.
+ * SA_UNSUPPORTED is a flag bit that will never be supported. Kernels from
+ * before the introduction of SA_UNSUPPORTED did not clear unknown bits from
+ * sa_flags when read using the oldact argument to sigaction and rt_sigaction,
+ * so this bit allows flag bit support to be detected from userspace while
+ * allowing an old kernel to be distinguished from a kernel that supports every
+ * flag bit.
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -42,6 +48,7 @@
 #ifndef SA_RESETHAND
 #define SA_RESETHAND	0x80000000
 #endif
+#define SA_UNSUPPORTED	0x00000400
 
 #define SA_NOMASK	SA_NODEFER
 #define SA_ONESHOT	SA_RESETHAND
diff --git a/kernel/signal.c b/kernel/signal.c
index 2ef8c238679e..018c19f6cf66 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3984,6 +3984,12 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
 	if (oact)
 		*oact = *k;
 
+	/*
+	 * Make sure that we never accidentally claim to support SA_UNSUPPORTED,
+	 * e.g. by having an architecture use the bit in their uapi.
+	 */
+	BUILD_BUG_ON(UAPI_SA_FLAGS & SA_UNSUPPORTED);
+
 	/*
 	 * Clear unknown flag bits in order to allow userspace to detect missing
 	 * support for flag bits and to allow the kernel to use non-uapi bits
-- 
2.29.0.rc1.297.gfa9743e501-goog

