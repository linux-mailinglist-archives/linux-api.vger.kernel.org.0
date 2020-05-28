Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BCE1E5BBC
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2020 11:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgE1JWs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 May 2020 05:22:48 -0400
Received: from mail.itouring.de ([188.40.134.68]:57880 "EHLO mail.itouring.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728161AbgE1JWs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 28 May 2020 05:22:48 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 05:22:47 EDT
Received: from tux.applied-asynchrony.com (p5b07e2b3.dip0.t-ipconnect.de [91.7.226.179])
        by mail.itouring.de (Postfix) with ESMTPSA id E0EF54160EC1;
        Thu, 28 May 2020 11:15:10 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
        by tux.applied-asynchrony.com (Postfix) with ESMTP id 4B903F01600;
        Thu, 28 May 2020 11:15:10 +0200 (CEST)
Subject: Re: [PATCH v5] mm: Proactive compaction
To:     Nitin Gupta <nigupta@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20200518181446.25759-1-nigupta@nvidia.com>
From:   =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <27b39956-2a21-8eef-8ebb-cb3a93a41a36@applied-asynchrony.com>
Date:   Thu, 28 May 2020 11:15:10 +0200
MIME-Version: 1.0
In-Reply-To: <20200518181446.25759-1-nigupta@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org


On 5/18/20 8:14 PM, Nitin Gupta wrote:
[patch v5 :)]

I've been successfully using this in my tree and it works great, but a friend
who also uses my tree just found a bug (actually an improvement ;) due to the
change from HUGETLB_PAGE_ORDER to HPAGE_PMD_ORDER in v5.

When building with CONFIG_TRANSPARENT_HUGEPAGE=n (for some reason it was off)
HPAGE_PMD_SHIFT expands to BUILD_BUG() and compilation fails like this:

...
./include/linux/huge_mm.h:284:28: note: in expansion of macro ‘BUILD_BUG’
   284 | #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
       |                            ^~~~~~~~~
./include/linux/huge_mm.h:78:26: note: in expansion of macro ‘HPAGE_PMD_SHIFT’
    78 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
       |                          ^~~~~~~~~~~~~~~
mm/compaction.c:1874:28: note: in expansion of macro ‘HPAGE_PMD_ORDER’
  1874 |    extfrag_for_order(zone, HPAGE_PMD_ORDER);
       |                            ^~~~~~~~~~~~~~~
...

It would be great if the whole thing would compile without THP; the only
occurrence is in fragmentation_score_zone(). Unfortunately I'm not familiar
enough with how to properly check for THP and properly calculate whatever
you're doing there, otherwise I would ifdef this away myself. ;)

Thanks for an otherwise great patch!

cheers,
Holger
