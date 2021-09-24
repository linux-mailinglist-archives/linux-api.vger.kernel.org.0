Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC434168BB
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 02:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhIXALS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 20:11:18 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:58428 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243629AbhIXALP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 20:11:15 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:60332)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYmc-00Bu71-0m; Thu, 23 Sep 2021 18:09:42 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57242 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYma-00Elu0-WF; Thu, 23 Sep 2021 18:09:41 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <87v92qx2c6.fsf@disp2133>
Date:   Thu, 23 Sep 2021 19:09:34 -0500
In-Reply-To: <87v92qx2c6.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        23 Sep 2021 19:08:09 -0500")
Message-ID: <87pmsyx29t.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTYma-00Elu0-WF;;;mid=<87pmsyx29t.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18P1JJkHBKk3bU181Jm9KWv8/ycafLugo8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 325 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (3.0%), b_tie_ro: 9 (2.6%), parse: 0.70 (0.2%),
         extract_message_metadata: 9 (2.7%), get_uri_detail_list: 1.30 (0.4%),
        tests_pri_-1000: 11 (3.5%), tests_pri_-950: 1.02 (0.3%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 52 (16.0%), check_bayes:
        51 (15.6%), b_tokenize: 6 (1.7%), b_tok_get_all: 7 (2.1%),
        b_comp_prob: 1.95 (0.6%), b_tok_touch_all: 33 (10.2%), b_finish: 0.82
        (0.3%), tests_pri_0: 230 (70.7%), check_dkim_signature: 0.47 (0.1%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 1.04 (0.3%), tests_pri_10:
        1.85 (0.6%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/6] signal: Remove the bogus sigkill_pending in ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


The existence of sigkill_pending is a little silly as it is
functionally a duplicate of fatal_signal_pending that is used in
exactly one place.

Checking for pending fatal signals and returning early in ptrace_stop
is actively harmful.  It casues the ptrace_stop called by
ptrace_signal to return early before setting current->exit_code.
Later when ptrace_signal reads the signal number from
current->exit_code is undefined, making it unpredictable what will
happen.

Instead rely on the fact that schedule will not sleep if there is a
pending signal that can awaken a task.

Removing the explict sigkill_pending test fixes fixes ptrace_signal
when ptrace_stop does not stop because current->exit_code is always
set to to signr.

Cc: stable@vger.kernel.org
Fixes: 3d749b9e676b ("ptrace: simplify ptrace_stop()->sigkill_pending() path")
Fixes: 1a669c2f16d4 ("Add arch_ptrace_stop")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..9f2dc9cf3208 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2182,15 +2182,6 @@ static inline bool may_ptrace_stop(void)
 	return true;
 }
 
-/*
- * Return non-zero if there is a SIGKILL that should be waking us up.
- * Called with the siglock held.
- */
-static bool sigkill_pending(struct task_struct *tsk)
-{
-	return sigismember(&tsk->pending.signal, SIGKILL) ||
-	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
-}
 
 /*
  * This must be called with current->sighand->siglock held.
@@ -2217,17 +2208,16 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
 		 * calling arch_ptrace_stop, so we must release it now.
 		 * To preserve proper semantics, we must do this before
 		 * any signal bookkeeping like checking group_stop_count.
-		 * Meanwhile, a SIGKILL could come in before we retake the
-		 * siglock.  That must prevent us from sleeping in TASK_TRACED.
-		 * So after regaining the lock, we must check for SIGKILL.
 		 */
 		spin_unlock_irq(&current->sighand->siglock);
 		arch_ptrace_stop(exit_code, info);
 		spin_lock_irq(&current->sighand->siglock);
-		if (sigkill_pending(current))
-			return;
 	}
 
+	/*
+	 * schedule() will not sleep if there is a pending signal that
+	 * can awaken the task.
+	 */
 	set_special_state(TASK_TRACED);
 
 	/*
-- 
2.20.1

