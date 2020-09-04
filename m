Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB84925E2D6
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 22:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgIDUcg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 16:32:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42132 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgIDUc2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 16:32:28 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id C61EE29B03D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 9/9] doc: Document Syscall User Dispatch
Date:   Fri,  4 Sep 2020 16:31:47 -0400
Message-Id: <20200904203147.2908430-10-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904203147.2908430-1-krisman@collabora.com>
References: <20200904203147.2908430-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Explain the interface, provide some background and security notes.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 .../admin-guide/syscall-user-dispatch.rst     | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/admin-guide/syscall-user-dispatch.rst

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
new file mode 100644
index 000000000000..96616660fded
--- /dev/null
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -0,0 +1,87 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================
+Syscall User Dispatch
+=====================
+
+Background
+----------
+
+Compatibility layers like Wine need a way to efficiently emulate system
+calls of only a part of their process - the part that has the
+incompatible code - while being able to execute native syscalls without
+a high performance penalty on the native part of the process.  Seccomp
+falls short on this task, since it has limited support to efficiently
+filter syscalls based on memory regions, and it doesn't support removing
+filters.  Therefore a new mechanism is necessary.
+
+Syscall User Dispatch brings the filtering of the syscall dispatcher
+address back to userspace.  The application is in control of a flip
+switch, indicating the current personality of the process.  A
+multiple-personality application can then flip the switch without
+invoking the kernel, when crossing the compatibility layer API
+boundaries, to enable/disable the syscall redirection and execute
+syscalls directly (disabled) or send them to be emulated in userspace
+through a SIGSYS.
+
+The goal of this design is to provide very quick compatibility layer
+boundary crosses, which is achieved by not executing a syscall to change
+personality every time the compatibility layer executes.  Instead, a
+userspace memory region exposed to the kernel indicates the current
+personality, and the application simply modifies that variable to
+configure the mechanism.
+
+There is a relatively high cost associated with handling signals on most
+architectures, like x86, but at least for Wine, syscalls issued by
+native Windows code are currently not known to be a performance problem,
+since they are quite rare, at least for modern gaming applications.
+
+Since this mechanism is designed to capture syscalls issued by
+non-native applications, it must function on syscalls whose invocation
+ABI is completely unexpected to Linux.  Syscall User Dispatch, therefore
+doesn't rely on any of the syscall ABI to make the filtering.  It uses
+only the syscall dispatcher address and the userspace key.
+
+Interface
+---------
+
+A process can setup this mechanism on supported kernels
+CONFIG_SYSCALL_USER_DISPATCH) by executing the following prctl:
+
+   prctl(PR_SET_SYSCALL_USER_DISPATCH, <op>, <start_addr>, <end_addr>, [selector])
+
+<op> is either PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF, to enable and
+disable the mechanism globally for that thread.  When
+PR_SYS_DISPATCH_OFF is used, the other fields must be zero.
+
+<start_addr> and <end_addr> delimit a closed memory region interval from
+which syscalls are always executed directly, regardless of the userspace
+selector.  This provides a fast path for the C library, which includes
+the most common syscall dispatchers in the native code applications, and
+also provides a way for the signal handler to return without triggering
+a nested SIGSYS on (rt_)sigreturn.  Users of this interface should make
+sure that at least the signal trampoline code is included in this
+region. In addition, for syscalls that implement the trampoline code on
+the vDSO, that trampoline is never intercepted.
+
+[selector] is a pointer to a char-sized region in the process memory
+region, that provides a quick way to enable disable syscall redirection
+thread-wide, without the need to invoke the kernel directly.  selector
+can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
+value should terminate the program with a SIGSYS.
+
+Security Notes
+--------------
+
+Syscall User Dispatch provides functionality for compatibility layers to
+quickly capture system calls issued by a non-native part of the
+application, while not impacting the Linux native regions of the
+process.  It is not a mechanism for sandboxing system calls, and it
+should not be seen as a security mechanism, since it is trivial for a
+malicious application to subvert the mechanism by jumping to an allowed
+dispatcher region prior to executing the syscall, or to discover the
+address and modify the selector value.  If the use case requires any
+kind of security sandboxing, Seccomp should be used instead.
+
+Any fork or exec of the existing process resets the mechanism to
+PR_SYS_DISPATCH_OFF.
-- 
2.28.0

