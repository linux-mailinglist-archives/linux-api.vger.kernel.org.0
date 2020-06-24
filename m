Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BF1207C8C
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 22:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406346AbgFXUAX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 16:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405057AbgFXUAW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 16:00:22 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD2AC0613ED
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 13:00:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r18so1933777pgk.11
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 13:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=5YurFeVtpOYVU5ydoL231turNTDylhl9IHjAbz77sBw=;
        b=gWs5urKSO+LqscynzsA4J+eqJDJAkH3tBkO/pG55Oc9LA2+QH7HzKz59mo7MeJjWuA
         mHV8ue/sZhEXa1URsrmDcDoWlOQRSTObJrJ0pUXY18bYxN+PqJxQSWojEHkKh+sSGm69
         EpnYFjsRzGX8gaiG1z9pe3N+bBPuJP5/OeeS7Ur6RLDfJTaLz+4SA9lWHVsWESZFCUsk
         2Aqv6L/ksmqQ4MyfazkqCWL3lrp+4rUF80zaLggi8eCSlY45LK3yu1rlIpP9+wOW3Sca
         oHUxUOXSRdfuxo6LwI8Y6WIfWvP9GbplTXykfwm1oHvDKeeqkJidgASklLocXHn4hIHh
         e3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=5YurFeVtpOYVU5ydoL231turNTDylhl9IHjAbz77sBw=;
        b=AhOwQeSw5O1PplMpFWdgTuC/7PC7VToXS1lOAZHGRGHEItZdWFZ6KEfXB5kXZ9w3pG
         M1Lj7LEvcklzPLSfKf2bC3RRhxc/+tTu8jVyMtUJHC1se+yoo6+Ha7EKu9RNLm/YbKTY
         AQGmLMAJWlDTIB8NKy8uHXCvwrDNSMK/UlyoHd6CM7KgKPN4FHAMvvvZlcnY09WpIg3C
         k3GcBmZEKHPvTdacne1idQfanyGK9It4WPjrBKlWzVqWa8//X61uJzb4ECyLX0OlUBha
         15rQADitRL6knfSKRHgQRB7XknpFYfSshO0VEK5HZuW/SGY6UiMXZqoCqpBrAwVdTena
         rb4w==
X-Gm-Message-State: AOAM531ugLJ3atmCrv1cvXAndR/q5LM3AwSuDRBB+vz5rB9RpzDnwcQd
        tBNhN9QwBfjVPcu7h0GGznqhOw==
X-Google-Smtp-Source: ABdhPJwtCEeKNEgeuOqiSzvg6ETq9Fn+Wg6Tlrq7FOjqG9WiTiT2/ej2Zy1HmHG3Cm5ZR+WRObO1PQ==
X-Received: by 2002:aa7:8813:: with SMTP id c19mr32760795pfo.220.1593028821321;
        Wed, 24 Jun 2020 13:00:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id r7sm17649498pgu.51.2020.06.24.13.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:00:20 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:00:19 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Minchan Kim <minchan@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v8 1/4] mm/madvise: pass task and mm to do_madvise
In-Reply-To: <20200622192900.22757-2-minchan@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2006241255180.35388@chino.kir.corp.google.com>
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-2-minchan@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 22 Jun 2020, Minchan Kim wrote:

> Patch series "introduce memory hinting API for external process", v8.
> 
> Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API.  With
> that, application could give hints to kernel what memory range are
> preferred to be reclaimed.  However, in some platform(e.g., Android), the
> information required to make the hinting decision is not known to the app.
> Instead, it is known to a centralized userspace daemon(e.g.,
> ActivityManagerService), and that daemon must be able to initiate reclaim
> on its own without any app involvement.
> 
> To solve the concern, this patch introduces new syscall -
> process_madvise(2).  Bascially, it's same with madvise(2) syscall but it
> has some differences.
> 
> 1. It needs pidfd of target process to provide the hint
> 
> 2.  It supports only MADV_{COLD|PAGEOUT|MERGEABLE|UNMEREABLE} at this
>    moment.  Other hints in madvise will be opened when there are explicit
>    requests from community to prevent unexpected bugs we couldn't support.
> 
> 3.  Only privileged processes can do something for other process's
>    address space.
> 
> For more detail of the new API, please see "mm: introduce external memory
> hinting API" description in this patchset.
> 
> This patch (of 4):
> 
> In upcoming patches, do_madvise will be called from external process
> context so we shouldn't asssume "current" is always hinted process's
> task_struct.
> 
> Furthermore, we must not access mm_struct via task->mm, but obtain it
> via access_mm() once (in the following patch) and only use that pointer
> [1], so pass it to do_madvise() as well.  Note the vma->vm_mm pointers
> are safe, so we can use them further down the call stack.
> 
> And let's pass *current* and current->mm as arguments of do_madvise so
> it shouldn't change existing behavior but prepare next patch to make
> review easy.
> 
> Note: io_madvise passes NULL as target_task argument of do_madvise because
> it couldn't know who is target.
> 
> [1] http://lore.kernel.org/r/CAG48ez27=pwm5m_N_988xT1huO7g7h6arTQL44zev6TD-h-7Tg@mail.gmail.com
> 
> [vbabka@suse.cz: changelog tweak]
> [minchan@kernel.org: use current->mm for io_uring]
>   Link: http://lkml.kernel.org/r/20200423145215.72666-1-minchan@kernel.org
> [akpm@linux-foundation.org: fix it for upstream changes]
> [akpm@linux-foundation.org: whoops]
> [rdunlap@infradead.org: add missing includes]
> Link: http://lkml.kernel.org/r/20200302193630.68771-2-minchan@kernel.org
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jann Horn <jannh@google.com>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: John Dias <joaodias@google.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: SeongJae Park <sj38.park@gmail.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Oleksandr Natalenko <oleksandr@redhat.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: <linux-man@vger.kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
