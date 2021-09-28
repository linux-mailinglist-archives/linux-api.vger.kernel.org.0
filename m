Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148FA41B3F5
	for <lists+linux-api@lfdr.de>; Tue, 28 Sep 2021 18:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241766AbhI1QgR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Sep 2021 12:36:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241662AbhI1QgQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Sep 2021 12:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632846876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90MnpVDj+JolZRQzNZV0139yLGyO6wZA0RZidpLY/d8=;
        b=avAEbCV/jcaB48n844D9j4qSOxuEIhq12fzA1MKcHZVSJs01NF3RmD34/7luyfwOGPnOoT
        JJKm9UfegSwRs04sfvueqgh0MgIfcS+ufjewDdAhTFqXDE4q4pNk+X6sg7+hREroEq2ycx
        vciEsbkd6FBqw2FPggCpk0nzG2OyFFg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-91-BjPgbooOOqCx8RyEFRnjyg-1; Tue, 28 Sep 2021 12:34:34 -0400
X-MC-Unique: BjPgbooOOqCx8RyEFRnjyg-1
Received: by mail-wr1-f69.google.com with SMTP id j16-20020adfa550000000b0016012acc443so15357205wrb.14
        for <linux-api@vger.kernel.org>; Tue, 28 Sep 2021 09:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=90MnpVDj+JolZRQzNZV0139yLGyO6wZA0RZidpLY/d8=;
        b=kuXyF3JwLZrI3Qyr6lEs7hv/IMTTv/dQspFEvWWGJu5CKT/UZmBxHayvVrD1ssD2yy
         SkgkH937ZOlxrfCuY8flYSaGhcMgQIr2cmwxoLQx8/RjJvsWcXi1zQroPQEOeqACMd/z
         +dN00tjZEl5Kkn8AdBpBJwhBxEGrRph3fbov+3mB6s1NYtVsySCNtZ8LMqNUBkJdnkSX
         S/+9DLi8X8pO7Cfoo+5gx24YgTr8NYx/uD2Z1Jh1hBZTm4AtuyA4fN3ostqKm6WUabIl
         1Qlw6JAFnAtWBuB1i0rNnEAUCoaXIV03oBVo7mk7Qs3aysxUirqKnv5a9GnS1MiRIdZh
         RHyA==
X-Gm-Message-State: AOAM532h6SsiQqfEQtTou66x8HgjNPVFuw3oQEbq5e+EI3/HZSNGbehe
        3K4PYMBUoU+tERYdGc7bMNw/PBkV6/EhLjAgCOZv7O9pw+NlpdZ6Q99SaovNMDQ1zZitmmgCqOB
        zqUFhfCX7hj5gOBRCXMmq
X-Received: by 2002:adf:f011:: with SMTP id j17mr1209204wro.320.1632846873583;
        Tue, 28 Sep 2021 09:34:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxC9lznFV3Ctkcfw7xljoa+4peYF5PkipscjyHbVyunvo7v7A6WC0Wx/PgoIe9YRO5C7xaV8Q==
X-Received: by 2002:adf:f011:: with SMTP id j17mr1209179wro.320.1632846873331;
        Tue, 28 Sep 2021 09:34:33 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23aaf.dip0.t-ipconnect.de. [79.242.58.175])
        by smtp.gmail.com with ESMTPSA id l18sm3700515wrp.56.2021.09.28.09.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 09:34:32 -0700 (PDT)
Subject: Re: [PATCH v3] madvise.2: Document MADV_POPULATE_READ and
 MADV_POPULATE_WRITE
To:     linux-man@vger.kernel.org
Cc:     Pankaj Gupta <pankaj.gupta@ionos.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jann Horn <jannh@google.com>, Mike Rapoport <rppt@kernel.org>,
        Linux API <linux-api@vger.kernel.org>, linux-mm@kvack.org
