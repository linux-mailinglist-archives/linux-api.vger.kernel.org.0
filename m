Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E3C28E68D
	for <lists+linux-api@lfdr.de>; Wed, 14 Oct 2020 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgJNSjs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Oct 2020 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730272AbgJNSjs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Oct 2020 14:39:48 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A85C061755;
        Wed, 14 Oct 2020 11:39:47 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so213651pjb.5;
        Wed, 14 Oct 2020 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NH5urOcy6c6c7U4nE2ctki4Ov521XyxV+9elVLTe53k=;
        b=ljjUBHvD9onxp1gRCJrEBhb0tdHVp8S71mYcEA5XYCz4Rhycv80d2h0TNWdFnZIIoL
         fTq+20VgUsTeou8V8x/eRwjfy1Z4ZgUEti0xXp+hqBDKTuIwfJvXf1ilf6gpPrTX+/5z
         bxnNYkQEr3EmDy7DbGRsK2+h/bf2blPJSsaIRE6CXM83dqKfkEftHUtyb63cZ5gd+BiB
         TMGaeDgrKgSNkVtzuh06CPpV2IdsQy3mZWKFj+vQPQ0EVkbi2htUZ2cpRfbQAVKgr7pA
         cjyLOY2ie7XcjfJFC+baHNO/TCCXnrCpLeDGRvcFW9ty4iOO1AfLotqQDHRnupTYTOtU
         QJ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NH5urOcy6c6c7U4nE2ctki4Ov521XyxV+9elVLTe53k=;
        b=a9U+mAgHctAzsF78XeO+qLb2gpToGQkxyJZM+Yp+zH0hz/iwRm9QaK+NySvndaiFd1
         LuXiJrUOQb+RkipJsN9NBDBybFmm8Gzlx/OZEMcKLsDI4l423BwTAjVhzHOgnJIVWsfS
         SKSy1YkazE8eesb3qWRVchxl+cMmeoeZk2JnGkD0SzamsXy7Eh5uyAR4Q0ooEwAnEbs9
         keLfW5b/WBKPJrzLeF6dQ7gPYaTDdJbUa+z+G5yLBoYikD4QqJI0atkKQTUhdyvd62ih
         kVHh4NUtaWNWzNUXPP/fqNJjps/ruIKkapUrk9JOTCgCHwVhl2TrnBcbJSji9e/iKwpe
         OEgQ==
X-Gm-Message-State: AOAM530932dIEw3V5eXxRPqOME8z/XTCk1i8Fb63758Ore/s3nt2jzpg
        BSqF/D1z8oVu5/RTqIB+cn8=
X-Google-Smtp-Source: ABdhPJwJRebcnF/K6rXv4Pvhn7mjLRUX1W19rCgciAw9z+AVgh4JoWoSHdM40MH8mmAfl3iv8UEsPA==
X-Received: by 2002:a17:90a:474c:: with SMTP id y12mr502073pjg.150.1602700787366;
        Wed, 14 Oct 2020 11:39:47 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id q24sm371251pfn.72.2020.10.14.11.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 11:39:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 14 Oct 2020 11:39:43 -0700
From:   minchan@kernel.org
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, linux-api@vger.kernel.org,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        kernel-team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [RFC]: userspace memory reaping
Message-ID: <20201014183943.GA1489464@google.com>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 14, 2020 at 09:57:20AM -0700, Suren Baghdasaryan wrote:
> On Wed, Oct 14, 2020 at 5:09 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > [Sorry for a late reply]
> >
> > On Mon 14-09-20 17:45:44, Suren Baghdasaryan wrote:
> > > + linux-kernel@vger.kernel.org
> > >
> > > On Mon, Sep 14, 2020 at 5:43 PM Suren Baghdasaryan <surenb@google.com> wrote:
> > > >
> > > > Last year I sent an RFC about using oom-reaper while killing a
> > > > process: https://patchwork.kernel.org/cover/10894999. During LSFMM2019
> > > > discussion https://lwn.net/Articles/787217 a couple of alternative
> > > > options were discussed with the most promising one (outlined in the
> > > > last paragraph of https://lwn.net/Articles/787217) suggesting to use a
> > > > remote version of madvise(MADV_DONTNEED) operation to force memory
> > > > reclaim of a killed process. With process_madvise() making its way
> > > > through reviews (https://patchwork.kernel.org/patch/11747133/), I
> > > > would like to revive this discussion and get feedback on several
> > > > possible options, their pros and cons.
> >
> > Thanks for reviving this!
> 
> Thanks for your feedback!
> 
> >
> > > > The need is similar to why oom-reaper was introduced - when a process
> > > > is being killed to free memory we want to make sure memory is freed
> > > > even if the victim is in uninterruptible sleep or is busy and reaction
> > > > to SIGKILL is delayed by an unpredictable amount of time. I
> > > > experimented with enabling process_madvise(MADV_DONTNEED) operation
> > > > and using it to force memory reclaim of the target process after
> > > > sending SIGKILL. Unfortunately this approach requires the caller to
> > > > read proc/pid/maps to extract the list of VMAs to pass as an input to
> > > > process_madvise().
> >
> > Well I would argue that this is not really necessary. You can simply
> > call process_madvise with the full address range and let the kernel
> > operated only on ranges which are safe to tear down asynchronously.
> > Sure that would require some changes to the existing code to not fail
> > on those ranges if they contain incompatible vmas but that should be
> > possible. If we are worried about backward compatibility then a
> > dedicated flag could override.
> >
> 
> IIUC this is very similar to the last option I proposed. I think this
> is doable if we treat it as a special case. process_madvise() return
> value not being able to handle a large range would still be a problem.
> Maybe we can return MAX_INT in those cases?

Or, maybe we could just return 0 if the operation succeeds without any
error.

> 
> > [...]
> >
> > > > While the objective is to guarantee forward progress even when the
> > > > victim cannot terminate, we still want this mechanism to be efficient
> > > > because we perform these operations to relieve memory pressure before
> > > > it affects user experience.
> > > >
> > > > Alternative options I would like your feedback are:
> > > > 1. Introduce a dedicated process_madvise(MADV_DONTNEED_MM)
> > > > specifically for this case to indicate that the whole mm can be freed.
> >
> > This shouldn't be any different from madvise on the full address range,
> > right?
> >
> 
> Yep, just a matter of choosing the most appropriate API.


I agree full range or just NULL passing to indicate entire address
space would be better than introducing a new advise in that we could
avoid MADV_PAGEOUT_MM, MADV_COLD_MM.

> 
> > > > 2. A new syscall to efficiently obtain a vector of VMAs (start,
> > > > length, flags) of the process instead of reading /proc/pid/maps. The
> > > > size of the vector is still limited by UIO_MAXIOV (1024), so several
> > > > calls might be needed to query larger number of VMAs, however it will
> > > > still be an order of magnitude more efficient than reading
> > > > /proc/pid/maps file in 4K or smaller chunks.
> >
> > While this might be interesting for other usecases - userspace memory
> > management in general - I do not think it is directly related to this
> > particular feature.
> >
> 
> True but such a syscall would be useful for other use cases, like
> MADV_COLD/MADV_PAGEOUT that Minchan was working on. Maybe we can kill
> more than one bird here? Minchan, any thought?

Generally, it could be helpful but I don't see it as desperate at this
moment.
