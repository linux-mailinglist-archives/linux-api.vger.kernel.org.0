Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0872DFF85
	for <lists+linux-api@lfdr.de>; Mon, 21 Dec 2020 19:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgLUSSR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 21 Dec 2020 13:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgLUSSR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 21 Dec 2020 13:18:17 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAD5C0613D6
        for <linux-api@vger.kernel.org>; Mon, 21 Dec 2020 10:17:36 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id m23so9705201ioy.2
        for <linux-api@vger.kernel.org>; Mon, 21 Dec 2020 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAA166E2+VdaZ0WOq2VqiVkG91PPnv5CvgKOO1YeExI=;
        b=G71NvLoRHnr+T+0Tj44sS0+PwbS/KGQYPgr7WLLYCjMbkUP7DXDdr1+DCuDH74UhfR
         0uhT1/xA6VzypVE0uzhLBnOA+GIjZDqHQNadUCPWR/IKNP2Si59mDS0jEWeyI9YKqZ7U
         TBGB7OIKwoJnff/rOQ5uFmYMApeVzt2BCA7szm6aSVnobSBvTH98mR3eNmQfX5219cVs
         fhkEs0k3J1vcnM1CToSL2/XpzHmyM+TER0Nc4ukCMwF5Oo1MqRuduvhr+m4xEGp8L7bW
         0hIRsH/veLcpyJq4FhazZX3xowbxBQP5xruSLqYGe8jih81PkUo5ovBuOfJb4UF8vXAt
         Cb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAA166E2+VdaZ0WOq2VqiVkG91PPnv5CvgKOO1YeExI=;
        b=YOb3j5nxIhSNo+o+sKEWHou4LmxjWbr3zqGQwicyKXeR4gdRU87C4YDR+MV7IOgTtH
         m9qzjuwBzlxje+QPiV7CNe80j8lP7xhImOSY1kjZjErVbq8SBv33efDsBgZ5OM1d4Fzr
         aMN0Za5V1/d6OhwB5IkTGzDIUQQxQKyGGcnihf8CAaFVFCf3QvuSLuDl1tJoSiCFu8Qk
         zVYsIgV/AWSg7RhM/HzqYLFeIPX48EfUCgx+OM54A8yXe1o8tw/PSFuQHlrmd6Da85g0
         EVodiCU/apsGyt5chRIL+9VzB3cxyEVj60MQ9j4JvABImXhkFBtLSemPinLSTZZX/ZOC
         /+fQ==
X-Gm-Message-State: AOAM5311c71yzOtzRPfT1oJOKOvfzEsv21G3Q0UFUeTEizuoOBQIhFtd
        4N/LPcDqB5NQ34KwXQO1jCfidr96ck9IaAo9N3zgSg==
X-Google-Smtp-Source: ABdhPJxgeHpqb9nV5DlPOA5od76OvoA920oVhBqD9Bew9ND4bnaQLYS6MtLQK24XLRfZJF6VaORPoUrLm/IauDX+o8I=
X-Received: by 2002:a02:6d2b:: with SMTP id m43mr15890188jac.20.1608574655646;
 Mon, 21 Dec 2020 10:17:35 -0800 (PST)
MIME-Version: 1.0
References: <20201117235447.816252-1-pcc@google.com> <b052f55a-682e-705a-285c-f9b1892c0e07@gmail.com>
 <5b99f5af-de0e-508a-f6e8-133fb290ae03@gmail.com> <edb79422-0876-71e7-5d61-ef50d781a69c@gmail.com>
In-Reply-To: <edb79422-0876-71e7-5d61-ef50d781a69c@gmail.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Mon, 21 Dec 2020 10:17:26 -0800
Message-ID: <CAMn1gO6_=zxTB1dHC8QJLuR7RbRcvXgBH2DyONvbxORgpTkngA@mail.gmail.com>
Subject: Re: [PATCH v2] sigaction.2: Document SA_EXPOSE_TAGBITS and the flag
 support detection protocol
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Kostya Serebryany <kcc@google.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Evgenii Stepanov <eugenis@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Alex,

The feature is due to be merged in 5.11 so presumably we should wait
until then. I have no updates for the patch; at this point I am hoping
for comments (or a Reviewed-by) from Dave.

