Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC02E289121
	for <lists+linux-api@lfdr.de>; Fri,  9 Oct 2020 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390652AbgJISe5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 9 Oct 2020 14:34:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:9530 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390447AbgJISdK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:10 -0400
IronPort-SDR: GlUnEelc2zOAG33OK0vfuCb8B/RK1Uwxs/o6uRHB5BFMdRLXUb9e8OUMpsP17+JvRDvvSnzDuE
 OvyftX4UYbSQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="164736592"
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="164736592"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:09 -0700
IronPort-SDR: SVy66sUDtVoA5a2G2YD/OTN6KwqOHE/c9fxQskputhCBOrlutlHdnwTGRBobLOz+c2VYWFEjiA
 D4syxx5bJNIg==
X-IronPort-AV: E=Sophos;i="5.77,355,1596524400"; 
   d="scan'208";a="529031104"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 11:33:09 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 01/26] Documentation/x86: Add CET description
Date:   Fri,  9 Oct 2020 11:32:05 -0700
Message-Id: <20201009183230.26717-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201009183230.26717-1-yu-cheng.yu@intel.com>
References: <20201009183230.26717-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Explain no_user_shstk/no_user_ibt kernel parameters, and introduce a new
document on Control-flow Enforcement Technology (CET).

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>

v13:
- Change X86_INTEL_* to X86_*.

v12:
- Remove ARCH_X86_CET_MMAP_SHSTK information.

v11:
- Add back GLIBC tunables information.
- Add ARCH_X86_CET_MMAP_SHSTK information.

v10:
- Change no_cet_shstk and no_cet_ibt to no_user_shstk and no_user_ibt.
- Remove the opcode section, as it is already in the Intel SDM.
- Remove sections related to GLIBC implementation.
- Remove shadow stack memory management section, as it is already in the
  code comments.
- Remove legacy bitmap related information, as it is not supported now.
- Fix arch_ioctl() related text.
- Change SHSTK, IBT to plain English.
---
 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/x86/index.rst                   |   1 +
 Documentation/x86/intel_cet.rst               | 133 ++++++++++++++++++
 3 files changed, 140 insertions(+)
 create mode 100644 Documentation/x86/intel_cet.rst

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1068742a6df..7c7124a6a7ac 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3164,6 +3164,12 @@
 			noexec=on: enable non-executable mappings (default)
 			noexec=off: disable non-executable mappings
 
+	no_user_shstk	[X86-64] Disable Shadow Stack for user-mode
+			applications
+
+	no_user_ibt	[X86-64] Disable Indirect Branch Tracking for user-mode
+			applications
+
 	nosmap		[X86,PPC]
 			Disable SMAP (Supervisor Mode Access Prevention)
 			even if it is supported by processor.
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 265d9e9a093b..2aef972a868d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,6 +19,7 @@ x86-specific Documentation
    tlb
    mtrr
    pat
+   intel_cet
    intel-iommu
    intel_txt
    amd-memory-encryption
