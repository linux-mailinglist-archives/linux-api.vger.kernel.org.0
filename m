Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE9D2BB530
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 20:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732101AbgKTTYg (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 14:24:36 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:53318 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732089AbgKTTYf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 14:24:35 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgC1F-0027H7-IK; Fri, 20 Nov 2020 12:24:29 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgC1E-00DlwZ-C7; Fri, 20 Nov 2020 12:24:29 -0700
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
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
References: <20201119190921.3589081-1-pcc@google.com>
        <87wnyf3ovs.fsf@x220.int.ebiederm.org>
        <CAMn1gO6mzzpnYbKfn3gXAwX2tejD-g+2S_ShkyWVCLskFWSqvg@mail.gmail.com>
Date:   Fri, 20 Nov 2020 13:24:07 -0600
In-Reply-To: <CAMn1gO6mzzpnYbKfn3gXAwX2tejD-g+2S_ShkyWVCLskFWSqvg@mail.gmail.com>
        (Peter Collingbourne's message of "Fri, 20 Nov 2020 10:22:47 -0800")
Message-ID: <878sav3k88.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kgC1E-00DlwZ-C7;;;mid=<878sav3k88.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+i7MlS8U5d+nsb2ZYbkgq9Wmx9qV+PC10=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4813]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 566 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 15 (2.6%), b_tie_ro: 9 (1.6%), parse: 1.94 (0.3%),
         extract_message_metadata: 20 (3.5%), get_uri_detail_list: 2.4 (0.4%),
        tests_pri_-1000: 24 (4.3%), tests_pri_-950: 1.59 (0.3%),
        tests_pri_-900: 1.20 (0.2%), tests_pri_-90: 155 (27.5%), check_bayes:
        152 (26.9%), b_tokenize: 9 (1.7%), b_tok_get_all: 30 (5.3%),
        b_comp_prob: 2.9 (0.5%), b_tok_touch_all: 106 (18.7%), b_finish: 1.07
        (0.2%), tests_pri_0: 308 (54.5%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 2.9 (0.5%), poll_dns_idle: 0.36 (0.1%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 31 (5.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v20] arm64: expose FAR_EL1 tag bits in siginfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> On Fri, Nov 20, 2020 at 9:44 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Peter Collingbourne <pcc@google.com> writes:
>>
>> > The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
>> > address exposed via siginfo.si_addr and sigcontext.fault_address. However,
>> > the tag bits may be needed by tools in order to accurately diagnose
>> > memory errors, such as HWASan [1] or future tools based on the Memory
>> > Tagging Extension (MTE).
>> >
>> > We should not stop clearing these bits in the existing fault address
>> > fields, because there may be existing userspace applications that are
>> > expecting the tag bits to be cleared. Instead, introduce a flag in
>> > sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
>> > there if the signal handler has this flag set.
>> >
>> > [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html
>>
>> For the generic bits:
>> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Thanks for the review.
>
>> Some of the arm bits look wrong.  There are a couple of cases where
>> it looks like you are deliberately passing an untagged address into
>> functions that normally take tagged addresses.
>>
>> It might be a good idea to have a type distinction between the two.
>> Perhaps "(void __user *)" vs "(unsigned long)" so that accidentally
>> using the wrong one generates a type error.
>>
>> I don't think I am really qualified to review all of the arm details,
>> and I certainly don't want to be in the middle of any arm bugs this
>> code might introduce.  If you will split out the generic bits of this
>> patch I will take it.  The this whole thing can be merged into the arm
>
> Okay, I'll do that.

Thank you.

>> tree and you can ensure the arm bits are correct.
>
> So you want Catalin to merge your signal-for-v5.11 branch with the
> generic patches into the arm64 tree and then add the arm64-specific
> patch on top? Works for me.

I think that is what we discussed.  Unless he has objections I would
prefer that.  I based the branch on -rc3 in hopes that I would
not cause problems for his process.

In the cases where I was confused you probably want comments describing
why the tag bits are being cleared.  It may be obvious when you know the
architecture intimately but it certainly was not for me.  I certainly
don't know the details of arm64 well enough to understand the
architecture specific nuances.

Eric
