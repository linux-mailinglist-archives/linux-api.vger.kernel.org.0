Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E757FE2325
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 21:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfJWTKM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 15:10:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43289 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732234AbfJWTKK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 15:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571857808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSqYczFmAd6Ynxten2iqPGJFZ6CnAADv6AsKVu1TUHs=;
        b=eSg3rESo8/KmQtLMIQzXAJXXJrUcfD/cLgUEDeMZGFwwvayqsghP5cMbetvnrVSMg+wz9R
        370z0yn2h850jyIL/ldgOjbVOsBcMIGzm6134KdG02CUYFTTEW0+PhdZoyuM/BZOrToEa0
        Mvz34x5jeeXba6E4Hy9jnQuTXY3qeNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-ua7GK7FcMlSlXUjvoIwVMA-1; Wed, 23 Oct 2019 15:10:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD88D800D49;
        Wed, 23 Oct 2019 19:10:00 +0000 (UTC)
Received: from mail (ovpn-123-192.rdu2.redhat.com [10.10.123.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65D435DAAF;
        Wed, 23 Oct 2019 19:10:00 +0000 (UTC)
Date:   Wed, 23 Oct 2019 15:09:59 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
Message-ID: <20191023190959.GA9902@redhat.com>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ua7GK7FcMlSlXUjvoIwVMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

On Sat, Oct 12, 2019 at 06:14:23PM -0700, Andy Lutomirski wrote:
> [adding more people because this is going to be an ABI break, sigh]

That wouldn't break the ABI, no more than when if you boot a kernel
built with CONFIG_USERFAULTFD=3Dn.

All non-cooperative features can be removed any time in a backwards
compatible way, the only precaution is to mark their feature bits as
reserved so they can't be reused for something else later.

> least severely restricted.  A .read implementation MUST NOT ACT ON THE
> CALLING TASK.  Ever.  Just imagine the effect of passing a userfaultfd
> as stdin to a setuid program.

With UFFD_EVENT_FORK, the newly created uffd that controls the child,
is not passed to the parent nor to the child. Instead it's passed to
the CRIU monitor only, which has to be already running as root and is
fully trusted and acts a hypervisor (despite there is no hypervisor).

By the time execve runs and any suid bit in the execve'd inode becomes
relevant, well before the new userland executable code can run, the
kernel throws away the "old_mm" controlled by any uffd and all
attached uffds are released as well.

All I found is your "A .read implementation MUST NOT ACT ON THE
CALLING TASK" as an explanation that something is broken but I need
further clarification.

Of course I can see you can always open a uffd and pass it to any task
you are going to execve on, but that simply means the suid program
will be able to control you, not the other way around. If you don't
want to be controlled by the next task, no matter if suid or not, just
don't that. What I don't see is how you're going to control the suid
binary from the outside, the suid binary at most will block in the
poll, read and write syscalls and get garbage or write some garbage
and get an error, it won't get signals and it cannot block in any page
fault either, it's not immediately clear what's out of ordinary.

On Mon, Oct 14, 2019 at 06:04:22PM +0200, Jann Horn wrote:
> FWIW, <https://codesearch.debian.net/search?q=3DUFFD_FEATURE_EVENT_FORK&l=
iteral=3D1>
> just shows the kernel, kernel selftests, and strace code for decoding
> syscall arguments. CRIU uses it though (probably for postcopy live
> migration / lazy migration?), I guess that code isn't in debian for
> some reason.

https://criu.org/Userfaultfd#Limitations

The CRIU developers did a truly amazing job by making container post
copy live migration work great for a subset of apps, that alone was an
amazing achievement. Is that achievement enough to use post copy live
migration of bare metal containers in production? Unfortunately
probably not and not just in debian.

If you're wrong and UFFDIO_EVENT_FORK isn't currently buggy and in
turn it isn't causing further maintenance burden, there is no hurry of
removing them, but in the long term, if none of the non-cooperative
features find its way in production (like it was reasonable to expect
initially), they must be removed from the kernel anyway, not just
UFFD_EVEN_FORK but all non-cooperative features associated with it.

In my view the kernel is complex enough that we can't keep in the
kernel anything that isn't actively used in production.

If you're right and UFFDIO_EVENT_FORK is flawed beyond repair well
then we should remove all non cooperative features right now.

Or is someone out there using CRIU --lazy-pages in production?

Virtual machine machine postcopy live migration is shipped in
production for years and it's fully reliable and by design it cannot
suffer from any of the above limitations.

In my view there's simply no justification not to use virtual machines
when the alternative requires so much more code to be written and so
much more complexity to be dealt with.

However the higher complexity happened in lots areas of the kernel
already where things got extremely complex just to avoid using virtual
machines, despite the end result is less secure, for the only sake of
slightly higher consolidation (especially if you ignore the existence
millisecond guest boot time, direct mapped pmem nvdimm, virtfs and
free page hinting).

The non-cooperative features of userfaultfd in principle aren't
fundamentally different from other cgroup vs KVM tradeoffs, so 1) it
wasn't apparent they wouldn't be used in production eventually and 2)
it didn't sound fair enough not to give a chance to bare metal
containers to achieve feature parity with VM (again with a much higher
code complexity, but that was to be expected and it has apparently
been dealt with in other areas with more or less satisfactory
results).

While at it, as far as userfaultfd is concerned I'd rather see people
spend time to write a malloc library that uses userfaultfd with the
UFFD_FEATURE_SIGBUS features and it replaces mmap with UFFDIO_ZEROPAGE
(plus adding the THP accelleration currently missing) and munmap with
MADV_DONTNEED to do allocations and freeing of memory with full
scalability without ever hitting on the map sem for writing. This is
already possible without any further kernel change (the THP
accelleration to UFFDIO_ZEROPAGE will only make it go faster but it
could be done later after the lib already works because it'd be
invisible to userland).

On my side, instead of trying to fix whatever issue in
UFFD_EVENT_FORK, I'd prefer to spend my time reviewing the uffd-wp
feature from Peter and the page fault enhancement patchset that Peter
and Linus were discussing. uffd-wp has the potential to drop fork()
from all apps calling fork() only to do an atomic snapshot of their
memory. Replacing fork() also means the uffd manager thread can decide
how much memory to reserve to the snapshot and it can start throttling
waiting for I/O completion if the threshold is exceeded, while fork
COWs cannot throttle and all apps using fork() risk to hit on x2
memory usage which can become oom-killer material if the memory size
of the process is huge. The side benefit is also that the way
userfaultfd works the fault granularity is entirely in control of
userland (because it's always userland that resolves the fault), it
could decide to use 8k or 16k even if that doesn't match the hardware
page size. That will allow to keep THP on without risking to hit on 2M
cows during the snapshot. Being able to keep THP enabled in nosql db
without hitting on slow 2M COW copies during snapshot, should allow a
further overall performance improvement when the snapshot is not
running than what it is possible today. In a completely different use
case, uffd-wp will also avoid JITs to set a dirty bit every time they
modify any data in memory. It should also be possible to provide the
same soft-dirty information in O(1) instead of O(N).

Thanks,
Andrea

