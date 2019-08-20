Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA689528E
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2019 02:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfHTATx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 20:19:53 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52604 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729143AbfHTATI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 20:19:08 -0400
Received: by mail-vs1-f74.google.com with SMTP id w2so1385381vso.19
        for <linux-api@vger.kernel.org>; Mon, 19 Aug 2019 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Xx9Xy1LVHNW0tgTSSnVwIoZL9BHfKDcopwVECPb1wsc=;
        b=F/yPzpVt2wy+/RI8gQkTjcBM7pMdfOqXRs/Rcx+HXbPreTgnQ44pNYo0mDGDUxvGEX
         bEWLJ9FU/qcn5HXlisW13gVjagvurjM7pXRJDLFO3k0QBYCIGITFcWsSSLhvoSXZhZ4v
         zf/nuuJTriWiZ1FX8j5uaG8iyW6Tq8BCyiQrxilehohXoQjUKJTcI7b92Q+sV+IRM3eb
         gsu02kbge5xj064n08ySG2E0hadOem6mN26HMordi9Z3QSRdBgmpiSuP/uu7ZDxdm5pm
         /ex9tUgx95/DmzWh00bg/8OYGi0Y5GIbzkzb0djk5Qvro5V/+6OpxnvCdu8sR6WlEcQD
         z62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Xx9Xy1LVHNW0tgTSSnVwIoZL9BHfKDcopwVECPb1wsc=;
        b=hx7X+XsOsjF3hwYyQE2AD8wzObhqJMGiJG+vv6tHMH5GL4H1U90IMBDc+8JZmPXUB/
         RfmC17sWNa5diKtfunc64zrb6FVeaV//OePXch43h6ldp/PuWRVFRVX17ZMir7Od0n/B
         Q/+dlRMBaDtu9SLGpf0ygHKNvyTqmYa5bqv/pr6TTyKXVi3BhKh5smuwkRhkw0Y+VQJ8
         8WIPoVgpD6oheHEFaa9PU2NmwzCLlxJIxls1Bv363d29uYrzhVgQj9/cNGT2TaQUyh6S
         hwZahPRinr8lbcWsr+PZE83OSOqMw0OrLhXD31BWWzOXFzP0n09oLH2QS8vbzTR1kRtD
         Y50Q==
X-Gm-Message-State: APjAAAW6xmD1BSBXzFQ/SnKLVN+f6/5LOgqjykd9x1wkH5iOth4C4304
        aBPO3LEUHgTds+69iX+OktaIUX4cPL9RI6wF2AUGQg==
X-Google-Smtp-Source: APXvYqyflZ+iCWxBsvHiYwKTezANKF/iZUuKUhXjSOpdFAAPQb73YcqwsuEdzoBQl/jf+20nh/mNpSEz6S9+q3d7ROeUiw==
X-Received: by 2002:ab0:67d6:: with SMTP id w22mr15722265uar.68.1566260347590;
 Mon, 19 Aug 2019 17:19:07 -0700 (PDT)
Date:   Mon, 19 Aug 2019 17:17:58 -0700
In-Reply-To: <20190820001805.241928-1-matthewgarrett@google.com>
Message-Id: <20190820001805.241928-23-matthewgarrett@google.com>
Mime-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH V40 22/29] lockdown: Lock down tracing and perf kprobes when
 in confidentiality mode
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

From: David Howells <dhowells@redhat.com>

Disallow the creation of perf and ftrace kprobes when the kernel is
locked down in confidentiality mode by preventing their registration.
This prevents kprobes from being used to access kernel memory to steal
crypto data, but continues to allow the use of kprobes from signed
modules.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: davem@davemloft.net
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: James Morris <jmorris@namei.org>
---
 include/linux/security.h     | 1 +
 kernel/trace/trace_kprobe.c  | 5 +++++
 security/lockdown/lockdown.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 669e8de5299d..0b2529dbf0f4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -117,6 +117,7 @@ enum lockdown_reason {
 	LOCKDOWN_MMIOTRACE,
 	LOCKDOWN_INTEGRITY_MAX,
 	LOCKDOWN_KCORE,
+	LOCKDOWN_KPROBES,
 	LOCKDOWN_CONFIDENTIALITY_MAX,
 };
 
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 7d736248a070..fcb28b0702b2 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -11,6 +11,7 @@
 #include <linux/uaccess.h>
 #include <linux/rculist.h>
 #include <linux/error-injection.h>
+#include <linux/security.h>
 
 #include "trace_dynevent.h"
 #include "trace_kprobe_selftest.h"
@@ -415,6 +416,10 @@ static int __register_trace_kprobe(struct trace_kprobe *tk)
 {
 	int i, ret;
 
+	ret = security_locked_down(LOCKDOWN_KPROBES);
+	if (ret)
+		return ret;
+
 	if (trace_probe_is_registered(&tk->tp))
 		return -EINVAL;
 
diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 403b30357f75..27b2cf51e443 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -32,6 +32,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
 	[LOCKDOWN_MMIOTRACE] = "unsafe mmio",
 	[LOCKDOWN_INTEGRITY_MAX] = "integrity",
 	[LOCKDOWN_KCORE] = "/proc/kcore access",
+	[LOCKDOWN_KPROBES] = "use of kprobes",
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

