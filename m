Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2177039CA1C
	for <lists+linux-api@lfdr.de>; Sat,  5 Jun 2021 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFERJH (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 5 Jun 2021 13:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhFERJH (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Sat, 5 Jun 2021 13:09:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE46361416;
        Sat,  5 Jun 2021 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622912839;
        bh=8K9ZUN1X6q7QYKaoMkC5sSzJVB3RkIZbgRR8IQ4iHzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x4De8Ow1WFCPQahQj1Mh7hSTuUB1qDxOFpxa6yTPbIBjo526qD9iDpkpZCc18/p15
         9TCgLoDTxbyQ5Goy7XmQZUK7TuuMFRx2kwWemNdhx13i0OD4Gzjnd9WVyG50J4098d
         1Psbz8yOqqi+f2/r1tnfkXREw6ulgxLXGwx5/T6g=
Date:   Sat, 5 Jun 2021 19:07:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yongw.pur@gmail.com
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, linux-api@vger.kernel.org
Subject: Re: [RFC PATCH V2] zram:calculate available memory when zram is used
Message-ID: <YLuvQwkZkl9UCoJw@kroah.com>
References: <1622910240-4621-1-git-send-email-yongw.pur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622910240-4621-1-git-send-email-yongw.pur@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sat, Jun 05, 2021 at 09:24:00AM -0700, yongw.pur@gmail.com wrote:
> From: wangyong <yongw.pur@gmail.com>
> 
> When zram is used, available+Swap free memory is obviously
> bigger than we actually can use, because zram can compress
> memory by compression algorithm and zram compressed data
> will occupy memory too.
> 
> So, we can count the compression ratio of zram in the kernel.
> The space will be saved by zram and other swap device are
> calculated as follows:
> zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
> We can evaluate the available memory of the whole system as:
> MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]
> 
> Add an entry to the /proc/meminfo file, returns swap will save space.
> Which name is more appropriate is still under consideration.
> There are several alternative names: SwapAvailable, SwapSaved,
> SwapCompressible
> 
> Signed-off-by: wangyong <yongw.pur@gmail.com>
> ---
>  drivers/block/zram/zcomp.h    |  1 +
>  drivers/block/zram/zram_drv.c | 19 +++++++++
>  drivers/block/zram/zram_drv.h |  1 +
>  fs/proc/meminfo.c             |  1 +
>  include/linux/swap.h          | 10 +++++
>  mm/swapfile.c                 | 95 +++++++++++++++++++++++++++++++++++++++++++
>  mm/vmscan.c                   |  1 +
>  7 files changed, 128 insertions(+)

You are adding a new sysfs file with no new Documentation/ABI entry.
Also are you sure you are allowed to add a new proc file entry without
breaking existing tools?

thanks,

greg k-h
