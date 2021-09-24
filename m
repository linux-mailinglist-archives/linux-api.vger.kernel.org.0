Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B832A4168B4
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 02:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbhIXAKl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 23 Sep 2021 20:10:41 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:33528 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhIXAKl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 23 Sep 2021 20:10:41 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:52332)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYm3-007ju0-D3; Thu, 23 Sep 2021 18:09:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57218 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTYm2-00EloX-6M; Thu, 23 Sep 2021 18:09:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@ZenIV.linux.org.uk>, <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Date:   Thu, 23 Sep 2021 19:08:09 -0500
Message-ID: <87v92qx2c6.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTYm2-00EloX-6M;;;mid=<87v92qx2c6.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/MWEGFo8SfpHSHDGwehupHY+XVRmEIGZo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TooManySym_01,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;<linux-kernel@vger.kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 427 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (1.0%), b_tie_ro: 2.9 (0.7%), parse: 0.99
        (0.2%), extract_message_metadata: 3.9 (0.9%), get_uri_detail_list:
        1.63 (0.4%), tests_pri_-1000: 2.9 (0.7%), tests_pri_-950: 1.11 (0.3%),
        tests_pri_-900: 0.85 (0.2%), tests_pri_-90: 164 (38.3%), check_bayes:
        162 (38.0%), b_tokenize: 4.9 (1.1%), b_tok_get_all: 5 (1.3%),
        b_comp_prob: 1.62 (0.4%), b_tok_touch_all: 147 (34.5%), b_finish: 0.77
        (0.2%), tests_pri_0: 232 (54.4%), check_dkim_signature: 0.35 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 1.32 (0.3%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 0/6] per signal_struct coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


Current coredumps are mixed up with the exit code, the signal handling
code and with the ptrace code in was they are much more complicated than
necessary and difficult to follow.

This series of changes starts with ptrace_stop and cleans it up,
making it easier to follow what is happening in ptrace_stop.
Then cleans up the exec interactions with coredumps.
Then cleans up the coredump interactions with exit.
Then the coredump interactions with the signal handling code is clean
up.

The first and last changes are bug fixes for minor bugs.

I believe the fact that vfork followed by execve can kill the process
the called vfork if exec fails is sufficient justification to change
the userspace visible behavior.

In previous conversations it was suggested that some of these cleanups
did not stand on their own.  I think I have managed to organize things
so all of their patches stand on their own.

Which means that if for some reason the last change needs to be reverted
we can still keep the gains from the other changes.


Eric W. Biederman (6):
      signal: Remove the bogus sigkill_pending in ptrace_stop
      ptrace: Remove the unnecessary arguments from arch_ptrace_stop
      exec: Check for a pending fatal signal instead of core_state
      exit: Factor coredump_exit_mm out of exit_mm
      coredump:  Don't perform any cleanups before dumping core
      coredump: Limit coredumps to a single thread group

 arch/ia64/include/asm/ptrace.h  |  4 +-
 arch/sparc/include/asm/ptrace.h |  8 ++--
 fs/binfmt_elf.c                 |  4 +-
 fs/binfmt_elf_fdpic.c           |  2 +-
 fs/coredump.c                   | 88 ++++++-----------------------------------
 fs/exec.c                       | 14 +++----
 fs/proc/array.c                 |  6 +--
 include/linux/mm_types.h        | 13 ------
 include/linux/ptrace.h          | 22 +++++------
 include/linux/sched.h           |  1 +
 include/linux/sched/signal.h    | 13 ++++++
 kernel/exit.c                   | 76 +++++++++++++++++++----------------
 kernel/fork.c                   |  4 +-
 kernel/signal.c                 | 49 ++++-------------------
 mm/oom_kill.c                   |  6 +--
 15 files changed, 104 insertions(+), 206 deletions(-)

Eric
