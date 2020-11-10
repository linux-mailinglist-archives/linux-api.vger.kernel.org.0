Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C002ACA1E
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 02:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgKJBNZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Nov 2020 20:13:25 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:38938 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBNY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Nov 2020 20:13:24 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcIDm-00GbIv-Hx; Mon, 09 Nov 2020 18:13:18 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcIDl-00BdYI-6y; Mon, 09 Nov 2020 18:13:17 -0700
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
        Richard Henderson <rth@twiddle.net>, linux-api@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
References: <cover.1604523707.git.pcc@google.com>
        <0ce3d90b5d6a4457b2fe3b0582f61fab70b17dfc.1604523707.git.pcc@google.com>
Date:   Mon, 09 Nov 2020 19:13:08 -0600
In-Reply-To: <0ce3d90b5d6a4457b2fe3b0582f61fab70b17dfc.1604523707.git.pcc@google.com>
        (Peter Collingbourne's message of "Wed, 4 Nov 2020 13:18:11 -0800")
Message-ID: <87eel2ypy3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kcIDl-00BdYI-6y;;;mid=<87eel2ypy3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19VidFgsnztWeSnS7Dkd47UYXIvr2cg2X4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2838]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 352 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (3.9%), b_tie_ro: 12 (3.4%), parse: 0.88
        (0.2%), extract_message_metadata: 4.0 (1.1%), get_uri_detail_list:
        1.57 (0.4%), tests_pri_-1000: 5 (1.5%), tests_pri_-950: 1.39 (0.4%),
        tests_pri_-900: 1.22 (0.3%), tests_pri_-90: 68 (19.3%), check_bayes:
        66 (18.6%), b_tokenize: 7 (2.0%), b_tok_get_all: 10 (2.8%),
        b_comp_prob: 3.2 (0.9%), b_tok_touch_all: 41 (11.5%), b_finish: 1.39
        (0.4%), tests_pri_0: 234 (66.5%), check_dkim_signature: 0.55 (0.2%),
        check_dkim_adsp: 2.8 (0.8%), poll_dns_idle: 1.05 (0.3%), tests_pri_10:
        3.2 (0.9%), tests_pri_500: 11 (3.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v14 8/8] arm64: expose FAR_EL1 tag bits in siginfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> the tag bits may be needed by tools in order to accurately diagnose
> memory errors, such as HWASan [1] or future tools based on the Memory
> Tagging Extension (MTE).
>
> We should not stop clearing these bits in the existing fault address
> fields, because there may be existing userspace applications that are
> expecting the tag bits to be cleared. Instead, create a new pair of
> fields in siginfo._sigfault, and store the tag bits of FAR_EL1 there,
> together with a mask specifying which bits are valid.
>
> A flag is added to si_faultflags to allow userspace to determine whether
> the values in the fields are valid.

I think I am missing some things:

Today it is documented that the tag bits are cleared, and so we can't
use the highbits to hold the tag bits by default.

Why do you need to deliver which tag bits are valid?  That feels like an
implementation detail that is needed to setup the tag bits.  It feels
like it would be constant per process.  So I don't understand why the
siginfo needs to report information the process should already have.


Want prevents adding a sigaction sa_flag SA_EXPOSE_TABITS that when set
causes the high bits to be set, and when clear (the default) will have
the signal delivery code clear those bits.

That should be enough for code that wants the tag bits to ask for them.
As userspace would need to be updated to get the new bits

Even if you have chained handlers.  The chaining mechanism would need to
be updated and it could call the aware handlers first then clear the tag
bits and call the rest of the handlers.

It feels like always passing the tag bits in the address and then
clearing them in the copy to userspace if the signal handler is
not ready for them would be easier to maintain.

Eric
