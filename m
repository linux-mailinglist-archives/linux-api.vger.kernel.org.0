Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98E2AF99E
	for <lists+linux-api@lfdr.de>; Wed, 11 Nov 2020 21:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKKUPe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Nov 2020 15:15:34 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:40584 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgKKUPe (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Nov 2020 15:15:34 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcwWe-006g7P-Aw; Wed, 11 Nov 2020 13:15:28 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcwWc-0000EG-Pi; Wed, 11 Nov 2020 13:15:28 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        <87zh3qug6q.fsf@x220.int.ebiederm.org> <20201111172703.GP6882@arm.com>
Date:   Wed, 11 Nov 2020 14:15:15 -0600
In-Reply-To: <20201111172703.GP6882@arm.com> (Dave Martin's message of "Wed,
        11 Nov 2020 17:27:04 +0000")
Message-ID: <87imabr6p8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kcwWc-0000EG-Pi;;;mid=<87imabr6p8.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/7N/eWBv/4p/S3APPKai60j3a29t5pU/E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_08,XMSubLong,XM_B_Unsub
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.5 XM_B_Unsub Unsubscribe in body of email but missing unsubscribe
        *       header
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dave Martin <Dave.Martin@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1058 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.0%), b_tie_ro: 9 (0.9%), parse: 1.14 (0.1%),
         extract_message_metadata: 15 (1.4%), get_uri_detail_list: 3.3 (0.3%),
        tests_pri_-1000: 4.2 (0.4%), tests_pri_-950: 1.30 (0.1%),
        tests_pri_-900: 1.02 (0.1%), tests_pri_-90: 223 (21.1%), check_bayes:
        217 (20.6%), b_tokenize: 11 (1.0%), b_tok_get_all: 10 (1.0%),
        b_comp_prob: 3.4 (0.3%), b_tok_touch_all: 188 (17.8%), b_finish: 0.94
        (0.1%), tests_pri_0: 410 (38.8%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 3.1 (0.3%), poll_dns_idle: 368 (34.8%), tests_pri_10:
        2.7 (0.3%), tests_pri_500: 385 (36.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v14 7/8] signal: define the field siginfo.si_faultflags
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Dave Martin <Dave.Martin@arm.com> writes:

> On Mon, Nov 09, 2020 at 07:57:33PM -0600, Eric W. Biederman wrote:
>> Peter Collingbourne <pcc@google.com> writes:
>> 
>> > This field will contain flags that may be used by signal handlers to
>> > determine whether other fields in the _sigfault portion of siginfo are
>> > valid. An example use case is the following patch, which introduces
>> > the si_addr_tag_bits{,_mask} fields.
>> >
>> > A new sigcontext flag, SA_FAULTFLAGS, is introduced in order to allow
>> > a signal handler to require the kernel to set the field (but note
>> > that the field will be set anyway if the kernel supports the flag,
>> > regardless of its value). In combination with the previous patches,
>> > this allows a userspace program to determine whether the kernel will
>> > set the field.
>> >
>> > It is possible for an si_faultflags-unaware program to cause a signal
>> > handler in an si_faultflags-aware program to be called with a provided
>> > siginfo data structure by using one of the following syscalls:
>> >
>> > - ptrace(PTRACE_SETSIGINFO)
>> > - pidfd_send_signal
>> > - rt_sigqueueinfo
>> > - rt_tgsigqueueinfo
>> >
>> > So we need to prevent the si_faultflags-unaware program from causing an
>> > uninitialized read of si_faultflags in the si_faultflags-aware program when
>> > it uses one of these syscalls.
>> >
>> > The last three cases can be handled by observing that each of these
>> > syscalls fails if si_code >= 0. We also observe that kill(2) and
>> > tgkill(2) may be used to send a signal where si_code == 0 (SI_USER),
>> > so we define si_faultflags to only be valid if si_code > 0.
>> >
>> > There is no such check on si_code in ptrace(PTRACE_SETSIGINFO), so
>> > we make ptrace(PTRACE_SETSIGINFO) clear the si_faultflags field if it
>> > detects that the signal would use the _sigfault layout, and introduce
>> > a new ptrace request type, PTRACE_SETSIGINFO2, that a si_faultflags-aware
>> > program may use to opt out of this behavior.
>> 
>> So I think while well intentioned this is misguided.
>> 
>> gdb and the like may use this but I expect the primary user is CRIU
>> which simply reads the signal out of one process saves it on disk
>> and then restores the signal as read into the new process (possibly
>> on a different machine).
>> 
>> At least for the CRIU usage PTRACE_SETSIGINFO need to remain a raw
>> pass through kind of operation.
>
> This is a problem, though.
>
> How can we tell the difference between a siginfo that was generated by
> the kernel and a siginfo that was generated (or altered) by a non-xflags
> aware userspace?
>
> Short of revving the whole API, I don't see a simple solution to this.

Unlike receiving a signal.  We do know that userspace old and new
always sends unused fields as zero into PTRACE_SETSIGINFO.

The split into kernel_siginfo verifies this and fails userspace if it
does something different.  No problems have been reported.

So in the case of xflags a non-xflags aware userspace would either pass
the siginfo from through from somewhere else (such as
PTRACE_GETSIGINFO), or it would simply generate a signal with all of
the xflags bits clear.  So everything should work regardless.

> Although a bit of a hack, could we include some kind of checksum in the
> siginfo?  If the checksum matches during PTRACE_SETSIGINFO, we could
> accept the whole thing; xflags included.  Otherwise, we could silently
> drop non-self-describing extensions.
>
> If we only need to generate the checksum when PTRACE_GETSIGINFO is
> called then it might be feasible to use a strong hash; otherwise, this
> mechanism will be far from bulletproof.
>
> A hash has the advantage that we don't need any other information
> to validate it beyond a salt: if the hash matches, it's self-
> validating.  We could also package other data with it to describe the
> presence of extensions, but relying on this for regular sigaction()/
> signal delivery use feels too high-overhead.
>
> For debuggers, I suspect that PTRACE_SETSIGINFO2 is still useful:
> userspace callers that want to write an extension field that they
> knowingly generated themselves should have a way to express that.
>
> Thoughts?

I think there are two cases:
1) CRIU  -- It is just a passthrough of PTRACE_GETSIGINFO
2) Creating a signal from nowhere -- Code that does not know about
   xflags would leave xflags at 0 so no problem.

Does anyone see any other cases I am missing?

Eric
