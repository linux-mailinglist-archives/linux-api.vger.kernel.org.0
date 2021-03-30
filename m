Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811AD34E3BD
	for <lists+linux-api@lfdr.de>; Tue, 30 Mar 2021 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbhC3I7I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 30 Mar 2021 04:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231695AbhC3I7E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 30 Mar 2021 04:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617094743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z7IpkPKNO0+WZGDPW7WcTQq39mnF+XSoroeOgb4x870=;
        b=LEC6oJpU1QyY7IbTsWXo1DCZLAYbpWG34NwKKDaCKTLx3vANscyjxkQaESHypMDH/0jr1I
        z7RSFK2rTaEAlxkk3shKRESWfnvnlb+jkVsRp5wjkIu93ruXyAxNn96I8cD6xZiKzCNKDg
        9+uzSlvAhVVNtYvwGRiTKcWGIUrIBtQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-05lw0s0-PG6axPupkq6nyA-1; Tue, 30 Mar 2021 04:59:01 -0400
X-MC-Unique: 05lw0s0-PG6axPupkq6nyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0AC8180FCAA;
        Tue, 30 Mar 2021 08:58:57 +0000 (UTC)
Received: from [10.36.114.210] (ovpn-114-210.ams2.redhat.com [10.36.114.210])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6F27E1001B2C;
        Tue, 30 Mar 2021 08:58:44 +0000 (UTC)
Subject: Re: [PATCH v1 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Helge Deller <deller@gmx.de>, Hugh Dickins <hughd@google.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Peter Xu <peterx@redhat.com>, Ram Pai <linuxram@us.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Rik van Riel <riel@surriel.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vlastimil Babka <vbabka@suse.cz>
References: <20210317110644.25343-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <af5555cf-d112-44fd-e030-bfe8f89c8ddc@redhat.com>
Date:   Tue, 30 Mar 2021 10:58:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210317110644.25343-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 17.03.21 12:06, David Hildenbrand wrote:
> Excessive details on MADV_POPULATE_(READ|WRITE) can be found in patch #2.
> 
> Now accompanied by minor adjustments and selftests/vm tests.
> 
> RFCv2 -> v1
> - "mm: fix variable name in declaration of populate_vma_page_range()"
> -- Added
> - "mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault ..."
> -- Fix detection of memory holes when we have to re-lookup the VMA
> -- Return -EHWPOISON to user space when we hit HW poisoned pages
> -- Make variable names in definition and declaration consistent
> - "MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT"
> -- Added
> - "selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore"
> -- Added
> - "selftests/vm: add test for MADV_POPULATE_(READ|WRITE)"
> -- Added
> 
> RFC -> RFCv2:
> - Fix re-locking (-> set "locked = 1;")
> - Don't mimic MAP_POPULATE semantics:
> --> Explicit READ/WRITE request instead of selecting it automatically,
>      which makes it more generic and better suited for some use cases (e.g., we
>      usually want to prefault shmem writable)
> --> Require proper access permissions
> - Introduce and use faultin_vma_page_range()
> --> Properly handle HWPOISON pages (FOLL_HWPOISON)
> --> Require proper access permissions (!FOLL_FORCE)
> - Let faultin_vma_page_range() check for compatible mappings/permissions
> - Extend patch description and add some performance numbers
> 
> David Hildenbrand (5):
>    mm: make variable names for populate_vma_page_range() consistent
>    mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault/prealloc
>      memory
>    MAINTAINERS: add tools/testing/selftests/vm/ to MEMORY MANAGEMENT
>    selftests/vm: add protection_keys_32 / protection_keys_64 to gitignore
>    selftests/vm: add test for MADV_POPULATE_(READ|WRITE)
> 
>   MAINTAINERS                                |   1 +
>   arch/alpha/include/uapi/asm/mman.h         |   3 +
>   arch/mips/include/uapi/asm/mman.h          |   3 +
>   arch/parisc/include/uapi/asm/mman.h        |   3 +
>   arch/xtensa/include/uapi/asm/mman.h        |   3 +
>   include/uapi/asm-generic/mman-common.h     |   3 +
>   mm/gup.c                                   |  54 ++++
>   mm/internal.h                              |   5 +-
>   mm/madvise.c                               |  69 +++++
>   tools/testing/selftests/vm/.gitignore      |   3 +
>   tools/testing/selftests/vm/Makefile        |   1 +
>   tools/testing/selftests/vm/madv_populate.c | 342 +++++++++++++++++++++
>   tools/testing/selftests/vm/run_vmtests.sh  |  16 +
>   13 files changed, 505 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/vm/madv_populate.c
> 

Gentle ping.

-- 
Thanks,

David / dhildenb

