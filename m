Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894843C9233
	for <lists+linux-api@lfdr.de>; Wed, 14 Jul 2021 22:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhGNUj6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 16:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGNUj6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jul 2021 16:39:58 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451C4C061760;
        Wed, 14 Jul 2021 13:37:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m11-20020a05600c3b0bb0290228f19cb433so4697917wms.0;
        Wed, 14 Jul 2021 13:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xPnLqVSYQ1uaB/yCls0QSqt5u2fz2yirntcHS/Cl+bU=;
        b=LizqDyKU9mSnk4N4xorkw1xNc8lRItlnBuSWiBDuHH44sIL+5Q0A9yjdWCUmflcr9A
         5N5yj9RE0buOwoxBkK1PaoMIPSS/gtreGDyTvaX2TdL9mBlCAW4M4wtsJh0diNqoNC5v
         P1j+m9MGJyTrfbL4GbUu7p5DL4l3fMKMYGlSOE2OKHsRONMbJWY/vbAJVhuNknZcETpm
         21RNRLK4J2yScgTtx3UlndQOLbR4UmecG/skHINafYkAiYLB/LtCYicLDmHuTyqlQbD6
         0bbHBEKAI7/OL7BFkRd+xRAxtcImlU653Qr9SSxfkYuBgEvZ6ZrhD8S8k+uSkfVrYZt8
         qwew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xPnLqVSYQ1uaB/yCls0QSqt5u2fz2yirntcHS/Cl+bU=;
        b=YHAsWc0/6bcYMPpXZsjWt1v8rvdubok9Ck4FUAj8O5KS/RyfF1JVVnP8ifR9Ek7W/K
         09hVoSLSlkPzW69HbIYwTsqZaeeKIsHZFfMivK2V4GzGPIbBvImYTr2Siq3n9ShRWDue
         vmUNJLOBxEN5MbPFVUolZvdSlBWetrmujbbk+WoSDjrdfXpPeaUi2cEcgVomt/Y/HXif
         YJ4stcaKuAHx0fjXidvWChS1rt9kK5HkoRrVO8iRXHgtQZnikB1RPAN0LMkgg1RTfksB
         BK6HDQi97NMVNxob2HjawtKIdlKy25ELp/3L1fb+J52fXc3tmM3QRTMPsJBv52+dyQL1
         4aUA==
X-Gm-Message-State: AOAM533uGypAN/fXdLixM4Co2KRQ7lopaEn4xQ48jbTwJKu9wRiGUzT3
        93YLYtEMwi7ow01YvtKN4Yc4kwjPCEQ=
X-Google-Smtp-Source: ABdhPJypnGGTNbeoNLZaaMxJJLMVr/4rkPJ3Mh9LuAmL6rpspoKLO185M5Ulg/6jtMcdEowglLbCNQ==
X-Received: by 2002:a7b:cc15:: with SMTP id f21mr6083429wmh.5.1626295023836;
        Wed, 14 Jul 2021 13:37:03 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id n18sm3736231wrt.89.2021.07.14.13.37.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jul 2021 13:37:03 -0700 (PDT)
Subject: Re: [PATCH v3] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
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
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-api@vger.kernel.org, Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>,
        linux-man@vger.kernel.org
References: <20210713013857.3237634-1-pcc@google.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <cc88a16b-262c-75c3-b7ab-d24a116198a7@gmail.com>
Date:   Wed, 14 Jul 2021 22:37:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713013857.3237634-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

On 7/13/21 3:38 AM, Peter Collingbourne wrote:
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
> This feature landed back in 5.11, but the manpage
> update seems to have fallen through the cracks.

Sorry, I don't remember what happened :/
Thanks for the ping.

> Here's a v3 with the introducing version specified
> and with one formatting nit fixed.

Please See some comments below (especially in the example code).

BTW, could you please link to the thread in the kernel mailing list that
added this feature?

Thanks,

Alex

> 
> v3:
> - s/5.x/5.11/g
> - s/.IR/.I/ in one location
> 
> v2:
> - fix formatting
> - address feedback from Dave
> 
>  man2/sigaction.2 | 125 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/man2/sigaction.2 b/man2/sigaction.2
> index 57ad6418c..6b90982d4 100644
> --- a/man2/sigaction.2
> +++ b/man2/sigaction.2
> @@ -261,6 +261,44 @@ This flag is meaningful only when establishing a signal handler.
>  .\" .I sa_sigaction
>  .\" field was added in Linux 2.1.86.)
>  .\"
> +.TP
> +.BR SA_UNSUPPORTED

s/.BR/.B/

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
> +.I oldact->sa_flags
> +may be used as a bitmask
> +describing which of the potentially unsupported flags are,
> +in fact, supported.
> +See the section "Dynamically probing for flag bit support"
> +below for more details.
> +.TP
> +.BR SA_EXPOSE_TAGBITS " (since Linux 5.11)"
> +Normally, when delivering a signal,
> +an architecture-specific set of tag bits are cleared from the
> +.I si_addr
> +field of
> +.IR siginfo_t .
> +If this flag is set,
> +an architecture-specific subset of the tag bits will be preserved in
> +.IR si_addr .
> +.IP
> +Programs that need to be compatible with Linux versions older than 5.11
> +must use
> +.B SA_UNSUPPORTED
> +to probe for support.
>  .SS The siginfo_t argument to a SA_SIGINFO handler
>  When the
>  .B SA_SIGINFO
> @@ -846,6 +884,93 @@ Triggered by a
>  .BR seccomp (2)
>  filter rule.
>  .RE
> +.SS Dynamically probing for flag bit support
> +The
> +.BR sigaction ()
> +call on Linux accepts unknown bits set in
> +.I act->sa_flags
> +without error.
> +The behavior of the kernel starting with Linux 5.11 is that a second
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
> +because they were introduced before Linux 5.11.
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

Use 4-space indents.

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

The {} initializer is a GCC extension.  Please use the C99-conforming
{0} zero initializer.  See
<https://stackoverflow.com/questions/11152160/initializing-a-struct-to-0>.

> +  act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
> +  act.sa_sigaction = handler;
> +  if (sigaction(SIGSEGV, &act, 0) != 0) {
> +    perror("sigaction");
> +    return 1;
> +  }
> +
> +  /* Force a SIGSEGV. */
> +  *(volatile int *)0 = 0;

Isn't this equivalent to the following (which wouldn't need a comment)?:

raise(SIGSEGV);

> +  return 1;
> +}
> +.EE
>  .SH RETURN VALUE
>  .BR sigaction ()
>  returns 0 on success; on error, \-1 is returned, and
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
