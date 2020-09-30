Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1363C27EDE0
	for <lists+linux-api@lfdr.de>; Wed, 30 Sep 2020 17:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgI3Pv1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 30 Sep 2020 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3Pv1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 30 Sep 2020 11:51:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E229AC061755;
        Wed, 30 Sep 2020 08:51:26 -0700 (PDT)
Received: from zn.tnic (p200300ec2f092a00869c7b979af15d7f.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:2a00:869c:7b97:9af1:5d7f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D0A51EC0445;
        Wed, 30 Sep 2020 17:51:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601481085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8IJoGZzJObE8St80wY9DzpuhEry0/MVi9UTMplvJAkw=;
        b=kqAUx6o7xOwJppyJb436b4BKze4HaXlnbrBvfP+p8MkQuBxpAJgK0tLtFv4ID9uzNGq/rn
        tFKrxS+5Iolj5OQ4DpC/m8nov+97uyE1wm5am27Ys0D8CBBf0WaRfFtDC5kmhldJlVYq08
        8TvGSl+NZXGtXjRwSx+u33PGNixHZrU=
Date:   Wed, 30 Sep 2020 17:51:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        rafael@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linuxarm@huawei.com, Dan Williams <dan.j.williams@intel.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Sean V Kelley <sean.v.kelley@linux.intel.com>,
        linux-api@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH v12 2/6] x86: Support Generic Initiator only proximity
 domains
Message-ID: <20200930155118.GG6810@zn.tnic>
References: <20200930140547.840251-1-Jonathan.Cameron@huawei.com>
 <20200930140547.840251-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930140547.840251-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 30, 2020 at 10:05:43PM +0800, Jonathan Cameron wrote:
> In common with memoryless domains only register GI domains
> if the proximity node is not online. If a domain is already
> a memory containing domain, or a memoryless domain there is
> nothing to do just because it also contains a Generic Initiator.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v12: Update comment to adopt passive voice.
> 
>  arch/x86/include/asm/numa.h |  2 ++
>  arch/x86/kernel/setup.c     |  1 +
>  arch/x86/mm/numa.c          | 21 +++++++++++++++++++++
>  3 files changed, 24 insertions(+)
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
> index aa76ec2d359b..22d3e5ade3ae 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -747,6 +747,27 @@ static void __init init_memory_less_node(int nid)
>  	 */
>  }
>  
> +/*
> + * A node may exist which has one or more Generic Initiators but no CPUs and no
> + * memory.
> + *
> + * This function must be called after init_cpu_to_node(), to ensure that any
> + * memoryless CPU nodes have already been brought online, and before the
> + * node_data[nid] is needed for zone list setup in build_all_zonelists().
> + *
> + * When this function is called, any nodes containing either memory and/or CPUs
> + * will already be online and there is no need to do anything extra, even if
> + * they also contain one or more Generic Initiators.
> + */
> +void __init init_gi_nodes(void)
> +{
> +	int nid;
> +
> +	for_each_node_state(nid, N_GENERIC_INITIATOR)
> +		if (!node_online(nid))
> +			init_memory_less_node(nid);
> +}
> +
>  /*
>   * Setup early cpu_to_node.
>   *
> -- 

Looks perfect, thanks! :-)

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
