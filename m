Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9245D3B6835
	for <lists+linux-api@lfdr.de>; Mon, 28 Jun 2021 20:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235928AbhF1SUv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 28 Jun 2021 14:20:51 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44528 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhF1SUp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Jun 2021 14:20:45 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxvpo-005Y4n-1h; Mon, 28 Jun 2021 12:18:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:37902 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lxvpm-00GUVd-To; Mon, 28 Jun 2021 12:18:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Andrei Vagin <avagin@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210414055217.543246-1-avagin@gmail.com>
        <20210414055217.543246-3-avagin@gmail.com>
        <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
        <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
        <CAG48ez1d3abHEekh_fYoXdAe85RG+c--G7sEyMYhiKEsns3uog@mail.gmail.com>
Date:   Mon, 28 Jun 2021 13:18:07 -0500
In-Reply-To: <CAG48ez1d3abHEekh_fYoXdAe85RG+c--G7sEyMYhiKEsns3uog@mail.gmail.com>
        (Jann Horn's message of "Mon, 28 Jun 2021 19:14:31 +0200")
Message-ID: <87o8bpyhsw.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lxvpm-00GUVd-To;;;mid=<87o8bpyhsw.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+tjKQ2S/wElv4BubhnpKaH2QbS07hFhis=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMNoVowels,XMSubLong,XM_B_SpammyWords,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Jann Horn <jannh@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 497 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.6%), b_tie_ro: 11 (2.3%), parse: 1.56
        (0.3%), extract_message_metadata: 7 (1.3%), get_uri_detail_list: 3.4
        (0.7%), tests_pri_-1000: 7 (1.4%), tests_pri_-950: 1.82 (0.4%),
        tests_pri_-900: 1.49 (0.3%), tests_pri_-90: 105 (21.0%), check_bayes:
        102 (20.6%), b_tokenize: 13 (2.6%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 3.7 (0.7%), b_tok_touch_all: 71 (14.2%), b_finish: 1.27
        (0.3%), tests_pri_0: 340 (68.4%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 3.4 (0.7%), poll_dns_idle: 0.88 (0.2%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Jann Horn <jannh@google.com> writes:

> On Mon, Jun 28, 2021 at 6:30 PM Andy Lutomirski <luto@kernel.org> wrote:
>> On Mon, Jun 28, 2021, at 9:13 AM, Jann Horn wrote:
>> > On Wed, Apr 14, 2021 at 7:59 AM Andrei Vagin <avagin@gmail.com> wrote:
>> > > This change introduces the new system call:
>> > > process_vm_exec(pid_t pid, struct sigcontext *uctx, unsigned long flags,
>> > >                 siginfo_t * uinfo, sigset_t *sigmask, size_t sizemask)
>> > >
>> > > process_vm_exec allows to execute the current process in an address
>> > > space of another process.
>> > [...]
>> >
>> > I still think that this whole API is fundamentally the wrong approach
>> > because it tries to shoehorn multiple usecases with different
>> > requirements into a single API. But that aside:
>> >
>> > > +static void swap_mm(struct mm_struct *prev_mm, struct mm_struct *target_mm)
>> > > +{
>> > > +       struct task_struct *tsk = current;
>> > > +       struct mm_struct *active_mm;
>> > > +
>> > > +       task_lock(tsk);
>> > > +       /* Hold off tlb flush IPIs while switching mm's */
>> > > +       local_irq_disable();
>> > > +
>> > > +       sync_mm_rss(prev_mm);
>> > > +
>> > > +       vmacache_flush(tsk);
>> > > +
>> > > +       active_mm = tsk->active_mm;
>> > > +       if (active_mm != target_mm) {
>> > > +               mmgrab(target_mm);
>> > > +               tsk->active_mm = target_mm;
>> > > +       }
>> > > +       tsk->mm = target_mm;
>> >
>> > I'm pretty sure you're not currently allowed to overwrite the ->mm
>> > pointer of a userspace thread. For example, zap_threads() assumes that
>> > all threads running under a process have the same ->mm. (And if you're
>> > fiddling with ->mm stuff, you should probably CC linux-mm@.)
>>
>> exec_mmap() does it, so it can’t be entirely impossible.
>
> Yeah, true, execve can do it - I guess the thing that makes that
> special is that it's running after de_thread(), so it's guaranteed to
> be single-threaded?

Even the implementation detail of swapping the mm aside.  Even the idea
of swaping the mm is completely broken, as an endless system calls
depend upon the state held in task_struct.  io_uring just tried running
system calls of a process in a different context and we ultimately had
to make the threads part of the original process to make enough things
work to keep the problem tractable.

System calls deeply and fundamentally depend on task_struct and
signal_struct.

I can think of two possibilities.
1) Hijack and existing process thread.
2) Inject a new thread into an existing process.

Anything else is just an exercise in trouble.  Of this I think Hijacking
an existing thread is the only one that won't require lots of tracking
down of special cases.  I seem to remember audit is still struggling
with how to properly audit io_uring threads.

Eric
