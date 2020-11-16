Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D467E2B5556
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 00:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgKPXtA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 16 Nov 2020 18:49:00 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:44096 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgKPXtA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 16 Nov 2020 18:49:00 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1keoEs-00C4dY-N0; Mon, 16 Nov 2020 16:48:50 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1keoEg-002h8J-B6; Mon, 16 Nov 2020 16:48:50 -0700
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
        <3581410892be6851d804bbbb84fccf06073f1262.1605235762.git.pcc@google.com>
        <878sb4nixz.fsf@x220.int.ebiederm.org>
        <CAMn1gO52j4fSEn5S2GdrtyCq+iiaMK16DkKiyj=Go91Jy+xR-w@mail.gmail.com>
Date:   Mon, 16 Nov 2020 17:48:21 -0600
In-Reply-To: <CAMn1gO52j4fSEn5S2GdrtyCq+iiaMK16DkKiyj=Go91Jy+xR-w@mail.gmail.com>
        (Peter Collingbourne's message of "Sat, 14 Nov 2020 14:12:41 -0800")
Message-ID: <87wnykg8xm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1keoEg-002h8J-B6;;;mid=<87wnykg8xm.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xm/VQ0i8x06zvcrtDi6ZNWVyMQu46CXs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4979]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 573 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.6%), b_tie_ro: 8 (1.4%), parse: 1.02 (0.2%),
        extract_message_metadata: 19 (3.4%), get_uri_detail_list: 2.8 (0.5%),
        tests_pri_-1000: 17 (2.9%), tests_pri_-950: 1.45 (0.3%),
        tests_pri_-900: 1.24 (0.2%), tests_pri_-90: 117 (20.3%), check_bayes:
        113 (19.8%), b_tokenize: 11 (1.9%), b_tok_get_all: 10 (1.7%),
        b_comp_prob: 3.0 (0.5%), b_tok_touch_all: 85 (14.9%), b_finish: 0.97
        (0.2%), tests_pri_0: 394 (68.7%), check_dkim_signature: 0.70 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.27 (0.0%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v16 5/6] signal: define the SA_UNSUPPORTED bit in sa_flags
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> On Sat, Nov 14, 2020 at 5:53 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Peter Collingbourne <pcc@google.com> writes:
>>
>> > Define a sa_flags bit, SA_UNSUPPORTED, which will never be supported
>> > in the uapi. The purpose of this flag bit is to allow userspace to
>> > distinguish an old kernel that does not clear unknown sa_flags bits
>> > from a kernel that supports every flag bit.
>> >
>> > In other words, if userspace does something like:
>> >
>> >   act.sa_flags |= SA_UNSUPPORTED;
>> >   sigaction(SIGSEGV, &act, 0);
>> >   sigaction(SIGSEGV, 0, &oldact);
>> >
>> > and finds that SA_UNSUPPORTED remains set in oldact.sa_flags, it means
>> > that the kernel cannot be trusted to have cleared unknown flag bits
>> > from sa_flags, so no assumptions about flag bit support can be made.
>> >
>> > Signed-off-by: Peter Collingbourne <pcc@google.com>
>> > Reviewed-by: Dave Martin <Dave.Martin@arm.com>
>> > Link: https://linux-review.googlesource.com/id/Ic2501ad150a3a79c1cf27fb8c99be342e9dffbcb
>> > ---
>> > v11:
>> > - clarify the commit message
>> >
>> >  include/uapi/asm-generic/signal-defs.h | 7 +++++++
>> >  kernel/signal.c                        | 6 ++++++
>> >  2 files changed, 13 insertions(+)
>> >
>> > diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
>> > index 493953fe319b..0126ebda4d31 100644
>> > --- a/include/uapi/asm-generic/signal-defs.h
>> > +++ b/include/uapi/asm-generic/signal-defs.h
>> > @@ -14,6 +14,12 @@
>> >   * SA_RESTART flag to get restarting signals (which were the default long ago)
>> >   * SA_NODEFER prevents the current signal from being masked in the handler.
>> >   * SA_RESETHAND clears the handler when the signal is delivered.
>> > + * SA_UNSUPPORTED is a flag bit that will never be supported. Kernels from
>> > + * before the introduction of SA_UNSUPPORTED did not clear unknown bits from
>> > + * sa_flags when read using the oldact argument to sigaction and rt_sigaction,
>> > + * so this bit allows flag bit support to be detected from userspace while
>> > + * allowing an old kernel to be distinguished from a kernel that supports every
>> > + * flag bit.
>> >   *
>> >   * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
>> >   * Unix names RESETHAND and NODEFER respectively.
>> > @@ -42,6 +48,7 @@
>> >  #ifndef SA_RESETHAND
>> >  #define SA_RESETHAND 0x80000000
>> >  #endif
>> > +#define SA_UNSUPPORTED       0x00000400
>>
>> Why this value and why not in numerical order with the other flags?
>>
>> At the very least not being in order with the other bits makes it
>> a little easier to overlook it and define something at that position.
>
> The value is because this is the first bit that isn't already taken by
> an architecture-specific flag bit. It seems okay to move it into
> numerical order.
>
> The taken flag bits are listed in the comment that I added in patch 3.
> Do you think there would be a more prominent way to document them?
> Maybe we can replace that comment with inline, in-order comments along
> the lines of:
>
> #ifndef SA_NOCLDSTOP
> #define SA_NOCLDSTOP   0x00000001
> #endif
> #ifndef SA_NOCLDWAIT
> #define SA_NOCLDWAIT   0x00000002
> #endif
> #ifndef SA_SIGINFO
> #define SA_SIGINFO     0x00000004
> #endif
> /* 0x00000008 has arch-specific definition */
> /* 0x00000010 has arch-specific definition */
>
> etc.
>
> And then this patch would add the new bit in the right place.

Yes.  That seems like it would be easier to think about.

If you could also add the architectures that use those bits that would
be helpful.  Then if someone wants to look and see what is going on they
need to look, and as a bunus in the if in event those architectures are
deleted we would know that the bit no longer need to be reserved.

Eric

p.s. Apologies for some reason I did not see this reply earlier.
