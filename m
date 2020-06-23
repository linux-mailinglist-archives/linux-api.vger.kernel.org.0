Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8F1205092
	for <lists+linux-api@lfdr.de>; Tue, 23 Jun 2020 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbgFWLUx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 23 Jun 2020 07:20:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33245 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732191AbgFWLUw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 23 Jun 2020 07:20:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id l11so20130213wru.0
        for <linux-api@vger.kernel.org>; Tue, 23 Jun 2020 04:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WPzKliK/Iqc/BzeE/hsqDLXWLRpgNNV0+FyZ9cudhEI=;
        b=gTSz8hfn/F955+n+QtvBNaiVkp9v/UWm0U3Pa3rcT+odZZLwuX1VCsLwiUH6ckkowt
         kLtUoZEgjf3cO4g8xyOD8sfUM6GQFfYPrCxA8t3nJ3z9SFK22FPswQr//GUOxtkOpuni
         /JEcuJ/EsRCH3xSWGkJzGqpG4K1D8ALmtl1gRms9yiUDisB0YiNvBszb634QKrAc+fJr
         tZ2tEjJCcQf346yzHETAir5nu9R8BK6rQMOqkAB7i73O/tD8cgl/bz1zdi30O3XNRnjl
         Ni89n4XJDAQtSl/tSsirBr1nOheik48STubq7NB6pc2cVZHO+kXh5V/PC295JnTggigg
         eIyg==
X-Gm-Message-State: AOAM5325PTb4DeMWwV9rKHn9BWZR2grTo2rpSZIN6mCE1U7cIXqQIIPE
        0pWjjXmX4hfYQTFJ+H5dafg=
X-Google-Smtp-Source: ABdhPJzNTVJxi+xWOF1p2Yd5p6rUzvyCIBy3VYDasa+lF1a/EHxfYwPXN1cgUTZqMXguqeki/1osQA==
X-Received: by 2002:a5d:4e48:: with SMTP id r8mr5417176wrt.309.1592911250784;
        Tue, 23 Jun 2020 04:20:50 -0700 (PDT)
Received: from localhost (ip-37-188-173-135.eurotel.cz. [37.188.173.135])
        by smtp.gmail.com with ESMTPSA id e8sm19910232wrv.24.2020.06.23.04.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 04:20:49 -0700 (PDT)
Date:   Tue, 23 Jun 2020 13:20:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Ben Widawsky <ben.widawsky@intel.com>
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
Message-ID: <20200623112048.GR31426@dhcp22.suse.cz>
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622070957.GB31426@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon 22-06-20 09:10:00, Michal Hocko wrote:
[...]
> > The goal of the new mode is to enable some use-cases when using tiered memory
> > usage models which I've lovingly named.
> > 1a. The Hare - The interconnect is fast enough to meet bandwidth and latency
> > requirements allowing preference to be given to all nodes with "fast" memory.
> > 1b. The Indiscriminate Hare - An application knows it wants fast memory (or
> > perhaps slow memory), but doesn't care which node it runs on. The application
> > can prefer a set of nodes and then xpu bind to the local node (cpu, accelerator,
> > etc). This reverses the nodes are chosen today where the kernel attempts to use
> > local memory to the CPU whenever possible. This will attempt to use the local
> > accelerator to the memory.
> > 2. The Tortoise - The administrator (or the application itself) is aware it only
> > needs slow memory, and so can prefer that.
> >
> > Much of this is almost achievable with the bind interface, but the bind
> > interface suffers from an inability to fallback to another set of nodes if
> > binding fails to all nodes in the nodemask.

Yes, and probably worth mentioning explicitly that this might lead to
the OOM killer invocation so a failure would be disruptive to any
workload which is allowed to allocate from the specific node mask (so
even tasks without any mempolicy).

> > Like MPOL_BIND a nodemask is given. Inherently this removes ordering from the
> > preference.
> > 
> > > /* Set first two nodes as preferred in an 8 node system. */
> > > const unsigned long nodes = 0x3
> > > set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);
> > 
> > > /* Mimic interleave policy, but have fallback *.
> > > const unsigned long nodes = 0xaa
> > > set_mempolicy(MPOL_PREFER_MANY, &nodes, 8);
> > 
> > Some internal discussion took place around the interface. There are two
> > alternatives which we have discussed, plus one I stuck in:
> > 1. Ordered list of nodes. Currently it's believed that the added complexity is
> >    nod needed for expected usecases.

There is no ordering in MPOL_BIND either and even though numa apis tend
to be screwed up from multiple aspects this is not a problem I have ever
stumbled over.

> > 2. A flag for bind to allow falling back to other nodes. This confuses the
> >    notion of binding and is less flexible than the current solution.

Agreed.

> > 3. Create flags or new modes that helps with some ordering. This offers both a
> >    friendlier API as well as a solution for more customized usage. It's unknown
> >    if it's worth the complexity to support this. Here is sample code for how
> >    this might work:
> > 
> > > // Default
> > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_SOCKET, NULL, 0);
> > > // which is the same as
> > > set_mempolicy(MPOL_DEFAULT, NULL, 0);

OK

> > > // The Hare
> > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, NULL, 0);
> > >
> > > // The Tortoise
> > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_REV, NULL, 0);
> > >
> > > // Prefer the fast memory of the first two sockets
> > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE, -1, 2);
> > >
> > > // Prefer specific nodes for some something wacky
> > > set_mempolicy(MPOL_PREFER_MANY | MPOL_F_PREFER_ORDER_TYPE_CUSTOM, 0x17c, 1024);

I am not so sure about these though. It would be much more easier to
start without additional modifiers and provide MPOL_PREFER_MANY without
any additional restrictions first (btw. I would like MPOL_PREFER_MASK
more but I do understand that naming is not the top priority now).

It would be also great to provide a high level semantic description
here. I have very quickly glanced through patches and they are not
really trivial to follow with many incremental steps so the higher level
intention is lost easily.

Do I get it right that the default semantic is essentially
	- allocate page from the given nodemask (with __GFP_RETRY_MAYFAIL
	  semantic)
	- fallback to numa unrestricted allocation with the default
	  numa policy on the failure

Or are there any usecases to modify how hard to keep the preference over
the fallback?
-- 
Michal Hocko
SUSE Labs
