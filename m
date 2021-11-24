Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0997E45CAC0
	for <lists+linux-api@lfdr.de>; Wed, 24 Nov 2021 18:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhKXRXw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Nov 2021 12:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbhKXRXv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Nov 2021 12:23:51 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A4C061574;
        Wed, 24 Nov 2021 09:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=90tBr9ISWVQ5VDnzn6BH4Jf8y5Ik/rvCK0jtS5q55bg=; b=T7x+cr74AzzFRTsIXSBUlC1rKX
        LEa1lEVdZsUkgySFF41gbe3HBB0rK5KLFnC+g6oTXxChVVuJzDf+9qeRu8H7Y6tGtWUTHDvWQL/Qf
        +FHGxt8YnkRa9VPidqhxPCd/YpEd6Fdqy2nbaN7VnuytIXlzhI+qGmL5Mu8yJevyiKMRAo4amvsqz
        /NrGH6raItx9mDtEl46I3ozPT5allOhkyCPkd5/QGI986JQU5TNPfO0RNa837MvmofcDnsAhNN/em
        W3UXw7LfiWAO9M6gG7KdgiSBWceGMPIPsyhiRCd0kkGjRetF1R6016ZZk9daXvDZADZoz07/ms33L
        NvuyILgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mpvwS-000I2u-Af; Wed, 24 Nov 2021 17:20:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A24C3300093;
        Wed, 24 Nov 2021 18:20:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BD202DABEF09; Wed, 24 Nov 2021 18:20:18 +0100 (CET)
Date:   Wed, 24 Nov 2021 18:20:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 0/6] sched,mm,x86/uaccess: implement User Managed
 Concurrency Groups
Message-ID: <YZ50UoNxtsACynjZ@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <YZ5G7gO5Gc1zu/Cm@hirez.programming.kicks-ass.net>
 <CAFTs51Vp=hfiDkSHVysHLh9QOqpUXUksF-SW86GOd5ih-=7JPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51Vp=hfiDkSHVysHLh9QOqpUXUksF-SW86GOd5ih-=7JPQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Nov 24, 2021 at 08:28:43AM -0800, Peter Oskolkov wrote:
> On Wed, Nov 24, 2021 at 6:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 22, 2021 at 01:13:21PM -0800, Peter Oskolkov wrote:
> > > User Managed Concurrency Groups (UMCG) is an M:N threading
> > > subsystem/toolkit that lets user space application developers implement
> > > in-process user space schedulers.
> > >
> > > This v0.9.1 patchset is the same as v0.9, where u32/u64 in
> > > uapi/linux/umcg.h are replaced with __u32/__u64, as test robot/lkp
> > > does not recognize u32/u64 for some reason.
> > >
> > > v0.9 is v0.8 rebased on top of the current tip/sched/core,
> > > with a fix in umcg_update_state of an issue reported by Tao Zhou.
> > >
> > > Key changes from patchset v0.7:
> > > https://lore.kernel.org/all/20211012232522.714898-1-posk@google.com/:
> > >
> > > - added libumcg tools/lib/umcg;
> > > - worker "wakeup" is reworked so that it is now purely a userspace op,
> > >   instead of waking the thread in order for it to block on return
> > >   to the userspace immediately;
> > > - a couple of minor fixes and refactorings.
> > >
> > > These big things remain to be addressed (in no particular order):
> > > - support tracing/debugging
> > > - make context switches faster (see umcg_do_context_switch in umcg.c)
> > > - support other architectures
> > > - cleanup and post selftests in tools/testing/selftests/umcg/
> > > - allow cross-mm wakeups (securely)
> >
> > *groan*... so these patches do *NOT* support the very thing this all
> > started with, namely block + wakeup notifications. I'm really not sure
> > how that happened, as that was the sole purpose of the exercise.
> 
> I'm not sure why you say this - in-process block/wakeup is very much
> supported - please see the third patch. Cross-process (cross-mm)
> wakeups are not supported at the moment, as the security story has to
> be fleshed out.

I seem to have gotten submit and update work confused. I'll go stare
more. For some reason I find it very hard to read this stuff.
