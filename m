Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D002056D1
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2020 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgFWQMV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jun 2020 12:12:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:31147 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732355AbgFWQMU (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 23 Jun 2020 12:12:20 -0400
IronPort-SDR: BSGu7w4Hki+Roz+Y9ZPFVmOV8OdkY6n784h92uuZDSTE0hIplirFSJIYZgm1+3sUrnUkrf0+ui
 ZP3rGLct0DHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="124376889"
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="124376889"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:12:14 -0700
IronPort-SDR: pbxQ2H2l/idGUoI9AM9BFZiTp8A/KSHbSaFejDDvWdwlCKEsK+aG5bSPsOwjfkktSoZP/IT3Tu
 O8jxzeHtUuyQ==
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="279161974"
Received: from bjscott-mobl3.amr.corp.intel.com (HELO intel.com) ([10.252.131.171])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:12:13 -0700
Date:   Tue, 23 Jun 2020 09:12:11 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 00/18] multiple preferred nodes
Message-ID: <20200623161211.qjup5km5eiisy5wy@intel.com>
Mail-Followup-To: Michal Hocko <mhocko@kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mina Almasry <almasrymina@google.com>, Tejun Heo <tj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-api@vger.kernel.org
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200623112048.GR31426@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 20-06-23 13:20:48, Michal Hocko wrote:
> On Mon 22-06-20 09:10:00, Michal Hocko wrote:
> [...]
> > > The goal of the new mode is to enable some use-cases when using tiered memory
> > > usage models which I've lovingly named.
> > > 1a. The Hare - The interconnect is fast enough to meet bandwidth and latency
> > > requirements allowing preference to be given to all nodes with "fast" memory.
> > > 1b. The Indiscriminate Hare - An application knows it wants fast memory (or
> > > perhaps slow memory), but doesn't care which node it runs on. The application
> > > can prefer a set of nodes and then xpu bind to the local node (cpu, accelerator,
> > > etc). This reverses the nodes are chosen today where the kernel attempts to use
> > > local memory to the CPU whenever possible. This will attempt to use the local
> > > accelerator to the memory.
> > > 2. The Tortoise - The administrator (or the application itself) is aware it only
> > > needs slow memory, and so can prefer that.
> > >
> > > Much of this is almost achievable with the bind interface, but the bind
> > > interface suffers from an inability to fallback to another set of nodes if
> > > binding fails to all nodes in the nodemask.
> 
> Yes, and probably worth mentioning explicitly that this might lead to
> the OOM killer invocation so a failure would be disruptive to any
> workload which is allowed to allocate from the specific node mask (so
> even tasks without any mempolicy).

Thanks. I don't believe I mention this fact in any of the commit messages or
comments (and perhaps this is an indication I should have). I'll find a place to
mention this outside of the cover letter.

