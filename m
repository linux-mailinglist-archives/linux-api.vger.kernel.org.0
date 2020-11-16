Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14832B53FF
	for <lists+linux-api@lfdr.de>; Mon, 16 Nov 2020 22:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgKPVzh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 16:55:37 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:46636 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgKPVzh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 16:55:37 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kemT4-00Bu1J-50; Mon, 16 Nov 2020 14:55:22 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kemT3-0005JW-7s; Mon, 16 Nov 2020 14:55:22 -0700
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
References: <cover.1605235762.git.pcc@google.com>
        <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
        <X7LMfrl/vQ8vA+Va@trantor>
Date:   Mon, 16 Nov 2020 15:55:05 -0600
In-Reply-To: <X7LMfrl/vQ8vA+Va@trantor> (Catalin Marinas's message of "Mon, 16
        Nov 2020 19:01:18 +0000")
Message-ID: <87d00dge6e.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kemT3-0005JW-7s;;;mid=<87d00dge6e.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19k++9Pb29rKqviHnrrXVeKG7pYWi03qds=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4849]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Catalin Marinas <catalin.marinas@arm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 571 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 10 (1.7%), b_tie_ro: 8 (1.4%), parse: 1.54 (0.3%),
         extract_message_metadata: 16 (2.8%), get_uri_detail_list: 2.3 (0.4%),
        tests_pri_-1000: 7 (1.2%), tests_pri_-950: 1.56 (0.3%),
        tests_pri_-900: 1.23 (0.2%), tests_pri_-90: 122 (21.3%), check_bayes:
        115 (20.1%), b_tokenize: 11 (2.0%), b_tok_get_all: 11 (2.0%),
        b_comp_prob: 3.3 (0.6%), b_tok_touch_all: 85 (14.9%), b_finish: 0.93
        (0.2%), tests_pri_0: 393 (68.8%), check_dkim_signature: 1.52 (0.3%),
        check_dkim_adsp: 4.1 (0.7%), poll_dns_idle: 0.25 (0.0%), tests_pri_10:
        2.2 (0.4%), tests_pri_500: 12 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v16 6/6] arm64: expose FAR_EL1 tag bits in siginfo
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Nov 12, 2020 at 06:53:36PM -0800, Peter Collingbourne wrote:
>> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
>> index eab4323609b9..19d284b70384 100644
>> --- a/Documentation/arm64/tagged-pointers.rst
>> +++ b/Documentation/arm64/tagged-pointers.rst
>> @@ -53,12 +53,25 @@ visibility.
>>  Preserving tags
>>  ---------------
>>  
>> -Non-zero tags are not preserved when delivering signals. This means that
>> -signal handlers in applications making use of tags cannot rely on the
>> -tag information for user virtual addresses being maintained for fields
>> -inside siginfo_t. One exception to this rule is for signals raised in
>> -response to watchpoint debug exceptions, where the tag information will
>> -be preserved.
>> +When delivering signals, non-zero tags are not preserved in
>> +siginfo.si_addr unless the flag SA_EXPOSE_TAGBITS was set in
>> +sigaction.sa_flags when the signal handler was installed. This means
>> +that signal handlers in applications making use of tags cannot rely
>> +on the tag information for user virtual addresses being maintained
>> +in these fields unless the flag was set.
>> +
>> +Due to architecture limitations, bits 63:60 of the fault address
>> +are not preserved in response to synchronous tag check faults
>> +(SEGV_MTESERR) even if SA_EXPOSE_TAGBITS was set. Applications should
>> +treat the values of these bits as undefined in order to accommodate
>> +future architecture revisions which may preserve the bits.
>
> If future architecture versions will preserve these bits, most likely
> we'll add a new HWCAP bit so that the user knows what's going on. But
> the user shouldn't rely on them being 0, just in case.
>
>> +For signals raised in response to watchpoint debug exceptions, the
>> +tag information will be preserved regardless of the SA_EXPOSE_TAGBITS
>> +flag setting.
>> +
>> +Non-zero tags are never preserved in sigcontext.fault_address
>> +regardless of the SA_EXPOSE_TAGBITS flag setting.
>
> We could've done it the other way around (fault_address tagged, si_addr
> untagged) but that would be specific to arm64, so I think we should
> solve it for other architectures that implement (or plan to) tagging.
> The fault_address in the arm64 sigcontext was an oversight, we should
> have removed it but when we realised it was already ABI.
>
> Anyway, I'm fine with the arm64 changes here:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> With Eric's ack, I'm happy to take the series through the arm64 tree,
> otherwise Eric's tree is fine as well.

In general I am fine with the last two patches.

I want to understand where the value for SA_UNSUPPORTED comes from, and
while I have good answers I am still digesting the question of if
SA_EXPOSE_TAGBITS should be implemented in the arch specific header or
in a generic header.  I quite agree it should have a generic
definition/implementation.  I just don't know if it makes sense to make
the value available to userspace if the architecture does not have
tagbits.  Mostly my concern is about bit consumption as we only have
30ish sigaction bits.

I will follow with my acks when I have resolved those issues.

Thank you,
Eric

