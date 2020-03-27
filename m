Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 769B5195E5A
	for <lists+linux-api@lfdr.de>; Fri, 27 Mar 2020 20:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgC0TMz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 27 Mar 2020 15:12:55 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16807 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgC0TMz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Mar 2020 15:12:55 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e7e4fd90002>; Fri, 27 Mar 2020 12:11:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 27 Mar 2020 12:12:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 27 Mar 2020 12:12:54 -0700
Received: from [10.2.58.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Mar
 2020 19:12:54 +0000
Subject: Re: [PATCH] mm: introduce MAP_FIXED_HUGETLB_LEN to mmap()
To:     Li Xinhai <lixinhai.lxh@gmail.com>, <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a3444ac1-90d3-83fa-fd7b-85ea77c6e0ff@nvidia.com>
Date:   Fri, 27 Mar 2020 12:12:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585336281; bh=AUhaKHwkE+hJ0knKe/OQPJvGbUJPsl8juAKT/nUXcGs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SuGFEBOY89HbUB/8dwmtlXPFi9CqsooX3xi2wvEy6EcefC1toszAaC3njKprZDQHe
         Y/QrMlZpmNL+i+3948JNiH2luFT1tNbygv/JiI+DVLUZ+/vl9TV70Uve0Qeo7rtX60
         Qh7fu0c64mAvdy8NY+zfXC+Gs1CL8jQgwX4/c6a68TDr7f9y1f824RWUfOJ2zTmHDb
         OVRJ7CaWZSbpc4f/faO0nQVBAzCk0LG84m8iQE7ciRfUT0QT6+aQ6td9JypjS2cTSz
         vZ8b2hwYvy6yPtsPyDAbWgd6HlWO+oxBc3+Rk8Bjn6JPv9hpQVZYs7xJEi+4UIEiqr
         yHx8iw6rzvIUA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/27/20 5:59 AM, Li Xinhai wrote:
> The purpose of MAP_FIXED_HUGETLB_LEN is to check whether the parameter
> length is valid or not according to the target file's huge page size.
> When it is used, if length is not aligned to underlying huge page size,
> mmap() is failed with errno set to EINVAL. When it is not used, the
> current semantic is maintained, i.e., length is round up to underlying
> huge page size.
> 
> In current code, the vma related call, except mmap, are all consider
> not correctly aligned length as invalid parameter, including mprotect,
> munmap, mlock, etc., by checking through hugetlb_vm_op_split. So, user
> will see failure, after successfully call mmap, although using same
> length parameter to other mapping syscall.
> 
> With MAP_FIXED_HUGETLB_LEN, user can choose to check if length is
> correctly aligned at first place when call mmap, instead of failure after
> mapping has been created.

Hi Li,

This is not worth creating a new MAP_ flag. If you look at the existing flags
you will see that they are both limited and carefully chosen, so as to cover
a reasonable chunk of functionality per flag. We don't just drop in a flag
for tiny corner cases like this one.

btw, remember that user API changes require man pages updates as well. And
that the API has to be supported forever. And that if we use up valuable
flag slots on trivia then we'll run out of flags quite soon, and won't be
able to do broader, more important upgrades.

Also, we need to include a user space API mailing list for things that
affect that. Adding them now: Linux API <linux-api@vger.kernel.org>
The man pages mailing list will also be needed if we go there.

Let's take a closer look at your problem and see what it takes to solve it.
If we need some sort of flag to mmap() or other routines, fine. But so far,
I can see at least two solutions that are much easier:

> 
> Signed-off-by: Li Xinhai <lixinhai.lxh@gmail.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>   include/uapi/asm-generic/mman-common.h |  1 +
>   mm/mmap.c                              | 17 +++++++++++++++--
>   2 files changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index f94f65d..1c9ba97 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -21,6 +21,7 @@
>   #define MAP_TYPE	0x0f		/* Mask for type of mapping */
>   #define MAP_FIXED	0x10		/* Interpret addr exactly */
>   #define MAP_ANONYMOUS	0x20		/* don't use a file */
> +#define MAP_FIXED_HUGETLB_LEN	0x40	/* check alignment of addr, length, offset */
>   
>   /* 0x0100 - 0x4000 flags are defined in asm-generic/mman.h */
>   #define MAP_POPULATE		0x008000	/* populate (prefault) pagetables */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d681a20..50a12e0 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1560,9 +1560,18 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>   		file = fget(fd);
>   		if (!file)
>   			return -EBADF;
> -		if (is_file_hugepages(file))
> -			len = ALIGN(len, huge_page_size(hstate_file(file)));

Solution idea #1: because your proposal here requires changing the calling
(user space) code by adding the new flag to the mmap() call, it's therefore
clear that other changes to the calling code are also possible. So what
about simply doing the length check first, before calling mmap()? In other
words, do the user space equivalent of the above two lines that you're deleting?
That avoids your stated problem of calling mmap twice.


> +
>   		retval = -EINVAL;
> +		if (is_file_hugepages(file)) {
> +			struct hstate *hs = hstate_file(file);
> +
> +			if (flags & MAP_FIXED_HUGETLB_LEN &&
> +				len & ~(huge_page_mask(hs)))
> +				goto out_fput;
> +
> +			len = ALIGN(len, huge_page_size(hs));


Solution idea #2: just do the length check unconditionally here (without looking
at a new flag), and return an error if it is not aligned. And same thing for the
MAP_HUGETLB case below. And delete the "len = ALIGN(len, huge_page_size(hs));" in
both cases.

That would still require a man page update, and consensus that it won't Break
The World, but it's possible (I really don't know) that this is a more common
and desirable behavior.

Let's see if anyone else weighs in about this.


> +		}
> +
>   		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
>   			goto out_fput;
>   	} else if (flags & MAP_HUGETLB) {
> @@ -1573,6 +1582,10 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>   		if (!hs)
>   			return -EINVAL;
>   
> +		if (flags & MAP_FIXED_HUGETLB_LEN &&
> +			len & ~(huge_page_mask(hs)))
> +			return -EINVAL;
> +
>   		len = ALIGN(len, huge_page_size(hs));
>   		/*
>   		 * VM_NORESERVE is used because the reservations will be
> 


thanks,
-- 
John Hubbard
NVIDIA
