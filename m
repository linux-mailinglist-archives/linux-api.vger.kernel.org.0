Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3645724D4BB
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 14:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbgHUMOD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Aug 2020 08:14:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbgHUMN6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 Aug 2020 08:13:58 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1E0D2078D;
        Fri, 21 Aug 2020 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598012038;
        bh=uVOgG9JFL4Fi6p0po8bQ65Th7wRBuNvR5zhzLTPFR5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ox5cTwPbjAUMDQ3PBaEQj29JiEe+7IH6AXVS6NxjULgL51ySfWOkFhBpDTJzVedaY
         /UuJysTOHbBMdbgEM7N7gU5gumkTHskOHzhwVjf+hvwlVhTurv/GZKKfyOQ8zI5AmJ
         zAPVwHcdFODduuOfyQXQDv1dwLqxCHq47/KNa/tk=
Date:   Fri, 21 Aug 2020 07:13:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, rafael@kernel.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, linuxarm@huawei.com,
        Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-api@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v9 4/6] ACPI: HMAT: Fix handling of changes from ACPI 6.2
 to ACPI 6.3
Message-ID: <20200821121356.GA1616281@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821094258.00007925@Huawei.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[+cc Keith, author of 3accf7ae37a9 ("acpi/hmat: Parse and report
heterogeneous memory")]

On Fri, Aug 21, 2020 at 09:42:58AM +0100, Jonathan Cameron wrote:
> On Thu, 20 Aug 2020 17:21:29 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Aug 19, 2020 at 10:51:09PM +0800, Jonathan Cameron wrote:
> > > In ACPI 6.3, the Memory Proximity Domain Attributes Structure
> > > changed substantially.  One of those changes was that the flag
> > > for "Memory Proximity Domain field is valid" was deprecated.
> > > 
> > > This was because the field "Proximity Domain for the Memory"
> > > became a required field and hence having a validity flag makes
> > > no sense.
> > > 
> > > So the correct logic is to always assume the field is there.
> > > Current code assumes it never is.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/acpi/numa/hmat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > index 2c32cfb72370..07cfe50136e0 100644
> > > --- a/drivers/acpi/numa/hmat.c
> > > +++ b/drivers/acpi/numa/hmat.c
> > > @@ -424,7 +424,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
> > >  		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
> > >  			p->flags, p->processor_PD, p->memory_PD);
> > >  
> > > -	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
> > > +	if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) || hmat_revision == 2) {  
> > 
> > I hope/assume the spec is written in such a way that p->memory_PD is
> > required for any revision > 1?  So maybe this should be:
> > 
> >   if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) ||
> >       hmat_revision > 1) {

I should have said simply:

  if (hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID)

We shouldn't even test p->flags for ACPI_HMAT_MEMORY_PD_VALID unless
we already know it's revision 1.

And unless there was a revision 0 of HMAT, there's no need to look for
hmat_revison > 1.

> Good point.  We have existing protections elsewhere against
> hmat_revision being anything other than 1 or 2, so we should aim to
> keep that in only one place.

I think the "Ignoring HMAT: Unknown revision" test in hmat_init(),
added by 3accf7ae37a9 ("acpi/hmat: Parse and report heterogeneous
memory"), is a mistake.

And I think hmat_normalize() has a similar mistake in that it tests
explicitly for hmat_revision == 2 when it should accept 2 AND anything
later.

We should assume that future spec revisions will be backwards
compatible.  Otherwise we're forced to make kernel changes when we
otherwise would not have to.

Bjorn
