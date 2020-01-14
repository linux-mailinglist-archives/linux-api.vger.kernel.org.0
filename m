Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7C713B2C3
	for <lists+linux-api@lfdr.de>; Tue, 14 Jan 2020 20:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgANTMn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jan 2020 14:12:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33859 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANTMn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jan 2020 14:12:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so7037076pfc.1;
        Tue, 14 Jan 2020 11:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f63B2LvCWNuhkfnuBRLARt3WlWJAkv9H8cQcBpg+JxA=;
        b=FAh3QOQ1X9MK9Pkn9EPZC1KsIdUlp49a/rCb3pGSAITaan1p0Ol+Z7s8PCAXCawGqs
         Aa/ExjygiJ+AtFLNFlladFpAl8pFyc/NyExixttixtN5ciGxwpzMPof30OJnzlegvZY0
         /s/oOvu65AKFBuvQDrMfdkyHaOwhX7xUnUhWOVhx1wWUbqMvNkIjnC1t3BkSTAIw/2+s
         EPPshBT+J1/T3JPY2XqkRc6ZdKJAxilRZu4bIMTGTdqowbXS6XxpBT4K0ZIzbHtb8qNg
         fbTyUw8d1pqhgT/fkk8utuPbGZrAFBj8+JK1nlcvG3jdWmlKyQGTzgqTlnBe3eoWtNRK
         RWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f63B2LvCWNuhkfnuBRLARt3WlWJAkv9H8cQcBpg+JxA=;
        b=j2B1lTi5AaNnCW50WGCRDqtsEbxIDh8lNBv0t1piRlnun/GD5pO+2VF+UVg72enDF7
         TVRQ+9mrBpzINP3ubf82cb1j+hv2x5SRuNpO8vdtanOJNN4AXY7rRp/bvYYHJRnkQYFK
         e1kRBmcMqSnoR0x/XqU4Nx6swhC8wIqknk/nNAp6wI8Yg7SJ3LVP65YiQ39OnV2gtT57
         7PrDQfcfbIHjUuW7dmxShiT8UXZLDYZI58l9BP8VOMf++RzZowf+0+PZkqxX2zyx3ytu
         QXwoOp1tM9/bjMrh7njUyVEBziZEeWmNXyfdjkrIASlP/EJfT8O9yS0pIrgi4q5waHBl
         cEOQ==
X-Gm-Message-State: APjAAAWYE+tdLr5+CnWntQQis4DRJdk4kKD2d6dpcMyDowNgoLq5/YIw
        eY9+IDQ36kvPqkSjtCk930U=
X-Google-Smtp-Source: APXvYqyX2/Ztqg7zQzkHX1bJyFkvAa04iBHiUGPG+wyB3Anf0nnb8KK8PuqFSwewo4GCFsiXAryL3w==
X-Received: by 2002:a63:b141:: with SMTP id g1mr29790386pgp.168.1579029162494;
        Tue, 14 Jan 2020 11:12:42 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id b21sm20330960pfp.0.2020.01.14.11.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:12:41 -0800 (PST)
Date:   Tue, 14 Jan 2020 11:12:39 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>, oleksandr@redhat.com,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH 2/4] mm: introduce external memory hinting API
Message-ID: <20200114191239.GB178589@google.com>
References: <20200110213433.94739-1-minchan@kernel.org>
 <20200110213433.94739-3-minchan@kernel.org>
 <56ea0927-ad2e-3fbd-3366-3813330f6cec@virtuozzo.com>
 <CAKOZuevwbQvrFWqy5GOm4RXuGszKLBvRs9i-KbAi3nPcHhwvSw@mail.gmail.com>
 <3eec2097-75a3-1e1d-06d9-44ee5eaf1312@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eec2097-75a3-1e1d-06d9-44ee5eaf1312@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 14, 2020 at 11:39:28AM +0300, Kirill Tkhai wrote:
> On 13.01.2020 22:18, Daniel Colascione wrote:
> > On Mon, Jan 13, 2020, 12:47 AM Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
> >>> +SYSCALL_DEFINE5(process_madvise, int, pidfd, unsigned long, start,
> >>> +             size_t, len_in, int, behavior, unsigned long, flags)
> >>
> >> I don't like the interface. The fact we have pidfd does not mean,
> >> we have to use it for new syscalls always. A user may want to set
> >> madvise for specific pid from console and pass pid as argument.
> >> pidfd would be an overkill in this case.
> >> We usually call "kill -9 pid" from console. Why shouldn't process_madvise()
> >> allow this?
> > 
> > All new APIs should use pidfds: they're better than numeric PIDs
> 
> Yes
> 
> > in every way.
> 
> No
> 
> > If a program wants to allow users to specify processes by
> > numeric PID, it can parse that numeric PID, open the corresponding
> > pidfd, and then use that pidfd with whatever system call it wants.
> > It's not necessary to support numeric PIDs at the system call level to
> > allow a console program to identify a process by numeric PID.
> 
> No. It is overkill. Ordinary pid interfaces also should be available.
> There are a lot of cases, when they are more comfortable. Say, a calling
> of process_madvise() from tracer, when a tracee is stopped. In this moment
> the tracer knows everything about tracee state, and pidfd brackets
> pidfd_open() and close() around actual action look just stupid, and this
> is cpu time wasting.
> 
> Another example is a parent task, which manages parameters of its children.
> It knows everything about them, whether they are alive or not. Pidfd interface
> will just utilize additional cpu time here.
> 
> So, no. Both interfaces should be available.

Sounds like that you want to support both options for every upcoming API
which deals with pid. I'm not sure how it's critical for process_madvise
API this case. In general, we sacrifice some performance for the nicer one
and later, once it's reported as hurdle for some workload, we could fix it
via introducing new flag. What I don't like at this moment is to make
syscall complicated with potential scenarios without real workload.
