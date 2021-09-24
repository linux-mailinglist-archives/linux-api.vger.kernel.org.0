Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F66241776D
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbhIXPXn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 11:23:43 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:45184 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233099AbhIXPXn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 11:23:43 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:57368)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTn1d-008ufT-0J; Fri, 24 Sep 2021 09:22:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:44582 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTn1b-00G4tc-Hf; Fri, 24 Sep 2021 09:22:08 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org
References: <87v92qx2c6.fsf@disp2133>
Date:   Fri, 24 Sep 2021 10:22:00 -0500
In-Reply-To: <87v92qx2c6.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        23 Sep 2021 19:08:09 -0500")
Message-ID: <87k0j6q9rb.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTn1b-00G4tc-Hf;;;mid=<87k0j6q9rb.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+JsYl7ZmJh6QO3BOzEAQ2MuO1Dj3p7FPo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMBrknScrpt_02,XMNoVowels,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 XMBrknScrpt_02 Possible Broken Spam Script
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 850 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (1.1%), b_tie_ro: 8 (1.0%), parse: 1.00 (0.1%),
         extract_message_metadata: 16 (1.9%), get_uri_detail_list: 3.3 (0.4%),
        tests_pri_-1000: 14 (1.7%), tests_pri_-950: 1.70 (0.2%),
        tests_pri_-900: 1.28 (0.2%), tests_pri_-90: 317 (37.2%), check_bayes:
        309 (36.4%), b_tokenize: 12 (1.4%), b_tok_get_all: 9 (1.0%),
        b_comp_prob: 2.7 (0.3%), b_tok_touch_all: 282 (33.2%), b_finish: 1.00
        (0.1%), tests_pri_0: 474 (55.8%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.8 (0.3%), poll_dns_idle: 0.59 (0.1%), tests_pri_10:
        3.0 (0.3%), tests_pri_500: 9 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 2/6] ptrace: Remove the unnecessary arguments from arch_ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Both arch_ptrace_stop_needed and arch_ptrace_stop are called with an
exit_code and a siginfo structure.  Neither argument is used by any of
the implementations so just remove the unneeded arguments.

The two arechitectures that implement arch_ptrace_stop are ia64 and
sparc.  Both architectures flush their register stacks before a
ptrace_stack so that all of the register information can be accessed
by debuggers.

As the question of if a register stack needs to be flushed is
independent of why ptrace is stopping not needing arguments make sense.

Cc: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Resent because my little one distracted me as I was sending this last
night and I did not manage to copy the sparc and ia64 folks.

 arch/ia64/include/asm/ptrace.h  |  4 ++--
 arch/sparc/include/asm/ptrace.h |  8 ++++----
 include/linux/ptrace.h          | 22 +++++++++-------------
 kernel/signal.c                 |  4 ++--
 4 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index 08179135905c..f15504f75f10 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -129,9 +129,9 @@ static inline long regs_return_value(struct pt_regs *regs)
   extern void ia64_decrement_ip (struct pt_regs *pt);
 
   extern void ia64_ptrace_stop(void);
-  #define arch_ptrace_stop(code, info) \
+  #define arch_ptrace_stop() \
 	ia64_ptrace_stop()
-  #define arch_ptrace_stop_needed(code, info) \
+  #define arch_ptrace_stop_needed() \
 	(!test_thread_flag(TIF_RESTORE_RSE))
 
   extern void ptrace_attach_sync_user_rbs (struct task_struct *);
diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index 71dd82b43cc5..d1419e669027 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -26,12 +26,12 @@ static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
 	return (regs->tstate &= ~TSTATE_SYSCALL);
 }
 
-#define arch_ptrace_stop_needed(exit_code, info) \
+#define arch_ptrace_stop_needed() \
 ({	flush_user_windows(); \
 	get_thread_wsaved() != 0; \
 })
 
-#define arch_ptrace_stop(exit_code, info) \
+#define arch_ptrace_stop() \
 	synchronize_user_stack()
 
 #define current_pt_regs() \
