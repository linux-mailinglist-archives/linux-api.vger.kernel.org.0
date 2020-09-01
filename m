Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5228259E5A
	for <lists+linux-api@lfdr.de>; Tue,  1 Sep 2020 20:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgIASqZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Sep 2020 14:46:25 -0400
Received: from albireo.enyo.de ([37.24.231.21]:58188 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgIASqY (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 1 Sep 2020 14:46:24 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1kDBIB-00022C-08; Tue, 01 Sep 2020 18:46:03 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1kDBIA-0007dD-RY; Tue, 01 Sep 2020 20:46:02 +0200
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
Date:   Tue, 01 Sep 2020 20:46:02 +0200
In-Reply-To: <20200901000633.1920247-4-minchan@kernel.org> (Minchan Kim's
        message of "Mon, 31 Aug 2020 17:06:33 -0700")
Message-ID: <87blippc7p.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Minchan Kim:

>       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
>                 unsigned long vlen, int advice, unsigned int flags);

size_t for vlen provides a clearer hint regarding the type of special
treatment needed for ILP32 here (zero extension, not changing the type
to long long).
