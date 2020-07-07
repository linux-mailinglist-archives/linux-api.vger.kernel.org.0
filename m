Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1365216B92
	for <lists+linux-api@lfdr.de>; Tue,  7 Jul 2020 13:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGGLcm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Jul 2020 07:32:42 -0400
Received: from albireo.enyo.de ([37.24.231.21]:54158 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgGGLcm (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 7 Jul 2020 07:32:42 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1jslq1-0003Sy-0A; Tue, 07 Jul 2020 11:32:37 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1jslq0-00051l-RM; Tue, 07 Jul 2020 13:32:36 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Neel Natu <neelnatu@google.com>
Subject: Re: [RFC PATCH for 5.8 3/4] rseq: Introduce RSEQ_FLAG_RELIABLE_CPU_ID
References: <20200706204913.20347-1-mathieu.desnoyers@efficios.com>
        <20200706204913.20347-4-mathieu.desnoyers@efficios.com>
        <87fta3zstr.fsf@mid.deneb.enyo.de>
        <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
Date:   Tue, 07 Jul 2020 13:32:36 +0200
In-Reply-To: <2088331919.943.1594118895344.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 7 Jul 2020 06:48:15 -0400
        (EDT)")
Message-ID: <874kqjzhkb.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> Those are very good points. One possibility we have would be to let
> glibc do the rseq registration without the RSEQ_FLAG_RELIABLE_CPU_ID
> flag. On kernels with the bug present, the cpu_id field is still good
> enough for typical uses of sched_getcpu() which does not appear to
> have a very strict correctness requirement on returning the right
> cpu number.
>
> Then libraries and applications which require a reliable cpu_id
> field could check this on their own by calling rseq with the
> RSEQ_FLAG_RELIABLE_CPU_ID flag. This would not make the state more
> complex in __rseq_abi, and let each rseq user decide about its own
> fate: whether it uses rseq or keeps using an rseq-free fallback.
>
> I am still tempted to allow combining RSEQ_FLAG_REGISTER |
> RSEQ_FLAG_RELIABLE_CPU_ID for applications which would not be using
> glibc, and want to check this flag on thread registration.

Well, you could add a bug fix level field to the __rseq_abi variable.
Then applications could check if the kernel has the appropriate level
of non-buggyness.  But the same thing could be useful for many other
kernel interfaces, and I haven't seen such a fix level value for them.
What makes rseq so special?

It won't help with the present bug, but maybe we should add an rseq
API sub-call that blocks future rseq registration for the thread.
Then we can add a glibc tunable that flips off rseq reliably if people
do not want to use it for some reason (and switch to the non-rseq
fallback code instead).  But that's going to help with future bugs
only.
