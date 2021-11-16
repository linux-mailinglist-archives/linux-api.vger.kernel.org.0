Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD77F4529CF
	for <lists+linux-api@lfdr.de>; Tue, 16 Nov 2021 06:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhKPFgC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 16 Nov 2021 00:36:02 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:38420 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbhKPFf7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 16 Nov 2021 00:35:59 -0500
Received: from in01.mta.xmission.com ([166.70.13.51]:34744)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmr5X-005ujB-T1; Mon, 15 Nov 2021 22:32:59 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:45502 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mmr5V-00CP21-Sq; Mon, 15 Nov 2021 22:32:59 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Kyle Huey <me@kylehuey.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Marko =?utf-8?B?TcOka2Vs?= =?utf-8?B?w6Q=?= 
        <marko.makela@mariadb.com>, <linux-api@vger.kernel.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <20211101034147.6203-1-khuey@kylehuey.com>
        <877ddqabvs.fsf@disp2133>
        <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
        <87fsse8maf.fsf@disp2133>
        <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
        <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
        <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
Date:   Mon, 15 Nov 2021 23:32:50 -0600
In-Reply-To: <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 15 Nov 2021 23:29:11 -0600")
Message-ID: <875yssekcd.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mmr5V-00CP21-Sq;;;mid=<875yssekcd.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18nSLMNxq2NVHb2kqhlpUyfVui5RNnA3JM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_Body_Dirty_Words autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1370 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 9 (0.7%), parse: 0.98 (0.1%),
         extract_message_metadata: 11 (0.8%), get_uri_detail_list: 1.29 (0.1%),
         tests_pri_-1000: 14 (1.0%), tests_pri_-950: 1.21 (0.1%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 53 (3.9%), check_bayes: 52
        (3.8%), b_tokenize: 7 (0.5%), b_tok_get_all: 7 (0.5%), b_comp_prob:
        2.0 (0.1%), b_tok_touch_all: 33 (2.4%), b_finish: 0.76 (0.1%),
        tests_pri_0: 1260 (92.0%), check_dkim_signature: 0.49 (0.0%),
        check_dkim_adsp: 3.1 (0.2%), poll_dns_idle: 1.35 (0.1%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 13 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/3] signal: In get_signal test for signal_group_exit every time through the loop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Recently while investigating a problem with rr and signals I noticed
that siglock is dropped in ptrace_signal and get_signal does not jump
to relock.

Looking farther to see if the problem is anywhere else I see that
do_signal_stop also returns if signal_group_exit is true.  I believe
that test can now never be true, but it is a bit hard to trace
through and be certain.

Testing signal_group_exit is not expensive, so move the test for
signal_group_exit into the for loop inside of get_signal to ensure
the test is never skipped improperly.

This has been a potential since I added the test for signal_group_exit
was added.

Fixes: 35634ffa1751 ("signal: Always notice exiting tasks")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7c4b7ae714d4..986fa69c15c5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2662,19 +2662,19 @@ bool get_signal(struct ksignal *ksig)
 		goto relock;
 	}
 
-	/* Has this task already been marked for death? */
-	if (signal_group_exit(signal)) {
-		ksig->info.si_signo = signr = SIGKILL;
-		sigdelset(&current->pending.signal, SIGKILL);
-		trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
-				&sighand->action[SIGKILL - 1]);
-		recalc_sigpending();
-		goto fatal;
-	}
-
 	for (;;) {
 		struct k_sigaction *ka;
 
+		/* Has this task already been marked for death? */
+		if (signal_group_exit(signal)) {
+			ksig->info.si_signo = signr = SIGKILL;
+			sigdelset(&current->pending.signal, SIGKILL);
+			trace_signal_deliver(SIGKILL, SEND_SIG_NOINFO,
+				&sighand->action[SIGKILL - 1]);
+			recalc_sigpending();
+			goto fatal;
+		}
+
 		if (unlikely(current->jobctl & JOBCTL_STOP_PENDING) &&
 		    do_signal_stop(0))
 			goto relock;
-- 
2.20.1

