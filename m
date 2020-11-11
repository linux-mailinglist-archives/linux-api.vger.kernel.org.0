Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C9B2AFA01
	for <lists+linux-api@lfdr.de>; Wed, 11 Nov 2020 21:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgKKUrO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Nov 2020 15:47:14 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:54808 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgKKUrO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Nov 2020 15:47:14 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcx1J-004mbs-Gr; Wed, 11 Nov 2020 13:47:09 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcx1I-00GRKr-0b; Wed, 11 Nov 2020 13:47:09 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Haren Myneni <haren@linux.ibm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
References: <cover.1604523707.git.pcc@google.com>
        <0eb601a5d1906fadd7099149eb605181911cfc04.1604523707.git.pcc@google.com>
        <878sbavuvy.fsf@x220.int.ebiederm.org>
        <d408fdd7c8893844fd13410397644ef157430e25.camel@linux.ibm.com>
Date:   Wed, 11 Nov 2020 14:46:56 -0600
In-Reply-To: <d408fdd7c8893844fd13410397644ef157430e25.camel@linux.ibm.com>
        (Haren Myneni's message of "Wed, 11 Nov 2020 03:10:34 -0800")
Message-ID: <87y2j7oc3j.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kcx1I-00GRKr-0b;;;mid=<87y2j7oc3j.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX190ekl+ykM/+6mHuS8aNrBFtQbRzNnsbtA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4983]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Haren Myneni <haren@linux.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 859 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.4%), b_tie_ro: 10 (1.2%), parse: 1.28
        (0.1%), extract_message_metadata: 7 (0.8%), get_uri_detail_list: 4.0
        (0.5%), tests_pri_-1000: 8 (0.9%), tests_pri_-950: 1.64 (0.2%),
        tests_pri_-900: 1.41 (0.2%), tests_pri_-90: 117 (13.6%), check_bayes:
        115 (13.4%), b_tokenize: 15 (1.7%), b_tok_get_all: 14 (1.6%),
        b_comp_prob: 5.0 (0.6%), b_tok_touch_all: 77 (8.9%), b_finish: 1.06
        (0.1%), tests_pri_0: 683 (79.5%), check_dkim_signature: 1.42 (0.2%),
        check_dkim_adsp: 3.2 (0.4%), poll_dns_idle: 0.63 (0.1%), tests_pri_10:
        2.8 (0.3%), tests_pri_500: 13 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v14 7/8] signal: define the field siginfo.si_faultflags
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Haren Myneni <haren@linux.ibm.com> writes:

