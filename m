Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D022134C4E0
	for <lists+linux-api@lfdr.de>; Mon, 29 Mar 2021 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhC2H2M (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Mar 2021 03:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhC2H1l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Mar 2021 03:27:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B02C061574;
        Mon, 29 Mar 2021 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vXzyS4ZdoAsGZHqx1Bd2aZc17spJkGLwajSiyRGf+lM=; b=uK3d9hLEsjECjYK//WF1aA+5NR
        2JDiou5L6iAAGfp2awoVez0aYlStDU62gbicIIelRkUvBdAZQzCFSMK6UQUC8Fj3yxBoVYR2ayB/I
        TnZuOn2dY0MO4dGbGYKshe/L/AFz7WrM5FdVUU7oFkKCRiQOR9L2XLjWyY50KNtJ3Cw0TImroaqN2
        acrp1waG/HroebOevKlOzuPHtWZNKjqpPPKK5YhJZXQ1TTzUkp9UV34VYOcSRc6QzZWIYzttzYE/a
        EnQGgNr8FvaziyYYF/S4G5d2hilj2dKOGvuJFF3gmyIM0XCmIMcKD7TrWsZAHJZuAOLro0vyRPX0w
        rUL3EChA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQmIi-001B3I-Hv; Mon, 29 Mar 2021 07:27:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19DDE3011FE;
        Mon, 29 Mar 2021 09:27:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E5A62207189A1; Mon, 29 Mar 2021 09:27:02 +0200 (CEST)
Date:   Mon, 29 Mar 2021 09:27:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related
 features
Message-ID: <YGGBRpsephlAubS1@hirez.programming.kicks-ass.net>
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <CALCETrUBC34NSHj3eLScYtHJk_7ZHOVJZVPkdLUXemPEiyA_uA@mail.gmail.com>
 <87o8f4cd50.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8f4cd50.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Sun, Mar 28, 2021 at 01:53:15AM +0100, Thomas Gleixner wrote:
> Though the little devil in my head tells me, that making AMX support
> depend on the CPUID faulting capability might be not the worst thing.
> 
> Then we actually enforce CPUID faulting (finally) on CPUs which support
> it, which would be a first step into the right direction simply because
> then random library X has to go to the kernel and ask for it explicitely
> or just shrug and use whatever the kernel is willing to hand out in
> CPUID.
> 
> Now take that one step further. When the first part of some user space
> application asks for it, then you can register that with the process and
> make sane decisions for all other requesters which come after it, which
> is an important step into the direction of having a common orchestration
> for this.

I wrote something like that at least one...

  https://lore.kernel.org/lkml/20190212164833.GK32494@hirez.programming.kicks-ass.net/

we just need to make sure AMD implements that before it ships a chip
with AVX512 on.
