Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F351CC518
	for <lists+linux-api@lfdr.de>; Sun, 10 May 2020 01:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgEIXOq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 9 May 2020 19:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725927AbgEIXOq (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 9 May 2020 19:14:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3192C061A0C;
        Sat,  9 May 2020 16:14:45 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t11so2667800pgg.2;
        Sat, 09 May 2020 16:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cFQEFHamvJeO++DzgevGO5UBaz8G9NUtSfCTpvC4iWo=;
        b=TfPHhOQwhqJHJ82A0wmjrQI3vCRANxfMZSw27kVD6T7S9YqwwoY7Ygagq51RWRZQCV
         tYOBqqpiFUUR7yqREoGDDtKNNqNPmbIGHz6Qaj+fkmOIkXK11f4K3INZpCMTT9asQwoJ
         7+ZmbUQLzPDXMTMwt2/neXXg+dCB8qZOpn64t8+RX06orDMgwRFGH8ssp1tevtP6uvtd
         qPqpiu9WtFajUd49dZwa3O8BjqKHPiFkL+nSwdAFCQYJx6uJN1pnh+chAR+IJ1aL/YHq
         ExmEvqOum+zfgln2hShEx0QqVYBiJrF87HK/Hd+3pxKxKVz/lvTm6X7O60x2QVgPNcNJ
         h1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cFQEFHamvJeO++DzgevGO5UBaz8G9NUtSfCTpvC4iWo=;
        b=SGPuBaF3h3UmYK82rE5UWRwYehdB5IYYriwfiJbuWIJMLc2Wh/8/MLsx+3fC1G8pHK
         tEHs60hRD0IdsQUfKGAWrPRDmL81jasGtqzaC/rC35zIus0sK2gJ9RURSCqmyEIsTZA3
         e8sZsejqmdwn74KGz4v6wwyLnb6cX9rSOyPJpUceOPmve+/0FYzaNVGggixed/JOuPWQ
         JCp80Jz+btJycKlrZcEH3Ws5xdGAFjyZpeaGeJU8a8pc1YBm90/0cXPmf5RKSjgOFZWF
         Lay+wLYrC/bg3C8X1I4p9MhEQy0zbFNuGyOmWkpvVmnMbB1JJLFQGLDo8vtXc+uO3sWX
         VSwA==
X-Gm-Message-State: AGi0PuaA4ihLmkEC2EWl++tv5mL5dHe3WJkIiiFIWQvzi1zQwloc6Cfx
        A0gWIVVB7tvfJZidPh7UfCs=
X-Google-Smtp-Source: APiQypLEtinKLOseJYS5AqPEVFV8rGU5ABR8NbhK6TXdEM4VBfW4ckpSgPbnOH2o6nFwMb3Yo8Pxbg==
X-Received: by 2002:a63:3c4c:: with SMTP id i12mr8099212pgn.448.1589066085023;
        Sat, 09 May 2020 16:14:45 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id z1sm5732684pjn.43.2020.05.09.16.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:14:43 -0700 (PDT)
Date:   Sat, 9 May 2020 16:14:41 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
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
Subject: Re: [PATCH v7 5/7] mm: support both pid and pidfd for process_madvise
Message-ID: <20200509231441.GC61301@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-6-minchan@kernel.org>
 <14089609-5fb1-b082-716f-c2e129d27c48@suse.cz>
 <20200311004251.GB87930@google.com>
 <20200508183653.GB125527@google.com>
 <20200508160415.65ff359a9e312c613336587b@linux-foundation.org>
 <20200509124817.xmrvsrq3mla6b76k@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509124817.xmrvsrq3mla6b76k@wittgenstein>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Christian,

On Sat, May 09, 2020 at 02:48:17PM +0200, Christian Brauner wrote:
> On Fri, May 08, 2020 at 04:04:15PM -0700, Andrew Morton wrote:
> > On Fri, 8 May 2020 11:36:53 -0700 Minchan Kim <minchan@kernel.org> wrote:
> > 
> > > 
> > > ...
> > >
> > > Per Vlastimil's request, I changed "which and advise" with "idtype and
> > > advice" in function prototype of description.
> > > Could you replace the part in the description? Code is never changed.
> > > 
> > 
> > Done, but...
> > 
> > >
> > > ...
> > >
> > > There is a demand[1] to support pid as well pidfd for process_madvise to
> > > reduce unnecessary syscall to get pidfd if the user has control of the
> > > target process(ie, they could guarantee the process is not gone or pid is
> > > not reused).
> > > 
> > > This patch aims for supporting both options like waitid(2).  So, the
> > > syscall is currently,
> > > 
> > >         int process_madvise(idtype_t idtype, id_t id, void *addr,
> > >                 size_t length, int advice, unsigned long flags);
> > > 
> > > @which is actually idtype_t for userspace libray and currently, it
> > > supports P_PID and P_PIDFD.
> > 
> > What does "@which is actually idtype_t for userspace libray" mean?  Can
> > you clarify and expand?
> 
> If I may clarify, the only case where we've supported both pidfd and pid
> in the same system call is waitid() to avoid adding a dedicated system
> call for waiting and because waitid() already had this (imho insane)
> argument type switching. The idtype_t thing comes from waitid() and is
> located int sys/wait.h and is defined as
> 
> "The type idtype_t is defined as an enumeration type whose possible
> values include at least the following:
> 
> P_ALL
> P_PID
> P_PGID
> "
> 
> int waitid(idtype_t idtype, id_t id, siginfo_t *infop, int options);
> If idtype is P_PID, waitid() shall wait for the child with a process ID equal to (pid_t)id.
> If idtype is P_PGID, waitid() shall wait for any child with a process group ID equal to (pid_t)id.
> If idtype is P_ALL, waitid() shall wait for any children and id is ignored.
> 
> I'm personally not a fan of this idtype_t thing and think this should
> just have been 
> > >         int pidfd_madvise(int pidfd, void *addr,
> > >                 size_t length, int advice, unsigned long flags);
> and call it a day.

That was the argument at that time, Daniel and I didn't want to have
pid along with pidfd even though Kirill strongly wanted to have it.
However you said " Overall, I don't particularly care how or if you
integrate pidfd here." at that time.

https://lore.kernel.org/linux-mm/20200113104256.5ujbplyec2sk4onn@wittgenstein/

I asked a question to Kirll at that time.

"
> Sounds like that you want to support both options for every upcoming API
> which deals with pid. I'm not sure how it's critical for process_madvise
> API this case. In general, we sacrifice some performance for the nicer one
> and later, once it's reported as hurdle for some workload, we could fix it
> via introducing new flag. What I don't like at this moment is to make
> syscall complicated with potential scenarios without real workload.

Yes, I suggest allowing both options for every new process api
"
https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/

You didn't give the opinion at that time, either(I expected you will
make some voice then). What I could do to proceed work was separate it
as different patch like this one to get more attention in future.
And now it works.

Let me clarify my side: I still don't like to introduce pid for new API
since we have pidfd. Since you just brought this issue again, I want to
hear *opinions* from others, again.

> 
> Also, if I may ask, why is the flag argument "unsigned long"?
> That's pretty unorthodox. The expectation is that flag arguments are
> not word-size dependent and should usually use "unsigned int". All new
> system calls follow this pattern too.

Nothing special in this flag: Let me change it as "unsigned int".
I will send the change once we have an agreement on "pidfd" argument.

Thanks for the review, Christian!
