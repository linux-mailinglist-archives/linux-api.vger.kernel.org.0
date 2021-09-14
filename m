Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE6240B69F
	for <lists+linux-api@lfdr.de>; Tue, 14 Sep 2021 20:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhINSSF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Sep 2021 14:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhINSSF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Sep 2021 14:18:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE06C061574;
        Tue, 14 Sep 2021 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jES37B1Gi2K2zluovx+bju9FoR0RejRId3amUw0BFp8=; b=ihiUe2JaSHXKYPf01jQ8bREk6Z
        i+xVmUCWwTOYOMQspUkbFBXI6NgXSvipxPdhkN9Ouku5jZFNnVsxQzhdetV41+LbTwhMZCo86xvSQ
        m4RVoOAi135n5B12he1xdJjMN3acB7GnbASz3yr6i/o6sIZELsoxArmXHtZ2ciNFSXy8ZcfsDh1Cp
        Hh4BxRcGxRPMlqopgKnmuKgu1hrT6QH1a3HVgm39h96kRxcjGE32wDieShbJFO0+nYgDDPWYzAQsE
        aJTDtq5jVfNKDF1jJ78piI9Xq9nO2i5LS7yckjVe6rgq77wfOA4yCcg89YajoqcHYfyDp9vneDt1S
        wyGFcl1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQCxu-00Ewgq-Vi; Tue, 14 Sep 2021 18:15:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86AE43001C7;
        Tue, 14 Sep 2021 20:15:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6D2A12D378DBB; Tue, 14 Sep 2021 20:15:30 +0200 (CEST)
Date:   Tue, 14 Sep 2021 20:15:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Jann Horn <jannh@google.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH 2/4 v0.5] sched/umcg: RFC: add userspace atomic helpers
Message-ID: <YUDmwsf8Lf7HQ3+s@hirez.programming.kicks-ass.net>
References: <20210908184905.163787-1-posk@google.com>
 <20210908184905.163787-3-posk@google.com>
 <CAG48ez2LyLNkH4iVbeKJUuH=oh57WECkKYCW+G9mtheoh7Fsvg@mail.gmail.com>
 <CAPNVh5eaW7r_Nv-wHEyxQiFkXngmONwPyZSFvtTEhk3TxJ+iMA@mail.gmail.com>
 <YUBYJLCYpy3yJO5F@hirez.programming.kicks-ass.net>
 <CAPNVh5chP3Zz+ww8WLb9bUYNikW-1PyOV=3==BM-92BgogaB3w@mail.gmail.com>
 <YUDkR8YtekMkuaBH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUDkR8YtekMkuaBH@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 14, 2021 at 08:04:55PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 14, 2021 at 09:29:00AM -0700, Peter Oskolkov wrote:
> > In the version of the patchset that I'm preparing to send I've decided
> > to punt on the issue and just ask the userspace to deal with locking
> > the memory as it sees fit: mlock() is available and as far as I can
> 
> Sadly mlock() does not imply no faults. Someone had a too literal
> reading of the POSIX-RT spec (of which mlock is part) and figured that
> all that was required was to keep the page in memory, not avoid faults.
> 
> Linux has had this bahviour for ages, PREEMPT_RT has tried to change
> this, but so far to no avail. At some point sys_mpin() was proposed to
> meet the original POSIX-RT intent, but afaict that never actually
> happened.
> 
> In short, mlock() does not avoid minor faults, or even migration faults,
> which can take a fair while to resolve.

Also, even if it did, that would still not be acceptible because
userspace could fail to call mlock() at which point mis-behaving
userspace can deadlock the kernel, which is a no-no.