I saw your s/.IR/.I/ and I will do that once I have another update for
the patch.

Peter

On Fri, Dec 18, 2020 at 2:27 AM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hi Peter,
>
> Linux 5.10 has been recently released.
> Was this merged to 5.10 or 5.11?
> Do you have any updates for this patch?
>
> Thanks,
>
> Alex
>
> On 11/18/20 3:04 PM, Alejandro Colomar (man-pages) wrote:
> >
> >
> > On 11/18/20 12:42 PM, Alejandro Colomar (man-pages) wrote:
> >> [[ Removed some CCs because gmail
> >>    didn't allow me to send it with so many CCs:
> >>    Kevin B., Andrey K., Helge D., David S.
> >> ]]
> >>
> >> On 11/18/20 12:54 AM, Peter Collingbourne wrote:
> >>> Signed-off-by: Peter Collingbourne <pcc@google.com>
> >>> ---
> >>> These features are implemented in this patch series:
> >>>
> >> https://lore.kernel.org/linux-arm-kernel/cover.1605235762.git.pcc@google.com/
> >>> which is still under review, so the patch should not be applied
> >>> yet.
> >>>
> >>> Alejandro, thanks for the review. Since the patch was almost
> >>> rewritten I didn't base this on your patch, instead I tried to
> >>> use the correct formatting in this patch.
> >>
> >> Hi Peter,
> >>
> >> Fine.
> >> See below a small fix.
> >
> > D'oh!
> > Fixing the CCs I forgot to add the fix to the code.
> > See below now.
> >
> >>
> >> Cheers,
> >>
> >> Alex
> >>
> >>>
> >>> v2:
> >>> - fix formatting
> >>> - address feedback from Dave
> >>>
> >>>  man2/sigaction.2 | 125 +++++++++++++++++++++++++++++++++++++++++++++++
> >>>  1 file changed, 125 insertions(+)
> >>>
> >>> diff --git a/man2/sigaction.2 b/man2/sigaction.2
> >>> index 6a8142324..0e4236a43 100644
> >>> --- a/man2/sigaction.2
> >>> +++ b/man2/sigaction.2
> >>> @@ -250,6 +250,44 @@ This flag is meaningful only when establishing a
> >> signal handler.
> >>>  .\" .I sa_sigaction
> >>>  .\" field was added in Linux 2.1.86.)
> >>>  .\"
> >>> +.TP
> >>> +.BR SA_UNSUPPORTED
> >>> +Used to dynamically probe for flag bit support.
> >>> +.IP
> >>> +If an attempt to register a handler succeeds with this flag set in
> >>> +.I act->sa_flags
> >>> +alongside other flags that are potentially unsupported by the kernel,
> >>> +and an immediately subsequent
> >>> +.BR sigaction ()
> >>> +call specifying the same signal number n and with non-NULL
> >>> +.I oldact
> >>> +yields
> >>> +.B SA_UNSUPPORTED
> >>> +.I clear
> >>> +in
> >>> +.IR oldact->sa_flags ,
> >>> +then
> >>> +.IR oldact->sa_flags
> >
> > s/.IR/.I/
> >
> > There's no roman part there.
> >
> >>> +may be used as a bitmask
> >>> +describing which of the potentially unsupported flags are,
> >>> +in fact, supported.
> >>> +See the section "Dynamically probing for flag bit support"
> >>> +below for more details.
> >>> +.TP
> >>> +.BR SA_EXPOSE_TAGBITS " (since Linux 5.x)"
> >>> +Normally, when delivering a signal,
> >>> +an architecture-specific set of tag bits are cleared from the
> >>> +.I si_addr
> >>> +field of
> >>> +.IR siginfo_t .
> >>> +If this flag is set,
> >>> +an architecture-specific subset of the tag bits will be preserved in
> >>> +.IR si_addr .
> >>> +.IP
> >>> +Programs that need to be compatible with Linux versions older than 5.x
> >>> +must use
> >>> +.B SA_UNSUPPORTED
> >>> +to probe for support.
> >>>  .SS The siginfo_t argument to a SA_SIGINFO handler
> >>>  When the
> >>>  .B SA_SIGINFO
> >>> @@ -833,6 +871,93 @@ Triggered by a
> >>>  .BR seccomp (2)
> >>>  filter rule.
> >>>  .RE
> >>> +.SS Dynamically probing for flag bit support
> >>> +The
> >>> +.BR sigaction ()
> >>> +call on Linux accepts unknown bits set in
> >>> +.I act->sa_flags
> >>> +without error.
> >>> +The behavior of the kernel starting with Linux 5.x is that a second
> >>> +.BR sigaction ()
> >>> +will clear unknown bits from
> >>> +.IR oldact->sa_flags .
> >>> +However, historically, a second
> >>> +.BR sigaction ()
> >>> +call would typically leave those bits set in
> >>> +.IR oldact->sa_flags .
> >>> +.PP
> >>> +This means that support for new flags cannot be detected
> >>> +simply by testing for a flag in
> >>> +.IR sa_flags ,
> >>> +and a program must test that
> >>> +.B SA_UNSUPPORTED
> >>> +has been cleared before relying on the contents of
> >>> +.IR sa_flags .
> >>> +.PP
> >>> +Since the behavior of the signal handler cannot be guaranteed
> >>> +unless the check passes,
> >>> +it is wise to either block the affected signal
> >>> +while registering the handler and performing the check in this case,
> >>> +or where this is not possible,
> >>> +for example if the signal is synchronous, to issue the second
> >>> +.BR sigaction ()
> >>> +in the signal handler itself.
> >>> +.PP
> >>> +In kernels that do not support a specific flag,
> >>> +the kernel's behavior is as if the flag was not set,
> >>> +even if the flag was set in
> >>> +.IR act->sa_flags .
> >>> +.PP
> >>> +The flags
> >>> +.BR SA_NOCLDSTOP ,
> >>> +.BR SA_NOCLDWAIT ,
> >>> +.BR SA_SIGINFO ,
> >>> +.BR SA_ONSTACK ,
> >>> +.BR SA_RESTART ,
> >>> +.BR SA_NODEFER ,
> >>> +.BR SA_RESETHAND ,
> >>> +and, if defined by the architecture,
> >>> +.B SA_RESTORER
> >>> +may not be reliably probed for using this mechanism,
> >>> +because they were introduced before Linux 5.x.
> >>> +However, in general, programs may assume that these flags are supported,
> >>> +since they have all been supported since Linux 2.6,
> >>> +which was released in the year 2003.
> >>> +.PP
> >>> +The following example program exits with status 0 if
> >>> +.B SA_EXPOSE_TAGBITS
> >>> +is determined to be supported, and 1 otherwise.
> >>> +.PP
> >>> +.EX
> >>> +#include <signal.h>
> >>> +#include <stdio.h>
> >>> +#include <unistd.h>
> >>> +
> >>> +void handler(int signo, siginfo_t *info, void *context) {
> >>> +  struct sigaction oldact;
> >>> +  if (sigaction(SIGSEGV, 0, &oldact) == 0 &&
> >>> +      !(oldact.sa_flags & SA_UNSUPPORTED) &&
> >>> +      (oldact.sa_flags & SA_EXPOSE_TAGBITS)) {
> >>> +    _exit(0);
> >>> +  } else {
> >>> +    _exit(1);
> >>> +  }
> >>> +}
> >>> +
> >>> +int main(void) {
> >>> +  struct sigaction act = {};
> >>> +  act.sa_flags = SA_SIGINFO | SA_UNSUPPORTED | SA_EXPOSE_TAGBITS;
> >>> +  act.sa_sigaction = handler;
> >>> +  if (sigaction(SIGSEGV, &act, 0) != 0) {
> >>> +    perror("sigaction");
> >>> +    return 1;
> >>> +  }
> >>> +
> >>> +  /* Force a SIGSEGV. */
> >>> +  *(volatile int *)0 = 0;
> >>> +  return 1;
> >>> +}
> >>> +.EE
> >>>  .SH RETURN VALUE
> >>>  .BR sigaction ()
> >>>  returns 0 on success; on error, \-1 is returned, and
> >>>
>
> --
> Alejandro Colomar
> Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
> http://www.alejandro-colomar.es/
