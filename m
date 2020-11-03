Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958D52A57E4
	for <lists+linux-api@lfdr.de>; Tue,  3 Nov 2020 22:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgKCVqs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Nov 2020 16:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgKCVqr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Nov 2020 16:46:47 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF5C0613D1;
        Tue,  3 Nov 2020 13:46:47 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id i26so14746886pgl.5;
        Tue, 03 Nov 2020 13:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PpGGoZmrXkX7f7f0JV0lFNqK/EDCekB1Ge7X3zSkxQ=;
        b=kEeTJrqmvvtmnfuCU25YIXiE75LlH9tArKhnwsc2sNhwLkYnILuVtw9gxIpPueUcLz
         +UhpHM+8MvKpX4Orvj43d4S3r51vEAyQ1gUNVYsGapQWX9TwQXlcrpdLX6gnv2IFjMXi
         Fe7/EULFy8TjBYL5q4leSQiJjp5jAvEUHwq/O2mAOx72N43uJLG1+Z8qQwUoteP8xpfS
         AZjXh83p+5lI+DPL8KJFaHotFr8YillaPC3SUdgj4iHXqmN2Tm3+IAm1ofHM9BfKRBSI
         Rf499CT/1qCra9AovZnxdb8CfC/Qe99XBfXKR05qFdQqv870zcZCSt8JnB9e5ufxaINM
         wFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1PpGGoZmrXkX7f7f0JV0lFNqK/EDCekB1Ge7X3zSkxQ=;
        b=gbbAqpqhnahr2OLtCyx8f0LO9b2Z6gRBrUUtXE0KockpYcpJxo9PZb4zp9OCh5ldcb
         TNgZtEATtv2765BUpttyeGMhaQ9/MvOrutHTvySFT8TpvOdQLFUkOAMhrFnO3FVcF4pH
         8slBgnH9Erz9FddLsqUWopJ4Llu2OC5GyN9C5Uj50CbpQRJa4r+hl/zraZF7m2vNXDM0
         1YpJGo5Mj0fjwwIQH/rSr7HXO5VwJOTWt/DAJa/P85j5y8HCXuTiOh4NJuTBlVFcJWu5
         1jMdkBRXhvS6tduYAf2574VVM6P0sQIhFjMz6tQOm/9jE8pCoV4Rzto55VG0ekaYIBfK
         9F9g==
X-Gm-Message-State: AOAM532QHInc5yAGXosIBYOMBnd2z8BnGzqq/gyCV9g1/+AugAo9sBGX
        8T2VcWN8fz1T52+l2i4e85polVLyx1o=
X-Google-Smtp-Source: ABdhPJyy0fb2Z4Agy9VQCUvcVqCyWVPKfTl3LIjTFXE6g/dHUpqtCBFeVLRcCo71EdONI96MLiTafw==
X-Received: by 2002:a17:90b:1081:: with SMTP id gj1mr1204800pjb.15.1604440006238;
        Tue, 03 Nov 2020 13:46:46 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id 92sm103966pjv.32.2020.11.03.13.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 13:46:44 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 Nov 2020 13:46:40 -0800
From:   Minchan Kim <minchan@kernel.org>
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
Message-ID: <20201103214532.GC1631979@google.com>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
 <CAJuCfpHwXcq1PfzHgqyYBR3N53TtV2WMt_Oubz0JZkvJHbFKGw@mail.gmail.com>
 <CAJuCfpH9iUt0cs1GBQppgdcD8chojCNXk22S+PeSgQ-bA7iitQ@mail.gmail.com>
 <20201103093550.GE21990@dhcp22.suse.cz>
 <20201103213228.GB1631979@google.com>
 <CAJuCfpELVYSNsjnXvg7pXQiwMBYpffcy5aNqj84t70-qN1XYiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpELVYSNsjnXvg7pXQiwMBYpffcy5aNqj84t70-qN1XYiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 03, 2020 at 01:40:41PM -0800, Suren Baghdasaryan wrote:
> On Tue, Nov 3, 2020 at 1:32 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > On Tue, Nov 03, 2020 at 10:35:50AM +0100, Michal Hocko wrote:
> > > On Mon 02-11-20 12:29:24, Suren Baghdasaryan wrote:
> > > [...]
> > > > To follow up on this. Should I post an RFC implementing SIGKILL_SYNC
> > > > which in addition to sending a kill signal would also reap the
> > > > victim's mm in the context of the caller? Maybe having some code will
> > > > get the discussion moving forward?
> > >
> > > Yeah, having a code, even preliminary, might help here. This definitely
> > > needs a good to go from process management people as that proper is land
> > > full of surprises...
> >
> > Just to remind a idea I suggested to reuse existing concept
> >
> >     fd = pidfd_open(victim process)
> >     fdatasync(fd);
> >     close(fd);
> >
> 
> Yep, I just posted a comment about that. I think though your above
> sequence is missing a pidfd_send_signal(fd, SIGKILL) before the
> fdatasync(fd)...
> Not sure if fdatasync(pidfd) or fsync(pidfd) would be more appropriate
> for this but will use one and we can discuss details in the RFC with
> the code.

IMO, fdatasync would be better symantic since fsync invovles metadata
(i.e., task_struct, mm_struct and so on). I think what you need is
just pages attached to address_space, which sounds like data, not
metadata. 
