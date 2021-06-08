Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2122239F25D
	for <lists+linux-api@lfdr.de>; Tue,  8 Jun 2021 11:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFHJbN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 8 Jun 2021 05:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230222AbhFHJbN (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 8 Jun 2021 05:31:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D2EB61278;
        Tue,  8 Jun 2021 09:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623144560;
        bh=DFQHA9AN0Bwqi+IGT+h997v/dvvg0EVj1Zuf554QF0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMc2fpUYVysUoQldR/Lysq905drBSZN0I8fEucHDRKLyfJMvV2rQZfAQzc9q0TC0o
         +dp/oboZGUcmjPNwP9zqz0DgrqNoyrpNuHe4+AcCbggcoImZx1SwXFe3jiSc/ujFPt
         3v4BkLgjwje0l21Y+dNLdfrlX3kfCwHgdr1eGym0=
Date:   Tue, 8 Jun 2021 11:29:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     yongw.pur@gmail.com
Cc:     minchan@kernel.org, ngupta@vflare.org, senozhatsky@chromium.org,
        axboe@kernel.dk, akpm@linux-foundation.org,
        songmuchun@bytedance.com, david@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, linux-api@vger.kernel.org,
        lu.zhongjun@zte.com.cn, yang.yang29@zte.com.cn,
        zhang.wenya1@zte.com.cn, wang.yong12@zte.com.cn
Subject: Re: [RFC PATCH V3] zram:calculate available memory when zram is used
Message-ID: <YL84boGKozWE+n23@kroah.com>
References: <1623080354-21453-1-git-send-email-yongw.pur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623080354-21453-1-git-send-email-yongw.pur@gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Jun 07, 2021 at 08:39:14AM -0700, yongw.pur@gmail.com wrote:
> From: wangyong <wang.yong12@zte.com.cn>
> 
> When zram is used, available+Swap free memory is obviously bigger than we
> actually can use, because zram can compress memory by compression
> algorithm and zram compressed data will occupy memory too.
> 
> So, we can count the compression ratio of zram in the kernel. The space
> will be saved by zram and other swap device are calculated as follows:
> zram[swapfree - swapfree * compress ratio] + swapdev[swapfree]
> We can evaluate the available memory of the whole system as:
> MemAvailable+zram[swapfree - swapfree * compress ratio]+swapdev[swapfree]

Why is this needed to be exported by userspace?  Who is going to use
this information and why can't they just calculate it from the exported
information already?

What tool requires this new information and what is it going to be used
for?

And why add a block driver's information to a core proc file?  Shouldn't
the information only be in the block driver's sysfs directory only?

thanks,

greg k-h
