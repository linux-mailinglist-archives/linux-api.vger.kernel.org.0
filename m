Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFA93C7FAF
	for <lists+linux-api@lfdr.de>; Wed, 14 Jul 2021 10:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238330AbhGNIDM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 14 Jul 2021 04:03:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47896 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238287AbhGNIDL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Jul 2021 04:03:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8EE0022823;
        Wed, 14 Jul 2021 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626249619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZA2FMKo94s4usb30QHwB12/TZioc1f+l11L4qEZdChg=;
        b=I5KeuLY0FF7OsP8T86dtLC+OVmDbMIJOOwGazCjrgeU26cVGVJ/QP6YvzJsAk/JPGVeVk+
        bGQaymcZeqYhc3qHGDry3Rp4jK3p9iUzXYqp3MWQn72FlwVYBJ7HH9e9IsMxXwA3kDVLiW
        7tB5+RSbNEy9moFZznhpeqZajyC5YNk=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1F2D3A3B90;
        Wed, 14 Jul 2021 08:00:19 +0000 (UTC)
Date:   Wed, 14 Jul 2021 10:00:19 +0200
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
Message-ID: <YO6Zk5wwpdqwwGUs@dhcp22.suse.cz>
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <YOvpVRSMJe8NQuS2@dhcp22.suse.cz>
 <30dddfb1-388c-a593-0987-73e821216da9@redhat.com>
 <YO55ZIrgkLXI4BbS@dhcp22.suse.cz>
 <b84dfb7b-9ae7-8cd7-ce65-0b1952e30e8e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b84dfb7b-9ae7-8cd7-ce65-0b1952e30e8e@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 14-07-21 09:51:13, David Hildenbrand wrote:
[...]
> Anyhow, the proposal here does not sound completely crazy to me, although
> it's unfortunate how we decided to mangle hibernation and swapping into the
> same mechanism originally; a different interface to active "hibernation only
> backends" would be cleaner than doing a "swapon ..." without swapping.

Completely agreed! And I suspect that a special swap flag just digs that
hole even deeper. While the flag might look simple enough now I am a bit
worried this will open traps in the future.

I am not saying the idea is crazy either, it is just a hack on top of
the existing hack and as such it requires a very good reasoning. So far
I have heard rather vague justification and I am especially curious
about the "no mixing with the regular swapout" concern. It might be very
well the case that there are more usecases which would benefit from it.
-- 
Michal Hocko
SUSE Labs
