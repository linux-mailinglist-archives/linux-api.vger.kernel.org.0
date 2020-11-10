Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1772ADA97
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 16:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732628AbgKJPir (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Nov 2020 10:38:47 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:44394 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732625AbgKJPir (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Nov 2020 10:38:47 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcVjJ-001ycA-0Y; Tue, 10 Nov 2020 08:38:45 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcVjI-0006WK-0f; Tue, 10 Nov 2020 08:38:44 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
References: <cover.1604523707.git.pcc@google.com>
        <4d826a62121153d54d7e36fc8a402c97e2106764.1604523707.git.pcc@google.com>
        <87lffa11sa.fsf@x220.int.ebiederm.org>
        <CAMn1gO63+7ZxcvSyHt1nrTQ+N=zk=xGYNiToRxwRcP5=UsQmsQ@mail.gmail.com>
Date:   Tue, 10 Nov 2020 09:38:34 -0600
In-Reply-To: <CAMn1gO63+7ZxcvSyHt1nrTQ+N=zk=xGYNiToRxwRcP5=UsQmsQ@mail.gmail.com>
        (Peter Collingbourne's message of "Mon, 9 Nov 2020 18:37:36 -0800")
Message-ID: <875z6dte6d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kcVjI-0006WK-0f;;;mid=<875z6dte6d.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/qYS2D7zgHzmBolnqloWRSVcj8hZZqxIo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4958]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 644 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.7 (0.6%), b_tie_ro: 2.5 (0.4%), parse: 0.67
        (0.1%), extract_message_metadata: 8 (1.3%), get_uri_detail_list: 1.27
        (0.2%), tests_pri_-1000: 11 (1.7%), tests_pri_-950: 1.08 (0.2%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 360 (55.9%), check_bayes:
        359 (55.7%), b_tokenize: 6 (1.0%), b_tok_get_all: 7 (1.1%),
        b_comp_prob: 1.54 (0.2%), b_tok_touch_all: 341 (53.0%), b_finish: 0.77
        (0.1%), tests_pri_0: 249 (38.6%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.93 (0.1%), tests_pri_10:
        1.75 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v14 4/8] signal: deduplicate code dealing with common _sigfault fields
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> On Mon, Nov 9, 2020 at 4:41 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Peter Collingbourne <pcc@google.com> writes:
>>
>> > We're about to add more common _sigfault fields, so deduplicate the
>> > existing code for initializing _sigfault fields in {send,force}_sig_*,
>> > and for copying _sigfault fields in copy_siginfo_to_external32 and
>> > post_copy_siginfo_from_user32, to reduce the number of places that
>> > will need to be updated by upcoming changes.
>>
>> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Thanks for the review.
>
>> No real objection but I am wondering if it might be better to
>> introduce two small inline functions for setting common fields
>> instead of:
>>
>> > +     if (siginfo_layout_is_fault(layout)) {
>> > +             to->si_addr = ptr_to_compat(from->si_addr);
>> > +#ifdef __ARCH_SI_TRAPNO
>> > +             to->si_trapno = from->si_trapno;
>> > +#endif
>> > +     }
>>
>> and
>>
>> > +     if (siginfo_layout_is_fault(layout)) {
>> > +             to->si_addr = compat_ptr(from->si_addr);
>> > +#ifdef __ARCH_SI_TRAPNO
>> > +             to->si_trapno = from->si_trapno;
>> > +#endif
>> > +     }
>>
>> perhaps called:
>> copy_sigfault_common_to_external32
>> post_copy_sigfault_common_from_user32
>>
>> I have not benchmarked or anything but my gut says one less conditional
>> branch to worry about makes dealing with spectre easier and probably
>> produces faster code as well.  Possibly even smaller code.
>
> Dave made the same proposal on an earlier version of the patch which I
> responded to in [1]. The main reason for keeping things as I
> implemented them was because of the ptrace handling but if we do end
> up dropping that as you proposed on the other patch then I think I'd
> be happy to move the code into helper functions.
>
> Peter
>
> [1] https://lore.kernel.org/linux-parisc/CAMn1gO42arQKGBj1Nnbs86TGYyogpRR_t73H=GbTmQrbAbV30A@mail.gmail.com/

That makes sense.

Eric
