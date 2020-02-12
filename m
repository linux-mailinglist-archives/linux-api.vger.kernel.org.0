Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5415B13A
	for <lists+linux-api@lfdr.de>; Wed, 12 Feb 2020 20:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgBLTlN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 14:41:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20617 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727361AbgBLTlM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 14:41:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581536471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/niUyGCzwKmL8P0YFidMu7QFy/0jVujYkp3YM5pI1SY=;
        b=giYfyWNcxyHRiDVjf8DWi3QX11vIaGpmWJxo5H/Wf9zwAmq2AJFbbD7ncZZ2gDx73mwcx+
        AglDG1/qPBJZ5sDmf+1mKHiV5puyqkQNw7CKUep8QwXUpukZFyOr69tUBo5LqvbR86n1yH
        WBzL4lum+VylPJvVNkhauHbp2Jep140=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-UosBqSVOMsOqpSSGjRWgwA-1; Wed, 12 Feb 2020 14:41:09 -0500
X-MC-Unique: UosBqSVOMsOqpSSGjRWgwA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0246A0CBF;
        Wed, 12 Feb 2020 19:41:06 +0000 (UTC)
Received: from mail (ovpn-122-89.rdu2.redhat.com [10.10.122.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EE086E40A;
        Wed, 12 Feb 2020 19:41:01 +0000 (UTC)
Date:   Wed, 12 Feb 2020 14:41:00 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Nick Kralevich <nnk@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Harden userfaultfd
Message-ID: <20200212194100.GA29809@redhat.com>
References: <20200211225547.235083-1-dancol@google.com>
 <202002112332.BE71455@keescook>
 <CAG48ez0ogRxvCK1aCnviN+nBqp6gmbUD7NjaMKvA7bF=esAc1A@mail.gmail.com>
 <20200212171416.GD1083891@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212171416.GD1083891@xz-x1>
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello everyone,

On Wed, Feb 12, 2020 at 12:14:16PM -0500, Peter Xu wrote:
> Right. AFAICT QEMU uses it far more than disk IOs.  A guest page can
> be accessed by any kernel component on the destination host during a
> postcopy procedure.  It can be as simple as when a vcpu writes to a
> missing guest page which still resides on the source host, then KVM
> will get a page fault and trap into userfaultfd asking for that page.
> The same thing happens to other modules like vhost, etc., as long as a
> missing guest page is touched by a kernel module.

Correct.

How does the android garbage collection work to make sure there cannot
be kernel faults on the missing memory?

If I understood correctly (I didn't have much time to review sorry)
what's proposed with regard to limiting uffd events from kernel
faults, the only use case I know that could deal with it is the
UFFD_FEATURE_SIGBUS but that's not normal userfaultfd: that's also the
only feature required from uffd to implement a pure malloc library in
userland that never takes the mmap sem for writing to implement
userland mremap/mmap/munmap lib calls (as those will convert to
UFFDIO_ZEROPAGE and MADV_DONTNEED internally to the lib and there will
be always a single vma). We just need to extend UFFDIO_ZEROPAGE to map
the THP zeropage to make this future pure-uffd malloc lib perform
better.

On the other end I'm also planning a mremap_vma_merge userland syscall
that will merge fragmented vmas.

Currently once you have a nice heap all contiguous but with small
objects and you free the fragments you can't build THP anymore even if
you make the memory virtually contiguous again by calling mremap. That
just build up a ton of vmas slowing down the app forever and also
preventing THP collapsing ever again.

mremap_vma_merge will require no new kernel feature, but it
fundamentally must be able to handle kernel faults. If databases
starts to use that, how can you enable this feature without breaking
random apps then?

So it'd be a feature usable only by one user (Android) perhaps? And
only until you start defragging the vmas of small objects?

Thanks,
Andrea

