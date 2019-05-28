Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDF2C5A2
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfE1Loo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 07:44:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34569 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1Lon (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 07:44:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id h2so7782444pgg.1;
        Tue, 28 May 2019 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Na+J22i77Z4lW2CgfdPS10rXWxVdK/zIAtW3TAGkfc0=;
        b=OXrfO0e3RlFaNQy3MzONif4phiuHMCrfpnn6bbGelKBttsjDb7M44ZI+FJjgbUxw6f
         7vXbGVdyuku1hUT89ULnYttsb2u5kz+/BF/U8tcBofrdT60RhDF7fwu4ghS6H7ZfsAJa
         FZ50GaZ9uRRD7wN2LYuLslXoDyELhO8unuwv8Xwg3UAse7oMSN4FPEALNexObmpuMFW/
         5tA/FWmvQH7GohrjdijN5eSt6qT+A7WGKgpjeoFVUudB1fizEiT481PdyYQ3Z5oxZlmg
         byTjYxHrYSLJKGsm3NO5UVkJkblMmBrgaHfU+8U+83lHzKF6n4q9it0LigqhyMDCjINY
         getA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Na+J22i77Z4lW2CgfdPS10rXWxVdK/zIAtW3TAGkfc0=;
        b=WcCTaBc2Ay/4fBa8IHBQYy7FFZmce9fzsSG5T1AYrqMY+CpV5ffyQMdsIcxuk6AAQK
         1SiNcrG6oKNa5pyABEkvkGWN13f5XIYU5pd1L0ruRbKEGoo5dG0St3i8y4XRB1IsRJ52
         Qzj12eWEO25n0wdlIfc+pFNrPsy5tieH71MH8FwGOPnZEHgHhBR8AGIk7nJ8YRTltRzL
         cN20Y5jPVFGAWeSPgE6tjsUYRKz+I2Pm15Yzzw7SMAnUL7RARBPgPJ05GQyl2SQHaY5D
         A8fDIll3cSrDhgP+B34HtF+/DNydpNrkyq91gVWm0Nq3eGqCVVi4wWAtQfi+jZ/vJ+J7
         gRdg==
X-Gm-Message-State: APjAAAUQxYXIAxOvK2A7CU+t0bx0JjUUf6UkkQGeG9JyV66V9bykMPHA
        CHsZ40S4o+yI2NFI+vl93Ja+Jtby
X-Google-Smtp-Source: APXvYqxKdDbXQTCQ2wTlaKWGq9gz76gsK2o3fQBBvCu+KCLAp37410V79lyMGOqtSpKnkp3QPk1hFQ==
X-Received: by 2002:a65:5206:: with SMTP id o6mr1937077pgp.248.1559043882565;
        Tue, 28 May 2019 04:44:42 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id v4sm8549594pfe.180.2019.05.28.04.44.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 04:44:41 -0700 (PDT)
Date:   Tue, 28 May 2019 20:44:36 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190528114436.GB30365@google.com>
References: <20190528032632.GF6879@google.com>
 <20190528062947.GL1658@dhcp22.suse.cz>
 <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
 <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com>
 <20190528104117.GW1658@dhcp22.suse.cz>
 <20190528111208.GA30365@google.com>
 <20190528112840.GY1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528112840.GY1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 01:28:40PM +0200, Michal Hocko wrote:
> On Tue 28-05-19 20:12:08, Minchan Kim wrote:
> > On Tue, May 28, 2019 at 12:41:17PM +0200, Michal Hocko wrote:
> > > On Tue 28-05-19 19:32:56, Minchan Kim wrote:
> > > > On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> > > > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > > > >
> > > > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > > > so map_anon wouldn't be helpful.
> > > > > > > 
> > > > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > > > memory map information out of processes.  Some single-system-call
> > > > > > > method for retrieving a binary snapshot of a process's address space
> > > > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > > > reduce complexity and increase performance in a variety of areas,
> > > > > > > e.g., Android memory map debugging commands.
> > > > > > 
> > > > > > I agree it's the best we can get *generally*.
> > > > > > Michal, any opinion?
> > > > > 
> > > > > I am not really sure this is directly related. I think the primary
> > > > > question that we have to sort out first is whether we want to have
> > > > > the remote madvise call process or vma fd based. This is an important
> > > > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > > > so far unfortunately.
> > > > 
> > > > With current usecase, it's per-process API with distinguishable anon/file
> > > > but thought it could be easily extended later for each address range
> > > > operation as userspace getting smarter with more information.
> > > 
> > > Never design user API based on a single usecase, please. The "easily
> > > extended" part is by far not clear to me TBH. As I've already mentioned
> > > several times, the synchronization model has to be thought through
> > > carefuly before a remote process address range operation can be
> > > implemented.
> > 
> > I agree with you that we shouldn't design API on single usecase but what
> > you are concerning is actually not our usecase because we are resilient
> > with the race since MADV_COLD|PAGEOUT is not destruptive.
> > Actually, many hints are already racy in that the upcoming pattern would
> > be different with the behavior you thought at the moment.
> 
> How come they are racy wrt address ranges? You would have to be in
> multithreaded environment and then the onus of synchronization is on
> threads. That model is quite clear. But we are talking about separate

Think about MADV_FREE. Allocator would think the chunk is worth to mark
"freeable" but soon, user of the allocator asked the chunk - ie, it's not
freeable any longer once user start to use it.

My point is that kinds of *hints* are always racy so any synchronization
couldn't help a lot. That's why I want to restrict hints process_madvise
supports as such kinds of non-destruptive one at next respin.

> processes and some of them might be even not aware of an external entity
> tweaking their address space.
> 
> > If you are still concerning of address range synchronization, how about
> > moving such hints to per-process level like prctl?
> > Does it make sense to you?
> 
> No it doesn't. How is prctl any relevant to any address range
> operations.

"whether we want to have the remote madvise call process or vma fd based."

You asked the above question and I answered we are using process level
hints but anon/vma filter at this moment. That's why I told you prctl to
make forward progress on discussion.

