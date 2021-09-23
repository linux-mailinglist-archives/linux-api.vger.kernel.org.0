Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4054C416423
	for <lists+linux-api@lfdr.de>; Thu, 23 Sep 2021 19:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbhIWRO7 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 13:14:59 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47274 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242705AbhIWROg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 13:14:36 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id A9F1D1F44614
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        mtk.manpages@gmail.com, Davidlohr Bueso <dave@stgolabs.net>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 22/22] futex2: Documentation: Document sys_futex_waitv() uAPI
Date:   Thu, 23 Sep 2021 14:11:11 -0300
Message-Id: <20210923171111.300673-23-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923171111.300673-1-andrealmeid@collabora.com>
References: <20210923171111.300673-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Create userspace documentation for futex_waitv() syscall, detailing how
the arguments are used.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 Documentation/userspace-api/futex2.rst | 86 ++++++++++++++++++++++++++
 Documentation/userspace-api/index.rst  |  1 +
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/futex2.rst

diff --git a/Documentation/userspace-api/futex2.rst b/Documentation/userspace-api/futex2.rst
new file mode 100644
index 000000000000..7d37409df355
--- /dev/null
+++ b/Documentation/userspace-api/futex2.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======
+futex2
+======
+
+:Author: André Almeida <andrealmeid@collabora.com>
+
+futex, or fast user mutex, is a set of syscalls to allow userspace to create
+performant synchronization mechanisms, such as mutexes, semaphores and
+conditional variables in userspace. C standard libraries, like glibc, uses it
+as a means to implement more high level interfaces like pthreads.
+
+futex2 is a followup version of the initial futex syscall, designed to overcome
+limitations of the original interface.
+
+User API
+========
+
+``futex_waitv()``
+-----------------
+
+Wait on an array of futexes, wake on any::
+
+  futex_waitv(struct futex_waitv *waiters, unsigned int nr_futexes,
+              unsigned int flags, struct timespec *timeout, clockid_t clockid)
+
+  struct futex_waitv {
+        __u64 val;
+        __u64 uaddr;
+        __u32 flags;
+        __u32 __reserved;
+  };
+
+Userspace sets an array of struct futex_waitv (up to a max of 128 entries),
+using ``uaddr`` for the address to wait for, ``val`` for the expected value
+and ``flags`` to specify the type (e.g. private) and size of futex.
+``__reserved`` needs to be 0, but it can be used for future extension. The
+pointer for the first item of the array is passed as ``waiters``. An invalid
+address for ``waiters`` or for any ``uaddr`` returns ``-EFAULT``.
+
+If userspace has 32-bit pointers, it should do a explicit cast to make sure
+the upper bits are zeroed. ``uintptr_t`` does the tricky and it works for
+both 32/64-bit pointers.
+
+``nr_futexes`` specifies the size of the array. Numbers out of [1, 128]
+interval will make the syscall return ``-EINVAL``.
+
+The ``flags`` argument of the syscall needs to be 0, but it can be used for
+future extension.
+
+For each entry in ``waiters`` array, the current value at ``uaddr`` is compared
+to ``val``. If it's different, the syscall undo all the work done so far and
+return ``-EAGAIN``. If all tests and verifications succeeds, syscall waits until
+one of the following happens:
+
+- The timeout expires, returning ``-ETIMEOUT``.
+- A signal was sent to the sleeping task, returning ``-ERESTARTSYS``.
+- Some futex at the list was awaken, returning the index of some waked futex.
+
+An example of how to use the interface can be found at ``tools/testing/selftests/futex/functional/futex_waitv.c``.
+
+Timeout
+-------
+
+``struct timespec *timeout`` argument is an optional argument that points to an
+absolute timeout. You need to specify the type of clock being used at
+``clockid`` argument. ``CLOCK_MONOTONIC`` and ``CLOCK_REALTIME`` are supported.
+This syscall accepts only 64bit timespec structs.
+
+Types of futex
+--------------
+
+A futex can be either private or shared. Private is used for processes that
+shares the same memory space and the virtual address of the futex will be the
+same for all processes. This allows for optimizations in the kernel. To use
+private futexes, it's necessary to specify ``FUTEX_PRIVATE_FLAG`` in the futex
+flag. For processes that doesn't share the same memory space and therefore can
+have different virtual addresses for the same futex (using, for instance, a
+file-backed shared memory) requires different internal mechanisms to be get
+properly enqueued. This is the default behavior, and it works with both private
+and shared futexes.
+
+Futexes can be of different sizes: 8, 16, 32 or 64 bits. Currently, the only
+supported one is 32 bit sized futex, and it need to be specified using
+``FUTEX_32`` flag.
diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index c432be070f67..a61eac0c73f8 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -28,6 +28,7 @@ place where this information is gathered.
    media/index
    sysfs-platform_profile
    vduse
+   futex2
 
 .. only::  subproject and html
 
-- 
2.33.0

