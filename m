Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5122A6C09
	for <lists+linux-api@lfdr.de>; Wed,  4 Nov 2020 18:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgKDRp6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 4 Nov 2020 12:45:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731956AbgKDRp6 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 4 Nov 2020 12:45:58 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B2CF206F1;
        Wed,  4 Nov 2020 17:45:53 +0000 (UTC)
Date:   Wed, 4 Nov 2020 17:45:50 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Linux API <linux-api@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        David Spickett <david.spickett@linaro.org>
Subject: Re: [PATCH v13 8/8] arm64: expose FAR_EL1 tag bits in siginfo
Message-ID: <20201104174549.GG28902@gaia>
References: <cover.1604376407.git.pcc@google.com>
 <c8a229473591a7bf98dc79e92403fe2de854ffef.1604376407.git.pcc@google.com>
 <20201103183321.GB81026@C02TF0J2HF1T.local>
 <CAMn1gO4q-7dEnCeF-PaL6K48jcpV-sJwnOSbT6JdL9NAd0XBWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMn1gO4q-7dEnCeF-PaL6K48jcpV-sJwnOSbT6JdL9NAd0XBWA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 03, 2020 at 11:16:53AM -0800, Peter Collingbourne wrote:
> On Tue, Nov 3, 2020 at 10:33 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > That said, I wonder whether we could solve this for MTE without new
> > fields by always setting the tag in si_addr when si_code is SEGV_MTE*.
> 
> This wouldn't solve the problem for MTE in the case where there is a
> non-linear buffer overflow that extends into an unmapped page, in
> which case we would get a SEGV_MAPERR that we would still need the tag
> bits for.

What I was thinking of is to only present the tags for SEGV_MTE* faults
(tag check faults). Is the tag relevant for a SEGV_MAPERR fault?

> > Alternatively, we could add a prctl() bit to require tagged si_addr.
> 
> It's an option that we considered but I would be concerned about the
> compatibility implications of this. In practice, on Android we would
> always have this bit set, so applications would be exposed to the tag
> bits in si_addr. If applications have previously relied on the
> documented behavior that the tag bits are unset, they may get confused
> by them now being set. It also wouldn't provide a way for the kernel
> to communicate which tag bits are valid.

It depends what you mean by application. If the MTE enabling and signal
handling is done from zygote, I suspect the rest of the app won't
install its own signal handlers, so they can't get confused.

For standard Linux processes and glibc, the feature wouldn't be enabled
by default even if MTE was turned on (we'd add a new prctl() bit).

Anyway, I'm not saying we should go for this approach, just making sure
that we explored all the options (sorry, should have read the previous
12 series ;)).

-- 
Catalin
