Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F36373399
	for <lists+linux-api@lfdr.de>; Wed,  5 May 2021 03:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhEEBdH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 May 2021 21:33:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230454AbhEEBdG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 May 2021 21:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620178330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPRVInBsTWC+0BUGJOB5FIDSOa450b+bMYREaXrrpp0=;
        b=RPi+LzQ5BM+t1GpveXBRNbwChSu0fL3JyyOv3/nQFxjx6g71+Nqkjm/drsa6mSFR4lLCvm
        ocqaas50O0ZTaqquk10lviSIgjOQgvYKGhHjh5ARYcNpqiwWJb0v+nPFylGqTe6g38jw6s
        eojA8oQzjTjvrMgsTgCcS3HgeA2hbq8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-YKAG9jvmP5qBEIWo9addAg-1; Tue, 04 May 2021 21:32:08 -0400
X-MC-Unique: YKAG9jvmP5qBEIWo9addAg-1
Received: by mail-io1-f72.google.com with SMTP id q187-20020a6b8ec40000b0290431cccd987fso166120iod.14
        for <linux-api@vger.kernel.org>; Tue, 04 May 2021 18:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cPRVInBsTWC+0BUGJOB5FIDSOa450b+bMYREaXrrpp0=;
        b=LNJgIkGRLQp6uP0a1oUvQUlsaM04x2yMpEwSRbEFmGvm5W41KQbNnApvSzMibOBp5l
         mzhJPQZuIx3KVOdVc6kCDqKnu25AbwGnHMbXO1RZQ9jCrnHhAPof+0QMfYsvI9oU2z1F
         jEd3jtffTckUjHqRONUfXOejy9uJaX3e6opTChrs+tG1sFsFn0lJHiK6Dwa3so5EFE3j
         S19PCd1PfL+rJpeXesSgdy/EnE5ixcvS5jBAeRukR/ZT7ZfnM42QMmvmM37r2xemln3Q
         A6eFKSwzrQ7VqFITpaDqSxHZWi0xGljLpJSIY7zddmsy5BmniXKzCy17wuSlR+lSx1KX
         mQng==
X-Gm-Message-State: AOAM532X75GaMwbPDtEDSG6y/ezO50VAPFnHWuKV7cRqmIKvVuadCqQK
        jRQNHkqE0ItSxzhJXfCVAuPZ2FJrKmTzHzpSdoPEL1gxuwbTjwNQk6b6uo2spOSjDtNB65SKVcM
        I5R1hSYerEunKr/T79onK
X-Received: by 2002:a92:8e03:: with SMTP id c3mr2036564ild.167.1620178327564;
        Tue, 04 May 2021 18:32:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNg9jcG4O9OkPZqQlTS7aeMFQ7/soHNplo9cjmrJ2Ghe+p949bqg4pbzePUCrb/19N4cHmHg==
X-Received: by 2002:a92:8e03:: with SMTP id c3mr2036544ild.167.1620178327359;
        Tue, 04 May 2021 18:32:07 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id u9sm1842495ior.8.2021.05.04.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 18:32:06 -0700 (PDT)
Date:   Tue, 4 May 2021 21:32:04 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v6 06/10] userfaultfd/shmem: modify
 shmem_mfill_atomic_pte to use install_pte()
Message-ID: <YJH1lCx9IGqHG+yq@t490s>
References: <20210503180737.2487560-1-axelrasmussen@google.com>
 <20210503180737.2487560-7-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210503180737.2487560-7-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Axel,

On Mon, May 03, 2021 at 11:07:33AM -0700, Axel Rasmussen wrote:
> In a previous commit, we added the mfill_atomic_install_pte() helper.
> This helper does the job of setting up PTEs for an existing page, to map
> it into a given VMA. It deals with both the anon and shmem cases, as
> well as the shared and private cases.
> 
> In other words, shmem_mfill_atomic_pte() duplicates a case it already
> handles. So, expose it, and let shmem_mfill_atomic_pte() use it
> directly, to reduce code duplication.
> 
> This requires that we refactor shmem_mfill_atomic_pte() a bit:
> 
> Instead of doing accounting (shmem_recalc_inode() et al) part-way
> through the PTE setup, do it afterward. This frees up
> mfill_atomic_install_pte() from having to care about this accounting,
> and means we don't need to e.g. shmem_uncharge() in the error path.
> 
> A side effect is this switches shmem_mfill_atomic_pte() to use
> lru_cache_add_inactive_or_unevictable() instead of just lru_cache_add().
> This wrapper does some extra accounting in an exceptional case, if
> appropriate, so it's actually the more correct thing to use.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

(The moving of "ret = -ENOMEM" seems unnecessary, but not a big deal I think)

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