@@ -129,12 +129,12 @@ static inline bool pt_regs_clear_syscall(struct pt_regs *regs)
 	return (regs->psr &= ~PSR_SYSCALL);
 }
 
-#define arch_ptrace_stop_needed(exit_code, info) \
+#define arch_ptrace_stop_needed() \
 ({	flush_user_windows(); \
 	current_thread_info()->w_saved != 0;	\
 })
 
-#define arch_ptrace_stop(exit_code, info) \
+#define arch_ptrace_stop() \
 	synchronize_user_stack()
 
 #define current_pt_regs() \
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index b5ebf6c01292..8aee2945ff08 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -362,29 +362,25 @@ static inline void user_single_step_report(struct pt_regs *regs)
 #ifndef arch_ptrace_stop_needed
 /**
  * arch_ptrace_stop_needed - Decide whether arch_ptrace_stop() should be called
- * @code:	current->exit_code value ptrace will stop with
- * @info:	siginfo_t pointer (or %NULL) for signal ptrace will stop with
  *
  * This is called with the siglock held, to decide whether or not it's
- * necessary to release the siglock and call arch_ptrace_stop() with the
- * same @code and @info arguments.  It can be defined to a constant if
- * arch_ptrace_stop() is never required, or always is.  On machines where
- * this makes sense, it should be defined to a quick test to optimize out
- * calling arch_ptrace_stop() when it would be superfluous.  For example,
- * if the thread has not been back to user mode since the last stop, the
- * thread state might indicate that nothing needs to be done.
+ * necessary to release the siglock and call arch_ptrace_stop().  It can be
+ * defined to a constant if arch_ptrace_stop() is never required, or always
+ * is.  On machines where this makes sense, it should be defined to a quick
+ * test to optimize out calling arch_ptrace_stop() when it would be
+ * superfluous.  For example, if the thread has not been back to user mode
+ * since the last stop, the thread state might indicate that nothing needs
+ * to be done.
  *
  * This is guaranteed to be invoked once before a task stops for ptrace and
  * may include arch-specific operations necessary prior to a ptrace stop.
  */
-#define arch_ptrace_stop_needed(code, info)	(0)
+#define arch_ptrace_stop_needed()	(0)
 #endif
 
 #ifndef arch_ptrace_stop
 /**
  * arch_ptrace_stop - Do machine-specific work before stopping for ptrace
- * @code:	current->exit_code value ptrace will stop with
- * @info:	siginfo_t pointer (or %NULL) for signal ptrace will stop with
  *
  * This is called with no locks held when arch_ptrace_stop_needed() has
  * just returned nonzero.  It is allowed to block, e.g. for user memory
@@ -394,7 +390,7 @@ static inline void user_single_step_report(struct pt_regs *regs)
  * we only do it when the arch requires it for this particular stop, as
  * indicated by arch_ptrace_stop_needed().
  */
-#define arch_ptrace_stop(code, info)		do { } while (0)
+#define arch_ptrace_stop()		do { } while (0)
 #endif
 
 #ifndef current_pt_regs
diff --git a/kernel/signal.c b/kernel/signal.c
index 9f2dc9cf3208..c9759ff2cb43 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2200,7 +2200,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 {
 	bool gstop_done = false;
 
-	if (arch_ptrace_stop_needed(exit_code, info)) {
+	if (arch_ptrace_stop_needed()) {
 		/*
 		 * The arch code has something special to do before a
 		 * ptrace stop.  This is allowed to block, e.g. for faults
@@ -2210,7 +2210,7 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		 * any signal bookkeeping like checking group_stop_count.
 		 */
 		spin_unlock_irq(&current->sighand->siglock);
-		arch_ptrace_stop(exit_code, info);
+		arch_ptrace_stop();
 		spin_lock_irq(&current->sighand->siglock);
 	}
 
-- 
2.20.1

