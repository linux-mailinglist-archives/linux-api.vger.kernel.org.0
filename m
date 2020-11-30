Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D592C845F
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 13:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgK3Mwh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 07:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgK3Mwh (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 30 Nov 2020 07:52:37 -0500
Received: from gaia (unknown [95.146.230.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2055820691;
        Mon, 30 Nov 2020 12:51:53 +0000 (UTC)
Date:   Mon, 30 Nov 2020 12:51:51 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Florian Weimer <fw@deneb.enyo.de>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>
Subject: Re: [PATCH v4 1/2] arm64: mte: make the per-task SCTLR_EL1 field
 usable elsewhere
Message-ID: <20201130125151.GD3902@gaia>
References: <b584bf342a38580daa7aa73eda72184e9453a5e4.1605842067.git.pcc@google.com>
 <160650438443.22092.12368244632759393865.b4-ty@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160650438443.22092.12368244632759393865.b4-ty@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Peter,

On Fri, Nov 27, 2020 at 07:13:43PM +0000, Catalin Marinas wrote:
> On Thu, 19 Nov 2020 19:29:46 -0800, Peter Collingbourne wrote:
> > In an upcoming change we are going to introduce per-task SCTLR_EL1
> > bits for PAC. Move the existing per-task SCTLR_EL1 field out of the
> > MTE-specific code so that we will be able to use it from both the
> > PAC and MTE code paths and make the task switching code more efficient.
> 
> Applied to arm64 (for-next/pac-keys-ctrl), thanks!
> 
> [1/2] arm64: mte: make the per-task SCTLR_EL1 field usable elsewhere
>       https://git.kernel.org/arm64/c/e710c29e0177
> [2/2] arm64: Introduce prctl(PR_PAC_{SET,GET}_ENABLED_KEYS)
>       https://git.kernel.org/arm64/c/284c64e9eba3
> 
> If Dave has any other comments next week, we can apply them on top.

I'm dropping these patches from the arm64 tree as they conflict
(and not in a trivial way) with the MTE patches queued in the mm tree.

So we either wait until 5.12 or we try to merge them via Andrew on top
of the mm tree. Given the interaction with MTE, I'm slightly inclined
towards the former.

-- 
Catalin
