Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B162B6CF3
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 19:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbgKQSRB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 13:17:01 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:51778 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730979AbgKQSRB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 13:17:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf5XB-00DV8E-St; Tue, 17 Nov 2020 11:16:54 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf5XA-004v0U-Rf; Tue, 17 Nov 2020 11:16:53 -0700
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
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
References: <cover.1605582887.git.pcc@google.com>
Date:   Tue, 17 Nov 2020 12:16:35 -0600
In-Reply-To: <cover.1605582887.git.pcc@google.com> (Peter Collingbourne's
        message of "Mon, 16 Nov 2020 19:17:23 -0800")
Message-ID: <87a6vfdf24.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kf5XA-004v0U-Rf;;;mid=<87a6vfdf24.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX198FaP5HgN4dI/5wsAe2ngeLWpuhYSDD6U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2207]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 366 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (3.1%), b_tie_ro: 10 (2.7%), parse: 0.87
        (0.2%), extract_message_metadata: 3.2 (0.9%), get_uri_detail_list:
        1.29 (0.4%), tests_pri_-1000: 4.4 (1.2%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.07 (0.3%), tests_pri_-90: 117 (32.0%), check_bayes:
        115 (31.5%), b_tokenize: 8 (2.1%), b_tok_get_all: 9 (2.4%),
        b_comp_prob: 3.7 (1.0%), b_tok_touch_all: 91 (24.8%), b_finish: 1.02
        (0.3%), tests_pri_0: 208 (57.0%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.67 (0.2%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 7 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v17 0/3] arm64: expose FAR_EL1 tag bits in siginfo
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
> expecting the tag bits to be cleared. Instead, introduce a flag in
> sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
> there if the signal handler has this flag set.
>
> In order to allow userspace to determine whether SA_EXPOSE_TAGBITS
> is supported, we first introduce a mechanism for userspace to detect
> kernel support for SA_* flags.
>
> These patches need to be applied on top of:
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11

The first two patches look good and I have applied them.

While I was at it I added Link tags to the LKML postings to the entire
series.  I don't think anyone has merged my branch into another so it
should still be safe.

Eric
