Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F352A6D20
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 19:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKDSsB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 13:48:01 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:40546 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgKDSsB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 13:48:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kaNot-006Wiq-TI; Wed, 04 Nov 2020 11:47:43 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kaNos-00EZCN-Pp; Wed, 04 Nov 2020 11:47:43 -0700
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
        David Spickett <david.spickett@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <cover.1604376407.git.pcc@google.com>
        <a309f8baa7c342536c17832cf604fad00aac486c.1604376407.git.pcc@google.com>
Date:   Wed, 04 Nov 2020 12:47:39 -0600
In-Reply-To: <a309f8baa7c342536c17832cf604fad00aac486c.1604376407.git.pcc@google.com>
        (Peter Collingbourne's message of "Mon, 2 Nov 2020 20:09:39 -0800")
Message-ID: <87h7q55584.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kaNos-00EZCN-Pp;;;mid=<87h7q55584.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1811kUSvbjFrFbUGdgjE0HQ3122cGMp5Gk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 533 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.5 (0.8%), b_tie_ro: 3.1 (0.6%), parse: 1.13
        (0.2%), extract_message_metadata: 19 (3.5%), get_uri_detail_list: 3.0
        (0.6%), tests_pri_-1000: 14 (2.6%), tests_pri_-950: 0.99 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 66 (12.3%), check_bayes:
        65 (12.1%), b_tokenize: 8 (1.5%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.3 (0.4%), b_tok_touch_all: 42 (7.9%), b_finish: 0.69
        (0.1%), tests_pri_0: 329 (61.8%), check_dkim_signature: 0.39 (0.1%),
        check_dkim_adsp: 2.7 (0.5%), poll_dns_idle: 79 (14.9%), tests_pri_10:
        1.81 (0.3%), tests_pri_500: 93 (17.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v13 3/8] arch: move SA_* definitions to generic headers
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> Most architectures with the exception of alpha, mips, parisc and
> sparc use the same values for these flags. Move their definitions into
> asm-generic/signal-defs.h and allow the architectures with non-standard
> values to override them. Also, document the non-standard flag values
> in order to make it easier to add new generic flags in the future.
>
> A consequence of this change is that on powerpc and x86, the constants'
> values aside from SA_RESETHAND change signedness from unsigned
> to signed. This is not expected to impact realistic use of these
> constants. In particular the typical use of the constants where they
> are or'ed together and assigned to sa_flags (or another int variable)
> would not be affected.

Except for the removal of SA_RESTORER on arm (see below).
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Link: https://linux-review.googlesource.com/id/Ia3849f18b8009bf41faca374e701cdca36974528
> ---
> v11:
> - tweak the commit message to point out the change from unsigned
>   to signed
>
> v10:
> - move the comments around and add one for SA_SIGINFO
>

> diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
> index 9b4185ba4f8a..7727f0984d26 100644
> --- a/arch/arm/include/uapi/asm/signal.h
> +++ b/arch/arm/include/uapi/asm/signal.h
> @@ -60,33 +60,11 @@ typedef unsigned long sigset_t;
>  #define SIGSWI		32
>  
>  /*
> - * SA_FLAGS values:
> - *
> - * SA_NOCLDSTOP		flag to turn off SIGCHLD when children stop.
> - * SA_NOCLDWAIT		flag on SIGCHLD to inhibit zombies.
> - * SA_SIGINFO		deliver the signal with SIGINFO structs
> - * SA_THIRTYTWO		delivers the signal in 32-bit mode, even if the task 
> - *			is running in 26-bit.
> - * SA_ONSTACK		allows alternate signal stacks (see sigaltstack(2)).
> - * SA_RESTART		flag to get restarting signals (which were the default long ago)
> - * SA_NODEFER		prevents the current signal from being masked in the handler.
> - * SA_RESETHAND		clears the handler when the signal is delivered.
> - *
> - * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
> - * Unix names RESETHAND and NODEFER respectively.
> + * SA_THIRTYTWO historically meant deliver the signal in 32-bit mode, even if
> + * the task is running in 26-bit. But since the kernel no longer supports
> + * 26-bit mode, the flag has no effect.
>   */
> -#define SA_NOCLDSTOP	0x00000001
> -#define SA_NOCLDWAIT	0x00000002
> -#define SA_SIGINFO	0x00000004
>  #define SA_THIRTYTWO	0x02000000

> -#define SA_RESTORER	0x04000000
   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Was removing SA_RESTOER from arm a typo?
If not it is probably better to move the removal into a separate patch.


> -#define SA_ONSTACK	0x08000000
> -#define SA_RESTART	0x10000000
> -#define SA_NODEFER	0x40000000
> -#define SA_RESETHAND	0x80000000
> -
> -#define SA_NOMASK	SA_NODEFER
> -#define SA_ONESHOT	SA_RESETHAND
>  
>  #define MINSIGSTKSZ	2048
>  #define SIGSTKSZ	8192
