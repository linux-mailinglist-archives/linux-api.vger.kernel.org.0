Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C433EA55F
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 22:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfJ3V2h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Oct 2019 17:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfJ3V2h (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 30 Oct 2019 17:28:37 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDF2721924
        for <linux-api@vger.kernel.org>; Wed, 30 Oct 2019 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572470916;
        bh=XnMIsHcVdwBeAptKPGJSNsffx0HxomByGS8vfIyd67I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GcWeTabOhXFFYmG9IuepIBfPV5QRfttQWMLS1Y6Rk8rh2vTkVAkEhB6Um3JyKeqy4
         LNs6p/NikovmiHK4i1587lHitpzbIZZEceZQnp9MC1Dd+FLh2eEfMYUuuLrCU/z23G
         d6YvUwcSinsTp5iE3gKiIYHIUUNColKmb8wgsW14=
Received: by mail-wr1-f41.google.com with SMTP id e6so2134866wrw.1
        for <linux-api@vger.kernel.org>; Wed, 30 Oct 2019 14:28:35 -0700 (PDT)
X-Gm-Message-State: APjAAAWnOtxfFdzs9bkZGYjNUYTSLuUGdpa7MlKEhy0P/x2DLh+XZ8L1
        Xiw5D223KKuyxLXDfaLhA05BMfRrxuVLm26Sdz86ow==
X-Google-Smtp-Source: APXvYqxL52nW7f18FABq7zaYN4yb2n3VI3Wgyrkk3D0RE6Z3WVzN667TLF9aXzvjCfAynZrgm0oE0wYz3oOaoK5HeOI=
X-Received: by 2002:adf:f342:: with SMTP id e2mr1983177wrp.61.1572470914076;
 Wed, 30 Oct 2019 14:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <1572171452-7958-1-git-send-email-rppt@kernel.org>
 <CA5C22D9-BC3E-4B69-8DD9-4D3B75E40BD5@amacapital.net> <20191029093254.GE18773@rapoport-lnx>
 <CALCETrUuuc4DS0cdMBtS550Wkp0x9ND3M3SgtaMgyRROnDR5Kg@mail.gmail.com> <20191030084005.GC20624@rapoport-lnx>
In-Reply-To: <20191030084005.GC20624@rapoport-lnx>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 30 Oct 2019 14:28:21 -0700
X-Gmail-Original-Message-ID: <CALCETrXajrY+0SmzkL7t++ndYwRoYLLE9VPKwSGSyW8HZx-TeA@mail.gmail.com>
Message-ID: <CALCETrXajrY+0SmzkL7t++ndYwRoYLLE9VPKwSGSyW8HZx-TeA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: add MAP_EXCLUSIVE to create exclusive user mappings
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 30, 2019 at 1:40 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, Oct 29, 2019 at 10:00:55AM -0700, Andy Lutomirski wrote:
> > On Tue, Oct 29, 2019 at 2:33 AM Mike Rapoport <rppt@kernel.org> wrote:
> > >
> > > On Mon, Oct 28, 2019 at 02:44:23PM -0600, Andy Lutomirski wrote:
> > > >
> > > > > On Oct 27, 2019, at 4:17 AM, Mike Rapoport <rppt@kernel.org> wrot=
e:
> > > > >
> > > > > =EF=BB=BFFrom: Mike Rapoport <rppt@linux.ibm.com>
> > > > >
> > > > > Hi,
> > > > >
> > > > > The patch below aims to allow applications to create mappins that=
 have
> > > > > pages visible only to the owning process. Such mappings could be =
used to
> > > > > store secrets so that these secrets are not visible neither to ot=
her
> > > > > processes nor to the kernel.
> > > > >
> > > > > I've only tested the basic functionality, the changes should be v=
erified
> > > > > against THP/migration/compaction. Yet, I'd appreciate early feedb=
ack.
> > > >
> > > > I=E2=80=99ve contemplated the concept a fair amount, and I think yo=
u should
> > > > consider a change to the API. In particular, rather than having it =
be a
> > > > MAP_ flag, make it a chardev.  You can, at least at first, allow on=
ly
> > > > MAP_SHARED, and admins can decide who gets to use it.  It might als=
o play
> > > > better with the VM overall, and you won=E2=80=99t need a VM_ flag f=
or it =E2=80=94 you
> > > > can just wire up .fault to do the right thing.
> > >
> > > I think mmap()/mprotect()/madvise() are the natural APIs for such
> > > interface.
> >
> > Then you have a whole bunch of questions to answer.  For example:
> >
> > What happens if you mprotect() or similar when the mapping is already
> > in use in a way that's incompatible with MAP_EXCLUSIVE?
>
> Then we refuse to mprotect()? Like in any other case when vm_flags are no=
t
> compatible with required madvise()/mprotect() operation.
>

I'm not talking about flags.  I'm talking about the case where one
thread (or RDMA or whatever) has get_user_pages()'d a mapping and
another thread mprotect()s it MAP_EXCLUSIVE.

> > Is it actually reasonable to malloc() some memory and then make it excl=
usive?
> >
> > Are you permitted to map a file MAP_EXCLUSIVE?  What does it mean?
>
> I'd limit MAP_EXCLUSIVE only to anonymous memory.
>
> > What does MAP_PRIVATE | MAP_EXCLUSIVE do?
>
> My preference is to have only mmap() and then the semantics is more clear=
:
>
> MAP_PRIVATE | MAP_EXCLUSIVE creates a pre-populated region, marks it lock=
ed
> and drops the pages in this region from the direct map.
> The pages are returned back on munmap().
> Then there is no way to change an existing area to be exclusive or vice
> versa.

And what happens if you fork()?  Limiting it to MAP_SHARED |
MAP_EXCLUSIVE would about this particular nasty question.

>
> > How does one pass exclusive memory via SCM_RIGHTS?  (If it's a
> > memfd-like or chardev interface, it's trivial.  mmap(), not so much.)
>
> Why passing such memory via SCM_RIGHTS would be useful?

Suppose I want to put a secret into exclusive memory and then send
that secret to some other process.  The obvious approach would be to
SCM_RIGHTS an fd over, but you can't do that with MAP_EXCLUSIVE as
you've defined it.  In general, there are lots of use cases for memfd
and other fd-backed memory.

>
> > And finally, there's my personal giant pet peeve: a major use of this
> > will be for virtualization.  I suspect that a lot of people would like
> > the majority of KVM guest memory to be unmapped from the host
> > pagetables.  But people might also like for guest memory to be
> > unmapped in *QEMU's* pagetables, and mmap() is a basically worthless
> > interface for this.  Getting fd-backed memory into a guest will take
> > some possibly major work in the kernel, but getting vma-backed memory
> > into a guest without mapping it in the host user address space seems
> > much, much worse.
>
> Well, in my view, the MAP_EXCLUSIVE is intended to keep small secrets
> rather than use it for the entire guest memory. I even considered adding =
a
> limit for the mapping size, but then I decided that since RLIMIT_MEMLOCK =
is
> anyway enforced there is no need for a new one.
>
> I agree that getting fd-backed memory into a guest would be less pain tha=
t
> VMA, but KVM can already use memory outside the control of the kernel via
> /dev/map [1].

That series doesn't address the problem I'm talking about at all.  I'm
saying that there is a legitimate use case where QEMU should *not*
have a mapping of the memory.  So QEMU would create some exclusive
memory using /dev/exclusive_memory and would tell KVM to map it into
the guest without mapping it into QEMU's address space at all.

(In fact, the way that SEV currently works is *functionally* like
this, except that there's a bogus incoherent mapping in the QEMU
process that is a giant can of worms.


IMO a major benefit of a chardev approach is that you don't need a new
VM_ flag and you don't need to worry about wiring it up everywhere in
the core mm code.
