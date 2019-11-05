Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911F5EF1A9
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 01:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfKEAKx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 4 Nov 2019 19:10:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39281 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbfKEAKx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 4 Nov 2019 19:10:53 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRmQn-0001We-Lw; Tue, 05 Nov 2019 01:10:46 +0100
Date:   Tue, 5 Nov 2019 01:10:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Shawn Landden <shawn@git.icu>
cc:     libc-alpha@sourceware.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
In-Reply-To: <alpine.DEB.2.21.1911041423510.5102@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1911050104050.17054@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <alpine.DEB.2.21.1911041423510.5102@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 4 Nov 2019, Thomas Gleixner wrote:
> Please provide a proper design and explain how this should work together
> with existing robust list using code first.

Just for clarification:

Any change to that interface needs to be discussed with the *libc people
first. Your way of overriding the robust list interfacce with some ad hoc
solution will break existing users which is not acceptable.

So either the problem is solved with the *libc people in a way which allows
them to build upon or if your intention is solely to solve the problem
Keith described then none of this is required at all as user space can
handle the different layouts for that magic fence implementation perfectly
fine.

Thanks,

	tglx