> 
> > > Like MPOL_BIND a nodemask is given. Inherently this removes ordering from the
> > > preference.
> > > 
> > > > /* Set first two nodes as preferred in an 8 node system. */
> > > > const unsigned long nodes = 0x3
> > > > set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);
> > > 
> > > > /* Mimic interleave policy, but have fallback *.
> > > > const unsigned long nodes = 0xaa
> > > > set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);
> > > 
> > > Some internal discussion took place around the interface. There are two
> > > alternatives which we have discussed, plus one I stuck in:
> > > 1. Ordered list of nodes. Currently it's believed that the added complexity is
> > >    nod needed for expected usecases.
> 
> There is no ordering in MPOL_BIND either and even though numa apis tend
> to be screwed up from multiple aspects this is not a problem I have ever
> stumbled over.
> 
> > > 2. A flag for bind to allow falling back to other nodes. This confuses the
> > >    notion of binding and is less flexible than the current solution.
> 
> Agreed.
> 
> > > 3. Create flags or new modes that helps with some ordering. This offers both a
> > >    friendlier API as well as a solution for more customized usage. It's unknown
> > >    if it's worth the complexity to support this. Here is sample code for how
> > >    this might work:
> > > 
> > > > // Default
> > > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_SOCKET, NULL, 0);
> > > > // which is the same as
> > > > set_mempolicy(MPOL_DEFAULT, NULL, 0);
> 
> OK
> 
> > > > // The Hare
> > > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, NULL, 0);
> > > >
> > > > // The Tortoise
> > > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_REV, NULL, 0);
> > > >
> > > > // Prefer the fast memory of the first two sockets
> > > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, -1, 2);
> > > >
> > > > // Prefer specific nodes for some something wacky
> > > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_CUSTOM, 0x17c, 1024);
> 
> I am not so sure about these though. It would be much more easier to
> start without additional modifiers and provide MPOL_PREFER_MANY without
> any additional restrictions first (btw. I would like MPOL_PREFER_MASK
> more but I do understand that naming is not the top priority now).

True. In fact, this is the same as making MPOL_F_PREFER_ORDER_TYPE_CUSTOM the
implicit default, and adding the others later. Luckily for me, this is
effectively what I have already :-).

It's a new domain for me, so I'm very flexible on the name. MASK seems like an
altogether better name to me as well, but I've been using "MANY" long enough now
that it seems natural.

> 
> It would be also great to provide a high level semantic description
> here. I have very quickly glanced through patches and they are not
> really trivial to follow with many incremental steps so the higher level
> intention is lost easily.
> 
> Do I get it right that the default semantic is essentially
> 	- allocate page from the given nodemask (with __GFP_RETRY_MAYFAIL
> 	  semantic)
> 	- fallback to numa unrestricted allocation with the default
> 	  numa policy on the failure
> 
> Or are there any usecases to modify how hard to keep the preference over
> the fallback?

tl;dr is: yes, and no usecases.

Longer answer:
Internal APIs (specifically, __alloc_pages_nodemask()) keep all the same
semantics for trying to allocate with the exception that it will first try the
preferred nodes, and next try the bound nodes. It should be noted here that an
empty preferred mask is the same as saying, traverse nodes in distance order
starting from local. Therefore, both for preferred mask, and bound mask the
universe set is equivalent to the empty set (∅ == U). [1]

| prefmask | bindmask | how                                    |
|----------|----------|----------------------------------------|
| ∅        | ∅        | Page allocation without policy         |
| ∅        | N ≠ ∅    | MPOL_BIND                              |
| N ≠ ∅    | ∅        | MPOL_PREFERRED* or internal preference |
| N ≠ ∅    | N ≠ ∅    | MPOL_BIND + internal preference        |
|----------|----------|----------------------------------------|

At the end of this patch series, there is never a case (that I can contrive
anyway) where prefmask is multiple nodes, and bindmask is multiple nodes. In the
future, if internal callers wanted to try to get clever, this could be the case.
The UAPI won't allow having both a bind and preferred node. "This system call
defines the default policy for the thread.  The thread policy governs allocation
of pages in the process's address space outside of memory ranges controlled  by
a more specific policy set by mbind(2)."

To your second question. There isn't any usecase. Sans bugs and oversights,
preferred nodes are always tried before fallback. I consider that almost the
hardest level of preference. The one thing I can think of that would be "harder"
would be some sort of mechanism to try all preferred nodes before any tricks are
used, like reclaim. I fear doing this will make the already scary
get_page_from_freelist() even more scary.

On this topic, I haven't changed anything for fragmentation. In the code right
now, fragmentation is enabled as soon as the zone chosen for allocation doesn't
match the preferred_zoneref->zone.

```
if (no_fallback && nr_online_nodes > 1 &&
		zone != ac->preferred_zoneref->zone) {
```

What might be more optimal is to move on to the next node and not allow
fragmentation yet, unless zone ∉  prefmask. Like the above, I think this will
add a decent amount of complexity.

The last thing, which I mention in a commit message but not here, OOM will scan
all nodes, and not just preferred nodes first. This seemed like a premature
optimization to me.


[1] There is an underlying assumption that the geodesic distance between any two
nodes is the same for all zonelists. IOW, if you have nodes M, N, P each with zones
A, and B the zonelists will be as follows:
M zonelist: MA -> MB -> NA -> NB -> PA -> PB
N zonelist: NA -> NB -> PA -> PB -> MA -> MB
P zonelist: PA -> PB -> MA -> MB -> NA -> NC
