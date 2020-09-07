Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C2E2605DE
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 22:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgIGUoD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 16:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgIGUoD (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 7 Sep 2020 16:44:03 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A909215A4
        for <linux-api@vger.kernel.org>; Mon,  7 Sep 2020 20:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599511442;
        bh=MCVTKtLEHzP4Rwjmh0FawcGIlox9ccdzsQ40S2dyu/c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=slVWam5LIC5G07eLJ8otjUmWPLdKHVH/EedkIQw7Plub564NnfNMdHijyx4JjTSP7
         GIvzW1Kd+UvoKW55L99oeLV4mT0RyigAYFBSe1qOXPFalxQ+L6kcfEVeI19nbzay2h
         EnwiP5b0PLVp3WaIgmSKOFu4hMDeuYjh/teHp+vM=
Received: by mail-wm1-f43.google.com with SMTP id y15so2584180wmi.0
        for <linux-api@vger.kernel.org>; Mon, 07 Sep 2020 13:44:02 -0700 (PDT)
X-Gm-Message-State: AOAM533X0k1fFgdC8gbNjY3OHtVfP6F8/xg2203nhWLp9C2kXxOrI+T9
        7GdGOrVGDzA6XLTV5tTvKQHgAlCs/cdJcyVaBxv3qA==
X-Google-Smtp-Source: ABdhPJzbwOk7GA9l9UAdPTz5URhOCp3ZUuG6FeZGVy45FAugqBEdQtPbk7kKiz9DitWp0Qb3raiOHQ9iX2aBHOI0HUk=
X-Received: by 2002:a05:600c:2183:: with SMTP id e3mr1063353wme.49.1599511440878;
 Mon, 07 Sep 2020 13:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200904113116.20648-1-alazar@bitdefender.com> <20200907150547.hst4luvrpntdb3lr@wittgenstein>
In-Reply-To: <20200907150547.hst4luvrpntdb3lr@wittgenstein>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 7 Sep 2020 13:43:48 -0700
X-Gmail-Original-Message-ID: <CALCETrUSUp_7svg8EHNTk3nQ0x9sdzMCU=h8G-Sy6=SODq5GHg@mail.gmail.com>
Message-ID: <CALCETrUSUp_7svg8EHNTk3nQ0x9sdzMCU=h8G-Sy6=SODq5GHg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     =?UTF-8?Q?Adalbert_Laz=C4=83r?= <alazar@bitdefender.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?TWloYWkgRG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Sep 7, 2020 at 8:05 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Fri, Sep 04, 2020 at 02:31:11PM +0300, Adalbert Laz=C4=83r wrote:
> > This patchset adds support for the remote mapping feature.
> > Remote mapping, as its name suggests, is a means for transparent and
> > zero-copy access of a remote process' address space.
> > access of a remote process' address space.
> >
> > The feature was designed according to a specification suggested by
> > Paolo Bonzini:
> > >> The proposed API is a new pidfd system call, through which the paren=
t
> > >> can map portions of its virtual address space into a file descriptor
> > >> and then pass that file descriptor to a child.
> > >>
> > >> This should be:
> > >>
> > >> - upstreamable, pidfd is the new cool thing and we could sell it as =
a
> > >> better way to do PTRACE_{PEEK,POKE}DATA
>
> In all honesty, that sentence made me a bit uneasy as it reads like this
> is implemented on top of pidfds because it makes it more likely to go
> upstream not because it is the right design. To be clear, I'm not
> implying any sort of malicious intent on your part but I would suggest
> to phrase this a little better. :)


I thought about this whole thing some more, and here are some thoughts.

First, I was nervous about two things.  One was faulting in pages from
the wrong context.  (When a normal page fault or KVM faults in a page,
the mm is loaded.  (In the KVM case, the mm is sort of not loaded when
the actual fault happens, but the mm is loaded when the fault is
handled, I think.  Maybe there are workqueues involved and I'm wrong.)
 When a remote mapping faults in a page, the mm is *not* loaded.)
This ought not to be a problem, though -- get_user_pages_remote() also
faults in pages from a non-current mm, and that's at least supposed to
work correctly, so maybe this is okay.

Second is recursion.  I think this is a genuine problem.

And I think that tying this to pidfds is the wrong approach.  In fact,
tying it to processes at all seems wrong.  There is a lot of demand
for various forms of memory isolation in which memory is mapped only
by its intended user.  Using something tied to a process mm gets in
the way of this in the same way that KVM's current mapping model gets
in the way.

All that being said, I think the whole idea of making fancy address
spaces composed from other mappable objects is neat and possibly quite
useful.  And, if you squint a bit, this is a lot like what KVM does
today.

So I suggest something that may be more generally useful as an
alternative.  This is a sketch and very subject to bikeshedding:

Create an empty address space:

int address_space_create(int flags, etc);

Map an fd into an address space:

int address_space_mmap(int asfd, int fd_to_map, offset, size, prot,
...);  /* might run out of args here */

Unmap from an address space:

int address_space_munmap(int asfd, unsigned long addr, unsigned long len);

Stick an address space into KVM:

ioctl(vmfd, KVM_MAP_ADDRESS_SPACE, asfd);  /* or similar */

Maybe some day allow mapping an address space into a process.

mmap(..., asfd, ...);


And at least for now, there's a rule that an address space that is
address_space_mmapped into an address space is disallowed.


Maybe some day we also allow mremap(), madvise(), etc.  And maybe some
day we allow creating a special address_space that represents a real
process's address space.


Under the hood, an address_space could own an mm_struct that is not
used by any tasks.  And we could have special memfds that are bound to
a VM such that all you can do with them is stick them into an
address_space and map that address_space into the VM in question.  For
this to work, we would want a special vm_operation for mapping into a
VM.


What do you all think?  Is this useful?  Does it solve your problems?
Is it a good approach going forward?
