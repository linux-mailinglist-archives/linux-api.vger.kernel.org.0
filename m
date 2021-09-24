Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE909417801
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 17:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhIXPuD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 11:50:03 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:50628 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhIXPuB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 11:50:01 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:38874)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTnR5-008xSC-F2; Fri, 24 Sep 2021 09:48:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:45738 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTnR4-00G8kT-3d; Fri, 24 Sep 2021 09:48:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
References: <87v92qx2c6.fsf@disp2133> <87pmsyx29t.fsf@disp2133>
        <202109240804.BC44773A@keescook>
Date:   Fri, 24 Sep 2021 10:48:18 -0500
In-Reply-To: <202109240804.BC44773A@keescook> (Kees Cook's message of "Fri, 24
        Sep 2021 08:22:20 -0700")
Message-ID: <87tuiaotz1.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTnR4-00G8kT-3d;;;mid=<87tuiaotz1.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19MrkKAk4H1SLoennbrPHAG5/y4bsFt64s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 660 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.4%), parse: 1.00 (0.2%),
         extract_message_metadata: 17 (2.6%), get_uri_detail_list: 2.9 (0.4%),
        tests_pri_-1000: 24 (3.6%), tests_pri_-950: 1.29 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 69 (10.4%), check_bayes:
        67 (10.2%), b_tokenize: 10 (1.5%), b_tok_get_all: 12 (1.8%),
        b_comp_prob: 6 (0.8%), b_tok_touch_all: 36 (5.4%), b_finish: 1.02
        (0.2%), tests_pri_0: 524 (79.4%), check_dkim_signature: 0.99 (0.2%),
        check_dkim_adsp: 3.5 (0.5%), poll_dns_idle: 0.88 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/6] signal: Remove the bogus sigkill_pending in ptrace_stop
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Sep 23, 2021 at 07:09:34PM -0500, Eric W. Biederman wrote:
>> 
>> The existence of sigkill_pending is a little silly as it is
>> functionally a duplicate of fatal_signal_pending that is used in
>> exactly one place.
>
> sigkill_pending() checks for &tsk->signal->shared_pending.signal but
> fatal_signal_pending() doesn't.

The extra test is unnecessary as all SIGKILL's visit complete_signal
immediately run the loop:

			/*
			 * Start a group exit and wake everybody up.
			 * This way we don't have other threads
			 * running and doing things after a slower
			 * thread has the fatal signal pending.
			 */
			signal->flags = SIGNAL_GROUP_EXIT;
			signal->group_exit_code = sig;
			signal->group_stop_count = 0;
			t = p;
			do {
				task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
				sigaddset(&t->pending.signal, SIGKILL);
				signal_wake_up(t, 1);
			} while_each_thread(p, t);
			return;

Which sets SIGKILL in the task specific queue.  Which means only the
non-shared queue needs to be tested.  Further fatal_signal_pending would
be buggy if this was not the case.

>> Checking for pending fatal signals and returning early in ptrace_stop
>> is actively harmful.  It casues the ptrace_stop called by
>> ptrace_signal to return early before setting current->exit_code.
>> Later when ptrace_signal reads the signal number from
>> current->exit_code is undefined, making it unpredictable what will
>> happen.
>> 
>> Instead rely on the fact that schedule will not sleep if there is a
>> pending signal that can awaken a task.
>
> This reasoning sound fine, but I can't see where it's happening.
> It looks like recalc_sigpending() is supposed to happen at the start
> of scheduling? I see it at the end of ptrace_stop(), though, so it looks
> like it's reasonable to skip checking shared_pending.
>
> (Does the scheduler deal with shared_pending directly?)

In the call of signal_pending_state from kernel/core/.c:__schedule().

ptrace_stop would actually be badly broken today if that was not the
case as several places enter into ptrace_event without testing signals
first.

>> Removing the explict sigkill_pending test fixes fixes ptrace_signal
>> when ptrace_stop does not stop because current->exit_code is always
>> set to to signr.
>> 
>> Cc: stable@vger.kernel.org
>> Fixes: 3d749b9e676b ("ptrace: simplify ptrace_stop()->sigkill_pending() path")
>> Fixes: 1a669c2f16d4 ("Add arch_ptrace_stop")
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  kernel/signal.c | 18 ++++--------------
>>  1 file changed, 4 insertions(+), 14 deletions(-)
>> 
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 952741f6d0f9..9f2dc9cf3208 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -2182,15 +2182,6 @@ static inline bool may_ptrace_stop(void)
>>  	return true;
>>  }
>>  
>> -/*
>> - * Return non-zero if there is a SIGKILL that should be waking us up.
>> - * Called with the siglock held.
>> - */
>> -static bool sigkill_pending(struct task_struct *tsk)
>> -{
>> -	return sigismember(&tsk->pending.signal, SIGKILL) ||
>> -	       sigismember(&tsk->signal->shared_pending.signal, SIGKILL);
>> -}
>>  
>>  /*
>>   * This must be called with current->sighand->siglock held.
>> @@ -2217,17 +2208,16 @@ static void ptrace_stop(int exit_code, int why, int clear_code, kernel_siginfo_t
>>  		 * calling arch_ptrace_stop, so we must release it now.
>>  		 * To preserve proper semantics, we must do this before
>>  		 * any signal bookkeeping like checking group_stop_count.
>> -		 * Meanwhile, a SIGKILL could come in before we retake the
>> -		 * siglock.  That must prevent us from sleeping in TASK_TRACED.
>> -		 * So after regaining the lock, we must check for SIGKILL.
>
> Where is the sleep this comment is talking about?
>
> i.e. will recalc_sigpending() have been called before the above sleep
> would happen? I assume it's after ptrace_stop() returns... But I want to
> make sure the sleep isn't in ptrace_stop() itself somewhere I can't see.
> I *do* see freezable_schedule() called, and that dumps us into
> __schedule(), and I don't see a recalc before it checks
> signal_pending_state().
>
> Does a recalc need to happen in plce of the old sigkill_pending()
> call?

You read that correctly freezable_schedule is where ptrace_stop sleeps.

The call chain you are looking for looks something like:
send_signal
  complete_signal
     signal_wake_up
       signal_wake_up_state
         set_tsk_thread_flag(t, TIF_SIGPENDING)

That is to say complete_signal sets TIF_SIGPENDING and
the per task siqueue SIGKILL entry.

Calling recalc_sigpending is only needed when a signal is removed from
the queues, not when a signal is added.

Eric
