Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707AA2785F3
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 13:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIYLeL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 07:34:11 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2919 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgIYLeL (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 25 Sep 2020 07:34:11 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 23D44ACD6EC795CB14F6;
        Fri, 25 Sep 2020 12:34:09 +0100 (IST)
Received: from localhost (10.52.122.107) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 25 Sep
 2020 12:34:08 +0100
Date:   Fri, 25 Sep 2020 12:32:26 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <rafael@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Brice Goglin" <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        <linux-api@vger.kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v10 2/6] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20200925123226.0000636a@Huawei.com>
In-Reply-To: <20200923160609.GO28545@zn.tnic>
References: <20200907140307.571932-1-Jonathan.Cameron@huawei.com>
        <20200907140307.571932-3-Jonathan.Cameron@huawei.com>
        <20200923160609.GO28545@zn.tnic>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.107]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, 23 Sep 2020 18:06:09 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Sep 07, 2020 at 10:03:03PM +0800, Jonathan Cameron wrote:
> > In common with memoryless domains we only register GI domains
> > if the proximity node is not online. If a domain is already
> > a memory containing domain, or a memoryless domain there is
> > nothing to do just because it also contains a Generic Initiator.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi Borislav,

Thanks for taking a look. Answers inline.

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
> 
> Can this function be an early_initcall() or so instead which you can
> call in numa.c directly instead of exporting it and calling it here?

I don't think we can.  This is doing the same operation as
is done for memoryless cpu nodes in the init_cpu_to_node() call above
so it would make little sense from a code flow point of view, even if
it were possible.  However it isn't possible as far as I can see.

It is called after init_cpu_to_node() because...
* A GI node may also be a CPU node and / or a Memory Node, but we only
  have to do anything extra if it has neither of these.
  Easiest way to do that is use the same logic init_cpu_to_node() 
  does and rely on ordering wrt to the other two types of nodes that
  have already been handled.  We could have could just call it at the
  end of init_cpu_to_node() but I'd not be happy doing so without renaming
  that function and then we'd end up with a horrible name like
  init_cpu_to_node_and_gi() as they are rather different things.

It needs to happen before use is made of the node_data which is allocated
in init_gi_nodes() / init_memoryless_node() / alloc_node_data()

I think the first call that uses node_data is build_all_zonelists()
(there might be one hiding earlier but it's definitely needed by this call).

We need the fallback lists to be setup correctly for the GI node, just
as they are for the memoryless node that has CPUs.

So there is a narrow window in which we need to call this. As mentioned
I could just call it from init_cpu_to_node() but that would make the code
harder to understand given it's nothing to do with cpus.

It might be possible to allocate the zonelists for this special case later
in the boot flow, but it seems like we would be adding a lot of complexity
to avoid a single function call.

Just to check my logic, I gave using early_initcall() a go and
it blows up spectacularly when allocations start happening for
Generic Initiators.


> 
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
> 
> Who's "we"? And what is "either of the others"? The other nodes?

"We" is the kernel.  Silly idiom, I'll rephrase.

"Either of the others" refers to CPU or memory as per the line above.
I'll state that explicitly.

How about this?

+/*
+ * A node may exist which has one or more Generic Initiators but no
+ * CPUs and no memory.
+ * When this function is called, any nodes containing either memory
+ * and/or CPUs will already be online and there is no need to do
+ * anything extra, even if they also contain one or more Generic
+ * Initiators.
+ */
>
 
Thanks,

Jonathan


