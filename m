Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8039C290FF6
	for <lists+linux-api@lfdr.de>; Sat, 17 Oct 2020 08:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437057AbgJQGDD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 17 Oct 2020 02:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411017AbgJQGBh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 17 Oct 2020 02:01:37 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8610C0613D8
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:49 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id h31so2383825qtd.14
        for <linux-api@vger.kernel.org>; Fri, 16 Oct 2020 17:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aYpxhhD4duAO9de94sHUgpMd1KkZSLoauYX6InAb7u4=;
        b=MDFvcv8kICkTbf/GMxS+8dDS/nI24BnQvmD950uRJSZQtjFpYJ8JQX3iYflDX4RhKG
         E6jr1hd4kfwzPbMH11guRISx+bynQ6IHz42Hx1/v1wj5iEhnyJAsbId1qiqLcy9bsiGq
         8mRHapErUeyQxh4cEuXMJWtojjJBzam0dR3+NT6RK7fr/sO7u23NZ/qfS8zrbcGtDC8N
         wp9bx5R2ULxL7hSnQCBr6J11W/BwU9v4N22fmLL5lTAz9YsEwcVq/3ot721EK/7FTh/z
         TTadz0hp2avGn9qi936Xk+prrOTjqyie9dGSB0pXsizY17fTNco3NSP18Hs5ZJKsFdB8
         ptRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aYpxhhD4duAO9de94sHUgpMd1KkZSLoauYX6InAb7u4=;
        b=tmKz4AppA4RkMgZROqHnXM/TJob4k/fqgy1nVsgZmtEVWIe5mVtEH9soiziVPlieII
         BxfPN4XBuWGg7Nmb31q1wE8kwpaa9WFERxCXYBtHHkE/QHdI+E0OJb3n2onfyGTF2TTI
         T33NFvmUr+XuBKtn6VdiiERenew7rRFXwYKT/XhdFfRojnWbnQy3th83L0GYF7ZffbX2
         CN/E/y7CgxDlHxCUFbbvEsQ5a5ssayPGKI+zhryHa1i1cA/SITVgOoG5yGKwUKy1T48s
         FOmjGT5OYXhtu/+15c6cHryrmI1CF7c7WYsLZqFdJ6UJz8ZP7WjSLM6ekR2jMGx6gnby
         Pzxw==
X-Gm-Message-State: AOAM533Mr7eH4HI7BjXrzcV+/CyuGu9ryBno1yF/Hn7UE/yqdqcK4l0+
        gyLdH//KpvOa8zJOHNkzvfhd5rM=
X-Google-Smtp-Source: ABdhPJwtLLT+7jeckcyazP8ZzIw3ameejoqutON9ep2YPLeEb8YpJ3jXjGWYE3dIbDUd38bTxNu3gV0=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:ad4:4391:: with SMTP id s17mr6769291qvr.60.1602893568791;
 Fri, 16 Oct 2020 17:12:48 -0700 (PDT)
Date:   Fri, 16 Oct 2020 17:12:27 -0700
In-Reply-To: <cover.1602892799.git.pcc@google.com>
Message-Id: <24475691e22fafbeafb99bad819c2df200b0408a.1602892799.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1602892799.git.pcc@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH v12 2/8] parisc: start using signal-defs.h
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

We currently include signal-defs.h on all architectures except parisc.
Make parisc fall in line. This will make maintenance easier once the
flag bits are moved here.

Signed-off-by: Peter Collingbourne <pcc@google.com>
Acked-by: Helge Deller <deller@gmx.de>
Link: https://linux-review.googlesource.com/id/If03a5135fb514fe96548fb74610e6c3586a04064
---
 arch/parisc/include/uapi/asm/signal.h | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index d9c51769851a..9e6f87bc8a73 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -68,14 +68,7 @@
 #define MINSIGSTKSZ	2048
 #define SIGSTKSZ	8192
 
-
-#define SIG_BLOCK          0	/* for blocking signals */
-#define SIG_UNBLOCK        1	/* for unblocking signals */
-#define SIG_SETMASK        2	/* for setting the signal mask */
-
-#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
-#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
-#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
+#include <asm-generic/signal-defs.h>
 
 # ifndef __ASSEMBLY__
 
@@ -84,10 +77,6 @@
 /* Avoid too many header ordering problems.  */
 struct siginfo;
 
-/* Type of a signal handler.  */
-typedef void __signalfn_t(int);
-typedef __signalfn_t __user *__sighandler_t;
-
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-- 
2.29.0.rc1.297.gfa9743e501-goog

