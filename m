Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2D6EFA4C
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 10:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfKEJ7b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 04:59:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730454AbfKEJ7b (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 04:59:31 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iRvcS-0000Cb-W3; Tue, 05 Nov 2019 10:59:25 +0100
Date:   Tue, 5 Nov 2019 10:59:24 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Florian Weimer <fweimer@redhat.com>
cc:     Shawn Landden <shawn@git.icu>, libc-alpha@sourceware.org,
        linux-api@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Keith Packard <keithp@keithp.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v2 PATCH] futex: extend set_robust_list to allow 2 locking
 ABIs at the same time.
In-Reply-To: <87woceslfs.fsf@oldenburg2.str.redhat.com>
Message-ID: <alpine.DEB.2.21.1911051053470.17054@nanos.tec.linutronix.de>
References: <20191104002909.25783-1-shawn@git.icu> <87woceslfs.fsf@oldenburg2.str.redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, 5 Nov 2019, Florian Weimer wrote:
> * Shawn Landden:
> > If this new ABI is used, then bit 1 of the *next pointer of the
> > user-space robust_list indicates that the futex_offset2 value should
> > be used in place of the existing futex_offset.
> 
> The futex interface currently has some races which can only be fixed by
> API changes.  I'm concerned that we sacrifice the last bit for some
> rather obscure feature.  What if we need that bit for fixing the
> correctness issues?

That current approach is going nowhere and if we change the ABI ever then
this needs to happen with all *libc folks involved and agreeing.

Out of curiosity, what's the race issue vs. robust list which you are
trying to solve?

Thanks,

	tglx
