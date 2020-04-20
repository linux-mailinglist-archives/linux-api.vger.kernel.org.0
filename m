Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239CC1B0D7A
	for <lists+linux-api@lfdr.de>; Mon, 20 Apr 2020 15:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDTNzb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 20 Apr 2020 09:55:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgDTNzb (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 20 Apr 2020 09:55:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2271A2070B;
        Mon, 20 Apr 2020 13:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587390930;
        bh=O04bKT/UuprfevGDf8tJ7GxxbeJNfAWwckV+P9MaPjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hx/5hkGLkldHa3//CkoCPCG+gGwq3zi4gcq/DdrXnHzRlqbNG7eGM+zPlLa43v7FQ
         ipphHG0vtKA2FVBYbsBP6XuX6Vn/HI4ph8M5Xdd/vQlTcmSQkiw+OQ1Ega0jr3KOQi
         bN/+VtLJSwcLueRAlqU250U9TAkGSeKhWgf/PVOM=
Date:   Mon, 20 Apr 2020 14:55:24 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Alex Belits <abelits@marvell.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v3 03/13] task_isolation: add instruction
 synchronization memory barrier
Message-ID: <20200420135523.GA18711@willie-the-truck>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <aed12dd15ea2981bc9554cfa8b5e273c1342c756.camel@marvell.com>
 <07c25c246c55012981ec0296eee23e68c719333a.camel@marvell.com>
 <d995795c731d6ecceb36bdf1c1df3d72fefd023d.camel@marvell.com>
 <20200415124427.GB28304@C02TD0UTHF1T.local>
 <e4d2cda6f011e80a0d8e482b85bca1c57665fcfd.camel@marvell.com>
 <20200420122350.GB12889@willie-the-truck>
 <20200420123628.GB69441@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420123628.GB69441@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 20, 2020 at 01:36:28PM +0100, Mark Rutland wrote:
> On Mon, Apr 20, 2020 at 01:23:51PM +0100, Will Deacon wrote:
> > On Sun, Apr 19, 2020 at 05:02:01AM +0000, Alex Belits wrote:
> > > On Wed, 2020-04-15 at 13:44 +0100, Mark Rutland wrote:
> > > > On Thu, Apr 09, 2020 at 03:17:40PM +0000, Alex Belits wrote:
> > > > > Some architectures implement memory synchronization instructions
> > > > > for
> > > > > instruction cache. Make a separate kind of barrier that calls them.
> > > > 
> > > > Modifying the instruction caches requries more than an ISB, and the
> > > > 'IMB' naming implies you're trying to order against memory accesses,
> > > > which isn't what ISB (generally) does.
> > > > 
> > > > What exactly do you want to use this for?
> > > 
> > > I guess, there should be different explanation and naming.
> > > 
> > > The intention is to have a separate barrier that causes cache
> > > synchronization event, for use in architecture-independent code. I am
> > > not sure, what exactly it should do to be implemented in architecture-
> > > independent manner, so it probably only makes sense along with a
> > > regular memory barrier.
> > > 
> > > The particular place where I had to use is the code that has to run
> > > after isolated task returns to the kernel. In the model that I propose
> > > for task isolation, remote context synchronization is skipped while
> > > task is in isolated in userspace (it doesn't run kernel, and kernel
> > > does not modify its userspace code, so it's harmless until entering the
> > > kernel).
> > 
> > > So it will skip the results of kick_all_cpus_sync() that was
> > > that was called from flush_icache_range() and other similar places.
> > > This means that once it's out of userspace, it should only run
> > > some "safe" kernel entry code, and then synchronize in some manner that
> > > avoids race conditions with possible IPIs intended for context
> > > synchronization that may happen at the same time. My next patch in the
> > > series uses it in that one place.
> > > 
> > > Synchronization will have to be implemented without a mandatory
> > > interrupt because it may be triggered locally, on the same CPU. On ARM,
> > > ISB is definitely necessary there, however I am not sure, how this
> > > should look like on x86 and other architectures. On ARM this probably
> > > still should be combined with a real memory barrier and cache
> > > synchronization, however I am not entirely sure about details. Would
> > > it make more sense to run DMB, IC and ISB? 
> > 
> > IIUC, we don't need to do anything on arm64 because taking an exception acts
> > as a context synchronization event, so I don't think you should try to
> > expose this as a new barrier macro. Instead, just make it a pre-requisite
> > that architectures need to ensure this behaviour when entering the kernel
> > from userspace if they are to select HAVE_ARCH_TASK_ISOLATION.
> 
> The CSE from the exception isn't sufficient here, because it needs to
> occur after the CPU has re-registered to receive IPIs for
> kick_all_cpus_sync(). Otherwise there's a window between taking the
> exception and re-registering where a necessary context synchronization
> event can be missed. e.g.
> 
> CPU A				CPU B
> [ Modifies some code ]		
> 				[ enters exception ]
> [ D cache maintenance ]
> [ I cache maintenance ]
> [ IPI ]				// IPI not taken
>   ...				[ register for IPI ] 
> [ IPI completes ] 
> 				[ execute stale code here ]

Thanks.

> However, I think 'IMB' is far too generic, and we should have an arch
> hook specific to task isolation, as it's far less likely to be abused as
> IMB will.

What guarantees we don't run any unsynchronised module code between
exception entry and registering for the IPI? It seems like we'd want that
code to run as early as possible, e.g. as part of
task_isolation_user_exit() but that doesn't seem to be what's happening.

Will
