Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A00D67573D
	for <lists+linux-api@lfdr.de>; Fri, 20 Jan 2023 15:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjATOeG (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 20 Jan 2023 09:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjATOeG (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Jan 2023 09:34:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6FD4203
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674225202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=05jMKEcp3JaFixP2jbb6Uhbzjdw/CtRlbciNLVbZds0=;
        b=hQQaD/bU27ZnAwO5kyEkai3ss6OLjulxaxXpjMNPTuTO+5lfudxi/sLi5LuiP26z0H6vWI
        Mm2AMi1NmTjI6IN+IRHjR5aqdMQkYYYXxGD1HLB75KFD3eKqEkoqfxxQjuVVsuDDm6Xt4I
        DYQk0CbE/IQsc7+rGTFizEWTA/tEHHs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-646-jJJWAO0-PdSGkC0_N_qwYQ-1; Fri, 20 Jan 2023 09:33:19 -0500
X-MC-Unique: jJJWAO0-PdSGkC0_N_qwYQ-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-4d5097a95f5so51749987b3.1
        for <linux-api@vger.kernel.org>; Fri, 20 Jan 2023 06:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05jMKEcp3JaFixP2jbb6Uhbzjdw/CtRlbciNLVbZds0=;
        b=p2LqbIfeegc5hAPRiErVH98fnG05/wJazYAUakZirA3ZWP9clSz4srjh5r4fVEmRCw
         0Sfd+0Liws6vrOETk7RhPf97yHEcvFMoAHFrTXbsIjur+jhulITddW2zjoG0nuE0gEPc
         jTB7877pB6yaf2BqTbvPEsvSJmANDs2ZQs1DITYrgMxaZ0dcph41Sg2YsdqAvbxDYQcY
         WvuNhaY82Umtn1XjQfuR5bQsm9OxW9WIwBPtfdjkZWhUCgH47yH9hzwLPC0YhMDlTDhe
         XS7nFT7kBNwsNliyHaYerQDl/twcFTz/ungU0IvyEFyRqTMzU9TI8qku9X0q/h2ZQ3We
         m4YA==
X-Gm-Message-State: AFqh2kpubypLKooA4kGXPL41awW/egyDMjNIA3C9uo6dnB2Q854RjZQ9
        rur8dgrZcM9B6zLZcczOsSgQVVnvMHLq3k1l1AVE4O8s/Q9w8hVGIMJSoyLLlwupUzgIiHvow19
        mJ/v1Hn/NYejqR02YqQiD
X-Received: by 2002:a25:3485:0:b0:800:52b1:8cf9 with SMTP id b127-20020a253485000000b0080052b18cf9mr2316257yba.2.1674225198612;
        Fri, 20 Jan 2023 06:33:18 -0800 (PST)
X-Google-Smtp-Source: AMrXdXumoIFgA+u1tEMdBbSpxot7YwkEeM1o8sqvSQ1+HPMrZOYsh/iygbBAoru/WwcspK7WhWxJGA==
X-Received: by 2002:a25:3485:0:b0:800:52b1:8cf9 with SMTP id b127-20020a253485000000b0080052b18cf9mr2316222yba.2.1674225198182;
        Fri, 20 Jan 2023 06:33:18 -0800 (PST)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id w22-20020a05620a149600b007090bb886a2sm2001191qkj.118.2023.01.20.06.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 06:33:16 -0800 (PST)
Date:   Fri, 20 Jan 2023 09:34:18 -0500
From:   Brian Foster <bfoster@redhat.com>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-api@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v6 1/3] workingset: refactor LRU refault to expose
 refault recency check
Message-ID: <Y8qmaqpAFko+gI3h@bfoster>
References: <20230117195959.29768-1-nphamcs@gmail.com>
 <20230117195959.29768-2-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117195959.29768-2-nphamcs@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jan 17, 2023 at 11:59:57AM -0800, Nhat Pham wrote:
> In preparation for computing recently evicted pages in cachestat,
> refactor workingset_refault and lru_gen_refault to expose a helper
> function that would test if an evicted page is recently evicted.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---

Hi Nhat,

I'm not terribly familiar with the workingset management code, but a few
thoughts now that I've stared at it a bit...

>  include/linux/swap.h |   1 +
>  mm/workingset.c      | 129 ++++++++++++++++++++++++++++++-------------
>  2 files changed, 92 insertions(+), 38 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a18cf4b7c724..dae6f6f955eb 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
>  }
>  
>  /* linux/mm/workingset.c */
> +bool workingset_test_recent(void *shadow, bool file, bool *workingset);
>  void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
>  void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
>  void workingset_refault(struct folio *folio, void *shadow);
> diff --git a/mm/workingset.c b/mm/workingset.c
> index 79585d55c45d..006482c4e0bd 100644
> --- a/mm/workingset.c
> +++ b/mm/workingset.c
> @@ -244,6 +244,33 @@ static void *lru_gen_eviction(struct folio *folio)
>  	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
>  }
>  
> +/*
> + * Test if the folio is recently evicted.
> + *
> + * As a side effect, also populates the references with
> + * values unpacked from the shadow of the evicted folio.
> + */
> +static bool lru_gen_test_recent(void *shadow, bool file, bool *workingset)
> +{
> +	struct mem_cgroup *eviction_memcg;
> +	struct lruvec *lruvec;
> +	struct lru_gen_struct *lrugen;
> +	unsigned long min_seq;
> +

Extra whitespace looks a bit funny here.

> +	int memcgid;
> +	struct pglist_data *pgdat;
> +	unsigned long token;
> +
> +	unpack_shadow(shadow, &memcgid, &pgdat, &token, workingset);
> +	eviction_memcg = mem_cgroup_from_id(memcgid);
> +
> +	lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
> +	lrugen = &lruvec->lrugen;
> +
> +	min_seq = READ_ONCE(lrugen->min_seq[file]);
> +	return !((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));

I think this might be more readable without the double negative.

Also it looks like this logic is pulled from lru_gen_refault(). Any
reason the caller isn't refactored to use this helper, similar to how
workingset_refault() is modified? It seems like a potential landmine to
duplicate the logic here for cachestat purposes and somewhere else for
actual workingset management.

> +}
> +
>  static void lru_gen_refault(struct folio *folio, void *shadow)
>  {
>  	int hist, tier, refs;
> @@ -306,6 +333,11 @@ static void *lru_gen_eviction(struct folio *folio)
>  	return NULL;
>  }
>  
> +static bool lru_gen_test_recent(void *shadow, bool file, bool *workingset)
> +{
> +	return true;
> +}

