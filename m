Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6BE2B2D7E
	for <lists+linux-api@lfdr.de>; Sat, 14 Nov 2020 14:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgKNNxx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 14 Nov 2020 08:53:53 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:43080 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgKNNxt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 14 Nov 2020 08:53:49 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kdvzq-00BdDW-Pe; Sat, 14 Nov 2020 06:53:42 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kdvzq-0001Zp-0u; Sat, 14 Nov 2020 06:53:42 -0700
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
References: <cover.1605235762.git.pcc@google.com>
        <3581410892be6851d804bbbb84fccf06073f1262.1605235762.git.pcc@google.com>
Date:   Sat, 14 Nov 2020 07:53:28 -0600
In-Reply-To: <3581410892be6851d804bbbb84fccf06073f1262.1605235762.git.pcc@google.com>
        (Peter Collingbourne's message of "Thu, 12 Nov 2020 18:53:35 -0800")
Message-ID: <878sb4nixz.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kdvzq-0001Zp-0u;;;mid=<878sb4nixz.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/FYdJI0tFmQTLSF0nxOUdOl1juCDlK/nA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4970]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 406 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 9 (2.3%), parse: 0.81 (0.2%),
         extract_message_metadata: 14 (3.5%), get_uri_detail_list: 1.99 (0.5%),
         tests_pri_-1000: 6 (1.5%), tests_pri_-950: 1.16 (0.3%),
        tests_pri_-900: 1.02 (0.3%), tests_pri_-90: 61 (15.1%), check_bayes:
        60 (14.7%), b_tokenize: 9 (2.3%), b_tok_get_all: 9 (2.2%),
        b_comp_prob: 2.3 (0.6%), b_tok_touch_all: 36 (8.8%), b_finish: 0.93
        (0.2%), tests_pri_0: 299 (73.5%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.6 (0.6%), poll_dns_idle: 0.42 (0.1%), tests_pri_10:
        1.97 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v16 5/6] signal: define the SA_UNSUPPORTED bit in sa_flags
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> Define a sa_flags bit, SA_UNSUPPORTED, which will never be supported
> in the uapi. The purpose of this flag bit is to allow userspace to
> distinguish an old kernel that does not clear unknown sa_flags bits
> from a kernel that supports every flag bit.
>
> In other words, if userspace does something like:
>
>   act.sa_flags |= SA_UNSUPPORTED;
>   sigaction(SIGSEGV, &act, 0);
>   sigaction(SIGSEGV, 0, &oldact);
>
> and finds that SA_UNSUPPORTED remains set in oldact.sa_flags, it means
> that the kernel cannot be trusted to have cleared unknown flag bits
> from sa_flags, so no assumptions about flag bit support can be made.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> Link: https://linux-review.googlesource.com/id/Ic2501ad150a3a79c1cf27fb8c99be342e9dffbcb
> ---
> v11:
> - clarify the commit message
>
>  include/uapi/asm-generic/signal-defs.h | 7 +++++++
>  kernel/signal.c                        | 6 ++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
> index 493953fe319b..0126ebda4d31 100644
> --- a/include/uapi/asm-generic/signal-defs.h
> +++ b/include/uapi/asm-generic/signal-defs.h
> @@ -14,6 +14,12 @@
>   * SA_RESTART flag to get restarting signals (which were the default long ago)
>   * SA_NODEFER prevents the current signal from being masked in the handler.
>   * SA_RESETHAND clears the handler when the signal is delivered.
> + * SA_UNSUPPORTED is a flag bit that will never be supported. Kernels from
> + * before the introduction of SA_UNSUPPORTED did not clear unknown bits from
> + * sa_flags when read using the oldact argument to sigaction and rt_sigaction,
> + * so this bit allows flag bit support to be detected from userspace while
> + * allowing an old kernel to be distinguished from a kernel that supports every
> + * flag bit.
>   *
>   * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
>   * Unix names RESETHAND and NODEFER respectively.
> @@ -42,6 +48,7 @@
>  #ifndef SA_RESETHAND
>  #define SA_RESETHAND	0x80000000
>  #endif
> +#define SA_UNSUPPORTED	0x00000400

Why this value and why not in numerical order with the other flags?

At the very least not being in order with the other bits makes it
a little easier to overlook it and define something at that position.

Eric


>  #define SA_NOMASK	SA_NODEFER
>  #define SA_ONESHOT	SA_RESETHAND
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f5bd12ee41b..8f34819e80de 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -3985,6 +3985,12 @@ int do_sigaction(int sig, struct k_sigaction *act, struct k_sigaction *oact)
>  	if (oact)
>  		*oact = *k;
>  
> +	/*
> +	 * Make sure that we never accidentally claim to support SA_UNSUPPORTED,
> +	 * e.g. by having an architecture use the bit in their uapi.
> +	 */
> +	BUILD_BUG_ON(UAPI_SA_FLAGS & SA_UNSUPPORTED);
> +
>  	/*
>  	 * Clear unknown flag bits in order to allow userspace to detect missing
>  	 * support for flag bits and to allow the kernel to use non-uapi bits
