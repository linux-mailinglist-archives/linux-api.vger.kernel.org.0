Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15FD44168C3
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 02:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243621AbhIXAM0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 20:12:26 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33832 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243656AbhIXAMY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 20:12:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:37924)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYnj-007jye-1T; Thu, 23 Sep 2021 18:10:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57274 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYnh-0085zA-SZ; Thu, 23 Sep 2021 18:10:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
References: <87v92qx2c6.fsf@disp2133>
Date:   Thu, 23 Sep 2021 19:10:43 -0500
In-Reply-To: <87v92qx2c6.fsf@disp2133> (Eric W. Biederman's message of "Thu,
        23 Sep 2021 19:08:09 -0500")
Message-ID: <87fstux27w.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTYnh-0085zA-SZ;;;mid=<87fstux27w.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//lluq1T+NArYq4Ku1XM1muNrcLOTmgzY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 342 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (3.0%), b_tie_ro: 9 (2.6%), parse: 0.88 (0.3%),
         extract_message_metadata: 12 (3.6%), get_uri_detail_list: 1.12 (0.3%),
         tests_pri_-1000: 14 (4.1%), tests_pri_-950: 1.33 (0.4%),
        tests_pri_-900: 1.08 (0.3%), tests_pri_-90: 91 (26.7%), check_bayes:
        90 (26.2%), b_tokenize: 6 (1.7%), b_tok_get_all: 6 (1.7%),
        b_comp_prob: 2.0 (0.6%), b_tok_touch_all: 73 (21.3%), b_finish: 0.87
        (0.3%), tests_pri_0: 199 (58.1%), check_dkim_signature: 0.57 (0.2%),
        check_dkim_adsp: 3.0 (0.9%), poll_dns_idle: 1.01 (0.3%), tests_pri_10:
        2.3 (0.7%), tests_pri_500: 7 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 3/6] exec: Check for a pending fatal signal instead of core_state
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Prevent exec continuing when a fatal signal is pending by replacing
mmap_read_lock with mmap_read_lock_killable.  This is always the right
thing to do as userspace will never observe an exec complete when
there is a fatal signal pending.

With that change it becomes unnecessary to explicitly test for a core
dump in progress.  In coredump_wait zap_threads arranges under
mmap_write_lock for all tasks that use a mm to also have SIGKILL
pending, which means mmap_read_lock_killable will always return -EINTR
when old_mm->core_state is present.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/exec.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..b6079f1a098e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -987,16 +987,14 @@ static int exec_mmap(struct mm_struct *mm)
 
 	if (old_mm) {
 		/*
-		 * Make sure that if there is a core dump in progress
-		 * for the old mm, we get out and die instead of going
-		 * through with the exec.  We must hold mmap_lock around
-		 * checking core_state and changing tsk->mm.
+		 * If there is a pending fatal signal perhaps a signal
+		 * whose default action is to create a coredump get
+		 * out and die instead of going through with the exec.
 		 */
-		mmap_read_lock(old_mm);
-		if (unlikely(old_mm->core_state)) {
-			mmap_read_unlock(old_mm);
+		ret = mmap_read_lock_killable(old_mm);
+		if (ret) {
 			up_write(&tsk->signal->exec_update_lock);
-			return -EINTR;
+			return ret;
 		}
 	}
 
-- 
2.20.1

