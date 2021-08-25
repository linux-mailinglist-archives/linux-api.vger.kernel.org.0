Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7010C3F7B29
	for <lists+linux-api@lfdr.de>; Wed, 25 Aug 2021 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbhHYRHM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Aug 2021 13:07:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241872AbhHYRHL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Aug 2021 13:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629911185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=gpUKC5h8J10ybyvZDqljNfqjwgKTySHJSQK0IjTg2II=;
        b=iueABD+a0TjAOVkgcv9XdbuWN8eoN+gYomP15ktadt2yZxQ4C+tc+d71ZuMYUkZfcdba+r
        XatjFE1bC7+Y3yHTtoMtxyxFQfA8eHyqfkAxM6XJXar6SeaJpun0xkFSsRUcUqzxed/HO6
        GDm3ZhvE3UvyRPSjHRhVH7gLL4uSdAw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-9c4mkFDsP1WkbHzUj8Z4Jw-1; Wed, 25 Aug 2021 13:06:23 -0400
X-MC-Unique: 9c4mkFDsP1WkbHzUj8Z4Jw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B18239381;
        Wed, 25 Aug 2021 17:06:21 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E7001346F;
        Wed, 25 Aug 2021 17:06:16 +0000 (UTC)
Date:   Wed, 25 Aug 2021 19:06:13 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Chris Hyser <chris.hyser@oracle.com>,
        Josh Don <joshdon@google.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Dmitry V. Levin" <ldv@strace.io>, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v4] uapi/linux/prctl: provide macro definitions for the
 PR_SCHED_CORE type argument
Message-ID: <20210825170613.GA3884@asgard.redhat.com>
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
enumeration definitions are not exposed to userspace.  Christian
has suggested to provide additional macro definitions that convey
the meaning of the type argument more in alignment with its actual
usage, and this patch does exactly that.

Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Complements: 7ac592aa35a684ff ("sched: prctl() core-scheduling interface")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
v4:
  - Rewritten in accordance with Christian Brauner's suggestion to provide
    macro definitions that are explicitly tailored for the prctl op.

v3: https://lore.kernel.org/lkml/20210807120905.GA14706@asgard.redhat.com/
  - Fixed header guard macro: s/_UAPI_LINUX_PID_H/_UAPI_LINUX_PIDTYPE_H/,
    as noted by Dmitry Levin.

v2: https://lore.kernel.org/lkml/20210807104800.GA22620@asgard.redhat.com/
  - Header file is renamed from pid.h to pidtype.h to avoid collisions
    with include/linux/pid.h when included from uapi headers;
  - The enum type has renamed from __kernel_pid_type to __kernel_pidtype
    to avoid possible confusion with __kernel_pid_t.

v1: https://lore.kernel.org/lkml/20210807010123.GA5174@asgard.redhat.com/
---
 Documentation/admin-guide/hw-vuln/core-scheduling.rst | 5 +++--
 include/uapi/linux/prctl.h                            | 3 +++
 kernel/sched/core_sched.c                             | 4 ++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
index 7b410ae..9a65fed 100644
--- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
+++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
@@ -61,8 +61,9 @@ arg3:
     ``pid`` of the task for which the operation applies.
 
 arg4:
-    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
-    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
+    ``pid_type`` for which the operation applies. It is one of
+    ``PR_SCHED_CORE_SCOPE_``-prefixed macro constants.  For example, if arg4
+    is ``PR_SCHED_CORE_SCOPE_THREAD_GROUP``, then the operation of this command
     will be performed for all tasks in the task group of ``pid``.
 
 arg5:
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 967d9c5..644a3b4 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -266,5 +266,8 @@ struct prctl_mm_map {
 # define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
 # define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
 # define PR_SCHED_CORE_MAX		4
+# define PR_SCHED_CORE_SCOPE_THREAD		0
+# define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
+# define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sched/core_sched.c b/kernel/sched/core_sched.c
index 9a80e9a..20f6409 100644
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -134,6 +134,10 @@ int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
 	if (!static_branch_likely(&sched_smt_present))
 		return -ENODEV;
 
+	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_THREAD != PIDTYPE_PID);
+	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_THREAD_GROUP != PIDTYPE_TGID);
+	BUILD_BUG_ON(PR_SCHED_CORE_SCOPE_PROCESS_GROUP != PIDTYPE_PGID);
+
 	if (type > PIDTYPE_PGID || cmd >= PR_SCHED_CORE_MAX || pid < 0 ||
 	    (cmd != PR_SCHED_CORE_GET && uaddr))
 		return -EINVAL;
-- 
2.1.4

