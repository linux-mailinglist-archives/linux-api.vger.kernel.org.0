Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4831337
	for <lists+linux-api@lfdr.de>; Fri, 31 May 2019 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEaQ7a (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 31 May 2019 12:59:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44571 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbfEaQ7a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 31 May 2019 12:59:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so1656297qtk.11
        for <linux-api@vger.kernel.org>; Fri, 31 May 2019 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e3NDCjv26v8d/6GmHIuWCh8rhIogpl4fMn5sXvVuI0c=;
        b=f8WPz/+hD8iie5whEpGer0vyU0wOgv311IGNFCXMOj/NFL+1xQv5rdq/sLr0vTGqyR
         D6cgjU6mJcydC2jbjchTtkfzjxQEhtKuhmZI5YdJqCj3Ohw0b/OOQ3QicxR77uGLCTSs
         tNJeznJPLPhwE2A8dhYmVKeOkBegUCxn8GC87aElTzNPvaLVwzoxqNKoG8OuHJPolcr8
         QDLJyRD84j7hLlmTwwwkBOFvc65tS5RO6ip0IJxG28S5uNa0GTZ2GXR/BlShA8I4Zngn
         bIVsIScBIk8K9a5HRlG5NsLb9Q/MvJtZw5Ay8p/0G7CAxHPRREYcTfTCO3UzAgv3Gzmm
         NXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e3NDCjv26v8d/6GmHIuWCh8rhIogpl4fMn5sXvVuI0c=;
        b=C3OwwGoC1NwtkbYI61eQd3fRSYxKnvNjQyPdZXwdNZMlopLlX3U4Ol5nK4O7ZqLkwU
         kfHQ/7uY+DestLo53rYlqbSfk27GwF+qTTCzqb8WcX3VyHdjC6ly7zPN5+ufFVMIjNnN
         Ex67nxFmnfXcjnO7xIlnZVe3JP4qw5Y1zO7riLJsY/WgAHl4TXQWhF8RsiFCaPO1Zy1O
         YjhFHiBW+IGwTSR7NPs5B26qN+qJrgbH5tGYgO5QpOzYhKDQTjJ8/bUpRpLLC0Cm35iH
         FUCzXIE7EQw2ez3YnIC0Q+Sa4M+AU2nQeqoGQRasByYZoAPV6Wr2+4z3T2sHs5uNQf3+
         AUyQ==
X-Gm-Message-State: APjAAAUUhiRWlg/y8Wc3CPZBAZvr85pDWHAvO5idDdEMfI3G3DqWMn/+
        rn7nlhlM7M72CLpMua0T454CZg==
X-Google-Smtp-Source: APXvYqzaN7Osp+sFUz/UO2xtX8ksDYOwDOi8/ZwHvqZxRo9bRaBiMSUChy138SG9ks/ETIGz6vQ6cg==
X-Received: by 2002:a0c:93e1:: with SMTP id g30mr9477692qvg.194.1559321969216;
        Fri, 31 May 2019 09:59:29 -0700 (PDT)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id y29sm4638814qkj.8.2019.05.31.09.59.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 09:59:28 -0700 (PDT)
Date:   Fri, 31 May 2019 12:59:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>, jannh@google.com,
        oleg@redhat.com, christian@brauner.io, oleksandr@redhat.com,
        hdanton@sina.com
Subject: Re: [RFCv2 3/6] mm: introduce MADV_PAGEOUT
Message-ID: <20190531165927.GA20067@cmpxchg.org>
References: <20190531064313.193437-1-minchan@kernel.org>
 <20190531064313.193437-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190531064313.193437-4-minchan@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michan,

this looks pretty straight-forward to me, only one kink:

On Fri, May 31, 2019 at 03:43:10PM +0900, Minchan Kim wrote:
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2126,6 +2126,83 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  			nr_deactivate, nr_rotated, sc->priority, file);
>  }
>  
> +unsigned long reclaim_pages(struct list_head *page_list)
> +{
> +	int nid = -1;
> +	unsigned long nr_isolated[2] = {0, };
> +	unsigned long nr_reclaimed = 0;
> +	LIST_HEAD(node_page_list);
> +	struct reclaim_stat dummy_stat;
> +	struct scan_control sc = {
> +		.gfp_mask = GFP_KERNEL,
> +		.priority = DEF_PRIORITY,
> +		.may_writepage = 1,
> +		.may_unmap = 1,
> +		.may_swap = 1,
> +	};
> +
> +	while (!list_empty(page_list)) {
> +		struct page *page;
> +
> +		page = lru_to_page(page_list);
> +		if (nid == -1) {
> +			nid = page_to_nid(page);
> +			INIT_LIST_HEAD(&node_page_list);
> +			nr_isolated[0] = nr_isolated[1] = 0;
> +		}
> +
> +		if (nid == page_to_nid(page)) {
> +			list_move(&page->lru, &node_page_list);
> +			nr_isolated[!!page_is_file_cache(page)] +=
> +						hpage_nr_pages(page);
> +			continue;
> +		}
> +
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					nr_isolated[1]);
> +		nr_reclaimed += shrink_page_list(&node_page_list,
> +				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
> +				&dummy_stat, true);
> +		while (!list_empty(&node_page_list)) {
> +			struct page *page = lru_to_page(&node_page_list);
> +
> +			list_del(&page->lru);
> +			putback_lru_page(page);
> +		}
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					-nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					-nr_isolated[1]);
> +		nid = -1;
> +	}
> +
> +	if (!list_empty(&node_page_list)) {
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					nr_isolated[1]);
> +		nr_reclaimed += shrink_page_list(&node_page_list,
> +				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
> +				&dummy_stat, true);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> +					-nr_isolated[0]);
> +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> +					-nr_isolated[1]);
> +
> +		while (!list_empty(&node_page_list)) {
> +			struct page *page = lru_to_page(&node_page_list);
> +
> +			list_del(&page->lru);
> +			putback_lru_page(page);
> +		}
> +
> +	}

The NR_ISOLATED accounting, nid parsing etc. is really awkward and
makes it hard to see what the function actually does.

Can you please make those ISOLATED counters part of the isolation API?
Your patch really shows this is an overdue cleanup.

These are fast local percpu counters, we don't need the sprawling
batching we do all over vmscan.c, migrate.c, khugepaged.c,
compaction.c etc. Isolation can increase the counter page by page, and
reclaim or putback can likewise decrease them one by one.

It looks like mlock is the only user of the isolation api that does
not participate in the NR_ISOLATED_* counters protocol, but I don't
see why it wouldn't, or why doing so would hurt.

There are also seem to be quite a few callsites that use the atomic
versions of the counter API when they're clearly under the irqsafe
lru_lock. That would be fixed automatically by this work as well.
