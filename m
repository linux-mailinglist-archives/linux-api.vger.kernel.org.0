Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746F42ACACC
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 02:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbgKJB5w (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 9 Nov 2020 20:57:52 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:34784 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJB5w (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Nov 2020 20:57:52 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcIul-002qP7-5T; Mon, 09 Nov 2020 18:57:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcIuk-0003cH-Cn; Mon, 09 Nov 2020 18:57:43 -0700
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
        <0eb601a5d1906fadd7099149eb605181911cfc04.1604523707.git.pcc@google.com>
Date:   Mon, 09 Nov 2020 19:57:33 -0600
In-Reply-To: <0eb601a5d1906fadd7099149eb605181911cfc04.1604523707.git.pcc@google.com>
        (Peter Collingbourne's message of "Wed, 4 Nov 2020 13:18:10 -0800")
Message-ID: <87zh3qug6q.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kcIuk-0003cH-Cn;;;mid=<87zh3qug6q.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+BHOLC6pp4F6dvMCbEBxblvibGsnpJFu8=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_08,XMSubLong,XM_B_Unsub
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4979]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.5 XM_B_Unsub Unsubscribe in body of email but missing unsubscribe
        *       header
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 410 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 11 (2.8%), b_tie_ro: 9 (2.3%), parse: 1.05 (0.3%),
         extract_message_metadata: 3.8 (0.9%), get_uri_detail_list: 1.48
        (0.4%), tests_pri_-1000: 4.8 (1.2%), tests_pri_-950: 1.25 (0.3%),
        tests_pri_-900: 1.03 (0.3%), tests_pri_-90: 55 (13.5%), check_bayes:
        53 (12.9%), b_tokenize: 8 (1.9%), b_tok_get_all: 7 (1.8%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 32 (7.8%), b_finish: 1.01
        (0.2%), tests_pri_0: 304 (74.2%), check_dkim_signature: 0.88 (0.2%),
        check_dkim_adsp: 3.5 (0.9%), poll_dns_idle: 1.07 (0.3%), tests_pri_10:
        4.4 (1.1%), tests_pri_500: 14 (3.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v14 7/8] signal: define the field siginfo.si_faultflags
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> This field will contain flags that may be used by signal handlers to
> determine whether other fields in the _sigfault portion of siginfo are
> valid. An example use case is the following patch, which introduces
> the si_addr_tag_bits{,_mask} fields.
>
> A new sigcontext flag, SA_FAULTFLAGS, is introduced in order to allow
> a signal handler to require the kernel to set the field (but note
> that the field will be set anyway if the kernel supports the flag,
> regardless of its value). In combination with the previous patches,
> this allows a userspace program to determine whether the kernel will
> set the field.
>
> It is possible for an si_faultflags-unaware program to cause a signal
> handler in an si_faultflags-aware program to be called with a provided
> siginfo data structure by using one of the following syscalls:
>
> - ptrace(PTRACE_SETSIGINFO)
> - pidfd_send_signal
> - rt_sigqueueinfo
> - rt_tgsigqueueinfo
>
> So we need to prevent the si_faultflags-unaware program from causing an
> uninitialized read of si_faultflags in the si_faultflags-aware program when
> it uses one of these syscalls.
>
> The last three cases can be handled by observing that each of these
> syscalls fails if si_code >= 0. We also observe that kill(2) and
> tgkill(2) may be used to send a signal where si_code == 0 (SI_USER),
> so we define si_faultflags to only be valid if si_code > 0.
>
> There is no such check on si_code in ptrace(PTRACE_SETSIGINFO), so
> we make ptrace(PTRACE_SETSIGINFO) clear the si_faultflags field if it
> detects that the signal would use the _sigfault layout, and introduce
> a new ptrace request type, PTRACE_SETSIGINFO2, that a si_faultflags-aware
> program may use to opt out of this behavior.

So I think while well intentioned this is misguided.

gdb and the like may use this but I expect the primary user is CRIU
which simply reads the signal out of one process saves it on disk
and then restores the signal as read into the new process (possibly
on a different machine).

At least for the CRIU usage PTRACE_SETSIGINFO need to remain a raw
pass through kind of operation.

Eric
