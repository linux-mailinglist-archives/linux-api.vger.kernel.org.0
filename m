Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9683E02A9
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 16:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238592AbhHDODx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238577AbhHDODv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 10:03:51 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1EEC061798
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 07:03:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p38so4751263lfa.0
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 07:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ughZXN0i6ciMUaDjjaXdTQDv5YKCIbyqFTwOxdxRMYc=;
        b=cwWoGqnBtbRPE3rm+p3rv/XNLBT6UskyQZGbimvxIbkwBs9NHfpMNztqOBU1axgWsG
         k+F67X5sBHfB/LkTVsbBcVP2q59dpESact7KEX5gs+41LKKBw5SglU+AMKmP/VXtN5qf
         oOtAuvqE0rzvbGC+nI1XTgP/4PMXCt+NQLGsbz48Zlk1S5hT41Hpq/SukRNVayGLyx4d
         aubveY9oEz/95GNs4EfKHMpq3GIAzIkijo2rW4tK1OUWJ48SI8Vs49cxQFbo/S+Bucxv
         H4XQKrayIn0ZOhCKjafL1f2R+9oxA8RT/Zmve2xalFVx/569jcVkyshiYm0Swqqjl8oi
         IOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ughZXN0i6ciMUaDjjaXdTQDv5YKCIbyqFTwOxdxRMYc=;
        b=hdbB0y6WETMiWffd2iYF4UIk5iRRMnsA1QHXqM2sC8XnXcWwY4x76WY6MvPtlJTVb7
         QjeBn7jypBnHP1eS79qZ4MJX4p43nIYVNNs7Ohuf7sOt3Un3UfMqDOutAITF/CyfmK1q
         BhLAsUvCd2AkC5X6qxCd/Vq7UrHws+RRaFbOAB2TvUqoEuBYBiuvKK66Qw1RwFVNd/ZL
         2Y8iBm6mtlQe/diCHhp6CF8SSBGGUJYfYvpUArdbJPmbdYwyxHZWr9TR1HRy5XOpwAu6
         eXmgNlEn972sOglAsLlT7JJSK5JJnMUCzC5Pb7h3s6iOXbJgxXBReY3cxDsL7b2+k6Ur
         apEg==
X-Gm-Message-State: AOAM5333nh6FZZb+GMr8Wv2OlNhGGUlQ34kxUK8Gbu5fuz+u/KFCvcvA
        Pz7tJhz64ecpa/BpoWizrgfZ7g==
X-Google-Smtp-Source: ABdhPJwoHv/m0AtQTKnETyKLX66l6MWvksv+9Z7Vx7V6O2e8eYlYGJ7BNGoinJFDdPVshZj0811POg==
X-Received: by 2002:a05:6512:b22:: with SMTP id w34mr20234036lfu.596.1628085817256;
        Wed, 04 Aug 2021 07:03:37 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id b15sm207452lff.104.2021.08.04.07.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 07:03:36 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 23CAC102BC1; Wed,  4 Aug 2021 17:03:41 +0300 (+03)
Date:   Wed, 4 Aug 2021 17:03:41 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 07/16] memfd: memfd_create(name, MFD_HUGEPAGE) for shmem
 huge pages
Message-ID: <20210804140341.m3ptxesrxwivqjmk@box.shutemov.name>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
 <c140f56a-1aa3-f7ae-b7d1-93da7d5a3572@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c140f56a-1aa3-f7ae-b7d1-93da7d5a3572@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 30, 2021 at 12:45:49AM -0700, Hugh Dickins wrote:
> Commit 749df87bd7be ("mm/shmem: add hugetlbfs support to memfd_create()")
> in 4.14 added the MFD_HUGETLB flag to memfd_create(), to use hugetlbfs
> pages instead of tmpfs pages: now add the MFD_HUGEPAGE flag, to use tmpfs
> Transparent Huge Pages when they can be allocated (flag named to follow
> the precedent of madvise's MADV_HUGEPAGE for THPs).

I don't like the interface. THP supposed to be transparent, not yet another
hugetlbs.

> /sys/kernel/mm/transparent_hugepage/shmem_enabled "always" or "force"
> already made this possible: but that is much too blunt an instrument,
> affecting all the very different kinds of files on the internal shmem
> mount, and was intended just for ease of testing hugepage loads.

I wounder if your tried "always" in production? What breaks? Maybe we can
make it work with a heuristic? This would speed up adoption.

If a tunable needed, I would rather go with fadvise(). It would operate on
a couple of bits per struct file and they get translated into VM_HUGEPAGE
and VM_NOHUGEPAGE on mmap().

Later if needed fadvise() implementation may be extended to track
requested ranges. But initially it can be simple.

-- 
 Kirill A. Shutemov
