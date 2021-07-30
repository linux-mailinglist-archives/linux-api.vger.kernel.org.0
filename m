Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C63DB922
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 15:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238824AbhG3NQP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jul 2021 09:16:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238801AbhG3NQP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Jul 2021 09:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627650970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T5n9htUTUEDNFMWHlREjCeA6Lm63re0yV9LYwhjCq4c=;
        b=U9JkZ5q8nwKB1qsez4t+MpAg+USf1zPUro/oPJhvd0tep0d91cudUwV2Z662U0kBywso1Y
        YCCIMmpPTwJmKqAT6DklDEJoKytbBT75KFzG78RpJJ5Ya/7diVkdhlDu5GPv8US2/lkHrr
        AqXKNsYzU60OqosLpGSIUUCnQAgsxwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-2AWqov1LPKuunWD90ncSHg-1; Fri, 30 Jul 2021 09:16:05 -0400
X-MC-Unique: 2AWqov1LPKuunWD90ncSHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5B50101C7DD;
        Fri, 30 Jul 2021 13:15:48 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4D3045D9D5;
        Fri, 30 Jul 2021 13:15:44 +0000 (UTC)
Date:   Fri, 30 Jul 2021 15:15:41 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Enable suspend-only swap spaces
Message-ID: <20210730131541.ighhjiazc4agehcy@ws.net.home>
References: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jul 26, 2021 at 05:12:46PM -0700, Evan Green wrote:
> Swap regions with SWAP_FLAG_HIBERNATE_ONLY set will not appear in
> /proc/meminfo under SwapTotal and SwapFree, since they are not usable as
> general swap. These regions do still appear in /proc/swaps.

Off-topic, /proc/swaps is in the same situation like /proc/mounts years ago ...

It does not provide all important information like SWAP_FLAG_DISCARD_PAGES
SWAP_FLAG_DISCARD_ONCE and SWAP_FLAG_HIBERNATE_ONLY flags. 

Users will not able to differentiate between regular and hibernate-only
devices in "swapon" or "cat /proc/swaps" output ;-(

It would be nice to have /proc/swapsinfo with extendible "flags" column.

 Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

