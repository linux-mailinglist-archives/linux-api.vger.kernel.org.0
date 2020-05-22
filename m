Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA381DEEAB
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2020 19:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgEVRzd (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 22 May 2020 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730635AbgEVRzd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 22 May 2020 13:55:33 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A70C061A0E
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 10:55:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id h21so13981045ejq.5
        for <linux-api@vger.kernel.org>; Fri, 22 May 2020 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7+ZinecQk+vU2tx3USRyzTX9hWXqwnrfU8Z0ao5NFs=;
        b=RM1/oCRXDo9ryPT24QfNPtGbMQpFbyhAtGPByRCCCkRsAIqdrbBXgtD+Xp5SO5xHVD
         Y5nW0iZ21Q903SnBry33l1LxeDFngn3uirbmpxBPPre74pAl3PQlkFV/9PLuVlTtF12n
         59lPUphICio+7TuzrBBJrxD5HeyV9gmylFGU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7+ZinecQk+vU2tx3USRyzTX9hWXqwnrfU8Z0ao5NFs=;
        b=Y3bCyRCG5oM7n4Ym6TB55W4dOziIeXldICTF7wLZ5xzBEl9AyZY+f6QEcxu96qfobr
         cIEPJujYHjsdD2x4ueoCpY2t4YC82cbj97rmrkUmoJPDMK/6OQxMLex4VNuLuVMQ297S
         vmm3Eh62v+xlIP1Xb3p30QpzjyJs/dcKJEolaqoOUOUpQ5Gf57YfYVERLpQLSfvhK/S6
         Cv+FAYfxOHmu6lgkbgiC3+6sQ0l5nYcFfi0JQrcoAk56mqLZLiDmg8VY5g9641Ml15lk
         dCoqDrKMlA4/MYkxqh3kFYpGITi674jBGrALhbJNKOVcCodui4IxHizdEOa5TpyUOIpt
         3fNQ==
X-Gm-Message-State: AOAM5321dQ3PuUcPtlLfC8dxzFFnWukV7YXDLX1BKDGAZaA0WNKGvudh
        UKWL+wbOCKJwZ1xdHrMdi4eu2bGVT/18kXfZK/lW6w==
X-Google-Smtp-Source: ABdhPJz/m46fpJfBvIY7sjEMmScn7M1dEiRH6YRxpET3JjeVNzQT8FxrHABIFR2TSp9Tpc7jFZXMsMl+UXhXNGe1F4U=
X-Received: by 2002:a17:906:9404:: with SMTP id q4mr9055108ejx.138.1590170131063;
 Fri, 22 May 2020 10:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234005.32370-1-sargun@sargun.me> <87h7wc4zac.fsf@x220.int.ebiederm.org>
In-Reply-To: <87h7wc4zac.fsf@x220.int.ebiederm.org>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Fri, 22 May 2020 10:54:55 -0700
Message-ID: <CAMp4zn_v-D=gyzdWO7D2KrdZ_vct87dV_0pM5HVNE_3zDG7k8Q@mail.gmail.com>
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 18, 2020 at 4:11 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Sargun Dhillon <sargun@sargun.me> writes:
>
> > This includes the thread group leader ID in the seccomp_notif. This is
> > immediately useful for opening up a pidfd for the group leader, as
> > pidfds only work on group leaders.
>
> The code looks fine (except for the name of the test), but can you
> please talk and think about this as something other than the
> group leader?
>
> The initial thread in a thread group can die, and the tgid is still
> valid for the entire group.  Because the initial thread of a
> process/thread group can die (but rarely does) that tends to result in
> kernel code that fails when thread_group_leader dies.
>
> To remove that class of bugs I am slowy working to remove the
> thread_group_leader from the kernel entirely.
>
> Looking at the names of the fields in the structure it looks like
> there is another class of bugs to be removed by renaming PIDTYPE_PID
> to PIDTYPE_TID in the kernel as well.  Just skimming the example code
> it looks very simple to get confused.
>
> Is there any chance some can modify struct seccomp_notify to do
> {
>         ...
>         union {
>                 __u32 pid;
>                 __u32 tid;
>         };
>         ...
> }
>
> Just to reduce the chance of confusion between the userspace pid and the
> in kernel pid names?
>
> Eric
Our use cases would be unaffected by this. I think this would be a wonderful
way to move forward, but I don't know if it could break userspace.

I believe Christian's team is the biggest user of this feature in OSS right now,
so he might know.

In addition, I'm not sure where you would want the thread's ID versus the
process's ID, unless you wanted to do something like SIGSTOP, and freeze
the thread to prevent it from making more progress, or being interrupted
while you go do notifier work.

Christian & Kees,
Thoughts?
