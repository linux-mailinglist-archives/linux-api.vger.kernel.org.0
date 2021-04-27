Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB7636BD43
	for <lists+linux-api@lfdr.de>; Tue, 27 Apr 2021 04:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhD0CYq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 26 Apr 2021 22:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbhD0CYp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Apr 2021 22:24:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3467BC061756
        for <linux-api@vger.kernel.org>; Mon, 26 Apr 2021 19:24:02 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id k127so3057434qkc.6
        for <linux-api@vger.kernel.org>; Mon, 26 Apr 2021 19:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=aBj4f1ka2nJ/gpsa6TStMHZaqIrVKG/e6xHVPE7SPEE=;
        b=E+NwonMupVGezKMvjZ7hJwuZQ7V76KMT7a8ypVkX65/bszqV5hRAaSxib3pmK+eJfD
         tllgqMWe4sbOvxMl7aM71A2JNBTaV6C4u83GRHWJqFYRE+VJcoLkL7QAEEBwq7WiVHci
         mu8D0PyYgzY4sbwCSW2vC8nYPq0r6pbav55Ns7BukgH1UbnMxFMMxgilLzeSqlIlSofA
         3UlLDdRyR+qwsj8qMAj7iuK0XWKe4Kx+CdfPJfaJCYsTqCzkbIHOIzVefh0TzQ5jTOs1
         AwC2bB4Nfm5aVbPV4Fja3J0XyP69U0AMxou0bN2hbN9ScZn/sFvBlmLvq/CUoguRbXC8
         Mh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=aBj4f1ka2nJ/gpsa6TStMHZaqIrVKG/e6xHVPE7SPEE=;
        b=hstctKZ0bzuMFKsDJTvfbJsK1emGdMxd06gdu85aZnN8IkmYjTFKpYnUCO+1b9OcWf
         6xZISXgiZPoULh9dAFuzWJCORDdNs1JLEqM33gay1XUdMAcVFZaNDIhf+kzLKnh/W2Kp
         G2KbFqv0Q4JtZKNnYXftb8DY4PE9Mt/zZelBKcZkqAaw9ZQPq+AzfYTsOf15yAYffNQK
         pVGQpG3ZRqum7ZYksozGsBd8bLx4GZb9AJIawTZnW9GpJTcSM+7n+t4ZnBxHnSxvu6Ph
         f1ZlVctuJ7ZMf1rpQKLCy8NY3B0MtqrEtphcgw5/iBO5GW5t05fMK5QCMhas0krvpoVK
         xqQg==
X-Gm-Message-State: AOAM532aFnxwr94pr2huA5zoO+qEh3Z4EfF0nK7ux7spsTZVOt1+NMOj
        stNFXVLaRz52lWrjuk+2tcY8wQ==
X-Google-Smtp-Source: ABdhPJwLO4HFCK9suHur0GwSkoyOuSg6kDjsLGyUYf2tfkko0tHuU3kIyVhh7klL0KlXz4P9U6ePlg==
X-Received: by 2002:a37:5b84:: with SMTP id p126mr21326713qkb.142.1619490241227;
        Mon, 26 Apr 2021 19:24:01 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id i2sm13728602qtg.0.2021.04.26.19.23.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 26 Apr 2021 19:24:00 -0700 (PDT)
Date:   Mon, 26 Apr 2021 19:23:57 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Axel Rasmussen <axelrasmussen@google.com>
cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v4 04/10] userfaultfd/shmem: support minor fault registration
 for shmem
In-Reply-To: <20210420220804.486803-5-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104261920110.2998@eggly.anvils>
References: <20210420220804.486803-1-axelrasmussen@google.com> <20210420220804.486803-5-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 20 Apr 2021, Axel Rasmussen wrote:

> This patch allows shmem-backed VMAs to be registered for minor faults.
> Minor faults are appropriately relayed to userspace in the fault path,
> for VMAs with the relevant flag.
> 
> This commit doesn't hook up the UFFDIO_CONTINUE ioctl for shmem-backed
> minor faults, though, so userspace doesn't yet have a way to resolve
> such faults.
> 
> Acked-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

And if this "04/10" had been numbered 03/10, I would have said
Acked-by: Hugh Dickins <hughd@google.com>

Just read the comment above: "so userspace doesn't yet have a way to
resolve such faults" - if it doesn't by this stage, we're in trouble.

> ---
>  fs/userfaultfd.c                 |  6 +++---
>  include/uapi/linux/userfaultfd.h |  7 ++++++-
>  mm/memory.c                      |  8 +++++---
>  mm/shmem.c                       | 12 +++++++++++-
>  4 files changed, 25 insertions(+), 8 deletions(-)
