Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BE24D0EC
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgHUIzu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Aug 2020 04:55:50 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2681 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726243AbgHUIzu (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 21 Aug 2020 04:55:50 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id E386C4B18AC1B04972AA;
        Fri, 21 Aug 2020 09:55:48 +0100 (IST)
Received: from localhost (10.52.123.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 21 Aug
 2020 09:55:47 +0100
Date:   Fri, 21 Aug 2020 09:54:14 +0100
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
        <linux-api@vger.kernel.org>
Subject: Re: [PATCH v9 2/6] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20200821095414.00004559@Huawei.com>
In-Reply-To: <20200820222433.GA1571517@bjorn-Precision-5520>
References: <20200819145111.1715026-3-Jonathan.Cameron@huawei.com>
        <20200820222433.GA1571517@bjorn-Precision-5520>
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

On Thu, 20 Aug 2020 17:24:33 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Aug 19, 2020 at 10:51:07PM +0800, Jonathan Cameron wrote:
> > In common with memoryless domains we only register GI domains
> > if the proximity node is not online. If a domain is already
> > a memory containing domain, or a memoryless domain there is
> > nothing to do just because it also contains a Generic Initiator.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  arch/x86/include/asm/numa.h |  2 ++
> >  arch/x86/kernel/setup.c     |  1 +
> >  arch/x86/mm/numa.c          | 14 ++++++++++++++
> >  3 files changed, 17 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> > index bbfde3d2662f..f631467272a3 100644
> > --- a/arch/x86/include/asm/numa.h
> > +++ b/arch/x86/include/asm/numa.h
> > @@ -62,12 +62,14 @@ extern void numa_clear_node(int cpu);
> >  extern void __init init_cpu_to_node(void);
> >  extern void numa_add_cpu(int cpu);
> >  extern void numa_remove_cpu(int cpu);
> > +extern void init_gi_nodes(void);
> >  #else	/* CONFIG_NUMA */
> >  static inline void numa_set_node(int cpu, int node)	{ }
> >  static inline void numa_clear_node(int cpu)		{ }
> >  static inline void init_cpu_to_node(void)		{ }
> >  static inline void numa_add_cpu(int cpu)		{ }
> >  static inline void numa_remove_cpu(int cpu)		{ }
> > +static inline void init_gi_nodes(void)			{ }
> >  #endif	/* CONFIG_NUMA */
> >  
> >  #ifdef CONFIG_DEBUG_PER_CPU_MAPS
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3511736fbc74..9062c146f03a 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1218,6 +1218,7 @@ void __init setup_arch(char **cmdline_p)
> >  	prefill_possible_map();
> >  
> >  	init_cpu_to_node();
> > +	init_gi_nodes();
> >  
> >  	io_apic_init_mappings();
> >  
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index aa76ec2d359b..fc630dc6764e 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -747,6 +747,20 @@ static void __init init_memory_less_node(int nid)
> >  	 */
> >  }
> >  
> > +/*
> > + * Generic Initiator Nodes may have neither CPU nor Memory.
> > + * At this stage if either of the others were present we would
> > + * already be online.
> > + */
> > +void __init init_gi_nodes(void)
> > +{
> > +	int nid;
> > +
> > +	for_each_node_state(nid, N_GENERIC_INITIATOR)
> > +		if (!node_online(nid))
> > +			init_memory_less_node(nid);
> > +}  
> 
> This doesn't *look* very x86-specific, and apparently you don't need
> any arm64-specific changes?  Too bad this can't be unified a little
> bit to remove the arch #ifdefs completely.

The only ifdefs in the set aren't actually about this (which is entirely
contained in arch code) they are to avoid ia64 issues as has an entirely
different implementation that I doubt anyone wants to touch!

> 
> I do see that init_memory_less_node() is only implemented on x86, but
> it just seems like all this might not be inherently be arch-specific.

I absolutely agree with a long term aim to unify the numa setup code
across architectures.

The x86 code is rather more involved than what we have for arm64. On arm64,
memoryless nodes are handled in the same pass as those with memory (and
we get GI nodes for free).

There are some separate patches under discussion that take a few steps
in that direction.

https://lore.kernel.org/linux-arm-kernel/20200814214725.28818-3-atish.patra@wdc.com/T/
https://patchwork.kernel.org/patch/11651437/ (this one is mostly by coincidence rather
than intent!)

Jonathan




