Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1134F8FE
	for <lists+linux-api@lfdr.de>; Wed, 31 Mar 2021 08:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233762AbhCaGrv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 31 Mar 2021 02:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233817AbhCaGrM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 31 Mar 2021 02:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617173229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JrtocEpDB4VtWPFMNINTrS+vkx/a/h89EctpsdAcq94=;
        b=SVy8Pl2EMsybab2kwvwk9DtWXv7cf8StkLP1SxeUwBS5u92OPfxavx+ftEL+els+x+7r1H
        fWIGiPBGpR20k6Y5IM/2AITHdINTUPFaG1QSkjx2wkq5J0vc5nT//QJowxZ1q8tD5+gqS2
        WWoV/PJ9YPaQ4KPmwjUBf7WgPRWbPjk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-CQDt-NDmP7SzyxnaLN8W3g-1; Wed, 31 Mar 2021 02:47:07 -0400
X-MC-Unique: CQDt-NDmP7SzyxnaLN8W3g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 226CA1084D68;
        Wed, 31 Mar 2021 06:47:03 +0000 (UTC)
Received: from [10.36.113.60] (ovpn-113-60.ams2.redhat.com [10.36.113.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 431544F3C6;
        Wed, 31 Mar 2021 06:46:48 +0000 (UTC)
Subject: Re: [PATCH v1 0/5] mm/madvise: introduce MADV_POPULATE_(READ|WRITE)
 to prefault/prealloc memory
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
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
 <af5555cf-d112-44fd-e030-bfe8f89c8ddc@redhat.com>
 <20210330215812.5279462ba693833680384b1b@linux-foundation.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <48cede0e-152a-598c-c63a-ed712e0f61c3@redhat.com>
Date:   Wed, 31 Mar 2021 08:46:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210330215812.5279462ba693833680384b1b@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 31.03.21 06:58, Andrew Morton wrote:
> On Tue, 30 Mar 2021 10:58:43 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>>>
>>>    MAINTAINERS                                |   1 +
>>>    arch/alpha/include/uapi/asm/mman.h         |   3 +
>>>    arch/mips/include/uapi/asm/mman.h          |   3 +
>>>    arch/parisc/include/uapi/asm/mman.h        |   3 +
>>>    arch/xtensa/include/uapi/asm/mman.h        |   3 +
>>>    include/uapi/asm-generic/mman-common.h     |   3 +
>>>    mm/gup.c                                   |  54 ++++
>>>    mm/internal.h                              |   5 +-
>>>    mm/madvise.c                               |  69 +++++
>>>    tools/testing/selftests/vm/.gitignore      |   3 +
>>>    tools/testing/selftests/vm/Makefile        |   1 +
>>>    tools/testing/selftests/vm/madv_populate.c | 342 +++++++++++++++++++++
>>>    tools/testing/selftests/vm/run_vmtests.sh  |  16 +
>>>    13 files changed, 505 insertions(+), 1 deletion(-)
>>>    create mode 100644 tools/testing/selftests/vm/madv_populate.c
>>>
>>
>> Gentle ping.
> 
> Ping who ;)

Well, the ping worked - Jann replied! :)

> 
> I was hoping for more review activity.  Were no changes expected from
> the [2/5] discussion with Jann?

They are, but that discussion happened after the ping. There will be a 
new version some-when next week or so, after I figure out some details.

-- 
Thanks,

David / dhildenb

