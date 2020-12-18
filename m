Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 675E22DE0FB
	for <lists+linux-api@lfdr.de>; Fri, 18 Dec 2020 11:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732586AbgLRK2T (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 18 Dec 2020 05:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgLRK2S (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 18 Dec 2020 05:28:18 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A74AC0617A7;
        Fri, 18 Dec 2020 02:27:38 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id t16so1581734wra.3;
        Fri, 18 Dec 2020 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YeOkHtjJ5a3Y5Is8ONz9fKVqPTCLKULaY+CYSDx9Kmw=;
        b=vA+865dUOnr8X7XvM4apqfr6yFLU4KWxGn8x/ZJoFDiBETRWrUAzPHLkTV3kyTeCvu
         yNDmaGZ6K1BHlSXankXt8/jvBG0Q/b9A8ES+fi4pMQ6x5xrTxHRaWJA9F4sGfvaHXWcs
         dVbwRJ6TuC5ZDLDrufT7uTkb8Zu8wMoihMZFjEcQgU99l43UCDUF8KHAMtTmyaD1aOu0
         uP57QJdbDgLnVh9XSPaRw3nffiq1X/DZwXhPzSq/Ju7v+z9lp18OA5VeVREMwKmUZRtN
         vJ0IyPE8dM1silw/RFDbV9i9ZES8i6USkJ/CYBaZdZSJ4GJysTSKgrgaKKRUjJ0tksqp
         yxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YeOkHtjJ5a3Y5Is8ONz9fKVqPTCLKULaY+CYSDx9Kmw=;
        b=hlwSrtt98l636m3L16qANYf+sdQ05vTHHWdbTsLwNzMQ9+uisZnIdFqFA3BhUwDc6f
         qgX7N7GGEPAHnsBP0bYqmW2fwGhm0F1wy8unxi6oH8YhEUx1JreBbvTJeJW1HaTVIWVT
         Vghl3W2CwHEttTSrpC7Qed4UjeX01xIRm6rGu64BJoVeyAwBVfBP60YpRqQrOizRa2Wp
         dGmhNW4lqSYAnoN+VT8TrMeyByrswXUCwRjrj7mp240lYdbzY6cs9R1+vBUgFZ47nq1P
         iWMHT8SkC1akPzy/mOsfalxNFgi/d3AIWgX1MonRSgFpWun4mknu+UjiL1nIFUFbKN6m
         gHEQ==
X-Gm-Message-State: AOAM530Ix+hzfrJD06A6YA23FvjZsS72xI+ENeWCAX3f6UQI918+L1+H
        p/kTcOPGOyQZkJjsRbj8IIQ=
X-Google-Smtp-Source: ABdhPJxLpMHT2cmJRwIp38GmwY4uYLQHIAo+x943oys7LhK5R1zdXNI+7jRYzi9LEu8RQvxrORorBg==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr3643103wrw.134.1608287257039;
        Fri, 18 Dec 2020 02:27:37 -0800 (PST)
Received: from [192.168.1.143] ([170.253.51.130])
        by smtp.gmail.com with ESMTPSA id s6sm14019602wro.79.2020.12.18.02.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Dec 2020 02:27:36 -0800 (PST)
Subject: Re: [PATCH v2] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Kostya Serebryany <kcc@google.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Dave Martin <Dave.Martin@arm.com>, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>
References: <20201117235447.816252-1-pcc@google.com>
 <b052f55a-682e-705a-285c-f9b1892c0e07@gmail.com>
 <5b99f5af-de0e-508a-f6e8-133fb290ae03@gmail.com>
Message-ID: <edb79422-0876-71e7-5d61-ef50d781a69c@gmail.com>
Date:   Fri, 18 Dec 2020 11:27:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <5b99f5af-de0e-508a-f6e8-133fb290ae03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

Linux 5.10 has been recently released.
Was this merged to 5.10 or 5.11?
Do you have any updates for this patch?

Thanks,

Alex

On 11/18/20 3:04 PM, Alejandro Colomar (man-pages) wrote:
> 
> 
> On 11/18/20 12:42 PM, Alejandro Colomar (man-pages) wrote:
>> [[ Removed some CCs because gmail
>>    didn't allow me to send it with so many CCs:
>>    Kevin B., Andrey K., Helge D., David S.
>> ]]
>>
>> On 11/18/20 12:54 AM, Peter Collingbourne wrote:
>>> Signed-off-by: Peter Collingbourne <pcc@google.com>
>>> ---
>>> These features are implemented in this patch series:
>>>
>> https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
>>> which is still under review, so the patch should not be applied
>>> yet.
>>>
>>> Alejandro, thanks for the review. Since the patch was almost
>>> rewritten I didn't base this on your patch, instead I tried to
>>> use the correct formatting in this patch.
>>
>> Hi Peter,
>>
>> Fine.
>> See below a small fix.
> 
> D'oh!
> Fixing the CCs I forgot to add the fix to the code.
> See below now.
> 
>>
>> Cheers,
>>
>> Alex
>>
>>>
>>> v2:
>>> - fix formatting
>>> - address feedback from Dave
>>>
>>>  man2/sigaction.2 | 125 +++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 125 insertions(+)
>>>
>>> diff --git a/man2/sigaction.2 b/man2/sigaction.2
>>> index 6a8142324..0e4236a43 100644
>>> --- a/man2/sigaction.2
>>> +++ b/man2/sigaction.2
>>> @@ -250,6 +250,44 @@ This flag is meaningful only when establishing a
>> signal handler.
>>>  .\" .I sa_sigaction
>>>  .\" field was added in Linux 2.1.86.)
>>>  .\"
>>> +.TP
>>> +.BR SA_UNSUPPORTED
>>> +Used to dynamically probe for flag bit support.
>>> +.IP
>>> +If an attempt to register a handler succeeds with this flag set in
>>> +.I act->sa_flags
>>> +alongside other flags that are potentially unsupported by the kernel,
>>> +and an immediately subsequent
>>> +.BR sigaction ()
>>> +call specifying the same signal number n and with non-NULL
>>> +.I oldact
>>> +yields
>>> +.B SA_UNSUPPORTED
>>> +.I clear
>>> +in
>>> +.IR oldact->sa_flags ,
>>> +then
>>> +.IR oldact->sa_flags
> 
> s/.IR/.I/
> 
> There's no roman part there.
> 
>>> +may be used as a bitmask
>>> +describing which of the potentially unsupported flags are,
>>> +in fact, supported.
>>> +See the section "Dynamically probing for flag bit support"
>>> +below for more details.
>>> +.TP
>>> +.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"
>>> +Normally, when delivering a signal,
>>> +an architecture-specific set of tag bits are cleared from the
>>> +.I si_addr
>>> +field of
>>> +.IR siginfo_t .
>>> +If this flag is set,
>>> +an architecture-specific subset of the tag bits will be preserved in
>>> +.IR si_addr .
>>> +.IP
>>> +Programs that need to be compatible with Linux versions older than 5.x
>>> +must use
>>> +.B SA_UNSUPPORTED
>>> +to probe for support.
>>>  .SS The siginfo_t argument to a SA_SIGINFO handler
>>>  When the
>>>  .B SA_SIGINFO
>>> @@ -833,6 +871,93 @@ Triggered by a
>>>  .BR seccomp (2)
>>>  filter rule.
>>>  .RE
>>> +.SS Dynamically probing for flag bit support
>>> +The
>>> +.BR sigaction ()
>>> +call on Linux accepts unknown bits set in
>>> +.I act->sa_flags
>>> +without error.
>>> +The behavior of the kernel starting with Linux 5.x is that a second
>>> +.BR sigaction ()
>>> +will clear unknown bits from
>>> +.IR oldact->sa_flags .
>>> +However, historically, a second
>>> +.BR sigaction ()
>>> +call would typically leave those bits set in
>>> +.IR oldact->sa_flags .
>>> +.PP
>>> +This means that support for new flags cannot be detected
>>> +simply by testing for a flag in
>>> +.IR sa_flags ,
>>> +and a program must test that
>>> +.B SA_UNSUPPORTED
>>> +has been cleared before relying on the contents of
>>> +.IR sa_flags .
>>> +.PP
>>> +Since the behavior of the signal handler cannot be guaranteed
>>> +unless the check passes,
>>> +it is wise to either block the affected signal
>>> +while registering the handler and performing the check in this case,
>>> +or where this is not possible,
>>> +for example if the signal is synchronous, to issue the second
>>> +.BR sigaction ()
>>> +in the signal handler itself.
>>> +.PP
>>> +In kernels that do not support a specific flag,
>>> +the kernel's behavior is as if the flag was not set,
>>> +even if the flag was set in
>>> +.IR act->sa_flags .
>>> +.PP
>>> +The flags
>>> +.BR SA_NOCLDSTOP ,
>>> +.BR SA_NOCLDWAIT ,
>>> +.BR SA_SIGINFO ,
>>> +.BR SA_ONSTACK ,
>>> +.BR SA_RESTART ,
>>> +.BR SA_NODEFER ,
>>> +.BR SA_RESETHAND ,
>>> +and, if defined by the architecture,
>>> +.B SA_RESTORER
>>> +may not be reliably probed for using this mechanism,
>>> +because they were introduced before Linux 5.x.
>>> +However, in general, programs may assume that these flags are supported,
>>> +since they have all been supported since Linux 2.6,
>>> +which was released in the year 2003.
>>> +.PP
>>> +The following example program exits with status 0 if
>>> +.B SA_EXPOSE_TAGBITS
>>> +is determined to be supported, and 1 otherwise.
>>> +.PP
>>> +.EX
>>> +#include <signal.h>
>>> +#include <stdio.h>
>>> +#include <unistd.h>
>>> +
>>> +void handler(int signo, siginfo_t *info, void *context) {
>>> +  struct sigaction oldact;
>>> +  if (sigaction(SIGSEGV, 0, &oldact) == 0 &&
>>> +      !(oldact.sa_flags & SA_UNSUPPORTED) &&
>>> +      (oldact.sa_flags & SA_EXPOSE_TAGBITS)) {
>>> +    _exit(0);
>>> +  } else {
>>> +    _exit(1);
>>> +  }
>>> +}
>>> +
>>> +int main(void) {
>>> +  struct sigaction act = {};
>>> +  act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
>>> +  act.sa_sigaction = handler;
>>> +  if (sigaction(SIGSEGV, &act, 0) != 0) {
>>> +    perror("sigaction");
>>> +    return 1;
>>> +  }
>>> +
>>> +  /* Force a SIGSEGV. */
>>> +  *(volatile int *)0 = 0;
>>> +  return 1;
>>> +}
>>> +.EE
>>>  .SH RETURN VALUE
>>>  .BR sigaction ()
>>>  returns 0 on success; on error, \-1 is returned, and
>>>

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
