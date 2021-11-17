Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF089454B34
	for <lists+linux-api@lfdr.de>; Wed, 17 Nov 2021 17:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237208AbhKQQpZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Nov 2021 11:45:25 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50338 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhKQQpT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 17 Nov 2021 11:45:19 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:54078)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnO0o-00B6h1-FU; Wed, 17 Nov 2021 09:42:18 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:57954 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mnO0m-0075Cp-M9; Wed, 17 Nov 2021 09:42:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Kyle Huey <me@kylehuey.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Marko =?utf-8?B?TcOka2Vsw6Q=?= <marko.makela@mariadb.com>,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20211101034147.6203-1-khuey@kylehuey.com>
        <877ddqabvs.fsf@disp2133>
        <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
        <87fsse8maf.fsf@disp2133>
        <CAP045ApAX725ZfujaK-jJNkfCo5s+oVFpBvNfPJk+DKY8K7d=Q@mail.gmail.com>
        <CAP045AqsstnxfTyXhhCGDSucqGN7BTtfHJ5s6ZxUQC5K-JU56A@mail.gmail.com>
        <87bl2kekig.fsf_-_@email.froward.int.ebiederm.org>
        <87zgq4d5r4.fsf_-_@email.froward.int.ebiederm.org>
        <202111161027.C7957C65@keescook>
Date:   Wed, 17 Nov 2021 10:42:09 -0600
In-Reply-To: <202111161027.C7957C65@keescook> (Kees Cook's message of "Tue, 16
        Nov 2021 10:30:49 -0800")
Message-ID: <87ilwqag4e.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mnO0m-0075Cp-M9;;;mid=<87ilwqag4e.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/WZnhpQj7gV1qPg+RDMo5ELhAqqDfKE4w=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,LotsOfNums_01,
        T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 912 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.2%), b_tie_ro: 9 (1.0%), parse: 1.37 (0.1%),
         extract_message_metadata: 19 (2.0%), get_uri_detail_list: 4.6 (0.5%),
        tests_pri_-1000: 25 (2.7%), tests_pri_-950: 1.36 (0.1%),
        tests_pri_-900: 1.17 (0.1%), tests_pri_-90: 180 (19.7%), check_bayes:
        175 (19.2%), b_tokenize: 47 (5.2%), b_tok_get_all: 17 (1.9%),
        b_comp_prob: 9 (1.0%), b_tok_touch_all: 95 (10.4%), b_finish: 2.6
        (0.3%), tests_pri_0: 643 (70.5%), check_dkim_signature: 0.99 (0.1%),
        check_dkim_adsp: 3.3 (0.4%), poll_dns_idle: 1.10 (0.1%), tests_pri_10:
        3.8 (0.4%), tests_pri_500: 23 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] signal: Requeue signals in the appropriate queue
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Mon, Nov 15, 2021 at 11:33:19PM -0600, Eric W. Biederman wrote:
>> 
>> In the event that a tracer changes which signal needs to be delivered
>> and that signal is currently blocked then the signal needs to be
>> requeued for later delivery.
>> 
>> With the advent of CLONE_THREAD the kernel has 2 signal queues per
>> task.  The per process queue and the per task queue.  Update the code
>> so that if the signal is removed from the per process queue it is
>> requeued on the per process queue.  This is necessary to make it
>> appear the signal was never dequeued.
>> 
>> The rr debugger reasonably believes that the state of the process from
>> the last ptrace_stop it observed until PTRACE_EVENT_EXIT can be recreated
>> by simply letting a process run.  If a SIGKILL interrupts a ptrace_stop
>> this is not true today.
>> 
>> So return signals to their original queue in ptrace_signal so that
>> signals that are not delivered appear like they were never dequeued.
>
> The only comment I have on this is that it seems like many callers
> totally ignore the result store in "type" (signalfd_dequeue,
> kernel_dequeue_signal, do_sigtimedwait), which would imply a different
> API might be desirable. That said, it's also not a big deal.

I thought about it.  The primary user of dequeue_signal get_signal does
care which queue you can from.  Always returning the value makes it
possible for the other callers to ask the question do they care, when
they are updated.

My conclusion was that in this case it is more useful for the callers of
dequeue_signal to ask if they care.  My sense is that if we have the
information right in people's faces and they care they will realize they
care.  If the information is not trivially available people are unlikely
to remember the kernel supports two queues, even when it makes a
difference.

Eric

