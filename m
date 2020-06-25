Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D27F2099DA
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2020 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbgFYG2f (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 25 Jun 2020 02:28:35 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:37251 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgFYG2f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 25 Jun 2020 02:28:35 -0400
Received: by mail-ej1-f66.google.com with SMTP id mb16so4792539ejb.4
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 23:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IZxXz9KByq6hibP/lbhu1aFBYmRX2QrnJLs+2zSgJz0=;
        b=FEqQ30v3NrRzKdUNwGBdr/UCVgE8sRipnlHtIsiTHXYn13BACWTgaPR5Ttfduk639f
         11KCBvBi97Ojn0jrFw7yz4IKPHCIOSQtAXkRy1xUR152wD3JcGNpQxrJgq2xuG8rOCnX
         2WX3fDzXft7ezqg5MsMpb62hR09waNj9YwXFT9v6TCoYTjAIsrDK63j/flhwZpOzUphf
         v+yt9spGYtvFzSYHt2JdHo9gCjf/UcNBSa0dKSkjVaVozmnZFl4qEgMWj2VPVC/gx2/O
         kJjqbWhsQYHHy6r+D3aP6prUM9aeFhpY+RcIHIFbAKRxLVYzrXBIfEPccKdfkfOWXN/V
         StiA==
X-Gm-Message-State: AOAM533O4CAH/U1ZJCq3ghDXa/zyNGRAXXAaIB4cCqPOfM6FXeS4t1XV
        HKSDiEhpARqLG7Vkqff+sS4=
X-Google-Smtp-Source: ABdhPJxk1Bk247vqEFFVV1m7vyabawPQ99efDuds9l9gBdxnvVfUu45BgKrTQEkkN8a6fEkmvAAArA==
X-Received: by 2002:a17:906:488b:: with SMTP id v11mr19650243ejq.173.1593066512104;
        Wed, 24 Jun 2020 23:28:32 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id m13sm6736266ejc.1.2020.06.24.23.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:28:28 -0700 (PDT)
Date:   Thu, 25 Jun 2020 08:28:27 +0200
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
Message-ID: <20200625062827.GB1320@dhcp22.suse.cz>
References: <20200624075216.GC1320@dhcp22.suse.cz>
 <20200624161643.75fkkvsxlmp3bf2e@intel.com>
 <20200624183917.GW1320@dhcp22.suse.cz>
 <20200624193733.tqeligjd3pdvrsmi@intel.com>
 <20200624195158.GX1320@dhcp22.suse.cz>
 <20200624200140.dypw6snshshzlbwa@intel.com>
 <20200624200750.GY1320@dhcp22.suse.cz>
 <20200624202344.woogq4n3bqkuejty@intel.com>
 <20200624204232.GZ1320@dhcp22.suse.cz>
 <20200624205518.tzcvjayntez4ueqw@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624205518.tzcvjayntez4ueqw@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 24-06-20 13:55:18, Ben Widawsky wrote:
> On 20-06-24 22:42:32, Michal Hocko wrote:
> > On Wed 24-06-20 13:23:44, Ben Widawsky wrote:
> > > On 20-06-24 22:07:50, Michal Hocko wrote:
> > > > On Wed 24-06-20 13:01:40, Ben Widawsky wrote:
> > > > > On 20-06-24 21:51:58, Michal Hocko wrote:
> > > > > > On Wed 24-06-20 12:37:33, Ben Widawsky wrote:
> > > > > > > On 20-06-24 20:39:17, Michal Hocko wrote:
> > > > > > > > On Wed 24-06-20 09:16:43, Ben Widawsky wrote:
> > > > [...]
> > > > > > > > > > Or do I miss something that really requires more involved approach like
> > > > > > > > > > building custom zonelists and other larger changes to the allocator?
> > > > > > > > > 
> > > > > > > > > I think I'm missing how this allows selecting from multiple preferred nodes. In
> > > > > > > > > this case when you try to get the page from the freelist, you'll get the
> > > > > > > > > zonelist of the preferred node, and when you actually scan through on page
> > > > > > > > > allocation, you have no way to filter out the non-preferred nodes. I think the
> > > > > > > > > plumbing of multiple nodes has to go all the way through
> > > > > > > > > __alloc_pages_nodemask(). But it's possible I've missed the point.
> > > > > > > > 
> > > > > > > > policy_nodemask() will provide the nodemask which will be used as a
> > > > > > > > filter on the policy_node.
> > > > > > > 
> > > > > > > Ah, gotcha. Enabling independent masks seemed useful. Some bad decisions got me
> > > > > > > to that point. UAPI cannot get independent masks, and callers of these functions
> > > > > > > don't yet use them.
> > > > > > > 
> > > > > > > So let me ask before I actually type it up and find it's much much simpler, is
> > > > > > > there not some perceived benefit to having both masks being independent?
> > > > > > 
> > > > > > I am not sure I follow. Which two masks do you have in mind? zonelist
> > > > > > and user provided nodemask?
> > > > > 
> > > > > Internally, a nodemask_t for preferred node, and a nodemask_t for bound nodes.
> > > > 
> > > > Each mask is a local to its policy object.
> > > 
> > > I mean for __alloc_pages_nodemask as an internal API. That is irrespective of
> > > policy. Policy decisions are all made beforehand. The question from a few mails
> > > ago was whether there is any use in keeping that change to
> > > __alloc_pages_nodemask accepting two nodemasks.
> > 
> > It is probably too late for me because I am still not following you
> > mean. Maybe it would be better to provide a pseudo code what you have in
> > mind. Anyway all that I am saying is that for the functionality that you
> > propose and _if_ the fallback strategy is fixed then all you should need
> > is to use the preferred nodemask for the __alloc_pages_nodemask and a
> > fallback allocation to the full (NULL nodemask). So you first try what
> > the userspace prefers - __GFP_RETRY_MAYFAIL will give you try hard but
> > do not OOM if the memory is depleted semantic and the fallback
> > allocation goes all the way to OOM on the complete memory depletion.
> > So I do not see much point in a custom zonelist for the policy. Maybe as
> > a micro-optimization to save some branches here and there.
> > 
> > If you envision usecases which might want to control the fallback
> > allocation strategy then this would get more complex because you
> > would need a sorted list of zones to try but this would really require
> > some solid usecase and it should build on top of a trivial
> > implementation which really is BIND with the fallback.
> > 
> 
> I will implement what you suggest. I think it's a good suggestion. Here is what
> I mean though:
> -struct page *
> -__alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> -                                                       nodemask_t *nodemask);
> +struct page *
> +__alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, nodemask_t *prefmask,
> +		       nodemask_t *nodemask);
> 
> Is there any value in keeping two nodemasks as part of the interface?

I do not see any advantage. The first thing you would have to do is
either intersect the two or special case the code to use one over
another and then you would need a clear criterion on how to do that.

-- 
Michal Hocko
SUSE Labs
