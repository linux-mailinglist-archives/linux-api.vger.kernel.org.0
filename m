Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041F82B6418
	for <lists+linux-api@lfdr.de>; Tue, 17 Nov 2020 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733009AbgKQNon (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 17 Nov 2020 08:44:43 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:33062 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732836AbgKQNkQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 17 Nov 2020 08:40:16 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf1DC-00CvDA-Sp; Tue, 17 Nov 2020 06:39:59 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kf1DB-0040YB-Sv; Tue, 17 Nov 2020 06:39:58 -0700
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
References: <cover.1605582887.git.pcc@google.com>
        <f296f270d97a4fbf496e1015461566407d02152f.1605582887.git.pcc@google.com>
Date:   Tue, 17 Nov 2020 07:39:40 -0600
In-Reply-To: <f296f270d97a4fbf496e1015461566407d02152f.1605582887.git.pcc@google.com>
        (Peter Collingbourne's message of "Mon, 16 Nov 2020 19:17:26 -0800")
Message-ID: <87mtzgcdb7.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kf1DB-0040YB-Sv;;;mid=<87mtzgcdb7.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19RYv/up30pxTpXmr+tpWw1dePD/OE5kk0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 381 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (2.4%), b_tie_ro: 8 (2.1%), parse: 0.82 (0.2%),
        extract_message_metadata: 3.4 (0.9%), get_uri_detail_list: 1.72 (0.5%),
         tests_pri_-1000: 3.6 (1.0%), tests_pri_-950: 0.96 (0.3%),
        tests_pri_-900: 0.84 (0.2%), tests_pri_-90: 98 (25.8%), check_bayes:
        97 (25.4%), b_tokenize: 9 (2.3%), b_tok_get_all: 9 (2.4%),
        b_comp_prob: 1.97 (0.5%), b_tok_touch_all: 74 (19.5%), b_finish: 0.79
        (0.2%), tests_pri_0: 250 (65.7%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.0 (0.5%), poll_dns_idle: 0.56 (0.1%), tests_pri_10:
        1.72 (0.5%), tests_pri_500: 6 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v17 3/3] arm64: expose FAR_EL1 tag bits in siginfo
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> diff --git a/kernel/signal.c b/kernel/signal.c
> index 8f34819e80de..16be62e6d341 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1650,6 +1650,15 @@ void force_sigsegv(int sig)
>  	force_sig(SIGSEGV);
>  }
>  
> +static void __user *get_si_addr(void __user *addr, unsigned long sig,
> +				unsigned long si_code)
> +{
> +	if (current->sighand->action[sig - 1].sa.sa_flags & SA_EXPOSE_TAGBITS)
> +		return addr;

Apologies for not seeing this before but this part of the patch is
buggy.

It is using current->sighand->action when the destination task may not
be current.  send_sig_fault and send_sig_mcerr may somewhat legitimately
be used to send faults to other processes.

Now that I think about it there are interactions with
PTRACE_GETSIGINFO/PTRACE_SETSIGINFO.

Can we move the masking into get_signal after the ptrace handling?

That way everything in the core of the kernel deals with unmasked
si_addr values and we only mask the address just before sending it to
userspace?

Eric

> +	return arch_untagged_si_addr(addr, sig, si_code);
> +}
> +
>  int force_sig_fault_to_task(int sig, int code, void __user *addr
>  	___ARCH_SI_TRAPNO(int trapno)
>  	___ARCH_SI_IA64(int imm, unsigned int flags, unsigned long isr)
> @@ -1661,7 +1670,7 @@ int force_sig_fault_to_task(int sig, int code, void __user *addr
>  	info.si_signo = sig;
>  	info.si_errno = 0;
>  	info.si_code  = code;
> -	info.si_addr  = addr;
> +	info.si_addr  = get_si_addr(addr, sig, code);
>  #ifdef __ARCH_SI_TRAPNO
>  	info.si_trapno = trapno;
>  #endif
> @@ -1693,7 +1702,7 @@ int send_sig_fault(int sig, int code, void __user *addr
>  	info.si_signo = sig;
>  	info.si_errno = 0;
>  	info.si_code  = code;
> -	info.si_addr  = addr;
> +	info.si_addr  = get_si_addr(addr, sig, code);
>  #ifdef __ARCH_SI_TRAPNO
>  	info.si_trapno = trapno;
>  #endif
> @@ -1714,7 +1723,7 @@ int force_sig_mceerr(int code, void __user *addr, short lsb)
>  	info.si_signo = SIGBUS;
>  	info.si_errno = 0;
>  	info.si_code = code;
> -	info.si_addr = addr;
> +	info.si_addr = get_si_addr(addr, SIGBUS, code);
>  	info.si_addr_lsb = lsb;
>  	return force_sig_info(&info);
>  }
> @@ -1728,7 +1737,7 @@ int send_sig_mceerr(int code, void __user *addr, short lsb, struct task_struct *
>  	info.si_signo = SIGBUS;
>  	info.si_errno = 0;
>  	info.si_code = code;
> -	info.si_addr = addr;
> +	info.si_addr = get_si_addr(addr, SIGBUS, code);
>  	info.si_addr_lsb = lsb;
>  	return send_sig_info(info.si_signo, &info, t);
>  }
> @@ -1742,7 +1751,7 @@ int force_sig_bnderr(void __user *addr, void __user *lower, void __user *upper)
>  	info.si_signo = SIGSEGV;
>  	info.si_errno = 0;
>  	info.si_code  = SEGV_BNDERR;
> -	info.si_addr  = addr;
> +	info.si_addr  = get_si_addr(addr, SIGSEGV, SEGV_BNDERR);
>  	info.si_lower = lower;
>  	info.si_upper = upper;
>  	return force_sig_info(&info);
> @@ -1757,7 +1766,7 @@ int force_sig_pkuerr(void __user *addr, u32 pkey)
>  	info.si_signo = SIGSEGV;
>  	info.si_errno = 0;
>  	info.si_code  = SEGV_PKUERR;
> -	info.si_addr  = addr;
> +	info.si_addr  = get_si_addr(addr, SIGSEGV, SEGV_PKUERR);
>  	info.si_pkey  = pkey;
>  	return force_sig_info(&info);
>  }
> @@ -1774,7 +1783,7 @@ int force_sig_ptrace_errno_trap(int errno, void __user *addr)
>  	info.si_signo = SIGTRAP;
>  	info.si_errno = errno;
>  	info.si_code  = TRAP_HWBKPT;
> -	info.si_addr  = addr;
> +	info.si_addr  = get_si_addr(addr, SIGTRAP, TRAP_HWBKPT);
>  	return force_sig_info(&info);
>  }