References: <20210823120645.8223-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <50357269-d227-5fda-a450-c47b035b9586@redhat.com>
Date:   Tue, 28 Sep 2021 18:34:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823120645.8223-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 23.08.21 14:06, David Hildenbrand wrote:
> MADV_POPULATE_READ and MADV_POPULATE_WRITE have been merged into
> upstream Linux via commit 4ca9b3859dac ("mm/madvise: introduce
> MADV_POPULATE_(READ|WRITE) to prefault page tables"), part of v5.14-rc1.
> 
> Further, commit eb2faa513c24 ("mm/madvise: report SIGBUS as -EFAULT for
> MADV_POPULATE_(READ|WRITE)"), part of v5.14-rc6, made sure that SIGBUS is
> converted to -EFAULT instead of -EINVAL.
> 
> Let's document the behavior and error conditions of these new madvise()
> options.
> 
> Acked-by: Pankaj Gupta <pankaj.gupta@ionos.com>
> Cc: Alejandro Colomar <alx.manpages@gmail.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Jann Horn <jannh@google.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Linux API <linux-api@vger.kernel.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v2 -> v3:
> - Refine what "populating readable/writable" means
> - Compare each version with MAP_POPULATE and give an example use case
> - Reword SIGBUS handling
> - Reword comment regarding special mappings and also add memfd_secret(2)
> - Reference MADV_HWPOISON when talking about HW poisoned pages
> - Minor cosmetic fixes
> 
> v1 -> v2:
> - Use semantic newlines in all cases
> - Add two missing "
> - Document -EFAULT handling
> - Rephrase some parts to make it more generic: VM_PFNMAP and VM_IO are only
>    examples for special mappings
> 
> ---
>   man2/madvise.2 | 156 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 156 insertions(+)
> 
> diff --git a/man2/madvise.2 b/man2/madvise.2
> index f1f384c0c..37f6dd6fa 100644
> --- a/man2/madvise.2
> +++ b/man2/madvise.2
> @@ -469,6 +469,106 @@ If a page is file-backed and dirty, it will be written back to the backing
>   storage.
>   The advice might be ignored for some pages in the range when it is not
>   applicable.
> +.TP
> +.BR MADV_POPULATE_READ " (since Linux 5.14)"
> +"Populate (prefault) page tables readable,
> +faulting in all pages in the range just as if manually reading from each page;
> +however,
> +avoid the actual memory access that would have been performed after handling
> +the fault.
> +.IP
> +In contrast to
> +.BR MAP_POPULATE ,
> +.B MADV_POPULATE_READ
> +does not hide errors,
> +can be applied to (parts of) existing mappings and will always populate
> +(prefault) page tables readable.
> +One example use case is prefaulting a file mapping,
> +reading all file content from disk;
> +however,
> +pages won't be dirtied and consequently won't have to be written back to disk
> +when evicting the pages from memory.
> +.IP
> +Depending on the underlying mapping,
> +map the shared zeropage,
> +preallocate memory or read the underlying file;
> +files with holes might or might not preallocate blocks.
> +If populating fails,
> +a
> +.B SIGBUS
> +signal is not generated; instead, an error is returned.
> +.IP
> +If
> +.B MADV_POPULATE_READ
> +succeeds,
> +all page tables have been populated (prefaulted) readable once.
> +If
> +.B MADV_POPULATE_READ
> +fails,
> +some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_READ
> +cannot be applied to mappings without read permissions
> +and special mappings,
> +for example,
> +mappings marked with kernel-internal flags such as
> +.B VM_PFNMAP
> +or
> +.BR VM_IO ,
> +or secret memory regions created using
> +.BR memfd_secret(2) .
> +.IP
> +Note that with
> +.BR MADV_POPULATE_READ ,
> +the process can be killed at any moment when the system runs out of memory.
> +.TP
> +.BR MADV_POPULATE_WRITE " (since Linux 5.14)"
> +Populate (prefault) page tables writable,
> +faulting in all pages in the range just as if manually writing to each
> +each page;
> +however,
> +avoid the actual memory access that would have been performed after handling
> +the fault.
> +.IP
> +In contrast to
> +.BR MAP_POPULATE ,
> +MADV_POPULATE_WRITE does not hide errors,
> +can be applied to (parts of) existing mappings and will always populate
> +(prefault) page tables writable.
> +One example use case is preallocating memory,
> +breaking any CoW (Copy on Write).
> +.IP
> +Depending on the underlying mapping,
> +preallocate memory or read the underlying file;
> +files with holes will preallocate blocks.
> +If populating fails,
> +a
> +.B SIGBUS
> +signal is not generated; instead, an error is returned.
> +.IP
> +If
> +.B MADV_POPULATE_WRITE
> +succeeds,
> +all page tables have been populated (prefaulted) writable once.
> +If
> +.B MADV_POPULATE_WRITE
> +fails,
> +some page tables might have been populated.
> +.IP
> +.B MADV_POPULATE_WRITE
> +cannot be applied to mappings without write permissions
> +and special mappings,
> +for example,
> +mappings marked with kernel-internal flags such as
> +.B VM_PFNMAP
> +or
> +.BR VM_IO ,
> +or secret memory regions created using
> +.BR memfd_secret(2) .
> +.IP
> +Note that with
> +.BR MADV_POPULATE_WRITE ,
> +the process can be killed at any moment when the system runs out of memory.
>   .SH RETURN VALUE
>   On success,
>   .BR madvise ()
> @@ -490,6 +590,22 @@ A kernel resource was temporarily unavailable.
>   .B EBADF
>   The map exists, but the area maps something that isn't a file.
>   .TP
> +.B EFAULT
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +and populating (prefaulting) page tables failed because a
> +.B SIGBUS
> +would have been generated on actual memory access and the reason is not a
> +HW poisoned page
> +(HW poisoned pages can,
> +for example,
> +be created using the
> +.B MADV_HWPOISON
> +flag described elsewhere in this page).
> +.TP
>   .B EINVAL
>   .I addr
>   is not page-aligned or
> @@ -533,6 +649,22 @@ or
>   .BR VM_PFNMAP
>   ranges.
>   .TP
> +.B EINVAL
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +but the specified address range includes ranges with insufficient permissions
> +or special mappings,
> +for example,
> +mappings marked with kernel-internal flags such a
> +.B VM_IO
> +or
> +.BR VM_PFNMAP ,
> +or secret memory regions created using
> +.BR memfd_secret(2) .
> +.TP
>   .B EIO
>   (for
>   .BR MADV_WILLNEED )
> @@ -548,6 +680,15 @@ Not enough memory: paging in failed.
>   Addresses in the specified range are not currently
>   mapped, or are outside the address space of the process.
>   .TP
> +.B ENOMEM
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +and populating (prefaulting) page tables failed because there was not enough
> +memory.
> +.TP
>   .B EPERM
>   .I advice
>   is
> @@ -555,6 +696,20 @@ is
>   but the caller does not have the
>   .B CAP_SYS_ADMIN
>   capability.
> +.TP
> +.B EHWPOISON
> +.I advice
> +is
> +.B MADV_POPULATE_READ
> +or
> +.BR MADV_POPULATE_WRITE ,
> +and populating (prefaulting) page tables failed because a HW poisoned page
> +(HW poisoned pages can,
> +for example,
> +be created using the
> +.B MADV_HWPOISON
> +flag described elsewhere in this page)
> +was encountered.
>   .SH VERSIONS
>   Since Linux 3.18,
>   .\" commit d3ac21cacc24790eb45d735769f35753f5b56ceb
> @@ -602,6 +757,7 @@ from the system call, as it should).
>   .\" function first appeared in 4.4BSD.
>   .SH SEE ALSO
>   .BR getrlimit (2),
> +.BR memfd_secret(2),
>   .BR mincore (2),
>   .BR mmap (2),
>   .BR mprotect (2),
> 

Gentle ping.

-- 
Thanks,

David / dhildenb

