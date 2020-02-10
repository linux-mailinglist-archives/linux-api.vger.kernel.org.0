Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD35F1572F8
	for <lists+linux-api@lfdr.de>; Mon, 10 Feb 2020 11:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgBJKpH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 10 Feb 2020 05:45:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43218 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJKpH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 10 Feb 2020 05:45:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so6531988ljm.10
        for <linux-api@vger.kernel.org>; Mon, 10 Feb 2020 02:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BNx4VxoH3E26nb5mVtZHenO7uYXaeGKCX3HrnaRRsGM=;
        b=dyNqMJouR9bWVSssHqRG8taozcRDO+iNHSU5I1D2hgvnseaCXcUMj7tJEUtAlIGBmW
         AxZh4Q0R04v96UKWjfu8yLKMIHRQvLu0Js6aL7knWYQoNoG7FSTHRUORv3rJNFxyBg5G
         iye0rRWRcRKxsS7G8NyFXpXBKfA+Mv/IhLBw7/aTdcrd91/yOwhpQgLJTjCAIIeYPxCN
         bZrsv251OXANlrIb5mbJsOSIMiTfF/J1qwFGyaJQbiB6/IGH1CTCAGNfo/v6F1MGVfpS
         2gpPGyA8UjccjX8t9gQO7iQ223Wd0me9uA7WZwx0Gtq586kcBdC5MzPtinBJQGQ8uBH8
         I0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BNx4VxoH3E26nb5mVtZHenO7uYXaeGKCX3HrnaRRsGM=;
        b=Znqltaa1bPvrP0C5fQfQYFdtGj9P+oE8dczAJBnCIX4+Xg+JqKt7x6sJQl9IK3ZQNl
         4cvE5FRM7mJO140xgigN5mpUH6x62hKeIzgTJ9MwCoZ7O4VEFqEXI976PObX3PifA2Wd
         B0P8q/D8xCmzLXl70PxQWlglE+sJ6bYQQwbRfkKgWe2SpvWE+t6hLi1qYh5llak7iQr2
         uJpmBUsFdIFl1wZQR1WGsz5GsinM7VvBA3QaIDCelxEyIOCJ0ai9QBc5Ybxy1hEc+yYm
         xbJFC4s7DGoB0jh0VMVuUxDerB5+pnl99RyJm89wBM/uNfolk++inzgVqaDtK7TGy3ZS
         equw==
X-Gm-Message-State: APjAAAVw9m2CeVafjBqiyPEEbpXT3q4dtZubDQfxq3AuZfkT5UxqSJ1C
        rMc67yCNBv+9AtvV+3BxAsuWbg==
X-Google-Smtp-Source: APXvYqzyUEuxFAUfEIVcadkslHcmmVVpWoyic/17vJ/VNXRS8askqpbnT9FZG3o3qI5x0Zrl3T7RXg==
X-Received: by 2002:a2e:8755:: with SMTP id q21mr541832ljj.156.1581331502847;
        Mon, 10 Feb 2020 02:45:02 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r9sm6107449lfc.72.2020.02.10.02.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 02:45:02 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 9D0CD100B0A; Mon, 10 Feb 2020 13:45:20 +0300 (+03)
