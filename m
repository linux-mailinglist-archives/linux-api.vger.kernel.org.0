Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C3F3C7E06
	for <lists+linux-api@lfdr.de>; Wed, 14 Jul 2021 07:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237911AbhGNFp4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 01:45:56 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48684 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237903AbhGNFpz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jul 2021 01:45:55 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A8A1A2025B;
        Wed, 14 Jul 2021 05:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626241380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w0Zh1FaNIeHmI9GVj8h2vOVAdae8z/pZJcGsHZc1oV8=;
        b=Vm0o20M9JWN9Xa1tHFXAYZoOfGor4yHhrSmk3IT7mvZ0cQsvBaakMH46b2IpiVCbW6dwtI
        qjpX785zHJZ/xymUSAwNsdx05/G2IMHml0rtJiKM9LW7a+RkzRvJTq9ahbmIcLpu4eOfJB
        yHHtk7a9u6W8E3s+aWVFQlO7usYinQc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 77F9CA3B81;
        Wed, 14 Jul 2021 05:43:00 +0000 (UTC)
Date:   Wed, 14 Jul 2021 07:43:00 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Evan Green <evgreen@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
Message-ID: <YO55ZIrgkLXI4BbS@dhcp22.suse.cz>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
 <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 12-07-21 09:41:26, David Hildenbrand wrote:
> On 12.07.21 09:03, Michal Hocko wrote:
> > [Cc linux-api]
> > 
> > On Fri 09-07-21 10:50:48, Evan Green wrote:
> > > Currently it's not possible to enable hibernation without also enabling
> > > generic swap for a given swap area. These two use cases are not the
> > > same. For example there may be users who want to enable hibernation,
> > > but whose drives don't have the write endurance for generic swap
> > > activities.
> > > 
> > > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > > generic swapping to it. This region can still be wired up for use in
> > > suspend-to-disk activities, but will never have regular pages swapped to
> > > it.
> > 
> > Could you expand some more on why a strict exclusion is really
> > necessary? I do understand that one might not want to have swap storage
> > available all the time but considering that swapon is really a light
> > operation so something like the following should be a reasonable
> > workaround, no?
> > 	swapon storage/file
> > 	s2disk
> > 	swapoff storage
> 
> I'm certainly not a hibernation expert, but I'd guess this can also be
> triggered by HW events, so from the kernel and not only from user space
> where your workaround would apply.

Is there anything preventing such a HW event doing the equivalent of the
above?
-- 
Michal Hocko
SUSE Labs
