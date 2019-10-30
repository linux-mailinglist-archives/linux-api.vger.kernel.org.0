Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 494E0E9513
	for <lists+linux-api@lfdr.de>; Wed, 30 Oct 2019 03:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfJ3CuX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 29 Oct 2019 22:50:23 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:43316 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726747AbfJ3CuX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 29 Oct 2019 22:50:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07486;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TgfhIsK_1572403814;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TgfhIsK_1572403814)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Oct 2019 10:50:17 +0800
Subject: Re: mbind() breaks its API definition since v5.2 by commit
 d883544515aa (mm: mempolicy: make the behavior consistent when MPOL_MF_MOVE*
 and MPOL_MF_STRICT were specified)
To:     Li Xinhai <lixinhai.lxh@gmail.com>, linux-mm <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        torvalds <torvalds@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lixinhai_lxh <lixinhai_lxh@126.com>
References: <2019103010274679257634@gmail.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <dc4864bf-8fa3-f5c8-f68c-57edc68d4662@linux.alibaba.com>
Date:   Tue, 29 Oct 2019 19:50:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2019103010274679257634@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



On 10/29/19 7:27 PM, Li Xinhai wrote:
> One change in do_mbind() of this commit has suspicious usage of return value of
> queue_pages_range(), excerpt as below:
>
> ---
> @@ -1243,10 +1265,15 @@ static long do_mbind(unsigned long start, unsigned long len,
>   	if (err)
>   		goto mpol_out;
>   
> -	err = queue_pages_range(mm, start, end, nmask,
> +	ret = queue_pages_range(mm, start, end, nmask,
>   			  flags | MPOL_MF_INVERT, &pagelist);
> -	if (!err)
> -		err = mbind_range(mm, start, end, new);
> +
> +	if (ret < 0) {      /////// convert to all possible 'ret' to '-EIO' <<<<
> +		err = -EIO;
> +		goto up_out;
> +	}
> +
> +	err = mbind_range(mm, start, end, new);
>   
>   	if (!err) {
>   		int nr_failed = 0;
> ---
>
> Note that inside queue_pages_range(), the call to walk_page_range() may return
> errors from 'test_walk' of 'struct mm_walk_ops', e.g. -EFAULT. Now, those error
> codes are no longer reported to user space application.
>
>  From user space, the mbind() call need to reported error, with EFAULT, as example:
> EFAULT
> Part or all of the memory range specified by nodemask and maxnode points
> outside your accessible address space. Or, there was an unmapped hole in the
> specified memory range specified by addr and len.

Thanks for catching this. That commit was aimed to correct the return 
values for some corner cases in mbind(), but it should not alter the 
errno for other failure cases, i.e. -EFAULT.

Could you please try the below patch (build test only)?

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4ae967b..99df43a 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1286,7 +1286,7 @@ static long do_mbind(unsigned long start, unsigned 
long len,
                           flags | MPOL_MF_INVERT, &pagelist);

         if (ret < 0) {
-               err = -EIO;
+               err = ret;
                 goto up_out;
         }


>
> Please correct me if this is the intended change(and will have updated API
> definition), or something was misunderstood.
>
> -Xinhai

