Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E63C256583
	for <lists+linux-api@lfdr.de>; Sat, 29 Aug 2020 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgH2HCh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 29 Aug 2020 03:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgH2HCg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 29 Aug 2020 03:02:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73BC061236;
        Sat, 29 Aug 2020 00:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9U9dGK0bqJLSVOUuBWXaxoDilhxzVYEaDPKgn3CAclI=; b=YfaX1TJf7HA6uhNhJQiWhVOa96
        f0ehNVUSyn/j0g/TXrjTt2eoL7mJwEB4PB/JJiVMi5LP9i0Al6Caf4Lm0tnG4qPm+56zU1QgHO5KD
        zRUe6vhjo0W4XXSUuEeI/I+YhnlDlJDIpE0Vz0B3crHHkxS+LD7Ce5nKBERAGV3SrwNdc5jXEkH+L
        TT9HMk6Idvnye6juI2mrnxGfJz/Y9+Bftdi20lxWcnnRC5XMrPf7C8x6ilSfuCiEiXoBdRoCP3Rv1
        ADtVbrtSOnk1GeYxMvqzbU/Yz18EpXB8qaJ0Olsk4Ci3SFrP0SCj75p0juusf5HA04sAnypvPh5mq
        hT3wh4Ww==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBusg-0000WP-5C; Sat, 29 Aug 2020 07:02:30 +0000
Date:   Sat, 29 Aug 2020 08:02:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com,
        SeongJae Park <sj38.park@gmail.com>,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>,
        linux-man <linux-man@vger.kernel.org>
Subject: Re: [PATCH v8 3/4] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
Message-ID: <20200829070230.GA1099@infradead.org>
References: <20200622192900.22757-1-minchan@kernel.org>
 <20200622192900.22757-4-minchan@kernel.org>
 <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0Mnp2ekmX-BX9yr+N8fy2=gBtASELLXoa9uGSpSS9aOA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 28, 2020 at 07:40:08PM +0200, Arnd Bergmann wrote:
> Every syscall that passes an iovec seems to do this. If we make import_iovec()
> handle both cases directly, this syscall and a number of others can
> be simplified, and you avoid the x32 entry point I mentioned above

FYI, I do have a series that does this (even tested) and kills tons of
compat syscalls by that.  But by doing that I found the problem that
compat syscalls issued by io_uring don't trigger in_compat_syscall().
I need to go back to fixing the io_uring vs in_compat_syscall() issue
(probably for 5.9) and then submit the whole thing.
