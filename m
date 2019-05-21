Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A02CA24B43
	for <lists+linux-api@lfdr.de>; Tue, 21 May 2019 11:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfEUJNh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 21 May 2019 05:13:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33834 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfEUJNg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 21 May 2019 05:13:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so8279322pgt.1;
        Tue, 21 May 2019 02:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FtiVzriB2PhlcNAnz836XBuHzMztzkTorf7MJccM2OU=;
        b=nLpAdWELdczUu+3lNyH6LfAl0QPj3HY+ylBRF+etXwbxLii/AXVKvL8Z2X2jUNDnDZ
         oOLUXjIgc+XGGxCeO17/IM2C1kUUN3SNtqpO/c6t/XJsrP0Ux7ktXDgHHS6EZdf8LFek
         gT5vJlMs8DrcCOeK7IrChtx97Zx1dbwWji6WwZBR8fpQRjgPj38fDcpr2Gtlrgd8zy8I
         uNh+aVGyi3WWAXJOrRiWrfeXZD4lN9bimqQB27OGtybJ0B3hz4egDMmNJDLGMpWTnPEQ
         4Vkk7lk+1VlnoIdxFYKpwVNCusuZtNP1TBbUsXL6/pt0+8CzePg6WX5gMb7XebjpDCG2
         xUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FtiVzriB2PhlcNAnz836XBuHzMztzkTorf7MJccM2OU=;
        b=K1UjvX2EKJN8qqwd/nkTc4gZSC+m0xe+FAeqv40VRNVBcGYRxQjnw7QH5Ha6clnfih
         V0jMSKmNWcVUJ/NTeEuDA7pDr8/rqrpbmA8DEc9YNobgYG4VvOQXsp7DGROrciPYtOYI
         5sVsg5qB3QwBP/svb3MX4gFrpiyqOyLqRzENdD0QRp4LZjXWIMWGocDQQmEUp3S2ibU4
         +Z0aVV8fUq8yujlQ4HcPMj9iaojJ8YsHOalMDL1d6aVDct+27b0EqO3eKkIMUYBFomLV
         2bYw24S5RjsD8/+oxwfg21NLLEd3ZMu4YXER+Z90PAabS5abSFpEmCD/Xe5eT2/9oYDD
         o7ww==
X-Gm-Message-State: APjAAAWWYD1xlOW9eWMHiyFODRo1wc2ZRW9LhYrj6his8JGX+0B8ZGsx
        J9uXwsR6Irg7Wve/5qBBUkg=
X-Google-Smtp-Source: APXvYqzVkDpZ7bX2Y7PzruSEK13LfO/mpDsKUUI4C9vtExA5uiJNVqQNkd9lzLO29jDx3IZd8nI4Sg==
X-Received: by 2002:a62:1ec1:: with SMTP id e184mr18958178pfe.185.1558430015975;
        Tue, 21 May 2019 02:13:35 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id u1sm31870394pfh.85.2019.05.21.02.13.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 02:13:34 -0700 (PDT)
Date:   Tue, 21 May 2019 18:13:29 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, linux-api@vger.kernel.org
Subject: Re: [RFC 3/7] mm: introduce MADV_COLD
Message-ID: <20190521091329.GB219653@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-4-minchan@kernel.org>
 <20190520082703.GX6836@dhcp22.suse.cz>
 <20190520230038.GD10039@google.com>
 <20190521060820.GB32329@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521060820.GB32329@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, May 21, 2019 at 08:08:20AM +0200, Michal Hocko wrote:
> On Tue 21-05-19 08:00:38, Minchan Kim wrote:
> > On Mon, May 20, 2019 at 10:27:03AM +0200, Michal Hocko wrote:
> > > [Cc linux-api]
> > > 
> > > On Mon 20-05-19 12:52:50, Minchan Kim wrote:
> > > > When a process expects no accesses to a certain memory range
> > > > for a long time, it could hint kernel that the pages can be
> > > > reclaimed instantly but data should be preserved for future use.
> > > > This could reduce workingset eviction so it ends up increasing
> > > > performance.
> > > > 
> > > > This patch introduces the new MADV_COLD hint to madvise(2)
> > > > syscall. MADV_COLD can be used by a process to mark a memory range
> > > > as not expected to be used for a long time. The hint can help
> > > > kernel in deciding which pages to evict proactively.
> > > 
> > > As mentioned in other email this looks like a non-destructive
> > > MADV_DONTNEED alternative.
> > > 
> > > > Internally, it works via reclaiming memory in process context
> > > > the syscall is called. If the page is dirty but backing storage
> > > > is not synchronous device, the written page will be rotate back
> > > > into LRU's tail once the write is done so they will reclaim easily
> > > > when memory pressure happens. If backing storage is
> > > > synchrnous device(e.g., zram), hte page will be reclaimed instantly.
> > > 
> > > Why do we special case async backing storage? Please always try to
> > > explain _why_ the decision is made.
> > 
> > I didn't make any decesion. ;-) That's how current reclaim works to
> > avoid latency of freeing page in interrupt context. I had a patchset
> > to resolve the concern a few years ago but got distracted.
> 
> Please articulate that in the changelog then. Or even do not go into
> implementation details and stick with - reuse the current reclaim
> implementation. If you call out some of the specific details you are
> risking people will start depending on them. The fact that this reuses
> the currect reclaim logic is enough from the review point of view
> because we know that there is no additional special casing to worry
> about.

I should have clarified. I will remove those lines in respin.

> -- 
> Michal Hocko
> SUSE Labs
