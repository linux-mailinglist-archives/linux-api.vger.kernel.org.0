Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32725E9AC
	for <lists+linux-api@lfdr.de>; Sat,  5 Sep 2020 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgIES1h (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Sep 2020 14:27:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728393AbgIES1g (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 5 Sep 2020 14:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599330454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BtgZJueEOiQwnrF4MWuzBn6DByhoMOeJI2jFjsPl+JU=;
        b=ZqsjRBBMTi5OB+K1sS8c+b2MlIdBvKC0wZJKgPnlErOn0+RGXJacv7ROSyVu8i++XML5MZ
        9P5o2j9oBLN7HkPdIMWNdfEC9trGnfxtgnOt0ij7iuXsW4PtXpGuwIP2piiCRIfm1XEJki
        OwaNoP2vyVL+f2oIUIOtgk0851slSWA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-opMoPyuKMvyfzCNOl8-TAA-1; Sat, 05 Sep 2020 14:27:32 -0400
X-MC-Unique: opMoPyuKMvyfzCNOl8-TAA-1
Received: by mail-wr1-f71.google.com with SMTP id j7so1992129wro.14
        for <linux-api@vger.kernel.org>; Sat, 05 Sep 2020 11:27:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BtgZJueEOiQwnrF4MWuzBn6DByhoMOeJI2jFjsPl+JU=;
        b=hM46AHT3rVBsVzxKGIZcQYFQ0o0aVaIvwwnlalY/SPz1xIC9H+Zy1WE+qkZrNhMewA
         uqz3IFfeGdCKPg7M5gGxsB7AT3rLGLjzp/e10YSEoGK3UbKJpn4ehairGw2S6xripJx4
         JUEE8RL12t2Vsk+vN35FHpexCS2Tmk/STu7pV4jsik6rlW2D9nfW+G6L+WGe97ur1/fr
         Ud5ij9PM7IXDSNzQa5P7ITLlD4TZZIpDQkHwJMXRzFNwHIh5RJhqbdVEaEGVN28meYOx
         vD4Ansht3Wo+wHSfjSxiBFsrQ89WjvNmCHWwV/umpy/cEfkQwyKbxcXD6jKEPCmvBKZB
         wppg==
X-Gm-Message-State: AOAM532FgBCbyNdIqCTmz6tXZm1kWwB4UbLTBtA2LE7OoHAwwjz0zQ7C
        Km0dCNVugmc1xe2FxFQIbicyxJ6MujKEgp0bu8utDX7KKDtY42Wvj+O5bZIhJdRfgbnLdHEQ8X1
        2ug/E59/q2SRRvYGaw4Dx
X-Received: by 2002:adf:dd82:: with SMTP id x2mr14129300wrl.419.1599330450944;
        Sat, 05 Sep 2020 11:27:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/x/sd7F1MCI06oI6NuHBEe16ZyXTnQS5UlsXBps+fFu54kInH2QDOs1ht+0nTW3W26BpTEg==
X-Received: by 2002:adf:dd82:: with SMTP id x2mr14129282wrl.419.1599330450666;
        Sat, 05 Sep 2020 11:27:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7ac8:5f99:2279:bef0? ([2001:b07:6468:f312:7ac8:5f99:2279:bef0])
        by smtp.gmail.com with ESMTPSA id h8sm18696461wrw.68.2020.09.05.11.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 11:27:29 -0700 (PDT)
Subject: Re: [RESEND RFC PATCH 0/5] Remote mapping
To:     Andy Lutomirski <luto@kernel.org>
Cc:     =?UTF-8?Q?Adalbert_Laz=c4=83r?= <alazar@bitdefender.com>,
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
 <836cff86-e670-8c69-6cbd-b22c5b5538df@redhat.com>
 <CALCETrUcxFJzN_Vz7qe+79eg8033+uUKOAAMEVj-cB1Gp6pouw@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bbe80f23-86c5-9d8f-8144-f292a6fc81b4@redhat.com>
Date:   Sat, 5 Sep 2020 20:27:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUcxFJzN_Vz7qe+79eg8033+uUKOAAMEVj-cB1Gp6pouw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 05/09/20 01:17, Andy Lutomirski wrote:
> There's sev_pin_memory(), so QEMU must have at least some idea of
> which memory could potentially be encrypted.  Is it in fact the case
> that QEMU doesn't know that some SEV pinned memory might actually be
> used for DMA until the guest tries to do DMA on that memory?  If so,
> yuck.

Yes.  All the memory is pinned, all the memory could potentially be used
for DMA (of garbage if it's encrypted).  And it's the same for pretty
much all protected VM extensions (SEV, POWER, s390, Intel TDX).

>> The primary VM and the enclave VM(s) would each get a different memory
>> access file descriptor.  QEMU would treat them no differently from any
>> other externally-provided memory backend, say hugetlbfs or memfd, so
>> yeah they would be mmap-ed to userspace and the host virtual address
>> passed as usual to KVM.
> 
> Would the VM processes mmap() these descriptors, or would KVM learn
> how to handle that memory without it being mapped?

The idea is that the process mmaps them, QEMU would treat them just the
same as a hugetlbfs file descriptor for example.

>> The manager can decide at any time to hide some memory from the parent
>> VM (in order to give it to an enclave).  This would actually be done on
>> request of the parent VM itself [...] But QEMU is
>> untrusted, so the manager cannot rely on QEMU behaving well.  Hence the
>> privilege separation model that was implemented here.
> 
> How does this work?  Is there a revoke mechanism, or does the parent
> just munmap() the memory itself?

The parent has ioctls to add and remove memory from the pidfd-mem.  So
unmapping is just calling the ioctl that removes a range.

>> So what you are suggesting is that KVM manages its own address space
>> instead of host virtual addresses (and with no relationship to host
>> virtual addresses, it would be just a "cookie")?
> 
> [...] For this pidfd-mem scheme in particular, it might avoid the nasty
> corner case I mentioned.  With pidfd-mem as in this patchset, I'm
> concerned about what happens when process A maps some process B
> memory, process B maps some of process A's memory, and there's a
> recursive mapping that results.  Or when a process maps its own
> memory, for that matter.
> 
> Or memfd could get fancier with operations to split memfds, remove
> pages from memfds, etc.  Maybe that's overkill.

Doing it directly with memfd is certainly an option, especially since
MFD_HUGE_* exists.  Basically you'd have a system call to create a
secondary view of the memfd, and the syscall interface could still be
very similar to what is in this patch, in particular the control/access
pair.  Probably this could be used also to implement Matthew Wilcox's ideas.

I still believe that the pidfd-mem concept has merit as a
"capability-like" PTRACE_{PEEK,POKE}DATA replacement, but it would not
need any of privilege separation or mmap support, only direct read/write.

So there's two concepts mixed in one interface in this patch, with two
completely different usecases.  Merging them is clever, but perhaps too
clever.  I can say that since it was my idea. :D

Thanks,

Paolo