> On Mon, 2020-11-09 at 19:54 -0600, Eric W. Biederman wrote:
>> Peter you are patching buggy code for your siginfo extension can
>> you please ignore vas-fault.c.  The code in vas-fault.c should
>> be fixed separately.  Futher it uses clear_siginfo so you should
>> get well defined behavior even if your new field is not initialized.
>> 
>> I have copied the powerpc folks so hopefully this buggy code
>> can be fixed.
>> 
>> > diff --git a/arch/powerpc/platforms/powernv/vas-fault.c
>> > b/arch/powerpc/platforms/powernv/vas-fault.c
>> > index 3d21fce254b7..877e7d5fb4a2 100644
>> > --- a/arch/powerpc/platforms/powernv/vas-fault.c
>> > +++ b/arch/powerpc/platforms/powernv/vas-fault.c
>> > @@ -154,6 +154,7 @@ static void update_csb(struct vas_window
>> > *window,
>> >  	info.si_errno = EFAULT;
>> >  	info.si_code = SEGV_MAPERR;
>> >  	info.si_addr = csb_addr;
>> > +	info.si_faultflags = 0;
>> 
>
> Thanks Eric for your comments and pointing possible issues.
>
> Here is the NX coprocessor interaction with user space and kernel:
>
> - Process opens NX window / channel. The user space sends requests to
> NX without kernel involvement. This request contains data buffer and
> status block called coprocessor status block (CSB). 
> - if NX sees fault on the request buffer or on CSB address, issue an
> interrupt to kernel
> - kernel updates the CSB with the fault information and then the
> process can reissue request.
> - If the fault is on CSB address and is not a valid address, sending
> SEGV signal so that the process assign proper CSB and reissue new
> request
> - We are not seeing the invalid CSB address in the process context, but
> during handling the fault later. So thought about sending SEGV signal
> instead of killing the process since it is not a standard segfault. 
> - All these windows will be closed upon process exit, but waits
> until all pending requests are completed. So process will not exit with
> pending requests, means after all faults handled if any.

I see a lot that doesn't seem to match that description.

Consider forking a child and having that child exit, but still have
the file descriptor open.  The release method will be called.

If you consider file descriptor passing there are much more interesting
cases involved.

> - In the case of multithread applications, NX windows will be closed
> with the last thread. Means other threads can still issue requests with
> these windows. So to support in these applications, take PID and MM
> references during window open and release them later in close. 
>
>> Powerpc folks.  This code was introduced in c96c4436aba4
>> ("powerpc/vas:
>> Update CSB and notify process for fault CRBs") and is badly buggy.
>> 
>> Let me count the bugs:
>> 
>> a) Using kill_pid_info.  That performs a permission check that
>>    does not make sense from a kernel thread.
>> 
>> b) Manually filling in struct siginfo.  Everyone gets it wrong
>>    and the powerpc code is no exception setting si_errno when
>>    that is something Linux as a rule does not do.
>> 
>> Technically we have send_sig_fault to handle sending
>> a fault from a non-sychrnous context but I am not convinced
>> it make sense in this case.
>
> Yes, kill_pid_info() -> group_send_sig_info() checks permissions which
> is an extra step.  I think send_sig_fault may be used to replace the
> above steps.

Make that change at a minimum, please.

>> c) Sending an asynchronous SIGSEGV with the si_code set to
>> SEGV_MAPERR.
>>    How can userspace detect it is an asynchronous signal?  What can
>>    userspace do if it detects an asynchronous signal?  If userspace
>> is
>>    so buggered as to give your kernel thread a bogus address I
>> suspect
>>    uncerimonious sending SIGKILL is probably the best you can do.
>
> Application can assign new CSB and send new request when it catches the
> signal. For example it can use csb_addr passed in si_addr amd decide
> whether this SEGV is due to to CSB fault. Since it is an async signal,
> was thinking for the application to recover instead of killing theprocess.  

An async signal the process can recover from is fine (caveats about
exec, exit, and file descripotr passing aside).

You want something to mark this as an asynchronous event so that
userspace can tell that signal from other signals.

If only a single coprocessor is possible it could be as simple
as using a special si_code for this case.

>> There are some additional questionable things in that code like
>> taking a
>> task_struct reference simply to be able to test tsk->flags but no
>> locks are held to ensure that tsk->flags are meaningful.  Nor are
>> any tests performed to see if the task being tested still uses
>> the designated mm.  I suspect exec could have been called.
>
> tsk->flags is used to make sure not to send a signal if the task is in
> exiting. We access this task under get/put_task_struct().

The thing ins get/put_task_struct is about a reference count.  It is not
a lock.  So the task can still set PF_EXITING after you have tested it
and before you call copy_to_user.   So testing PF_EXITING gets you
practically nothing.

Further the signal delivery code can already cop with attempting to send
a signal to a task that is in PF_EXITING so I don't see the point of
trying to avoid that situation.


> Also 
> kill_pid_info() sends signal if pid_task() is available. Since we are
> taken mm reference, it can not be freed.

But task->mm can be different if the task has called exec.

> So the task has to be present until all NX windows are closed.

I don't see how that follows from anything the code does or you have
said.  The lifetime of an mm and the lifetime of a pid are independent
of the lifetime of a task.  

>> In which case the code needs to check the mm, or at least play with
>> exec_id to ensure you are not improperly signaling a process after
>> exec.
>> 
>> None of this is to say that update_csb is fundmentally bad or hard to
>> correct just that it has some significant defects in it's
>> implementation
>> right now that need to be corrected.  I am hoping a detailed
>> accounting
>> and pointing out those defects will allow the bug to be fixed.
>> 
>> Thank you,
>> Eric

Eric
