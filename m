Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5332B7CF7
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 12:45:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgKRLme (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 06:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKRLmd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 06:42:33 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EB2C0613D4;
        Wed, 18 Nov 2020 03:42:33 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a3so2412308wmb.5;
        Wed, 18 Nov 2020 03:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cNxYJ2h2CVZlNjlM0f3oEwG1YXfqRrBKar7rsqZqciA=;
        b=GQK5dpFr8QYgH5EQECkqAeWdv0jyeJNiaBXvUIe1LMFhV2/EhN9dNOuEiDH5xgeudf
         cUDAINh0+3YecaZ+cJk4o1OdOBgWoZ+5U/1d38BBIq4kwErmt2MDsu46JJCWCRITzkOJ
         u/wp4CWCFN79B5B5JfwoeRvzSAyCkTNhe5hQZrItR0QzIpimD5jCTTn3QgExQHeGA3Fe
         Fi4dS/ShUwWna0yqY8qh8CdfqBgvtUQctJJnC0RmP8MN4oi3qwCYJinjhxFS5Tv4P7RU
         g6kLOxCPYOG9WTOs+VUFRyOhhcu4gg4W4kbyTN3x+KjHlitMItr7mPtq7pNJPB6drs47
         HUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cNxYJ2h2CVZlNjlM0f3oEwG1YXfqRrBKar7rsqZqciA=;
        b=hIEiNIopBmiRKT7fy7q/RBZsxX9yvI9SPHo8ZNb71cK7TDHvBwy6RwGa5bjml5cDo8
         mV8OInIqfgUQQKbaUEe4dlPNY7o9iXfZs5Q//IneQjGf6ULjThYsPWhrpfHpZB8ZclCq
         nDGEDe3A/mGOOMLkuLeAlCfzniXMsf4HP+mrvodjqdYgCTFhz7Zk4QU8wMNc1AsC73tN
         UcZA3JR9v9V5sJoNjJVX3BkobXEYRWfj4JdwtY0ML1cTSRN68DAj+GVBPQBfaQyhm3i0
         jFDVd629pT7/LrhkGfhy20qc4IDh/qNyihylsiUNTZJAmuOkyjKkd55cSHa70tbxuqLU
         sR7w==
X-Gm-Message-State: AOAM5305QOjOYG5U6p1s+DG7SwC4HH4DJw8npjFMPb3Ev463BWZEPsGQ
        GeRcI6bhELFiG5yRVCOCXBcvcPFaBybIUw==
X-Google-Smtp-Source: ABdhPJwe5tYy1Cb1vjttkemcXVNvw1FwmZD+AYuSWJtpOK5O69mbTySGADCbxeQaHLbeS3W2QpeWtQ==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr3956371wml.50.1605699751781;
        Wed, 18 Nov 2020 03:42:31 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id v2sm32027937wrm.96.2020.11.18.03.42.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 03:42:31 -0800 (PST)
Subject: Re: [PATCH v2] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org
References: <20201117235447.816252-1-pcc@google.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <b052f55a-682e-705a-285c-f9b1892c0e07@gmail.com>
Date:   Wed, 18 Nov 2020 12:42:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201117235447.816252-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[[ Removed some CCs because gmail
   didn't allow me to send it with so many CCs:
   Kevin B., Andrey K., Helge D., David S.
]]

On 11/18/20 12:54 AM, Peter Collingbourne wrote:
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
> These features are implemented in this patch series:
>
https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
> which is still under review, so the patch should not be applied
> yet.
>
> Alejandro, thanks for the review. Since the patch was almost
> rewritten I didn't base this on your patch, instead I tried to
> use the correct formatting in this patch.

Hi Peter,

Fine.
See below a small fix.

Cheers,

Alex

>
> v2:
> - fix formatting
> - address feedback from Dave
>
>  man2/sigaction.2 | 125 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
>
> diff --git a/man2/sigaction.2 b/man2/sigaction.2
> index 6a8142324..0e4236a43 100644
> --- a/man2/sigaction.2
> +++ b/man2/sigaction.2
> @@ -250,6 +250,44 @@ This flag is meaningful only when establishing a
signal handler.
>  .\" .I sa_sigaction
>  .\" field was added in Linux 2.1.86.)
>  .\"
> +.TP
> +.BR SA_UNSUPPORTED
> +Used to dynamically probe for flag bit support.
> +.IP
> +If an attempt to register a handler succeeds with this flag set in
> +.I act->sa_flags
> +alongside other flags that are potentially unsupported by the kernel,
> +and an immediately subsequent
> +.BR sigaction ()
> +call specifying the same signal number n and with non-NULL
> +.I oldact
> +yields
> +.B SA_UNSUPPORTED
> +.I clear
> +in
> +.IR oldact->sa_flags ,
> +then
> +.IR oldact->sa_flags
> +may be used as a bitmask
> +describing which of the potentially unsupported flags are,
> +in fact, supported.
> +See the section "Dynamically probing for flag bit support"
> +below for more details.
> +.TP
> +.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"
> +Normally, when delivering a signal,
> +an architecture-specific set of tag bits are cleared from the
> +.I si_addr
> +field of
> +.IR siginfo_t .
> +If this flag is set,
> +an architecture-specific subset of the tag bits will be preserved in
> +.IR si_addr .
> +.IP
> +Programs that need to be compatible with Linux versions older than 5.x
> +must use
> +.B SA_UNSUPPORTED
> +to probe for support.
>  .SS The siginfo_t argument to a SA_SIGINFO handler
>  When the
>  .B SA_SIGINFO
> @@ -833,6 +871,93 @@ Triggered by a
>  .BR seccomp (2)
>  filter rule.
>  .RE
> +.SS Dynamically probing for flag bit support
> +The
> +.BR sigaction ()
> +call on Linux accepts unknown bits set in
> +.I act->sa_flags
> +without error.
> +The behavior of the kernel starting with Linux 5.x is that a second
> +.BR sigaction ()
> +will clear unknown bits from
> +.IR oldact->sa_flags .
> +However, historically, a second
> +.BR sigaction ()
> +call would typically leave those bits set in
> +.IR oldact->sa_flags .
> +.PP
> +This means that support for new flags cannot be detected
> +simply by testing for a flag in
> +.IR sa_flags ,
> +and a program must test that
> +.B SA_UNSUPPORTED
> +has been cleared before relying on the contents of
> +.IR sa_flags .
> +.PP
> +Since the behavior of the signal handler cannot be guaranteed
> +unless the check passes,
> +it is wise to either block the affected signal
> +while registering the handler and performing the check in this case,
> +or where this is not possible,
> +for example if the signal is synchronous, to issue the second
> +.BR sigaction ()
> +in the signal handler itself.
> +.PP
> +In kernels that do not support a specific flag,
> +the kernel's behavior is as if the flag was not set,
> +even if the flag was set in
> +.IR act->sa_flags .
> +.PP
> +The flags
> +.BR SA_NOCLDSTOP ,
> +.BR SA_NOCLDWAIT ,
> +.BR SA_SIGINFO ,
> +.BR SA_ONSTACK ,
> +.BR SA_RESTART ,
> +.BR SA_NODEFER ,
> +.BR SA_RESETHAND ,
> +and, if defined by the architecture,
> +.B SA_RESTORER
> +may not be reliably probed for using this mechanism,
> +because they were introduced before Linux 5.x.
> +However, in general, programs may assume that these flags are supported,
> +since they have all been supported since Linux 2.6,
> +which was released in the year 2003.
> +.PP
> +The following example program exits with status 0 if
> +.B SA_EXPOSE_TAGBITS
> +is determined to be supported, and 1 otherwise.
> +.PP
> +.EX
> +#include <signal.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +
> +void handler(int signo, siginfo_t *info, void *context) {
> +  struct sigaction oldact;
> +  if (sigaction(SIGSEGV, 0, &oldact) == 0 &&
> +      !(oldact.sa_flags & SA_UNSUPPORTED) &&
> +      (oldact.sa_flags & SA_EXPOSE_TAGBITS)) {
> +    _exit(0);
> +  } else {
> +    _exit(1);
> +  }
> +}
> +
> +int main(void) {
> +  struct sigaction act = {};
> +  act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
> +  act.sa_sigaction = handler;
> +  if (sigaction(SIGSEGV, &act, 0) != 0) {
> +    perror("sigaction");
> +    return 1;
> +  }
> +
> +  /* Force a SIGSEGV. */
> +  *(volatile int *)0 = 0;
> +  return 1;
> +}
> +.EE
>  .SH RETURN VALUE
>  .BR sigaction ()
>  returns 0 on success; on error, \-1 is returned, and
>
