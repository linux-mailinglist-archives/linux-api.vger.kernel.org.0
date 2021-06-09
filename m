Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926103A1853
	for <lists+linux-api@lfdr.de>; Wed,  9 Jun 2021 17:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbhFIPCJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Jun 2021 11:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238378AbhFIPCI (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 9 Jun 2021 11:02:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46166611CC;
        Wed,  9 Jun 2021 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623250800;
        bh=49nXecvhsLBHihPFzr4F1shvMNvWEV2skUmEodggHXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N7/Nd/zuds8aJM/XE8CD7Qy708zqWC+oTwV5MoOmEHCPALfB37ouXaY5eSmS4j4eO
         HNjLgTrAPIM5H3TRpZQQQpErtoQZAjEhuly03r7j3mv0Vv2sbCrJN1Bc0IivMIxPrg
         zlugSh2FzNlpApkjnRjS3w7t+Mv+Nz7VUM2t1/oQ=
Date:   Wed, 9 Jun 2021 16:59:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yong w <yongw.pur@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, linux-api@vger.kernel.org,
        lu.zhongjun@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.wenya1@zte.com.cn, wang.yong12@zte.com.cn
Subject: Re: [RFC PATCH V3] zram:calculate available memory when zram is used
Message-ID: <YMDXbh0H20MPG87V@kroah.com>
References: <1623080354-21453-1-git-send-email-yongw.pur@gmail.com>
 <YL84boGKozWE+n23@kroah.com>
 <CAOH5QeBV5zq=SpMSxZHJqgmfKegdgc7ehpots6AKjjgEYq5rGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOH5QeBV5zq=SpMSxZHJqgmfKegdgc7ehpots6AKjjgEYq5rGg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jun 09, 2021 at 10:23:36PM +0800, yong w wrote:
> Greg KH <gregkh@linuxfoundation.org> 于2021年6月8日周二 下午5:29写道：
> 
> >
> > On Mon, Jun 07, 2021 at 08:39:14AM -0700, yongw.pur@gmail.com wrote:
> > > From: wangyong <wang.yong12@zte.com.cn>
> > >
> > > When zram is used, available+Swap free memory is obviously bigger than we
> > > actually can use, because zram can compress memory by compression
> > > algorithm and zram compressed data will occupy memory too.
> > >
> > > So, we can count the compression ratio of zram in the kernel. The space
> > > will be saved by zram and other swap device are calculated as follows:
> > > zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
> > > We can evaluate the available memory of the whole system as:
> > > MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]
> >
> > Why is this needed to be exported by userspace?  Who is going to use
> > this information and why can't they just calculate it from the exported
> > information already?
> 
> In embedded devices, it is necessary to assess how much memory is available.

Why is that any different from a server?  Or a laptop?  Or any other
system running Linux?  "embedded" isn't special here :)

> If the memory allocation is based on available+swapfree, it may cause oom and
> affect the normal use of the devices. And it is more accurate and safe
> to calculate
> the swap available memory through minimum compression ratio.
> 
> Although mm_stat interface provides compressed information，but it is not easy to
> get the minimum compression ratio during swaping out. Kernel provides a common
> interface, which makes it easier to use and judge the state of system memory

If you are running up against this type of limit, how is a proc file
guess going to help much?  What are you going to do based on the result?
And as it's always going to be a guess, how reliable is it?

> > What tool requires this new information and what is it going to be used
> > for?
> 
> It can be used in embedded devices to evaluate the memory condition
> and avoid causing oom; Also If we wants to know more accurate available
> memory information when zram is used.

Why not rely on the oom logic instead?  What is wrong with that as this
is always going to be just a guess.  You are never going to be able to
react fast enough to reading this value to be able to do anything better
than you could through the existing oom notifier/logic, right?

> > And why add a block driver's information to a core proc file?  Shouldn't
> > the information only be in the block driver's sysfs directory only?
> >
> > thanks,
> >
> > greg k-h
> 
> I thought it would be better to put it there.

If no one needs it, why add it?  :)

> In the first patch, MemAvailable returned with swap available memory, and
> David recommended a separate interface.

A sysfs file makes more sense to me, and seems simpler.

But again, this is just a guess, trying to do real work based on it
feels really risky.

thanks,

greg k-h
