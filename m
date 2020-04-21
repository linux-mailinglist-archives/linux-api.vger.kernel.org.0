Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33F51B1CC0
	for <lists+linux-api@lfdr.de>; Tue, 21 Apr 2020 05:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgDUD0R (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 23:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:42352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgDUD0R (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 Apr 2020 23:26:17 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F198206F9;
        Tue, 21 Apr 2020 03:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587439576;
        bh=FX6uG5F8AzQ1flbZ2fXf08M3XCLcX/I/Er+4aPB3lI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MoKVQvI+tqfAlfk+k0e77LTTf38deWd0xVvaRxd057+hRHlzNUBxbRIj2MifWjAjH
         TOygngigqi31EUrMLsYSzKs83kBCvJNSLmOwP/20UtlfXj6L97YhQY6mh7yfGaug7/
         ISY3AbK77ACPfsmSBfz4AZujkOsgvHgKClnDqlwE=
Date:   Mon, 20 Apr 2020 20:26:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <nitin@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v3] mm: Proactive compaction
Message-Id: <20200420202615.daa216426294e842cb0b523c@linux-foundation.org>
In-Reply-To: <20200310222539.1981-1-nigupta@nvidia.com>
References: <20200310222539.1981-1-nigupta@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 10 Mar 2020 15:25:39 -0700 Nitin Gupta <nigupta@nvidia.com> wrote:

> For some applications we need to allocate almost all memory as
> hugepages. However, on a running system, higher order allocations can
> fail if the memory is fragmented. Linux kernel currently does on-demand
> compaction as we request more hugepages but this style of compaction
> incurs very high latency. Experiments with one-time full memory
> compaction (followed by hugepage allocations) shows that kernel is able
> to restore a highly fragmented memory state to a fairly compacted memory
> state within <1 sec for a 32G system. Such data suggests that a more
> proactive compaction can help us allocate a large fraction of memory as
> hugepages keeping allocation latencies low.

hn, there was plenty of feedback for earlier versions, but then
everyone went quiet.  I guess it's time for a refresh and resend,
please.

With some code comments, please!  Is the code really so self-evident
that this:

+/* Compact all zones within a node according to proactiveness */

is the only thing which needs to be said about it?  How is the reader
to know what proactive compaction actually *is*?

What does extfrag_for_order() do and what does its return value mean?

Please document /sys/kernel/mm/compaction/proactiveness in the
appropriate place under Documentation/

