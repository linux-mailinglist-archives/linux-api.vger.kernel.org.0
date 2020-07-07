Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5134216778
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 09:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGGH3Z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 03:29:25 -0400
Received: from albireo.enyo.de ([37.24.231.21]:49040 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgGGH3Z (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 Jul 2020 03:29:25 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jsi2a-0000Vp-A9; Tue, 07 Jul 2020 07:29:20 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jsi2a-0003dv-6a; Tue, 07 Jul 2020 09:29:20 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
        <20200706204913.20347-4-mathieu.desnoyers@efficios.com>
Date:   Tue, 07 Jul 2020 09:29:20 +0200
In-Reply-To: <20200706204913.20347-4-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 6 Jul 2020 16:49:12 -0400")
Message-ID: <87fta3zstr.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> commit 93b585c08d16 ("Fix: sched: unreliable rseq cpu_id for new tasks")
> addresses an issue with cpu_id field of newly created processes. Expose
> a flag which can be used by user-space to query whether the kernel
> implements this fix.
>
> Considering that this issue can cause corruption of user-space per-cpu
> data updated with rseq, it is recommended that user-space detects
> availability of this fix by using the RSEQ_FLAG_RELIABLE_CPU_ID flag
> either combined with registration or on its own before using rseq.

Presumably, the intent is that glibc uses RSEQ_FLAG_RELIABLE_CPU_ID to
register the rseq area.  That will surely prevent glibc itself from
activating rseq on broken kernels.  But if another rseq library
performs registration and has not been updated to use
RSEQ_FLAG_RELIABLE_CPU_ID, we still end up with an active rseq area
(and incorrect CPU IDs from sched_getcpu in glibc).  So further glibc
changes will be needed.  I suppose we could block third-party rseq
registration with a registration of a hidden rseq area (not
__rseq_abi).  But then the question is if any of the third-party rseq
users are expecting the EINVAL error code from their failed
registration.

The rseq registration state machine is quite tricky already, and the
need to use RSEQ_FLAG_RELIABLE_CPU_ID would make it even more
complicated.  Even if we implemented all the changes, it's all going
to be essentially dead, untestable code in a few months, when the
broken kernels are out of circulation.  It does not appear to be good
investment to me.
