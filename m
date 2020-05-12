Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB5C1CFEBE
	for <lists+linux-api@lfdr.de>; Tue, 12 May 2020 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgELTzq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 12 May 2020 15:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgELTzp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 12 May 2020 15:55:45 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FACFC061A0E
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 12:55:44 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id z1so8646170vsn.11
        for <linux-api@vger.kernel.org>; Tue, 12 May 2020 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=souGqEVdFUGfbVs6klo3kTV/o0WFTA0pV6SMGDZE5jU=;
        b=BGByk4t/lgEtRVy7AtXqVevMTDz90sCHvuLDrt76134g9D/XItf0Ktm7vUPpyEWdwi
         64DApzPuvJouI1yo+2vRRdSKpZdFDmGG2oTRKHPbFbZyBiJLkDrFaj/fzoyYXcNETbmG
         q3eEQXEDH2DKbwb5Xffuev5oBuFRf934QYOjhcke0Mi5oyne/vHEpY5Ks7qT0Lg7zcMT
         b0e1tttnIX3fK3KgNQ9DFs3S1FB2Gkehy1pqFjtJ6ekv0TzPSS2WGT6Xx+vIUb7lXKH0
         Qo4rs067MNBl/CbM4MzosrXxY4CrZAn/jO3iycnbI4WFbyEYQnBQnaZ389icQNz0QWt5
         Z38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=souGqEVdFUGfbVs6klo3kTV/o0WFTA0pV6SMGDZE5jU=;
        b=dKi5G5y3KA0rORkMR3AGD4ylg5F2VMp4J6ZDu5SxNfs3P9ZLqIXPUWUKhlr+4PAGRo
         dse9d92mR0dW6zhNV4O4CxzoMbRwLPkWU86y4WZKmP4S6bmMCazgFUWUzJIU/av4DKs7
         PY6Co5Cza0DufO8pif5ReDq11YBLv4AwhVm8ENq2xX8inCyg1SEA+x37Y8z3PQBaDe+n
         E1nUikPUhzlHeLW6d7i35YiuK+n1pU+BPd2R+67q7ezsMUbxv9JiKa+L4EhS3S5fKzeU
         oP2OS/hZAHi/1zk6uNJN2zdfq3BqayNMLhJDM64y4cONPx5tm3GxEOGVvdU/5Tr3jdVv
         5c2w==
X-Gm-Message-State: AGi0PuYscl8ccFbwVNx7bItxptmRuFyI6QSMv2YZteB+wVZV6KGWzlb3
        MmXKzIOlNoTkU7nf3R4+ceK6SOocRzHYgn1wgIxVKA==
X-Google-Smtp-Source: APiQypJALX0PEkw6GFYEO7ce5qnOamFXHlAc7QIRs/F4gM/2LXdipawuW0G4sPiNSihRRxaPNxzRlrtB0yEpIkUujs8=
X-Received: by 2002:a67:dd98:: with SMTP id i24mr18420597vsk.239.1589313342705;
 Tue, 12 May 2020 12:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200302193630.68771-1-minchan@kernel.org> <20200302193630.68771-6-minchan@kernel.org>
 <14089609-5fb1-b082-716f-c2e129d27c48@suse.cz> <20200311004251.GB87930@google.com>
 <20200508183653.GB125527@google.com> <20200508160415.65ff359a9e312c613336587b@linux-foundation.org>
 <20200509124817.xmrvsrq3mla6b76k@wittgenstein> <20200509231441.GC61301@google.com>
