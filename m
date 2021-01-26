Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3024303E34
	for <lists+linux-api@lfdr.de>; Tue, 26 Jan 2021 14:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbhAZNK5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 26 Jan 2021 08:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391981AbhAZNKh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 26 Jan 2021 08:10:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 785A723109;
        Tue, 26 Jan 2021 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611666593;
        bh=ZKqmv5ySAEdjIw8FQQCkv9GpFgvu0//r1rv3d/WP07o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XTwlDzUR5YnyO9yclmVZGRKNMQnC/Y5iBHSiUXF2z8IIhUPq583aX9r6OwMzkpbX5
         o3m4zSy4UjoHO7dUZhaFv5Fz07m5oabjWYcYVN0uOJTvp6HMbyf92qLhTU9UzTERmd
         9Yr8Ibex5JHDcvkAtg8OMfi7UAbog7H4AWb/vMZCCXiXhWH6gEI97ZgURl7dXHa73e
         QFhzuOcD3RnPc66wMTEPYDFFK39QjBzZzHu7szCNPH6C/txKWZjw9fJLodry88kcyz
         EGFxt5qUH88psBifxTkZgXSkEV80Wcw05yaprXWLBIY48/TL53GNPmDQKpXJ6/ckfT
         6dJEsmygC9zsg==
Date:   Tue, 26 Jan 2021 13:09:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [PATCH v6 3/3] arm64: pac: Optimize kernel entry/exit key
 installation code paths
Message-ID: <20210126130947.GD29702@willie-the-truck>
References: <c57a23199fce831c86d830717555623942f16f6e.1609311499.git.pcc@google.com>
 <e3977b3e1b548be1d9554ccfad6c83ac87802583.1609311499.git.pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3977b3e1b548be1d9554ccfad6c83ac87802583.1609311499.git.pcc@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Dec 29, 2020 at 10:59:15PM -0800, Peter Collingbourne wrote:
> The kernel does not use any keys besides IA so we don't need to
> install IB/DA/DB/GA on kernel exit if we arrange to install them
> on task switch instead, which we can expect to happen an order of
> magnitude less often.
> 
> Furthermore we can avoid installing the user IA in the case where the
> user task has IA disabled and just leave the kernel IA installed. This
> also lets us avoid needing to install IA on kernel entry.

I've got to be honest, this makes me nervous in case there is a way for
userspace to recover the kernel key even though EnIA is clear. Currently,
EnIA doesn't affect XPAC* and PACGA instructions, and the architecture
clearly expects us to be switching these things:

  | Note
  | Keys are not banked by Exception level. Arm expects software to switch the
  | keys between Exception levels, typically by swapping the values with zero
  | so that the current key values are not present in memo

But then:

> On an Apple M1 under a hypervisor, the overhead of kernel entry/exit
> has been measured to be reduced by 15.6ns in the case where IA is
> enabled, and 31.9ns in the case where IA is disabled.

That's a good improvement, so this feels like its worth doing. I suppose all we
can do is keep an eye on the architecture in case any future extensions mean
the approach taken here is dangerous.

Will
