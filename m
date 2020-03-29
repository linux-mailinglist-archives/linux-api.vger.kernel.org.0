Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4315A196AE8
	for <lists+linux-api@lfdr.de>; Sun, 29 Mar 2020 05:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC2DxJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 28 Mar 2020 23:53:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1590 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgC2DxJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 28 Mar 2020 23:53:09 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e801b460000>; Sat, 28 Mar 2020 20:51:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 28 Mar 2020 20:53:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 28 Mar 2020 20:53:08 -0700
Received: from [10.2.58.50] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 29 Mar
 2020 03:53:08 +0000
Subject: Re: [PATCH] mm: allow checking length for hugetlb mapping in mmap()
To:     Li Xinhai <lixinhai.lxh@gmail.com>, <linux-mm@kvack.org>
CC:     <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1585451295-22302-1-git-send-email-lixinhai.lxh@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f8b5b647-9041-8127-925c-1c8dcb508f24@nvidia.com>
Date:   Sat, 28 Mar 2020 20:53:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585451295-22302-1-git-send-email-lixinhai.lxh@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585453894; bh=NfEElATanGXp13na3lUpdTsmmzPeIP2rqZ50O/f1exk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=pLE1149/A+cR5S345/tFxoBhdj5NW3ZDXteirzwCr8YDWSAdN8ittKZ3m95nhuMTe
         rK0fIpTeVggDxMpextcycJf+rsdzYKk0bzJCvwMYP34ICIKrxz0iMjoeVT5AOhNqsW
         2PLAxp4yHdSSNpe6drCoZLzANF0T9YBZtM3ZiWcazFMnmhT8tP4CkV4MUKYc1ikysA
         bfct3fFZ0lr/DTPpGGv0ce0jJFf5TCXXIoYl0+bcCPH8rDZw98EeZ5+P+mdkg8B7Oe
         SVAqkUh0gBlUxphneL2bsAk4paZFXe4ltD39k+4BMRjDAIPBYsEXkGYZX0p82MS4Lh
         IYv9HuP6eh7Xw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/28/20 8:08 PM, Li Xinhai wrote:
> In current code, the vma related call of hugetlb mapping, except mmap,
> are all consider not correctly aligned length as invalid parameter,
> including mprotect,munmap, mlock, etc., by checking through
> hugetlb_vm_op_split. So, user will see failure, after successfully call
> mmap, although using same length parameter to other mapping syscall.
> 
> It is desirable for all hugetlb mapping calls have consistent behavior,
> without mmap as exception(which round up length to align underlying
> hugepage size). In current Documentation/admin-guide/mm/hugetlbpage.rst,
> the description is:
> "
> Syscalls that operate on memory backed by hugetlb pages only have their
> lengths aligned to the native page size of the processor; they will
> normally fail with errno set to EINVAL or exclude hugetlb pages that
> extend beyond the length if not hugepage aligned. For example, munmap(2)
> will fail if memory is backed by a hugetlb page and the length is smaller
> than the hugepage size.
> "
> which express the consistent behavior.


Missing here is a description of what the patch actually does...

> 
> Signed-off-by: Li Xinhai <lixinhai.lxh@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
> changes:
> 0. patch which introduce new flag for mmap()
>     The new flag should be avoided.
>     https://lore.kernel.org/linux-mm/1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com/
> 
>   mm/mmap.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d681a20..b2aa102 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1560,20 +1560,12 @@ unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
>   		file = fget(fd);
>   		if (!file)
>   			return -EBADF;
> -		if (is_file_hugepages(file))
> -			len = ALIGN(len, huge_page_size(hstate_file(file)));


...and it looks like this is simply removing the forced alignment. And not adding
any error case for non-aligned cases. So now I'm not immediately sure what happens if a
non-aligned address is passed in.

I would have expected to see either error checking or an ALIGN call here, but now both
are gone, so I'm lost and confused. :)


thanks,
-- 
John Hubbard
NVIDIA

>   		retval = -EINVAL;
>   		if (unlikely(flags & MAP_HUGETLB && !is_file_hugepages(file)))
>   			goto out_fput;
>   	} else if (flags & MAP_HUGETLB) {
>   		struct user_struct *user = NULL;
> -		struct hstate *hs;
>   
> -		hs = hstate_sizelog((flags >> MAP_HUGE_SHIFT) & MAP_HUGE_MASK);
> -		if (!hs)
> -			return -EINVAL;
> -
> -		len = ALIGN(len, huge_page_size(hs));
>   		/*
>   		 * VM_NORESERVE is used because the reservations will be
>   		 * taken when vm_ops->mmap() is called
> 
