Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D97265C3D
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 11:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725785AbgIKJM5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 05:12:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39940 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKJMz (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Sep 2020 05:12:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85D8DABEA;
        Fri, 11 Sep 2020 09:13:08 +0000 (UTC)
Date:   Fri, 11 Sep 2020 11:12:52 +0200
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
Message-ID: <20200911091252.GD7986@dhcp22.suse.cz>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
 <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
 <20200911072035.GC7986@dhcp22.suse.cz>
 <02cdbf90-b29f-a9ec-c83d-49f2548e3e91@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02cdbf90-b29f-a9ec-c83d-49f2548e3e91@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 11-09-20 10:09:07, David Hildenbrand wrote:
[...]
> Consider two cases:
> 
> 1. Hot(un)plugging huge DIMMs: many (not all!) use cases want to
> online/offline the whole thing. HW can effectively only plug/unplug the
> whole thing. It makes sense in some (most?) setups to represent one DIMM
> as one memory block device.

Yes, for the physical hotplug it doesn't really make much sense to me to
offline portions that the HW cannot hotremove.

> 2. Hot(un)plugging small memory increments. This is mostly the case in
> virtualized environments - especially hyper-v balloon, xen balloon,
> virtio-mem and (drumroll) ppc dlpar and s390x standby memory. On PPC,
> you want at least all (16MB!) memory block devices that can get
> unplugged again individually ("LMBs") as separate memory blocks. Same on
> s390x on memory increment size (currently effectively the memory block
> size).

Yes I do recognize those usecase even though I will not pretend I
consider it quesitonable. E.g. any hotplug with a smaller granularity
than the memory model in Linus allows is just dubious. We simply cannot
implement that without a lot of wasting and then the question is what is
the real point.

> In summary, larger memory block devices mostly only make sense with
> DIMMs (and for boot memory in some cases). We will still end up with
> many memory block devices in other configurations.

And that is fine because the boot time memory is still likely the
primary source of memory. And reducing memory devices for those is a
huge improvement already (just think of a multi TB system with
gazillions pointless memory devices). 

> I do agree that a "disable sysfs" option is interesting - even with
> memory hotplug (we mostly need a way to configure it and a way to notify
> kexec-tools about memory hot(un)plug events). I am currently (once
> again) looking into improving auto-onlining support in the kernel.
> 
> Having that said, I much rather want to see smaller improvements (that
> can be fine-tuned individually - like allowing variable-sized memory
> blocks) than doing a switch to "new shiny" and figuring out after a
> while that we need "new shiny2".

There is only one certainty. Providing a long term interface with ever
growing (ab)users is a hard target. And shinyN might be needed in the
end. Who knows. My main point is that the existing interface is hitting
a wall on usecases which _do_not_care_ about memory hotplug. And that is
something we should be looking at.

> I consider removing "phys_device" as one of these tunables. The question
> would be how to make such sysfs changes easy to configure
> ("-phys_device", "+variable_sized_blocks" ...)

I am with you on that. There are more candidates in memory block
directories which have dubious value. Deprecation process is a PITA and
that's why I thought that it would make sense to focus on something that
we can mis^Wdesign with exising and forming usecases in mind that would
get rid of all the cruft that we know it doesn't work (removable would
be another one.

I am definitely not going to insist and I appreciate you are trying to
clean this up. That is highly appreciated of course.
-- 
Michal Hocko
SUSE Labs
