Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E5D207CDA
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406367AbgFXUXs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 16:23:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:17376 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406312AbgFXUXs (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 24 Jun 2020 16:23:48 -0400
IronPort-SDR: xEdMIIrwC5x8cEbbWk3R6QSlxAJ76miYj4DiD3DbXcZuP4zIqHwjfLljz3+ZvWf6QwQAQ+w3pl
 Uy6heti5tHxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="142846884"
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="142846884"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 13:23:48 -0700
IronPort-SDR: fxWtqumXe6sD00YWjgTbHbnDEr/zuILUeu2cIlNh2F1rPHyjNJrBCMGnDQdDpOLSxP+BDP66NV
 HwNwAvpUaSWA==
X-IronPort-AV: E=Sophos;i="5.75,276,1589266800"; 
   d="scan'208";a="319555868"
Received: from schapar-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.143.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 13:23:46 -0700
Date:   Wed, 24 Jun 2020 13:23:44 -0700
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
Message-ID: <20200624202344.woogq4n3bqkuejty@intel.com>
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
References: <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
 <20200623161211.qjup5km5eiisy5wy@intel.com>
 <20200624075216.GC1320@dhcp22.suse.cz>
 <20200624161643.75fkkvsxlmp3bf2e@intel.com>
 <20200624183917.GW1320@dhcp22.suse.cz>
 <20200624193733.tqeligjd3pdvrsmi@intel.com>
 <20200624195158.GX1320@dhcp22.suse.cz>
 <20200624200140.dypw6snshshzlbwa@intel.com>
 <20200624200750.GY1320@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624200750.GY1320@dhcp22.suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 20-06-24 22:07:50, Michal Hocko wrote:
> On Wed 24-06-20 13:01:40, Ben Widawsky wrote:
> > On 20-06-24 21:51:58, Michal Hocko wrote:
> > > On Wed 24-06-20 12:37:33, Ben Widawsky wrote:
> > > > On 20-06-24 20:39:17, Michal Hocko wrote:
> > > > > On Wed 24-06-20 09:16:43, Ben Widawsky wrote:
> [...]
> > > > > > > Or do I miss something that really requires more involved approach like
> > > > > > > building custom zonelists and other larger changes to the allocator?
> > > > > > 
> > > > > > I think I'm missing how this allows selecting from multiple preferred nodes. In
> > > > > > this case when you try to get the page from the freelist, you'll get the
> > > > > > zonelist of the preferred node, and when you actually scan through on page
> > > > > > allocation, you have no way to filter out the non-preferred nodes. I think the
> > > > > > plumbing of multiple nodes has to go all the way through
> > > > > > __alloc_pages_nodemask(). But it's possible I've missed the point.
> > > > > 
> > > > > policy_nodemask() will provide the nodemask which will be used as a
> > > > > filter on the policy_node.
> > > > 
> > > > Ah, gotcha. Enabling independent masks seemed useful. Some bad decisions got me
> > > > to that point. UAPI cannot get independent masks, and callers of these functions
> > > > don't yet use them.
> > > > 
> > > > So let me ask before I actually type it up and find it's much much simpler, is
> > > > there not some perceived benefit to having both masks being independent?
> > > 
> > > I am not sure I follow. Which two masks do you have in mind? zonelist
> > > and user provided nodemask?
> > 
> > Internally, a nodemask_t for preferred node, and a nodemask_t for bound nodes.
> 
> Each mask is a local to its policy object.

I mean for __alloc_pages_nodemask as an internal API. That is irrespective of
policy. Policy decisions are all made beforehand. The question from a few mails
ago was whether there is any use in keeping that change to
__alloc_pages_nodemask accepting two nodemasks.
