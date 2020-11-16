Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8542E2B5573
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 01:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKQAAS (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 19:00:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:47974 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgKQAAR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 19:00:17 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1keoPk-00FsVl-Tk; Mon, 16 Nov 2020 17:00:05 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1keoPj-0005bt-DY; Mon, 16 Nov 2020 17:00:04 -0700
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
References: <cover.1605235762.git.pcc@google.com>
        <81e1307108ca8ea67aa1060f6f47b34a507410f1.1605235762.git.pcc@google.com>
        <X7LMfrl/vQ8vA+Va@trantor> <87d00dge6e.fsf@x220.int.ebiederm.org>
        <CAMn1gO7wU1FS5wf0Nz+pO7oNGErub-gJucG6XX8QS6JMq+P84A@mail.gmail.com>
Date:   Mon, 16 Nov 2020 17:59:47 -0600
In-Reply-To: <CAMn1gO7wU1FS5wf0Nz+pO7oNGErub-gJucG6XX8QS6JMq+P84A@mail.gmail.com>
        (Peter Collingbourne's message of "Mon, 16 Nov 2020 15:28:29 -0800")
Message-ID: <878sb0g8ek.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1keoPj-0005bt-DY;;;mid=<878sb0g8ek.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/+Ukk1mkf/W4/9EfHqyZUNvhSPx10VC/s=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubLong,XM_B_SpammyWords autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4949]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 592 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.8%), b_tie_ro: 9 (1.6%), parse: 0.93 (0.2%),
         extract_message_metadata: 18 (3.0%), get_uri_detail_list: 4.0 (0.7%),
        tests_pri_-1000: 15 (2.5%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 94 (15.9%), check_bayes:
        91 (15.4%), b_tokenize: 14 (2.3%), b_tok_get_all: 14 (2.3%),
        b_comp_prob: 3.8 (0.6%), b_tok_touch_all: 56 (9.5%), b_finish: 0.81
        (0.1%), tests_pri_0: 438 (73.9%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 0.21 (0.0%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 9 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v16 6/6] arm64: expose FAR_EL1 tag bits in siginfo
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> On Mon, Nov 16, 2020 at 1:55 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>>
>> > On Thu, Nov 12, 2020 at 06:53:36PM -0800, Peter Collingbourne wrote:
>> >> diff --git a/Documentation/arm64/tagged-pointers.rst b/Documentation/arm64/tagged-pointers.rst
>> >> index eab4323609b9..19d284b70384 100644
>> >> --- a/Documentation/arm64/tagged-pointers.rst
>> >> +++ b/Documentation/arm64/tagged-pointers.rst
>> >> @@ -53,12 +53,25 @@ visibility.
>> >>  Preserving tags
>> >>  ---------------
>> >>
>> >> -Non-zero tags are not preserved when delivering signals. This means that
>> >> -signal handlers in applications making use of tags cannot rely on the
>> >> -tag information for user virtual addresses being maintained for fields
>> >> -inside siginfo_t. One exception to this rule is for signals raised in
>> >> -response to watchpoint debug exceptions, where the tag information will
>> >> -be preserved.
>> >> +When delivering signals, non-zero tags are not preserved in
>> >> +siginfo.si_addr unless the flag SA_EXPOSE_TAGBITS was set in
>> >> +sigaction.sa_flags when the signal handler was installed. This means
>> >> +that signal handlers in applications making use of tags cannot rely
>> >> +on the tag information for user virtual addresses being maintained
>> >> +in these fields unless the flag was set.
>> >> +
>> >> +Due to architecture limitations, bits 63:60 of the fault address
>> >> +are not preserved in response to synchronous tag check faults
>> >> +(SEGV_MTESERR) even if SA_EXPOSE_TAGBITS was set. Applications should
>> >> +treat the values of these bits as undefined in order to accommodate
>> >> +future architecture revisions which may preserve the bits.
>> >
>> > If future architecture versions will preserve these bits, most likely
>> > we'll add a new HWCAP bit so that the user knows what's going on. But
>> > the user shouldn't rely on them being 0, just in case.
>> >
>> >> +For signals raised in response to watchpoint debug exceptions, the
>> >> +tag information will be preserved regardless of the SA_EXPOSE_TAGBITS
>> >> +flag setting.
>> >> +
>> >> +Non-zero tags are never preserved in sigcontext.fault_address
>> >> +regardless of the SA_EXPOSE_TAGBITS flag setting.
>> >
>> > We could've done it the other way around (fault_address tagged, si_addr
>> > untagged) but that would be specific to arm64, so I think we should
>> > solve it for other architectures that implement (or plan to) tagging.
>> > The fault_address in the arm64 sigcontext was an oversight, we should
>> > have removed it but when we realised it was already ABI.
>> >
>> > Anyway, I'm fine with the arm64 changes here:
>> >
>> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> >
>> > With Eric's ack, I'm happy to take the series through the arm64 tree,
>> > otherwise Eric's tree is fine as well.
>>
>> In general I am fine with the last two patches.
>>
>> I want to understand where the value for SA_UNSUPPORTED comes from, and
>
> I hope I explained it well enough in [1]. If documenting the
> arch-specific bits that way looks good to you let me know and I will
> update patch 3.

Bah.  I missed your reply.

Please send me an incremental patch against:

 https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11

As I have already applied your first 4 patches and have them in
linux-next.

>> while I have good answers I am still digesting the question of if
>> SA_EXPOSE_TAGBITS should be implemented in the arch specific header or
>> in a generic header.  I quite agree it should have a generic
>> definition/implementation.  I just don't know if it makes sense to make
>> the value available to userspace if the architecture does not have
>> tagbits.  Mostly my concern is about bit consumption as we only have
>> 30ish sigaction bits.
>
> As mentioned in [2] I would favor making the bits generic as that
> would simplify the client code. And I would personally not be too
> concerned about consuming bits here. Our historical rate of adding new
> bits is very low (as far as I know these are the first new bits to be
> added in about 20 years!) And once we are at the point where we are
> close to running out of bits it would be a good time to consider a new
> sigaction API anyway that addresses some of the historical warts of
> the existing one, and at that point we should be able to come up with
> a way to add more bits.

It is a good point that this areay hasn't seen much action in ages.  So
there is not too much need to be concerned.

In general portable code will need to do "#ifdef SA_EXPOSE_TAGBITS"
somewhere.  But certainly it should be at least as generic as
SA_RESTORER.  With the same meaning everywhere it is defined.
And certainly it makes sense for the implementation to live
in the generic signal code for to ensure all architectures implement
it with the same semantics.

I am going to sleep on this one and then see if I see any real concerns.

This is bike-shedding I know, and you have done a very nice job gettin
this far.  So I don't expect I will come up with any compelling reasons
to change after sleeping on it, but I am going to sleep on it.


> [1] https://lore.kernel.org/linux-arm-kernel/CAMn1gO52j4fSEn5S2GdrtyCq+iiaMK16DkKiyj=Go91Jy+xR-w@mail.gmail.com/
> [2] https://lore.kernel.org/linux-arm-kernel/CAMn1gO6n7NrM8A+vkMt=ixvbSzUJbrr2s6Ko3WENPoT-84J15w@mail.gmail.com/

Eric
