Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5042525F572
	for <lists+linux-api@lfdr.de>; Mon,  7 Sep 2020 10:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgIGIiN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Sep 2020 04:38:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56560 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgIGIiM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Sep 2020 04:38:12 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFCf9-0004Rn-HI; Mon, 07 Sep 2020 08:38:07 +0000
Date:   Mon, 7 Sep 2020 10:38:06 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Adalbert =?utf-8?B?TGF6xINy?= <alazar@bitdefender.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Mihai =?utf-8?B?RG9uyJt1?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
Message-ID: <20200907083806.krehiwqtfiw42wmy@wittgenstein>
References: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
 <70D23368-A24D-4A15-8FC7-FA728D102475@amacapital.net>
 <836cff86-e670-8c69-6cbd-b22c5b5538df@redhat.com>
 <CALCETrUcxFJzN_Vz7qe+79eg8033+uUKOAAMEVj-cB1Gp6pouw@mail.gmail.com>
 <bbe80f23-86c5-9d8f-8144-f292a6fc81b4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bbe80f23-86c5-9d8f-8144-f292a6fc81b4@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Sep 05, 2020 at 08:27:29PM +0200, Paolo Bonzini wrote:
> On 05/09/20 01:17, Andy Lutomirski wrote:
> > There's sev_pin_memory(), so QEMU must have at least some idea of
> > which memory could potentially be encrypted.  Is it in fact the case
> > that QEMU doesn't know that some SEV pinned memory might actually be
> > used for DMA until the guest tries to do DMA on that memory?  If so,
> > yuck.
> 
> Yes.  All the memory is pinned, all the memory could potentially be used
> for DMA (of garbage if it's encrypted).  And it's the same for pretty
> much all protected VM extensions (SEV, POWER, s390, Intel TDX).
> 
> >> The primary VM and the enclave VM(s) would each get a different memory
> >> access file descriptor.  QEMU would treat them no differently from any
> >> other externally-provided memory backend, say hugetlbfs or memfd, so
> >> yeah they would be mmap-ed to userspace and the host virtual address
> >> passed as usual to KVM.
> > 
> > Would the VM processes mmap() these descriptors, or would KVM learn
> > how to handle that memory without it being mapped?
> 
> The idea is that the process mmaps them, QEMU would treat them just the
> same as a hugetlbfs file descriptor for example.
> 
> >> The manager can decide at any time to hide some memory from the parent
> >> VM (in order to give it to an enclave).  This would actually be done on
> >> request of the parent VM itself [...] But QEMU is
> >> untrusted, so the manager cannot rely on QEMU behaving well.  Hence the
> >> privilege separation model that was implemented here.
> > 
> > How does this work?  Is there a revoke mechanism, or does the parent
> > just munmap() the memory itself?
> 
> The parent has ioctls to add and remove memory from the pidfd-mem.  So
> unmapping is just calling the ioctl that removes a range.

I would strongly suggest we move away from ioctl() patterns. If
something like this comes up in the future, just propose them as system
calls.

> 
> >> So what you are suggesting is that KVM manages its own address space
> >> instead of host virtual addresses (and with no relationship to host
> >> virtual addresses, it would be just a "cookie")?
> > 
> > [...] For this pidfd-mem scheme in particular, it might avoid the nasty
> > corner case I mentioned.  With pidfd-mem as in this patchset, I'm
> > concerned about what happens when process A maps some process B
> > memory, process B maps some of process A's memory, and there's a
> > recursive mapping that results.  Or when a process maps its own
> > memory, for that matter.
> > 
> > Or memfd could get fancier with operations to split memfds, remove
> > pages from memfds, etc.  Maybe that's overkill.
> 
> Doing it directly with memfd is certainly an option, especially since
> MFD_HUGE_* exists.  Basically you'd have a system call to create a

I like that idea way better to be honest.

Christian
