Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623CC2B7F05
	for <lists+linux-api@lfdr.de>; Wed, 18 Nov 2020 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKROFA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Nov 2020 09:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgKROFA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Nov 2020 09:05:00 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000FDC0613D4;
        Wed, 18 Nov 2020 06:04:59 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so3121034wml.5;
        Wed, 18 Nov 2020 06:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qyt3KmXW+Zg/2rU5IYdqdLQ5eBxh43hmngwUzyBBa58=;
        b=JFrprZzOR9SLrBaIVib2ojrSFw6Hpd4NHzRQU+Ygz2qZhfNRQEk0STJ2JS2A9UP05G
         RnitYDCq809sq8I2XfCu2mSeWkdwEL7+pptOUjQu5M2YVF5Sketd777WdNagU5RSTAmT
         mQs5O/3arkzygeZtDS+/QKdktoffIuyVPg3nfLrbJsln27d9LO6h+IbV64ylUjiuDVN3
         Nbdk4eqfB4psQ0x3kj1w2da6868eIKIrrcTafgAKkP3/8nneBhqUvrlnbMzY8Ust0dzZ
         SYEmBiuNI4+Ny/ahv/YZww30+6ScxZiB9JBLxDZ1nEgCsQPouJdc3Mbn/o2qJy4SXx4/
         35Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qyt3KmXW+Zg/2rU5IYdqdLQ5eBxh43hmngwUzyBBa58=;
        b=swAPHYIF3VwW8G/qVrGxsNtELTNSl6/IhL4yAQrM5vblUhwHmLkc1YTn0ALg2MCsrR
         aZu7KMhWclTDr/0ho5+GT0ve1kOov+VO6mjlz3LGg112YakPjNGBh8m5P7OQ44PV4zKV
         wFjOc6MITm3ousSpdtsUg/btGlArp01UjFmZcMZY4MGvD2Uwtwvd1gOxhOz1rjT4dxiJ
         0Ns1gmlbad+yTuLVrX8lgF/9Tps6RxlL90J151GWs1B9w9a7Is4Zagib5c9H067NSfaw
         jkNrPmrNKuxyO3yGPJwYA/0ynDb2NGDvGYkVxOr+Fm7RizouY0XJ/TQp+Jr5p0F3LSsw
         zNqQ==
X-Gm-Message-State: AOAM531HlN1mEDuSgBizLGtFUWBzQjVfV0vi+fyldLtbr+YI8AEZ04Ey
        mRPzDbF665yQBbkPX9Ef+9VKnPpD642Asg==
X-Google-Smtp-Source: ABdhPJy5zEiyFd9aTwIeaiBNbDKAIHmkrjBk8TFTppP2HBYVH7ubRIr19GToeyLjtiu0VdI8mSPj3w==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr194771wmc.172.1605708298288;
        Wed, 18 Nov 2020 06:04:58 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id t11sm3940122wmf.35.2020.11.18.06.04.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 06:04:57 -0800 (PST)
Subject: Re: [PATCH v2] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
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
 <b052f55a-682e-705a-285c-f9b1892c0e07@gmail.com>
Message-ID: <5b99f5af-de0e-508a-f6e8-133fb290ae03@gmail.com>
Date:   Wed, 18 Nov 2020 15:04:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <b052f55a-682e-705a-285c-f9b1892c0e07@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 11/18/20 12:42 PM, Alejandro Colomar (man-pages) wrote:
> [[ Removed some CCs because gmail
>    didn't allow me to send it with so many CCs:
>    Kevin B., Andrey K., Helge D., David S.
> ]]
> 
> On 11/18/20 12:54 AM, Peter Collingbourne wrote:
>> Signed-off-by: Peter Collingbourne <pcc@google.com>
>> ---
>> These features are implemented in this patch series:
>>
> https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
>> which is still under review, so the patch should not be applied
>> yet.
>>
>> Alejandro, thanks for the review. Since the patch was almost
>> rewritten I didn't base this on your patch, instead I tried to
>> use the correct formatting in this patch.
> 
> Hi Peter,
> 
> Fine.
> See below a small fix.

D'oh!
Fixing the CCs I forgot to add the fix to the code.
See below now.

> 
> Cheers,
> 
> Alex
> 
>>
>> v2:
>> - fix formatting
>> - address feedback from Dave
>>
>>  man2/sigaction.2 | 125 +++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 125 insertions(+)
>>
>> diff --git a/man2/sigaction.2 b/man2/sigaction.2
>> index 6a8142324..0e4236a43 100644
>> --- a/man2/sigaction.2
>> +++ b/man2/sigaction.2
>> @@ -250,6 +250,44 @@ This flag is meaningful only when establishing a
> signal handler.
>>  .\" .I sa_sigaction
>>  .\" field was added in Linux 2.1.86.)
>>  .\"
>> +.TP
>> +.BR SA_UNSUPPORTED
>> +Used to dynamically probe for flag bit support.
>> +.IP
>> +If an attempt to register a handler succeeds with this flag set in
>> +.I act->sa_flags
>> +alongside other flags that are potentially unsupported by the kernel,
>> +and an immediately subsequent
>> +.BR sigaction ()
>> +call specifying the same signal number n and with non-NULL
>> +.I oldact
>> +yields
>> +.B SA_UNSUPPORTED
>> +.I clear
>> +in
>> +.IR oldact->sa_flags ,
>> +then
>> +.IR oldact->sa_flags

