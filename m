Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808D274287
	for <lists+linux-api@lfdr.de>; Thu, 25 Jul 2019 02:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfGYAWJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jul 2019 20:22:09 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:43081 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbfGYAWI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jul 2019 20:22:08 -0400
Received: by mail-pf1-f202.google.com with SMTP id 6so29662393pfz.10
        for <linux-api@vger.kernel.org>; Wed, 24 Jul 2019 17:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1GKbn44rCmbF+NrvL+wZV1RLlesXhBkZKOH/YO/9ZL8=;
        b=XKMX+YyPNvmsF5QebU46Pq01VSV5R5z3MWRBqYUeF6pAvLDFvb/7L+/MXvhjj6AU+t
         WT83PwJQAr1fN2R8/x2DQ9hGx4NdXNWB6dOgYzIiwZWq5hLWOTFSNQ5H4jQv8Oqrb3gq
         1XDynlhlGSTS8Pf5JHrpP94V6O9b2yhOOrjMJf9uWYEfcmJ/bCtBjEdpGnU446jiUFfu
         2agZ4adS0HsOaaYTvSvYaInnXD1FMuO3AMJ/quZvPEi+mG6OzHw+xsaTloMwSKO0eect
         OTI8f5kP9PooRR/uH9cubdGVBLmUkB5PQ3Qyk249tWedggPE8Kq37uJEKnOE6LiVFFjJ
         RcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1GKbn44rCmbF+NrvL+wZV1RLlesXhBkZKOH/YO/9ZL8=;
        b=B6ap5tJhLOVtGj8I5+AGK+lL37bV/1uLJ+cu++QqHuiX7s8nR6vxxuF06qB9rt7TFr
         pjryi+xdqmdyRF00B6XFPVHhyUm4q6zDjNI0PKPoMNyAM+l4b03WyfK8fINW6dOVnFAp
         vvGWkIo0Eav53M38LYOupWb9sO0o7SXSqGzhuHSMAUCp+aAhCsil5xDPQHQxdOCMUWcN
         e18R7rZe1jRPdpis9+oSrAveLaVgYLKRaJNFqRJQQ5B38hlzf8au3nDPYDVtMOuvsVW/
         UiSeiCHVgjhx0E1On/0TMLj4Vf34U3R9MM8cTp9Yz5C11esul+wH4/ZTQNUfMjSqmjOI
         B9PA==
X-Gm-Message-State: APjAAAV6I5vUT69PgZkwJBfTlE4jBgmlwaqLhdgQtlhQep5GlDEwJiaH
        zbnRDS72LN9KJ2FU54Ext8BhJy2iv+8=
X-Google-Smtp-Source: APXvYqxgpap+Da/0nN2jtubJq52d0L5czbF6C1p4jc50Cm+i12S26ak7LaIN/05FA/yW5pN0RIw3DSEWgYg=
X-Received: by 2002:a63:e14d:: with SMTP id h13mr83876881pgk.431.1564014127785;
 Wed, 24 Jul 2019 17:22:07 -0700 (PDT)
Date:   Wed, 24 Jul 2019 17:22:03 -0700
Message-Id: <20190725002204.185225-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v2 1/2] tests: move common definitions and functions into pidfd.h
From:   Suren Baghdasaryan <surenb@google.com>
To:     surenb@google.com
Cc:     christian@brauner.io, arnd@arndb.de, ebiederm@xmission.com,
        keescook@chromium.org, joel@joelfernandes.org, dancol@google.com,
        tglx@linutronix.de, jannh@google.com, dhowells@redhat.com,
        mtk.manpages@gmail.com, luto@kernel.org, akpm@linux-foundation.org,
        oleg@redhat.com, cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Move definitions and functions used across different pidfd tests into
pidfd.h header.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/pidfd/pidfd.h          | 18 ++++++++++++++++++
 .../testing/selftests/pidfd/pidfd_open_test.c  |  5 -----
 tools/testing/selftests/pidfd/pidfd_test.c     | 10 ----------
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index 8452e910463f..db4377af6be7 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -16,6 +16,14 @@
 
 #include "../kselftest.h"
 
+#ifndef __NR_pidfd_open
+#define __NR_pidfd_open -1
+#endif
+
+#ifndef __NR_pidfd_send_signal
+#define __NR_pidfd_send_signal -1
+#endif
+
 /*
  * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
  * That means, when it wraps around any pid < 300 will be skipped.
@@ -53,5 +61,15 @@ int wait_for_pid(pid_t pid)
 	return WEXITSTATUS(status);
 }
 
+static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
+{
+	return syscall(__NR_pidfd_open, pid, flags);
+}
+
+static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
+					unsigned int flags)
+{
+	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
+}
 
 #endif /* __PIDFD_H */
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index 0377133dd6dc..b9fe75fc3e51 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -22,11 +22,6 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
-static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
-{
-	return syscall(__NR_pidfd_open, pid, flags);
-}
-
 static int safe_int(const char *numstr, int *converted)
 {
 	char *err = NULL;
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index 7eaa8a3de262..17b2fd621726 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -21,10 +21,6 @@
 #include "pidfd.h"
 #include "../kselftest.h"
 
-#ifndef __NR_pidfd_send_signal
-#define __NR_pidfd_send_signal -1
-#endif
-
 #define str(s) _str(s)
 #define _str(s) #s
 #define CHILD_THREAD_MIN_WAIT 3 /* seconds */
@@ -47,12 +43,6 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
-					unsigned int flags)
-{
-	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
-}
-
 static int signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
-- 
2.22.0.709.g102302147b-goog

