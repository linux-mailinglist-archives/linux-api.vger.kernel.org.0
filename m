Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9DFE404658
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352697AbhIIHjX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Sep 2021 03:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352693AbhIIHjW (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 9 Sep 2021 03:39:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF7D3610C8;
        Thu,  9 Sep 2021 07:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1631173093;
        bh=7lwbrqw7wj0cp85DjhXotE5F9UFIt/AUJn9Dp18hKEI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKJkYPDDVFO4QOfan1RYrCZO8uFJytvBPjRn4YNNgxASM2R/ajO/bIdzNJdHEPlIE
         G7GtJXzbCvqsAqdyw0gkKr2sKWwrkPWQXwv1YVTtYgXuEhKdxV+IQYrf88p6ZfJJt1
         xx56WIsnXK0yT+17akXxtHE+3r6GM2ci888Eva3A=
Date:   Thu, 9 Sep 2021 08:39:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Prakash Sangappa <prakash.sangappa@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [RESEND RFC PATCH 1/3] Introduce per thread user-kernel shared
 structure
Message-ID: <YTmsN78BGKZZLULo@kroah.com>
References: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
 <1631146225-13387-2-git-send-email-prakash.sangappa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631146225-13387-2-git-send-email-prakash.sangappa@oracle.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Sep 08, 2021 at 05:10:23PM -0700, Prakash Sangappa wrote:
> A structure per thread is allocated from a page that is shared mapped
> between user space and kernel as means for faster communication. This will
> facilitate sharing information, Ex: per thread stats shared between kernel
> and user space, that can be read by applications without the need for
> making frequent system calls in latency sensitive code path.
> 
> A new system call is added, which will allocate the shared structure and
> return its mapped user address. Multiple such structures will be allocated
> on a page to accommodate requests from different threads of a multithreaded
> process. Available space on a page is managed using a bitmap. When a thread
> exits, the shared structure is freed and can get reused for another thread
> that requests the shared structure. More pages will be allocated and used
> as needed based on the number of threads requesting use of shared
> structures. These pages are all freed when the process exits.
> 
> Each of these shared structures are rounded to 128 bytes. Available space
> in this structure can be used to accommodate additional per thread stats,
> state etc as needed. In future, if more space beyond 128 bytes, is
> needed, multiple such shared structures per thread could be allocated and
> managed by the kernel. Although, space in shared structure for sharing any
> kind of stats or state should be sparingly used. Therefore shared structure
> layout is not exposed to user space. the system call will return the
> mapped user address of a specific member or nested structure within the
> shared structure corresponding to stats requested, This would allow future
> enhancements/changes without breaking the API.
> 
> Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>

Where is the Documentation/ABI/ entries for this new user/kernel abi
that you are creating and must maintain for the next 20+ years?

thanks,

greg k-h
