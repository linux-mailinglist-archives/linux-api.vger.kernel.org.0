Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5E3207C86
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 22:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391396AbgFXUAH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391221AbgFXUAG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 16:00:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691AC061573
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 13:00:06 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f9so1699012pfn.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 13:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IeM1pbX3Y/QRt8rMyrroNyrQ/gTGnkJwEnogm0dQ3GE=;
        b=uhBYvvKCWelTf4JenS6hYiSwgyGKBjl7XAHO+DuYLiRrdYNH1hh8a647W7MkpRc4W3
         grtXLTOUfUT9eg5QiRa1Fb/bpa4JxRgaR1568VZ3Rp4Tzrkb68F99ewBKwLJE2svnato
         wIDa9TNmSIMZXHndufHSFI3KeZwRR31Pat1P9Ww2YAe/Blsh7+N+pV1a1TQjce7oLPl+
         L9IhY2vdG5I9KUW4iS96MKRWm8TQzhkjib3ioZR2aREcTFKbAucF0gsWUdHcOivUMgTR
         hZV33HumrWYCIH4FW+6RBsVHhBxSKuITT9/LtRDQYcJXRJ3TafqePblA72wzwovefbeN
         YUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IeM1pbX3Y/QRt8rMyrroNyrQ/gTGnkJwEnogm0dQ3GE=;
        b=gfQJGigYBNlweonFduv7gT8YHm2JLjRxJHLMzlJE70zqGebdS7TT7fHaUycWTj1YQE
         /HliJjqal0Ri87VfMJcGh2kHZTvqjS8FEXqs3FMvEG/vArexPCLVzBcTmZtnqENC/HxL
         sjF0LsnDILaoi9kHF/pJfdLNM3F1gyhHE3HB/EG09xFYf70bsNSONEIdBa63RSDPH+Ja
         vBHThvOfF8EfG5tojvhwd+64WojZfRfGXQt2WjhrDcGHvyWSPtYDrLMZ0U9DQgicJGgN
         sVC+riBLajVu4sqWjGv2rt2y+5eDgpuHv2cLmV4D6KRRaIexgtBcspzTAe5W3n3V5zO2
         Q/Tg==
X-Gm-Message-State: AOAM531wwi6sw6JCR0RRTTziFV1z5LOblOJPVHU0tXPz86Gggel5NDnR
        SxFPfbBWWwWFJWDE1qxJjsjX/Q==
X-Google-Smtp-Source: ABdhPJwi+ep/yhnadV35mqvrBbBtsDSgiibwsNhPmy0Eh7KnXNpc3Qxvv8zxkmDoRNCdHSdO5Af54A==
X-Received: by 2002:aa7:924c:: with SMTP id 12mr30224767pfp.225.1593028805959;
        Wed, 24 Jun 2020 13:00:05 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h30sm3090949pfr.89.2020.06.24.13.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:00:05 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:00:04 -0700 (PDT)
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
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v8 4/4] mm/madvise: check fatal signal pending of target
 process
In-Reply-To: <20200622192900.22757-5-minchan@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2006241259530.35388@chino.kir.corp.google.com>
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-5-minchan@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 22 Jun 2020, Minchan Kim wrote:

> Bail out to prevent unnecessary CPU overhead if target process has pending
> fatal signal during (MADV_COLD|MADV_PAGEOUT) operation.
> 
> Link: http://lkml.kernel.org/r/20200302193630.68771-4-minchan@kernel.org
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: John Dias <joaodias@google.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oleksandr Natalenko <oleksandr@redhat.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: SeongJae Park <sj38.park@gmail.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: <linux-man@vger.kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
