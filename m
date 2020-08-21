Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D64E24D7C5
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 16:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUO71 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Aug 2020 10:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgHUO70 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 Aug 2020 10:59:26 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 028392078B;
        Fri, 21 Aug 2020 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598021965;
        bh=8SvRGeHN8PjzAryxcSzCn1l5HDCU4NdZCwvWwqwc/TQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jJeL0ZxI40ABQG1jAcEoeCqJLVZEKr7JjT3mzYBSe1PXfwc2hMPToKPC+x1IXZpE0
         /0Wq9hScOhWHwgEX8nX2N63lGlsmcSqwE58SsFRTuI8PdpDXmX/KwtCi29XSXy3bQb
         /VDM1rZFrz07C5BCGCqq3gH0endiZMgsFs/vReF8=
Date:   Fri, 21 Aug 2020 09:59:23 -0500
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
Message-ID: <20200821145923.GA1625248@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821134622.GA1620197@bjorn-Precision-5520>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Aug 21, 2020 at 08:46:22AM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 21, 2020 at 01:59:01PM +0100, Jonathan Cameron wrote:
> > On Fri, 21 Aug 2020 07:13:56 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > 
> > > [+cc Keith, author of 3accf7ae37a9 ("acpi/hmat: Parse and report
> > > heterogeneous memory")]
> > > 
> > > On Fri, Aug 21, 2020 at 09:42:58AM +0100, Jonathan Cameron wrote:
> > > > On Thu, 20 Aug 2020 17:21:29 -0500
> > > > Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >   
> > > > > On Wed, Aug 19, 2020 at 10:51:09PM +0800, Jonathan Cameron wrote:  
> > > > > > In ACPI 6.3, the Memory Proximity Domain Attributes Structure
> > > > > > changed substantially.  One of those changes was that the flag
> > > > > > for "Memory Proximity Domain field is valid" was deprecated.
> > > > > > 
> > > > > > This was because the field "Proximity Domain for the Memory"
> > > > > > became a required field and hence having a validity flag makes
> > > > > > no sense.
> > > > > > 
> > > > > > So the correct logic is to always assume the field is there.
> > > > > > Current code assumes it never is.
> > > > > > 
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > ---
> > > > > >  drivers/acpi/numa/hmat.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > > > > index 2c32cfb72370..07cfe50136e0 100644
> > > > > > --- a/drivers/acpi/numa/hmat.c
> > > > > > +++ b/drivers/acpi/numa/hmat.c
> > > > > > @@ -424,7 +424,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
> > > > > >  		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
> > > > > >  			p->flags, p->processor_PD, p->memory_PD);
> > > > > >  
> > > > > > -	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
> > > > > > +	if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) || hmat_revision == 2) {    
> > > > > 
> > > > > I hope/assume the spec is written in such a way that p->memory_PD is
> > > > > required for any revision > 1?  So maybe this should be:
> > > > > 
> > > > >   if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) ||
> > > > >       hmat_revision > 1) {  
> > > 
> > > I should have said simply:
> > > 
> > >   if (hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID)
> > > 
> > > We shouldn't even test p->flags for ACPI_HMAT_MEMORY_PD_VALID unless
> > > we already know it's revision 1.
> > > 
> > > And unless there was a revision 0 of HMAT, there's no need to look for
> > > hmat_revison > 1.
> > 
> > It needs to stay as an or statement as you had the first time.
> > The field is always valid for hmat_revision > 1, and valid for
> > hmat_revision == 1 with the flag set.  You could express it as
> > 
> > if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID) || (hmat_revision != 1))
> > 
> > but that seems more confusing to me.
> 
> Oh, you're right, sorry!  There are two questions here:
> 
> 1) In what order should we test "p->flags & ACPI_HMAT_MEMORY_PD_VALID"
>    and "hmat_revision == 1"?  ACPI_HMAT_MEMORY_PD_VALID is defined
>    only when "hmat_revision == 1", so I think we should test the
>    revision first.
> 
>    When "hmat_revision == 2", ACPI_HMAT_MEMORY_PD_VALID is reserved,
>    so we shouldn't test it, even if we later check the revision and
>    discard the result of the flag test.  This is a tiny thing,
>    admittedly, but I think it follows the spec more clearly.
> 
> 2) Do we need to test hmat_revision for anything other than 1?  Yes,
>    you're right, see below.
> 
> > > > Good point.  We have existing protections elsewhere against
> > > > hmat_revision being anything other than 1 or 2, so we should aim to
> > > > keep that in only one place.  
> > > 
> > > I think the "Ignoring HMAT: Unknown revision" test in hmat_init(),
> > > added by 3accf7ae37a9 ("acpi/hmat: Parse and report heterogeneous
> > > memory"), is a mistake.
> > > 
> > > And I think hmat_normalize() has a similar mistake in that it tests
> > > explicitly for hmat_revision == 2 when it should accept 2 AND anything
> > > later.
> > > 
> > > We should assume that future spec revisions will be backwards
> > > compatible.  Otherwise we're forced to make kernel changes when we
> > > otherwise would not have to.
> > 
> > I disagree with this. There is no rule in ACPI about maintaining
> > backwards compatibility. The assumption is that the version number
> > will always be checked.  The meaning of fields changed between
> > version 1 and version 2 so it would be bold to assume that won't
> > happen in the future!
> 
> There *is* a rule about maintaining backwards compatibility.  ACPI
> v6.3, sec 5.2.2, says:
> 
>   All versions of the ACPI tables must maintain backward
>   compatibility. To accomplish this, modifications of the tables
>   consist of redefinition of previously reserved fields and values
>   plus appending data to the 1.0 tables. Modifications of the ACPI
>   tables require that the version numbers of the modified tables be
>   incremented.
> 
> > HMAT is an optional table, so if someone boots up an old kernel
> > they are probably better off failing to use it at all than
> > misinterpreting it. 
> 
> An old kernel tests:
> 
>   if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1)
>     target = find_mem_target(p->memory_PD);
> 
> which is fine on old firmware.  On new firmware (hmat_revision == 2),
> it will ignore p->memory_PD.  That is probably a problem, but I think
> we should check for that at the place where we need a memory_PD and
> don't find one.  That's more general than sanity checking a revision.
> 
> A new kernel that tests:
> 
>   if ((hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID) ||
>        hmat_revision > 1)
>     target = find_mem_target(p->memory_PD);
> 
> will do the right thing on both old and new firmware.

Actually, I think this part of the spec was done incorrectly.

ACPI v6.3 could have made the p->memory_PD field required without
changing the definition of ACPI_HMAT_MEMORY_PD_VALID.  What value was
gained by making ACPI_HMAT_MEMORY_PD_VALID a reserved bit in v6.3?

If they had left ACPI_HMAT_MEMORY_PD_VALID alone, the Linux code could
have been simply this, which would work with old firmware and new
firmware, and we wouldn't have to touch this at all:

  if (p->flags & ACPI_HMAT_MEMORY_PD_VALID)
    target = find_mem_target(p->memory_PD);

Bjorn
