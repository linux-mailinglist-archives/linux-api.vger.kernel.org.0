Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BC42C65A
	for <lists+linux-api@lfdr.de>; Tue, 28 May 2019 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfE1MWQ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 May 2019 08:22:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32770 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfE1MWP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 May 2019 08:22:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so8299339plq.0;
        Tue, 28 May 2019 05:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AJ8VRsxsoWGs/vBSV1ADUeGhgVxuJp/KwJ0JXgr2QW8=;
        b=nOfmaveBw33qA+XOhBteLcPyL6U0iAwH31DZFkeev74RKVWIws7CENGYDnihRDjxvn
         nCSw3qHhQW9dZsKA3TKHyivcfswE3XdA9LbjIbTloBrbMUu3qCfhcahqTPjJl0c2BHwF
         Ba2JzCTarLEOdUUnVtU94PDddmwZRE2ZSfocpESfyPTDwtaK8r/Oo7dIbyD+lJR2PkZe
         z5yy6U4PyW7okX5RiXlxAYZTR2aoWnaWNfGqD1u7PcQRsptm3U1jVZdg5qnUVZ1mJufG
         ED5ixHOJ4Tos/q69eKg1psE/LcRiqlnlfCoTm84cOZT5jDb6CrabqUYSIp1T62ntfYa1
         mJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=AJ8VRsxsoWGs/vBSV1ADUeGhgVxuJp/KwJ0JXgr2QW8=;
        b=KEIjPYaCo70DO6UleQTqGbwfnDv1j5ShkAi5VDvY0iOR4aPa/dM3iK/wPk7H4Gwk+I
         q2p9tFBzbMGoIvBqcqiR1qV2CPwZVAQP1rbfxxuwddEQrmF5rWzqcOwoVXwguhcV1O+Y
         YwO9LDRAW4C2p9qnyERJqlmrhYW7hBm3kkY1YDFVdFLFZmtFUJesfmIlALs35p1mLu3+
         VT6N41NNUGiB6WCbVoFH0fWPQ8u9jY+6NqG6dtpxvckaCv+euK2ngMYhKleC7DKT/Knm
         N0A9cYj9y0k8cZ1dSlvIwWFEj0pqqq5fdhJwctHX6GlhaKx/+awyBerX5A0zdzq0b7U0
         OxuA==
X-Gm-Message-State: APjAAAWoJuP1AJQD3lNUkCbuKGtv1lvAK5BNH7b87sEqRJfGJn8qYVtl
        bAU8Raoa2c0aFd4SrMrIMwo=
X-Google-Smtp-Source: APXvYqyxBBA1c7fo0kmqewKRmZb4uXkX32qK6cXRlHYmibj6AYwQWFyVNY2kFpvESFd+P8Oc5wfClw==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr70129886plo.60.1559046134645;
        Tue, 28 May 2019 05:22:14 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id o7sm18655494pfp.168.2019.05.28.05.22.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 28 May 2019 05:22:13 -0700 (PDT)
Date:   Tue, 28 May 2019 21:22:07 +0900
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
Message-ID: <20190528122207.GD30365@google.com>
References: <20190528081351.GA159710@google.com>
 <CAKOZuesnS6kBFX-PKJ3gvpkv8i-ysDOT2HE2Z12=vnnHQv0FDA@mail.gmail.com>
 <20190528084927.GB159710@google.com>
 <20190528090821.GU1658@dhcp22.suse.cz>
 <20190528103256.GA9199@google.com>
 <20190528104117.GW1658@dhcp22.suse.cz>
 <20190528111208.GA30365@google.com>
 <20190528112840.GY1658@dhcp22.suse.cz>
 <20190528114436.GB30365@google.com>
 <20190528120614.GB1658@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528120614.GB1658@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 28, 2019 at 02:06:14PM +0200, Michal Hocko wrote:
