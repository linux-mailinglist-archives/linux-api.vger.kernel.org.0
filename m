Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA1240975
	for <lists+linux-api@lfdr.de>; Tue, 11 Jun 2019 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404880AbfFKUgY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 11 Jun 2019 16:36:24 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43875 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391943AbfFKUgY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 11 Jun 2019 16:36:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hanVC-0004lG-Tk; Tue, 11 Jun 2019 14:36:18 -0600
Received: from ip72-206-97-68.om.om.cox.net ([72.206.97.68] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hanVA-0006GI-BF; Tue, 11 Jun 2019 14:36:18 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Arseny Maslennikov <ar@cs.msu.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>,
        <linux-api@vger.kernel.org>
References: <20190605081906.28938-1-ar@cs.msu.ru>
        <20190605081906.28938-2-ar@cs.msu.ru>
Date:   Tue, 11 Jun 2019 15:36:00 -0500
In-Reply-To: <20190605081906.28938-2-ar@cs.msu.ru> (Arseny Maslennikov's
        message of "Wed, 5 Jun 2019 11:19:00 +0300")
Message-ID: <87o933507j.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hanVA-0006GI-BF;;;mid=<87o933507j.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=72.206.97.68;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3P7RQue3RXfD0vg4lwaqD053joFTXlMY=
X-SA-Exim-Connect-IP: 72.206.97.68
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMNoVowels,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4543]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Arseny Maslennikov <ar@cs.msu.ru>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2146 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 7 (0.3%), b_tie_ro: 4.4 (0.2%), parse: 1.15
        (0.1%), extract_message_metadata: 15 (0.7%), get_uri_detail_list: 4.4
        (0.2%), tests_pri_-1000: 13 (0.6%), tests_pri_-950: 1.39 (0.1%),
        tests_pri_-900: 1.12 (0.1%), tests_pri_-90: 45 (2.1%), check_bayes: 42
        (2.0%), b_tokenize: 18 (0.8%), b_tok_get_all: 10 (0.5%), b_comp_prob:
        4.8 (0.2%), b_tok_touch_all: 4.7 (0.2%), b_finish: 0.80 (0.0%),
        tests_pri_0: 736 (34.3%), check_dkim_signature: 0.89 (0.0%),
        check_dkim_adsp: 2.8 (0.1%), poll_dns_idle: 1300 (60.6%),
        tests_pri_10: 2.5 (0.1%), tests_pri_500: 1321 (61.6%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 1/7] signal.h: Define SIGINFO on all architectures
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Arseny Maslennikov <ar@cs.msu.ru> writes:

> This complementary patch defines SIGINFO as a synonym for SIGPWR
> on every architecture supported by the kernel.
> The particular signal number chosen does not really matter and is only
> required for the related tty functionality to work properly,
> so if it does not suite expectations, any suggestions are warmly
> welcome.
>
> SIGPWR looks like a nice candidate for this role, because it is
> defined on every supported arch; it is currently only used to inform
> PID 1 of power failures, and daemons that care about low-level
> events do not tend to have a controlling terminal.
>
> However, on sparcs SIGPWR is a synonym for SIGLOST, a signal unique
> to that architecture, with a narrow set of intended uses that do not
> combine well with interactively requesting status.
> SIGLOST is not used by any kernel code at the moment.
> I'm not sure there is a more reasonable alternative right now.

Is the name SIGINFO already well established.

It just is a little bit confusing with struct siginfo.

At least on x86 it looks like we have signals 32 and 33 that are
reserved and not used for anything.  Is there a reason you have
not picked one of those?

Also should this be a realtime signal with signal information
or a non-realtime signal?

I don't expect there is much to encode except that the user is asking
for information.  I half wonder if it could be done as a different
si_code to SIGWINCH.  But of course that doesn't work because it is
not a real time signal so does not queue more than one siginfo. (Sigh).

I just would like to see that we have a clear concept of how this new
signal plays into all of the signal handling bits.

Added linux-api because this is fundamentally extending the linux-api,
and we probably want man-page updates etc.

Eric

