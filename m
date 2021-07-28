Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B785A3D9672
	for <lists+linux-api@lfdr.de>; Wed, 28 Jul 2021 22:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhG1UNf (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 28 Jul 2021 16:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhG1UNd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 28 Jul 2021 16:13:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86832C061757;
        Wed, 28 Jul 2021 13:13:30 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j2so3979588wrx.9;
        Wed, 28 Jul 2021 13:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0aFm8vJ9RhhQPVCobXlUfl/fGOpGkmciFT8CCiUV9Ds=;
        b=pNIYW9pHPGpgFxNsGG0MOF8rV9jrzsDLuCf8DSzy8dSaIrjl83h3WJcIpxMww1reVG
         xB22lX8b7gVV4Pqps3FvOK/KiHspI1sXBoLWs3aBFarSlUD5OTkJoQcejEC5XzmW22VL
         StEELVtmPlZddBnJy3AIEWOvfm7WPFAdZbqeLSwyb1lSSZgDfVcQxAunODoIthEpTw1u
         Us1K/VzMklFdFUd+RQ4ZD4jN89Ie+JZyCUGyYW0iY6cXMuMB6G7M42vQ0ilRAUnf6iPH
         P0W5mtCUofkbcMvjI4F0P57AO9NwNBZiGXMuyy6HYQ3h/+cHdgcggpytrDs+BipGZ2lH
         nTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0aFm8vJ9RhhQPVCobXlUfl/fGOpGkmciFT8CCiUV9Ds=;
        b=mUdjdCWP+FFBLrhMCczdIcqVhrfTOMbNnpmmFfMC3pJrboIVTtzQN/UFWE90ALeOXk
         ni7v/AlIQOiV1VzZhSiW9FHzO5aZA2Hf2sjm0Ckt+tZsvpLxqkH6YPvRkIcwmfwO1MUv
         XhkpLizHVJYQmY1D92Mse3+FvNGGm/C/S+GaxR46GxvMMriTmq7FMMC+evZPyZH8PzFh
         xbxYUlOkvIKrhYdgOQ/t/DnSqMirXSLLdtKRjF9aeQKs187w8Mw5O+SeqLZq1IzLJh6N
         AIsDRILN5ktv5vF/SIwOsBoaMhDL4XwW78899UwnAXu9UZ29klMri2jcz7wLCbfY1Kda
         WhCg==
X-Gm-Message-State: AOAM533p2t0n6v5zRhZArV0ZZ5GDOQshTDZiylFLu6y0FoYARnvJg+VN
        V3Lwyt3p+ez3hcvOTmT4Xt8TU650G70=
X-Google-Smtp-Source: ABdhPJxwOgubwGNFSJIa28VUtkeY3zG1bc+o3V2A07YpK/NtVHk1bCKpNANBjepAbgLBfBchpbSSZw==
X-Received: by 2002:a05:6000:1367:: with SMTP id q7mr1047285wrz.395.1627503209132;
        Wed, 28 Jul 2021 13:13:29 -0700 (PDT)
Received: from [10.8.0.150] ([195.53.121.100])
        by smtp.gmail.com with ESMTPSA id i5sm839339wrw.13.2021.07.28.13.13.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 13:13:28 -0700 (PDT)
Sender: Alejandro Colomar <alx.mailinglists@gmail.com>
Subject: Re: [PATCH v4] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
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
References: <20210715204610.575999-1-pcc@google.com>
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Message-ID: <cc2d2629-cb3d-ceee-cfa5-c317bef8204e@gmail.com>
Date:   Wed, 28 Jul 2021 22:13:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210715204610.575999-1-pcc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

On 7/15/21 10:46 PM, Peter Collingbourne wrote:
> Signed-off-by: Peter Collingbourne <pcc@google.com>

Thanks! I applied the patch.

I applied some minor tweaks in a following commit (I didn't send it back 
to you because it was a bit of my fault for not having seen it before, 
and didn't want to make you lose more time with that):

     sigaction.2: Apply minor tweaks to Peter's patch

     - Move example program to a new EXAMPLES section
     - Invert logic in the handler to have the failure in the 
conditional path,
       and the success out of any conditionals.
     - Use NULL, EXIT_SUCCESS, and EXIT_FAILURE instead of magic numbers
     - Separate declarations from code
     - Put function return type on its own line
     - Put function opening brace on its line

You can see the diff in my tree: 
<https://github.com/alejandro-colomar/man-pages>

I'll resend it to Michael very soon (I hope today), so you'll see there 
anyway.

You can comment there if you find something that you don't like , or if 
I broke anything accidentally :)

Cheers,

Alex


> ---
> v4:
> - s/.BR/.BR/ in one location
> - 4 space indentation
> - raise(SIGSEGV) instead of manual SIGSEGV
> - use C99 initialization
> 
> v3:
> - s/5.x/5.11/g
> - s/.IR/.I/ in one location
> 
> v2:
> - fix formatting
> - address feedback from Dave
> 
>   man2/sigaction.2 | 123 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 123 insertions(+)
> 
> diff --git a/man2/sigaction.2 b/man2/sigaction.2
> index 57ad6418c..4bf6f095e 100644
> --- a/man2/sigaction.2
> +++ b/man2/sigaction.2
> @@ -261,6 +261,44 @@ This flag is meaningful only when establishing a signal handler.
>   .\" .I sa_sigaction
>   .\" field was added in Linux 2.1.86.)
>   .\"
> +.TP
> +.B SA_UNSUPPORTED
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
>   .SS The siginfo_t argument to a SA_SIGINFO handler
>   When the
>   .B SA_SIGINFO
> @@ -846,6 +884,91 @@ Triggered by a
>   .BR seccomp (2)
>   filter rule.
>   .RE
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
> +    struct sigaction oldact;
> +    if (sigaction(SIGSEGV, 0, &oldact) == 0 &&
> +        !(oldact.sa_flags & SA_UNSUPPORTED) &&
> +        (oldact.sa_flags & SA_EXPOSE_TAGBITS)) {
> +        _exit(0);
> +    } else {
> +        _exit(1);
> +    }
> +}
> +
> +int main(void) {
> +    struct sigaction act = {0};
> +    act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
> +    act.sa_sigaction = handler;
> +    if (sigaction(SIGSEGV, &act, 0) != 0) {
> +        perror("sigaction");
> +        return 1;
> +    }
> +
> +    raise(SIGSEGV);
> +}
> +.EE
>   .SH RETURN VALUE
>   .BR sigaction ()
>   returns 0 on success; on error, \-1 is returned, and
> 


-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