s/.IR/.I/

There's no roman part there.

>> +may be used as a bitmask
>> +describing which of the potentially unsupported flags are,
>> +in fact, supported.
>> +See the section "Dynamically probing for flag bit support"
>> +below for more details.
>> +.TP
>> +.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"
>> +Normally, when delivering a signal,
>> +an architecture-specific set of tag bits are cleared from the
>> +.I si_addr
>> +field of
>> +.IR siginfo_t .
>> +If this flag is set,
>> +an architecture-specific subset of the tag bits will be preserved in
>> +.IR si_addr .
>> +.IP
>> +Programs that need to be compatible with Linux versions older than 5.x
>> +must use
>> +.B SA_UNSUPPORTED
>> +to probe for support.
>>  .SS The siginfo_t argument to a SA_SIGINFO handler
>>  When the
>>  .B SA_SIGINFO
>> @@ -833,6 +871,93 @@ Triggered by a
>>  .BR seccomp (2)
>>  filter rule.
>>  .RE
>> +.SS Dynamically probing for flag bit support
>> +The
>> +.BR sigaction ()
>> +call on Linux accepts unknown bits set in
>> +.I act->sa_flags
>> +without error.
>> +The behavior of the kernel starting with Linux 5.x is that a second
>> +.BR sigaction ()
>> +will clear unknown bits from
>> +.IR oldact->sa_flags .
>> +However, historically, a second
>> +.BR sigaction ()
>> +call would typically leave those bits set in
>> +.IR oldact->sa_flags .
>> +.PP
>> +This means that support for new flags cannot be detected
>> +simply by testing for a flag in
>> +.IR sa_flags ,
>> +and a program must test that
>> +.B SA_UNSUPPORTED
>> +has been cleared before relying on the contents of
>> +.IR sa_flags .
>> +.PP
>> +Since the behavior of the signal handler cannot be guaranteed
>> +unless the check passes,
>> +it is wise to either block the affected signal
>> +while registering the handler and performing the check in this case,
>> +or where this is not possible,
>> +for example if the signal is synchronous, to issue the second
>> +.BR sigaction ()
>> +in the signal handler itself.
>> +.PP
>> +In kernels that do not support a specific flag,
>> +the kernel's behavior is as if the flag was not set,
>> +even if the flag was set in
>> +.IR act->sa_flags .
>> +.PP
>> +The flags
>> +.BR SA_NOCLDSTOP ,
>> +.BR SA_NOCLDWAIT ,
>> +.BR SA_SIGINFO ,
>> +.BR SA_ONSTACK ,
>> +.BR SA_RESTART ,
>> +.BR SA_NODEFER ,
>> +.BR SA_RESETHAND ,
>> +and, if defined by the architecture,
>> +.B SA_RESTORER
>> +may not be reliably probed for using this mechanism,
>> +because they were introduced before Linux 5.x.
>> +However, in general, programs may assume that these flags are supported,
>> +since they have all been supported since Linux 2.6,
>> +which was released in the year 2003.
>> +.PP
>> +The following example program exits with status 0 if
>> +.B SA_EXPOSE_TAGBITS
>> +is determined to be supported, and 1 otherwise.
>> +.PP
>> +.EX
>> +#include <signal.h>
>> +#include <stdio.h>
>> +#include <unistd.h>
>> +
>> +void handler(int signo, siginfo_t *info, void *context) {
>> +  struct sigaction oldact;
>> +  if (sigaction(SIGSEGV, 0, &oldact) == 0 &&
>> +      !(oldact.sa_flags & SA_UNSUPPORTED) &&
>> +      (oldact.sa_flags & SA_EXPOSE_TAGBITS)) {
>> +    _exit(0);
>> +  } else {
>> +    _exit(1);
>> +  }
>> +}
>> +
>> +int main(void) {
>> +  struct sigaction act = {};
>> +  act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
>> +  act.sa_sigaction = handler;
>> +  if (sigaction(SIGSEGV, &act, 0) != 0) {
>> +    perror("sigaction");
>> +    return 1;
>> +  }
>> +
>> +  /* Force a SIGSEGV. */
>> +  *(volatile int *)0 = 0;
>> +  return 1;
>> +}
>> +.EE
>>  .SH RETURN VALUE
>>  .BR sigaction ()
>>  returns 0 on success; on error, \-1 is returned, and
>>
