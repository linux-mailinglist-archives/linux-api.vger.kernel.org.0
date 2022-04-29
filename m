Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3F5151C6
	for <lists+linux-api@lfdr.de>; Fri, 29 Apr 2022 19:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbiD2R1x (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 29 Apr 2022 13:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiD2R1x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 29 Apr 2022 13:27:53 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 29 Apr 2022 10:24:33 PDT
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [216.12.86.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC00969299
        for <linux-api@vger.kernel.org>; Fri, 29 Apr 2022 10:24:33 -0700 (PDT)
Date:   Fri, 29 Apr 2022 13:09:29 -0400
From:   Rich Felker <dalias@libc.org>
To:     linux-api@vger.kernel.org
Subject: COMPAT_32BIT_TIME and allnoconfig: breaking userspace
Message-ID: <20220429170923.GA14233@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I just ran across another instance of breakage from allnoconfig
setting COMPAT_32BIT_TIME to no:

https://github.com/esnet/iperf/issues/1326

This option inherently breaks the cardinal rule of "Don't break
userspace", and as I understand it was initially justified as being
configurable for the sake of "testing that a system is time64 ready"
rather than as a viable production option. But it was never documented
in the Kconfig text as breaking userspace or put behind EXPERT or
anything that would prevent inadvertently turning it off, and of
course allnoconfig turns it off.

I'm told (?) that some people want to break userspace here, removing
the old syscalls after 2038 or maybe even before. That should not
happen. Not only is it an unjustified violation of syscall stability
policy; it's not even well-motivated. The vast majority of these
syscalls take relative timeouts and did not even need time64 versions
added. Removing them will not only break binaries which are not
time64-ready, but also old binaries which do not care about time at
all, as well as all current binaries built on musl libc, as we use
these syscalls (per the syscall stability policy) even in >=1.2.0
which is fully time64.

Quoting from the above bug tracker thread:

> musl supports all kernels back to the earliest one the arch was
> added in or 2.6.0, whichever came later. And it has always depended
> on the kernel ABI stability policy ("don't break userspace" - Linus)
> as the principle on which it makes this work. That is, we always use
> the oldest syscall that can achieve the operation requested.

> In theory we could do things the other way around, trying the newer
> one first and falling back, but that would put a performance hit on
> older systems and most of the time it doesn't even have any
> usefulness - for example, the timeout passed to select is relative,
> so unless you're trying to wait 70 years (in which case we do
> perform the time64 syscall and error if it's not available) the old
> syscall is perfectly acceptable. For operations where it can't be
> known in advance whether the time fits in 32 bits - for example,
> stat, clock_gettime, etc. - we do have to try the time64 one first.
> (Note that vdso, where present, greatly reduces the cost of having
> to do that for clock_gettime.)

I would like to propose making the ability to disable
COMPAT_32BIT_TIME depend on EXPERT, and documenting in the Kconfig
description that it breaks userspace. I will send a separate patch to
that effect.

If folks are strongly opposed to this, can you please clarify why it's
okay to break userspace here but not in other places, especially in
light of the fact that were are already (and have been for over 2
years, so there are plenty of binaries in the wild) using these
syscalls successfully in fully-time64-ready binaries.

Rich
