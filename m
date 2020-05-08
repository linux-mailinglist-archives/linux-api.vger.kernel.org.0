Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965E71CB704
	for <lists+linux-api@lfdr.de>; Fri,  8 May 2020 20:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEHSVr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 8 May 2020 14:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbgEHSVr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 8 May 2020 14:21:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D3BC061A0C;
        Fri,  8 May 2020 11:21:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d22so1236105pgk.3;
        Fri, 08 May 2020 11:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gV/o9nW1NZlOEYAKRGRfdUGcdnKxPdO6FjHvoQSmtS8=;
        b=Fho/vCig3jvc0rFGu22IQlVl0LbUgnslTrEacpTD1DxEbw4rblrrsfiwtfEvDCFkt3
         eL2bJ8UcwqXj8KZ6VxlgZwqxHze8iuf1gMPR1O0o6SCnDBDnvpE24//uqJE7XLFhKQIP
         OG9SlLp3PMTT9+tCdEeQFKiFPaIJsY4pcCMj3ZeeLatNX6nmXX2ih/k8EWHWSc6vwArH
         QzBbqr/bUS9StnHBf1q/zAV0hyXHk6+uX/Fg5fnVEO+XPTXtJYd2Rw6wWi+m0PrRexhv
         xphOHgxD2mSpxPoRUuzbrZSuonrvtaG/nvzgCAoYgh2LmmnlRA0kO+PRrDbAvYhGDiuu
         0Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=gV/o9nW1NZlOEYAKRGRfdUGcdnKxPdO6FjHvoQSmtS8=;
        b=UTRPlDhvwkvYFowCGhxCxi/6Ekm5MQfb83Yimr94CCNz4vOCIWDUcTDfOPsi8Km7j9
         T2mRPHu1R0sIXB5mjI7jS8nqe743ZrW4MDvkLkSR1bmpSj8wdyXAzr4GD8v/oJ8bd4oO
         TQ3Zf6PIwh9+atwfBLStBgsV5WnY8s7Vq6ir3NSU8EdfSlrBwZ9263UrRYQhx0pxmZKT
         vdiELMc46eTtRs9We2MyynOUN4X4tZzkVfgw4WA5cZcMtxRX8YBX7T5904wd61fHjwv/
         ryyJozQpNTWj1NGstlNHS6yP0DkpLCI6LucHQlJPIy98wTfoWsJt5dMUTRN4UrD1TLOv
         iYsw==
X-Gm-Message-State: AGi0PuZPZbbiy5cxUQY3d8CM1He3pW/ZkmjQyzKt755Iehlzej4BK0Qu
        SVxdUUivLPKT2SbQGBSXfeY=
X-Google-Smtp-Source: APiQypKFXwPLf4reDS9wBZw91ohMCcZQpLOa4hDF/CkXvGYds+TKhWq/NPgguH9tO5AmSyf1JFBi8w==
X-Received: by 2002:a63:1f62:: with SMTP id q34mr3131580pgm.197.1588962106785;
        Fri, 08 May 2020 11:21:46 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id u8sm2875545pjy.16.2020.05.08.11.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:21:45 -0700 (PDT)
Date:   Fri, 8 May 2020 11:21:43 -0700
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
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v7 1/7] mm: pass task and mm to do_madvise
Message-ID: <20200508182143.GA101195@google.com>
References: <20200302193630.68771-1-minchan@kernel.org>
 <20200302193630.68771-2-minchan@kernel.org>
 <2a767d50-4034-da8c-c40c-280e0dda910e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a767d50-4034-da8c-c40c-280e0dda910e@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 05, 2020 at 04:48:12PM +0100, Vlastimil Babka wrote:
> On 3/2/20 8:36 PM, Minchan Kim wrote:
> > In upcoming patches, do_madvise will be called from external process
> > context so we shouldn't asssume "current" is always hinted process's
> > task_struct.
> 
> 
> > Furthermore, we couldn't access mm_struct via task->mm
> > once it's verified by access_mm which will be introduced in next
> > patch[1].
> 
> I would suggest to replace with:
> 
> Furthermore, we must not access mm_struct via task->mm, but obtain it via
> access_mm() once (in the following patch) and only use that pointer [1], so pass
> it to do_madvise() as well. Note the vma->vm_mm pointers are safe, so we can use
> them further down the call stack.
> 
> > And let's pass *current* and current->mm as arguments of
> > do_madvise so it shouldn't change existing behavior but prepare
> > next patch to make review easy.
> > 
> > Note: io_madvise pass NULL as target_task argument of do_madvise
> > because it couldn't know who is target.
> 
>              can't

Andrew already picked up your suggestion except "can't" part. I don't
think it's enough to resend fix it so I will leave it as-is.

