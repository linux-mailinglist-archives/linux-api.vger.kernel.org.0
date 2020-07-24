Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD4E22C64D
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 15:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGXNZL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jul 2020 09:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgGXNZL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 24 Jul 2020 09:25:11 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293F9C0619D3
        for <linux-api@vger.kernel.org>; Fri, 24 Jul 2020 06:25:11 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgn2rX1z9sV6; Fri, 24 Jul 2020 23:25:08 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Cc:     musl@lists.openwall.com, linux-api@vger.kernel.org,
        libc-dev@lists.llvm.org
In-Reply-To: <20200611081203.995112-2-npiggin@gmail.com>
References: <20200611081203.995112-1-npiggin@gmail.com> <20200611081203.995112-2-npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/64s/exception: treat NIA below __end_interrupts as soft-masked
Message-Id: <159559697416.1657499.13017258329138347266.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:25:08 +1000 (AEST)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 11 Jun 2020 18:12:02 +1000, Nicholas Piggin wrote:
> The scv instruction causes an interrupt which can enter the kernel with
> MSR[EE]=1, thus allowing interrupts to hit at any time. These must not
> be taken as normal interrupts, because they come from MSR[PR]=0 context,
> and yet the kernel stack is not yet set up and r13 is not set to the
> PACA).
> 
> Treat this as a soft-masked interrupt regardless of the soft masked
> state. This does not affect behaviour yet, because currently all
> interrupts are taken with MSR[EE]=0.

Applied to powerpc/next.

[1/2] powerpc/64s/exception: treat NIA below __end_interrupts as soft-masked
      https://git.kernel.org/powerpc/c/b2dc2977cba48990df45e0a96150663d4f342700
[2/2] powerpc/64s: system call support for scv/rfscv instructions
      https://git.kernel.org/powerpc/c/7fa95f9adaee7e5cbb195d3359741120829e488b

cheers
