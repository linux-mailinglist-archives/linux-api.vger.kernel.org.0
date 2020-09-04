Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D03D25E416
	for <lists+linux-api@lfdr.de>; Sat,  5 Sep 2020 01:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgIDXRY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 19:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbgIDXRX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 4 Sep 2020 19:17:23 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FDA214F1
        for <linux-api@vger.kernel.org>; Fri,  4 Sep 2020 23:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599261441;
        bh=e6/KXRi6ed8KJBr+ogYQ8xztR4FSRcHEfP0ZPflsq50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bFc5aJejvyTXXZ1h9e6QplU9EtxUM2BziFEqyluwiP3PjTYvee9/ivcg24ElP91HT
         nos0MtfFbj4tzdI4+GMP+FibphDPkilci8IAj0Tz8/gJrAsV0ga5ZMrnJpSbogQNfZ
         1LKhVWXCyS51JEa65NhcuWNvtVCCLxQok2W+OquI=
Received: by mail-wm1-f44.google.com with SMTP id o21so8235223wmc.0
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 16:17:21 -0700 (PDT)
X-Gm-Message-State: AOAM532GqrMxOFXp0TI/cx1eNJZm0c5+iLtqrX/7EZgfwuW5fTA5OE2w
        FWSenD59TJ8l9AKNstK3ju4Cs5UFvcvgg2LL6c69Xg==
X-Google-Smtp-Source: ABdhPJwXEZDR79uh80tJQK6eDLpo5czf20qXoHjC0rfq+roaGtfbAo1BqN6sPBwcwbZ0WoyObNWA84hpB/ulNHe/Aqg=
X-Received: by 2002:a1c:7e02:: with SMTP id z2mr9688126wmc.138.1599261439657;
 Fri, 04 Sep 2020 16:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
 <70D23368-A24D-4A15-8FC7-FA728D102475@amacapital.net> <836cff86-e670-8c69-6cbd-b22c5b5538df@redhat.com>
In-Reply-To: <836cff86-e670-8c69-6cbd-b22c5b5538df@redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 4 Sep 2020 16:17:08 -0700
X-Gmail-Original-Message-ID: <CALCETrUcxFJzN_Vz7qe+79eg8033+uUKOAAMEVj-cB1Gp6pouw@mail.gmail.com>
Message-ID: <CALCETrUcxFJzN_Vz7qe+79eg8033+uUKOAAMEVj-cB1Gp6pouw@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        =?UTF-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 4, 2020 at 2:59 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/09/20 22:34, Andy Lutomirski wrote:
> > On Sep 4, 2020, at 1:09 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >> =EF=BB=BFOn 04/09/20 21:39, Andy Lutomirski wrote:
> >>> I'm a little concerned
> >>> that it's actually too clever and that maybe a more
> >>> straightforward solution should be investigated.  I personally
> >>> rather dislike the KVM model in which the guest address space
> >>> mirrors the host (QEMU) address space rather than being its own
> >>> thing.  In particular, the current model means that
> >>> extra-special-strange mappings like SEV-encrypted memory are
> >>> required to be present in the QEMU page tables in order for the
> >>> guest to see them. (If I had noticed that last bit before it went
> >>> upstream, I would have NAKked it.  I would still like to see it
> >>> deprecated and ideally eventually removed from the kernel.  We
> >>> have absolutely no business creating incoherent mappings like
> >>> this.)
> >>
> >> NACK first and ask second, right Andy?  I see that nothing has
> >> changed since Alan Cox left Linux.
> >
> > NACKs are negotiable.  And maybe someone can convince me that the SEV
> > mapping scheme is reasonable, but I would be surprised.
>
> So why say NACK?  Any half-decent maintainer would hold on merging the
> patches at least until the discussion is over.  Also I suppose any
> deprecation proposal should come with a description of an alternative.

I suppose that's a fair point.

>
> Anyway, for SEV the problem is DMA.  There is no way to know in advance
> which memory the guest will use for I/O; it can change at any time and
> the same host-physical address can even be mapped both as C=3D0 and C=3D1=
 by
> the guest.  There's no communication protocol between the guest and the
> host to tell the host _which_ memory should be mapped in QEMU.  (One was
> added to support migration, but that doesn't even work with SEV-ES
> processors where migration is planned to happen mostly with help from
> the guest, either in the firmware or somewhere else).

There's sev_pin_memory(), so QEMU must have at least some idea of
which memory could potentially be encrypted.  Is it in fact the case
that QEMU doesn't know that some SEV pinned memory might actually be
used for DMA until the guest tries to do DMA on that memory?  If so,
yuck.

