Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B283F36CFD6
	for <lists+linux-api@lfdr.de>; Wed, 28 Apr 2021 02:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbhD1AEF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Apr 2021 20:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbhD1AEF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Apr 2021 20:04:05 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D9EC061760
        for <linux-api@vger.kernel.org>; Tue, 27 Apr 2021 17:03:21 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso55029836otb.13
        for <linux-api@vger.kernel.org>; Tue, 27 Apr 2021 17:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xacAZXww+/r1bYXmcQWffobgGN8QvzDcUp5VNbqVO2g=;
        b=h59I82pBb9CSjo53IXp5WlilB8BELyUyymcAkd7h7D/t8//pyn5b1QYqX/2KNcMMte
         AArc97JJ6OtqU61vD0xKuqULCy4SntW4x1jnWa8jX1jAdd7z1a0wvl+1c43Ax+tPfgvp
         GySDj+7ZVf0MRQwIc8xOBSN7GWeeDZr51l4ZLBjUw8ISAfdOPsh1RsUYMHRu3emXp16S
         Gzu3w9xqBLGrm+yukJsGw2+ETqrSRIQBfjrA3OwvGoxyReveyWDafwio18B05Vtjf3Yz
         LMxBS6XZ5bGhvFIKOJzoz3O2FEEUEmh7DDllLTRdPVLhtX+lZb+Nson3KQz/GNJPDKW9
         PIaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xacAZXww+/r1bYXmcQWffobgGN8QvzDcUp5VNbqVO2g=;
        b=Br4ApNtIORkr6eHvvr2zPN5KY4mA7P9nbZ5EWsFbZXKgYOTvui0Rllex3uPDZ6KtGX
         7OCxDKYRBULWMk9PSGn4PIaoV0bSDikosDIlSX/U7c6NbBbcJAOrjDnzwF8iHL9tyZGT
         m9OWzG72KGm1lET5/8jaT3/pEzRjVWO/CZeSmZ8hqGC4n0TYM7M3dcCh3UsuzqG9ypGA
         jWD+d8eABo9mPNE45o7E/LbbsuvmdLvy96VbHPmp/j8orDv8+7heZK+nBjH2dSnXqxUi
         o3FrrGtj52g5w9vAsowrqGTTvmVUVu6yoGDBnxFXWHJIECgd4o1GR5Y/u34+IWhd4MIZ
         +L6w==
X-Gm-Message-State: AOAM5307z1kcQxgt3iYAUWKWa7mXkCoL3Tv0pQps37pY3jB61xjdXOXW
        KA6HujopQ/b/EfmfLmiue0SzJw==
X-Google-Smtp-Source: ABdhPJzE3/VyNTj6Deb8Jn0iF9zjPFK3uybT4s/FTec9X68bbLS2maO9mVnotyq3tMx9A2f40jmlSA==
X-Received: by 2002:a9d:6c52:: with SMTP id g18mr20760460otq.29.1619568200397;
        Tue, 27 Apr 2021 17:03:20 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e12sm324759otq.46.2021.04.27.17.03.18
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Tue, 27 Apr 2021 17:03:20 -0700 (PDT)
Date:   Tue, 27 Apr 2021 17:03:17 -0700 (PDT)
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
Subject: Re: [PATCH v5 04/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
In-Reply-To: <20210427225244.4326-5-axelrasmussen@google.com>
Message-ID: <alpine.LSU.2.11.2104271702470.7111@eggly.anvils>
References: <20210427225244.4326-1-axelrasmussen@google.com> <20210427225244.4326-5-axelrasmussen@google.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 27 Apr 2021, Axel Rasmussen wrote:

> With this change, userspace can resolve a minor fault within a
> shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
> match those for hugetlbfs - we look up the existing page in the page
> cache, and install a PTE for it.
> 
> This commit introduces a new helper: mcopy_atomic_install_pte.
> 
> Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
> shmem.c? The existing userfault implementation only relies on shmem.c
> for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
> fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
> shmem in one place, regardless of shared/private (to reduce code
> duplication).
> 
> Why add a new mcopy_atomic_install_pte helper? A problem we have with
> continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
> *close* to what we want, but not exactly. We do want to setup the PTEs
> in a CONTINUE operation, but we don't want to e.g. allocate a new page,
> charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
> we have the problem stated above: shmem_mcopy_atomic_pte() and
> mcopy_atomic_pte() both handle one-half of the problem (shared /
> private) continue cares about. So, introduce mcontinue_atomic_pte(), to
> handle all of the shmem continue cases. Introduce the helper so it
> doesn't duplicate code with mcopy_atomic_pte().
> 
> In a future commit, shmem_mcopy_atomic_pte() will also be modified to
> use this new helper. However, since this is a bigger refactor, it seems
> most clear to do it as a separate change.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Acked-by: Hugh Dickins <hughd@google.com>

> ---
>  mm/userfaultfd.c | 172 ++++++++++++++++++++++++++++++++++-------------
>  1 file changed, 127 insertions(+), 45 deletions(-)
