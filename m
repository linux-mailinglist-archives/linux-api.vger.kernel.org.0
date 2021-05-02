Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679E6370E6D
	for <lists+linux-api@lfdr.de>; Sun,  2 May 2021 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhEBSZq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 2 May 2021 14:25:46 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:54044 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbhEBSZp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 2 May 2021 14:25:45 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldGlv-006v2s-Aq; Sun, 02 May 2021 12:24:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ldGlu-00BNqY-8D; Sun, 02 May 2021 12:24:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
References: <YIpkvGrBFGlB5vNj@elver.google.com>
        <m11rat9f85.fsf@fess.ebiederm.org>
        <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
        <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
        <m1zgxfs7zq.fsf_-_@fess.ebiederm.org>
        <m1o8dvs7s7.fsf_-_@fess.ebiederm.org>
        <CANpmjNNhd+qAy7tPSu=08_y-BZiowKigVkOh6HnXsxhWYuFpJA@mail.gmail.com>
Date:   Sun, 02 May 2021 13:24:46 -0500
In-Reply-To: <CANpmjNNhd+qAy7tPSu=08_y-BZiowKigVkOh6HnXsxhWYuFpJA@mail.gmail.com>
        (Marco Elver's message of "Sat, 1 May 2021 12:33:27 +0200")
Message-ID: <m1sg35ngcx.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ldGlu-00BNqY-8D;;;mid=<m1sg35ngcx.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/0HsNqVjpzSZgBfn2EWtFrYSso3wfS118=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4942]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 509 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.6 (0.7%), b_tie_ro: 2.4 (0.5%), parse: 0.84
        (0.2%), extract_message_metadata: 9 (1.8%), get_uri_detail_list: 2.3
        (0.5%), tests_pri_-1000: 11 (2.1%), tests_pri_-950: 1.03 (0.2%),
        tests_pri_-900: 0.83 (0.2%), tests_pri_-90: 79 (15.4%), check_bayes:
        78 (15.2%), b_tokenize: 10 (1.9%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 1.59 (0.3%), b_tok_touch_all: 54 (10.6%), b_finish: 0.64
        (0.1%), tests_pri_0: 395 (77.6%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.88 (0.2%), tests_pri_10:
        1.55 (0.3%), tests_pri_500: 5 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] signal: Implement SIL_FAULT_TRAPNO
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Sat, 1 May 2021 at 00:54, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Now that si_trapno is part of the union in _si_fault and available on
>> all architectures, add SIL_FAULT_TRAPNO and update siginfo_layout to
>> return SIL_FAULT_TRAPNO when si_trapno is actually used.
>>
>> Update the code that uses siginfo_layout to deal with SIL_FAULT_TRAPNO
>> and have the same code ignore si_trapno in in all other cases.
>>
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> ---
>>  fs/signalfd.c          |  7 ++-----
>>  include/linux/signal.h |  1 +
>>  kernel/signal.c        | 36 ++++++++++++++----------------------
>>  3 files changed, 17 insertions(+), 27 deletions(-)
>>
>> diff --git a/fs/signalfd.c b/fs/signalfd.c
>> index 040a1142915f..126c681a30e7 100644
>> --- a/fs/signalfd.c
>> +++ b/fs/signalfd.c
>> @@ -123,15 +123,12 @@ static int signalfd_copyinfo(struct signalfd_siginfo __user *uinfo,
>>                  */
>>         case SIL_FAULT:
>>                 new.ssi_addr = (long) kinfo->si_addr;
>> -#ifdef __ARCH_SI_TRAPNO
>> +       case SIL_FAULT_TRAPNO:
>> +               new.ssi_addr = (long) kinfo->si_addr;
>>                 new.ssi_trapno = kinfo->si_trapno;
>> -#endif
>>                 break;
>>         case SIL_FAULT_MCEERR:
>>                 new.ssi_addr = (long) kinfo->si_addr;
>> -#ifdef __ARCH_SI_TRAPNO
>> -               new.ssi_trapno = kinfo->si_trapno;
>> -#endif
>>                 new.ssi_addr_lsb = (short) kinfo->si_addr_lsb;
>>                 break;
>>         case SIL_PERF_EVENT:
>> diff --git a/include/linux/signal.h b/include/linux/signal.h
>> index 1e98548d7cf6..5160fd45e5ca 100644
>> --- a/include/linux/signal.h
>> +++ b/include/linux/signal.h
>> @@ -40,6 +40,7 @@ enum siginfo_layout {
>>         SIL_TIMER,
>>         SIL_POLL,
>>         SIL_FAULT,
>> +       SIL_FAULT_TRAPNO,
>>         SIL_FAULT_MCEERR,
>>         SIL_FAULT_BNDERR,
>>         SIL_FAULT_PKUERR,
>> diff --git a/kernel/signal.c b/kernel/signal.c
>> index c3017aa8024a..7b2d61cb7411 100644
>> --- a/kernel/signal.c
>> +++ b/kernel/signal.c
>> @@ -1194,6 +1194,7 @@ static inline bool has_si_pid_and_uid(struct kernel_siginfo *info)
>>         case SIL_TIMER:
>>         case SIL_POLL:
>>         case SIL_FAULT:
>> +       case SIL_FAULT_TRAPNO:
>>         case SIL_FAULT_MCEERR:
>>         case SIL_FAULT_BNDERR:
>>         case SIL_FAULT_PKUERR:
>> @@ -2527,6 +2528,7 @@ static void hide_si_addr_tag_bits(struct ksignal *ksig)
>>  {
>>         switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
>>         case SIL_FAULT:
>> +       case SIL_FAULT_TRAPNO:
>>         case SIL_FAULT_MCEERR:
>>         case SIL_FAULT_BNDERR:
>>         case SIL_FAULT_PKUERR:
>> @@ -3206,6 +3208,12 @@ enum siginfo_layout siginfo_layout(unsigned sig, int si_code)
>>                         if ((sig == SIGBUS) &&
>>                             (si_code >= BUS_MCEERR_AR) && (si_code <= BUS_MCEERR_AO))
>>                                 layout = SIL_FAULT_MCEERR;
>> +                       else if (IS_ENABLED(ALPHA) &&
>> +                                ((sig == SIGFPE) ||
>> +                                 ((sig == SIGTRAP) && (si_code == TRAP_UNK))))
>> +                               layout = SIL_FAULT_TRAPNO;
>> +                       else if (IS_ENABLED(SPARC) && (sig == SIGILL) && (si_code == ILL_ILLTRP))
>> +                               layout = SIL_FAULT_TRAPNO;
>
> The breakage isn't apparent here, but in later patches. These need to
> become CONFIG_SPARC and CONFIG_ALPHA.

Good catch.  For some reason I thought IS_ENABLED added the CONFIG_
prefix but I looked and it doesn't.


>>                         else if ((sig == SIGSEGV) && (si_code == SEGV_BNDERR))
>>                                 layout = SIL_FAULT_BNDERR;
>>  #ifdef SEGV_PKUERR
>> @@ -3317,30 +3325,22 @@ void copy_siginfo_to_external32(struct compat_siginfo *to,
>>                 break;
>>         case SIL_FAULT:
>>                 to->si_addr = ptr_to_compat(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> +               break;
>> +       case SIL_FAULT_TRAPNO:
>> +               to->si_addr = ptr_to_compat(from->si_addr);
>>                 to->si_trapno = from->si_trapno;
>> -#endif
>>                 break;
>>         case SIL_FAULT_MCEERR:
>>                 to->si_addr = ptr_to_compat(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> -               to->si_trapno = from->si_trapno;
>> -#endif
>>                 to->si_addr_lsb = from->si_addr_lsb;
>>                 break;
>>         case SIL_FAULT_BNDERR:
>>                 to->si_addr = ptr_to_compat(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> -               to->si_trapno = from->si_trapno;
>> -#endif
>>                 to->si_lower = ptr_to_compat(from->si_lower);
>>                 to->si_upper = ptr_to_compat(from->si_upper);
>>                 break;
>>         case SIL_FAULT_PKUERR:
>>                 to->si_addr = ptr_to_compat(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> -               to->si_trapno = from->si_trapno;
>> -#endif
>>                 to->si_pkey = from->si_pkey;
>>                 break;
>>         case SIL_PERF_EVENT:
>> @@ -3401,30 +3401,22 @@ static int post_copy_siginfo_from_user32(kernel_siginfo_t *to,
>>                 break;
>>         case SIL_FAULT:
>>                 to->si_addr = compat_ptr(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> +               break;
>> +       case SIL_FAULT_TRAPNO:
>> +               to->si_addr = compat_ptr(from->si_addr);
>>                 to->si_trapno = from->si_trapno;
>> -#endif
>>                 break;
>>         case SIL_FAULT_MCEERR:
>>                 to->si_addr = compat_ptr(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> -               to->si_trapno = from->si_trapno;
>> -#endif
>>                 to->si_addr_lsb = from->si_addr_lsb;
>>                 break;
>>         case SIL_FAULT_BNDERR:
>>                 to->si_addr = compat_ptr(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> -               to->si_trapno = from->si_trapno;
>> -#endif
>>                 to->si_lower = compat_ptr(from->si_lower);
>>                 to->si_upper = compat_ptr(from->si_upper);
>>                 break;
>>         case SIL_FAULT_PKUERR:
>>                 to->si_addr = compat_ptr(from->si_addr);
>> -#ifdef __ARCH_SI_TRAPNO
>> -               to->si_trapno = from->si_trapno;
>> -#endif
>>                 to->si_pkey = from->si_pkey;
>>                 break;
>>         case SIL_PERF_EVENT:
>> --
>> 2.30.1
