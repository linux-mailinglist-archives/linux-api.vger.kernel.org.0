Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA29F2B7101
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 22:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgKQVha (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 16:37:30 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:56384 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbgKQVha (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 16:37:30 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf8fC-00G0So-N6; Tue, 17 Nov 2020 14:37:22 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf8fB-005RjH-JB; Tue, 17 Nov 2020 14:37:22 -0700
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
References: <20201117195205.645925-1-pcc@google.com>
Date:   Tue, 17 Nov 2020 15:37:04 -0600
In-Reply-To: <20201117195205.645925-1-pcc@google.com> (Peter Collingbourne's
        message of "Tue, 17 Nov 2020 11:52:05 -0800")
Message-ID: <877dqj8y2n.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kf8fB-005RjH-JB;;;mid=<877dqj8y2n.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1//OgS3vP5N5WfdqdyQHB6ATPU+1uS93zE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 440 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 8 (1.8%), b_tie_ro: 7 (1.5%), parse: 0.91 (0.2%),
        extract_message_metadata: 3.5 (0.8%), get_uri_detail_list: 1.70 (0.4%),
         tests_pri_-1000: 4.1 (0.9%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 1.02 (0.2%), tests_pri_-90: 110 (25.1%), check_bayes:
        109 (24.7%), b_tokenize: 9 (2.0%), b_tok_get_all: 7 (1.5%),
        b_comp_prob: 2.5 (0.6%), b_tok_touch_all: 87 (19.8%), b_finish: 0.95
        (0.2%), tests_pri_0: 294 (66.8%), check_dkim_signature: 0.83 (0.2%),
        check_dkim_adsp: 2.8 (0.6%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v18] arm64: expose FAR_EL1 tag bits in siginfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

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

Do we perhaps want to say the high bits of si_addr?

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
> index 8f34819e80de..576de3d9bd86 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2658,6 +2658,26 @@ bool get_signal(struct ksignal *ksig)
>  
>  		ka = &sighand->action[signr-1];
>  
> +		if (!(ka->sa.sa_flags & SA_EXPOSE_TAGBITS)) {
> +			switch (siginfo_layout(signr, ksig->info.si_code)) {
> +			case SIL_FAULT:
> +			case SIL_FAULT_MCEERR:
> +			case SIL_FAULT_BNDERR:
> +			case SIL_FAULT_PKUERR:
> +				ksig->info.si_addr = arch_untagged_si_addr(
> +					ksig->info.si_addr, signr,
> +					ksig->info.si_code);
> +				break;
> +			case SIL_KILL:
> +			case SIL_TIMER:
> +			case SIL_POLL:
> +			case SIL_CHLD:
> +			case SIL_RT:
> +			case SIL_SYS:
> +				break;
> +			}
> +		}
> +
>  		/* Trace actually delivered signals. */
>  		trace_signal_deliver(signr, &ksig->info, ka);

Overall this looks good.

It is a common path so I wonder about the generated code, and how close
to a noop this becomes on x86 and other architetures without tag bits.

Can you put this blob of code in it's own function (perhaps called
hide_si_addr_tag_bits) and call it right after "ksig->sig = signr" line?

Effectively that is the same place in the code but it gets it outside of
the sighand lock.  The tracing code does not care as it does not look at
si_addr.

I am concerned with the complexity of reading get_signal and using a
well named inline function should make it unnecessary to read that
code unless you care about what is going on.

Further having the code outside of the lock at the end of get_signal
with nothing else going on seems much easier to reason about.  The code
is get_signal is something that needs reading and reasoning about.

Eric