diff --git a/Documentation/x86/intel_cet.rst b/Documentation/x86/intel_cet.rst
new file mode 100644
index 000000000000..c9ebb3d9dd00
--- /dev/null
+++ b/Documentation/x86/intel_cet.rst
@@ -0,0 +1,133 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================================
+Control-flow Enforcement Technology (CET)
+=========================================
+
+[1] Overview
+============
+
+Control-flow Enforcement Technology (CET) is an Intel processor feature
+that provides protection against return/jump-oriented programming (ROP)
+attacks.  It can be set up to protect both applications and the kernel.
+Only user-mode protection is implemented in the 64-bit kernel, including
+support for running legacy 32-bit applications.
+
+CET introduces Shadow Stack and Indirect Branch Tracking.  Shadow stack is
+a secondary stack allocated from memory and cannot be directly modified by
+applications.  When executing a CALL, the processor pushes the return
+address to both the normal stack and the shadow stack.  Upon function
+return, the processor pops the shadow stack copy and compares it to the
+normal stack copy.  If the two differ, the processor raises a control-
+protection fault.  Indirect branch tracking verifies indirect CALL/JMP
+targets are intended as marked by the compiler with 'ENDBR' opcodes.
+
+There are two kernel configuration options:
+
+    X86_SHADOW_STACK_USER, and
+    X86_BRANCH_TRACKING_USER.
+
+These need to be enabled to build a CET-enabled kernel, and Binutils v2.31
+and GCC v8.1 or later are required to build a CET kernel.  To build a CET-
+enabled application, GLIBC v2.28 or later is also required.
+
+There are two command-line options for disabling CET features::
+
+    no_user_shstk - disables user shadow stack, and
+    no_user_ibt   - disables user indirect branch tracking.
+
+At run time, /proc/cpuinfo shows CET features if the processor supports
+CET.
+
+[2] Application Enabling
+========================
+
+An application's CET capability is marked in its ELF header and can be
+verified from the following command output, in the NT_GNU_PROPERTY_TYPE_0
+field:
+
+    readelf -n <application>
+
+If an application supports CET and is statically linked, it will run with
+CET protection.  If the application needs any shared libraries, the loader
+checks all dependencies and enables CET when all requirements are met.
+
+[3] Backward Compatibility
+==========================
+
+GLIBC provides a few tunables for backward compatibility.
+
+GLIBC_TUNABLES=glibc.tune.hwcaps=-SHSTK,-IBT
+    Turn off SHSTK/IBT for the current shell.
+
+GLIBC_TUNABLES=glibc.tune.x86_shstk=<on, permissive>
+    This controls how dlopen() handles SHSTK legacy libraries::
+
+        on         - continue with SHSTK enabled;
+        permissive - continue with SHSTK off.
+
+[4] CET arch_prctl()'s
+======================
+
+Several arch_prctl()'s have been added for CET:
+
+arch_prctl(ARCH_X86_CET_STATUS, u64 *addr)
+    Return CET feature status.
+
+    The parameter 'addr' is a pointer to a user buffer.
+    On returning to the caller, the kernel fills the following
+    information::
+
+        *addr       = shadow stack/indirect branch tracking status
+        *(addr + 1) = shadow stack base address
+        *(addr + 2) = shadow stack size
+
+arch_prctl(ARCH_X86_CET_DISABLE, unsigned int features)
+    Disable shadow stack and/or indirect branch tracking as specified in
+    'features'.  Return -EPERM if CET is locked.
+
+arch_prctl(ARCH_X86_CET_LOCK)
+    Lock in all CET features.  They cannot be turned off afterwards.
+
+Note:
+  There is no CET-enabling arch_prctl function.  By design, CET is enabled
+  automatically if the binary and the system can support it.
+
+[5] The implementation of the Shadow Stack
+==========================================
+
+Shadow Stack size
+-----------------
+
+A task's shadow stack is allocated from memory to a fixed size of
+MIN(RLIMIT_STACK, 4 GB).  In other words, the shadow stack is allocated to
+the maximum size of the normal stack, but capped to 4 GB.  However,
+a compat-mode application's address space is smaller, each of its thread's
+shadow stack size is MIN(1/4 RLIMIT_STACK, 4 GB).
+
+Signal
+------
+
+The main program and its signal handlers use the same shadow stack.
+Because the shadow stack stores only return addresses, a large shadow
+stack covers the condition that both the program stack and the signal
+alternate stack run out.
+
+The kernel creates a restore token for the shadow stack restoring address
+and verifies that token when restoring from the signal handler.
+
+Fork
+----
+
+The shadow stack's vma has VM_SHSTK flag set; its PTEs are required to be
+read-only and dirty.  When a shadow stack PTE is not RO and dirty, a
+shadow access triggers a page fault with the shadow stack access bit set
+in the page fault error code.
+
+When a task forks a child, its shadow stack PTEs are copied and both the
+parent's and the child's shadow stack PTEs are cleared of the dirty bit.
+Upon the next shadow stack access, the resulting shadow stack page fault
+is handled by page copy/re-use.
+
+When a pthread child is created, the kernel allocates a new shadow stack
+for the new thread.
-- 
2.21.0

