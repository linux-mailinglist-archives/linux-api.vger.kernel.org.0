Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B0736C8E6
	for <lists+linux-api@lfdr.de>; Tue, 27 Apr 2021 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236465AbhD0PzG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 27 Apr 2021 11:55:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48220 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234932AbhD0PzE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Apr 2021 11:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619538860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2EAyRlyPf7sFuC/hgHV65Ah6f40dk7Oz+0C6LVfX60=;
        b=Umcgh4d7jLM4rrJZP1qHMUA9yCzNESquu+rEWCx41UBNI3ptHWgWpTm4clIwu/hOGho70w
        r+2Wb3v9LT4LwwbljS6TltAyUbjIumo0wqjnlbixrE44aqhZMfTDOdMo7Helz1Vl19Cb54
        KM/7zx3HHS+nPR4qbXKUsNZ4FnG1EQ8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-skK4X3JQOCmsMZs8qXN04g-1; Tue, 27 Apr 2021 11:54:17 -0400
X-MC-Unique: skK4X3JQOCmsMZs8qXN04g-1
Received: by mail-qv1-f71.google.com with SMTP id w9-20020a0cdf890000b029019aa511c767so3855556qvl.18
        for <linux-api@vger.kernel.org>; Tue, 27 Apr 2021 08:54:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F2EAyRlyPf7sFuC/hgHV65Ah6f40dk7Oz+0C6LVfX60=;
        b=mT7odtBDNtM0wgCdoK5ewz8X+PevwjKf6XjeIvIIZlvumktTt06CsxzSJ7v1icKmxK
         ant4LwkXvB7OkEdkXThYgiVD+vdKn3QnmZ+K/200+8KFhV0M8hgzVy0oMCnZndxLG6wB
         l3P40HROkWw2Bll1+eT9U+u/MqYBHx0gKybAlM2WKMbSQahOAREcGtWvCWqPqOg5c335
         Q7hXD6ltq7UQYirHM+ylP0bMqFjHazEpdYK58dGCkE0fXeXpAIVBkdCaLXDoYNU/ysVy
         Qa1a1WmDAuaKqdP+Kw8UfwXm16zlFjsDQYohG1L352BqPjxO6B4YmPj4AJE2Cb0xhtCe
         +ekQ==
X-Gm-Message-State: AOAM5305iGjraxtd5739v4BFCLG/KAwsou+5ySj30ubEJELCvo0vndCE
        uin2KiexlYD/GNqCxHylZyObJT5eW0X8UkqlEsm0yYy9cI/uKtUGQ9P4+EqoMPefaSqkW8AOza/
        sWNcerkz2usl1jCMcdJHC
X-Received: by 2002:ac8:4455:: with SMTP id m21mr11149097qtn.192.1619538857286;
        Tue, 27 Apr 2021 08:54:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjPXLMKWECur9Mqt8jATos9gtIg5JYkYXdpYunNG2EodbYnflzFS1Fc8CUzF2HNgSB2Ko5hg==
X-Received: by 2002:ac8:4455:: with SMTP id m21mr11149060qtn.192.1619538857004;
        Tue, 27 Apr 2021 08:54:17 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id f24sm167754qto.45.2021.04.27.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 08:54:16 -0700 (PDT)
Date:   Tue, 27 Apr 2021 11:54:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v4 03/10] userfaultfd/shmem: support UFFDIO_CONTINUE for
 shmem
Message-ID: <20210427155414.GB6820@xz-x1>
References: <20210420220804.486803-1-axelrasmussen@google.com>
 <20210420220804.486803-4-axelrasmussen@google.com>
 <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2104261906390.2998@eggly.anvils>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 26, 2021 at 07:19:58PM -0700, Hugh Dickins wrote:
> On Tue, 20 Apr 2021, Axel Rasmussen wrote:
> 
> > With this change, userspace can resolve a minor fault within a
> > shmem-backed area with a UFFDIO_CONTINUE ioctl. The semantics for this
> > match those for hugetlbfs - we look up the existing page in the page
> > cache, and install a PTE for it.
> > 
> > This commit introduces a new helper: mcopy_atomic_install_pte.
> > 
> > Why handle UFFDIO_CONTINUE for shmem in mm/userfaultfd.c, instead of in
> > shmem.c? The existing userfault implementation only relies on shmem.c
> > for VM_SHARED VMAs. However, minor fault handling / CONTINUE work just
> > fine for !VM_SHARED VMAs as well. We'd prefer to handle CONTINUE for
> > shmem in one place, regardless of shared/private (to reduce code
> > duplication).
> > 
> > Why add a new mcopy_atomic_install_pte helper? A problem we have with
> > continue is that shmem_mcopy_atomic_pte() and mcopy_atomic_pte() are
> > *close* to what we want, but not exactly. We do want to setup the PTEs
> > in a CONTINUE operation, but we don't want to e.g. allocate a new page,
> > charge it (e.g. to the shmem inode), manipulate various flags, etc. Also
> > we have the problem stated above: shmem_mcopy_atomic_pte() and
> > mcopy_atomic_pte() both handle one-half of the problem (shared /
> > private) continue cares about. So, introduce mcontinue_atomic_pte(), to
> > handle all of the shmem continue cases. Introduce the helper so it
> > doesn't duplicate code with mcopy_atomic_pte().
> > 
> > In a future commit, shmem_mcopy_atomic_pte() will also be modified to
> > use this new helper. However, since this is a bigger refactor, it seems
> > most clear to do it as a separate change.
> > 
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> 
> If this "03/10" had been numbered 04/10, I would have said
> Acked-by: Hugh Dickins <hughd@google.com>
> 
> But I find this new ordering incomprehensible - I'm surprised that it
> even builds this way around (if it does): this patch is so much about
> what has been enabled in "04/10" (references to UFFDIO_CONTINUE shmem
> VMAs etc).
> 
> Does Peter still think this way round is better? If he does, then we
> shall have to compromise by asking you just to squash the two together.

Hi, Hugh, Axel,

I have no strong opinion. To me, UFFDIO_CONTINUE can be introduced earlier like
this. As long as we don't enable the feature (which is done in the next patch),
no one will be able to call it, then it looks clean.  Merging them also looks
good to me.

Thanks,

-- 
Peter Xu

