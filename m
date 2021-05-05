Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E648D373D64
	for <lists+linux-api@lfdr.de>; Wed,  5 May 2021 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhEEON5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 May 2021 10:13:57 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43334 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhEEONl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 May 2021 10:13:41 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIGa-00CGlJ-DX; Wed, 05 May 2021 08:12:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1leIGX-002GvZ-Te; Wed, 05 May 2021 08:12:43 -0600
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
        <m1r1irpc5v.fsf@fess.ebiederm.org>
        <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
        <m1czuapjpx.fsf@fess.ebiederm.org>
        <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
        <m14kfjh8et.fsf_-_@fess.ebiederm.org>
        <m1tuni8ano.fsf_-_@fess.ebiederm.org>
        <CANpmjNM5sYihM_9P5YHx06BooqLDhK96cMHGKaf61nCcoDJBdw@mail.gmail.com>
Date:   Wed, 05 May 2021 09:12:38 -0500
In-Reply-To: <CANpmjNM5sYihM_9P5YHx06BooqLDhK96cMHGKaf61nCcoDJBdw@mail.gmail.com>
        (Marco Elver's message of "Wed, 5 May 2021 00:05:00 +0200")
Message-ID: <m1o8dp8e21.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1leIGX-002GvZ-Te;;;mid=<m1o8dp8e21.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19By7EuCGlSC+Hrh/+dmLFpw1rmZv8aoeM=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,TR_XM_PhishingBody,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XM_B_Phish66 autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3381]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Marco Elver <elver@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1887 ms - load_scoreonly_sql: 0.17 (0.0%),
        signal_user_changed: 15 (0.8%), b_tie_ro: 12 (0.6%), parse: 1.92
        (0.1%), extract_message_metadata: 20 (1.1%), get_uri_detail_list: 3.8
        (0.2%), tests_pri_-1000: 19 (1.0%), tests_pri_-950: 1.90 (0.1%),
        tests_pri_-900: 1.38 (0.1%), tests_pri_-90: 1228 (65.1%), check_bayes:
        1225 (64.9%), b_tokenize: 12 (0.6%), b_tok_get_all: 9 (0.5%),
        b_comp_prob: 3.1 (0.2%), b_tok_touch_all: 1197 (63.4%), b_finish: 1.32
        (0.1%), tests_pri_0: 579 (30.7%), check_dkim_signature: 0.87 (0.0%),
        check_dkim_adsp: 2.6 (0.1%), poll_dns_idle: 0.44 (0.0%), tests_pri_10:
        2.2 (0.1%), tests_pri_500: 13 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Marco Elver <elver@google.com> writes:

> On Tue, 4 May 2021 at 23:13, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> This set of changes sorts out the ABI issues with SIGTRAP TRAP_PERF, and
>> hopefully will can get merged before any userspace code starts using the
>> new ABI.
>>
>> The big ideas are:
>> - Placing the asserts first to prevent unexpected ABI changes
>> - si_trapno becomming ordinary fault subfield.
>> - struct signalfd_siginfo is almost full
>>
>> This set of changes starts out with Marco's static_assert changes and
>> additional one of my own that enforces the fact that the alignment of
>> siginfo_t is also part of the ABI.  Together these build time
>> checks verify there are no unexpected ABI changes in the changes
>> that follow.
>>
>> The field si_trapno is changed to become an ordinary extension of the
>> _sigfault member of siginfo.
>>
>> The code is refactored a bit and then si_perf_type is added along side
>> si_perf_data in the _perf subfield of _sigfault of siginfo_t.
>>
>> Finally the signalfd_siginfo fields are removed as they appear to be
>> filling up the structure without userspace actually being able to use
>> them.
>>
>> v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
>> v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org
>>
>> Eric W. Biederman (9):
>>       signal: Verify the alignment and size of siginfo_t
>>       siginfo: Move si_trapno inside the union inside _si_fault
>>       signal: Implement SIL_FAULT_TRAPNO
>>       signal: Use dedicated helpers to send signals with si_trapno set
>>       signal: Remove __ARCH_SI_TRAPNO
>>       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
>>       signal: Factor force_sig_perf out of perf_sigtrap
>>       signal: Deliver all of the siginfo perf data in _perf
>>       signalfd: Remove SIL_FAULT_PERF_EVENT fields from signalfd_siginfo
>>
>> Marco Elver (3):
>>       sparc64: Add compile-time asserts for siginfo_t offsets
>>       arm: Add compile-time asserts for siginfo_t offsets
>>       arm64: Add compile-time asserts for siginfo_t offsets
>
> I can't seem to see the rest of them in my inbox. LKML also is missing
> them: https://lore.kernel.org/linux-api/m1tuni8ano.fsf_-_@fess.ebiederm.org/
>
> Something must have swallowed them. Could you resend?
> I'll then test in the morning.

They got stuck going out you should see them any time now.
Sorry about that.

Eric
