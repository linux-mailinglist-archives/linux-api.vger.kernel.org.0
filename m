Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2635422C653
	for <lists+linux-api@lfdr.de>; Fri, 24 Jul 2020 15:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgGXNZO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 24 Jul 2020 09:25:14 -0400
Received: from ozlabs.org ([203.11.71.1]:44633 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXNZO (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 24 Jul 2020 09:25:14 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgq46Hrz9sTd; Fri, 24 Jul 2020 23:25:11 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Cc:     kvm-ppc@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org
In-Reply-To: <20200703011958.1166620-1-npiggin@gmail.com>
References: <20200703011958.1166620-1-npiggin@gmail.com>
Subject: Re: [PATCH v2 0/3] remove PROT_SAO support and disable
Message-Id: <159559696901.1657499.15799900734438878764.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:25:11 +1000 (AEST)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 3 Jul 2020 11:19:55 +1000, Nicholas Piggin wrote:
> It was suggested that I post this to a wider audience on account of
> the change to supported userspace features in patch 2 particularly.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (3):
>   powerpc: remove stale calc_vm_prot_bits comment
>   powerpc/64s: remove PROT_SAO support
>   powerpc/64s/hash: disable subpage_prot syscall by default
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc: Remove stale calc_vm_prot_bits() comment
      https://git.kernel.org/powerpc/c/f4ac1774f2cba44994ce9ac0a65772e4656ac2df
[2/3] powerpc/64s: Remove PROT_SAO support
      https://git.kernel.org/powerpc/c/5c9fa16e8abd342ce04dc830c1ebb2a03abf6c05
[3/3] powerpc/64s/hash: Disable subpage_prot syscall by default
      https://git.kernel.org/powerpc/c/63396ada804c676e070bd1b8663046f18698ab27

cheers
