Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A3324D59F
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgHUNAj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Aug 2020 09:00:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727123AbgHUNAg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 Aug 2020 09:00:36 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id EE9029E83CF50866E9B6;
        Fri, 21 Aug 2020 14:00:33 +0100 (IST)
Received: from localhost (10.52.123.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 21 Aug
 2020 14:00:33 +0100
Date:   Fri, 21 Aug 2020 13:59:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Brice Goglin" <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        <linux-api@vger.kernel.org>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v9 4/6] ACPI: HMAT: Fix handling of changes from ACPI
 6.2 to ACPI 6.3
Message-ID: <20200821135901.0000260b@Huawei.com>
In-Reply-To: <20200821121356.GA1616281@bjorn-Precision-5520>
References: <20200821094258.00007925@Huawei.com>
        <20200821121356.GA1616281@bjorn-Precision-5520>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.86]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 21 Aug 2020 07:13:56 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> [+cc Keith, author of 3accf7ae37a9 ("acpi/hmat: Parse and report
> heterogeneous memory")]
> 
> On Fri, Aug 21, 2020 at 09:42:58AM +0100, Jonathan Cameron wrote:
> > On Thu, 20 Aug 2020 17:21:29 -0500
> > Bjorn Helgaas <helgaas@kernel.org> wrote:
> >   
> > > On Wed, Aug 19, 2020 at 10:51:09PM +0800, Jonathan Cameron wrote:  
> > > > In ACPI 6.3, the Memory Proximity Domain Attributes Structure
> > > > changed substantially.  One of those changes was that the flag
> > > > for "Memory Proximity Domain field is valid" was deprecated.
> > > > 
> > > > This was because the field "Proximity Domain for the Memory"
> > > > became a required field and hence having a validity flag makes
> > > > no sense.
> > > > 
> > > > So the correct logic is to always assume the field is there.
> > > > Current code assumes it never is.
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >  drivers/acpi/numa/hmat.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > > index 2c32cfb72370..07cfe50136e0 100644
> > > > --- a/drivers/acpi/numa/hmat.c
> > > > +++ b/drivers/acpi/numa/hmat.c
> > > > @@ -424,7 +424,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
> > > >  		pr_info("HMAT: Memory Flags:%04x Processor Domain:%u Memory Domain:%u\n",
> > > >  			p->flags, p->processor_PD, p->memory_PD);
> > > >  
> > > > -	if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
> > > > +	if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) || hmat_revision == 2) {    
> > > 
> > > I hope/assume the spec is written in such a way that p->memory_PD is
> > > required for any revision > 1?  So maybe this should be:
> > > 
> > >   if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) ||
> > >       hmat_revision > 1) {  
> 
> I should have said simply:
> 
>   if (hmat_revision == 1 && p->flags & ACPI_HMAT_MEMORY_PD_VALID)
> 
> We shouldn't even test p->flags for ACPI_HMAT_MEMORY_PD_VALID unless
> we already know it's revision 1.
> 
> And unless there was a revision 0 of HMAT, there's no need to look for
> hmat_revison > 1.

It needs to stay as an or statement as you had the first time.
The field is always valid for hmat_revision > 1, and valid for
hmat_revision == 1 with the flag set.  You could express it as

if ((p->flags & ACPI_HMAT_MEMORY_PD_VALID) || (hmat_revision != 1))

but that seems more confusing to me.

> 
> > Good point.  We have existing protections elsewhere against
> > hmat_revision being anything other than 1 or 2, so we should aim to
> > keep that in only one place.  
> 
> I think the "Ignoring HMAT: Unknown revision" test in hmat_init(),
> added by 3accf7ae37a9 ("acpi/hmat: Parse and report heterogeneous
> memory"), is a mistake.
> 
> And I think hmat_normalize() has a similar mistake in that it tests
> explicitly for hmat_revision == 2 when it should accept 2 AND anything
> later.
> 
> We should assume that future spec revisions will be backwards
> compatible.  Otherwise we're forced to make kernel changes when we
> otherwise would not have to.

I disagree with this. There is no rule in ACPI about maintaining
backwards compatibility. The assumption is that the version number
will always be checked.  The meaning of fields changed between
version 1 and version 2 so it would be bold to assume that won't
happen in the future!

HMAT is an optional table, so if someone boots up an old kernel
they are probably better off failing to use it at all than
misinterpreting it. 

Having the sanity check in one place makes sense, but removing it
entirely is a bad idea.

Jonathan


> 
> Bjorn


