Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819CB24C7BE
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 00:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHTWYh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Aug 2020 18:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgHTWYg (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 20 Aug 2020 18:24:36 -0400
Received: from localhost (104.sub-72-107-126.myvzw.com [72.107.126.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3233A2087D;
        Thu, 20 Aug 2020 22:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597962275;
        bh=EzkGTo7PwVoBMRVxTVmD/ln0ndYMvqUfYa99G7EdZrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eUI2xM5SYs5TOUjrABWD24q3qjsn1Z30MLU4mm5N+ZC+qbbocobQE2Dcl6rsjc/KE
         mMc95BUGA7Eh5g8nUomJh2XAUbuqWwCbgx9nHq1KgS4wu6PqyC/kbHfaHCevgLMf2B
         FCXP45ZKQS/nj7xCn3Vq7R5bxmxqlkpUsek+HeXs=
Date:   Thu, 20 Aug 2020 17:24:33 -0500
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
Subject: Re: [PATCH v9 2/6] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20200820222433.GA1571517@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819145111.1715026-3-Jonathan.Cameron@huawei.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 19, 2020 at 10:51:07PM +0800, Jonathan Cameron wrote:
> In common with memoryless domains we only register GI domains
> if the proximity node is not online. If a domain is already
> a memory containing domain, or a memoryless domain there is
> nothing to do just because it also contains a Generic Initiator.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  arch/x86/include/asm/numa.h |  2 ++
>  arch/x86/kernel/setup.c     |  1 +
>  arch/x86/mm/numa.c          | 14 ++++++++++++++
>  3 files changed, 17 insertions(+)
> 
> diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
> index bbfde3d2662f..f631467272a3 100644
> --- a/arch/x86/include/asm/numa.h
> +++ b/arch/x86/include/asm/numa.h
> @@ -62,12 +62,14 @@ extern void numa_clear_node(int cpu);
>  extern void __init init_cpu_to_node(void);
>  extern void numa_add_cpu(int cpu);
>  extern void numa_remove_cpu(int cpu);
> +extern void init_gi_nodes(void);
>  #else	/* CONFIG_NUMA */
>  static inline void numa_set_node(int cpu, int node)	{ }
>  static inline void numa_clear_node(int cpu)		{ }
>  static inline void init_cpu_to_node(void)		{ }
>  static inline void numa_add_cpu(int cpu)		{ }
>  static inline void numa_remove_cpu(int cpu)		{ }
> +static inline void init_gi_nodes(void)			{ }
>  #endif	/* CONFIG_NUMA */
>  
>  #ifdef CONFIG_DEBUG_PER_CPU_MAPS
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 3511736fbc74..9062c146f03a 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1218,6 +1218,7 @@ void __init setup_arch(char **cmdline_p)
>  	prefill_possible_map();
>  
>  	init_cpu_to_node();
> +	init_gi_nodes();
>  
>  	io_apic_init_mappings();
>  
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index aa76ec2d359b..fc630dc6764e 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -747,6 +747,20 @@ static void __init init_memory_less_node(int nid)
>  	 */
>  }
>  
> +/*
> + * Generic Initiator Nodes may have neither CPU nor Memory.
> + * At this stage if either of the others were present we would
> + * already be online.
> + */
> +void __init init_gi_nodes(void)
> +{
> +	int nid;
> +
> +	for_each_node_state(nid, N_GENERIC_INITIATOR)
> +		if (!node_online(nid))
> +			init_memory_less_node(nid);
> +}

This doesn't *look* very x86-specific, and apparently you don't need
any arm64-specific changes?  Too bad this can't be unified a little
bit to remove the arch #ifdefs completely.

I do see that init_memory_less_node() is only implemented on x86, but
it just seems like all this might not be inherently be arch-specific.
