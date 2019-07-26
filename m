Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C13476EE7
	for <lists+linux-api@lfdr.de>; Fri, 26 Jul 2019 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbfGZQWc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 26 Jul 2019 12:22:32 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:43461 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfGZQWc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 26 Jul 2019 12:22:32 -0400
Received: by mail-pl1-f201.google.com with SMTP id t2so28707806plo.10
        for <linux-api@vger.kernel.org>; Fri, 26 Jul 2019 09:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tjhcSRmIRXUILRS/jy/QiJdV3Z5E1s7xQzD5RJUqH7Q=;
        b=UO4hLjUItbB6ULBWQOmwqIJJ0t3923sVzDDDeStO7mSA/Bh+vF+0trnk/xlQZkqI5C
         iwYyPjMiVPlMRR5k+6Hrq87bXuZjU3ZDHWJSBrvBn0Ez1BWq6Rc9z0Ys3mLzmdFxg25y
         duGoe/AzBtiUob6yFfepgE9R9RJ0LITqZpkSpPt8YAfB2ZPGq1tjefoHVcNcwUqg9l7U
         Od5f5FjeOMOVeX5z4wWU8swRAndpFG7hfnKGzp/yOUAzC3sBjyITLPaYlUI8uUTOnwDt
         LV6seuE0PvYIcvQJkpR7uceH3Xr9cOOomgV23HvZjLFmQZdHjT0AMWLagTetoWDrTUxC
         OKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tjhcSRmIRXUILRS/jy/QiJdV3Z5E1s7xQzD5RJUqH7Q=;
        b=f5iMmyR/gCkl62KGi9Gym9hBH2Wq1rIIo9BwmpR5EC6Rtd7ngmL/dBsX81i8Elt4Ba
         IjWkgUI60n/BoDqlubl7jP6V+7Hj1Tkrn1DrzSxO5ko4ejfBJl0IdBp6hk/+vCRSYa0E
         vpsu9EfyOPIPv44c9WZBF48ePLYN0f4Lgia03Or0OABKGBUd/nvIO6SWun2xfgWVHxx4
         WEETFzgUQoj3h/H9d+gh9pGhurvLX6h6I/Ke1ap9qbKBHMRzBeNqk1jmFxkAMCFUtdOY
         r0fx5uaD/I/iXbybOXinZQGCwxoQ84YOVpAPMaoVvQCyP6Iwl0XghorE/3vz1RRd+zXq
         gt9w==
X-Gm-Message-State: APjAAAXcJN3YCtZ96n+0gTQp8/ZCoISTIilLfjfLhv8fsS3bQ7Jj+JL/
        bvkZOEA8zVaa7PHAfY+rgcGlNvRqTWU=
X-Google-Smtp-Source: APXvYqwRGZjimDoN0Ifg4KsikRTFzC8uTbFRXzYuLY+8ZFeCLXhnSEodDmSJP55fWDQxYndQvdCSxD1e+sQ=
X-Received: by 2002:a65:4808:: with SMTP id h8mr91147086pgs.22.1564158150843;
 Fri, 26 Jul 2019 09:22:30 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:22:25 -0700
Message-Id: <20190726162226.252750-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH v3 1/2] tests: move common definitions and functions into pidfd.h
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
Reviewed-by: Christian Brauner <christian@brauner.io>
---
Changes since v1 (https://lore.kernel.org/linux-kselftest/20190723173907.196488-1-surenb@google.com)
	- Move common test definitions and functions into pidfd.h as per Christian Brauner
	- Code cleanup and additional error handling as per Christian Brauner
Changes since v2 (https://lore.kernel.org/linux-kselftest/20190725002204.185225-2-surenb@google.com)
	- Added waitpid to prevent zombies as per Yann Droneaud

Patches are based on v5.3-rc1 in Linus' tree.
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

