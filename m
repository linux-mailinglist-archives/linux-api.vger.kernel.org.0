Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9025418F220
	for <lists+linux-api@lfdr.de>; Mon, 23 Mar 2020 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727738AbgCWJtt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 23 Mar 2020 05:49:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgCWJtt (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 23 Mar 2020 05:49:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B5022072D;
        Mon, 23 Mar 2020 09:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584956988;
        bh=Dk9SiQHTvQDbS1aDBmct0UumdwanFiG0VwvW4geFoX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSULd/9gOiraf5VSWDJaltlND3dLyq3/XYW5kRo1UHq7nV7tV0kIgncKq3yFgmPbq
         QOrPv+GZWXZq5oFHq2ycSIzwD38EuTM9L/n9Y1Ge+z833ItBbLH/ifI8YStGlieQTE
         E/rDy5i7fGDZMudd5gobmLJdX7pLFD+pG1mmmKmw=
Date:   Mon, 23 Mar 2020 10:49:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     leon@kernel.org, vbabka@suse.cz, adobriyan@gmail.com,
        akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v2 3/3] android: ion: include system heap size in
 meminfo extra
Message-ID: <20200323094946.GA425358@kroah.com>
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
 <CGME20200323080508epcas1p3c68190cd46635b9ff026a4ae70fc7a3b@epcas1p3.samsung.com>
 <20200323080503.6224-4-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323080503.6224-4-jaewon31.kim@samsung.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 23, 2020 at 05:05:03PM +0900, Jaewon Kim wrote:
> In Android system ion system heap size is huge like hundreds of MB. To
> know overal system memory usage, include ion system heap size in
> proc/meminfo_extra.
> 
> To include heap size, use register_meminfo_extra introduced in previous
> patch.
> 
> Prior to register we need to add stats to show the ion heap usage. Add
> total_allocated into ion heap and count it on allocation and freeing. In
> a ion heap using ION_HEAP_FLAG_DEFER_FREE, a buffer can be freed from
> user but still live on deferred free list. Keep stats until the buffer
> is finally freed so that we can cover situation of deferred free thread
> stuck problem.
> 
> i.e) cat /proc/meminfo_extra | grep IonSystemHeap
> IonSystemHeap:    242620 kB
> 
> i.e.) show_mem on oom
> <6>[  420.856428]  Mem-Info:
> <6>[  420.856433]  IonSystemHeap:32813kB
> 
> Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
> ---
>  drivers/staging/android/ion/ion.c             | 2 ++
>  drivers/staging/android/ion/ion.h             | 1 +
>  drivers/staging/android/ion/ion_system_heap.c | 2 ++
>  3 files changed, 5 insertions(+)

Does this really give the proper granularity that ion users have?  I
thought they wanted to know what each heap was doing.

Also, this code should be deleted really soon now, so I would not make
any core changes to the kernel based on it at all.

thanks,

greg k-h
