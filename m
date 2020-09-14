Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A1E2689E7
	for <lists+linux-api@lfdr.de>; Mon, 14 Sep 2020 13:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbgINLYl (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Sep 2020 07:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:41734 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgINLYd (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 14 Sep 2020 07:24:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90E4DAE51;
        Mon, 14 Sep 2020 11:24:37 +0000 (UTC)
Date:   Mon, 14 Sep 2020 13:24:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-api@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Ways to deprecate /sys/devices/system/memory/memoryX/phys_device
 ?
Message-ID: <20200914112421.GK16999@dhcp22.suse.cz>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
 <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
 <20200911072035.GC7986@dhcp22.suse.cz>
 <02cdbf90-b29f-a9ec-c83d-49f2548e3e91@redhat.com>
 <20200911091252.GD7986@dhcp22.suse.cz>
 <0f532ff3-972b-bd91-30fe-1c3111d920bf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f532ff3-972b-bd91-30fe-1c3111d920bf@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 11-09-20 12:09:52, David Hildenbrand wrote:
> On 11.09.20 11:12, Michal Hocko wrote:
> > On Fri 11-09-20 10:09:07, David Hildenbrand wrote:
> > [...]
> >> Consider two cases:
> >>
> >> 1. Hot(un)plugging huge DIMMs: many (not all!) use cases want to
> >> online/offline the whole thing. HW can effectively only plug/unplug the
> >> whole thing. It makes sense in some (most?) setups to represent one DIMM
> >> as one memory block device.
> > 
> > Yes, for the physical hotplug it doesn't really make much sense to me to
> > offline portions that the HW cannot hotremove.
> 
> I've seen people offline parts of memory to simulate systems with less
> RAM and people offline parts of memory on demand to save energy
> (poweroff banks). People won't stop being creative with what we provided
> to them :D

Heh, I have seen people shooting their foot for fun. But more seriously,
I do undestand different usecases and we shouldn't cut them off their
toys.

> >> 2. Hot(un)plugging small memory increments. This is mostly the case in
> >> virtualized environments - especially hyper-v balloon, xen balloon,
> >> virtio-mem and (drumroll) ppc dlpar and s390x standby memory. On PPC,
> >> you want at least all (16MB!) memory block devices that can get
> >> unplugged again individually ("LMBs") as separate memory blocks. Same on
> >> s390x on memory increment size (currently effectively the memory block
> >> size).
> > 
> > Yes I do recognize those usecase even though I will not pretend I
> > consider it quesitonable. E.g. any hotplug with a smaller granularity
> > than the memory model in Linus allows is just dubious. We simply cannot
> > implement that without a lot of wasting and then the question is what is
> > the real point.
> 
> Having the section size as small as possible in these environments is
> most certainly preferable, to clean up metadata where possible.

There is a certain line that is hard to maintain. I consider a section
to be the smallest granularity that makes sense to support. Current
section sizing makes sense from the VMEMMAP point of view. If there are
strong reasons to allow smaller once then I belive this should be
compile time option.

> Otherwise, hot(un)plugging smaller granularity behaves more like memory
> ballooning (and I think I don't have to tell you that ballooning is used
> excessively even though it wastes memory on metadata ;) ). Anyhow,
> that's another discussion.

Yeah, I am aware of that. And honestly subsection offlining makes very
little sense to me. It was hard to argue against that for nvdimm
usecases where we simply had to workaround the reality where devices
couldn't have been aligned properly. I do not think we want to claim a
support for general hotplug though. 

[...]

> > There is only one certainty. Providing a long term interface with ever
> > growing (ab)users is a hard target. And shinyN might be needed in the
> > end. Who knows. My main point is that the existing interface is hitting
> > a wall on usecases which _do_not_care_ about memory hotplug. And that is
> > something we should be looking at.
> 
> Agreed. I can see 3 scenarios
> 
> a) no memory hotplug support, no sysfs.
> b) memory hotplug support, no sysfs
> c) memory hotplug support, sysfs
> 
> Starting with a) and c) is the easiest way to go.

Yes, the first and the simplest way would be to provide
memory_hotplug=[disabled|v1]

where disabled would be no sysfs interface, v1 would be the existing
infrastructure. I would hope to land with v2 in a future which would
provide a new interface.

-- 
Michal Hocko
SUSE Labs
