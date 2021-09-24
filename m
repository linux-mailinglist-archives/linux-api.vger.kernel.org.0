Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53672417678
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 16:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346601AbhIXODT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 10:03:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55388 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhIXODT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 10:03:19 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:36168)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTllp-00Cwnw-4x; Fri, 24 Sep 2021 08:01:45 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:40906 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTlln-009AEd-2w; Fri, 24 Sep 2021 08:01:44 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
References: <87v92qx2c6.fsf@disp2133> <202109232234.135BF1325@keescook>
Date:   Fri, 24 Sep 2021 09:00:59 -0500
In-Reply-To: <202109232234.135BF1325@keescook> (Kees Cook's message of "Thu,
        23 Sep 2021 22:59:44 -0700")
Message-ID: <87tuiars2s.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTlln-009AEd-2w;;;mid=<87tuiars2s.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18p2onFZadiUOSMtB8fa5sbORAGQC5f2J4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4982]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1459 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.45
        (0.1%), extract_message_metadata: 31 (2.1%), get_uri_detail_list: 3.3
        (0.2%), tests_pri_-1000: 58 (3.9%), tests_pri_-950: 1.82 (0.1%),
        tests_pri_-900: 1.33 (0.1%), tests_pri_-90: 199 (13.7%), check_bayes:
        197 (13.5%), b_tokenize: 38 (2.6%), b_tok_get_all: 23 (1.6%),
        b_comp_prob: 4.8 (0.3%), b_tok_touch_all: 119 (8.2%), b_finish: 1.18
        (0.1%), tests_pri_0: 1082 (74.2%), check_dkim_signature: 1.42 (0.1%),
        check_dkim_adsp: 19 (1.3%), poll_dns_idle: 15 (1.0%), tests_pri_10:
        3.8 (0.3%), tests_pri_500: 63 (4.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/6] per signal_struct coredumps
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Sep 23, 2021 at 07:08:09PM -0500, Eric W. Biederman wrote:
>> Current coredumps are mixed up with the exit code, the signal handling
>> code and with the ptrace code in was they are much more complicated than
>> necessary and difficult to follow.
>> 
>> This series of changes starts with ptrace_stop and cleans it up,
>> making it easier to follow what is happening in ptrace_stop.
>> Then cleans up the exec interactions with coredumps.
>> Then cleans up the coredump interactions with exit.
>> Then the coredump interactions with the signal handling code is clean
>> up.
>> 
>> The first and last changes are bug fixes for minor bugs.
>
> I haven't had a chance to carefully look through this yet, but I like
> the sound of it. :)

Please do most of the changes are quite small and straight forward.
Which is why this is several patches to make catching bugs and bisecting
easier.

> Do we have any behavioral tests around this? The ptrace tests in seccomp
> don't explicitly exercise the exit handling. Are there regression tests
> for "rr"? They're usually the first to notice subtle changes in
> ptrace.

There are no tests that I am aware of.  I am hoping to get this into
linux-next so more people will test just because.

> What I couldn't tell from my quick skim: does this further change the
> behavior around force_sig_seccomp()? Specifically the "am I single
> threaded?" check:

There are two changes I can think of with this patchset.
- Tasks killed in the coredump signal path are those that share
  signal_struct, and the coredump will only include those tasks.
- No tasks will reach PTRACE_EVENT_EXIT during a coredump.
  Which actually makes PTRACE_EVENT_EXIT and coredumps more reliable.
  As there is no concern about waiting for each other.


>         case SECCOMP_RET_KILL_THREAD:
>         case SECCOMP_RET_KILL_PROCESS:
>         default:
>                 seccomp_log(this_syscall, SIGSYS, action, true);
>                 /* Dump core only if this is the last remaining thread. */
>                 if (action != SECCOMP_RET_KILL_THREAD ||
>                     (atomic_read(&current->signal->live) == 1)) {
>                         /* Show the original registers in the dump. */
>                         syscall_rollback(current, current_pt_regs());
>                         /* Trigger a coredump with SIGSYS */
>                         force_sig_seccomp(this_syscall, data, true);
>                 } else {
>                         do_exit(SIGSYS);
>                 }
>                 return -1; /* skip the syscall go directly to signal handling */
>
> I *think* the answer is "no", in the sense that coredump_wait() is still
> calling zap_threads() which calls zap_process(). Which now seem like
> should have opposite names. :) And therefore inducing a coredump will
> still take out all threads. (i.e. after your series, no changes need to
> be made to seccomp for it.)

Correct.  Seccomp can stay the same.

What changes in practice is that now SECCOMP_RET_KILL_PROCESS only kills
the process and not other processes that share the mm.


I can imagine a future where the seccomp logic to ask if this is the
final thread will move into signal delivery.  That takes some more
exit cleanups.

In fact once we are convinced the final change in the series is correct.
There are a lot of simplifications to the code that are possible.

One I am hoping for is to move the killing up into complete_signal and
then modifying force_sig_info_to_task to need to stomp sa_handler and
SIGNAL_UNKILLABLE but can instead call the relevant parts of send_signal
by hand, like send_sigqueue does.


Eric
