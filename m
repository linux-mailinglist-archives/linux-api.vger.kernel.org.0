Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B278312407B
	for <lists+linux-api@lfdr.de>; Wed, 18 Dec 2019 08:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfLRHjH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 18 Dec 2019 02:39:07 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:9692 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfLRHjH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Dec 2019 02:39:07 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9d7780002>; Tue, 17 Dec 2019 23:38:32 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 17 Dec 2019 23:39:01 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 17 Dec 2019 23:39:01 -0800
Received: from [10.2.165.11] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 07:39:00 +0000
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>, <cl@linux.com>,
        <mhocko@suse.com>, <cai@lca.pw>, <akpm@linux-foundation.org>
CC:     <linux-man@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
 <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
 <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
 <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <51dd767a-221f-882d-c7f6-45bd0c217a67@nvidia.com>
Date:   Tue, 17 Dec 2019 23:36:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <092adc11-7039-9343-7067-0e0199c9dc13@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576654712; bh=niungb3NWD18TtefGE0yuSB9KQjV5p6gDgvusv9+FwI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=X354docB+XmzyyqCzg1MdSpZNg566c/6yQnQBXH5PDwsDqnxS9VZosRWzmgFPx1kK
         pX1HnjmCJkD9oL7TKeuV09T7Yf8gE6nLdUpsLTYrpu07eV086GCwsAKjSGk+y0hWcx
         8Ovea66u32wFR2tHgg3rr29yuH5rUCAtBe+yB3wkUs7RTh9wVWIZa/E1EjRfSZkfNB
         hD/jkDZA4NYnmD6j5j9SzmnUsR2NFQrb3S9+Do7VSY7ADTKKcbLqdCJskovWQ9AB4V
         BmIv8Ne1Kp5QGrKlAUBkcy4/YTMCpMvZA8K659fne+/74Kj7g1Db0JV+woSeQiywsU
         0tSdJe7cP8yuA==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12/13/19 5:55 PM, Michael Kerrisk (man-pages) wrote:
...
>>> whoa, hold on. If I'm reading through the various error paths
>>> correctly, then this
>>> code is *never* going to return ENOENT for the whole function. It can
>>> fill in that
>>> value per-page, in the status array, but that's all. Did I get that
>>> right?
>>
>> Nice catch. Yes, you are right.
>>
>>>
>>> If so, we need to redo this part of the man page.
>>
>> Yes.
> 
> So where are things at with this? Is an improved man-pages
> patch on the way, or is some other action (on the API) planned?
> 

I was waiting to see if Yang was going to respond...anyway, I think
we're looking at approximately this sort of change:

diff --git a/man2/move_pages.2 b/man2/move_pages.2
index 2d96468fa..1bf1053f2 100644
--- a/man2/move_pages.2
+++ b/man2/move_pages.2
@@ -191,12 +191,6 @@ was specified or an attempt was made to migrate pages of a kernel thread.
  .B ENODEV
  One of the target nodes is not online.
  .TP
-.B ENOENT
-No pages were found that require moving.
-All pages are either already
-on the target node, not present, had an invalid address or could not be
-moved because they were mapped by multiple processes.
-.TP
  .B EPERM
  The caller specified
  .B MPOL_MF_MOVE_ALL

...But I'm not sure if we should change the implementation, instead, so
that it *can* return ENOENT. That's the main question to resolve before
creating any more patches, I think.

In addition, Michal mentioned that the page states in the status array also
need updated documentation.


thanks,
-- 
John Hubbard
NVIDIA
