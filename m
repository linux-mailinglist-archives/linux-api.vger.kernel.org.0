Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130A53D81A1
	for <lists+linux-api@lfdr.de>; Tue, 27 Jul 2021 23:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhG0VUK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Jul 2021 17:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235006AbhG0VT2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Jul 2021 17:19:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 164DA60FED;
        Tue, 27 Jul 2021 21:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1627420713;
        bh=vrsuZUHarGNvf9RdkDQpMyk5mA0/4F4hlnHq6SdM+Yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qoIRcerJm+iTqJT9RloyT7tYKD6oJtvJujrDY8t/CzTccbun57NT0AcoKigxcEjGx
         Md+6GcyQ1Vlwhsv1TZQuW0bkvZ5yVMEo8ZTuJJPYgm31Aa6/RrtCAA2v3CNr6nMyYf
         k8B81r2ZMW3WQgfd61GdIQuR4X6iJlorspY+PtRE=
Date:   Tue, 27 Jul 2021 14:18:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Pavel Machek <pavel@ucw.cz>,
        linux-api@vger.kernel.org, Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Minchan Kim <minchan@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v4] mm: Enable suspend-only swap spaces
Message-Id: <20210727141832.86695e7181eb10c6e8fd0191@linux-foundation.org>
In-Reply-To: <CAE=gft7567-2Lq7raJKrOpQ8UAvXTFWwPci=_GCRPET3nS=9SA@mail.gmail.com>
References: <20210726171106.v4.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
        <d6668437-5c3b-2dff-bb95-4e3132d13711@redhat.com>
        <6ff28cfe-1107-347b-0327-ad36e256141b@redhat.com>
        <CAE=gft7567-2Lq7raJKrOpQ8UAvXTFWwPci=_GCRPET3nS=9SA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 27 Jul 2021 09:31:33 -0700 Evan Green <evgreen@chromium.org> wrote:

> > Pavel just mentioned uswsusp, and I wonder if it would be a possible
> > alternative to this patch.
> 
> I think you're right that it would be possible to isolate the
> hibernate image with uswsusp if you avoid using the SNAPSHOT_*SWAP*
> ioctls. But I'd expect performance to suffer noticeably, since now
> every page is making a round trip out to usermode and back. I'd still
> very much use the HIBERNATE_ONLY flag if it were accepted, I think
> there's value to it.

The uswsusp option makes your patch a performance optimization rather
than a feature-add.  And we do like to see quantitative testing results
when considering a performance optimization.  Especially when the
performance optimization is a bit icky, putting special-case testing
all over the place, maintenance cost, additional testing effort, etc.

I do think that diligence demands that we quantify the difference.  Is
this a thing you can help with?
