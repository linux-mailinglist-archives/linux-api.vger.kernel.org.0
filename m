Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612992BBA1F
	for <lists+linux-api@lfdr.de>; Sat, 21 Nov 2020 00:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKTXX0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 18:23:26 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:47774 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgKTXXZ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 18:23:25 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFkN-002S57-V0; Fri, 20 Nov 2020 16:23:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgFkM-00EHNf-Q5; Fri, 20 Nov 2020 16:23:19 -0700
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
References: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
Date:   Fri, 20 Nov 2020 17:22:58 -0600
In-Reply-To: <13cf24d00ebdd8e1f55caf1821c7c29d54100191.1605904350.git.pcc@google.com>
        (Peter Collingbourne's message of "Fri, 20 Nov 2020 12:33:45 -0800")
Message-ID: <87h7pj1ulp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kgFkM-00EHNf-Q5;;;mid=<87h7pj1ulp.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/0KlmzXqNFrKXdMr3d8vvafdt449SoUBc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 589 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 10 (1.6%), parse: 1.13
        (0.2%), extract_message_metadata: 17 (2.9%), get_uri_detail_list: 3.1
        (0.5%), tests_pri_-1000: 16 (2.6%), tests_pri_-950: 1.34 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 134 (22.8%), check_bayes:
        131 (22.2%), b_tokenize: 15 (2.6%), b_tok_get_all: 11 (1.9%),
        b_comp_prob: 3.4 (0.6%), b_tok_touch_all: 96 (16.3%), b_finish: 1.03
        (0.2%), tests_pri_0: 395 (67.0%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 10 (1.6%), poll_dns_idle: 0.31 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v21 1/2] signal: define the SA_EXPOSE_TAGBITS bit in sa_flags
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> Architectures that support address tagging, such as arm64, may want to
> expose fault address tag bits to the signal handler to help diagnose
> memory errors. However, these bits have not been previously set,
> and their presence may confuse unaware user applications. Therefore,
> introduce a SA_EXPOSE_TAGBITS flag bit in sa_flags that a signal
> handler may use to explicitly request that the bits are set.
>
> The generic signal handler APIs expect to receive tagged addresses.
> Architectures may specify how to untag addresses in the case where
> SA_EXPOSE_TAGBITS is clear by defining the arch_untagged_si_addr
> function.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Link: https://linux-review.googlesource.com/id/I16dd0ed2081f091fce97be0190cb8caa874c26cb
> ---
> To be applied on top of:
> https://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git signal-for-v5.11

I have merged this first patch into signal-for-v5.11 and pushed
everything out to linux-next.

Eric


>  include/linux/signal.h                 | 14 ++++++++++++++
>  include/linux/signal_types.h           |  2 +-
>  include/uapi/asm-generic/signal-defs.h |  3 +++
>  kernel/signal.c                        | 24 ++++++++++++++++++++++++
>  4 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/signal.h b/include/linux/signal.h
> index b256f9c65661..205526c4003a 100644
> --- a/include/linux/signal.h
> +++ b/include/linux/signal.h
> @@ -469,4 +469,18 @@ struct seq_file;
>  extern void render_sigset_t(struct seq_file *, const char *, sigset_t *);
>  #endif
>  
> +#ifndef arch_untagged_si_addr
> +/*
> + * Given a fault address and a signal and si_code which correspond to the
> + * _sigfault union member, returns the address that must appear in si_addr if
> + * the signal handler does not have SA_EXPOSE_TAGBITS enabled in sa_flags.
> + */
> +static inline void __user *arch_untagged_si_addr(void __user *addr,
> +						 unsigned long sig,
> +						 unsigned long si_code)
> +{
> +	return addr;
> +}
> +#endif
> +
>  #endif /* _LINUX_SIGNAL_H */
> diff --git a/include/linux/signal_types.h b/include/linux/signal_types.h
> index a7887ad84d36..68e06c75c5b2 100644
> --- a/include/linux/signal_types.h
> +++ b/include/linux/signal_types.h
> @@ -78,6 +78,6 @@ struct ksignal {
>  
>  #define UAPI_SA_FLAGS                                                          \
>  	(SA_NOCLDSTOP | SA_NOCLDWAIT | SA_SIGINFO | SA_ONSTACK | SA_RESTART |  \
> -	 SA_NODEFER | SA_RESETHAND | __ARCH_UAPI_SA_FLAGS)
> +	 SA_NODEFER | SA_RESETHAND | SA_EXPOSE_TAGBITS | __ARCH_UAPI_SA_FLAGS)
>  
>  #endif /* _LINUX_SIGNAL_TYPES_H */
> diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
> index c790f67304ba..fe929e7b77ca 100644
> --- a/include/uapi/asm-generic/signal-defs.h
> +++ b/include/uapi/asm-generic/signal-defs.h
> @@ -20,6 +20,8 @@
>   * so this bit allows flag bit support to be detected from userspace while
>   * allowing an old kernel to be distinguished from a kernel that supports every
>   * flag bit.
> + * SA_EXPOSE_TAGBITS exposes an architecture-defined set of tag bits in
> + * siginfo.si_addr.
>   *
>   * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
>   * Unix names RESETHAND and NODEFER respectively.
> @@ -41,6 +43,7 @@
>  /* 0x00000100 used on sparc */
>  /* 0x00000200 used on sparc */
>  #define SA_UNSUPPORTED	0x00000400
> +#define SA_EXPOSE_TAGBITS	0x00000800
>  /* 0x00010000 used on mips */
>  /* 0x01000000 used on x86 */
>  /* 0x02000000 used on x86 */
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f34819e80de..26018c59821d 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2524,6 +2524,26 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
>  	return signr;
>  }
>  
> +static void hide_si_addr_tag_bits(struct ksignal *ksig)
> +{
> +	switch (siginfo_layout(ksig->sig, ksig->info.si_code)) {
> +	case SIL_FAULT:
> +	case SIL_FAULT_MCEERR:
> +	case SIL_FAULT_BNDERR:
> +	case SIL_FAULT_PKUERR:
> +		ksig->info.si_addr = arch_untagged_si_addr(
> +			ksig->info.si_addr, ksig->sig, ksig->info.si_code);
> +		break;
> +	case SIL_KILL:
> +	case SIL_TIMER:
> +	case SIL_POLL:
> +	case SIL_CHLD:
> +	case SIL_RT:
> +	case SIL_SYS:
> +		break;
> +	}
> +}
> +
>  bool get_signal(struct ksignal *ksig)
>  {
>  	struct sighand_struct *sighand = current->sighand;
> @@ -2761,6 +2781,10 @@ bool get_signal(struct ksignal *ksig)
>  	spin_unlock_irq(&sighand->siglock);
>  
>  	ksig->sig = signr;
> +
> +	if (!(ksig->ka.sa.sa_flags & SA_EXPOSE_TAGBITS))
> +		hide_si_addr_tag_bits(ksig);
> +
>  	return ksig->sig > 0;
>  }
