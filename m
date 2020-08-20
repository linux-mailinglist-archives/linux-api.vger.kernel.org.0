Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D623B24C7B9
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgHTWVh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Aug 2020 18:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgHTWVb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 20 Aug 2020 18:21:31 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C832075E;
        Thu, 20 Aug 2020 22:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597962091;
        bh=YZFXjRScFns5Q/JX8kMKWW0SqdzIXgtS9wkbdlVq+aY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=knEda3aCkNQRb87lx+sMgW3yN3C0Y6JlzUzcCgx8GpjQ10pVHNJ4crvidnJ1gmard
         5v3EkkglnDiXCky0Pjvo1GthcdGBaGo/AMvK4GnWaK1ckhnJ7Kws0ZkiAgZ0Z2+TtX
         yfwNjy/fqDviqP4iGN/YePrORscJex7NxAo+wTqo=
Date:   Thu, 20 Aug 2020 17:21:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linuxarm@huawei.com,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v9 4/6] ACPI: HMAT: Fix handling of changes from ACPI 6.2
 to ACPI 6.3
Message-ID: <20200820222129.GA1571389@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819145111.1715026-5-Jonathan.Cameron@huawei.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 19, 2020 at 10:51:09PM +0800, Jonathan Cameron wrote:
> In ACPI 6.3, the Memory Proximity Domain Attributes Structure
> changed substantially.  One of those changes was that the flag
> for "Memory Proximity Domain field is valid" was deprecated.
> 
> This was because the field "Proximity Domain for the Memory"
> became a required field and hence having a validity flag makes
> no sense.
> 
> So the correct logic is to always assume the field is there.
> Current code assumes it never is.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/numa/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c32cfb72370..07cfe50136e0 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -424,7 +424,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>  		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
>  			p->flags, p->processor_PD, p->memory_PD);
>  
> -	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
> +	if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) || hmat_revision == 2) {

I hope/assume the spec is written in such a way that p->memory_PD is
required for any revision > 1?  So maybe this should be:

  if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) ||
      hmat_revision > 1) {

>  		target = find_mem_target(p->memory_PD);
>  		if (!target) {
>  			pr_debug("HMAT: Memory Domain missing from SRAT\n");
> -- 
> 2.19.1
> 
