Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 085C7190117
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 23:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCWWap (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 18:30:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgCWWao (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Mar 2020 18:30:44 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jGVak-0008VP-5g
        for linux-api@vger.kernel.org; Mon, 23 Mar 2020 22:30:42 +0000
Received: by mail-qt1-f197.google.com with SMTP id w3so14464127qtc.8
        for <linux-api@vger.kernel.org>; Mon, 23 Mar 2020 15:30:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eLU6QAsvnXROGLfRM3tayO8KnVh0W3thszMUzPMtEKg=;
        b=YPPKkCjOXuBZKb5hb9wQQHZfR2n6bUvTeC0nriSTNuwbEyGyOKXo3YDUbZzQolhm+v
         8VHLZ/uWRa21IP6kP/HyCbKog3O4AUmapxSnl/K9BWU9mlHdf+XPVd96bsnbt2498OGw
         aaOtrZlXiQynbELXIqIADw6Vt9NYDoaavK7kkMGNO3+/qjtrkpUaLG+eAKxeFNrKpyUI
         TmC4TxQqnW0bSRTmUnAg8CNN5DE8wT7AyKpljm0eVIWKlTYdHuKUKaswWdFKq/9Lv6uh
         UawFdhNRHFKHpoWQfb+/XC420RjlapRk7+jZt+1U0Xw1N4EIHZ9BEm9xbJdaccZs1dss
         Q6zg==
X-Gm-Message-State: ANhLgQ1e1ejnRNyrMBQjlXZYPdyEyKS3Pr3P1WAED+Zdq+bizdeowDga
        T22qVmyP4IV34gaam01EvYYFxiC2IdSng1ndQvU3HRjv56d2GviIFroCbQ0oleh1/GLtexkVnZ9
        d/Bnm2FjljXlYWr410fwiWaXZGziWruMIPqs76A==
X-Received: by 2002:ac8:a8b:: with SMTP id d11mr22756228qti.94.1585002641072;
        Mon, 23 Mar 2020 15:30:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsTQBRiPkiwW3HiyLOozMBtqzvrhukAt8NVf/Rykr5oh/XnNKcWvstjmOpyCmFqRJWYI13/yw==
X-Received: by 2002:ac8:a8b:: with SMTP id d11mr22756188qti.94.1585002640687;
        Mon, 23 Mar 2020 15:30:40 -0700 (PDT)
Received: from localhost (189-47-87-73.dsl.telesp.net.br. [189.47.87.73])
        by smtp.gmail.com with ESMTPSA id w30sm13984116qtw.21.2020.03.23.15.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2020 15:30:39 -0700 (PDT)
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, tglx@linutronix.de,
        akpm@linux-foundation.org, linux-api@vger.kernel.org,
        rdunlap@infradead.org, willy@infradead.org, gpiccoli@canonical.com,
        kernel@gpiccoli.net
Subject: [PATCH V2] panic: Add sysctl/cmdline to dump all CPUs backtraces on oops event
Date:   Mon, 23 Mar 2020 19:30:35 -0300
Message-Id: <20200323223035.29891-1-gpiccoli@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Usually when kernel reach an oops condition, it's a point of no return;
in case not enough debug information is available in the kernel splat,
one of the last resorts would be to collect a kernel crash dump and
analyze it. The problem with this approach is that in order to collect
the dump, a panic is required (to kexec-load the crash kernel). When
in an environment of multiple virtual machines, users may prefer to
try living with the oops, at least until being able to properly
shutdown their VMs / finish their important tasks.

This patch implements a way to collect a bit more debug details when an
oops event is reached, by printing all the CPUs backtraces through the
usage of NMIs (on architectures that support that). The sysctl/kernel
parameter added (and documented) here was called "oops_all_cpu_backtrace"
and when set will (as the name suggests) dump all CPUs backtraces.

Far from ideal, this may be the last option though for users that for
some reason cannot panic on oops. Most of times oopses are clear enough
to indicate the kernel portion that must be investigated, but in virtual
environments it's possible to observe hypervisor/KVM issues that could
lead to oopses shown in other guests CPUs (like virtual APIC crashes).
This patch hence aims to help debug such complex issues without
resorting to kdump.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
---


V2: Implemented grammar suggestions from Randy, Andrew and
Matthew. Thanks in advance for the reviews!
Cheers,

Guilherme


 .../admin-guide/kernel-parameters.txt         |  8 +++++++
 Documentation/admin-guide/sysctl/kernel.rst   | 17 +++++++++++++++
 include/linux/kernel.h                        |  6 ++++++
 kernel/panic.c                                | 21 +++++++++++++++++++
 kernel/sysctl.c                               | 11 ++++++++++
 5 files changed, 63 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 7a14caac6c94..7db622028c00 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3333,6 +3333,14 @@
 			This will also cause panics on machine check exceptions.
 			Useful together with panic=30 to trigger a reboot.
 
+	oops_all_cpu_backtrace=
+			[KNL] Should kernel generate backtraces on all cpus
+			when oops occurs - this should be a last measure resort
+			in case	a kdump cannot be collected, for example.
+			Defaults to 0 and can be controlled by the sysctl
+			kernel.oops_all_cpu_backtrace.
+			Format: <integer>
+
 	page_alloc.shuffle=
 			[KNL] Boolean flag to control whether the page allocator
 			should randomize its free lists. The randomization may
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b4ff69d2348..8660001d3a3e 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -57,6 +57,7 @@ show up in /proc/sys/kernel:
 - msgmnb
 - msgmni
 - nmi_watchdog
+- oops_all_cpu_backtrace
 - osrelease
 - ostype
 - overflowgid
@@ -572,6 +573,22 @@ numa_balancing_scan_size_mb is how many megabytes worth of pages are
 scanned for a given scan.
 
 
+oops_all_cpu_backtrace:
+================
+
+If this option is set, the kernel will send an NMI to all CPUs to dump
+their backtraces when an oops event occurs. It should be used as a last
+resort in case a panic cannot be triggered (to protect VMs running, for
+example) or kdump can't be collected. This file shows up if CONFIG_SMP
+is enabled.
+
+0: Won't show all CPUs backtraces when an oops is detected.
+This is the default behavior.
+
+1: Will non-maskably interrupt all CPUs and dump their backtraces when
+an oops event is detected.
+
+
 osrelease, ostype & version:
 ============================
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 0d9db2a14f44..6cd00257b572 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -513,6 +513,12 @@ static inline u32 int_sqrt64(u64 x)
 }
 #endif
 
+#ifdef CONFIG_SMP
+extern unsigned int sysctl_oops_all_cpu_backtrace;
+#else
+#define sysctl_oops_all_cpu_backtrace 0
+#endif /* CONFIG_SMP */
+
 extern void bust_spinlocks(int yes);
 extern int oops_in_progress;		/* If set, an oops, panic(), BUG() or die() is in progress */
 extern int panic_timeout;
diff --git a/kernel/panic.c b/kernel/panic.c
index b69ee9e76cb2..73c340418575 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -36,6 +36,24 @@
 #define PANIC_TIMER_STEP 100
 #define PANIC_BLINK_SPD 18
 
+#ifdef CONFIG_SMP
+/*
+ * Should we dump all CPUs backtraces in an oops event?
+ * Defaults to 0, can be changed either via cmdline or sysctl.
+ */
+unsigned int __read_mostly sysctl_oops_all_cpu_backtrace;
+
+static int __init oops_backtrace_setup(char *str)
+{
+	int rc = kstrtouint(str, 0, &sysctl_oops_all_cpu_backtrace);
+
+	if (rc)
+		return rc;
+	return 1;
+}
+__setup("oops_all_cpu_backtrace=", oops_backtrace_setup);
+#endif /* CONFIG_SMP */
+
 int panic_on_oops = CONFIG_PANIC_ON_OOPS_VALUE;
 static unsigned long tainted_mask =
 	IS_ENABLED(CONFIG_GCC_PLUGIN_RANDSTRUCT) ? (1 << TAINT_RANDSTRUCT) : 0;
@@ -515,6 +533,9 @@ void oops_enter(void)
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
 	do_oops_enter_exit();
+
+	if (sysctl_oops_all_cpu_backtrace)
+		trigger_all_cpu_backtrace();
 }
 
 /*
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 238f268de486..1ac31d9d5b7e 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -813,6 +813,17 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_SMP
+	{
+		.procname	= "oops_all_cpu_backtrace",
+		.data		= &sysctl_oops_all_cpu_backtrace,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif /* CONFIG_SMP */
 	{
 		.procname	= "pid_max",
 		.data		= &pid_max,
-- 
2.25.1

