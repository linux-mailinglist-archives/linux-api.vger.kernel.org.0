Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E231CBB0C
	for <lists+linux-api@lfdr.de>; Sat,  9 May 2020 01:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEHXER (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 May 2020 19:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:47376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgEHXER (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 8 May 2020 19:04:17 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C190208DB;
        Fri,  8 May 2020 23:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588979056;
        bh=AqLynUwQ51zN07t3YqDgkNGcT5K3FLB+CukBeZhLq98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iuutN3iviKQPxE9c89Nx6lLRcAGHl5P6ObTVn+J4JMJKLVBT+frvae/ZauOSfLDe4
         Xh5umy4EUykz8LoU4D/7eRyPZgBcLFVERkU/Lo/IzzDsuzMwAm/NKpFgJjwE33S18V
         eROfy6Ro5YQbqyaL9xkp8q+yyf+qIqyEvnn6MC2o=
Date:   Fri, 8 May 2020 16:04:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
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
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH v7 5/7] mm: support both pid and pidfd for
 process_madvise
Message-Id: <20200508160415.65ff359a9e312c613336587b@linux-foundation.org>
In-Reply-To: <20200508183653.GB125527@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
        <20200302193630.68771-6-minchan@kernel.org>
        <14089609-5fb1-b082-716f-c2e129d27c48@suse.cz>
        <20200311004251.GB87930@google.com>
        <20200508183653.GB125527@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 8 May 2020 11:36:53 -0700 Minchan Kim <minchan@kernel.org> wrote:

> 
> ...
>
> Per Vlastimil's request, I changed "which and advise" with "idtype and
> advice" in function prototype of description.
> Could you replace the part in the description? Code is never changed.
> 

Done, but...

>
> ...
>
> There is a demand[1] to support pid as well pidfd for process_madvise to
> reduce unnecessary syscall to get pidfd if the user has control of the
> target process(ie, they could guarantee the process is not gone or pid is
> not reused).
> 
> This patch aims for supporting both options like waitid(2).  So, the
> syscall is currently,
> 
>         int process_madvise(idtype_t idtype, id_t id, void *addr,
>                 size_t length, int advice, unsigned long flags);
> 
> @which is actually idtype_t for userspace libray and currently, it
> supports P_PID and P_PIDFD.

What does "@which is actually idtype_t for userspace libray" mean?  Can
you clarify and expand?

Also, does this userspace library exist?  If so, where is it?

>
> ...
>
