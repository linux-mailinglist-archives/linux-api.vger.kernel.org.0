Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02326206984
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 03:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbgFXBb2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jun 2020 21:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387921AbgFXBb1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Jun 2020 21:31:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8234AC061573;
        Tue, 23 Jun 2020 18:31:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g12so303711pll.10;
        Tue, 23 Jun 2020 18:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=STvVE6RZ3Y0xoSbwRDvBmVixkdJOr1NShciDYz9YwAM=;
        b=W0vTKcKu1k4LZL/79tI9ZWaSgDRT8dAnFbEzoztsZnuxsAdCwsWzGStWBp+QyRecCD
         CUpj6vHksbhJgjnx02F34EzU9VSZkoU+w0V/55gsApx6Jpw5WusaCp9GSfjQGbLUIjmN
         dhnNMzgXGSuy1Bl5Lsh2JdeS0x9Kc+IttH5obXsz2tQ6BHUdRYOP1aSTYrleoPNbXxHL
         Vil+Zf21VuwEdfSVf/OirWzjruOs1ePNLO44R4wC6m426c5cTRulwDPOyti+Oh0Q16Eg
         atT7+QCFMnsJy3yxnvWZ2NOKyqgbq6B3oBd86RRKLsITNob8O+MKM6eY768wVMLumQta
         /5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=STvVE6RZ3Y0xoSbwRDvBmVixkdJOr1NShciDYz9YwAM=;
        b=M+WaptIZeMC0tRcLJHtWdHffPtt6Ob49sJHncmq44fTVTVNQwzqBuUmt/39xEZvma7
         6VekuBYVXzOciyJjGq09deI+/fVPYwp7bqAYLxMMHRHl1eZBuwOYpIA1olsn5EKZeS7O
         coQ37EuFUl0mrSljY10V8YUng5QpsYf3EViTD9ynuQZ5RVp3BUuRYzWtUMzl+tIQSrTf
         Tjmk2MdSIDvuCs5mE78JWtD6UKjjfzMMTq2ZCn+mnEsqpfTrKKsSFScVBIY3MFzMnJ8x
         88OvxF+5a32yUnrGBAd+EqiXIBQpQLJOjjVRHOzkeswHEh1W1nFAtNPFq6M7Tpn4dHmt
         W82g==
X-Gm-Message-State: AOAM530rS3LR/NP54vv8g7FrkL1CugqUSqGKLGuo+JSf36w7VFlzBLe+
        2uGji0wGmZvoRQ0zS55BKm4=
X-Google-Smtp-Source: ABdhPJyysnl8A9zV1eAdaECih+/1cO9iPnaZNXWpwZYi4TkGIOLdr794d0QrNa/rQMjmDGDb7OxyBA==
X-Received: by 2002:a17:902:7208:: with SMTP id ba8mr26976478plb.217.1592962285863;
        Tue, 23 Jun 2020 18:31:25 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id m20sm19512857pfk.52.2020.06.23.18.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:31:24 -0700 (PDT)
Date:   Tue, 23 Jun 2020 18:31:22 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Oleksandr Natalenko <oleksandr@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
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
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>
Subject: Re: [PATCH v8 0/4]  introduce memory hinting API for external process
Message-ID: <20200624013122.GA9502@google.com>
References: <20200622192900.22757-1-minchan@kernel.org>
 <20200623090721.5owt4cxjji6isqe3@butterfly.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623090721.5owt4cxjji6isqe3@butterfly.localdomain>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Oleksandr,

On Tue, Jun 23, 2020 at 11:07:21AM +0200, Oleksandr Natalenko wrote:
> On Mon, Jun 22, 2020 at 12:28:56PM -0700, Minchan Kim wrote:
> > Now, we have MADV_PAGEOUT and MADV_COLD as madvise hinting API. With that,
> > application could give hints to kernel what memory range are preferred to be
> > reclaimed. However, in some platform(e.g., Android), the information
> > required to make the hinting decision is not known to the app.
> > Instead, it is known to a centralized userspace daemon(e.g., ActivityManagerService),
> > and that daemon must be able to initiate reclaim on its own without any app
> > involvement.
> > 
> > To solve the concern, this patch introduces new syscall - process_madvise(2).
> > Bascially, it's same with madvise(2) syscall but it has some differences.
> > 
> > 1. It needs pidfd of target process to provide the hint
> > 2. It supports only MADV_{COLD|PAGEOUT} at this moment.
> >    Other hints in madvise will be opened when there are explicit requests from
> >    community to prevent unexpected bugs we couldn't support.
> > 3. Only privileged processes can do something for other process's address
> >    space.
> > 
> > For more detail of the new API, please see "mm: introduce external memory hinting API"
> > description in this patchset.
> > 
> > * from v7 -  http://lore.kernel.org/r/20200302193630.68771-1-minchan@kernel.org
> >   * dropping pid support from new syscall and fold releated patches into syscall patch
> >   * dropping KSM patch by discussion - Oleksandr, I lost the discussion.
> >     Please resend the single patch against of the patchset if you resolves the discussion.
> >     https://lore.kernel.org/linux-api/20200302193630.68771-8-minchan@kernel.org/
> 
> What "next" tag this (v8) submission is based on please?

It's against on v5.8-rc1-mmots-2020-06-20-21-44 from mmotm - https://github.com/hnaz/linux-mm.git
