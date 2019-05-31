Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B89D930F2E
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 15:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfEaNo5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 09:44:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44290 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaNo5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 09:44:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id x3so730632pff.11;
        Fri, 31 May 2019 06:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPbIIJuyYstqKudbEw2Wc+jcaMTMVd97T1l4e8lD3KA=;
        b=ZEX8PNbz0qOV4voBBdbFmKU8Z61+Kq1IWhx5JPVytMYOvYTBT5KAWMYHlQHpuKdgSg
         HSrAx8xuwmobu/aN7G69ZUXBZGFsZAZKV9Jwh7R86aeFbLWpR61w1dIFZRGmCJEQeIJX
         cWE9s+nnWFabfC6BKmM5q+lzvE9zelYV4BIrEjFfbqCw6jo4BlTEpDpeVU9ZNlUskaZE
         QxrQ3Kle9nm1Vhb7WtfmtLmGs/xkMXVJASxfRSvUPhsmiQFlY+5ygS1PjZUquJEC4CoC
         ODl+QIaQ/YQt/Fyrhd0r1FX06SAFd8tvZi3XzPE6c2gDd+30+cy7tWw0Q6OCeGgjV+/u
         6ZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPbIIJuyYstqKudbEw2Wc+jcaMTMVd97T1l4e8lD3KA=;
        b=KxTOSLjed++fvl4TmCnNEQrSR4rjgkhG4/v6y7aei4wwWwfqfm0MAkoHnfMxC6WXzL
         0ZEErW5BPuJRFi51DQiFJR/te/6kO9E3ZMnPeS5WJxMCHcpPIJREyGiFZf33zlFO4Pza
         uBKacJUlRKzHeA5ZG41TfUwigAtB8y3lTldzObn4MmanwAsn2+dAM1ZGJEs/hYsTHkXo
         VsZz+Fm3svKlvGoEehfLgKonBoS07/F4h7AVadIXGVuRKNUqZ8N8dnf164ZsDBgIGPO9
         QkancrHb3Tl3lHQK4a6jEij4tqDSLzEoFHNtsG745gW2NvRMgY1S88p/N6B0yhDkl7LE
         SaZg==
X-Gm-Message-State: APjAAAXiRNPUJQFv1owGRKapet5F2D7ViJtOZ/g4kpcPP+hNuK/iUc6Z
        STkxCm1+AWx80iw+Zbjxf/0=
X-Google-Smtp-Source: APXvYqwQVdzt+MDB8OA82hnznf1kjVB0kSuwffl4tojHdIoAaLiUvdyrPZr97mrwWIcFKVij7mYIJw==
X-Received: by 2002:a17:90a:9382:: with SMTP id q2mr9524146pjo.131.1559310296875;
        Fri, 31 May 2019 06:44:56 -0700 (PDT)
Received: from google.com ([122.38.223.241])
        by smtp.gmail.com with ESMTPSA id g83sm6546532pfb.158.2019.05.31.06.44.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 31 May 2019 06:44:55 -0700 (PDT)
Date:   Fri, 31 May 2019 22:44:47 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 3/6] mm: introduce MADV_PAGEOUT
Message-ID: <20190531134447.GD195463@google.com>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-4-minchan@kernel.org>
 <20190531085044.GJ6896@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531085044.GJ6896@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 31, 2019 at 10:50:44AM +0200, Michal Hocko wrote:
> On Fri 31-05-19 15:43:10, Minchan Kim wrote:
> > When a process expects no accesses to a certain memory range
> > for a long time, it could hint kernel that the pages can be
> > reclaimed instantly but data should be preserved for future use.
> > This could reduce workingset eviction so it ends up increasing
> > performance.
> > 
> > This patch introduces the new MADV_PAGEOUT hint to madvise(2)
> > syscall. MADV_PAGEOUT can be used by a process to mark a memory
> > range as not expected to be used for a long time so that kernel
> > reclaims the memory instantly. The hint can help kernel in deciding
> > which pages to evict proactively.
> 
> Again, are there any restictions on what kind of memory can be paged out?
> Private/Shared, anonymous/file backed. Any restrictions on mapping type.
> Etc. Please make sure all that is in the changelog.

It's same with MADV_COLD. Yes, I will include all detail in the
description.

> 
> What are the failure modes? E.g. what if the swap is full, does the call
> fails or it silently ignores the error?

In such case, just ignore the swapout. It returns -EINVAL only if the
vma is one of (VM_LOCKED|VM_HUGETLB|VM_PFNMAP) at this moment.

> 
> Thanks!
> -- 
> Michal Hocko
> SUSE Labs
