Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 860E536925
	for <lists+linux-api@lfdr.de>; Thu,  6 Jun 2019 03:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFFBXG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 21:23:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:54654 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfFFBXD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 5 Jun 2019 21:23:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:23:03 -0700
X-ExtLoop1: 1
Received: from aubrey-skl.sh.intel.com ([10.239.53.6])
  by orsmga008.jf.intel.com with ESMTP; 05 Jun 2019 18:23:00 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        peterz@infradead.org, hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v19 3/3] Documentation/filesystems/proc.txt: add arch_status file
Date:   Thu,  6 Jun 2019 09:22:36 +0800
Message-Id: <20190606012236.9391-3-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606012236.9391-1-aubrey.li@linux.intel.com>
References: <20190606012236.9391-1-aubrey.li@linux.intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Added /proc/<pid>/arch_status file, and added AVX512_elapsed_ms in
/proc/<pid>/arch_status. Report it in Documentation/filesystems/proc.txt

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linux API <linux-api@vger.kernel.org>
---
 Documentation/filesystems/proc.txt | 39 ++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..e8bc403d15df 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -45,6 +45,7 @@ Table of Contents
   3.9   /proc/<pid>/map_files - Information about memory mapped files
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
+  3.12	/proc/<pid>/arch_status - Task architecture specific information
 
   4	Configuring procfs
   4.1	Mount options
@@ -1948,6 +1949,44 @@ patched.  If the patch is being enabled, then the task has already been
 patched.  If the patch is being disabled, then the task hasn't been
 unpatched yet.
 
+3.12 /proc/<pid>/arch_status - task architecture specific status
+-------------------------------------------------------------------
+When CONFIG_PROC_PID_ARCH_STATUS is enabled, this file displays the
+architecture specific status of the task.
+
+Example
+-------
+ $ cat /proc/6753/arch_status
+ AVX512_elapsed_ms:      8
+
+Description
+-----------
+
+x86 specific entries:
+---------------------
+ AVX512_elapsed_ms:
+ ------------------
+  If AVX512 is supported on the machine, this entry shows the milliseconds
+  elapsed since the last time AVX512 usage was recorded. The recording
+  happens on a best effort basis when a task is scheduled out. This means
+  that the value depends on two factors:
+
+    1) The time which the task spent on the CPU without being scheduled
+       out. With CPU isolation and a single runnable task this can take
+       several seconds.
+
+    2) The time since the task was scheduled out last. Depending on the
+       reason for being scheduled out (time slice exhausted, syscall ...)
+       this can be arbitrary long time.
+
+  As a consequence the value cannot be considered precise and authoritative
+  information. The application which uses this information has to be aware
+  of the overall scenario on the system in order to determine whether a
+  task is a real AVX512 user or not.
+
+  A special value of '-1' indicates that no AVX512 usage was recorded, thus
+  the task is unlikely an AVX512 user, but depends on the workload and the
+  scheduling scenario, it also could be a false negative mentioned above.
 
 ------------------------------------------------------------------------------
 Configuring procfs
-- 
2.17.1

