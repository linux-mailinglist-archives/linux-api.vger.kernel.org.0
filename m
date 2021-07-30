Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D11373DB885
	for <lists+linux-api@lfdr.de>; Fri, 30 Jul 2021 14:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238776AbhG3MYB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 30 Jul 2021 08:24:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52194 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238705AbhG3MYA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 30 Jul 2021 08:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627647835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o099h3eyKLatB2qTEqr+nt7BhMYNRVj70jWcHx8N7L4=;
        b=N/Xcb3MabH+IcDbm09v1Ypoue4ZUvR9YVI9Q9qEQGO3gWqRIj6wnQ42CNgwLRJb/g/tbeJ
        rWpoyGJ/iFXmiuNs2bWX4NSRQBnfVkaIv5eRD9H4zlel4TO3/GqPLD+mjjkBbnJ7wiQct6
        FFrhK8TXrjS4vtpCPHJxyCGO8bMYK0s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-eIz0JEgIPsyIZM519nU8zg-1; Fri, 30 Jul 2021 08:23:54 -0400
X-MC-Unique: eIz0JEgIPsyIZM519nU8zg-1
Received: by mail-wr1-f71.google.com with SMTP id c5-20020a5d52850000b0290126f2836a61so3183580wrv.6
        for <linux-api@vger.kernel.org>; Fri, 30 Jul 2021 05:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=o099h3eyKLatB2qTEqr+nt7BhMYNRVj70jWcHx8N7L4=;
        b=HxNn9kmuC01ByysZiHREtMQFQXn2BpX5lt5fLUdDfr2z0pFtMJh+f5cTI/DnHPgFwG
         eT1T001maUtm/uc4RKDHuU2yhgm9rQ+jabTEtJWaQSPVTcsw5t4Wi2g/DrBFOLiyR4jD
         PhY2ii1uL94q32OmP9ttFZU1te5qHYymQGk8xSMeR8LgRQchqu1asbcrqJWyWDyfwPyo
         bIiu08yAEcdMiHHqCGBdBE/XSWoITdftAeAT3erTUc7TlLsoE51X0ZTj9eTdWA+yqjkf
         M5sMpcqhHBAqyk/HqJAo1rzYn8CQ7tK8Ch/FkGzlpn25v/M31GU+p26zZ1W6AODvQzuZ
         esfg==
X-Gm-Message-State: AOAM533nKOAspwUnl0O2BjvB8IXF8rnoTEsEES4GApqEO1EgPLX0DQTD
        C61Nm4ihqloN7kcZ4p+hgGiwkXBrK6lVtKC+L3pD7OuuCLP223q3c+8UfOm6mhrTELuYA2D5k7h
        PLaTPv75Hzi1iH5t4Pi4m
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr184477wmq.184.1627647833323;
        Fri, 30 Jul 2021 05:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7H0CLmKXC7bceTQEaG3gTwuLm+5FooguUuol7APR+1g3WafQj2fDWXl80uW7T1OCOEd1scw==
X-Received: by 2002:a05:600c:350a:: with SMTP id h10mr184451wmq.184.1627647833106;
        Fri, 30 Jul 2021 05:23:53 -0700 (PDT)
Received: from ?IPv6:2003:d8:2f0a:7f00:fad7:3bc9:69d:31f? (p200300d82f0a7f00fad73bc9069d031f.dip0.t-ipconnect.de. [2003:d8:2f0a:7f00:fad7:3bc9:69d:31f])
        by smtp.gmail.com with ESMTPSA id k7sm1550622wms.48.2021.07.30.05.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 05:23:52 -0700 (PDT)
Subject: Re: [PATCH v1] mm/madvise: report SIGBUS as -EFAULT for
 MADV_POPULATE_(READ|WRITE)
To:     linux-kernel@vger.kernel.org, akpm@linuxfoundation.org
Cc:     linux-mm@kvack.org, Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dave Hansen <dave.hansen@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Peter Xu <peterx@redhat.com>,
        Rolf Eike Beer <eike-kernel@sf-tec.de>,
        Ram Pai <linuxram@us.ibm.com>, Shuah Khan <shuah@kernel.org>
References: <20210726154932.102880-1-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <dfd5ee42-0789-4373-4e1b-f6e902a80230@redhat.com>
Date:   Fri, 30 Jul 2021 14:23:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210726154932.102880-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrew,

sorry for not CCing you, absolutely no clue why I accidentally dropped 
you. Can you give this patch a churn? It would be great if we could get 
that into 5.14, so we don't have to deal with differing behavior between 
Linux versions.

Cheers!

On 26.07.21 17:49, David Hildenbrand wrote:
> Doing some extended tests and polishing the man page update for
> MADV_POPULATE_(READ|WRITE), I realized that we end up converting also
> SIGBUS (via -EFAULT) to -EINVAL, making it look like yet another
> madvise() user error.
> 
> We want to report only problematic mappings and permission problems that
> the user could have know as -EINVAL.
> 
> Let's not convert -EFAULT arising due to SIGBUS (or SIGSEGV) to
> -EINVAL, but instead indicate -EFAULT to user space. While we could also
> convert it to -ENOMEM, using -EFAULT looks more helpful when user space
> might want to troubleshoot what's going wrong: MADV_POPULATE_(READ|WRITE)
> is not part of an final Linux release and we can still adjust the behavior.
> 
> Fixes: 4ca9b3859dac ("mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page tables")
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
> Cc: Matt Turner <mattst88@gmail.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>
> Cc: Ram Pai <linuxram@us.ibm.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   mm/gup.c     | 7 +++++--
>   mm/madvise.c | 4 +++-
>   2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 42b8b1fa6521..b94717977d17 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1558,9 +1558,12 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
>   		gup_flags |= FOLL_WRITE;
>   
>   	/*
> -	 * See check_vma_flags(): Will return -EFAULT on incompatible mappings
> -	 * or with insufficient permissions.
> +	 * We want to report -EINVAL instead of -EFAULT for any permission
> +	 * problems or incompatible mappings.
>   	 */
> +	if (check_vma_flags(vma, gup_flags))
> +		return -EINVAL;
> +
>   	return __get_user_pages(mm, start, nr_pages, gup_flags,
>   				NULL, NULL, locked);
>   }
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 6d3d348b17f4..5c065bc8b5f6 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -862,10 +862,12 @@ static long madvise_populate(struct vm_area_struct *vma,
>   			switch (pages) {
>   			case -EINTR:
>   				return -EINTR;
> -			case -EFAULT: /* Incompatible mappings / permissions. */
> +			case -EINVAL: /* Incompatible mappings / permissions. */
>   				return -EINVAL;
>   			case -EHWPOISON:
>   				return -EHWPOISON;
> +			case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
> +				return -EFAULT;
>   			default:
>   				pr_warn_once("%s: unhandled return value: %ld\n",
>   					     __func__, pages);
> 


-- 
Thanks,

David / dhildenb

