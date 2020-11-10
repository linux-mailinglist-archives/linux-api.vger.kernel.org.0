Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB12AD9D8
	for <lists+linux-api@lfdr.de>; Tue, 10 Nov 2020 16:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbgKJPMr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Nov 2020 10:12:47 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53712 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730754AbgKJPMq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Nov 2020 10:12:46 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcVK5-003sqk-4J; Tue, 10 Nov 2020 08:12:41 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kcVK3-0001ep-W9; Tue, 10 Nov 2020 08:12:40 -0700
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
        <0ce3d90b5d6a4457b2fe3b0582f61fab70b17dfc.1604523707.git.pcc@google.com>
        <87eel2ypy3.fsf@x220.int.ebiederm.org>
        <CAMn1gO6HYcLayiO3REvpr2o3FL3CT-7CTQajOjNMcYWn5MO=fw@mail.gmail.com>
Date:   Tue, 10 Nov 2020 09:12:30 -0600
In-Reply-To: <CAMn1gO6HYcLayiO3REvpr2o3FL3CT-7CTQajOjNMcYWn5MO=fw@mail.gmail.com>
        (Peter Collingbourne's message of "Mon, 9 Nov 2020 19:49:16 -0800")
Message-ID: <87blg5tfdt.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kcVK3-0001ep-W9;;;mid=<87blg5tfdt.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/w5800oPC4xOaCZlu4BJtNPqrdKRx+P5c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4672]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 607 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 9 (1.6%), parse: 1.13 (0.2%),
         extract_message_metadata: 14 (2.3%), get_uri_detail_list: 3.6 (0.6%),
        tests_pri_-1000: 14 (2.4%), tests_pri_-950: 1.20 (0.2%),
        tests_pri_-900: 1.06 (0.2%), tests_pri_-90: 93 (15.3%), check_bayes:
        91 (15.0%), b_tokenize: 13 (2.2%), b_tok_get_all: 13 (2.2%),
        b_comp_prob: 4.2 (0.7%), b_tok_touch_all: 55 (9.1%), b_finish: 1.02
        (0.2%), tests_pri_0: 460 (75.8%), check_dkim_signature: 0.71 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 0.90 (0.1%), tests_pri_10:
        1.92 (0.3%), tests_pri_500: 6 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v14 8/8] arm64: expose FAR_EL1 tag bits in siginfo
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> On Mon, Nov 9, 2020 at 5:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
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
>> > expecting the tag bits to be cleared. Instead, create a new pair of
>> > fields in siginfo._sigfault, and store the tag bits of FAR_EL1 there,
>> > together with a mask specifying which bits are valid.
>> >
>> > A flag is added to si_faultflags to allow userspace to determine whether
>> > the values in the fields are valid.
>>
>> I think I am missing some things:
>>
>> Today it is documented that the tag bits are cleared, and so we can't
>> use the highbits to hold the tag bits by default.
>>
>> Why do you need to deliver which tag bits are valid?  That feels like an
>> implementation detail that is needed to setup the tag bits.  It feels
>> like it would be constant per process.  So I don't understand why the
>> siginfo needs to report information the process should already have.
>
> It isn't constant as it may vary depending on the specific type of
> fault being delivered. For example on arm64 the architecture only
> provides us with bits 56-59 of the tag for tag check faults, while all
> other data aborts also provide bits 60-63. Now although the user
> program may distinguish the two cases by checking the si_code, we
> would also like to allow future architecture extensions to provide
> bits 60-63 for tag check faults as well and allow distinguishing
> between "bits 60-63 were zero" and "bits 60-63 were unknown" (which is
> important when providing error reports).

Does that mean that bits 60-63 are effectively unusable as tag bits
if the tag check fault won't report them?

If you can use bits 60-63 as tag bits how does that work if they aren't
reported?

> I suppose that you could imagine that, if the "bits 60-63 available"
> extension ever comes to pass, it could be exposed via a bit in
> getauxval(AT_HWCAP2) (or maybe something like AT_HWCAP3 depending on
> how long it takes to arrive) and that would provide a way for
> userspace to know which bits are valid. But it seems like allowing
> this to vary per signal is relatively cheap, allows the information to
> be made available trivially architecture independently and keeps our
> options open for the future (because we don't know if some future
> architecture will actually make this a per-signal attribute).
>
> That being said, maybe we could solve this problem at the point at
> which we do encounter such an architecture though.

My goal would be to extend things to the minimum extent necessary to
handle today's reality well.  Usually architectures evolve in
unanticipated directions so simple and straight forward usually wins for
handling future evolution.  As there is simply less old baggage to carry
around.

However I don't understand if reporting the valid bits on a signal by
signal basis has a real advantage today or not.  If it helps today we
will find room for the field.


>> Want prevents adding a sigaction sa_flag SA_EXPOSE_TABITS that when set
>> causes the high bits to be set, and when clear (the default) will have
>> the signal delivery code clear those bits.
>>
>> That should be enough for code that wants the tag bits to ask for them.
>> As userspace would need to be updated to get the new bits
>>
>> Even if you have chained handlers.  The chaining mechanism would need to
>> be updated and it could call the aware handlers first then clear the tag
>> bits and call the rest of the handlers.
>>
>> It feels like always passing the tag bits in the address and then
>> clearing them in the copy to userspace if the signal handler is
>> not ready for them would be easier to maintain.
>
> I think that approach might work. Although it may make life harder for
> callers of ptrace(PTRACE_SETSIGINFO) since they may need to know the
> value of the bit in order to prepare a correct siginfo structure, if
> we can reasonably expect them to always be delivering an exact copy of
> a signal that was received before then maybe that is okay.

I think we can reasonably expect callers of PTRACE_SETSIGINFO to be able
to either deal the full reality of what is going on, or to only generate
signals that they fully understand.

Other than the use by CRIU it is a debugging facility and it is not
expected for ordinary usage.  The non-CRIU use case would really seem to
be what happens if I inject arbitrary signal X into process Y.  For that
you need the ability to inject an arbitrary signal.

My real sense with PTRACE_SETSIGINFO is that if we wind up with a
regression we can deal with it then.

> Assuming that this is an alternative to introducing
> si_addr_tag_bits_mask, the userspace code would need to use the flag
> bit support detection protocol for SA_EXPOSE_TAGBITS in order to be
> able to distinguish between "no bits valid" and "some bits valid", and
> then use an architecture-specific mechanism to determine exactly which
> bits are valid. Is that okay for a generic feature?

Unless I am mistaken setting the bits is already architecture specific
so having some architecture specific code in there should not be a big
problem.

But I really don't understand the arm case well enough to know if we can
get away without si_addr_tag_bits_mask, and in turn without the flags
field that indicates the si_addr_tag_bits_mask is present.

So I am asking questions so I can understand just what we get from
si_addr_tag_bits_mask.

Eric
