Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72A3A42601
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2019 14:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407888AbfFLMgc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Jun 2019 08:36:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54349 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407867AbfFLMgc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Jun 2019 08:36:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCaJcU686788
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:36:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCaJcU686788
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342980;
        bh=0HgdtB4MlYHY8kJiOx0wsSNBk+4UuW1WUAN7QmeO3uw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=bXfGlx1khjx1j+nlgwjeaSF1i9LGtOe3gsBCMPwu+mRLG+vB1vP2W84PIG2RAR7Xw
         TYpDXOrZpwEqHOIuNeW2Z7vbRyWWfzsmK32DouRk5kyDyTGxz1m/m6FfngEH1NKlFw
         v6KZ8rM4/Tc865I54dJ5Kfj8Bji85T73meO5Z7UBomwU4+6AaaA5sgveV8ZjbpmHId
         DVbQ4FGzg3qOgAdjQ/j/NZKzSfxTY8aewvqmFwfOS+7db/5us4rOHE921Bf6Utn8Vy
         +pB4ubcnnWD/mfkza17zWURR/1eB8esNCDcKIn2S9e5/wZgxaze/zRCm/WFGqw1G3W
         s9GVMP6DEuRPA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCaJQP686785;
        Wed, 12 Jun 2019 05:36:19 -0700
Date:   Wed, 12 Jun 2019 05:36:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Aubrey Li <tipbot@zytor.com>
Message-ID: <tip-711486fd18596315d42cebaac3dba8c408f60a3d@git.kernel.org>
Cc:     adobriyan@gmail.com, arjan@linux.intel.com, tglx@linutronix.de,
        aubrey.li@linux.intel.com, peterz@infradead.org, mingo@kernel.org,
        tim.c.chen@linux.intel.com, linux-api@vger.kernel.org,
        dave.hansen@intel.com, hpa@zytor.com, ak@linux.intel.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Reply-To: linux-api@vger.kernel.org, ak@linux.intel.com, hpa@zytor.com,
          dave.hansen@intel.com, luto@kernel.org,
          linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          adobriyan@gmail.com, arjan@linux.intel.com, tglx@linutronix.de,
          aubrey.li@linux.intel.com, mingo@kernel.org,
          peterz@infradead.org, tim.c.chen@linux.intel.com
In-Reply-To: <20190606012236.9391-3-aubrey.li@linux.intel.com>
References: <20190606012236.9391-3-aubrey.li@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/core] Documentation/filesystems/proc.txt: Add arch_status
 file
Git-Commit-ID: 711486fd18596315d42cebaac3dba8c408f60a3d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=0.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FORGED_REPLYTO autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Commit-ID:  711486fd18596315d42cebaac3dba8c408f60a3d
Gitweb:     https://git.kernel.org/tip/711486fd18596315d42cebaac3dba8c408f60a3d
Author:     Aubrey Li <aubrey.li@linux.intel.com>
AuthorDate: Thu, 6 Jun 2019 09:22:36 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 11:42:13 +0200

Documentation/filesystems/proc.txt: Add arch_status file

Add documentation for /proc/<pid>/arch_status file and the x86 specific
AVX512_elapsed_ms entry in it.

[ tglx: Massage changelog ]

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: akpm@linux-foundation.org
Cc: peterz@infradead.org
Cc: hpa@zytor.com
Cc: ak@linux.intel.com
Cc: tim.c.chen@linux.intel.com
Cc: dave.hansen@intel.com
Cc: arjan@linux.intel.com
Cc: adobriyan@gmail.com
Cc: aubrey.li@intel.com
Cc: linux-api@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linux API <linux-api@vger.kernel.org>
Link: https://lkml.kernel.org/r/20190606012236.9391-3-aubrey.li@linux.intel.com

---
 Documentation/filesystems/proc.txt | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..a226061fa109 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -45,6 +45,7 @@ Table of Contents
   3.9   /proc/<pid>/map_files - Information about memory mapped files
   3.10  /proc/<pid>/timerslack_ns - Task timerslack value
   3.11	/proc/<pid>/patch_state - Livepatch patch operation state
+  3.12	/proc/<pid>/arch_status - Task architecture specific information
 
   4	Configuring procfs
   4.1	Mount options
@@ -1948,6 +1949,45 @@ patched.  If the patch is being enabled, then the task has already been
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
+  task is a real AVX512 user or not. Precise information can be obtained
+  with performance counters.
+
+  A special value of '-1' indicates that no AVX512 usage was recorded, thus
+  the task is unlikely an AVX512 user, but depends on the workload and the
+  scheduling scenario, it also could be a false negative mentioned above.
 
 ------------------------------------------------------------------------------
 Configuring procfs