>> Fixes: 794aa320b79d ("[PATCH] sigfix-2.5.40-D6")
>> History Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.gi
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
>
>> ---
>>  fs/signalfd.c                |  5 +++--
>>  include/linux/sched/signal.h |  7 ++++---
>>  kernel/signal.c              | 21 ++++++++++++++-------
>>  3 files changed, 21 insertions(+), 12 deletions(-)
>> 
>> diff --git a/fs/signalfd.c b/fs/signalfd.c
>> index 040e1cf90528..74f134cd1ff6 100644
>> --- a/fs/signalfd.c
>> +++ b/fs/signalfd.c
>> @@ -165,11 +165,12 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>>  static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info,
>>  				int nonblock)
>>  {
>> +	enum pid_type type;
>>  	ssize_t ret;
>>  	DECLARE_WAITQUEUE(wait, current);
>>  
>>  	spin_lock_irq(&current->sighand->siglock);
>> -	ret = dequeue_signal(current, &ctx->sigmask, info);
>> +	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
>>  	switch (ret) {
>>  	case 0:
>>  		if (!nonblock)
>> @@ -184,7 +185,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
>>  	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
>>  	for (;;) {
>>  		set_current_state(TASK_INTERRUPTIBLE);
>> -		ret = dequeue_signal(current, &ctx->sigmask, info);
>> +		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
>>  		if (ret != 0)
>>  			break;
>>  		if (signal_pending(current)) {
>> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
>> index 23505394ef70..167995d471da 100644
>> --- a/include/linux/sched/signal.h
>> +++ b/include/linux/sched/signal.h
>> @@ -286,17 +286,18 @@ static inline int signal_group_exit(const struct signal_struct *sig)
>>  extern void flush_signals(struct task_struct *);
>>  extern void ignore_signals(struct task_struct *);
>>  extern void flush_signal_handlers(struct task_struct *, int force_default);
>> -extern int dequeue_signal(struct task_struct *task,
>> -			  sigset_t *mask, kernel_siginfo_t *info);
>> +extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
>> +			  kernel_siginfo_t *info, enum pid_type *type);
>>  
>>  static inline int kernel_dequeue_signal(void)
>>  {
>>  	struct task_struct *task = current;
>>  	kernel_siginfo_t __info;
>> +	enum pid_type __type;
>>  	int ret;
>>  
>>  	spin_lock_irq(&task->sighand->siglock);
>> -	ret = dequeue_signal(task, &task->blocked, &__info);
>> +	ret = dequeue_signal(task, &task->blocked, &__info, &__type);
>>  	spin_unlock_irq(&task->sighand->siglock);
>>  
>>  	return ret;
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index 986fa69c15c5..43e8b7e362b0 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -626,7 +626,8 @@ static int __dequeue_signal(struct sigpending *pending, sigset_t *mask,
>>   *
>>   * All callers have to hold the siglock.
>>   */
>> -int dequeue_signal(struct task_struct *tsk, sigset_t *mask, kernel_siginfo_t *info)
>> +int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
>> +		   kernel_siginfo_t *info, enum pid_type *type)
>>  {
>>  	bool resched_timer = false;
>>  	int signr;
>> @@ -634,8 +635,10 @@ int dequeue_signal(struct task_struct *tsk, sigset_t *mask, kernel_siginfo_t *in
>>  	/* We only dequeue private signals from ourselves, we don't let
>>  	 * signalfd steal them
>>  	 */
>> +	*type = PIDTYPE_PID;
>>  	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
>>  	if (!signr) {
>> +		*type = PIDTYPE_TGID;
>>  		signr = __dequeue_signal(&tsk->signal->shared_pending,
>>  					 mask, info, &resched_timer);
>>  #ifdef CONFIG_POSIX_TIMERS
>> @@ -2522,7 +2525,7 @@ static void do_freezer_trap(void)
>>  	freezable_schedule();
>>  }
>>  
>> -static int ptrace_signal(int signr, kernel_siginfo_t *info)
>> +static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)
>>  {
>>  	/*
>>  	 * We do not check sig_kernel_stop(signr) but set this marker
>> @@ -2563,7 +2566,7 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>>  
>>  	/* If the (new) signal is now blocked, requeue it.  */
>>  	if (sigismember(&current->blocked, signr)) {
>> -		send_signal(signr, info, current, PIDTYPE_PID);
>> +		send_signal(signr, info, current, type);
>>  		signr = 0;
>>  	}
>>  
>> @@ -2664,6 +2667,7 @@ bool get_signal(struct ksignal *ksig)
>>  
>>  	for (;;) {
>>  		struct k_sigaction *ka;
>> +		enum pid_type type;
>>  
>>  		/* Has this task already been marked for death? */
>>  		if (signal_group_exit(signal)) {
>> @@ -2706,16 +2710,18 @@ bool get_signal(struct ksignal *ksig)
>>  		 * so that the instruction pointer in the signal stack
>>  		 * frame points to the faulting instruction.
>>  		 */
>> +		type = PIDTYPE_PID;
>>  		signr = dequeue_synchronous_signal(&ksig->info);
>>  		if (!signr)
>> -			signr = dequeue_signal(current, &current->blocked, &ksig->info);
>> +			signr = dequeue_signal(current, &current->blocked,
>> +					       &ksig->info, &type);
>>  
>>  		if (!signr)
>>  			break; /* will return 0 */
>>  
>>  		if (unlikely(current->ptrace) && (signr != SIGKILL) &&
>>  		    !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
>> -			signr = ptrace_signal(signr, &ksig->info);
>> +			signr = ptrace_signal(signr, &ksig->info, type);
>>  			if (!signr)
>>  				continue;
>>  		}
>> @@ -3540,6 +3546,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
>>  	ktime_t *to = NULL, timeout = KTIME_MAX;
>>  	struct task_struct *tsk = current;
>>  	sigset_t mask = *which;
>> +	enum pid_type type;
>>  	int sig, ret = 0;
>>  
>>  	if (ts) {
>> @@ -3556,7 +3563,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
>>  	signotset(&mask);
>>  
>>  	spin_lock_irq(&tsk->sighand->siglock);
>> -	sig = dequeue_signal(tsk, &mask, info);
>> +	sig = dequeue_signal(tsk, &mask, info, &type);
>>  	if (!sig && timeout) {
>>  		/*
>>  		 * None ready, temporarily unblock those we're interested
>> @@ -3575,7 +3582,7 @@ static int do_sigtimedwait(const sigset_t *which, kernel_siginfo_t *info,
>>  		spin_lock_irq(&tsk->sighand->siglock);
>>  		__set_task_blocked(tsk, &tsk->real_blocked);
>>  		sigemptyset(&tsk->real_blocked);
>> -		sig = dequeue_signal(tsk, &mask, info);
>> +		sig = dequeue_signal(tsk, &mask, info, &type);
>>  	}
>>  	spin_unlock_irq(&tsk->sighand->siglock);
>>  
>> -- 
>> 2.20.1
>> 
