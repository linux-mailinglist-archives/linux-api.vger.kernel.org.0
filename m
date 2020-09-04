Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6301B25E384
	for <lists+linux-api@lfdr.de>; Fri,  4 Sep 2020 23:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIDV7F (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 4 Sep 2020 17:59:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38037 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727057AbgIDV7F (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 Sep 2020 17:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599256742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EoZOJ7xWPzkIVlMZdJmR4Hwqzb4r1fE3xQ2uosOBZDI=;
        b=A1JlN9rO5waVizbbhLJY3soMSmtrj+Pq5+yRWZX+niD90u4llvGXY58mMl5YUEY7eiYFoH
        224d9QwaU5B6jmowib4tjAAXJLbPmxi5DMHh4MIA6Y5+SZztxPSAdIkOi6uYE4H3gKTFaU
        IslbxTpgJ1N0KUE3pqlL0wiG1SfRk10=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-5sm-l_MUPIicR5kVNIw8Kw-1; Fri, 04 Sep 2020 17:59:01 -0400
X-MC-Unique: 5sm-l_MUPIicR5kVNIw8Kw-1
Received: by mail-wm1-f72.google.com with SMTP id m25so2678301wmi.0
        for <linux-api@vger.kernel.org>; Fri, 04 Sep 2020 14:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EoZOJ7xWPzkIVlMZdJmR4Hwqzb4r1fE3xQ2uosOBZDI=;
        b=grcocncomQrjtgoTVIcJGe477PHI46mlXm2QGUCZ7aN5ApTWP2uRelG6yzTY2hGhnO
         W+MpskVseVYnT3gEYV/SI81o7AWJcY2lRpCpsnTSPkouZs4RW7+laafgposTO5uzEWp8
         CaP6ORJHlwJvc76JYG8KS7BTybEAZp3ZMkVvTiD0JrBaZBsU/0NFy6fYJ5gGWFRe71z9
         BUtv/teTJo56dsOBTJHq7jBpu5rYseFmprRmgWfNWXV7POFPVsTQbEvZgXYv+dH1if3E
         LdsQVB9CO1O4TYu80mgqFD48XK7Wpe6Z1jymkWL/pn3JoUIXmhTB3pg2SJEmO1fi3qC3
         w3MA==
X-Gm-Message-State: AOAM531faSzz/QR9gSDk6lJBZNHT2dUsM1TOalZb8OMKWDUp7BKk6HQl
        ZpNQibYhYYubNCsjOcLRyyJQ+ynAoAyUWtFiGXAdWBibFakfXnNboCBu1WkPLHRAx4AVaPX7qI0
        8JURNXDOpYfprI61F09ug
X-Received: by 2002:a1c:7912:: with SMTP id l18mr9393756wme.124.1599256739661;
        Fri, 04 Sep 2020 14:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzajioDBmsJb5kmZTNPcpohl6e4YiK5MUNMtPhEODb2SBzokI+UbTLMT6caLh7sLzoYFtDUdQ==
X-Received: by 2002:a1c:7912:: with SMTP id l18mr9393732wme.124.1599256739345;
        Fri, 04 Sep 2020 14:58:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c5ce:ce6f:889c:8d7a? ([2001:b07:6468:f312:c5ce:ce6f:889c:8d7a])
        by smtp.gmail.com with ESMTPSA id q15sm14108923wrr.8.2020.09.04.14.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 14:58:58 -0700 (PDT)
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>,
        =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Graf <graf@amazon.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jerome Glisse <jglisse@redhat.com>,
        =?UTF-8?Q?Mihai_Don=c8=9bu?= <mdontu@bitdefender.com>,
        Mircea Cirjaliu <mcirjaliu@bitdefender.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Sargun Dhillon <sargun@sargun.me>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <d22e1e08-e2c1-510e-5ae7-accbf69731bf@redhat.com>
 <70D23368-A24D-4A15-8FC7-FA728D102475@amacapital.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <836cff86-e670-8c69-6cbd-b22c5b5538df@redhat.com>
Date:   Fri, 4 Sep 2020 23:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <70D23368-A24D-4A15-8FC7-FA728D102475@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 04/09/20 22:34, Andy Lutomirski wrote:
> On Sep 4, 2020, at 1:09 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> ﻿On 04/09/20 21:39, Andy Lutomirski wrote:
>>> I'm a little concerned
>>> that it's actually too clever and that maybe a more
>>> straightforward solution should be investigated.  I personally 
>>> rather dislike the KVM model in which the guest address space
>>> mirrors the host (QEMU) address space rather than being its own
>>> thing.  In particular, the current model means that
>>> extra-special-strange mappings like SEV-encrypted memory are
>>> required to be present in the QEMU page tables in order for the
>>> guest to see them. (If I had noticed that last bit before it went
>>> upstream, I would have NAKked it.  I would still like to see it
>>> deprecated and ideally eventually removed from the kernel.  We
>>> have absolutely no business creating incoherent mappings like
>>> this.)
>> 
>> NACK first and ask second, right Andy?  I see that nothing has
>> changed since Alan Cox left Linux.
> 
> NACKs are negotiable.  And maybe someone can convince me that the SEV
> mapping scheme is reasonable, but I would be surprised.

So why say NACK?  Any half-decent maintainer would hold on merging the
patches at least until the discussion is over.  Also I suppose any
deprecation proposal should come with a description of an alternative.

Anyway, for SEV the problem is DMA.  There is no way to know in advance
which memory the guest will use for I/O; it can change at any time and
the same host-physical address can even be mapped both as C=0 and C=1 by
the guest.  There's no communication protocol between the guest and the
host to tell the host _which_ memory should be mapped in QEMU.  (One was
added to support migration, but that doesn't even work with SEV-ES
processors where migration is planned to happen mostly with help from
the guest, either in the firmware or somewhere else).

But this is a digression.  (If you would like to continue the discussion
please trim the recipient list and change the subject).

> Regardless, you seem to be suggesting that you want to have enclave
> VMs in which the enclave can see some memory that the parent VM can’t
> see. How does this fit into the KVM mapping model?  How does this
> remote mapping mechanism help?  Do you want QEMU to have that memory
> mapped in its own pagetables?

There are three processes:

- the manager, which is the parent of the VMs and uses the pidfd_mem
system call

- the primary VM

- the enclave VM(s)

The primary VM and the enclave VM(s) would each get a different memory
access file descriptor.  QEMU would treat them no differently from any
other externally-provided memory backend, say hugetlbfs or memfd, so
yeah they would be mmap-ed to userspace and the host virtual address
passed as usual to KVM.

Enclave VMs could be used to store secrets and perform crypto for
example.  The enclave is measured at boot, any keys or other stuff it
needs can be provided out-of-band from the manager

The manager can decide at any time to hide some memory from the parent
VM (in order to give it to an enclave).  This would actually be done on
 request of the parent VM itself, and QEMU would probably be so kind as
to replace the "hole" left in the guest memory with zeroes.  But QEMU is
untrusted, so the manager cannot rely on QEMU behaving well.  Hence the
 privilege separation model that was implemented here.

Actually Amazon has already created something like that and Andra-Irina
Paraschiv has posted patches on the list for this.  Their implementation
is not open source, but this pidfd-mem concept is something that Andra,
Alexander Graf and I came up with as a way to 1) reimplement the feature
upstream and 2) satisfy Bitdefender's need for memory introspection 3)
add what seemed a useful interface anyway, for example to replace
PTRACE_{PEEK,POKE}DATA.  Though (3) would only need pread/pwrite, not
mmap which adds a lot of the complexity.

> As it stands, the way that KVM memory mappings are created seems to
> be convenient, but it also seems to be resulting in increasing
> bizarre userspace mappings.  At what point is the right solution to
> decouple KVM’s mappings from QEMU’s?

So what you are suggesting is that KVM manages its own address space
instead of host virtual addresses (and with no relationship to host
virtual addresses, it would be just a "cookie")?  It would then need a
couple ioctls to mmap/munmap (creating and deleting VMAs) into the
address space, and those cookies would be passed to
KVM_SET_USER_MEMORY_REGION.  QEMU would still need access to these VMAs,
would it mmap a file descriptor provided by KVM?  All in all the
implementation seems quite complex, and I don't understand why it would
avoid incoherent SEV mappings; what am I missing?

Paolo

