Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FA327B541
	for <lists+linux-api@lfdr.de>; Mon, 28 Sep 2020 21:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgI1T1I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Sep 2020 15:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgI1T1I (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Sep 2020 15:27:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8CC061755;
        Mon, 28 Sep 2020 12:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=wvOiw2+3bAcRKK9sP6ssyc0QGj9+IdGfx8mVk/nIt+w=; b=Q7y/5cgmDerOTHDRh4oEv9UU//
        E8wq/Q4/XuX538oWiXR/DXe1vpuxeaHGJWP92muVimbmfWaY6oD2LNjf3yoO75rNdPl5yBSSNkfYZ
        TUZPmCaq4h0Ebgh07+l4ArZqy90lM0dqpBBRLlMnGiDTXmeIDM1+jkym7vjuyPt2PgawtGYGDKyuw
        4UUe9JNcuR9bu2zJzh0M4xavAaxNGie+ArR2nI/cTTJ4En/LfdmAPTh8sQP+SaWO6cNlkhjsNIB9f
        6d3WM3KYyg2Lww+7H/il1O4Btu3qPdBHDPkdJbQJL6FhPWhz1ETtlB2PnQ1/DYFzen7meTCvND6PL
        XZnsT74A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMynZ-000560-K9; Mon, 28 Sep 2020 19:26:58 +0000
Subject: Re: [PATCH v11 6/6] docs: mm: numaperf.rst Add brief description for
 access class 1.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-mm@kvack.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        rafael@kernel.org, Ingo Molnar <mingo@redhat.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, linuxarm@huawei.com,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-api@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Hanjun Guo <guohanjun@huawei.com>
References: <20200928125235.446188-1-Jonathan.Cameron@huawei.com>
 <20200928125235.446188-7-Jonathan.Cameron@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <15e6f95b-adac-97e5-5ea9-4dd28ecf560d@infradead.org>
Date:   Mon, 28 Sep 2020 12:26:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200928125235.446188-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi--

On 9/28/20 5:52 AM, Jonathan Cameron wrote:
> Try to make minimal changes to the document which already describes
> access class 0 in a generic fashion (including IO initiatiors that
> are not CPUs).
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  v11: No change.
> 
>  Documentation/admin-guide/mm/numaperf.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
> index 4d69ef1de830..b89bb85eac75 100644
> --- a/Documentation/admin-guide/mm/numaperf.rst
> +++ b/Documentation/admin-guide/mm/numaperf.rst

> @@ -88,6 +93,9 @@ The latency attributes are provided in nanoseconds.
>  The values reported here correspond to the rated latency and bandwidth
>  for the platform.
>  
> +Access class 1, takes the same form, but only includes values for CPU to
> +memory activity.

-ETOOMANYCOMMAS.

Drop the first comma for sure. Maybe even the second one.

> +
>  ==========
>  NUMA Cache
>  ==========
> 

thanks.
-- 
~Randy

