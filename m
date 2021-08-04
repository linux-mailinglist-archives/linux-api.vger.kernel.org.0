Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FA63DFDC1
	for <lists+linux-api@lfdr.de>; Wed,  4 Aug 2021 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbhHDJPo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Aug 2021 05:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbhHDJPn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Aug 2021 05:15:43 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E23C061798
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 02:15:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 26so2195169oiy.0
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 02:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=h7Zb2A6Dh35OWvvMLuElewoKlDVEdIPG861c8z8d7jg=;
        b=Y+FPojpZ7vt4c9aS5JxHtYi18I/UZ1MIAtfN7XmXFNAKWkhc8z6zThket2NIo8OWzv
         o6BoeEfJUNOU/E2EOlgL44Q4WYwKCgL8OwzFH99F9XMQm5SSel14hNwv+AqmKFh46L1C
         1kYt5Y5qZQQCbd/dwLuOkWY6OJGph/xf8u3TjomeEOCGyff7QYW73X1eNuTNkYLQvGv5
         ZR/cHEpvqFQSWRV4hjpDNnphgts54ZHQ3cccgNqDNaVhI4CSKEqCcv+xmT4QLqpNVaTx
         QEFAj5r7cAVU0Tga+T52yaijY0x26+uG/kZiDest7zF2s/PQqIlz4mKUa2LMtIjVXg41
         0Xaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=h7Zb2A6Dh35OWvvMLuElewoKlDVEdIPG861c8z8d7jg=;
        b=U5veL+PpjQ+bEj4DDkXYC1YHyXmHAAS/1nvPuS8yHJyzTyCvd3/lWSLserbxzMQOSp
         DVSkqWxjF6aXDhg72p0/FawCZk3JuPqqg4er9MV0TcCB5lVXQBbNqGGMIhULkVE/m5Rv
         Sj5GQiPl9uC7NWs/KkwSXL9u3UbIUDC2a9DXtibusU/+cEKD0crrF5iDWiXmkJmGjr+9
         9YN8j4yBO9To7R0nBtkoAjWoGictX2Jc2u1urDrolWHCRuNTNSE1V+z5j38vI9+XJ0S/
         k+5VPH6mPLtkLzrebLu0jpZzvDD6WKM3QItywYzWoxaZffSMpbUhZhqd4raLN0PzW529
         B+UQ==
X-Gm-Message-State: AOAM532mHyrW6e7pOulaiW2XihpQIOkOlPhgXEuvuSc3394vGlwJ7fLX
        SSFlf7OOpG9xUfq7i7Zu2/wJ0g==
X-Google-Smtp-Source: ABdhPJyiGrsvu72TeAV4c1kVT/RJj6hoqjS/aWTa8gUe1f/N1n3nzIaS/JrvT7jZLpDJKjpFi8eRxg==
X-Received: by 2002:aca:6704:: with SMTP id z4mr17441159oix.89.1628068530413;
        Wed, 04 Aug 2021 02:15:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x8sm260465oof.27.2021.08.04.02.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 02:15:29 -0700 (PDT)
Date:   Wed, 4 Aug 2021 02:15:26 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 10/16] tmpfs: fcntl(fd, F_MEM_LOCK) to memlock a tmpfs
 file
In-Reply-To: <YQieHio1oUKCfgqq@casper.infradead.org>
Message-ID: <7077b94a-d894-4d97-4b3e-23f516d58591@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <54e03798-d836-ae64-f41-4a1d46bc115b@google.com> <YQieHio1oUKCfgqq@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 3 Aug 2021, Matthew Wilcox wrote:
> On Fri, Jul 30, 2021 at 12:55:22AM -0700, Hugh Dickins wrote:
> > A new uapi to lock the files on tmpfs in memory, to protect against swap
> > without mapping the files. This commit introduces two new commands to
> > fcntl and shmem: F_MEM_LOCK and F_MEM_UNLOCK. The locking will be
> > charged against RLIMIT_MEMLOCK of uid in namespace of the caller.
> 
> It's not clear to me why this is limited to shmfs.  Would it not also
> make sense for traditional filesystems, eg to force chrome's text pages
> to stay in the page cache, no matter how much memory the tabs allocate?

Right: if VFS people would like this to be available for all filesystems,
that's fine by me - it's just that we have not given thought to other
filesystems, and the demand was for tmpfs, so that was where to start.
I'm more confident adding fields to shmem inode than to generic inode.

(Plus tmpfs does have a stronger claim on CAP_IPC_LOCK etc, but there's
no real reason why that cannot be extended to similar use by other FSs).

hugetlbfs and ramfs, where the files are already memlocked?  Not worth a
special case, I think: if someone uses up memlock quota on them, so be it.

It looks as if tmpfs would still want its own special case, just to
handle the FALLOC_FL_KEEP_SIZE issue (see 12/16): tmpfs has beyond-i_size
pages in memory, but accounts them evictable; whereas I doubt any storage
filesystems would be using memory for them.

To be clear: I'm not intending to extend this to other filesystems at
the moment; but happy to do so if that's the consensus.

Hugh
