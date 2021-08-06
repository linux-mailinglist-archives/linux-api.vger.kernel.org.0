Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753433E22FE
	for <lists+linux-api@lfdr.de>; Fri,  6 Aug 2021 07:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbhHFFn6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Aug 2021 01:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240780AbhHFFn6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Aug 2021 01:43:58 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA72C061799
        for <linux-api@vger.kernel.org>; Thu,  5 Aug 2021 22:43:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id e14so8806743qkg.3
        for <linux-api@vger.kernel.org>; Thu, 05 Aug 2021 22:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=nb0tzD291O2NpxD3QkJh5g66mFqozKrq3J7zV5XdneM=;
        b=tPJQHXxZd9eovODzKBrQ7Z1rQFYYNBRweevMY3p3T4d+8apkd/mZ4TyiXxYdN5oBHu
         +XFAycB1FnQvzN1zYjFLP5xEqwa6Lz90VqwX3n+BQPHkjfdn5gEk1NigAvwe9fXlD9SE
         dS8tKra0w06ivJObMdFJ5EFEZhWLYXTvRc4kZiH0MbWzpk2ETptYZEtSqKyavpv2dLJr
         zClQiwX0qS9s/UburEei25PU/qGv02H+kF28+HWanfBfj27acFef+4JzJA3Wic9Nrwxp
         3xP1iJS5I0CYcBXgt9BGW6QPmuvSkHWUfkH/I9YOJXzCmWCKUTUQ86xrJrhkLbC+Mi5Y
         4rMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nb0tzD291O2NpxD3QkJh5g66mFqozKrq3J7zV5XdneM=;
        b=Utp0qeCWlbEuCltsD4R3tQ6gvtE8O+uh7xOUo5/J8DiIPEPJWYXPA0YkilS5+6qNgN
         c3jcjaGr3/3ywkKBRpZG2CXABRko2PNUV9OQSfdyg7IMMBeBS8/w4wNR6M9qqIGTsZbY
         12QowqKSsWWsM8+01rhWwrc1B+7Pt5elM+Jygn87dUC31qQZSMTj/IHA78Y+Taa6w4kL
         ID1NZeqwFsiMARaIiyGl1Z8N2dCu+3XmlF13cL8723V2Dljnv8JDleRktARHpJgB+y3O
         Cx0ljRScL+NqECicbX+ujw6qRGDiYqCb8MR8cMi/a1cU1FXMaNtlrZPbfZuLQc1AiurF
         mtTg==
X-Gm-Message-State: AOAM532l+6x3W/gRldRWoITUO127OqtS5cVFhFk28ZfaZaR7iOvQAQh2
        bm7J32Vm+pnnnHkijaQ3yffyTA==
X-Google-Smtp-Source: ABdhPJwEfynqWrtytJi7KqnkQzjUoNcTR3OSX0gNN/t9rR4rDc5rHaI5jc76FJ1/rG7ENL+FdWpl4w==
X-Received: by 2002:a37:5a02:: with SMTP id o2mr8487795qkb.476.1628228621102;
        Thu, 05 Aug 2021 22:43:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g4sm3970818qkk.104.2021.08.05.22.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 22:43:40 -0700 (PDT)
Date:   Thu, 5 Aug 2021 22:43:37 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
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
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH 06/16] huge tmpfs: shmem_is_huge(vma, inode, index)
In-Reply-To: <CAHbLzkqKQ_k_aipojZd=UiHyivaweCpCFJJn7WCWVcxhTijqAQ@mail.gmail.com>
Message-ID: <749bcf72-efbd-d6c-db30-e9ff98242390@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com> <dae523ab-c75b-f532-af9d-8b6a1d4e29b@google.com> <CAHbLzkoKZ9OdUfP5DX81CKOJWrRZ0GANrmenNeKWNmSOgUh0bQ@mail.gmail.com> <e7374d7e-4773-aba1-763-8fa2c953f917@google.com>
 <CAHbLzko_wg4mx-LTbJ6JcJo-6VzMh5BAcuMV8PXKPsFXOBVASw@mail.gmail.com> <CAHbLzkqKQ_k_aipojZd=UiHyivaweCpCFJJn7WCWVcxhTijqAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 5 Aug 2021, Yang Shi wrote:
> 
> By rereading the code, I think you are correct. Both cases do work
> correctly without leaking. And the !CONFIG_NUMA case may carry the
> huge page indefinitely.
> 
> I think it is because khugepaged may collapse memory for another NUMA
> node in the next loop, so it doesn't make too much sense to carry the
> huge page, but it may be an optimization for !CONFIG_NUMA case.

Yes, that is its intention.

> 
> However, as I mentioned in earlier email the new pcp implementation
> could cache THP now, so we might not need keep this convoluted logic
> anymore. Just free the page if collapse is failed then re-allocate
> THP. The carried THP might improve the success rate a little bit but I
> doubt how noticeable it would be, may be not worth for the extra
> complexity at all.

It would be great if the new pcp implementation is good enough to
get rid of khugepaged's confusing NUMA=y/NUMA=n differences; and all
the *hpage stuff too, I hope.  That would be a welcome cleanup.

> > > Collapse failure is not uncommon and leaking huge pages gets noticed.

After writing that, I realized how I'm almost always testing a NUMA=y
kernel (though on non-NUMA machines), and seldom try the NUMA=n build.
So did so to check no leak, indeed; but was surprised, when comparing
vmstats, that the NUMA=n run had done 5 times as much thp_collapse_alloc
as the NUMA=y run.  I've merely made a note to look into that one day:
maybe it was just a one-off oddity, or maybe the incrementing of stats
is wrong down one path or the other.

Hugh
