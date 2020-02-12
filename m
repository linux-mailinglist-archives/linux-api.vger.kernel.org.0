Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79AE515B4F4
	for <lists+linux-api@lfdr.de>; Thu, 13 Feb 2020 00:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbgBLXld (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 12 Feb 2020 18:41:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729185AbgBLXlc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 12 Feb 2020 18:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581550891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQDr5ebf155fcZ1EU9k3LjSOmIORyHdnxl3xLxcFMjY=;
        b=eMdIVKSnfwBpGzSGT4vlqXKTSBicg/9yEtLUke74+Kt/HzKJbwzTZJmNE6LOOn2/Vqb2MJ
        1eZ0fi9AAAfW3DaeAQfyGr+EjlvTnEyiSEE0s4x4L+pHh8RU/iNoI8NNm2TBUpucHItE+/
        OyAj/6XyE+cY1z0LbeTzM9hI2nfoz4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-wq3_P8QhNASyMq3xTcID_Q-1; Wed, 12 Feb 2020 18:41:25 -0500
X-MC-Unique: wq3_P8QhNASyMq3xTcID_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56A62107ACC5;
        Wed, 12 Feb 2020 23:41:23 +0000 (UTC)
Received: from mail (ovpn-122-89.rdu2.redhat.com [10.10.122.89])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83EA91001281;
        Wed, 12 Feb 2020 23:41:20 +0000 (UTC)
Date:   Wed, 12 Feb 2020 18:41:19 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20200212234119.GB29809@redhat.com>
References: <20200211225547.235083-1-dancol@google.com>
 <202002112332.BE71455@keescook>
 <CAG48ez0ogRxvCK1aCnviN+nBqp6gmbUD7NjaMKvA7bF=esAc1A@mail.gmail.com>
 <20200212171416.GD1083891@xz-x1>
 <20200212194100.GA29809@redhat.com>
 <CAKOZuevusieaKCt5r-jnQ5ArGfw5Otszq2CAcrqFi6MYxkKwtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuevusieaKCt5r-jnQ5ArGfw5Otszq2CAcrqFi6MYxkKwtA@mail.gmail.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Daniel,

On Wed, Feb 12, 2020 at 12:04:39PM -0800, Daniel Colascione wrote:
> We don't pass pointers to the heap into system calls. (Big primitive
> arrays, ByteBuffer, etc. are allocated off the regular heap.)

That sounds pretty restrictive, I wonder what you gain by enforcing
that invariant or if it just happened incidentally for some other
reason?  Do you need to copy that memory every time if you need to do
I/O on it? Are you sure this won't need to change any time soon to
increase performance?

> I don't understand what you mean. The purpose of preventing UFFD from
> handling kernel faults is exploit mitigation.

That part was clear. What wasn't clear is what the new feature
does exactly and what it blocks, because it's all about blocking or
how does it make things more secure?

> The key requirement here is the ability to prevent unprivileged
> processes from using UFFD to widen kernel exploit windows by
> preventing UFFD from taking kernel faults. Forcing unprivileged
> processes to use UFFD only with UFFD_FEATURE_SIGBUS would satisfy this
> requirement, but it's much less flexible and unnecessarily couples two
> features.

I mentioned it in case you could use something like that model.

> > On the other end I'm also planning a mremap_vma_merge userland syscall
> > that will merge fragmented vmas.
> 
> This is probably a separate discussion, but does that operation really
> need to be a system call? Historically, userspace has operated mostly

mremap_vma_merge was not intended as a system call, if implemented as
a system call it wouldn't use uffd.

> on page ranges and not VMAs per se, and the kernel has been free to

Userland doesn't need to know anything.. unless it wants to optimize.

The userland can know full well if it does certain mremap operations
and puts its ranges virtually contiguous in a non linear way, so that
the kernel cannot merge the vmas.

> merge and split VMAs as needed for its internal purposes. This
> approach has serious negative side effects (like making munmap
> fallible: see [1]), but it is what it is.
> 
> [1] https://lore.kernel.org/linux-mm/CAKOZuetOD6MkGPVvYFLj5RXh200FaDyu3sQqZviVRhTFFS3fjA@mail.gmail.com/

The fact it's fallible is a secondary concern here. Even if you make
it unlimited, if it grows it slowdown everything and also prevents THP
to be collapsed. Even the scalability of the mmap_sem worsens.

> > Currently once you have a nice heap all contiguous but with small
> > objects and you free the fragments you can't build THP anymore even if
> > you make the memory virtually contiguous again by calling mremap. That
> > just build up a ton of vmas slowing down the app forever and also
> > preventing THP collapsing ever again.
> 
> Shouldn't the THP background kthread take care of merging VMAs?

The solution can't depend on any THP feature, because the buildup of
vmas is a scalability issue and a performance regression over time
even if THP is not configured in the kernel. However once that's
solved THP also gets naturally optimized.

What should happen (in my view) is just the simplest solution that can
defrag and forcefully merge the vmas without having to stop or restart
the app.

> Presumably, those apps wouldn't issue the system call on address
> ranges managed with a non-kernel-fault UFFD.

So the new security feature won't have to block kernel faults on those
apps and they can run side by side with the blocked app?

> We shouldn't be fragmenting at all, either at the memory level or the
> VMA level. The GC is a moving collector, and we don't punch holes in
> the heap.

That sounds good.

Thanks,
Andrea

