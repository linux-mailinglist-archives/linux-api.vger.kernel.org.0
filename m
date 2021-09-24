Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA98417CFD
	for <lists+linux-api@lfdr.de>; Fri, 24 Sep 2021 23:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347411AbhIXVbD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Sep 2021 17:31:03 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:49938 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347407AbhIXVbD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Sep 2021 17:31:03 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:56264)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTsl6-00DdKS-0s; Fri, 24 Sep 2021 15:29:28 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:34214 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mTsl4-00GwpJ-Kt; Fri, 24 Sep 2021 15:29:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-api@vger.kernel.org
References: <87v92qx2c6.fsf@disp2133> <874kaax26c.fsf@disp2133>
        <202109241135.A683423@keescook>
Date:   Fri, 24 Sep 2021 16:28:58 -0500
In-Reply-To: <202109241135.A683423@keescook> (Kees Cook's message of "Fri, 24
        Sep 2021 11:51:27 -0700")
Message-ID: <87lf3lirxh.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mTsl4-00GwpJ-Kt;;;mid=<87lf3lirxh.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18YukOWJtm+xJ8/jQJBHA1usuGUTV8zxUg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong,XM_B_Investor,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.0 XM_B_Investor BODY: Commonly used business phishing phrases
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 796 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 9 (1.1%), b_tie_ro: 8 (1.0%), parse: 1.28 (0.2%),
        extract_message_metadata: 18 (2.2%), get_uri_detail_list: 4.5 (0.6%),
        tests_pri_-1000: 24 (3.0%), tests_pri_-950: 1.57 (0.2%),
        tests_pri_-900: 1.21 (0.2%), tests_pri_-90: 256 (32.1%), check_bayes:
        252 (31.7%), b_tokenize: 15 (1.9%), b_tok_get_all: 98 (12.3%),
        b_comp_prob: 8 (1.0%), b_tok_touch_all: 126 (15.9%), b_finish: 1.16
        (0.1%), tests_pri_0: 465 (58.4%), check_dkim_signature: 0.75 (0.1%),
        check_dkim_adsp: 2.9 (0.4%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        3.8 (0.5%), tests_pri_500: 13 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 5/6] coredump:  Don't perform any cleanups before dumping core
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Thu, Sep 23, 2021 at 07:11:39PM -0500, Eric W. Biederman wrote:
>> 
>> Rename coredump_exit_mm to coredump_task_exit and call it from do_exit
>> before PTRACE_EVENT_EXIT, and before any cleanup work for a task
>> happens.  This ensures that an accurate copy of the process can be
>> captured in the coredump as no cleanup for the process happens before
>> the coredump completes.  This also ensures that PTRACE_EVENT_EXIT
>> will not be visited by any thread until the coredump is complete.
>> 
>> Add a new flag PF_POSTCOREDUMP so that tasks that have passed through
>> coredump_task_exit can be recognized and ignored in zap_process.
>> 
>> Now that all of the coredumping happens before exit_mm remove code to
>> test for a coredump in progress from mm_release.
>> 
>> Replace "may_ptrace_stop()" with a simple test of "current->ptrace".
>> The other tests in may_ptrace_stop all concern avoiding stopping
>> during a coredump.  These tests are no longer necessary as it is now
>> guaranteed that fatal_signal_pending will be set if the code enters
>> ptrace_stop during a coredump.  The code in ptrace_stop is guaranteed
>> not to stop if fatal_signal_pending returns true.
>> 
>> Until this change "ptrace_event(PTRACE_EVENT_EXIT)" could call
>> ptrace_stop without fatal_signal_pending being true, as signals are
>> dequeued in get_signal before calling do_exit.  This is no longer
>> an issue as "ptrace_event(PTRACE_EVENT_EXIT)" is no longer reached
>> until after the coredump completes.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  fs/coredump.c         |  8 ++++----
>>  include/linux/sched.h |  1 +
>>  kernel/exit.c         | 19 ++++++++++++-------
>>  kernel/fork.c         |  3 +--
>>  kernel/signal.c       | 27 +--------------------------
>>  mm/oom_kill.c         |  2 +-
>>  6 files changed, 20 insertions(+), 40 deletions(-)
>> 
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index 5e0e08a7fb9b..d576287fb88b 100644
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -359,7 +359,7 @@ static int zap_process(struct task_struct *start, int exit_code, int flags)
>>  
>>  	for_each_thread(start, t) {
>>  		task_clear_jobctl_pending(t, JOBCTL_PENDING_MASK);
>> -		if (t != current && t->mm) {
>> +		if (t != current && !(t->flags & PF_POSTCOREDUMP)) {
>
> PF_POSTCOREDUMP is "my exit path is done with anything associated with
> coredumping, including not having dumped core", yes? i.e. it's a task
> lifetime mark, not a "did this actually dump core" mark?

Correct.  I am open to a better name if you have one.

>>  			sigaddset(&t->pending.signal, SIGKILL);
>>  			signal_wake_up(t, 1);
>>  			nr++;
>> @@ -404,8 +404,8 @@ static int zap_threads(struct task_struct *tsk, struct mm_struct *mm,
>>  	 *
>>  	 * do_exit:
>>  	 *	The caller holds mm->mmap_lock. This means that the task which
>> -	 *	uses this mm can't pass coredump_exit_mm(), so it can't exit or
>> -	 *	clear its ->mm.
>> +	 *	uses this mm can't pass coredump_task_exit(), so it can't exit
>> +	 *	or clear its ->mm.
>>  	 *
>>  	 * de_thread:
>>  	 *	It does list_replace_rcu(&leader->tasks, &current->tasks),
>> @@ -500,7 +500,7 @@ static void coredump_finish(struct mm_struct *mm, bool core_dumped)
>>  		next = curr->next;
>>  		task = curr->task;
>>  		/*
>> -		 * see coredump_exit_mm(), curr->task must not see
>> +		 * see coredump_task_exit(), curr->task must not see
>>  		 * ->task == NULL before we read ->next.
>>  		 */
>>  		smp_mb();
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index e12b524426b0..f3741f23935e 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1664,6 +1664,7 @@ extern struct pid *cad_pid;
>>  #define PF_VCPU			0x00000001	/* I'm a virtual CPU */
>>  #define PF_IDLE			0x00000002	/* I am an IDLE thread */
>>  #define PF_EXITING		0x00000004	/* Getting shut down */
>> +#define PF_POSTCOREDUMP		0x00000008	/* Coredumps should ignore this task */
>
> This might need some bikeshedding. It happens that the coredump code
> (zap_process(), actually) will ignore it, but I think what's being
> described is "this process has reached an point-of-no-return on the exit
> path, where coredumping is either done or never happened".

Yes.

I would be happy for any improvements to the naming or the description.
It all seemed reasonable to me (being the author) but from you reaction
I can see it is confusing, and I can see how it is confusing.


>>  #define PF_IO_WORKER		0x00000010	/* Task is an IO worker */
>>  #define PF_WQ_WORKER		0x00000020	/* I'm a workqueue worker */
>>  #define PF_FORKNOEXEC		0x00000040	/* Forked but didn't exec */
>> diff --git a/kernel/exit.c b/kernel/exit.c
>> index cb1619d8fd64..774e6b5061b8 100644
>> --- a/kernel/exit.c
>> +++ b/kernel/exit.c
>> @@ -339,23 +339,29 @@ kill_orphaned_pgrp(struct task_struct *tsk, struct task_struct *parent)
>>  	}
>>  }
>>  
>> -static void coredump_exit_mm(struct mm_struct *mm)
>> +static void coredump_task_exit(struct task_struct *tsk)
>>  {
>>  	struct core_state *core_state;
>> +	struct mm_struct *mm;
>> +
>> +	mm = tsk->mm;
>> +	if (!mm)
>> +		return;
>>  
>>  	/*
>>  	 * Serialize with any possible pending coredump.
>>  	 * We must hold mmap_lock around checking core_state
>> -	 * and clearing tsk->mm.  The core-inducing thread
>> +	 * and setting PF_POSTCOREDUMP.  The core-inducing thread
>>  	 * will increment ->nr_threads for each thread in the
>> -	 * group with ->mm != NULL.
>> +	 * group without PF_POSTCOREDUMP set.
>>  	 */
>> +	mmap_read_lock(mm);
>> +	tsk->flags |= PF_POSTCOREDUMP;
>
> What are the races possible here?
>
> - 2 threads exiting, but neither have core_state, so no change, looks ok
> - 1 thread exiting, 1 thread has dumped. core_state exists, in which
>   case this starts a loop to wait for wakeup?
> 	if dumping thread enters zap_process, gets to sigaddset/signal_wake_up
> 	then the exiting thread sets PF_POSTCOREDUMP and goes to sleep,
> 	will it wait forever? (I can't tell if sighand locking prevents
> 	this ordering problem...)
> - 2 threads dumping -- similar race to above? I suspect I'm missing
>   something, as I'd expect this case to already be handled.


So everything should work from a locking perspective as I am not
changing the locking I am simply moving the call from exit_mm earlier.

To explain how the locking works.

Coredumps are not handled in complete_signal, so when
a thread dequeues the signal the other threads are all running.

If two threads dequeue core dumping signals at the same time both will
contend for mmap_write_lock one will get it and set core_state the
second will return -EBUSY from coredump_wait and return from do_coredump
and proceed to do_exit.

There similar set of races that zap_threads called from coredump_wait
resolves by testing for signal_group_exit inside of sighand lock.

The normal case is one thread runs through do_coredump, coredump_wait,
and zap_threads, counts the threads and waits in coredump_wait for
all of the other threads to stop.

The other threads proceed to do_exit and  coredump_task_exit.
From their the discover that core_state is set.  And holding
the mmap_read_lock is enough to know ensure that either
no coredump is in progress or all of the setup is complete in
coredump_wait.

If core_state is found it is known that there is a waiter waiting in
coredump_wait.  So the tasks add themselves to the list.  Decrement
the count to indicate they don't need to be waited for any longer
and the last one waits up the waiter in coredump_wait.

The threads then spin in TASK_UNINTERRUPTLE until the coredump
completes.

The dumping thread takes the coredump then calls coredump_finish.
In coredump_finish the linked list is torn down, and each element
of the linked list has sets ".task = NULL"  Then the task is woken
up.

The task waiting in TASK_UNINTERRUPTIBLE wakes up. Sees that .task =
NULL and proceeds with the rest of do_exit.


The only change  this patch makes to that entire process is
"task->mm = NULL" is replaced by setting PF_POSTCOREDUMP.

Does that help?

Eric
