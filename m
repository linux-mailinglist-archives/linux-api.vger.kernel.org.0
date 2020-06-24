Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34598207CA2
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 22:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406251AbgFXUHz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 16:07:55 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35763 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406231AbgFXUHy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 16:07:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so2225409wmf.0
        for <linux-api@vger.kernel.org>; Wed, 24 Jun 2020 13:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zn5H85cQV046jV3P3ggqci4wKXa88ITUcHIq4Namnmw=;
        b=INDAgpvHlTF2OUixKx1tkjcxAPqN+Q9DbbhnYy7jiJKxdXCw/zISaR7UHgZsXIRlLW
         J5jczCJa5DWd8w+gERJYLxSIur3zh+Z9mNWGgeM0zYW4ZCfarhiGHXSVwFgYMkdQxcH7
         Nt3uYgZjvIaUn52TLm0hLkxC5wMn2Wq0Xf5HQK1juU+EOWuC5uuFrBa4GoM/Gaqcb0P9
         4I43nw5YvT65yuIHKu0h9JCvAKv780MdyYzXDP5elrCdEsCZlv8vOiPOC55O2Dpz0C+G
         uenAbmtpr9SsjlqffcGQGzYd7p4GsoBggPZd6U/8C111I6BKoWQaB7BPj6gYR1hkYyDV
         SAfg==
X-Gm-Message-State: AOAM531XqAxsZcOQx2yceV/WQpJzs7r4UmavbDykPz2pNW82AaKQ4ZwJ
        PuU0Lyk/gK87aBajtiBzlPE=
X-Google-Smtp-Source: ABdhPJwr1VPpzP8Gp/Rb+eJdNGBMXtHkdfBgz9FKMHSGQEcD4Z8LF6StyZfKxXHDBxgVQmEFARxA9Q==
X-Received: by 2002:a1c:9613:: with SMTP id y19mr30634312wmd.135.1593029272410;
        Wed, 24 Jun 2020 13:07:52 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id f16sm9565775wmh.27.2020.06.24.13.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:07:51 -0700 (PDT)
Date:   Wed, 24 Jun 2020 22:07:50 +0200
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
Message-ID: <20200624200750.GY1320@dhcp22.suse.cz>
References: <20200619162425.1052382-1-ben.widawsky@intel.com>
 <20200622070957.GB31426@dhcp22.suse.cz>
 <20200623112048.GR31426@dhcp22.suse.cz>
 <20200623161211.qjup5km5eiisy5wy@intel.com>
 <20200624075216.GC1320@dhcp22.suse.cz>
 <20200624161643.75fkkvsxlmp3bf2e@intel.com>
 <20200624183917.GW1320@dhcp22.suse.cz>
 <20200624193733.tqeligjd3pdvrsmi@intel.com>
 <20200624195158.GX1320@dhcp22.suse.cz>
 <20200624200140.dypw6snshshzlbwa@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624200140.dypw6snshshzlbwa@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed 24-06-20 13:01:40, Ben Widawsky wrote:
> On 20-06-24 21:51:58, Michal Hocko wrote:
> > On Wed 24-06-20 12:37:33, Ben Widawsky wrote:
> > > On 20-06-24 20:39:17, Michal Hocko wrote:
> > > > On Wed 24-06-20 09:16:43, Ben Widawsky wrote:
[...]
> > > > > > Or do I miss something that really requires more involved approach like
> > > > > > building custom zonelists and other larger changes to the allocator?
> > > > > 
> > > > > I think I'm missing how this allows selecting from multiple preferred nodes. In
> > > > > this case when you try to get the page from the freelist, you'll get the
> > > > > zonelist of the preferred node, and when you actually scan through on page
> > > > > allocation, you have no way to filter out the non-preferred nodes. I think the
> > > > > plumbing of multiple nodes has to go all the way through
> > > > > __alloc_pages_nodemask(). But it's possible I've missed the point.
> > > > 
> > > > policy_nodemask() will provide the nodemask which will be used as a
> > > > filter on the policy_node.
> > > 
> > > Ah, gotcha. Enabling independent masks seemed useful. Some bad decisions got me
> > > to that point. UAPI cannot get independent masks, and callers of these functions
> > > don't yet use them.
> > > 
> > > So let me ask before I actually type it up and find it's much much simpler, is
> > > there not some perceived benefit to having both masks being independent?
> > 
> > I am not sure I follow. Which two masks do you have in mind? zonelist
> > and user provided nodemask?
> 
> Internally, a nodemask_t for preferred node, and a nodemask_t for bound nodes.

Each mask is a local to its policy object.
-- 
Michal Hocko
SUSE Labs
