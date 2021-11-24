Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3964545CED8
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 22:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343493AbhKXVWw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 16:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbhKXVWw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 16:22:52 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3197BC061574;
        Wed, 24 Nov 2021 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zK/24Qkt+CUXxwWRIIvMb1Yuxk0SqsiVKxof3LAwFho=; b=FeDgrchxjCm0DOEFAH2BbOpgTw
        szmGevFWjVGMbpCgxid/aEmkreMVkqLgBu0Pzaqf6Kxg3JAKlRv5VGgFhtvXRz9pEDyfT0VH5dnVs
        V4RkmYJlIkaXuTcuhB7t3Z0TakccZfNV6JWWMqOofe35Lk9fPH138vuyMgZB43vqfIOFUAAm8HM+/
        8tywOU/SQEXrvmRc60nPvaSqZjquWKqLV+ZP4DOc8P50F25GD9Dr4wikzLxmP5f/Ltr1mmu3FTLrN
        SL5t2RvjCw1EaKGpd+1LOGqQyra45XXq7koQrBsfncTz/EnYktFdg6B18RQ3QxgDDHh647yDExmK+
        neBk2SBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpzft-000JqU-7K; Wed, 24 Nov 2021 21:19:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 178D5986843; Wed, 24 Nov 2021 22:19:28 +0100 (CET)
Date:   Wed, 24 Nov 2021 22:19:27 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <20211124211927.GG721624@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122211327.5931-4-posk@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Nov 22, 2021 at 01:13:24PM -0800, Peter Oskolkov wrote:

> +	 * Timestamp: a 46-bit CLOCK_MONOTONIC timestamp, at 16ns resolution.

> +static int umcg_update_state(u64 __user *state_ts, u64 *expected, u64 desired,
> +				bool may_fault)
> +{
> +	u64 curr_ts = (*expected) >> (64 - UMCG_STATE_TIMESTAMP_BITS);
> +	u64 next_ts = ktime_get_ns() >> UMCG_STATE_TIMESTAMP_GRANULARITY;

I'm still very hesitant to use ktime (fear the HPET); but I suppose it
makes sense to use a time base that's accessible to userspace. Was
MONOTONIC_RAW considered?

