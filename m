Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D1D23925
	for <lists+linux-api@lfdr.de>; Mon, 20 May 2019 16:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390731AbfETOAw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 May 2019 10:00:52 -0400
Received: from relay.sw.ru ([185.231.240.75]:39774 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390323AbfETOAv (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 May 2019 10:00:51 -0400
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hSipj-00082Z-CF; Mon, 20 May 2019 17:00:07 +0300
Subject: [PATCH v2 1/7] mm: Add process_vm_mmap() syscall declaration
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        ktkhai@virtuozzo.com, mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Mon, 20 May 2019 17:00:07 +0300
Message-ID: <155836080726.2441.11153759042802992469.stgit@localhost.localdomain>
In-Reply-To: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Similar to process_vm_readv() and process_vm_writev(),
add declarations of a new syscall, which will allow
to map memory from or to another process.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl |    2 ++
 include/linux/syscalls.h               |    5 +++++
 include/uapi/asm-generic/unistd.h      |    5 ++++-
 init/Kconfig                           |    9 +++++----
 kernel/sys_ni.c                        |    2 ++
 6 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index ad968b7bac72..99d6e0085576 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -438,3 +438,4 @@
 431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
 432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
 433	i386	fspick			sys_fspick			__ia32_sys_fspick
+434	i386	process_vm_mmap		sys_process_vm_mmap		__ia32_compat_sys_process_vm_mmap
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index b4e6f9e6204a..46d7d2898f7a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -355,6 +355,7 @@
 431	common	fsconfig		__x64_sys_fsconfig
 432	common	fsmount			__x64_sys_fsmount
 433	common	fspick			__x64_sys_fspick
+434	common	process_vm_mmap		__x64_sys_process_vm_mmap
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -398,3 +399,4 @@
 545	x32	execveat		__x32_compat_sys_execveat/ptregs
 546	x32	preadv2			__x32_compat_sys_preadv64v2
 547	x32	pwritev2		__x32_compat_sys_pwritev64v2
+548	x32	process_vm_mmap		__x32_compat_sys_process_vm_mmap
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index e2870fe1be5b..7d8ae36589cf 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -997,6 +997,11 @@ asmlinkage long sys_fspick(int dfd, const char __user *path, unsigned int flags)
 asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 				       siginfo_t __user *info,
 				       unsigned int flags);
+asmlinkage long sys_process_vm_mmap(pid_t pid,
+				    unsigned long src_addr,
+				    unsigned long len,
+				    unsigned long dst_addr,
+				    unsigned long flags);
 
 /*
  * Architecture-specific system calls
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index a87904daf103..b7aaa5ae02da 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -844,9 +844,12 @@ __SYSCALL(__NR_fsconfig, sys_fsconfig)
 __SYSCALL(__NR_fsmount, sys_fsmount)
 #define __NR_fspick 433
 __SYSCALL(__NR_fspick, sys_fspick)
+#define __NR_process_vm_mmap 424
+__SC_COMP(__NR_process_vm_mmap, sys_process_vm_mmap, \
+          compat_sys_process_vm_mmap)
 
 #undef __NR_syscalls
-#define __NR_syscalls 434
+#define __NR_syscalls 435
 
 /*
  * 32 bit systems traditionally used different
diff --git a/init/Kconfig b/init/Kconfig
index 8b9ffe236e4f..604db5f14718 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -320,13 +320,14 @@ config POSIX_MQUEUE_SYSCTL
 	default y
 
 config CROSS_MEMORY_ATTACH
-	bool "Enable process_vm_readv/writev syscalls"
+	bool "Enable process_vm_readv/writev/mmap syscalls"
 	depends on MMU
 	default y
 	help
-	  Enabling this option adds the system calls process_vm_readv and
-	  process_vm_writev which allow a process with the correct privileges
-	  to directly read from or write to another process' address space.
+	  Enabling this option adds the system calls process_vm_readv,
+	  process_vm_writev and process_vm_mmap, which allow a process
+	  with the correct privileges to directly read from or write to
+	  or mmap another process' address space.
 	  See the man page for more details.
 
 config USELIB
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index 4d9ae5ea6caf..6f51634f4f7e 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -316,6 +316,8 @@ COND_SYSCALL(process_vm_readv);
 COND_SYSCALL_COMPAT(process_vm_readv);
 COND_SYSCALL(process_vm_writev);
 COND_SYSCALL_COMPAT(process_vm_writev);
+COND_SYSCALL(process_vm_mmap);
+COND_SYSCALL_COMPAT(process_vm_mmap);
 
 /* compare kernel pointers */
 COND_SYSCALL(kcmp);

