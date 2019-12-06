Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69DDC114A97
	for <lists+linux-api@lfdr.de>; Fri,  6 Dec 2019 02:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfLFBri (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Dec 2019 20:47:38 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1493 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLFBrh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Dec 2019 20:47:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5de9b33d0000>; Thu, 05 Dec 2019 17:47:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 05 Dec 2019 17:47:37 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 05 Dec 2019 17:47:37 -0800
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec
 2019 01:47:36 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Dec 2019
 01:47:36 +0000
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
Message-ID: <683f6cae-0e0c-d4e4-0929-7fd1a79a2266@nvidia.com>
Date:   Thu, 5 Dec 2019 17:47:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1575596861; bh=hHAqZuqTQkT4Jg75DDaPISOvw/O4fuowgbjbEnHGf64=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=f6tCm1D/suIescD8w+pxCD2rleaR43m1WcZ5BxpODtT57dOMzvFdKTb0ou58JXsBL
         myUNvQvY77xa9Ds51TSoJjp78o/Ss96pAv4jnfqTGAmWpgdHE1pno3y9pCu365EnXl
         UHwvY9vmfGltMN1M2EiH3Gn7ZksERB31c1jFtN/DkOOWVrD2zlBg2XBvoSLYH8YsYB
         iy5jpU3sIw0Wr/mWb4yiyok+YlL/R2wvhRONVgj58Sp/gEFFD8vgj2pGtckc8prZxd
         J2C0PMS1e6I1UT2M30e+Ytfc/FchC1kDISdWP67a0toIT7CyFw+uE1Y2939yHLoqit
         xRO8aymsX2TCw==
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12/5/19 5:34 PM, Yang Shi wrote:
...
> 
> diff --git a/man2/move_pages.2 b/man2/move_pages.2
> index 2d96468..2a2f3cd 100644
> --- a/man2/move_pages.2
> +++ b/man2/move_pages.2
> @@ -192,9 +192,8 @@ was specified or an attempt was made to migrate pages of a kernel thread.
>  One of the target nodes is not online.
>  .TP
>  .B ENOENT
> -No pages were found that require moving.
> -All pages are either already
> -on the target node, not present, had an invalid address or could not be
> +No pages were found.
> +All pages are either not present, had an invalid address or could not be
>  moved because they were mapped by multiple processes.

How about this wording (ignoring man formatting for the moment):

No pages were moved, because all requested pages fell into one or more of
the following cases:

* Page not present.
* Page has an invalid address.
* Page is mapped by multiple processes.

Reasoning: I don't like the "no pages were found" all by itself, because it
blindly rewords the meaning of ENOENT. ENOENT is merely the closest
symbol we have. So we use ENOENT and that's fine, but the descriptive text 
should describe what really happened, which is "no pages were moved". If we had 
an ENOPAGESMOVED then we'd use that. :)

thanks,
-- 
John Hubbard
NVIDIA
