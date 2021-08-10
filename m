Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C7C3E8568
	for <lists+linux-api@lfdr.de>; Tue, 10 Aug 2021 23:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhHJVfh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 10 Aug 2021 17:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbhHJVfg (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 10 Aug 2021 17:35:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFDC061798
        for <linux-api@vger.kernel.org>; Tue, 10 Aug 2021 14:35:08 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v24-20020a0568300918b02904f3d10c9742so824176ott.4
        for <linux-api@vger.kernel.org>; Tue, 10 Aug 2021 14:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=owlKubz0VCC0V3BG8kdaZ1xrau2d//hIlJnyfzapz+s=;
        b=AEKpi0uIg7pyzBo4tSSu7frvNA2UyvuApWtvuMkpMkS7yaSyheLEb8zHuLNCITXFla
         bd9U5QSV+e9gdMv6FTgDM7FASRqfmv5ikOgOz2NmRNNIuRZifJmnnbGTa13+WIvf/h7d
         R0WP/4+s7/b4QG66dz/cEsSjmT37QecCQMknjaaOMs3ysZbOEEg6vChNkEYJGXmHYY3U
         j2iPyWAxEZRBkjaO2/loDu/EPj4LRJSXQRZAEV2Vkjc2sESwf+Sxfg/DWPT97dz1PzgO
         rbLe8Pjrp48llIKFJYzrGYOvnvfiMtQ1UKHtDfokSRUFUpQbNCuHV/swmHhrgqmvtSdz
         sXZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=owlKubz0VCC0V3BG8kdaZ1xrau2d//hIlJnyfzapz+s=;
        b=N7dQ34GUitRDLdhjrg+JG9HXf85XffCRJhld2Ezne7Bo1mhkkoFogf2gc/ofWgGy06
         X3YzVLNHcLBF2YdF8RS/5eUppsLWg4hTURqtF7GWetg2IWq4xEYIulEVgPqhEDfmoLX5
         1eBVGcF7Vm8JTRyANEzp7OFnovChEMtG0EhIogRTArGljykmaPNasfxVYKqHDbReq3Rj
         RLhhansLoxjUduVI6lSlH6VzrtbihKmyEPncSEUSSHgxTBbus5uoXoxSo09dcAxzfTBg
         zmvYiUCYb064zlfdUpXGu/x/Ipzfkfayekc5dv9XFQ8UyJlSE7EfTSif8f3w+8zLMJ+K
         rg9g==
X-Gm-Message-State: AOAM530Sy5QJP57vdOxxgEJct+8IVUdg39VfBKGs/km86Dnu5WNJJduh
        HzuQlm7L8rF2JlbKDmRS7kqbDQ==
X-Google-Smtp-Source: ABdhPJwte0HMSxmLKnkcfT0K1AKrEXn4M9+ysfn8DCxnrjGunubgPXOIXjYQCMSgXF5nqAQ8B58iyw==
X-Received: by 2002:a9d:5d14:: with SMTP id b20mr23125580oti.307.1628631308088;
        Tue, 10 Aug 2021 14:35:08 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 45sm295805otm.43.2021.08.10.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 14:35:07 -0700 (PDT)
Date:   Tue, 10 Aug 2021 14:35:05 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Feng Tang <feng.tang@intel.com>
cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>, ying.huang@intel.com
Subject: Re: [PATCH v7 3/5] mm/hugetlb: add support for mempolicy
 MPOL_PREFERRED_MANY
In-Reply-To: <20210810085048.GA67328@shbuild999.sh.intel.com>
Message-ID: <81f33a1-8ff-f2d4-63ff-de6c81d86f3@google.com>
References: <1627970362-61305-1-git-send-email-feng.tang@intel.com> <1627970362-61305-4-git-send-email-feng.tang@intel.com> <YQ06tNiDEsvl8004@dhcp22.suse.cz> <20210809024430.GA46432@shbuild999.sh.intel.com> <YRDqRMTXVZO9EkoC@dhcp22.suse.cz>
 <20210809123747.GB46432@shbuild999.sh.intel.com> <YRErZFQGZx4aPYuU@dhcp22.suse.cz> <20210810085048.GA67328@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 10 Aug 2021, Feng Tang wrote:
> On Mon, Aug 09, 2021 at 03:19:32PM +0200, Michal Hocko wrote:
> [snip]
> > > > Do you think you can provide same helpers for other policies as well?
> > > > Maybe we can get rid of some other ifdefery as well.
> > > 
> > > Sure. I can make separate patch(es) for that.
> > > 
> > > And you mean helper like mpol_is_bind/default/local/preferred? 
> > > 
> > > I just run 'git-grep MPOL', and for places using "mode == MPOL_XXX",
> > > mostly they are in mempolicy.[ch], the only another place is in
> > > shmem.c, do we need to create all the helpers for it and the
> > > potential future users? 
> > 
> > I would just go with those instances which need to ifdef for NUMA.
> > Thanks!
> 
> Yes, following is a patch to remove one CONFIG_NUMA check, though
> an bolder idea to extend the patch by removing the CONFIG_TMPFS
> check in the same line.
> 
> Thanks,
> Feng
> 
> ---------8<---------------------------------
> 
> From 1a5858721ac8ce99c27c13d310bba2983dc73d97 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Tue, 10 Aug 2021 17:00:59 +0800
> Subject: [PATCH] mm: shmem: avoid open coded check for mempolicy's mode
> 
> Add a mempolicy helper to do the check, which can also remove
> a CONFIG_NUMA option check.
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

No thanks: this is not an improvement.

The "#if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)" is there to
eliminate dead code that would not be automatically eliminated by the
optimizer: it's not there just to avoid MPOL_DEFAULT, and it's there
to cover shmem_get_sbmpol() along with shmem_show_mpol().

I know we tend to avoid #ifdefs in .c files, and that's good; and
I know you could find other code in mm/shmem.c which might also be
#ifdef'ed to eliminate other dead code in other configs; but unless
there's a new drive to purge our .c source of all #ifdefs,
please just leave this as is.

Thanks,
Hugh

> ---
>  include/linux/mempolicy.h | 14 ++++++++++++++
>  mm/shmem.c                |  8 ++++----
>  2 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 60d5e6c3340c..8fc518ad4f3c 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -192,6 +192,10 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>  	return  (pol->mode == MPOL_PREFERRED_MANY);
>  }
>  
> +static inline bool mpol_is_default(struct mempolicy *pol)
> +{
> +	return  (pol->mode == MPOL_DEFAULT);
> +}
>  
>  #else
>  
> @@ -287,6 +291,10 @@ static inline int mpol_parse_str(char *str, struct mempolicy **mpol)
>  }
>  #endif
>  
> +static inline void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
> +{
> +}
> +
>  static inline int mpol_misplaced(struct page *page, struct vm_area_struct *vma,
>  				 unsigned long address)
>  {
> @@ -309,5 +317,11 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>  	return  false;
>  }
>  
> +static inline bool mpol_is_default(struct mempolicy *pol)
> +{
> +	return  false;
> +}
> +
> +
>  #endif /* CONFIG_NUMA */
>  #endif
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 96f05f6af8bb..26b195209ef7 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1437,12 +1437,12 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_NUMA) && defined(CONFIG_TMPFS)
> +#ifdef CONFIG_TMPFS
>  static void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
>  {
>  	char buffer[64];
>  
> -	if (!mpol || mpol->mode == MPOL_DEFAULT)
> +	if (!mpol || mpol_is_default(mpol))
>  		return;		/* show nothing */
>  
>  	mpol_to_str(buffer, sizeof(buffer), mpol);
> @@ -1461,7 +1461,7 @@ static struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
>  	}
>  	return mpol;
>  }
> -#else /* !CONFIG_NUMA || !CONFIG_TMPFS */
> +#else /* !CONFIG_TMPFS */
>  static inline void shmem_show_mpol(struct seq_file *seq, struct mempolicy *mpol)
>  {
>  }
> @@ -1469,7 +1469,7 @@ static inline struct mempolicy *shmem_get_sbmpol(struct shmem_sb_info *sbinfo)
>  {
>  	return NULL;
>  }
> -#endif /* CONFIG_NUMA && CONFIG_TMPFS */
> +#endif /* CONFIG_TMPFS */
>  #ifndef CONFIG_NUMA
>  #define vm_policy vm_private_data
>  #endif
> -- 
> 2.14.1
