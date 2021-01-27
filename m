Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A29305CB9
	for <lists+linux-api@lfdr.de>; Wed, 27 Jan 2021 14:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhA0NOF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 27 Jan 2021 08:14:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29898 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343757AbhA0NLn (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 27 Jan 2021 08:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611753016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hJ4khNSatKes1oULY24OEMe4Z2NSkL2V3kH7MRO9ztw=;
        b=YLNpLvUYLUBk/bJznw82HUpD9YpDG/45WcJ+7phSn1JqbhD7MnDHccQXTZxr1mOrBBHwK6
        i16QGhqw+fplklguwUfIacFPbBmkGO13h31+u7xBpJv9U9BvETTv3IHi7HUIoR4k8c9bZ0
        BZ2kd8+i+rtLykomPmRE2248wjp92F8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-fAnSPFvWNkicSGUsF0mlFg-1; Wed, 27 Jan 2021 08:10:13 -0500
X-MC-Unique: fAnSPFvWNkicSGUsF0mlFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46281801817;
        Wed, 27 Jan 2021 13:10:10 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 447115D9D5;
        Wed, 27 Jan 2021 13:10:02 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id C2807416D87F; Wed, 27 Jan 2021 10:09:25 -0300 (-03)
Date:   Wed, 27 Jan 2021 10:09:25 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, juri.lelli@redhat.com, abelits@marvell.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com, jinyuqi@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [Patch v4 1/3] lib: Restrict cpumask_local_spread to houskeeping
 CPUs
Message-ID: <20210127130925.GA64740@fuller.cnet>
References: <20200625223443.2684-1-nitesh@redhat.com>
 <20200625223443.2684-2-nitesh@redhat.com>
 <3e9ce666-c9cd-391b-52b6-3471fe2be2e6@arm.com>
 <20210127121939.GA54725@fuller.cnet>
 <c5cba5f3-287a-d087-c329-6e6613634370@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5cba5f3-287a-d087-c329-6e6613634370@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jan 27, 2021 at 12:36:30PM +0000, Robin Murphy wrote:
> On 2021-01-27 12:19, Marcelo Tosatti wrote:
> > On Wed, Jan 27, 2021 at 11:57:16AM +0000, Robin Murphy wrote:
> > > Hi,
> > > 
> > > On 2020-06-25 23:34, Nitesh Narayan Lal wrote:
> > > > From: Alex Belits <abelits@marvell.com>
> > > > 
> > > > The current implementation of cpumask_local_spread() does not respect the
> > > > isolated CPUs, i.e., even if a CPU has been isolated for Real-Time task,
> > > > it will return it to the caller for pinning of its IRQ threads. Having
> > > > these unwanted IRQ threads on an isolated CPU adds up to a latency
> > > > overhead.
> > > > 
> > > > Restrict the CPUs that are returned for spreading IRQs only to the
> > > > available housekeeping CPUs.
> > > > 
> > > > Signed-off-by: Alex Belits <abelits@marvell.com>
> > > > Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > > > ---
> > > >    lib/cpumask.c | 16 +++++++++++-----
> > > >    1 file changed, 11 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/lib/cpumask.c b/lib/cpumask.c
> > > > index fb22fb266f93..85da6ab4fbb5 100644
> > > > --- a/lib/cpumask.c
> > > > +++ b/lib/cpumask.c
> > > > @@ -6,6 +6,7 @@
> > > >    #include <linux/export.h>
> > > >    #include <linux/memblock.h>
> > > >    #include <linux/numa.h>
> > > > +#include <linux/sched/isolation.h>
> > > >    /**
> > > >     * cpumask_next - get the next cpu in a cpumask
> > > > @@ -205,22 +206,27 @@ void __init free_bootmem_cpumask_var(cpumask_var_t mask)
> > > >     */
> > > >    unsigned int cpumask_local_spread(unsigned int i, int node)
> > > >    {
> > > > -	int cpu;
> > > > +	int cpu, hk_flags;
> > > > +	const struct cpumask *mask;
> > > > +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_MANAGED_IRQ;
> > > > +	mask = housekeeping_cpumask(hk_flags);
> > > 
> > > AFAICS, this generally resolves to something based on cpu_possible_mask
> > > rather than cpu_online_mask as before, so could now potentially return an
> > > offline CPU. Was that an intentional change?
> > 
> > Robin,
> > 
> > AFAICS online CPUs should be filtered.
> 
> Apologies if I'm being thick, but can you explain how? In the case of
> isolation being disabled or compiled out, housekeeping_cpumask() is
> literally just "return cpu_possible_mask;". If we then iterate over that
> with for_each_cpu() and just return the i'th possible CPU (e.g. in the
> NUMA_NO_NODE case), what guarantees that CPU is actually online?
> 
> Robin.

Nothing, but that was the situation before 1abdfe706a579a702799fce465bceb9fb01d407c
as well.

cpumask_local_spread() should probably be disabling CPU hotplug.

Thomas?

> 
> > > I was just looking at the current code since I had the rare presence of mind
> > > to check if something suitable already existed before I start open-coding
> > > "any online CPU, but local node preferred" logic for handling IRQ affinity
> > > in a driver - cpumask_local_spread() appears to be almost what I want (if a
> > > bit more heavyweight), if only it would actually guarantee an online CPU as
> > > the kerneldoc claims :(
> > > 
> > > Robin.
> > > 
> > > >    	/* Wrap: we always want a cpu. */
> > > > -	i %= num_online_cpus();
> > > > +	i %= cpumask_weight(mask);
> > > >    	if (node == NUMA_NO_NODE) {
> > > > -		for_each_cpu(cpu, cpu_online_mask)
> > > > +		for_each_cpu(cpu, mask) {
> > > >    			if (i-- == 0)
> > > >    				return cpu;
> > > > +		}
> > > >    	} else {
> > > >    		/* NUMA first. */
> > > > -		for_each_cpu_and(cpu, cpumask_of_node(node), cpu_online_mask)
> > > > +		for_each_cpu_and(cpu, cpumask_of_node(node), mask) {
> > > >    			if (i-- == 0)
> > > >    				return cpu;
> > > > +		}
> > > > -		for_each_cpu(cpu, cpu_online_mask) {
> > > > +		for_each_cpu(cpu, mask) {
> > > >    			/* Skip NUMA nodes, done above. */
> > > >    			if (cpumask_test_cpu(cpu, cpumask_of_node(node)))
> > > >    				continue;
> > > > 
> > 

