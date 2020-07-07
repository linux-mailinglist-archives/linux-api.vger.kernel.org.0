Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1CB2165BC
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 07:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGGFHk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 01:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgGGFHj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Jul 2020 01:07:39 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E423C061794
        for <linux-api@vger.kernel.org>; Mon,  6 Jul 2020 22:07:39 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x83so26366025oif.10
        for <linux-api@vger.kernel.org>; Mon, 06 Jul 2020 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zAb/McZ8XV6K9mwnFmuQqAT3ttMAxvJlZ4c61ur+Pa0=;
        b=D+Yof6FF8oNlsgkmvQuu9+VtHHmA9NcZHMWdtgSC/QSPt6pr1sj+AiB3zxUjck6g39
         ywslF1il3kMVm/aWTK3rXKezuwLifVn5w7C3ifktqJEi2o4eOwDbGiuHK27GRm7Un1V/
         uAGDZ8reGtpiSosTpJXUMmhGknY10wUjR85pjFzVX9eFUNrcCBBFnL8Yv5a8Tovk6IKf
         E3O8YyKBDq73PTmSGkB/uslZp7RItO6oHD4KJbDoraUxxlpQe7aAhSwYZ/1b/2XmNUE/
         kxJUH9iulFf8gugSa6TU/gETmNRFstl1Sq18kRVs8wwztF+RvVtQHYR2ezRguq6oNQze
         mssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zAb/McZ8XV6K9mwnFmuQqAT3ttMAxvJlZ4c61ur+Pa0=;
        b=XDZPJwNxcmN6iKj3dliG4DEVZkZ4CKSHZkIThWAjNUw7As/tKww5bbCQmu8MkWfSoW
         e/F4M4hsLTOKkd3Fj3Qs+HAmpcl67mA2DDk0zhgiTTZALiKb7BPdIKzIqClvMjd2VOC4
         XC3PLe8UYiXXNphPoeIRKM9hg/l/B1yeciDYzRMvF84sCmKflpB/vyCem9epDYvfTtQA
         pusft3WWaD0ApycBf/iA96rdTiWYvhrG5GZFCx8B4KdYkzHTWSnyNHRAqoCn9e+6Hugf
         fR/r5w4C17qJmaVIs69tIu2knYDELJwZgRuxN0DPvFrcZCwHb/xUjJinpYBz2U5VHBpj
         vWTA==
X-Gm-Message-State: AOAM533YCgjISj5uYOCuouR4S02ykyZbyt5JbUDOMqMH5LnUL+wvVmE/
        WSC6aFfspDnzMl3OT7LDvWPrdg==
X-Google-Smtp-Source: ABdhPJxVEHb5iTVD+kSh7pvIzuQgzyhih6LB4C6jdkDUZbpZpAoAQywdAuQlqTiMn0b3PGXucearDA==
X-Received: by 2002:aca:5158:: with SMTP id f85mr2097275oib.6.1594098458258;
        Mon, 06 Jul 2020 22:07:38 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t187sm5490060oib.45.2020.07.06.22.07.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 06 Jul 2020 22:07:37 -0700 (PDT)
Date:   Mon, 6 Jul 2020 22:07:34 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Mike Rapoport <rppt@kernel.org>
cc:     Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Idan Yaniv <idan.yaniv@ibm.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH v2 1/5] mm: make HPAGE_PxD_{SHIFT,MASK,SIZE} always
 available
In-Reply-To: <20200706172051.19465-2-rppt@kernel.org>
Message-ID: <alpine.LSU.2.11.2007062153000.2793@eggly.anvils>
References: <20200706172051.19465-1-rppt@kernel.org> <20200706172051.19465-2-rppt@kernel.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 6 Jul 2020, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> The definitions of shift, mask and size for the second and the third level
> of the leaf pages are available only when CONFIG_TRANSPARENT_HUGEPAGE is
> set. Otherwise they evaluate to BUILD_BUG().
> 
> There is no explanation neither in the code nor in the changelog why the
> usage of, e.g. HPAGE_PMD_SIZE should be only allowed with THP and forbidden
> otherwise while the definitions of HPAGE_PMD_SIZE and HPAGE_PUD_SIZE
> express the sizes better than ambiguous HPAGE_SIZE.
> 
> Make HPAGE_PxD_{SHIFT,MASK,SIZE} definitions available unconditionally.

Adding Andrea to Cc, he's the one who structured it that way,
and should be consulted.

I'm ambivalent myself.  Many's the time I've been irritated by the
BUILD_BUG() in HPAGE_etc, and it's responsible for very many #ifdef
CONFIG_TRANSPARENT_HUGEPAGEs or IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)s
that you find uglily scattered around the source.

But that's the point of it: it's warning when you write code peculiar
to THP, that is going to bloat the build of kernels without any THP.

So although I've often been tempted to do as you suggest, I've always
ended up respecting Andrea's intention, and worked around it instead
(sometimes with #ifdef or IS_ENABLED(), sometimes with
PMD_{SHIFT,MASK_SIZE}, sometimes with a local definition).

Hugh

> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  include/linux/huge_mm.h | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 71f20776b06c..1f4b44a76e31 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -115,7 +115,6 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
>  #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define HPAGE_PMD_SHIFT PMD_SHIFT
>  #define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
>  #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
> @@ -124,6 +123,8 @@ extern struct kobj_attribute shmem_enabled_attr;
>  #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
>  #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
>  
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +
>  extern unsigned long transparent_hugepage_flags;
>  
>  /*
> @@ -316,13 +317,6 @@ static inline struct list_head *page_deferred_list(struct page *page)
>  }
>  
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
> -#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> -#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
> -#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
> -
> -#define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
> -#define HPAGE_PUD_MASK ({ BUILD_BUG(); 0; })
> -#define HPAGE_PUD_SIZE ({ BUILD_BUG(); 0; })
>  
>  static inline int hpage_nr_pages(struct page *page)
>  {
> -- 
> 2.26.2