Date:   Mon, 10 Feb 2020 13:45:20 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Brian Geffon <bgeffon@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Yu Zhao <yuzhao@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH v4] mm: Add MREMAP_DONTUNMAP to mremap().
Message-ID: <20200210104520.cfs2oytkrf5ihd3m@box>
References: <20200207201856.46070-1-bgeffon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200207201856.46070-1-bgeffon@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Feb 07, 2020 at 12:18:56PM -0800, Brian Geffon wrote:
> When remapping an anonymous, private mapping, if MREMAP_DONTUNMAP is
> set, the source mapping will not be removed. Instead it will be
> cleared as if a brand new anonymous, private mapping had been created
> atomically as part of the mremap() call.  If a userfaultfd was watching
> the source, it will continue to watch the new mapping.  For a mapping
> that is shared or not anonymous, MREMAP_DONTUNMAP will cause the
> mremap() call to fail. Because MREMAP_DONTUNMAP always results in moving
> a VMA you MUST use the MREMAP_MAYMOVE flag. The final result is two
> equally sized VMAs where the destination contains the PTEs of the source.
> 
> We hope to use this in Chrome OS where with userfaultfd we could write
> an anonymous mapping to disk without having to STOP the process or worry
> about VMA permission changes.
> 
> This feature also has a use case in Android, Lokesh Gidra has said
> that "As part of using userfaultfd for GC, We'll have to move the physical
> pages of the java heap to a separate location. For this purpose mremap
> will be used. Without the MREMAP_DONTUNMAP flag, when I mremap the java
> heap, its virtual mapping will be removed as well. Therefore, we'll
> require performing mmap immediately after. This is not only time consuming
> but also opens a time window where a native thread may call mmap and
> reserve the java heap's address range for its own usage. This flag
> solves the problem."
>            
> Signed-off-by: Brian Geffon <bgeffon@google.com>
> ---
>  include/uapi/linux/mman.h |  5 +-
>  mm/mremap.c               | 98 ++++++++++++++++++++++++++++++---------
>  2 files changed, 80 insertions(+), 23 deletions(-)
> 
> diff --git a/include/uapi/linux/mman.h b/include/uapi/linux/mman.h
> index fc1a64c3447b..923cc162609c 100644
> --- a/include/uapi/linux/mman.h
> +++ b/include/uapi/linux/mman.h
> @@ -5,8 +5,9 @@
>  #include <asm/mman.h>
>  #include <asm-generic/hugetlb_encode.h>
>  
> -#define MREMAP_MAYMOVE	1
> -#define MREMAP_FIXED	2
> +#define MREMAP_MAYMOVE		1
> +#define MREMAP_FIXED		2
> +#define MREMAP_DONTUNMAP	4
>  
>  #define OVERCOMMIT_GUESS		0
>  #define OVERCOMMIT_ALWAYS		1
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 122938dcec15..9f4aa17f178b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -318,8 +318,8 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  static unsigned long move_vma(struct vm_area_struct *vma,
>  		unsigned long old_addr, unsigned long old_len,
>  		unsigned long new_len, unsigned long new_addr,
> -		bool *locked, struct vm_userfaultfd_ctx *uf,
> -		struct list_head *uf_unmap)
> +		bool *locked, unsigned long flags,
> +		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>  	struct vm_area_struct *new_vma;
> @@ -408,11 +408,41 @@ static unsigned long move_vma(struct vm_area_struct *vma,
>  	if (unlikely(vma->vm_flags & VM_PFNMAP))
>  		untrack_pfn_moved(vma);
>  
> +	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
> +		if (vm_flags & VM_ACCOUNT) {
> +			/* Always put back VM_ACCOUNT since we won't unmap */
> +			vma->vm_flags |= VM_ACCOUNT;
> +
> +			vm_acct_memory(vma_pages(new_vma));
> +		}
> +
> +		/*
> +		 * locked_vm accounting: if the mapping remained the same size
> +		 * it will have just moved and we don't need to touch locked_vm
> +		 * because we skip the do_unmap. If the mapping shrunk before
> +		 * being moved then the do_unmap on that portion will have
> +		 * adjusted vm_locked. Only if the mapping grows do we need to
> +		 * do something special; the reason is locked_vm only accounts
> +		 * for old_len, but we're now adding new_len - old_len locked
> +		 * bytes to the new mapping.
> +		 */
> +		if (new_len > old_len)
> +			mm->locked_vm += (new_len - old_len) >> PAGE_SHIFT;

Hm. How do you enforce that we're not over RLIMIT_MEMLOCK?


-- 
 Kirill A. Shutemov
