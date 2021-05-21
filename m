Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADF038D07D
	for <lists+linux-api@lfdr.de>; Sat, 22 May 2021 00:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbhEUWE6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 18:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhEUWE4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 18:04:56 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6DFC061574
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 15:03:31 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c15so25654466ljr.7
        for <linux-api@vger.kernel.org>; Fri, 21 May 2021 15:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QlIMY15CpFScH+ksxa68jbEZt4sckreO5cTytM/uKyQ=;
        b=NcsSM/s4rzD7dlt+04clT1uj5dtUq5BhwFimvnhztIB6rQKNDP+rOxORZp7zivcDiB
         +adfZgxAxkfkXXTIkjUzTVCmhnbhpjOOKH5/yw/PQ5X/S4EkYqASi2W6yBYlqBTJPd2N
         UzXw9Pg8df34MaaYYHM2xkjZ6Wg+4MPwF0PqPgsUzEI1kLsT+C937e7gFzw7GO/pellR
         kmwHPOQxI6f20m+ryg58lE+B0x1PhdGa5R0m03/W6juP7HGsLCGzLUo+XoBQ1CypsgPv
         X2jfAWDHInGbYBeYbUE3Vl1bjkf2yO97SP2tEK2EVjGl21JBpTNFqFlVGlaUwnVtH/CB
         4Ddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QlIMY15CpFScH+ksxa68jbEZt4sckreO5cTytM/uKyQ=;
        b=ByjHD2Cy4CgPgIFumPgLVKc7l8HYtJ33s6cgJXxnu6w4O9paK5Qbz1KWjG6y1YD8m+
         4mybj/cAYK+XJFLWOKvHum2jsMRO0B42CB8BXHO1R1EpEcLmWYf2sE1LM+dKYFvtyabw
         fQX7p8+FoRmxaVVzxt48azzZSjdqLjIt3tC79mlQ7vBCJWqB5Yf95/wlYO1yW71Ho0kx
         p7csQ5vMesy2AlSy8bp8wSJYaWHEQ6KDjH+XJfVmNWlP5C+sL6lNPC+Iy7NGZ8U/uQJw
         wRFm9IF/QAvl+7slIVAKOa1tpvF9BSGExxfHwkrmnqwPlQm4QorwIjoM51ajdJavj8ly
         Ne0g==
X-Gm-Message-State: AOAM531S571uTcpWf/+VhB1lMVgcSGzZSKBOnvylu9jyOHPAYO+11lea
        u5ClGDyGOHovbnlEXgq+ZTLm/bD7KwnHQkXNiz/3cA==
X-Google-Smtp-Source: ABdhPJw+0Qgixkebi05CmJcybmpLEK8eFm8/RcA/Uyc8tm1QpjZrtF09sMlvAAj4osycGZDCHoKp9ZCK05jucXh09ks=
X-Received: by 2002:a2e:9c05:: with SMTP id s5mr7976368lji.208.1621634610156;
 Fri, 21 May 2021 15:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <20210520183614.1227046-5-posk@google.com>
 <YKgEn/TBsTyhk0m1@gmail.com> <CAG48ez0=ndXMCM-hST1WLMpQu5X9w_93Df=EoBqdq+DhC_HwbQ@mail.gmail.com>
In-Reply-To: <CAG48ez0=ndXMCM-hST1WLMpQu5X9w_93Df=EoBqdq+DhC_HwbQ@mail.gmail.com>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 21 May 2021 15:03:18 -0700
Message-ID: <CAPNVh5fOPn+yuH5kEcGBFLphxDHSvsVS1QeFtHh63d4Go9UAJA@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 4/9] sched/umcg: implement core UMCG API
To:     Jann Horn <jannh@google.com>
Cc:     Andrei Vagin <avagin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 21, 2021 at 2:32 PM Jann Horn <jannh@google.com> wrote:
>
> On Fri, May 21, 2021 at 9:09 PM Andrei Vagin <avagin@gmail.com> wrote:
> > On Thu, May 20, 2021 at 11:36:09AM -0700, Peter Oskolkov wrote:
> > > @@ -67,7 +137,75 @@ SYSCALL_DEFINE4(umcg_register_task, u32, api_version, u32, flags, u32, group_id,
> > >   */
> > >  SYSCALL_DEFINE1(umcg_unregister_task, u32, flags)
> > >  {
> > > -     return -ENOSYS;
> > > +     struct umcg_task_data *utd;
> > > +     int ret = -EINVAL;
> > > +
> > > +     rcu_read_lock();
> > > +     utd = rcu_dereference(current->umcg_task_data);
> > > +
> > > +     if (!utd || flags)
> > > +             goto out;
> > > +
> > > +     task_lock(current);
> > > +     rcu_assign_pointer(current->umcg_task_data, NULL);
> > > +     task_unlock(current);
> > > +
> > > +     ret = 0;
> > > +
> > > +out:
> > > +     rcu_read_unlock();
> > > +     if (!ret && utd) {
> > > +             synchronize_rcu();
> >
> > synchronize_rcu is expensive. Do we really need to call it here? Can we
> > use kfree_rcu?
> >
> > Where is task->umcg_task_data freed when a task is destroyed?
>
> or executed - the umcg stuff includes a userspace pointer, so it
> probably shouldn't normally be kept around across execve?

Ack - thanks for these and other comments. Please keep them coming.
I'll address them in v0.2.

Thanks,
Peter