>
> Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
> ---
>  arch/arm/include/uapi/asm/signal.h     | 1 +
>  arch/h8300/include/uapi/asm/signal.h   | 1 +
>  arch/ia64/include/uapi/asm/signal.h    | 1 +
>  arch/m68k/include/uapi/asm/signal.h    | 1 +
>  arch/mips/include/uapi/asm/signal.h    | 1 +
>  arch/parisc/include/uapi/asm/signal.h  | 1 +
>  arch/powerpc/include/uapi/asm/signal.h | 1 +
>  arch/s390/include/uapi/asm/signal.h    | 1 +
>  arch/sparc/include/uapi/asm/signal.h   | 2 ++
>  arch/x86/include/uapi/asm/signal.h     | 1 +
>  arch/xtensa/include/uapi/asm/signal.h  | 1 +
>  include/uapi/asm-generic/signal.h      | 1 +
>  12 files changed, 13 insertions(+)
>
> diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
> index 9b4185ba4f8a..b80b53a17267 100644
> --- a/arch/arm/include/uapi/asm/signal.h
> +++ b/arch/arm/include/uapi/asm/signal.h
> @@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
>  #define SIGLOST		29
>  */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  #define	SIGUNUSED	31
>  
> diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
> index e15521037348..7a2b783af22b 100644
> --- a/arch/h8300/include/uapi/asm/signal.h
> +++ b/arch/h8300/include/uapi/asm/signal.h
> @@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
>  #define SIGLOST		29
>  */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  #define	SIGUNUSED	31
>  
> diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
> index aa98ff1b9e22..b4c98cb17165 100644
> --- a/arch/ia64/include/uapi/asm/signal.h
> +++ b/arch/ia64/include/uapi/asm/signal.h
> @@ -45,6 +45,7 @@
>  #define SIGLOST		29
>  */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  /* signal 31 is no longer "unused", but the SIGUNUSED macro remains for backwards compatibility */
>  #define	SIGUNUSED	31
> diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
> index 915cc755a184..a0b4e4108cb8 100644
> --- a/arch/m68k/include/uapi/asm/signal.h
> +++ b/arch/m68k/include/uapi/asm/signal.h
> @@ -50,6 +50,7 @@ typedef unsigned long sigset_t;
>  #define SIGLOST		29
>  */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  #define	SIGUNUSED	31
>  
> diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
> index 53104b10aae2..975a6f0d3b0b 100644
> --- a/arch/mips/include/uapi/asm/signal.h
> +++ b/arch/mips/include/uapi/asm/signal.h
> @@ -43,6 +43,7 @@ typedef unsigned long old_sigset_t;		/* at least 32 bits */
>  #define SIGCHLD		18	/* Child status has changed (POSIX).  */
>  #define SIGCLD		SIGCHLD /* Same as SIGCHLD (System V).	*/
>  #define SIGPWR		19	/* Power failure restart (System V).  */
> +#define SIGINFO		SIGPWR	/* Keyboard status request (4.2 BSD). */
>  #define SIGWINCH	20	/* Window size change (4.3 BSD, Sun).  */
>  #define SIGURG		21	/* Urgent condition on socket (4.2 BSD).  */
>  #define SIGIO		22	/* I/O now possible (4.2 BSD).	*/
> diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
> index d38563a394f2..fe2e00d590ac 100644
> --- a/arch/parisc/include/uapi/asm/signal.h
> +++ b/arch/parisc/include/uapi/asm/signal.h
> @@ -22,6 +22,7 @@
>  #define SIGUSR2		17
>  #define SIGCHLD		18
>  #define SIGPWR		19
> +#define SIGINFO		SIGPWR
>  #define SIGVTALRM	20
>  #define SIGPROF		21
>  #define SIGIO		22
> diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
> index 85b0a7aa43e7..e7f3885905b4 100644
> --- a/arch/powerpc/include/uapi/asm/signal.h
> +++ b/arch/powerpc/include/uapi/asm/signal.h
> @@ -53,6 +53,7 @@ typedef struct {
>  #define SIGLOST		29
>  */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  #define	SIGUNUSED	31
>  
> diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
> index 9a14a611ed82..12ee62987971 100644
> --- a/arch/s390/include/uapi/asm/signal.h
> +++ b/arch/s390/include/uapi/asm/signal.h
> @@ -58,6 +58,7 @@ typedef unsigned long sigset_t;
>  #define SIGLOST         29
>  */
>  #define SIGPWR          30
> +#define SIGINFO         SIGPWR
>  #define SIGSYS		31
>  #define SIGUNUSED       31
>  
> diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
> index ff9505923b9a..b655163198bb 100644
> --- a/arch/sparc/include/uapi/asm/signal.h
> +++ b/arch/sparc/include/uapi/asm/signal.h
> @@ -71,6 +71,8 @@
>  #define SIGWINCH	28
>  #define SIGLOST		29
>  #define SIGPWR		SIGLOST
> +/* XXX: is it OK for SIGINFO to collide with LOST? */
> +#define SIGINFO		SIGPWR
>  #define SIGUSR1		30
>  #define SIGUSR2		31
>  
> diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
> index e5745d593dc7..1539bb28826c 100644
> --- a/arch/x86/include/uapi/asm/signal.h
> +++ b/arch/x86/include/uapi/asm/signal.h
> @@ -55,6 +55,7 @@ typedef unsigned long sigset_t;
>  #define SIGLOST		29
>  */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  #define	SIGUNUSED	31
>  
> diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
> index 005dec5bfde4..d644234305de 100644
> --- a/arch/xtensa/include/uapi/asm/signal.h
> +++ b/arch/xtensa/include/uapi/asm/signal.h
> @@ -65,6 +65,7 @@ typedef struct {
>  #define SIGPOLL		SIGIO
>  /* #define SIGLOST		29 */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  #define	SIGUNUSED	31
>  
> diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
> index 5c716a952cbe..9f9a1db0d43c 100644
> --- a/include/uapi/asm-generic/signal.h
> +++ b/include/uapi/asm-generic/signal.h
> @@ -43,6 +43,7 @@
>  #define SIGLOST		29
>  */
>  #define SIGPWR		30
> +#define SIGINFO		SIGPWR
>  #define SIGSYS		31
>  #define	SIGUNUSED	31
