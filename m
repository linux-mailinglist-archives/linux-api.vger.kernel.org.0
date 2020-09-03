Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDD625C81D
	for <lists+linux-api@lfdr.de>; Thu,  3 Sep 2020 19:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgICRfJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Sep 2020 13:35:09 -0400
Received: from albireo.enyo.de ([37.24.231.21]:40558 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICRfJ (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Sep 2020 13:35:09 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kDt8U-0004Wm-Jl; Thu, 03 Sep 2020 17:34:58 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kDt8U-00087R-Fu; Thu, 03 Sep 2020 19:34:58 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
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
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall: an external memory hinting API
References: <20200901000633.1920247-1-minchan@kernel.org>
        <20200901000633.1920247-4-minchan@kernel.org>
        <87blippc7p.fsf@mid.deneb.enyo.de>
        <20200903172618.GB1959033@google.com>
Date:   Thu, 03 Sep 2020 19:34:58 +0200
In-Reply-To: <20200903172618.GB1959033@google.com> (Minchan Kim's message of
        "Thu, 3 Sep 2020 10:26:18 -0700")
Message-ID: <87pn72lq65.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Minchan Kim:

> On Tue, Sep 01, 2020 at 08:46:02PM +0200, Florian Weimer wrote:
>> * Minchan Kim:
>> 
>> >       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>> >                 unsigned long vlen, int advice, unsigned int flags);
>> 
>> size_t for vlen provides a clearer hint regarding the type of special
>> treatment needed for ILP32 here (zero extension, not changing the type
>> to long long).
>> 
>
> All existing system calls using iove in Linux uses unsigned long so
> I want to be consistent with them unless process_madvise need something
> speicial.

Userspace uses int, following POSIX (where applicable).  There is no
consistency to be had here.