In-Reply-To: <20200509231441.GC61301@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 12 May 2020 12:55:30 -0700
Message-ID: <CAJuCfpFKYdfbG02vevRhWHhMhA4e_rRVNfCabcT0Pf_qNUgAnQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/7] mm: support both pid and pidfd for process_madvise
To:     Minchan Kim <minchan@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, May 9, 2020 at 4:14 PM Minchan Kim <minchan@kernel.org> wrote:
>
> Hi Christian,
>
> On Sat, May 09, 2020 at 02:48:17PM +0200, Christian Brauner wrote:
> > On Fri, May 08, 2020 at 04:04:15PM -0700, Andrew Morton wrote:
> > > On Fri, 8 May 2020 11:36:53 -0700 Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > >
> > > > ...
> > > >
> > > > Per Vlastimil's request, I changed "which and advise" with "idtype and
> > > > advice" in function prototype of description.
> > > > Could you replace the part in the description? Code is never changed.
> > > >
> > >
> > > Done, but...
> > >
> > > >
> > > > ...
> > > >
> > > > There is a demand[1] to support pid as well pidfd for process_madvise to
> > > > reduce unnecessary syscall to get pidfd if the user has control of the
> > > > target process(ie, they could guarantee the process is not gone or pid is
> > > > not reused).
> > > >
> > > > This patch aims for supporting both options like waitid(2).  So, the
> > > > syscall is currently,
> > > >
> > > >         int process_madvise(idtype_t idtype, id_t id, void *addr,
> > > >                 size_t length, int advice, unsigned long flags);
> > > >
> > > > @which is actually idtype_t for userspace libray and currently, it
> > > > supports P_PID and P_PIDFD.
> > >
> > > What does "@which is actually idtype_t for userspace libray" mean?  Can
> > > you clarify and expand?
> >
> > If I may clarify, the only case where we've supported both pidfd and pid
> > in the same system call is waitid() to avoid adding a dedicated system
> > call for waiting and because waitid() already had this (imho insane)
> > argument type switching. The idtype_t thing comes from waitid() and is
> > located int sys/wait.h and is defined as
> >
> > "The type idtype_t is defined as an enumeration type whose possible
> > values include at least the following:
> >
> > P_ALL
> > P_PID
> > P_PGID
> > "
> >
> > int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
> > If idtype is P_PID, waitid() shall wait for the child with a process ID equal to (pid_t)id.
> > If idtype is P_PGID, waitid() shall wait for any child with a process group ID equal to (pid_t)id.
> > If idtype is P_ALL, waitid() shall wait for any children and id is ignored.
> >
> > I'm personally not a fan of this idtype_t thing and think this should
> > just have been
> > > >         int pidfd_madvise(int pidfd, void *addr,
> > > >                 size_t length, int advice, unsigned long flags);
> > and call it a day.
>
> That was the argument at that time, Daniel and I didn't want to have
> pid along with pidfd even though Kirill strongly wanted to have it.
> However you said " Overall, I don't particularly care how or if you
> integrate pidfd here." at that time.
>
> https://lore.kernel.org/linux-mm/20200113104256.5ujbplyec2sk4onn@wittgenstein/
>
> I asked a question to Kirll at that time.
>
> "
> > Sounds like that you want to support both options for every upcoming API
> > which deals with pid. I'm not sure how it's critical for process_madvise
> > API this case. In general, we sacrifice some performance for the nicer one
> > and later, once it's reported as hurdle for some workload, we could fix it
> > via introducing new flag. What I don't like at this moment is to make
> > syscall complicated with potential scenarios without real workload.
>
> Yes, I suggest allowing both options for every new process api
> "
> https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/
>
> You didn't give the opinion at that time, either(I expected you will
> make some voice then). What I could do to proceed work was separate it
> as different patch like this one to get more attention in future.
> And now it works.
>
> Let me clarify my side: I still don't like to introduce pid for new API
> since we have pidfd. Since you just brought this issue again, I want to
> hear *opinions* from others, again.


IIRC Kirill's main complaint was that if we support only pidfds and
userspace has a pid of the process then it would have to convert that
pid into pidfd before calling process_madvise, which involves
additional syscall(s). The overhead would be more tangible if there
are multiple processes needing to be madvised.
I'm not sure how often such a need arises to madvise multiple
processes in a bulk like that and how critical is the overhead of
obtaining pidfd. With pid reuse possibility pid-based API will still
have the issue of possibly sending the request to a wrong process, so
this pidfd obtaining overhead arguably makes the usage more robust and
therefore is not a pure loss.

I don't have a real strong opinion against supporting pid in this
syscall but I think API maintainers should decide going forward
whether new APIs should support pid along with pidfd or switch to
pidfd only.
Thanks!

>
> >
> > Also, if I may ask, why is the flag argument "unsigned long"?
> > That's pretty unorthodox. The expectation is that flag arguments are
> > not word-size dependent and should usually use "unsigned int". All new
> > system calls follow this pattern too.
>
> Nothing special in this flag: Let me change it as "unsigned int".
> I will send the change once we have an agreement on "pidfd" argument.
>
> Thanks for the review, Christian!
