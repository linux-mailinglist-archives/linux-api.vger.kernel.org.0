Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323D728F8CF
	for <lists+linux-api@lfdr.de>; Thu, 15 Oct 2020 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbgJOSnz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 15 Oct 2020 14:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731154AbgJOSnz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 15 Oct 2020 14:43:55 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532AC061755;
        Thu, 15 Oct 2020 11:43:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f19so2544664pfj.11;
        Thu, 15 Oct 2020 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xV+ZkBNMWugBuC3oFzXT5UBZRM8reU/hX0mycgZbUE0=;
        b=JIOfP6QyLkJwJ+mlZ9xwHJKJyiUhBMF//TdMIdMRFRReUuQ1+XyXZB6RDX36HjEVOB
         EYVjdMqy50q2hiyDvGgCcfk4ffeblCmtxPNKplTlkVGcVa0hc/5uSjw4rhFtt2dLNJo9
         NLxIKAQcCtyYKb9UloN9yUAgzRn13IHvwmjs6enToUhXof3kxZnC1mQjpuO+CgmCwMKv
         gCo+kssxju3VdQzcexK02yvCa6u4s24sZbgNQeXyzLQ0WrNCREFQGSvUJ5PYha/mgH+t
         wMy9McRom8YWqXGeUyiD8mUO1ZOONsrjrv47gC7n/5iM8SkxEhI0lYRbkBLXgDFCgh5W
         UONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xV+ZkBNMWugBuC3oFzXT5UBZRM8reU/hX0mycgZbUE0=;
        b=bbZFONxk/d1okMgPiz0X5uhCqlP+jEf9OglXNEyDspTFCMEpYi9pQ0E4CK3aPUlGWP
         mVcLPJzaOeE1dchFihO2IzBCJAc7GnLgkekz2NCURlwzt0GfNPZonCR/cQmeyKg1tj3d
         nnlbKDd6BKFYWdejsiuS5wpwYZcM4wEC9o1Obu/+vmMV4fXFXrcMZk7Hyn9vfeQ/QK/W
         DgAIbbi49tPNSAYrzx+VpAbdDOBkjcxzoGFsvn0yAVefX0KhskQY5fRiytTWQMu0dF0g
         4nt+ZN2xaA2HSxRzHRMhGlEXh/FapCCb0j/+MwypSNHTwRgU/9OyTcXhmefY7uNYQFog
         766A==
X-Gm-Message-State: AOAM532ANsxOucB7OtBWSN9bYrWCIvEYZThbablNx57+el5igJuEOBRb
        oeF/z6wfGjKbD0tU4YizQUo=
X-Google-Smtp-Source: ABdhPJzg1f36S7JBkpfzKfIJO9S7c1n4KYwgjLfZuKaKPBDCRuiD6ZZepcgfH4pFu1/2tQ79DGQkag==
X-Received: by 2002:a63:3588:: with SMTP id c130mr176425pga.200.1602787432849;
        Thu, 15 Oct 2020 11:43:52 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id m19sm2400131pgn.93.2020.10.15.11.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 11:43:51 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 15 Oct 2020 11:43:49 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-api@vger.kernel.org,
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
Message-ID: <20201015184349.GA3930989@google.com>
References: <CAJuCfpGz1kPM3G1gZH+09Z7aoWKg05QSAMMisJ7H5MdmRrRhNQ@mail.gmail.com>
 <CAJuCfpGjuUz5FPpR5iQ7oURJAhnP1ffBAnERuTUp9uPxQCRhDg@mail.gmail.com>
 <20201014120937.GC4440@dhcp22.suse.cz>
 <CAJuCfpEQ_ADYsMrF_zjfAeQ3d-FALSP+CeYsvgH2H1-FSoGGqg@mail.gmail.com>
 <20201015092030.GB22589@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015092030.GB22589@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 15, 2020 at 11:20:30AM +0200, Michal Hocko wrote:

> > > I do have a vague recollection that we have discussed a kill(2) based
> > > approach as well in the past. Essentially SIG_KILL_SYNC which would
> > > not only send the signal but it would start a teardown of resources
> > > owned by the task - at least those we can remove safely. The interface
> > > would be much more simple and less tricky to use. You just make your
> > > userspace oom killer or potentially other users call SIG_KILL_SYNC which
> > > will be more expensive but you would at least know that as many
> > > resources have been freed as the kernel can afford at the moment.
> > 
> > Correct, my early RFC here
> > https://patchwork.kernel.org/project/linux-mm/patch/20190411014353.113252-3-surenb@google.com
> > was using a new flag for pidfd_send_signal() to request mm reaping by
> > oom-reaper kthread. IIUC you propose to have a new SIG_KILL_SYNC
> > signal instead of a new pidfd_send_signal() flag and otherwise a very
> > similar solution. Is my understanding correct?
> 
> Well, I think you shouldn't focus too much on the oom-reaper aspect
> of it. Sure it can be used for that but I believe that a new signal
> should provide a sync behavior. People more familiar with the process
> management would be better off defining what is possible for a new sync
> signal.  Ideally not only pro-active process destruction but also sync
> waiting until the target process is released so that you know that once
> kill syscall returns the process is gone.

If we approach with signal, I am not sure we need to create new signal
rather than pidfd and fsync(2) semantic.

Furthermore, process_madvise makes the work in the caller context but
signal might work somewhere else context depending on implemenation(
oom reaper or CPU resumed the task). I am not sure it it fulfils Suren's
requirement.

One more thing to think over: Even though we spent some overhead to
read /proc/pid/maps, we could make zapping in parallel in userspace
with multi thread approach. I am not sure what's the win since Suren
also care about zapping performance.
