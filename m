Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B01261FD66D
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2020 22:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFQUxO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 17 Jun 2020 16:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgFQUxN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 17 Jun 2020 16:53:13 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8E2B2073E;
        Wed, 17 Jun 2020 20:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592427193;
        bh=fn2yk/yFjARGWSEFsjLDcqp5WNIOynxfyeyLoNcKW+k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HjDClTRvr8xAI8oqRuscDf1288YkY+vBcA9xL8LlWBqGpFC63d80YZKXAwaGmhu1K
         yGOghB/CWY2PlFivh46jtSNKt6QlJIjws2MSND/pfhsIvwOdqe4tW1IP4F5Hkv0qqi
         3kZqLpHGln4q7kjDM/Ap/jAyMTb1W6Y2n8fXtibc=
Date:   Wed, 17 Jun 2020 13:53:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nitin Gupta <nigupta@nvidia.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Nitin Gupta <ngupta@nitingupta.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v8] mm: Proactive compaction
Message-Id: <20200617135312.4f395479454c55a8d021b023@linux-foundation.org>
In-Reply-To: <20200616204527.19185-1-nigupta@nvidia.com>
References: <20200616204527.19185-1-nigupta@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 16 Jun 2020 13:45:27 -0700 Nitin Gupta <nigupta@nvidia.com> wrote:

> For some applications, we need to allocate almost all memory as
> hugepages. However, on a running system, higher-order allocations can
> fail if the memory is fragmented. Linux kernel currently does on-demand
> compaction as we request more hugepages, but this style of compaction
> incurs very high latency. Experiments with one-time full memory
> compaction (followed by hugepage allocations) show that kernel is able
> to restore a highly fragmented memory state to a fairly compacted memory
> state within <1 sec for a 32G system. Such data suggests that a more
> proactive compaction can help us allocate a large fraction of memory as
> hugepages keeping allocation latencies low.
>
> ...
>

All looks straightforward to me and easy to disable if it goes wrong.

All the hard-coded magic numbers are a worry, but such is life.

One teeny complaint:

>
> ...
>
> @@ -2650,12 +2801,34 @@ static int kcompactd(void *p)
>  		unsigned long pflags;
>  
>  		trace_mm_compaction_kcompactd_sleep(pgdat->node_id);
> -		wait_event_freezable(pgdat->kcompactd_wait,
> -				kcompactd_work_requested(pgdat));
> +		if (wait_event_freezable_timeout(pgdat->kcompactd_wait,
> +			kcompactd_work_requested(pgdat),
> +			msecs_to_jiffies(HPAGE_FRAG_CHECK_INTERVAL_MSEC))) {
> +
> +			psi_memstall_enter(&pflags);
> +			kcompactd_do_work(pgdat);
> +			psi_memstall_leave(&pflags);
> +			continue;
> +		}
>  
> -		psi_memstall_enter(&pflags);
> -		kcompactd_do_work(pgdat);
> -		psi_memstall_leave(&pflags);
> +		/* kcompactd wait timeout */
> +		if (should_proactive_compact_node(pgdat)) {
> +			unsigned int prev_score, score;

Everywhere else, scores have type `int'.  Here they are unsigned.  How come?

Would it be better to make these unsigned throughout?  I don't think a
score can ever be negative?

> +			if (proactive_defer) {
> +				proactive_defer--;
> +				continue;
> +			}
> +			prev_score = fragmentation_score_node(pgdat);
> +			proactive_compact_node(pgdat);
> +			score = fragmentation_score_node(pgdat);
> +			/*
> +			 * Defer proactive compaction if the fragmentation
> +			 * score did not go down i.e. no progress made.
> +			 */
> +			proactive_defer = score < prev_score ?
> +					0 : 1 << COMPACT_MAX_DEFER_SHIFT;
> +		}
>  	}

