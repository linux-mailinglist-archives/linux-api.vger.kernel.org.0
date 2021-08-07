Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797FE3E3545
	for <lists+linux-api@lfdr.de>; Sat,  7 Aug 2021 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhHGMJh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 7 Aug 2021 08:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232076AbhHGMJf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 7 Aug 2021 08:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628338158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=d4TYSd02mzRf2TIB1Frp8TU56Sr3Vj8VyK7Z22hB08c=;
        b=bA4uPMMagZ4Uq3+61ELaIQFZab9Toffp4X8hycYjODuDbY2W6rFAoctAAxHVwL52im04+Z
        MD3hYYxJujnFoMoIGwQKMY/6VZqQECvd11deoYfpYtqTC0bLV/Icv6M4XJPN7q/yQzHoeJ
        4WJv3wCICdaDpCAjyag+16PZpV549tc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-3UeGjiDeNNGt-XnzFrDjow-1; Sat, 07 Aug 2021 08:09:14 -0400
X-MC-Unique: 3UeGjiDeNNGt-XnzFrDjow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0342871805;
        Sat,  7 Aug 2021 12:09:12 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 057CA60C59;
        Sat,  7 Aug 2021 12:09:05 +0000 (UTC)
Date:   Sat, 7 Aug 2021 14:09:05 +0200
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
Subject: [PATCH v3] uapi: expose enum pid_type as enum __kernel_pidtype
Message-ID: <20210807120905.GA14706@asgard.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Commit 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
made use of enum pid_type in prctl's arg4;  however, this type
and the associated enumeration definitions are not exposed to userspace.
Try to fix that by providing enum __kernel_pidtype and tying in-kernel
enum pid_type definitions to it.  Note that enum pid_type cannot be exposed
as is, since "enum pid_type" is already exists in various projects [1]
(notably gcc and strace), and "enum __pid_type" is defined by glibc and uclibc
for fcntl(F_SETOWN_EX) owner ID type;  there is also __kernel_pid_t,
that looks too similar to __kernel_pid_type.

[1] https://codesearch.debian.net/search?q=enum+pid_type

Complements: 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
v3:
  - Fixed header guard macro: s/_UAPI_LINUX_PID_H/_UAPI_LINUX_PIDTYPE_H/,
    as noted by Dmitry Levin.

v2: https://lore.kernel.org/lkml/20210807104800.GA22620@asgard.redhat.com/
  - Header file is renamed from pid.h to pidtype.h to avoid collisions
    with include/linux/pid.h when included from uapi headers;
  - The enum type has renamed from __kernel_pid_type to __kernel_pidtype
    to avoid possible confusion with __kernel_pid_t.

v1: https://lore.kernel.org/lkml/20210807010123.GA5174@asgard.redhat.com/
---
 .../admin-guide/hw-vuln/core-scheduling.rst          |  7 ++++---
 include/linux/pid.h                                  | 12 +++++++-----
 include/uapi/linux/pidtype.h                         | 20 ++++++++++++++++++++
 include/uapi/linux/prctl.h                           |  1 +
 4 files changed, 32 insertions(+), 8 deletions(-)
 create mode 100644 include/uapi/linux/pidtype.h

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index 7b410ae..0989c48 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -61,9 +61,10 @@ arg3:
     ``pid`` of the task for which the operation applies.
 
 arg4:
-    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
-    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
-    will be performed for all tasks in the task group of ``pid``.
+    ``pid_type`` for which the operation applies. It is of type
+    ``enum __kernel_pidtype``.  For example, if arg4 is ``__PIDTYPE_TGID``,
+    then the operation of this command will be performed for all tasks
+    in the task group of ``pid``.
 
 arg5:
     userspace pointer to an unsigned long for storing the cookie returned by
diff --git a/include/linux/pid.h b/include/linux/pid.h
index fa10acb..57cce71 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -5,14 +5,16 @@
 #include <linux/rculist.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
+#include <uapi/linux/pidtype.h>
 
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
diff --git a/include/uapi/linux/pidtype.h b/include/uapi/linux/pidtype.h
new file mode 100644
index 0000000..759aa29
--- /dev/null
+++ b/include/uapi/linux/pidtype.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_PIDTYPE_H
+#define _UAPI_LINUX_PIDTYPE_H
+
+/*
+ * Type of a process-related ID.  So far, it is used only
+ * for prctl(PR_SCHED_CORE);  not to be confused with type field
+ * of f_owner_ex structure argument of fcntl(F_SETOWN_EX).
+ */
+enum __kernel_pidtype
+{
+	__PIDTYPE_PID,
+	__PIDTYPE_TGID,
+	__PIDTYPE_PGID,
+	__PIDTYPE_SID,
+
+	__PIDTYPE_MAX /* Non-UAPI */
+};
+
+#endif /* _UAPI_LINUX_PIDTYPE_H */
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 967d9c5..0af570b 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -3,6 +3,7 @@
 #define _LINUX_PRCTL_H
 
 #include <linux/types.h>
+#include <linux/pidtype.h> /* enum __kernel_pidtype */
 
 /* Values to pass as first argument to prctl() */
 
-- 
2.1.4

