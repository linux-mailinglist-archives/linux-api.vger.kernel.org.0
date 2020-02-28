Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C35241741EA
	for <lists+linux-api@lfdr.de>; Fri, 28 Feb 2020 23:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgB1WUl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 28 Feb 2020 17:20:41 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33535 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgB1WUl (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 28 Feb 2020 17:20:41 -0500
Received: by mail-vs1-f65.google.com with SMTP id n27so3009659vsa.0
        for <linux-api@vger.kernel.org>; Fri, 28 Feb 2020 14:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RLZDPkr+sbLOsLAqSk5t24KKVvpcoUu7pZBHwyGVF/w=;
        b=iGHi9zGlTxXPUGyfJ6aUjX/jWRV86OTlh52H3HYRIcBPHLkMLGGLkwHZ2G2RGrhjo+
         lc0LQFLKpfqzcLXa4Zq8VPTs0yfXEEM9ERN9sbCUxvBGj66WYsuk6KiWPfIPSNZmLp30
         IEH632S07sXyUQ79F3J5ezao+yF/Fpe7qru2HjbwueLbUIf4YiXSkL8NdnKY60uecYp0
         sJqGmPztqjek/tGyz+px0ir2Dfc4PCHkQsPr3Jxwbh701LYSw7ALikrNIcKSGoUHwcyx
         NXpQTdUZH0k3K3iD6/qJiQlPWTSMk22J8iaPaZl7KbxUT28WcnjG8YvZYCsAuaRXyrMd
         +PKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RLZDPkr+sbLOsLAqSk5t24KKVvpcoUu7pZBHwyGVF/w=;
        b=F7gSCNkDKk8zQsqi73cgfj3GiBMH2p2CzyclQRq6ZFtDuo2t+5ByUKQOO25ZiDDn1z
         a+k5j33Rek0IaEagSQvCcizEDovggTYtKyuKkZyitaVfU2pbAqSuT3i3smevAAi+ujaH
         ie2KyhdfKsekLCXbTXv5KezADwEXaQ2AL9OPM9JdJH0uR5UgbWODeZLMBMNjOamFkOHN
         G6RctBcXxX5rKoo8SkuZFz0mmK/NVi6pXTOGasj4IFMnUk0NfUA5weC1+kwcCXmcBrwI
         KQpRyZCWbTcXDIAOhdmGHgML1glG50o8NEC2MWK94UzTZrrMY1gS2a+rTT8Wa2jrlFWh
         67/A==
X-Gm-Message-State: ANhLgQ0h0ptTS2prVjWruV01UoCtymJQ3mmkcqSmpXwJ55/706XI5Ipo
        dC0WCPOGHmwDy1mULYQPrUdmSSgbn/aqAWi2whBSYg==
X-Google-Smtp-Source: ADFU+vucSYcoD6unlTY7xz6q7iqehwa133kDvpqR74txDiukj9Kg4F2LjdFUucWdyOzLGB0JoFtmLEYDoHqkSSGHZWQ=
X-Received: by 2002:a67:ed0a:: with SMTP id l10mr3731827vsp.239.1582928438632;
 Fri, 28 Feb 2020 14:20:38 -0800 (PST)
MIME-Version: 1.0
References: <20200219014433.88424-1-minchan@kernel.org> <20200219014433.88424-4-minchan@kernel.org>
In-Reply-To: <20200219014433.88424-4-minchan@kernel.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Feb 2020 14:20:27 -0800
Message-ID: <CAJuCfpH7cEuwobS3c=O0MzKtZi+6d2yK++YgSp7GViWPiJsgCg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] mm: check fatal signal pending of target process
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
>
> Bail out to prevent unnecessary CPU overhead if target process has
> pending fatal signal during (MADV_COLD|MADV_PAGEOUT) operation.
>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  mm/madvise.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f29155b8185d..def1507c2030 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -36,6 +36,7 @@
>  struct madvise_walk_private {
>         struct mmu_gather *tlb;
>         bool pageout;
> +       struct task_struct *target_task;
>  };
>
>  /*
> @@ -316,6 +317,10 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>         if (fatal_signal_pending(current))
>                 return -EINTR;
>
> +       if (private->target_task &&
> +                       fatal_signal_pending(private->target_task))
> +               return -EINTR;
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (pmd_trans_huge(*pmd)) {
>                 pmd_t orig_pmd;
> @@ -471,12 +476,14 @@ static const struct mm_walk_ops cold_walk_ops = {
>  };
>
>  static void madvise_cold_page_range(struct mmu_gather *tlb,
> +                            struct task_struct *task,
>                              struct vm_area_struct *vma,
>                              unsigned long addr, unsigned long end)
>  {
>         struct madvise_walk_private walk_private = {
>                 .pageout = false,
>                 .tlb = tlb,
> +               .target_task = task,
>         };
>
>         tlb_start_vma(tlb, vma);
> @@ -484,7 +491,8 @@ static void madvise_cold_page_range(struct mmu_gather *tlb,
>         tlb_end_vma(tlb, vma);
>  }
>
> -static long madvise_cold(struct vm_area_struct *vma,
> +static long madvise_cold(struct task_struct *task,
> +                       struct vm_area_struct *vma,
>                         struct vm_area_struct **prev,
>                         unsigned long start_addr, unsigned long end_addr)
>  {
> @@ -497,19 +505,21 @@ static long madvise_cold(struct vm_area_struct *vma,
>
>         lru_add_drain();
>         tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> -       madvise_cold_page_range(&tlb, vma, start_addr, end_addr);
> +       madvise_cold_page_range(&tlb, task, vma, start_addr, end_addr);
>         tlb_finish_mmu(&tlb, start_addr, end_addr);
>
>         return 0;
>  }
>
>  static void madvise_pageout_page_range(struct mmu_gather *tlb,
> +                            struct task_struct *task,
>                              struct vm_area_struct *vma,
>                              unsigned long addr, unsigned long end)
>  {
>         struct madvise_walk_private walk_private = {
>                 .pageout = true,
>                 .tlb = tlb,
> +               .target_task = task,
>         };
>
>         tlb_start_vma(tlb, vma);
> @@ -533,7 +543,8 @@ static inline bool can_do_pageout(struct vm_area_struct *vma)
>                 inode_permission(file_inode(vma->vm_file), MAY_WRITE) == 0;
>  }
>
> -static long madvise_pageout(struct vm_area_struct *vma,
> +static long madvise_pageout(struct task_struct *task,
> +                       struct vm_area_struct *vma,
>                         struct vm_area_struct **prev,
>                         unsigned long start_addr, unsigned long end_addr)
>  {
> @@ -549,7 +560,7 @@ static long madvise_pageout(struct vm_area_struct *vma,
>
>         lru_add_drain();
>         tlb_gather_mmu(&tlb, mm, start_addr, end_addr);
> -       madvise_pageout_page_range(&tlb, vma, start_addr, end_addr);
> +       madvise_pageout_page_range(&tlb, task, vma, start_addr, end_addr);
>         tlb_finish_mmu(&tlb, start_addr, end_addr);
>
>         return 0;
> @@ -929,7 +940,8 @@ static int madvise_inject_error(int behavior,
>  #endif
>
>  static long
> -madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
> +madvise_vma(struct task_struct *task, struct vm_area_struct *vma,
> +               struct vm_area_struct **prev,
>                 unsigned long start, unsigned long end, int behavior)
>  {
>         switch (behavior) {
> @@ -938,9 +950,9 @@ madvise_vma(struct vm_area_struct *vma, struct vm_area_struct **prev,
>         case MADV_WILLNEED:
>                 return madvise_willneed(vma, prev, start, end);
>         case MADV_COLD:
> -               return madvise_cold(vma, prev, start, end);
> +               return madvise_cold(task, vma, prev, start, end);
>         case MADV_PAGEOUT:
> -               return madvise_pageout(vma, prev, start, end);
> +               return madvise_pageout(task, vma, prev, start, end);
>         case MADV_FREE:
>         case MADV_DONTNEED:
>                 return madvise_dontneed_free(vma, prev, start, end, behavior);
> @@ -1140,7 +1152,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
>                         tmp = end;
>
>                 /* Here vma->vm_start <= start < tmp <= (end|vma->vm_end). */
> -               error = madvise_vma(vma, &prev, start, tmp, behavior);
> +               error = madvise_vma(target_task, vma, &prev,
> +                                       start, tmp, behavior);
>                 if (error)
>                         goto out;
>                 start = tmp;
> --
> 2.25.0.265.gbab2e86ba0-goog
>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
