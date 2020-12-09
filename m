Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C882D3FD7
	for <lists+linux-api@lfdr.de>; Wed,  9 Dec 2020 11:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgLIK0Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Dec 2020 05:26:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:43792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729628AbgLIK0Z (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Dec 2020 05:26:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E21BDACF5;
        Wed,  9 Dec 2020 10:25:32 +0000 (UTC)
Subject: Re: [PATCH] mm,hwpoison: Return -EBUSY when migration fails
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Linux API <linux-api@vger.kernel.org>
References: <20201209092818.30417-1-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ae1f9209-f4f7-fae5-1d8f-5e7e5d2d55aa@suse.cz>
Date:   Wed, 9 Dec 2020 11:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209092818.30417-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12/9/20 10:28 AM, Oscar Salvador wrote:
> Currently, we return -EIO when we fail to migrate the page.
> 
> Migrations' failures are rather transient as they can happen due to
> several reasons, e.g: high page refcount bump, mapping->migrate_page
> failing etc.
> All meaning that at that time the page could not be migrated, but
> that has nothing to do with an EIO error.
> 
> Let us return -EBUSY instead, as we do in case we failed to isolate
> the page.
> 
> While are it, let us remove the "ret" print as its value does not change.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Technically this affects madvise(2) so let's cc linux-api. The manpage doesn't
document error codes of MADV_HWPOISON and MADV_SOFT_OFFLINE (besides EPERM)
though so nothing to adjust there. It's meant only for the hwpoison testing
suite anyway.

> ---
>  mm/memory-failure.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 428991e297e2..1942fb83ac64 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1849,11 +1849,11 @@ static int __soft_offline_page(struct page *page)
>  			pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
>  				pfn, msg_page[huge], ret, page->flags, &page->flags);
>  			if (ret > 0)
> -				ret = -EIO;
> +				ret = -EBUSY;
>  		}
>  	} else {
> -		pr_info("soft offline: %#lx: %s isolation failed: %d, page count %d, type %lx (%pGp)\n",
> -			pfn, msg_page[huge], ret, page_count(page), page->flags, &page->flags);
> +		pr_info("soft offline: %#lx: %s isolation failed, page count %d, type %lx (%pGp)\n",
> +			pfn, msg_page[huge], page_count(page), page->flags, &page->flags);
>  		ret = -EBUSY;
>  	}
>  	return ret;
> 

