Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 395B71F6F1C
	for <lists+linux-api@lfdr.de>; Thu, 11 Jun 2020 23:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgFKVCx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 Jun 2020 17:02:53 -0400
Received: from gate.crashing.org ([63.228.1.57]:52027 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKVCx (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 11 Jun 2020 17:02:53 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 05BL2WSL021038;
        Thu, 11 Jun 2020 16:02:32 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 05BL2UHa021034;
        Thu, 11 Jun 2020 16:02:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 11 Jun 2020 16:02:30 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, libc-dev@lists.llvm.org,
        musl@lists.openwall.com, linux-api@vger.kernel.org
Subject: Re: Linux powerpc new system call instruction and ABI
Message-ID: <20200611210230.GH31009@gate.crashing.org>
References: <20200611081203.995112-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611081203.995112-1-npiggin@gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi!

On Thu, Jun 11, 2020 at 06:12:01PM +1000, Nicholas Piggin wrote:
> Calling convention
> ------------------
> The proposal is for scv 0 to provide the standard Linux system call ABI 
> with the following differences from sc convention[1]:
> 
> - lr is to be volatile across scv calls. This is necessary because the 
>   scv instruction clobbers lr. From previous discussion, this should be 
>   possible to deal with in GCC clobbers and CFI.
> 
> - cr1 and cr5-cr7 are volatile. This matches the C ABI and would allow the
>   kernel system call exit to avoid restoring the volatile cr registers
>   (although we probably still would anyway to avoid information leaks).
> 
> - Error handling: The consensus among kernel, glibc, and musl is to move to
>   using negative return values in r3 rather than CR0[SO]=1 to indicate error,
>   which matches most other architectures, and is closer to a function call.

What about cr0 then?  Will it be volatile as well (exactly like for
function calls)?

> Notes
> -----
> - r0,r4-r8 are documented as volatile in the ABI, but the kernel patch as
>   submitted currently preserves them. This is to leave room for deciding
>   which way to go with these.

The kernel has to set it to *something* that doesn't leak information ;-)


Segher