>
> But this is a digression.  (If you would like to continue the discussion
> please trim the recipient list and change the subject).

Fair enough.  And my apologies for bring grumpier about SEV than was called=
 for.

>
> > Regardless, you seem to be suggesting that you want to have enclave
> > VMs in which the enclave can see some memory that the parent VM can=E2=
=80=99t
> > see. How does this fit into the KVM mapping model?  How does this
> > remote mapping mechanism help?  Do you want QEMU to have that memory
> > mapped in its own pagetables?
>
> There are three processes:
>
> - the manager, which is the parent of the VMs and uses the pidfd_mem
> system call
>
> - the primary VM
>
> - the enclave VM(s)
>
> The primary VM and the enclave VM(s) would each get a different memory
> access file descriptor.  QEMU would treat them no differently from any
> other externally-provided memory backend, say hugetlbfs or memfd, so
> yeah they would be mmap-ed to userspace and the host virtual address
> passed as usual to KVM.

Would the VM processes mmap() these descriptors, or would KVM learn
how to handle that memory without it being mapped?

>
> Enclave VMs could be used to store secrets and perform crypto for
> example.  The enclave is measured at boot, any keys or other stuff it
> needs can be provided out-of-band from the manager
>
> The manager can decide at any time to hide some memory from the parent
> VM (in order to give it to an enclave).  This would actually be done on
>  request of the parent VM itself, and QEMU would probably be so kind as
> to replace the "hole" left in the guest memory with zeroes.  But QEMU is
> untrusted, so the manager cannot rely on QEMU behaving well.  Hence the
>  privilege separation model that was implemented here.

How does this work?  Is there a revoke mechanism, or does the parent
just munmap() the memory itself?

>
> Actually Amazon has already created something like that and Andra-Irina
> Paraschiv has posted patches on the list for this.  Their implementation
> is not open source, but this pidfd-mem concept is something that Andra,
> Alexander Graf and I came up with as a way to 1) reimplement the feature
> upstream and 2) satisfy Bitdefender's need for memory introspection 3)
> add what seemed a useful interface anyway, for example to replace
> PTRACE_{PEEK,POKE}DATA.  Though (3) would only need pread/pwrite, not
> mmap which adds a lot of the complexity.
>
> > As it stands, the way that KVM memory mappings are created seems to
> > be convenient, but it also seems to be resulting in increasing
> > bizarre userspace mappings.  At what point is the right solution to
> > decouple KVM=E2=80=99s mappings from QEMU=E2=80=99s?
>
> So what you are suggesting is that KVM manages its own address space
> instead of host virtual addresses (and with no relationship to host
> virtual addresses, it would be just a "cookie")?  It would then need a
> couple ioctls to mmap/munmap (creating and deleting VMAs) into the
> address space, and those cookies would be passed to
> KVM_SET_USER_MEMORY_REGION.  QEMU would still need access to these VMAs,
> would it mmap a file descriptor provided by KVM?  All in all the
> implementation seems quite complex, and I don't understand why it would
> avoid incoherent SEV mappings; what am I missing?

It might not avoid incoherent SEV mappings in particular, but it would
certainly enable other, somewhat related usecases.  For example, QEMU
could have KVM map a memfd without itself mapping that memfd, which
would reduce the extent to which the memory would be exposed to an
attacker who can read QEMU memory.

For this pidfd-mem scheme in particular, it might avoid the nasty
corner case I mentioned.  With pidfd-mem as in this patchset, I'm
concerned about what happens when process A maps some process B
memory, process B maps some of process A's memory, and there's a
recursive mapping that results.  Or when a process maps its own
memory, for that matter.  If KVM could map fd's directly, then there
could be a parallel mechanism for KVM to import portions of more than
one process's address space, and this particular problem would be
avoided.  So a process would create pidfd-mem-like object and pass
that to KVM (via an intermediary process or directly) and KVM could
map that, but no normal process would be allowed to map it.  This
avoids the recursion problems.

Or memfd could get fancier with operations to split memfds, remove
pages from memfds, etc.  Maybe that's overkill.

(Or a fancy recursion detector could be built, but this has been a
pain point in AF_UNIX, epoll, etc in the past.  It may be solvable,
but it won't be pretty.)

I admit that allowing KVM to map fd's directly without some specific
vm_operations support for this could be challenging, but ISTM kvm
could plausibly own an mm_struct and pagetables at the cost of some
wasted memory.  The result would, under the hood, work more or less
like the current implementation, but the API would be quite different.

>
> Paolo
>
