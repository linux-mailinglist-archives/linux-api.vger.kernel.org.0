Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C64278CF2
	for <lists+linux-api@lfdr.de>; Fri, 25 Sep 2020 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgIYPjM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 25 Sep 2020 11:39:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728678AbgIYPjM (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 25 Sep 2020 11:39:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601048349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jDnBhjhUv7YmI2bb5gm13xCZ5HPNcb3nq4eD9eHGM6I=;
        b=G3g2WkorQDLCkKfxkqvc66L0olkKD9cuZWPclS07u6X4tJRnpoRrAWzK9W9pArxeL9tyxh
        RNSC1iTHPwqiaYZOUBBty1wDxcG9kPltD5gU2SP6owKvAssYCWxufwyz3e+0fcf9Gd9Z0i
        SapfbUbiajqlZFrXyqSHVOHhxwCwLnU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90176ACA3;
        Fri, 25 Sep 2020 15:39:09 +0000 (UTC)
Date:   Fri, 25 Sep 2020 17:39:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
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
Message-ID: <20200925153908.GH3389@dhcp22.suse.cz>
References: <21852ccb-bd06-9281-7c8e-485ec02f2883@redhat.com>
 <20200922155611.379373f7@thinkpad>
 <a7d02345-2195-3092-a368-ca3209e2c93e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7d02345-2195-3092-a368-ca3209e2c93e@redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri 25-09-20 16:49:28, David Hildenbrand wrote:
> >> There were once RFC patches to make use of it in ACPI, but it could be
> >> solved using different interfaces [1].
> >>
> >>
> >> While I'd love to rip it out completely, I think it would break old
> >> lsmem/chmem completely - and I assume that's not acceptable. I was
> >> wondering what would be considered safe to do now/in the future:
> >>
> >> 1. Make it always return 0 (just as if "sclp.rzm" would be set to 0 on
> >> s390x). This will make old lsmem/chmem behave differently after
> >> switching to a new kernel, like if sclp.rzm would not be set by HW -
> >> AFAIU, it will assume all memory is in a single memory increment. Do we
> >> care?
> > 
> > No, at least not until that kernel change would be backported to some
> > old distribution level where we still use lsmem/chmem from s390-tools.
> > Given that this is just some clean-up w/o any functional benefit, and
> > hopefully w/o any negative impact, I think we can safely assume that no
> > distributor will do that "just for fun".
> > 
> > Even if there would be good reasons for backports, then I guess we also
> > have good reasons for backporting / switching to the util-linux version
> > of lsmem / chmem for such distribution levels. Alternatively, adjust the
> > s390-tools lsmem / chmem there.
> > 
> > But I would rather "rip it out completely" than just return 0. You'd
> > need some lsmem / chmem changes anyway, at least in case this would
> > ever be backported.
> 
> Thanks for your input Gerald.
> 
> So unless people would be running shiny new kernels on older
> distributions it shouldn't be a problem (and I don't think we care too
> much about something like that). I don't expect something like that to
> get backported - there is absolutely no reason to do so IMHO.

Ohh, there are many people running current Linus tree on an older
distribution. Including me.

> >> 2. Restrict it to s390x only. It always returned 0 on other
> >> architectures, I was not able to find any user.
> >>
> >> I think 2 should be safe to do (never used on other archs). I do wonder
> >> what the feelings are about 1.
> > 
> > Please don't add any s390-specific workarounds here, that does not
> > really sound like a clean-up, rather the opposite.
> 
> People seem to have different opinions here. I'm happy as long as we can
> get rid of it (either now, or in the future with a new model).
> 
> > 
> > That being said, I do not really see the benefit of this change at
> > all. As Michal mentioned, there really should be some more fundamental
> > change. And from the rest of this thread, it also seems that phys_device
> > usage might not be the biggest issue here.
> > 
> 
> As I already expressed, I am more of a friend of small, incremental
> changes than having a single big world switch where everything will be
> shiny and perfect.
> 
> (Deprecating it now - in any way - stops any new users from appearing -
> both, in the kernel and from user space - eventually making the big
> world switch later a little easier because there is one thing less that
> vanished)

Realistically people do not care about deprecation all that much. They
simply use whatever they can find or somebody will show them. Really,
deprecation has never really worked. The only thing that worked was to
remove the functionality and then wait for somebody to complain and
revert or somehow allow the functionality without necessity to alter the
userspace.

As much as I would like to remove as much crud as possible I strongly
suspect that the existing hotplug interface is just a lost case and it
doesn't make for the best used time to put a lip stick on a pig. Even if
we remove this particular interface we are not going to get rid of a lot
of code or we won't gain any more sensible semantic, right?
-- 
Michal Hocko
SUSE Labs
