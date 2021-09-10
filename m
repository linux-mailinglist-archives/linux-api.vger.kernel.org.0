Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F864070A8
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIJRuU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 13:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJRuT (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 13:50:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B8C061756
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 10:49:08 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f2so4486618ljn.1
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 10:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZvmshrhRRHf+OonCKONixU3Sueg2FEGkMUdYO67ivdc=;
        b=nRwczmrLwdY24+0iOzfvLMv7zbOplKlYUVYrxS4yakIb7jNpRbGK1CMdpIj+VSWKVi
         sSxEPhOK8ff+oVlQDZmuPWDOg2Vb091nKGzmuUS2mAIeLNcz4ZeyT7lNxrfmW1MLjv0f
         eEHEFPOJum7M8dK4CM5F6ZF77uzwwn6V2v8bClziKGbXLD+x8pgqSGjEfOAEGHFKy25A
         ut82zveh+rHnKaCywQipWTLfQwVYrPuvH+Ebr/2Rx1UOOq2cyOrKJIE/0Nny+wDtkt+t
         GThwT449G9PXEM1F2Oigy0b+g3na21ZnkC2tpbG7a9mns59v2F0eFHQ/xlLCljO/YkZr
         /Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZvmshrhRRHf+OonCKONixU3Sueg2FEGkMUdYO67ivdc=;
        b=ndCpWtidD+leDJuBsW2xI0V0bC1fV/h1YzKf+mJb0aq6E/jta3sS/60aQdJsS4fVxR
         aYOGbwfu9fgwbNeCAuU1fLZ+Li3vFMazdmRJcR/8r2bTvA/ZnI/u3fz1Cl/0frLPpOI2
         ZHcPrKC/c/n/H/PGVCW0iA+bZUrQ5kGOoM5EM7ymMh48PIma92b5nfj4VT/YsfEAEdYJ
         62FEnnd6Kh9kuurcx+4+pc/imJmrCBqRrEhPBnoisx+9PYe0xo6pkNoGChg4uXAm2NIY
         W9FNHGcZwmvxMGGdTeUJOwiymoBg/UdRo32TZ/55yEIepLeyYl1ZUGWhVUoVOJjPWgJB
         VVKQ==
X-Gm-Message-State: AOAM530QbLEbgbt6Xh0MiZ8xutXUifZRncUTKA5SnQgbm165YzoIFNUU
        CMqjl7z87mKAjjsd0wm2H2BBZfheI2TN9qfg0eDUk9qcPzSwGTA3
X-Google-Smtp-Source: ABdhPJzvcciiaT2SwMFnRgYH6WVSzzw0BqgnVEoTyxrAWzLcHjaGQDD+bcpesnpXnRlmMl35IMOt5Qk+VZSC14njvQc=
X-Received: by 2002:a2e:9150:: with SMTP id q16mr5002276ljg.418.1631296146232;
 Fri, 10 Sep 2021 10:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
 <8735qcgzdu.fsf@oldenburg.str.redhat.com> <1297400717.15316.1631295199656.JavaMail.zimbra@efficios.com>
In-Reply-To: <1297400717.15316.1631295199656.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 10 Sep 2021 10:48:54 -0700
Message-ID: <CAPNVh5d0jd=ks6WBnsheiAE394=31X963X+ZUG6x=ZZLHZ=jbQ@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 10, 2021 at 10:33 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Sep 10, 2021, at 12:37 PM, Florian Weimer fweimer@redhat.com wrote:
>
> > * Peter Oskolkov:
> >
> >> In short, due to the need to read/write to the userspace from
> >> non-sleepable contexts in the kernel it seems that we need to have some
> >> form of per task/thread kernel/userspace shared memory that is pinned,
> >> similar to what your sys_task_getshared does.
> >
> > In glibc, we'd also like to have this for PID and TID.  Eventually,
> > rt_sigprocmask without kernel roundtrip in most cases would be very nice
> > as well.  For performance and simplicity in userspace, it would be best
> > if the memory region could be at the same offset from the TCB for all
> > threads.
> >
> > For KTLS, the idea was that the auxiliary vector would contain size and
> > alignment of the KTLS.  Userspace would reserve that memory, register it
> > with the kernel like rseq (or the robust list pointers), and pass its
> > address to the vDSO functions that need them.  The last part ensures
> > that the vDSO functions do not need non-global data to determine the
> > offset from the TCB.  Registration is still needed for the caches.
> >
> > I think previous discussions (in the KTLS and rseq context) did not have
> > the pinning constraint.
>
> If this data is per-thread, and read from user-space, why is it relevant
> to update this data from non-sleepable kernel context rather than update it as
> needed on return-to-userspace ? When returning to userspace, sleeping due to a
> page fault is entirely acceptable. This is what we currently do for rseq.
>
> In short, the data could be accessible from the task struct. Flags in the
> task struct can let return-to-userspace know that it has outdated ktls
> data. So before returning to userspace, the kernel can copy the relevant data
> from the task struct to the shared memory area, without requiring any pinning.
>
> What am I missing ?

I can't speak about other use cases, but in the context of userspace
scheduling, the information that a task has blocked in the kernel and
is going to be removed from its runqueue cannot wait to be delivered
to the userspace until the task wakes up, as the userspace scheduler
needs to know of the even when it happened so that it can schedule
another task in place of the blocked one. See the discussion here:

https://lore.kernel.org/lkml/CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com/

>
> Thanks,
>
> Mathieu
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
