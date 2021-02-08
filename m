Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DEE13128C2
	for <lists+linux-api@lfdr.de>; Mon,  8 Feb 2021 02:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbhBHBbo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 7 Feb 2021 20:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhBHBbo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 7 Feb 2021 20:31:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32742C06174A;
        Sun,  7 Feb 2021 17:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lD7QVBDoo2n3B5TjjWe/LazElHNVpG8lB7yZkwrFfwc=; b=MaJMVf613EdZuXmqlYeAtKUuHj
        Y1do0olDL4LMFLRLVerYvQCug2SqeQLzlJ8NzAPMCYrVBJXRHGDVz1tBDYWcSrGha+Tpu2Id7Mtmm
        tAb30QyZmu9ZhJbiEFOIz6GuKN9xCRRdCA7HEDU1qVgg6i70eTyQ6rIDgtWwoHGBH+uoN6zydBL34
        Iab+t9xLe8qt8LfgKIYJfpN3O3pxnioA+yvAVnarVxjSkWY8vd+QbOn/hiVTlV8NwZ9qDHhFP/Jwe
        TUnXf6m8p5iH6eMf9YUnyVUZOfuEb/040qR0nuT1cb7GOibjLaWDBaVjiK0x5J/FvBH86/Fg3M9pP
        yn9SsJ6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l8vOC-005L6R-9O; Mon, 08 Feb 2021 01:30:56 +0000
Date:   Mon, 8 Feb 2021 01:30:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Liguozhu (Kenneth)" <liguozhu@hisilicon.com>,
        "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
        "chensihang (A)" <chensihang1@hisilicon.com>
Subject: Re: [RFC PATCH v3 1/2] mempinfd: Add new syscall to provide memory
 pin
Message-ID: <20210208013056.GM308988@casper.infradead.org>
References: <1612685884-19514-1-git-send-email-wangzhou1@hisilicon.com>
 <1612685884-19514-2-git-send-email-wangzhou1@hisilicon.com>
 <20210207213409.GL308988@casper.infradead.org>
 <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4b2d7db8a1047d9952cbbfaf9e27824@hisilicon.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Feb 07, 2021 at 10:24:28PM +0000, Song Bao Hua (Barry Song) wrote:
> > > In high-performance I/O cases, accelerators might want to perform
> > > I/O on a memory without IO page faults which can result in dramatically
> > > increased latency. Current memory related APIs could not achieve this
> > > requirement, e.g. mlock can only avoid memory to swap to backup device,
> > > page migration can still trigger IO page fault.
> > 
> > Well ... we have two requirements.  The application wants to not take
> > page faults.  The system wants to move the application to a different
> > NUMA node in order to optimise overall performance.  Why should the
> > application's desires take precedence over the kernel's desires?  And why
> > should it be done this way rather than by the sysadmin using numactl to
> > lock the application to a particular node?
> 
> NUMA balancer is just one of many reasons for page migration. Even one
> simple alloc_pages() can cause memory migration in just single NUMA
> node or UMA system.
> 
> The other reasons for page migration include but are not limited to:
> * memory move due to CMA
> * memory move due to huge pages creation
> 
> Hardly we can ask users to disable the COMPACTION, CMA and Huge Page
> in the whole system.

You're dodging the question.  Should the CMA allocation fail because
another application is using SVA?

I would say no.  The application using SVA should take the one-time
performance hit from having its memory moved around.
