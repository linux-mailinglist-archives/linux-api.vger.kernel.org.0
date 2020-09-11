Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60787265A6B
	for <lists+linux-api@lfdr.de>; Fri, 11 Sep 2020 09:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgIKHUk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 11 Sep 2020 03:20:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgIKHUj (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 Sep 2020 03:20:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E782EACDF;
        Fri, 11 Sep 2020 07:20:51 +0000 (UTC)
Date:   Fri, 11 Sep 2020 09:20:35 +0200
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
Message-ID: <20200911072035.GC7986@dhcp22.suse.cz>
References: <f14f7f00-0501-bb93-88cc-780ae4fbaad3@intel.com>
 <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E00A442-7107-48DA-8172-EED95F6E1663@redhat.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu 10-09-20 22:31:09, David Hildenbrand wrote:
> 
> 
> > Am 10.09.2020 um 22:01 schrieb Dave Hansen <dave.hansen@intel.com>:
> > 
> > ﻿On 9/10/20 3:20 AM, David Hildenbrand wrote:
> >> I was just exploring how /sys/devices/system/memory/memoryX/phys_device
> >> is/was used. It's one of these interfaces that most probably never
> >> should have been added but now we are stuck with it.
> > 
> > While I'm all for cleanups, what specific problems is phys_device causing?
> > 
> 
> Mostly stumbling over it, understanding that it is basically unused
> with new userspace for good reason, questioning its existence.
> 
> E.g., I am working on virtio-mem support for s390x. Displaying
> misleading/wrong phys_device indications isn‘t particularly helpful
> - especially once there are different ways to hotplug memory for an
> architecture.
> 
> > Are you hoping that we can just remove users of memoryX/* until there
> > are no more left, and this is the easiest place to start?
> 
> At least reducing it to a minimum with clear semantics. Even with
> automatic onlining there are still reasons why we need to keep the
> interface for now (e.g., reloading kexec to update the kdump headers
> on memory hot(un)plug). But also standby memory handling on s399x
> requires it (->manual onlining).

While I agree that the existing interface is far from ideal, I am not
sure it makes much sense to invest energy into cleaning it up. We can
have a pig with a lipstick but but this will not solve the underlying
problem that we have I believe. The interface doesn't scale with the
block count (especially on some platforms like ppc), it is too
inflexible (single size of the block) and many others. I believe we need
a completely new interface which would effectively deprecate the
existing one. One could still chose to use the old interface but new
usecases would use the new one ideally.

I have brought that up earlier already without much follow up
(http://lkml.kernel.org/r/20200619120704.GD12177@dhcp22.suse.cz)

-- 
Michal Hocko
SUSE Labs
