Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE97337A0F
	for <lists+linux-api@lfdr.de>; Thu, 11 Mar 2021 17:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhCKQwa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Mar 2021 11:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhCKQw0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 Mar 2021 11:52:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F30C061574;
        Thu, 11 Mar 2021 08:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jojXJ42UMX7xPogeR/Mx0xX5P7m6PdT89qs91n08TWo=; b=QtzkLjJCe42eAwZ5cWDdaH3YGv
        Z1LcAP8aoAk5vnC910BVd4LtywBRSTrl9hlFggmzXruMJCyyBoMTBIYvjQhgir0HgupnuL8PUNVXf
        lHl3yD/h+0nPv8WLTpdJuaBELGVsYAil6MImW+dkHkfd/NXn0qs4epBtUPwIVFsH6nIvw+Q8mOp8m
        gfBePz0ulbeUoJICMI2OqLbmdFSrN5bDqaAUBWN6zCQfdhnMEeDniH5/CtT//D9Y32QD2NLtfPQk7
        yQSUs6aZLVZ6cUpwxZ+/O6T5MnqhwLBcXrppHBJXaGwJ8uTzHDVY7CCKnZzSooboClxHgAZJE1KzY
        nbMMotLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKOXK-007qGS-Fc; Thu, 11 Mar 2021 16:51:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59AE2301959;
        Thu, 11 Mar 2021 17:51:45 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 464BD2BF461C2; Thu, 11 Mar 2021 17:51:45 +0100 (CET)
Date:   Thu, 11 Mar 2021 17:51:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Piotr Figiel <figiel@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Florian Weimer <fweimer@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir <emmir@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
Message-ID: <YEpKoa9PgjffO7Q5@hirez.programming.kicks-ass.net>
References: <20210226135156.1081606-1-figiel@google.com>
 <1173189328.5477.1615474316906.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1173189328.5477.1615474316906.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 11, 2021 at 09:51:56AM -0500, Mathieu Desnoyers wrote:
> 
> 
> ----- On Feb 26, 2021, at 8:51 AM, Piotr Figiel figiel@google.com wrote:
> 
> > For userspace checkpoint and restore (C/R) a way of getting process state
> > containing RSEQ configuration is needed.
> > 
> > There are two ways this information is going to be used:
> > - to re-enable RSEQ for threads which had it enabled before C/R
> > - to detect if a thread was in a critical section during C/R
> > 
> > Since C/R preserves TLS memory and addresses RSEQ ABI will be restored
> > using the address registered before C/R.
> > 
> > Detection whether the thread is in a critical section during C/R is needed
> > to enforce behavior of RSEQ abort during C/R. Attaching with ptrace()
> > before registers are dumped itself doesn't cause RSEQ abort.
> > Restoring the instruction pointer within the critical section is
> > problematic because rseq_cs may get cleared before the control is passed
> > to the migrated application code leading to RSEQ invariants not being
> > preserved. C/R code will use RSEQ ABI address to find the abort handler
> > to which the instruction pointer needs to be set.
> > 
> > To achieve above goals expose the RSEQ ABI address and the signature value
> > with the new ptrace request PTRACE_GET_RSEQ_CONFIGURATION.
> > 
> > This new ptrace request can also be used by debuggers so they are aware
> > of stops within restartable sequences in progress.
> > 
> > Signed-off-by: Piotr Figiel <figiel@google.com>
> > Reviewed-by: Michal Miroslaw <emmir@google.com>
> 
> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

How do we route this? Do I stick this in tip/sched/core as being an rseq
patch?
