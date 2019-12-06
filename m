Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52160114DA5
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfLFI2o (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 Dec 2019 03:28:44 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11643 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfLFI2n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 Dec 2019 03:28:43 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dea11290001>; Fri, 06 Dec 2019 00:28:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 06 Dec 2019 00:28:42 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 06 Dec 2019 00:28:42 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 08:28:42 +0000
Received: from [10.2.163.87] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec 2019
 08:28:41 +0000
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
To:     Yang Shi <yang.shi@linux.alibaba.com>, <mtk.manpages@gmail.com>,
        <cl@linux.com>, <mhocko@suse.com>, <cai@lca.pw>,
        <akpm@linux-foundation.org>
CC:     <linux-man@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
Date:   Fri, 6 Dec 2019 00:25:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575620906; bh=1U4N9I7Sc9y0IjpHHe/ILL0my6L0bvlv/3soA/LZXBQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ru2aIusPL9M9jcFeBHIHwJL3XtTEuuYrZjBbbQ3J7Cbg8Ami0xgtltwuvHSHLAYnj
         ufrGfv8+HhxpcBAqWuj+1diQqpDKAt6+G0arLN5UFadEBm5m3sv0FD1X3slEkcOrZC
         exXvz6mIgaxUz6oK/oBsVvNU4BmwWeuo6IA1/1qyCTtgtSj48AAE/T9A2raC+/quM/
         Hs7+SMLGPgIjxjs6IlK58OmrEkie+Jb/C5Z5YBpdQe7YWrwmqkOdmpPaIXCUbrYcIK
         NKygTVKq1TqzibJgX8z16/XaOlsI8p1DHz4dWRBxr7Q3OxT2rqJoALrdAwOY0LfxFQ
         H2vFanrsahMdQ==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12/5/19 5:34 PM, Yang Shi wrote:
> Since commit e78bbfa82624 ("mm: stop returning -ENOENT
> from sys_move_pages() if nothing got migrated"), move_pages doesn't
> return -ENOENT anymore if the pages are already on the target nodes, but
> this change is never reflected in manpage.
> 
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Qian Cai <cai@lca.pw>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>   man2/move_pages.2 | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 2d96468..2a2f3cd 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -192,9 +192,8 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>   One of the target nodes is not online.
>   .TP
>   .B ENOENT
> -No pages were found that require moving.
> -All pages are either already
> -on the target node, not present, had an invalid address or could not be
> +No pages were found.
> +All pages are either not present, had an invalid address or could not be
>   moved because they were mapped by multiple processes.
>   .TP
>   .B EPERM
> 

whoa, hold on. If I'm reading through the various error paths correctly, then this
code is *never* going to return ENOENT for the whole function. It can fill in that
value per-page, in the status array, but that's all. Did I get that right?

If so, we need to redo this part of the man page.


thanks,
-- 
John Hubbard
NVIDIA
