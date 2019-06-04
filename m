Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E79BE34C5F
	for <lists+linux-api@lfdr.de>; Tue,  4 Jun 2019 17:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfFDPiV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 4 Jun 2019 11:38:21 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:50926 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbfFDPiV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 4 Jun 2019 11:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1559662700;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=OIhqYY+SOkOUs9T6s6IEPEZv9lMASXYu4UBAM6SEZvE=;
        b=ZYNwKBfhOkfV60g9kU9G7VB5OM0s231pfDNM3QuvIazUXNFVO7bjE5m0pNNNMQec
        mEU2+GxAR9kUbYrODxURkYyW8OfS7B5BnJz4CvBknHYYByKfjas7oyCwT1qOsv54YQE
        sODGtZoWQg96VqyeEDuBs0l2tlZz6jNwzoqkr9iE=
Date:   Tue, 4 Jun 2019 15:38:20 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Minchan Kim <minchan@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [PATCH v1 4/4] mm: introduce MADV_PAGEOUT
In-Reply-To: <20190603053655.127730-5-minchan@kernel.org>
Message-ID: <0100016b232425c9-64a09298-59ba-48b8-9aa3-e7e1ad2d316c-000000@email.amazonses.com>
References: <20190603053655.127730-1-minchan@kernel.org> <20190603053655.127730-5-minchan@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.06.04-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 3 Jun 2019, Minchan Kim wrote:

> @@ -415,6 +416,128 @@ static long madvise_cold(struct vm_area_struct *vma,
>  	return 0;
>  }
>
> +static int madvise_pageout_pte_range(pmd_t *pmd, unsigned long addr,
> +				unsigned long end, struct mm_walk *walk)
> +{
> +	pte_t *orig_pte, *pte, ptent;
> +	spinlock_t *ptl;
> +	LIST_HEAD(page_list);
> +	struct page *page;
> +	int isolated = 0;
> +	struct vm_area_struct *vma = walk->vma;
> +	unsigned long next;
> +
> +	if (fatal_signal_pending(current))
> +		return -EINTR;
> +
> +	next = pmd_addr_end(addr, end);
> +	if (pmd_trans_huge(*pmd)) {
> +		ptl = pmd_trans_huge_lock(pmd, vma);
> +		if (!ptl)
> +			return 0;
> +
> +		if (is_huge_zero_pmd(*pmd))
> +			goto huge_unlock;
> +
> +		page = pmd_page(*pmd);
> +		if (page_mapcount(page) > 1)
> +			goto huge_unlock;
> +
> +		if (next - addr != HPAGE_PMD_SIZE) {
> +			int err;
> +
> +			get_page(page);
> +			spin_unlock(ptl);
> +			lock_page(page);
> +			err = split_huge_page(page);
> +			unlock_page(page);
> +			put_page(page);
> +			if (!err)
> +				goto regular_page;
> +			return 0;
> +		}

I have seen this before multiple times. Is there a way to avoid
replicating the whole shebang?

