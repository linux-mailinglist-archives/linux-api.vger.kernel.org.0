Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007823E3276
	for <lists+linux-api@lfdr.de>; Sat,  7 Aug 2021 03:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhHGBBw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 21:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhHGBBv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 21:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628298094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZHKTu8mLlmvqP5/EG23Ge70ypLYDuqHlMFMJ1YrpXI0=;
        b=YULRD40tvCVqGrQAdsY+jdvWkGhANlYZI5xD2ZTEFCyJa0ANlaMJhLctpOFvgvF43YtOVC
        lmgFPVB6lKifisxWJbTGGpEmJ7Qq0YMOJUoWREV7av472ESbBT0GDefE+9sAkv+623/hOB
        t6lftix61rMCu/i3eO/GPoF5cAXMtGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-MLtUEOIENFu489mkHhdK6w-1; Fri, 06 Aug 2021 21:01:32 -0400
X-MC-Unique: MLtUEOIENFu489mkHhdK6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7374F801AE7;
        Sat,  7 Aug 2021 01:01:30 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C8EF119CBA;
        Sat,  7 Aug 2021 01:01:23 +0000 (UTC)
Date:   Sat, 7 Aug 2021 03:01:23 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Dmitry V. Levin" <ldv@strace.io>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] uapi: expose enum pid_type
Message-ID: <20210807010123.GA5174@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Commit 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
made use of enum pid_type in prctl's arg4; this type and the associated
enumeration definitions are not exposed to userspace.  Try to fix that
by providing enum _kernel_pid_type and tying in-kernel enum pid_type
definitions to it.  Note that enum pid_type cannot be exposed as is,
since "enum pid_type" is already exists in various projects [1] (notably
gcc and strace), and "enum __pid_type" is defined by glibc and uclibc
for fcntl(F_SETOWN_EX) owner ID type.

[1] https://codesearch.debian.net/search?q=enum+pid_type

Complements: 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 .../admin-guide/hw-vuln/core-scheduling.rst          |  7 ++++---
 include/linux/pid.h                                  | 12 +++++++-----
 include/uapi/linux/pid.h                             | 20 ++++++++++++++++++++
 include/uapi/linux/prctl.h                           |  1 +
 4 files changed, 32 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/linux/pid.h

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index 7b410ae..3eb2b7c 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -61,9 +61,10 @@ arg3:
     ``pid`` of the task for which the operation applies.
 
 arg4:
-    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
-    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
-    will be performed for all tasks in the task group of ``pid``.
+    ``pid_type`` for which the operation applies. It is of type
+    ``enum __kernel_pid_type``.  For example, if arg4 is ``__PIDTYPE_TGID``,
+    then the operation of this command will be performed for all tasks
+    in the task group of ``pid``.
 
 arg5:
     userspace pointer to an unsigned long for storing the cookie returned by
diff --git a/include/linux/pid.h b/include/linux/pid.h
index fa10acb..f8ca4c9 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -5,14 +5,16 @@
 #include <linux/rculist.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
+#include <uapi/linux/pid.h>
 
 enum pid_type
 {
-	PIDTYPE_PID,
-	PIDTYPE_TGID,
-	PIDTYPE_PGID,
-	PIDTYPE_SID,
-	PIDTYPE_MAX,
+	PIDTYPE_PID = __PIDTYPE_PID,
+	PIDTYPE_TGID = __PIDTYPE_TGID,
+	PIDTYPE_PGID = __PIDTYPE_PGID,
+	PIDTYPE_SID = __PIDTYPE_SID,
+
+	PIDTYPE_MAX = __PIDTYPE_MAX
 };
 
 /*
diff --git a/include/uapi/linux/pid.h b/include/uapi/linux/pid.h
new file mode 100644
index 0000000..91d08e4
--- /dev/null
+++ b/include/uapi/linux/pid.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_PID_H
+#define _UAPI_LINUX_PID_H
+
+/*
+ * Type of process-related ID.  So far, it is used only for prctl(PR_SCHED_CORE);
+ * not to be confused with type field of f_owner_ex structure argument
+ * of fcntl(F_SETOWN_EX).
+ */
+enum __kernel_pid_type
+{
+	__PIDTYPE_PID,
+	__PIDTYPE_TGID,
+	__PIDTYPE_PGID,
+	__PIDTYPE_SID,
+
+	__PIDTYPE_MAX /* Non-UAPI */
+};
+
+#endif /* _UAPI_LINUX_PID_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 967d9c5..4e794aa 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -3,6 +3,7 @@
 #define _LINUX_PRCTL_H
 
 #include <linux/types.h>
+#include <linux/pid.h> /* enum __kernel_pid_type */
 
 /* Values to pass as first argument to prctl() */
 
-- 
2.1.4

