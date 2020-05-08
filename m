Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9894F1CB76B
	for <lists+linux-api@lfdr.de>; Fri,  8 May 2020 20:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgEHSg6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 May 2020 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHSg5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 May 2020 14:36:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840EFC061A0C;
        Fri,  8 May 2020 11:36:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x10so1112721plr.4;
        Fri, 08 May 2020 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DI4jr073qlq2kMXmJOvGcOhiGeUasYxQR1ZwT0O6BJc=;
        b=e9phhNfqFy4SUFWgk2EkceTCIXKBpoo+T6gbLnaezV4G1B1/6lGhJ9ZcLZnuIelgrn
         Ql4cXp0/PLMBEjmnbd2PNYpKCM9yzKGC3CymbAKLYUct+zd+y/b8iq4Ky/HQZw9RQrIY
         xsTziG+UJ7AhftkBwChU8kc9ifBpNVlPOuwtpKv1eySwSaFBPFq5dJ4usA5J2F/H+v6m
         vktpsEvHDUu22Sy7Bu5cLx4TwMhNuNvPG0WBDsdtsVacNNxZmnxGqbJerhxm+TOunoDS
         2wKFP/FJdInr5l49rJI1sh1qd9ISmsRyxCk2BCLIMDZe6Ql6K/PqU2ITpyvLxqk5XBUL
         Ta6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DI4jr073qlq2kMXmJOvGcOhiGeUasYxQR1ZwT0O6BJc=;
        b=f6isCfWSyi9Kd4YVT5ux2+p7P+3FTj0DMqMYbIfio4asllNRa7tcKjvzXx+U8/iaKY
         yAsaoUgUIeSo0+ifG0w+yJ9+PtolSMjVhPzy3+kx1SIaCutexxjVvT/ONVznlEhNiRjq
         OFDbAbMYc8vnmyfV3Jxrq8X8myjfV3FMF7op1kiV225oSV3UhKHzzlq+eoNavbou+0LJ
         BSNm86J1MdFTjzqPKNtE0wmC0FAcfkKQIiH6txVgiHyCw/IdqKtIgpUj9UZwrMXoTuxb
         pIDX06UtRp+WBDj0TQaTWxfGMC4A6pHuAL8AqCJihhTDrO1NTjqlwmfZgKkmoxUann1t
         AguA==
X-Gm-Message-State: AGi0PuYN7iVy8wRS+hAfzL5a7qJeLo8K2D5gmUnWm5gzf48+ecil3FKx
        gZPv32iOO6277oJUUFJcWuw=
X-Google-Smtp-Source: APiQypKgW5Qc0p3xd2HpZcE+oAgc4345/KXJgo5T1enrKQgtp+/zxkhsCUo1kw0ffKngWDoRgVGTKw==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr3617494pla.336.1588963016739;
        Fri, 08 May 2020 11:36:56 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id mn1sm2880315pjb.24.2020.05.08.11.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:36:55 -0700 (PDT)
Date:   Fri, 8 May 2020 11:36:53 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v7 5/7] mm: support both pid and pidfd for process_madvise
Message-ID: <20200508183653.GB125527@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-6-minchan@kernel.org>
 <14089609-5fb1-b082-716f-c2e129d27c48@suse.cz>
 <20200311004251.GB87930@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311004251.GB87930@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 10, 2020 at 05:42:51PM -0700, Minchan Kim wrote:
> On Fri, Mar 06, 2020 at 12:14:19PM +0100, Vlastimil Babka wrote:
> > On 3/2/20 8:36 PM, Minchan Kim wrote:
> > > There is a demand[1] to support pid as well pidfd for process_madvise
> > > to reduce unnecessary syscall to get pidfd if the user has control of
> > > the target process(ie, they could guarantee the process is not gone
> > > or pid is not reused).
> > > 
> > > This patch aims for supporting both options like waitid(2). So, the
> > > syscall is currently,
> > > 
> > > 	int process_madvise(int which, pid_t pid, void *addr,
> > > 		size_t length, int advise, unsigned long flag);
> > 
> > This is again halfway between kernel and userspace description, so if we stick
> > to userspace then it's:
> > 
> >  	int process_madvise(idtype_t idtype, id_t id, void *addr,
> >  		size_t length, int advice, unsigned long flags);
> 
> Yub.
> 

Hi Andrew,

Per Vlastimil's request, I changed "which and advise" with "idtype and
advice" in function prototype of description.
Could you replace the part in the description? Code is never changed.

Thanks.

From f11cfd023746ae67b89f2d84d960706ba6c5c911 Mon Sep 17 00:00:00 2001
From: Minchan Kim <minchan@kernel.org>
Date: Wed, 6 May 2020 13:54:40 +0000
Subject: [PATCH] mm/madvise: support both pid and pidfd for process_madvise

There is a demand[1] to support pid as well pidfd for process_madvise to
reduce unnecessary syscall to get pidfd if the user has control of the
target process(ie, they could guarantee the process is not gone or pid is
not reused).

This patch aims for supporting both options like waitid(2).  So, the
syscall is currently,

        int process_madvise(idtype_t idtype, id_t id, void *addr,
                size_t length, int advice, unsigned long flags);

@which is actually idtype_t for userspace libray and currently, it
supports P_PID and P_PIDFD.

[1]  https://lore.kernel.org/linux-mm/9d849087-3359-c4ab-fbec-859e8186c509@virtuozzo.com/

Link: http://lkml.kernel.org/r/20200302193630.68771-6-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Suggested-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Christian Brauner <christian@brauner.io>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Jann Horn <jannh@google.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: John Dias <joaodias@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oleksandr Natalenko <oleksandr@redhat.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: SeongJae Park <sj38.park@gmail.com>
Cc: SeongJae Park <sjpark@amazon.de>
Cc: Shakeel Butt <shakeelb@google.com>
Cc: Sonny Rao <sonnyrao@google.com>
Cc: Tim Murray <timmurray@google.com>
Cc: <linux-man@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
