Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A791F6AE9
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 17:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgFKPXy (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jun 2020 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgFKPXy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Jun 2020 11:23:54 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97693C08C5C1
        for <linux-api@vger.kernel.org>; Thu, 11 Jun 2020 08:23:53 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jjP3Q-0076fb-QW; Thu, 11 Jun 2020 15:23:45 +0000
Date:   Thu, 11 Jun 2020 16:23:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-api@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] unexport linux/elfcore.h
Message-ID: <20200611152344.GA1693733@ZenIV.linux.org.uk>
References: <20200611010115.GZ23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611010115.GZ23230@ZenIV.linux.org.uk>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 11, 2020 at 02:01:15AM +0100, Al Viro wrote:
> 	In include/uapi/linux/elfcore.h we have
> ...
> #include <linux/elf.h>
> ...
> struct elf_prstatus
> {
> ...
>         elf_gregset_t pr_reg;   /* GP registers */
> 
> and that ends up in glibc /usr/include/linux/elfcore.h.  What
> does *not* end up in exported headers is
> 	1) include of asm/elf.h from linux/elf.h - asm/elf.h
> is not exported at all and linux/elf.h is our uapi/linux/elf.h,
> which doesn't include asm/elf.h at all
> 	2) and definitions of elf_gregset_t whatsoever.
> 
> Now, glibc (as well as other libc variants) does contain
> such definition - in /usr/include/sys/procfs.h.  Along with
> a definition of struct elf_prstatus.
> 
> IOW, #include <linux/elfcore.h> in any userland program is
> going to blow - either due to redefinition of struct elf_prstatus
> or due to incomplete type of member in that definition, depending
> upon the headers we'd pulled in earlier.
> 
> Seeing that there's no userland code that would manage to pull that
> file, is there any point exporting it at all?

I mean something like this.  Objections?

commit 4d0380050642e4bf4b7a4d90d4bafeceacb1340d
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Thu Jun 11 11:11:32 2020 -0400

    unexport linux/elfcore.h
    
    It's unusable from userland - it uses elf_gregset_t, which is not
    provided by exported headers.  glibc has it in sys/procfs.h, but
    the same file defines struct elf_prstatus, so linux/elfcore.h can't
    be included once sys/procfs.h has been pulled.  Same goes for uclibc
    and dietlibc simply doesn't have elf_gregset_t defined anywhere.
    
    IOW, no userland source is including that thing.
    
    Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

diff --git a/arch/x86/kernel/crash_core_32.c b/arch/x86/kernel/crash_core_32.c
index c0159a7bca6d..854ef9a18cca 100644
--- a/arch/x86/kernel/crash_core_32.c
+++ b/arch/x86/kernel/crash_core_32.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/crash_core.h>
+#include <linux/mmzone.h>
 
 #include <asm/pgtable.h>
 #include <asm/setup.h>
diff --git a/arch/x86/kernel/crash_core_64.c b/arch/x86/kernel/crash_core_64.c
index 845a57eb4eb7..909b4c92dc9b 100644
--- a/arch/x86/kernel/crash_core_64.c
+++ b/arch/x86/kernel/crash_core_64.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/crash_core.h>
+#include <linux/mmzone.h>
 
 #include <asm/pgtable.h>
 #include <asm/setup.h>
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index ff1b00d0f9ff..8cc050acdeb2 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/dax.h>
 #include <linux/uaccess.h>
+#include <linux/ptrace.h>
 #include <asm/param.h>
 #include <asm/page.h>
 
diff --git a/include/linux/elfcore.h b/include/linux/elfcore.h
index 4cad0e784b28..7f5ef250c683 100644
--- a/include/linux/elfcore.h
+++ b/include/linux/elfcore.h
@@ -5,12 +5,71 @@
 #include <linux/user.h>
 #include <linux/bug.h>
 #include <linux/sched/task_stack.h>
-
-#include <asm/elf.h>
-#include <uapi/linux/elfcore.h>
+#include <linux/elf.h>
 
 struct coredump_params;
 