I guess this is a no-op for !MGLRU but given the context (i.e. special
treatment for "recent" refaults), perhaps false is a more sane default?

> +
>  static void lru_gen_refault(struct folio *folio, void *shadow)
>  {
>  }
> @@ -373,40 +405,31 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
>  				folio_test_workingset(folio));
>  }
>  
> -/**
> - * workingset_refault - Evaluate the refault of a previously evicted folio.
> - * @folio: The freshly allocated replacement folio.
> - * @shadow: Shadow entry of the evicted folio.
> +/*
> + * Test if the folio is recently evicted by checking if
> + * refault distance of shadow exceeds workingset size.
>   *
> - * Calculates and evaluates the refault distance of the previously
> - * evicted folio in the context of the node and the memcg whose memory
> - * pressure caused the eviction.
> + * As a side effect, populate workingset with the value
> + * unpacked from shadow.
>   */
> -void workingset_refault(struct folio *folio, void *shadow)
> +bool workingset_test_recent(void *shadow, bool file, bool *workingset)
>  {
> -	bool file = folio_is_file_lru(folio);
>  	struct mem_cgroup *eviction_memcg;
>  	struct lruvec *eviction_lruvec;
>  	unsigned long refault_distance;
>  	unsigned long workingset_size;
> -	struct pglist_data *pgdat;
> -	struct mem_cgroup *memcg;
> -	unsigned long eviction;
> -	struct lruvec *lruvec;
>  	unsigned long refault;
> -	bool workingset;
> +
>  	int memcgid;
> -	long nr;
> +	struct pglist_data *pgdat;
> +	unsigned long eviction;
>  
> -	if (lru_gen_enabled()) {
> -		lru_gen_refault(folio, shadow);
> -		return;
> -	}
> +	if (lru_gen_enabled())
> +		return lru_gen_test_recent(shadow, file, workingset);

Hmm.. so this function is only called by workingset_refault() when
lru_gen_enabled() == false, otherwise it calls into lru_gen_refault(),
which as noted above duplicates some of the recency logic.

I'm assuming this lru_gen_test_recent() call is so filemap_cachestat()
can just call workingset_test_recent(). That seems reasonable, but makes
me wonder...

>  
> -	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
> +	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
>  	eviction <<= bucket_order;
>  
> -	rcu_read_lock();
>  	/*
>  	 * Look up the memcg associated with the stored ID. It might
>  	 * have been deleted since the folio's eviction.
> @@ -425,7 +448,8 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	 */
>  	eviction_memcg = mem_cgroup_from_id(memcgid);
>  	if (!mem_cgroup_disabled() && !eviction_memcg)
> -		goto out;
> +		return false;
> +
>  	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
>  	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
>  
> @@ -447,21 +471,6 @@ void workingset_refault(struct folio *folio, void *shadow)
>  	 */
>  	refault_distance = (refault - eviction) & EVICTION_MASK;
>  
> -	/*
> -	 * The activation decision for this folio is made at the level
> -	 * where the eviction occurred, as that is where the LRU order
> -	 * during folio reclaim is being determined.
> -	 *
> -	 * However, the cgroup that will own the folio is the one that
> -	 * is actually experiencing the refault event.
> -	 */
> -	nr = folio_nr_pages(folio);
> -	memcg = folio_memcg(folio);
> -	pgdat = folio_pgdat(folio);
> -	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> -
> -	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
> -
>  	mem_cgroup_flush_stats_delayed();
>  	/*
>  	 * Compare the distance to the existing workingset size. We
> @@ -483,8 +492,51 @@ void workingset_refault(struct folio *folio, void *shadow)
>  						     NR_INACTIVE_ANON);
>  		}
>  	}
> -	if (refault_distance > workingset_size)
> +
> +	return refault_distance <= workingset_size;
> +}
> +
> +/**
> + * workingset_refault - Evaluate the refault of a previously evicted folio.
> + * @folio: The freshly allocated replacement folio.
> + * @shadow: Shadow entry of the evicted folio.
> + *
> + * Calculates and evaluates the refault distance of the previously
> + * evicted folio in the context of the node and the memcg whose memory
> + * pressure caused the eviction.
> + */
> +void workingset_refault(struct folio *folio, void *shadow)
> +{
> +	bool file = folio_is_file_lru(folio);
> +	struct pglist_data *pgdat;
> +	struct mem_cgroup *memcg;
> +	struct lruvec *lruvec;
> +	bool workingset;
> +	long nr;
> +
> +	if (lru_gen_enabled()) {
> +		lru_gen_refault(folio, shadow);
> +		return;
> +	}

... if perhaps this should call workingset_test_recent() a bit earlier,
since it also covers the lru_gen_*() case..? That may or may not be
cleaner. It _seems like_ it might produce a bit more consistent logic,
but just a thought and I could easily be missing details.

> +
> +	rcu_read_lock();
> +
> +	nr = folio_nr_pages(folio);
> +	memcg = folio_memcg(folio);
> +	pgdat = folio_pgdat(folio);
> +	lruvec = mem_cgroup_lruvec(memcg, pgdat);
> +
> +	if (!workingset_test_recent(shadow, file, &workingset)) {
> +		/*
> +		 * The activation decision for this folio is made at the level
> +		 * where the eviction occurred, as that is where the LRU order
> +		 * during folio reclaim is being determined.
> +		 *
> +		 * However, the cgroup that will own the folio is the one that
> +		 * is actually experiencing the refault event.
> +		 */

IIUC, this comment is explaining the difference between using the
eviction lru (based on the shadow entry) to calculate recency vs. the
lru for the current folio to process the refault. If so, perhaps it
should go right above the workingset_test_recent() call? (Then the if
braces could go away as well..).

>  		goto out;
> +	}
>  
>  	folio_set_active(folio);
>  	workingset_age_nonresident(lruvec, nr);
> @@ -498,6 +550,7 @@ void workingset_refault(struct folio *folio, void *shadow)
>  		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
>  	}
>  out:
> +	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);

Why not just leave this up earlier in the function (i.e. before the
recency check) as it was originally?

Brian

>  	rcu_read_unlock();
>  }
>  
> -- 
> 2.30.2
> 

