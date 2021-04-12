Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E1135D426
	for <lists+linux-api@lfdr.de>; Tue, 13 Apr 2021 01:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238142AbhDLXre (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 12 Apr 2021 19:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237377AbhDLXrd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Apr 2021 19:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618271234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOlYJ8gOWVcLmeEYE6eSkfjpllqClsrslpwu4Ap6W2U=;
        b=bHom31ebEqfmqM5zkPx1MAN8leARD+8pWSJRi1Ng2tS24P1m6Q5p/Cg10pSkL8tqZ/vEVO
        b2075k4i5mNkocrM7oYKGk4AO9BePa8meqlOxTitERCWZQMqxUPuTNg8Hsq0Bo97QrbiiJ
        neZaqQEmj1GqDLCRqi9aVuiouqBEfiM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-QpDVhBJ8PmirnuLIivvwRQ-1; Mon, 12 Apr 2021 19:47:12 -0400
X-MC-Unique: QpDVhBJ8PmirnuLIivvwRQ-1
Received: by mail-qv1-f69.google.com with SMTP id w30so3488470qvf.23
        for <linux-api@vger.kernel.org>; Mon, 12 Apr 2021 16:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOlYJ8gOWVcLmeEYE6eSkfjpllqClsrslpwu4Ap6W2U=;
        b=PDBEkAsE/Dv9tjVjfY+RK21Sa9xH8WQY3HDEZokZiZOzCxNRKWJnW9qTegb6f8cULQ
         MW0i0emg1S2JaJgj5pZM2jqEfn7zw5Z0jRSmxj1yeLoDLavxj0/FeAfHflMROTwl5IHi
         TUuYc1yf5fUgbTe+yW3kQE5xM5HxERV/c/110dplOlDxhSFmCBWaQTmQqmviSgN1g0Fm
         TpMiVbF/eyFRkrsOn9D1oeiYofvtmXOnSx/qlD7VGHOJk0SpJGlR+mUwwY8Dy9fKep6y
         5BfRn1mPvTX3dRvzJ0Wh6r9DfDQNsnms3ZMCDhW7aJ9PqJCNpaLwOSfl2ywV0T87pXFC
         b3RA==
X-Gm-Message-State: AOAM533x8NqS23DZDJu9CVkvQ2GhI3TQzfBi2pmQDBwisdfTY0YK9yoa
        ox0DODtqK7zdivio7dxxVYO7o1Y5fXpqxlJbcJTh6j8+U/kEHXsqe5muSfZJvefENthhR82Iqw7
        LykwDzDiHyUENop/NvJbW
X-Received: by 2002:ac8:7eeb:: with SMTP id r11mr27318626qtc.386.1618271232162;
        Mon, 12 Apr 2021 16:47:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwt11l4Cmqc8ipKHVN8+7B3+t8Kvpj6xeiTM99PZLhifufYZQq8uWPSWVpgHfhlat2939djGg==
X-Received: by 2002:ac8:7eeb:: with SMTP id r11mr27318609qtc.386.1618271231937;
        Mon, 12 Apr 2021 16:47:11 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id b83sm3341647qkc.97.2021.04.12.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:47:11 -0700 (PDT)
Date:   Mon, 12 Apr 2021 19:47:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH 1/9] userfaultfd/hugetlbfs: avoid including
 userfaultfd_k.h in hugetlb.h
Message-ID: <20210412234707.GB1002612@xz-x1>
References: <20210408234327.624367-1-axelrasmussen@google.com>
 <20210408234327.624367-2-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210408234327.624367-2-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 08, 2021 at 04:43:19PM -0700, Axel Rasmussen wrote:
> Minimizing header file inclusion is desirable. In this case, we can do
> so just by forward declaring the enumeration our signature relies upon.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---
>  include/linux/hugetlb.h | 5 ++++-
>  mm/hugetlb.c            | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 1d3246b31a41..dfb749eaf348 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -11,7 +11,6 @@
>  #include <linux/kref.h>
>  #include <linux/pgtable.h>
>  #include <linux/gfp.h>
> -#include <linux/userfaultfd_k.h>
>  
>  struct ctl_table;
>  struct user_struct;
> @@ -136,6 +135,8 @@ unsigned long hugetlb_total_pages(void);
>  vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  			unsigned long address, unsigned int flags);
>  #ifdef CONFIG_USERFAULTFD
> +enum mcopy_atomic_mode;

(I'm not 100% sure, but.. maybe this can be moved even out of ifdef?  Then you
 can define it once at the top rather than twice?)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

