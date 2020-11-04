Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43082A6C60
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 19:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgKDSFn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 13:05:43 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50996 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbgKDSFm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Nov 2020 13:05:42 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kaNA8-006Rnf-0m; Wed, 04 Nov 2020 11:05:36 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kaNA7-0003so-4W; Wed, 04 Nov 2020 11:05:35 -0700
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
        David Spickett <david.spickett@linaro.org>
References: <cover.1604376407.git.pcc@google.com>
        <e67e653cd06c573e932e7d72223dd7d48fcd21d3.1604376407.git.pcc@google.com>
Date:   Wed, 04 Nov 2020 12:05:31 -0600
In-Reply-To: <e67e653cd06c573e932e7d72223dd7d48fcd21d3.1604376407.git.pcc@google.com>
        (Peter Collingbourne's message of "Mon, 2 Nov 2020 20:09:38 -0800")
Message-ID: <87r1p9576c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kaNA7-0003so-4W;;;mid=<87r1p9576c.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1++bJSHWtQNH7zBfGB2JU+iGKcjfoK+Ahk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Peter Collingbourne <pcc@google.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 399 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 9 (2.3%), b_tie_ro: 7 (1.8%), parse: 1.24 (0.3%),
        extract_message_metadata: 19 (4.9%), get_uri_detail_list: 1.85 (0.5%),
        tests_pri_-1000: 15 (3.9%), tests_pri_-950: 1.37 (0.3%),
        tests_pri_-900: 1.03 (0.3%), tests_pri_-90: 81 (20.3%), check_bayes:
        79 (19.9%), b_tokenize: 9 (2.2%), b_tok_get_all: 8 (2.0%),
        b_comp_prob: 2.8 (0.7%), b_tok_touch_all: 55 (13.8%), b_finish: 1.23
        (0.3%), tests_pri_0: 246 (61.6%), check_dkim_signature: 0.76 (0.2%),
        check_dkim_adsp: 1.96 (0.5%), poll_dns_idle: 0.41 (0.1%),
        tests_pri_10: 2.3 (0.6%), tests_pri_500: 19 (4.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v13 2/8] parisc: start using signal-defs.h
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Peter Collingbourne <pcc@google.com> writes:

> We currently include signal-defs.h on all architectures except parisc.
> Make parisc fall in line. This will make maintenance easier once the
> flag bits are moved here.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> Acked-by: Helge Deller <deller@gmx.de>
> Link: https://linux-review.googlesource.com/id/If03a5135fb514fe96548fb74610e6c3586a04064

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>  arch/parisc/include/uapi/asm/signal.h | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
> index d9c51769851a..9e6f87bc8a73 100644
> --- a/arch/parisc/include/uapi/asm/signal.h
> +++ b/arch/parisc/include/uapi/asm/signal.h
> @@ -68,14 +68,7 @@
>  #define MINSIGSTKSZ	2048
>  #define SIGSTKSZ	8192
>  
> -
> -#define SIG_BLOCK          0	/* for blocking signals */
> -#define SIG_UNBLOCK        1	/* for unblocking signals */
> -#define SIG_SETMASK        2	/* for setting the signal mask */
> -
> -#define SIG_DFL	((__sighandler_t)0)	/* default signal handling */
> -#define SIG_IGN	((__sighandler_t)1)	/* ignore signal */
> -#define SIG_ERR	((__sighandler_t)-1)	/* error return from signal */
> +#include <asm-generic/signal-defs.h>
>  
>  # ifndef __ASSEMBLY__
>  
> @@ -84,10 +77,6 @@
>  /* Avoid too many header ordering problems.  */
>  struct siginfo;
>  
> -/* Type of a signal handler.  */
> -typedef void __signalfn_t(int);
> -typedef __signalfn_t __user *__sighandler_t;
> -
>  typedef struct sigaltstack {
>  	void __user *ss_sp;
>  	int ss_flags;
