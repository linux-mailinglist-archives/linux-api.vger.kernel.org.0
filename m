Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7049319838A
	for <lists+linux-api@lfdr.de>; Mon, 30 Mar 2020 20:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgC3Slz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Mar 2020 14:41:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37272 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgC3Slz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Mar 2020 14:41:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UIda16060704;
        Mon, 30 Mar 2020 18:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=dhrzUGgVm+Wzh5ejmhh2gbHZgBqZJCbqEjk0hhpoY80=;
 b=y0Z/L4HWR0nONsb7Sw3W3ZnFN3YgCBpW5RyHFHvYZ/g401dfAEj4p5Wz9i+Ai3CKrKE+
 rwCqjMvEqsBxrVLwdEnZwrSEO9BecPrjsHvqnTPHzy7Ds0CkceI722QP5lEA4NWUksiI
 GjwfouvhxqwVUnkEBwrucQHO8tOdKkuiaTlZJalMq+RRr+jxoeSs0T8gRdP0jXp7TIb5
 9hPXmjQzfYjYNICriv6r346mMS3AP7NI3xAZ/ZKvN6OlcgIz5u48Ew7ifPmkFebpB1oK
 7hwNLt1aa6igny5ESDNXxXbAIRzgu8/z8LZkJv/ihiPoe4/WYs/VmbFQcTqYSEuk7DxX /w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 303ceuufv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 18:41:48 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02UIapno183588;
        Mon, 30 Mar 2020 18:39:48 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 302g2ccx6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Mar 2020 18:39:48 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02UIdkBc017835;
        Mon, 30 Mar 2020 18:39:46 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Mar 2020 11:39:45 -0700
Subject: Re: [PATCH] mm: allow checking length for hugetlb mapping in mmap()
To:     Li Xinhai <lixinhai.lxh@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        akpm <akpm@linux-foundation.org>
References: <1585451295-22302-1-git-send-email-lixinhai.lxh@gmail.com> <>
 <f8b5b647-9041-8127-925c-1c8dcb508f24@nvidia.com>
 <2020032916093522557671@gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <5e02a305-038f-b86c-31e7-85358563cbc5@oracle.com>
Date:   Mon, 30 Mar 2020 11:39:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2020032916093522557671@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9576 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003300157
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/29/20 1:09 AM, Li Xinhai wrote:
> On 2020-03-29 at 11:53 John Hubbard wrote:
>> On 3/28/20 8:08 PM, Li Xinhai wrote:
>>> In current code, the vma related call of hugetlb mapping, except mmap,
>>> are all consider not correctly aligned length as invalid parameter,
>>> including mprotect,munmap, mlock, etc., by checking through
>>> hugetlb_vm_op_split. So, user will see failure, after successfully call
>>> mmap, although using same length parameter to other mapping syscall.
>>>
>>> It is desirable for all hugetlb mapping calls have consistent behavior,
>>> without mmap as exception(which round up length to align underlying
>>> hugepage size). In current Documentation/admin-guide/mm/hugetlbpage.rst,
>>> the description is:
>>> "
>>> Syscalls that operate on memory backed by hugetlb pages only have their
>>> lengths aligned to the native page size of the processor; they will
>>> normally fail with errno set to EINVAL or exclude hugetlb pages that
>>> extend beyond the length if not hugepage aligned. For example, munmap(2)
>>> will fail if memory is backed by a hugetlb page and the length is smaller
>>> than the hugepage size.
>>> "
>>> which express the consistent behavior.
>>
>>
>> Missing here is a description of what the patch actually does...
>>
> 
> right, more statement can be added like:
> "
> After this patch, all hugetlb mapping related syscall wil only align
> length parameter to the native page size of the processor. For mmap(),
> hugetlb_get_unmmaped_area() will set errno to EINVAL if length is not
> aligned to underlying hugepage size.
> "
> 
>>>
>>> Signed-off-by: Li Xinhai <lixinhai.lxh@gmail.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>> changes:
>>> 0. patch which introduce new flag for mmap()
>>>      The new flag should be avoided.
>>> https://lore.kernel.org/linux-mm/1585313944-8627-1-git-send-email-lixinhai.lxh@gmail.com/

It is not exactly clear in your commit message, but this change will cause
mmap() of hugetlb ranges to fail (-EINVAL) if length is not a multiple of
huge page size.  The mmap man page says:

  Huge page (Huge TLB) mappings
       For mappings that employ huge pages, the requirements for the arguments
       of  mmap()  and munmap() differ somewhat from the requirements for map‐
       pings that use the native system page size.

       For mmap(), offset must be a multiple of the underlying huge page size.
       The system automatically aligns length to be a multiple of the underly‐
       ing huge page size.

       For munmap(), addr and length must both be a multiple of the underlying
       huge page size.

So this change may cause application failure.  The code you are removing was
added with commit af73e4d9506d.  The commit message for that commit says:

    hugetlbfs: fix mmap failure in unaligned size request
    
    The current kernel returns -EINVAL unless a given mmap length is
    "almost" hugepage aligned.  This is because in sys_mmap_pgoff() the
    given length is passed to vm_mmap_pgoff() as it is without being aligned
    with hugepage boundary.
    
    This is a regression introduced in commit 40716e29243d ("hugetlbfs: fix
    alignment of huge page requests"), where alignment code is pushed into
    hugetlb_file_setup() and the variable len in caller side is not changed.

The change in commit af73e4d9506d was added because causing mmap to return
-EINVAL if length is not a multiple of huge page size was considered a
regression.  It would still be considered a regression today.

I understand that the behavior not consistent.  However, it is clearly
documented.  I do not believe we can change the behavior of this code.

-- 
Mike Kravetz