+struct elf_siginfo
+{
+	int	si_signo;			/* signal number */
+	int	si_code;			/* extra code */
+	int	si_errno;			/* errno */
+};
+
+/*
+ * Definitions to generate Intel SVR4-like core files.
+ * These mostly have the same names as the SVR4 types with "elf_"
+ * tacked on the front to prevent clashes with linux definitions,
+ * and the typedef forms have been avoided.  This is mostly like
+ * the SVR4 structure, but more Linuxy, with things that Linux does
+ * not support and which gdb doesn't really use excluded.
+ */
+struct elf_prstatus
+{
+	struct elf_siginfo pr_info;	/* Info associated with signal */
+	short	pr_cursig;		/* Current signal */
+	unsigned long pr_sigpend;	/* Set of pending signals */
+	unsigned long pr_sighold;	/* Set of held signals */
+	pid_t	pr_pid;
+	pid_t	pr_ppid;
+	pid_t	pr_pgrp;
+	pid_t	pr_sid;
+	struct __kernel_old_timeval pr_utime;	/* User time */
+	struct __kernel_old_timeval pr_stime;	/* System time */
+	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
+	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
+	elf_gregset_t pr_reg;	/* GP registers */
+#ifdef CONFIG_BINFMT_ELF_FDPIC
+	/* When using FDPIC, the loadmap addresses need to be communicated
+	 * to GDB in order for GDB to do the necessary relocations.  The
+	 * fields (below) used to communicate this information are placed
+	 * immediately after ``pr_reg'', so that the loadmap addresses may
+	 * be viewed as part of the register set if so desired.
+	 */
+	unsigned long pr_exec_fdpic_loadmap;
+	unsigned long pr_interp_fdpic_loadmap;
+#endif
+	int pr_fpvalid;		/* True if math co-processor being used.  */
+};
+
+#define ELF_PRARGSZ	(80)	/* Number of chars for args */
+
+struct elf_prpsinfo
+{
+	char	pr_state;	/* numeric process state */
+	char	pr_sname;	/* char for pr_state */
+	char	pr_zomb;	/* zombie */
+	char	pr_nice;	/* nice val */
+	unsigned long pr_flag;	/* flags */
+	__kernel_uid_t	pr_uid;
+	__kernel_gid_t	pr_gid;
+	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
+	/* Lots missing */
+	char	pr_fname[16];	/* filename of executable */
+	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
+};
+
+
 static inline void elf_core_copy_regs(elf_gregset_t *elfregs, struct pt_regs *regs)
 {
 #ifdef ELF_CORE_COPY_REGS
diff --git a/include/uapi/linux/elfcore.h b/include/uapi/linux/elfcore.h
deleted file mode 100644
index baf03562306d..000000000000
--- a/include/uapi/linux/elfcore.h
+++ /dev/null
@@ -1,101 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_ELFCORE_H
-#define _UAPI_LINUX_ELFCORE_H
-
-#include <linux/types.h>
-#include <linux/signal.h>
-#include <linux/time.h>
-#include <linux/ptrace.h>
-#include <linux/elf.h>
-#include <linux/fs.h>
-
-struct elf_siginfo
-{
-	int	si_signo;			/* signal number */
-	int	si_code;			/* extra code */
-	int	si_errno;			/* errno */
-};
-
-
-#ifndef __KERNEL__
-typedef elf_greg_t greg_t;
-typedef elf_gregset_t gregset_t;
-typedef elf_fpregset_t fpregset_t;
-typedef elf_fpxregset_t fpxregset_t;
-#define NGREG ELF_NGREG
-#endif
-
-/*
- * Definitions to generate Intel SVR4-like core files.
- * These mostly have the same names as the SVR4 types with "elf_"
- * tacked on the front to prevent clashes with linux definitions,
- * and the typedef forms have been avoided.  This is mostly like
- * the SVR4 structure, but more Linuxy, with things that Linux does
- * not support and which gdb doesn't really use excluded.
- * Fields present but not used are marked with "XXX".
- */
-struct elf_prstatus
-{
-#if 0
-	long	pr_flags;	/* XXX Process flags */
-	short	pr_why;		/* XXX Reason for process halt */
-	short	pr_what;	/* XXX More detailed reason */
-#endif
-	struct elf_siginfo pr_info;	/* Info associated with signal */
-	short	pr_cursig;		/* Current signal */
-	unsigned long pr_sigpend;	/* Set of pending signals */
-	unsigned long pr_sighold;	/* Set of held signals */
-#if 0
-	struct sigaltstack pr_altstack;	/* Alternate stack info */
-	struct sigaction pr_action;	/* Signal action for current sig */
-#endif
-	pid_t	pr_pid;
-	pid_t	pr_ppid;
-	pid_t	pr_pgrp;
-	pid_t	pr_sid;
-	struct __kernel_old_timeval pr_utime;	/* User time */
-	struct __kernel_old_timeval pr_stime;	/* System time */
-	struct __kernel_old_timeval pr_cutime;	/* Cumulative user time */
-	struct __kernel_old_timeval pr_cstime;	/* Cumulative system time */
-#if 0
-	long	pr_instr;		/* Current instruction */
-#endif
-	elf_gregset_t pr_reg;	/* GP registers */
-#ifdef CONFIG_BINFMT_ELF_FDPIC
-	/* When using FDPIC, the loadmap addresses need to be communicated
-	 * to GDB in order for GDB to do the necessary relocations.  The
-	 * fields (below) used to communicate this information are placed
-	 * immediately after ``pr_reg'', so that the loadmap addresses may
-	 * be viewed as part of the register set if so desired.
-	 */
-	unsigned long pr_exec_fdpic_loadmap;
-	unsigned long pr_interp_fdpic_loadmap;
-#endif
-	int pr_fpvalid;		/* True if math co-processor being used.  */
-};
-
-#define ELF_PRARGSZ	(80)	/* Number of chars for args */
-
-struct elf_prpsinfo
-{
-	char	pr_state;	/* numeric process state */
-	char	pr_sname;	/* char for pr_state */
-	char	pr_zomb;	/* zombie */
-	char	pr_nice;	/* nice val */
-	unsigned long pr_flag;	/* flags */
-	__kernel_uid_t	pr_uid;
-	__kernel_gid_t	pr_gid;
-	pid_t	pr_pid, pr_ppid, pr_pgrp, pr_sid;
-	/* Lots missing */
-	char	pr_fname[16];	/* filename of executable */
-	char	pr_psargs[ELF_PRARGSZ];	/* initial part of arg list */
-};
-
-#ifndef __KERNEL__
-typedef struct elf_prstatus prstatus_t;
-typedef struct elf_prpsinfo prpsinfo_t;
-#define PRARGSZ ELF_PRARGSZ 
-#endif
-
-
-#endif /* _UAPI_LINUX_ELFCORE_H */
diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a5c36b..65065f6ebac8 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -89,7 +89,6 @@ arch/x86/include/uapi/asm/auxvec.h:CONFIG_X86_64
 arch/x86/include/uapi/asm/mman.h:CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 include/uapi/asm-generic/fcntl.h:CONFIG_64BIT
 include/uapi/linux/atmdev.h:CONFIG_COMPAT
-include/uapi/linux/elfcore.h:CONFIG_BINFMT_ELF_FDPIC
 include/uapi/linux/eventpoll.h:CONFIG_PM_SLEEP
 include/uapi/linux/hw_breakpoint.h:CONFIG_HAVE_MIXED_BREAKPOINTS_REGS
 include/uapi/linux/pktcdvd.h:CONFIG_CDROM_PKTCDVD_WCACHE
diff --git a/usr/include/Makefile b/usr/include/Makefile
index b568a95d1f62..4b637ea50bef 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -24,7 +24,6 @@ no-header-test += linux/am437x-vpfe.h
 no-header-test += linux/android/binder.h
 no-header-test += linux/android/binderfs.h
 no-header-test += linux/coda.h
-no-header-test += linux/elfcore.h
 no-header-test += linux/errqueue.h
 no-header-test += linux/fsmap.h
 no-header-test += linux/hdlc/ioctl.h
