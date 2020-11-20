Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDAD2BB19F
	for <lists+linux-api@lfdr.de>; Fri, 20 Nov 2020 18:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgKTRoC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Nov 2020 12:44:02 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:37102 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgKTRoB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Nov 2020 12:44:01 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgARv-005s7H-HF; Fri, 20 Nov 2020 10:43:55 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kgARu-0003xP-NM; Fri, 20 Nov 2020 10:43:55 -0700
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
References: <20201119190921.3589081-1-pcc@google.com>
Date:   Fri, 20 Nov 2020 11:43:35 -0600
In-Reply-To: <20201119190921.3589081-1-pcc@google.com> (Peter Collingbourne's
        message of "Thu, 19 Nov 2020 11:09:21 -0800")
Message-ID: <87wnyf3ovs.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kgARu-0003xP-NM;;;mid=<87wnyf3ovs.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19MslMp4ZMr8Ylr6mZy5wWRoRUKED5W/2o=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4904]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 521 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (1.9%), b_tie_ro: 8 (1.6%), parse: 1.06 (0.2%),
         extract_message_metadata: 14 (2.7%), get_uri_detail_list: 2.6 (0.5%),
        tests_pri_-1000: 13 (2.6%), tests_pri_-950: 1.13 (0.2%),
        tests_pri_-900: 0.89 (0.2%), tests_pri_-90: 88 (16.9%), check_bayes:
        86 (16.5%), b_tokenize: 10 (1.9%), b_tok_get_all: 9 (1.7%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 62 (11.9%), b_finish: 0.78
        (0.1%), tests_pri_0: 344 (66.1%), check_dkim_signature: 0.66 (0.1%),
        check_dkim_adsp: 2.1 (0.4%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        4.5 (0.9%), tests_pri_500: 41 (7.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v20] arm64: expose FAR_EL1 tag bits in siginfo
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> The kernel currently clears the tag bits (i.e. bits 56-63) in the fault
> address exposed via siginfo.si_addr and sigcontext.fault_address. However,
> the tag bits may be needed by tools in order to accurately diagnose
> memory errors, such as HWASan [1] or future tools based on the Memory
> Tagging Extension (MTE).
>
> We should not stop clearing these bits in the existing fault address
> fields, because there may be existing userspace applications that are
> expecting the tag bits to be cleared. Instead, introduce a flag in
> sigaction.sa_flags, SA_EXPOSE_TAGBITS, and only expose the tag bits
> there if the signal handler has this flag set.
>
> [1] http://clang.llvm.org/docs/HardwareAssistedAddressSanitizerDesign.html

For the generic bits:
Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Some of the arm bits look wrong.  There are a couple of cases where
it looks like you are deliberately passing an untagged address into
functions that normally take tagged addresses.

It might be a good idea to have a type distinction between the two.
Perhaps "(void __user *)" vs "(unsigned long)" so that accidentally
using the wrong one generates a type error.

I don't think I am really qualified to review all of the arm details,
and I certainly don't want to be in the middle of any arm bugs this
code might introduce.  If you will split out the generic bits of this
patch I will take it.  The this whole thing can be merged into the arm
tree and you can ensure the arm bits are correct.

Eric


> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 1ee94002801f..c5375cb7763d 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -596,33 +596,35 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
>  	return 0;
>  }
>  
> -static int __kprobes do_translation_fault(unsigned long addr,
> +static int __kprobes do_translation_fault(unsigned long far,
>  					  unsigned int esr,
>  					  struct pt_regs *regs)
>  {
> +	unsigned long addr = untagged_addr(far);
> +
>  	if (is_ttbr0_addr(addr))
> -		return do_page_fault(addr, esr, regs);
> +		return do_page_fault(far, esr, regs);
>  
> -	do_bad_area(addr, esr, regs);
> +	do_bad_area(far, esr, regs);
>  	return 0;
>  }
>  
> -static int do_alignment_fault(unsigned long addr, unsigned int esr,
> +static int do_alignment_fault(unsigned long far, unsigned int esr,
>  			      struct pt_regs *regs)
>  {
> -	do_bad_area(addr, esr, regs);
> +	do_bad_area(far, esr, regs);
>  	return 0;
>  }
>  
> -static int do_bad(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +static int do_bad(unsigned long far, unsigned int esr, struct pt_regs *regs)
>  {
>  	return 1; /* "fault" */
>  }
>  
> -static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
>  {
>  	const struct fault_info *inf;
> -	void __user *siaddr;
> +	unsigned long siaddr;
>  
>  	inf = esr_to_fault_info(esr);
>  
> @@ -635,18 +637,23 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  	}
>  
>  	if (esr & ESR_ELx_FnV)
> -		siaddr = NULL;
> +		siaddr = 0;
>  	else
> -		siaddr  = (void __user *)addr;
> +		siaddr  = untagged_addr(far);
>  	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
>
What is going on in this function?

Are you deliberately removing the tag bits?
>  	return 0;
>  }
>  
> -static int do_tag_check_fault(unsigned long addr, unsigned int esr,
> +static int do_tag_check_fault(unsigned long far, unsigned int esr,
>  			      struct pt_regs *regs)
>  {
> -	do_bad_area(addr, esr, regs);
> +	/*
> +	 * The architecture specifies that bits 63:60 of FAR_EL1 are UNKNOWN for tag
> +	 * check faults. Mask them out now so that userspace doesn't see them.
> +	 */
> +	far &= (1UL << 60) - 1;
> +	do_bad_area(far, esr, regs);
>  	return 0;
>  }
>  
> @@ -717,11 +724,12 @@ static const struct fault_info fault_info[] = {
>  	{ do_bad,		SIGKILL, SI_KERNEL,	"unknown 63"			},
>  };
>  
> -void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> +void do_mem_abort(unsigned long far, unsigned int esr, struct pt_regs *regs)
>  {
>  	const struct fault_info *inf = esr_to_fault_info(esr);
> +	unsigned long addr = untagged_addr(far);
>  
> -	if (!inf->fn(addr, esr, regs))
> +	if (!inf->fn(far, esr, regs))
>  		return;
>  
>  	if (!user_mode(regs)) {
> @@ -730,8 +738,7 @@ void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  		show_pte(addr);
>  	}
>  
> -	arm64_notify_die(inf->name, regs,
> -			 inf->sig, inf->code, (void __user *)addr, esr);
> +	arm64_notify_die(inf->name, regs, inf->sig, inf->code, addr, esr);

What is going on in this function?

Are you deliberately removing the tag bits?
>  }
>  NOKPROBE_SYMBOL(do_mem_abort);
>  
