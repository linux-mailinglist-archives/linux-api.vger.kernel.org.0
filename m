Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43F2B1460
	for <lists+linux-api@lfdr.de>; Fri, 13 Nov 2020 03:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgKMCqO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 12 Nov 2020 21:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgKMCqO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Nov 2020 21:46:14 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E668C0613D6
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v13so4490424ybe.18
        for <linux-api@vger.kernel.org>; Thu, 12 Nov 2020 18:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ygGnL3mRCd+dIJRzIWujb3ScKZ0x4r/fVg2nxqC4gq4=;
        b=Cn/9D3WNAZBE7X4G+PG6zFUg4eCliD8JAHztfW+2/RuVatICsGU50UCABOAeCrVCUA
         Z65WJ9/vr7B9In4uExKDiTY+VsOHjr9qlV+QmPMRq6DNNtT7Gj06fVIVy4C8cR0mHRu9
         jdiB6mV0JUc0hxwoW//wwB8peg0ArEnJxaBNNqqP++M4tvMdk6pTpBhuYp0CXgat9E5H
         vFPBO0B/Uc884GkkVe3F3PEakSNTKDscpVy5pmOPuhYAv/xA83zrN1cNln2MgTatVlsc
         hLgTSgxFFSiUp97/bNCBdq33F/uTRHskpMlshbwdfcHwIwk8ddSOdu1nv+ylfzG0Vc65
         N3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ygGnL3mRCd+dIJRzIWujb3ScKZ0x4r/fVg2nxqC4gq4=;
        b=JF0bNcJU49e4V4NTKt55Aqd4EdVrjm2uujbDTjqRIDpZApaumhcG/NjWJiZ5yMNFsL
         yAn5xzx6RRf3CnV+W67QeNHSfT6LsXvK7Rq9O1jHviJnNmPQB78oJWgvu8jyIndHVZa1
         C6kpPSX4byubRUCKGHiV9DIkSws5tLTVuTVDw5bIemu9hM/tVyD6F32qUcw8+QQ9Gyr/
         FapP57MIwYobVdBVBrk0rRiu8jUifJNNMShkmY4ekj49403mMHgQ+swWUsehpMRKNjhl
         BDKInyI52jo3UgAp5K5VmVkLY8qM5VLmRgOslUKk5wJWOL/1+msRi1O9kHrT/lhwbIED
         dkew==
X-Gm-Message-State: AOAM531Dli6ckGPMcSz1n6IhR4LjDUdL7iYbDYShX3fQbO0Q3UmzYRU3
        5v0NJ5wRx4K5uoWgXPdCa85o+ok=
X-Google-Smtp-Source: ABdhPJw/c1G7e+0UcYC46FTxSIXt5iwxVrv7iFV6TjcbN7r5kualmCR80+cGk7tUP6tMS7SIYX1MoOs=
Sender: "pcc via sendgmr" <pcc@pcc-desktop.svl.corp.google.com>
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:0:7220:84ff:fe09:385a])
 (user=pcc job=sendgmr) by 2002:a25:4095:: with SMTP id n143mr122463yba.106.1605235573532;
 Thu, 12 Nov 2020 18:46:13 -0800 (PST)
Date:   Thu, 12 Nov 2020 18:46:02 -0800
In-Reply-To: <cover.1605235488.git.pcc@google.com>
Message-Id: <a75b8eb7bb9eac1cf73fb119eb53e5892d6e9656.1605235488.git.pcc@google.com>
Mime-Version: 1.0
References: <cover.1605235488.git.pcc@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v15 1/6] parisc: Drop parisc special case for __sighandler_t
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

From: Helge Deller <deller@gmx.de>

I believe we can and *should* drop this parisc-specific typedef for
__sighandler_t when compiling a 64-bit kernel. The reasons:

1. We don't have a 64-bit userspace yet, so nothing (on userspace side)
can break.

2. Inside the Linux kernel, this is only used in kernel/signal.c, in
function kernel_sigaction() where the signal handler is compared against
SIG_IGN.  SIG_IGN is defined as (__sighandler_t)1), so only the pointers
are compared.

3. Even when a 64-bit userspace gets added at some point, I think
__sighandler_t should be defined what it is: a function pointer struct.

I compiled kernel/signal.c with and without the patch, and the produced code
is identical in both cases.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Reviewed-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I21c43f21b264f339e3aa395626af838646f62d97
---
 arch/parisc/include/uapi/asm/signal.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index e605197b462c..d9c51769851a 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -85,16 +85,8 @@
 struct siginfo;
 
 /* Type of a signal handler.  */
-#if defined(__LP64__)
-/* function pointers on 64-bit parisc are pointers to little structs and the
- * compiler doesn't support code which changes or tests the address of
- * the function in the little struct.  This is really ugly -PB
- */
-typedef char __user *__sighandler_t;
-#else
 typedef void __signalfn_t(int);
 typedef __signalfn_t __user *__sighandler_t;
-#endif
 
 typedef struct sigaltstack {
 	void __user *ss_sp;
-- 
2.29.2.299.gdc1121823c-goog

