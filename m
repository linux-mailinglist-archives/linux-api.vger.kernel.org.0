Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974822C0F6C
	for <lists+linux-api@lfdr.de>; Mon, 23 Nov 2020 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbgKWPyI (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Nov 2020 10:54:08 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:46892 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730775AbgKWPyI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 23 Nov 2020 10:54:08 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1khE9p-00AOeW-Gq; Mon, 23 Nov 2020 08:53:37 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1khE9o-002VLF-Gs; Mon, 23 Nov 2020 08:53:37 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
References: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
        <87h7pj1ulp.fsf@x220.int.ebiederm.org> <20201123114935.GD17833@gaia>
Date:   Mon, 23 Nov 2020 09:53:13 -0600
In-Reply-To: <20201123114935.GD17833@gaia> (Catalin Marinas's message of "Mon,
        23 Nov 2020 11:49:36 +0000")
Message-ID: <87y2isysra.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1khE9o-002VLF-Gs;;;mid=<87y2isysra.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/ry+q88UTCyU/G2s1YZX7m3LL9GyWOTKk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_SpammyWords,XM_B_SpammyWords2 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4981]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.8 XM_B_SpammyWords2 Two or more commony used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Catalin Marinas <catalin.marinas@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 413 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.8%), b_tie_ro: 10 (2.4%), parse: 1.13
        (0.3%), extract_message_metadata: 20 (4.9%), get_uri_detail_list: 2.1
        (0.5%), tests_pri_-1000: 16 (3.9%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.05 (0.3%), tests_pri_-90: 80 (19.3%), check_bayes:
        78 (18.9%), b_tokenize: 8 (1.9%), b_tok_get_all: 8 (1.9%),
        b_comp_prob: 2.4 (0.6%), b_tok_touch_all: 56 (13.6%), b_finish: 0.93
        (0.2%), tests_pri_0: 270 (65.4%), check_dkim_signature: 0.74 (0.2%),
        check_dkim_adsp: 3.2 (0.8%), poll_dns_idle: 0.29 (0.1%), tests_pri_10:
        2.0 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v21 1/2] signal: define the SA_EXPOSE_TAGBITS bit in sa_flags
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Fri, Nov 20, 2020 at 05:22:58PM -0600, Eric W. Biederman wrote:
>> Peter Collingbourne <pcc@google.com> writes:
>> 
>> > Architectures that support address tagging, such as arm64, may want to
>> > expose fault address tag bits to the signal handler to help diagnose
>> > memory errors. However, these bits have not been previously set,
>> > and their presence may confuse unaware user applications. Therefore,
>> > introduce a SA_EXPOSE_TAGBITS flag bit in sa_flags that a signal
>> > handler may use to explicitly request that the bits are set.
>> >
>> > The generic signal handler APIs expect to receive tagged addresses.
>> > Architectures may specify how to untag addresses in the case where
>> > SA_EXPOSE_TAGBITS is clear by defining the arch_untagged_si_addr
>> > function.
>> >
>> > Signed-off-by: Peter Collingbourne <pcc@google.com>
>> > Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> > Link: https://linux-review.googlesource.com/id/I16dd0ed2081f091fce97be0190cb8caa874c26cb
>> > ---
>> > To be applied on top of:
>> > https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11
>> 
>> I have merged this first patch into signal-for-v5.11 and pushed
>> everything out to linux-next.
>
> Thank you Eric. Assuming this branch won't be rebased, I'll apply the
> arm64 changes on top (well, if you rebase it, just let me know so that
> we don't end up with duplicate commits in mainline).

No.  I won't be rebasing it.  Not unless something serious problem shows
up, and at that point I will be more likely to apply a corrective change
on top that you can also grab.

Eric
