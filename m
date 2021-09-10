Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7F4070BC
	for <lists+linux-api@lfdr.de>; Fri, 10 Sep 2021 20:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhIJSCV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 Sep 2021 14:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhIJSCV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 Sep 2021 14:02:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92A5C061574
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 11:01:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id f2so4535822ljn.1
        for <linux-api@vger.kernel.org>; Fri, 10 Sep 2021 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D6eGw9e5BUY6TAP4EchlrFgfo6PF8pNmzyrAzV5l6+U=;
        b=WuAsSyO1ShPcQmScIPb9jbonQleyWAwshCderojlg7vaVKUngxHwb/h5Ny+Be5yHmQ
         25PBV/STt9pJRexj3pGEC3gdKiAp6tkWm9wOvj0AlsP7cdz7R127eIeIPeT788sWGUwO
         iyeQAiFFKupCNvaVejE4zkeH5CkVb9VDK89GeVwWkcIL0cATiN4lja+WOkBUmCMo7Ab4
         cyZYgEv2BPRGB0ouJE9Og/z9wFKCaO14FEvRTCtS2MYCicn8jd+KO4cFknbJ9rgydD5f
         Za6LcFooAgE3rXeHy6V5cEo0plRNTBWvSMxInnTdffNn18lZuHPurlHU0oIIbsGCZBCl
         mt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D6eGw9e5BUY6TAP4EchlrFgfo6PF8pNmzyrAzV5l6+U=;
        b=Nz5Fl5i27jDop7WbzA3gzlCg9etGxfm1PhTtosd5hCrdhnVTAg1Yf8C0vTK/VjNdhj
         kDN77ZyaR1U73o4v6FAAA09boKBIr+QHLtGA6O9WMQfVSsAjxj9W4tSx8/zlarATWgLo
         CJ9VpOESZIloRAT+Rt3D/lVL0LOtpt+HZCFnFQTIL7UhcIyxByK9/oWC5x2gZzvDrC7e
         dvOX16d8IErB7KjNhBxpfQSv61e3xynD8P+f7eQz08zYcPWrKxzj8CTjW/g4d3+Y0JoT
         HIlDx/qbR3Ci3K9XAqu06tcIGYM5HvLaPPB+2peQ5KZVOyeF0JIHQ2g12b23y/auTCQq
         Jplw==
X-Gm-Message-State: AOAM530Sw3Bbrz9EQaR9aL5wIfQdC6laFa8vGKyetzE7GeS+g7qbfKvE
        Uc7NnTJLFJoOs0Ej6ukAMhqSdFBDiWDgQKYnqqMhjw==
X-Google-Smtp-Source: ABdhPJxzKJxKqi373C4LyVuMNfnmEuLI8pNB0HfKYRcmyQ31PToOi9kXsz4k14S/k3UOif6bMqJgqeECF2MXULG+3dY=
X-Received: by 2002:a2e:2e16:: with SMTP id u22mr5279625lju.12.1631296867505;
 Fri, 10 Sep 2021 11:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
 <CAFTs51VDUPWu=r9d=ThABc-Z6wCwTOC+jKDCq=Jk8Pfid61xyQ@mail.gmail.com>
 <CAPNVh5dsN0LPHg6TJ_MO2XKtpTEe0n4Y6+HjwERJPSrb2J0cbg@mail.gmail.com>
 <8735qcgzdu.fsf@oldenburg.str.redhat.com> <1297400717.15316.1631295199656.JavaMail.zimbra@efficios.com>
 <CAPNVh5d0jd=ks6WBnsheiAE394=31X963X+ZUG6x=ZZLHZ=jbQ@mail.gmail.com> <872090791.15342.1631296555821.JavaMail.zimbra@efficios.com>
In-Reply-To: <872090791.15342.1631296555821.JavaMail.zimbra@efficios.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 10 Sep 2021 11:00:56 -0700
Message-ID: <CAPNVh5dhoSmoxXabnDg5w1CnwVz0J_nS09xQbQ4cJu-UNa26Lg@mail.gmail.com>
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

On Fri, Sep 10, 2021 at 10:55 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Sep 10, 2021, at 1:48 PM, Peter Oskolkov posk@google.com wrote:
>
> > On Fri, Sep 10, 2021 at 10:33 AM Mathieu Desnoyers
> > <mathieu.desnoyers@efficios.com> wrote:
> >>
> >> ----- On Sep 10, 2021, at 12:37 PM, Florian Weimer fweimer@redhat.com wrote:
> >>
> >> > * Peter Oskolkov:
> >> >
> >> >> In short, due to the need to read/write to the userspace from
> >> >> non-sleepable contexts in the kernel it seems that we need to have some
> >> >> form of per task/thread kernel/userspace shared memory that is pinned,
> >> >> similar to what your sys_task_getshared does.
> >> >
> >> > In glibc, we'd also like to have this for PID and TID.  Eventually,
> >> > rt_sigprocmask without kernel roundtrip in most cases would be very nice
> >> > as well.  For performance and simplicity in userspace, it would be best
> >> > if the memory region could be at the same offset from the TCB for all
> >> > threads.
> >> >
> >> > For KTLS, the idea was that the auxiliary vector would contain size and
> >> > alignment of the KTLS.  Userspace would reserve that memory, register it
> >> > with the kernel like rseq (or the robust list pointers), and pass its
> >> > address to the vDSO functions that need them.  The last part ensures
> >> > that the vDSO functions do not need non-global data to determine the
> >> > offset from the TCB.  Registration is still needed for the caches.
> >> >
> >> > I think previous discussions (in the KTLS and rseq context) did not have
> >> > the pinning constraint.
> >>
> >> If this data is per-thread, and read from user-space, why is it relevant
> >> to update this data from non-sleepable kernel context rather than update it as
> >> needed on return-to-userspace ? When returning to userspace, sleeping due to a
> >> page fault is entirely acceptable. This is what we currently do for rseq.
> >>
> >> In short, the data could be accessible from the task struct. Flags in the
> >> task struct can let return-to-userspace know that it has outdated ktls
> >> data. So before returning to userspace, the kernel can copy the relevant data
> >> from the task struct to the shared memory area, without requiring any pinning.
> >>
> >> What am I missing ?
> >
> > I can't speak about other use cases, but in the context of userspace
> > scheduling, the information that a task has blocked in the kernel and
> > is going to be removed from its runqueue cannot wait to be delivered
> > to the userspace until the task wakes up, as the userspace scheduler
> > needs to know of the even when it happened so that it can schedule
> > another task in place of the blocked one. See the discussion here:
> >
> > https://lore.kernel.org/lkml/CAG48ez0mgCXpXnqAUsa0TcFBPjrid-74Gj=xG8HZqj2n+OPoKw@mail.gmail.com/
>
> OK, just to confirm my understanding, so the use-case here is per-thread
> state which can be read by other threads (in this case the userspace scheduler) ?

Yes, exactly! And sometimes these other threads have to read/write the
state while they are themselves in preempt_disabled regions in the
kernel. There could be a way to do that asynchronously (e.g. via
workpools), but this will add latency and complexity.

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