> On Tue 28-05-19 20:44:36, Minchan Kim wrote:
> > On Tue, May 28, 2019 at 01:28:40PM +0200, Michal Hocko wrote:
> > > On Tue 28-05-19 20:12:08, Minchan Kim wrote:
> > > > On Tue, May 28, 2019 at 12:41:17PM +0200, Michal Hocko wrote:
> > > > > On Tue 28-05-19 19:32:56, Minchan Kim wrote:
> > > > > > On Tue, May 28, 2019 at 11:08:21AM +0200, Michal Hocko wrote:
> > > > > > > On Tue 28-05-19 17:49:27, Minchan Kim wrote:
> > > > > > > > On Tue, May 28, 2019 at 01:31:13AM -0700, Daniel Colascione wrote:
> > > > > > > > > On Tue, May 28, 2019 at 1:14 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > > > > > > if we went with the per vma fd approach then you would get this
> > > > > > > > > > > feature automatically because map_files would refer to file backed
> > > > > > > > > > > mappings while map_anon could refer only to anonymous mappings.
> > > > > > > > > >
> > > > > > > > > > The reason to add such filter option is to avoid the parsing overhead
> > > > > > > > > > so map_anon wouldn't be helpful.
> > > > > > > > > 
> > > > > > > > > Without chiming on whether the filter option is a good idea, I'd like
> > > > > > > > > to suggest that providing an efficient binary interfaces for pulling
> > > > > > > > > memory map information out of processes.  Some single-system-call
> > > > > > > > > method for retrieving a binary snapshot of a process's address space
> > > > > > > > > complete with attributes (selectable, like statx?) for each VMA would
> > > > > > > > > reduce complexity and increase performance in a variety of areas,
> > > > > > > > > e.g., Android memory map debugging commands.
> > > > > > > > 
> > > > > > > > I agree it's the best we can get *generally*.
> > > > > > > > Michal, any opinion?
> > > > > > > 
> > > > > > > I am not really sure this is directly related. I think the primary
> > > > > > > question that we have to sort out first is whether we want to have
> > > > > > > the remote madvise call process or vma fd based. This is an important
> > > > > > > distinction wrt. usability. I have only seen pid vs. pidfd discussions
> > > > > > > so far unfortunately.
> > > > > > 
> > > > > > With current usecase, it's per-process API with distinguishable anon/file
> > > > > > but thought it could be easily extended later for each address range
> > > > > > operation as userspace getting smarter with more information.
> > > > > 
> > > > > Never design user API based on a single usecase, please. The "easily
> > > > > extended" part is by far not clear to me TBH. As I've already mentioned
> > > > > several times, the synchronization model has to be thought through
> > > > > carefuly before a remote process address range operation can be
> > > > > implemented.
> > > > 
> > > > I agree with you that we shouldn't design API on single usecase but what
> > > > you are concerning is actually not our usecase because we are resilient
> > > > with the race since MADV_COLD|PAGEOUT is not destruptive.
> > > > Actually, many hints are already racy in that the upcoming pattern would
> > > > be different with the behavior you thought at the moment.
> > > 
> > > How come they are racy wrt address ranges? You would have to be in
> > > multithreaded environment and then the onus of synchronization is on
> > > threads. That model is quite clear. But we are talking about separate
> > 
> > Think about MADV_FREE. Allocator would think the chunk is worth to mark
> > "freeable" but soon, user of the allocator asked the chunk - ie, it's not
> > freeable any longer once user start to use it.
> 
> That is not a race in the address space, right. The underlying object
> hasn't changed. It has been declared as freeable and since that moment
> nobody can rely on the content because it might have been discarded.
> Or put simply, the content is undefined. It is responsibility of the
> madvise caller to make sure that the object is not in active use while
> it is marking it.
> 
> > My point is that kinds of *hints* are always racy so any synchronization
> > couldn't help a lot. That's why I want to restrict hints process_madvise
> > supports as such kinds of non-destruptive one at next respin.
> 
> I agree that a non-destructive operations are safer against paralel
> modifications because you just get a annoying and unexpected latency at
> worst case. But we should discuss whether this assumption is sufficient
> for further development. I am pretty sure once we open remote madvise
> people will find usecases for destructive operations or even new madvise
> modes we haven't heard of. What then?

I support Daniel's vma seq number approach for the future plan.
