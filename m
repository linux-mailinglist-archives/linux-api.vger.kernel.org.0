Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF63FE9845
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 09:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfJ3IkP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 04:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbfJ3IkP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Oct 2019 04:40:15 -0400
Received: from rapoport-lnx (190.228.71.37.rev.sfr.net [37.71.228.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04AFE20856;
        Wed, 30 Oct 2019 08:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572424814;
        bh=/nCth3tAN3zo9YpLVlMHUApCRm+0ZcTx184ZTc9xlgM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nesn8HlZl7oj3aP21LaeInYQ+pjC5N1ru/Ic4LIsTmwnHs/f8XRQSOkx71rnYe1Au
         RSpTABrOh3VDdlU2zTYQNbqqVTXVwsnRNGFTBvg7cUfwoi8YwW1psOJ5Z6Fbj5mZP2
         f+9qYKTxXa82mHdjLJcKrDzqXxxuQtR9XPh7IhV0=
Date:   Wed, 30 Oct 2019 09:40:06 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, X86 ML <x86@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user
 mappings
Message-ID: <20191030084005.GC20624@rapoport-lnx>
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <CA5C22D9-BC3E-4B69-8DD9-4D3B75E40BD5@amacapital.net>
 <20191029093254.GE18773@rapoport-lnx>
 <CALCETrUuuc4DS0cdMBtS550Wkp0x9ND3M3SgtaMgyRROnDR5Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrUuuc4DS0cdMBtS550Wkp0x9ND3M3SgtaMgyRROnDR5Kg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 29, 2019 at 10:00:55AM -0700, Andy Lutomirski wrote:
> On Tue, Oct 29, 2019 at 2:33 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Mon, Oct 28, 2019 at 02:44:23PM -0600, Andy Lutomirski wrote:
> > >
> > > > On Oct 27, 2019, at 4:17 AM, Mike Rapoport <rppt@kernel.org> wrote:
> > > >
> > > > ﻿From: Mike Rapoport <rppt@linux.ibm.com>
> > > >
> > > > Hi,
> > > >
> > > > The patch below aims to allow applications to create mappins that have
> > > > pages visible only to the owning process. Such mappings could be used to
> > > > store secrets so that these secrets are not visible neither to other
> > > > processes nor to the kernel.
> > > >
> > > > I've only tested the basic functionality, the changes should be verified
> > > > against THP/migration/compaction. Yet, I'd appreciate early feedback.
> > >
> > > I’ve contemplated the concept a fair amount, and I think you should
> > > consider a change to the API. In particular, rather than having it be a
> > > MAP_ flag, make it a chardev.  You can, at least at first, allow only
> > > MAP_SHARED, and admins can decide who gets to use it.  It might also play
> > > better with the VM overall, and you won’t need a VM_ flag for it — you
> > > can just wire up .fault to do the right thing.
> >
> > I think mmap()/mprotect()/madvise() are the natural APIs for such
> > interface.
> 
> Then you have a whole bunch of questions to answer.  For example:
> 
> What happens if you mprotect() or similar when the mapping is already
> in use in a way that's incompatible with MAP_EXCLUSIVE?

Then we refuse to mprotect()? Like in any other case when vm_flags are not
compatible with required madvise()/mprotect() operation.

> Is it actually reasonable to malloc() some memory and then make it exclusive?
> 
> Are you permitted to map a file MAP_EXCLUSIVE?  What does it mean?

I'd limit MAP_EXCLUSIVE only to anonymous memory.

> What does MAP_PRIVATE | MAP_EXCLUSIVE do?

My preference is to have only mmap() and then the semantics is more clear:

MAP_PRIVATE | MAP_EXCLUSIVE creates a pre-populated region, marks it locked
and drops the pages in this region from the direct map.
The pages are returned back on munmap(). 
Then there is no way to change an existing area to be exclusive or vice
versa.

> How does one pass exclusive memory via SCM_RIGHTS?  (If it's a
> memfd-like or chardev interface, it's trivial.  mmap(), not so much.)

Why passing such memory via SCM_RIGHTS would be useful?
 
> And finally, there's my personal giant pet peeve: a major use of this
> will be for virtualization.  I suspect that a lot of people would like
> the majority of KVM guest memory to be unmapped from the host
> pagetables.  But people might also like for guest memory to be
> unmapped in *QEMU's* pagetables, and mmap() is a basically worthless
> interface for this.  Getting fd-backed memory into a guest will take
> some possibly major work in the kernel, but getting vma-backed memory
> into a guest without mapping it in the host user address space seems
> much, much worse.

Well, in my view, the MAP_EXCLUSIVE is intended to keep small secrets
rather than use it for the entire guest memory. I even considered adding a
limit for the mapping size, but then I decided that since RLIMIT_MEMLOCK is
anyway enforced there is no need for a new one.

I agree that getting fd-backed memory into a guest would be less pain that
VMA, but KVM can already use memory outside the control of the kernel via
/dev/map [1].

So unless I'm missing something here, there is no need to use MAP_EXCLUSIVE
for the guest memory.

[1] https://lwn.net/Articles/778240/

> > Switching to a chardev doesn't solve the major problem of direct
> > map fragmentation and defeats the ability to use exclusive memory mappings
> > with the existing allocators, while mprotect() and madvise() do not.
> >
> 
> Will people really want to do malloc() and then remap it exclusive?
> This sounds dubiously useful at best.

Again, my preference is to have mmap() only, but I see a value in this use
case as well. Application developers allocate memory and then sometimes
change its properties rather than go mmap() something. For such usage
mprotect() may be usefull.


-- 
Sincerely yours,
Mike.
