Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 645301584C3
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 22:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgBJV1d (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 16:27:33 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36067 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBJV1c (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 16:27:32 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so311053pjb.1;
        Mon, 10 Feb 2020 13:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yXadc5r0jVy9eypDN9eO0vm8bZvBNSj5lFEFk014iXE=;
        b=j7knCdoYiOGtw+fon1SpNcC7LIcblZXlttx6rgmUEFSpM0BYTymY/Q7dFTBUvdfd9E
         4oWsIFc/CuIZAnpSCPxyJ64Vyo1DLIN/8/ookbWFj0mpEEdUkF1bPONPIX1a+x9rwm5t
         77Esu0BtOseNpkjAIrFzgSsGNlMzvEOzP7xNgoi8z28YU7bSAOW/fjTQJNsFX2N8U/8X
         Q5KZ/42QxYi6NEueqyz6IPxTh7ebwxMb+YHJ2GfIXsvyxjiK2ESQAceqNalCuwcw+NOY
         QXMda4YHv5hsZ3le4X0vbo710/Cmssbhhup/Z1frMEvVqEcM9Aaa5bwFqsyMytPpr4XX
         hnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=yXadc5r0jVy9eypDN9eO0vm8bZvBNSj5lFEFk014iXE=;
        b=EmJgKmtjZ3kBPoYbZSY0q14S3UJUK1pNUvokCExM2yc70gjStej14Te4z2wXY0OJn7
         jXtkKSGnZ6FdBLHcit+UQ+vlmwK1HV76Zrgzk+yHJGdnbrgXZujb7R9PCc/hKklFhWnh
         6iW7r5QBHinLXUByzbFBswDXYClVt4xNLyuzqsqRd2rVcVO/vetZl9PEhkW48j9FzXqb
         wCwst6XagxdjZZsPWv7mJFIdvtC4goOTXTUY/mT3dseQugvscqECEiozLqAdok8+zP6P
         JB0uzAjl7xQ/I5coIaEfohkLJDO0DBBFq3DsQf8P1Jv1HvEJ3AdBFdUKd7aVduu4p/50
         u9Hw==
X-Gm-Message-State: APjAAAX4QnD+VjeMgqLnew0GbnpTxbK6zZlSKiFUtCzkN4uLVjOboFut
        4GtqpKfBHJ9I9KEm++yA9zKeUh81
X-Google-Smtp-Source: APXvYqyjo35cOZZHrhBZhNWK3bWxb+GGcYspZ1LBRhtydKFEE8Pdu7WmVJap0j0swIpL5rMky8kO4A==
X-Received: by 2002:a17:90b:289:: with SMTP id az9mr1208133pjb.23.1581370051007;
        Mon, 10 Feb 2020 13:27:31 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id e84sm1280496pfh.149.2020.02.10.13.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 13:27:29 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:27:27 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v3 2/5] mm: introduce external memory hinting API
Message-ID: <20200210212727.GA48790@google.com>
References: <20200128001641.5086-1-minchan@kernel.org>
 <20200128001641.5086-3-minchan@kernel.org>
 <CAJuCfpFOBUYfxyQZZCvKjD0pyh_D-ZEpJP9kLD8xav+hVHZWYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpFOBUYfxyQZZCvKjD0pyh_D-ZEpJP9kLD8xav+hVHZWYQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Suren,

On Mon, Feb 10, 2020 at 09:50:20AM -0800, Suren Baghdasaryan wrote:
> On Mon, Jan 27, 2020 at 4:17 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > There is usecase that System Management Software(SMS) want to give
> > a memory hint like MADV_[COLD|PAGEEOUT] to other processes and
> > in the case of Android, it is the ActivityManagerService.
> >
> > It's similar in spirit to madvise(MADV_WONTNEED), but the information
> > required to make the reclaim decision is not known to the app. Instead,
> > it is known to the centralized userspace daemon(ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without
> > any app involvement.
> >
> > To solve the issue, this patch introduces a new syscall process_madvise(2).
> > It uses pidfd of an external process to give the hint.
> >
> >  int process_madvise(int pidfd, void *addr, size_t length, int advise,
> >                         unsigned long flag);
> >
> > Since it could affect other process's address range, only privileged
> > process(CAP_SYS_PTRACE) or something else(e.g., being the same UID)
> > gives it the right to ptrace the process could use it successfully.
> > The flag argument is reserved for future use if we need to extend the
> > API.
> >
> > I think supporting all hints madvise has/will supported/support to
> > process_madvise is rather risky. Because we are not sure all hints make
> > sense from external process and implementation for the hint may rely on
> > the caller being in the current context so it could be error-prone.
> > Thus, I just limited hints as MADV_[COLD|PAGEOUT] in this patch.
> >
> > If someone want to add other hints, we could hear hear the usecase and
> > review it for each hint. It's safer for maintenance rather than
> > introducing a buggy syscall but hard to fix it later.
> 
> I would definitely be interested in adding MADV_DONTNEED support for
> process_madvise() to allow quick memory reclaim after a kill. The
> scenario is that userspace daemon can kill a process and try to help
> reclaim its memory. Having process_madvise(MADV_DONTNEED) support
> helps in the following cases:
> 1. Process issuing process_madvise has a higher CPU bandwidth
> allowance than the victim process, therefore can reclaim victim's
> memory quicker.
> 2. In case the victim occupies large amounts of memory the process
> issuing process_madvise can spawn multiple (possibly high priority)
> threads each reclaiming portions of the victim's memory.
> Such an extension will add a destructive kind of madvise into the set
> supported by process_madvise and I want to make sure we can accomodate
> for that in the future. Do you see any issues with supporting
> MADV_DONTNEED in the future?

Or kernel could do by themselves to spawn mulitple tasks if the system has
available badwidth and target process has a lot memory to be reclaimed

Anyway, it doesn't have any issue because we already have some synchrnoization
methods(e.g., signal or cgroup freezer) to freeze target processes before
giving a hint. It's not different with usual write syscall on shared file
among processes.

< snip >

> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 0c901de531e4..00ffa7e92f79 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/falloc.h>
> >  #include <linux/fadvise.h>
> >  #include <linux/sched.h>
> > +#include <linux/sched/mm.h>
> >  #include <linux/ksm.h>
> >  #include <linux/fs.h>
> >  #include <linux/file.h>
> > @@ -315,6 +316,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >
> >         if (fatal_signal_pending(task))
> >                 return -EINTR;
> > +       else if (current != task && fatal_signal_pending(current))
> > +               return -EINTR;
> 
> I think this can be simplified as:
> 
> +       if (fatal_signal_pending(current))
> +               return -EINTR;
> 
> current != task condition is not needed because if current == task
> then you would return earlier after checking
> fatal_signal_pending(task).

True, I will remove it.

Thanks!
