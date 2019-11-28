Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69F510C93D
	for <lists+linux-api@lfdr.de>; Thu, 28 Nov 2019 14:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfK1NIx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 28 Nov 2019 08:08:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:43183 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfK1NIx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 28 Nov 2019 08:08:53 -0500
Received: from [189.110.51.181] (helo=calabresa)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1iaJXM-0000HX-6o; Thu, 28 Nov 2019 13:08:48 +0000
Date:   Thu, 28 Nov 2019 10:08:40 -0300
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched_getattr.2: update to include changed size semantics
Message-ID: <20191128130840.GA3719@calabresa>
References: <20191128120140.20367-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191128120140.20367-1-cyphar@cyphar.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 28, 2019 at 11:01:40PM +1100, Aleksa Sarai wrote:
> Due to a userspace breakage, commit 1251201c0d34 ("sched/core: Fix
> uclamp ABI bug, clean up and robustify sched_read_attr() ABI logic and
> code") changed the semantics of sched_getattr(2) when the userspace
> struct is smaller than the kernel struct. Now, any trailing non-zero
> data in the kernel structure is ignored when copying to userspace.
> 
> Ref: 1251201c0d34 ("sched/core: Fix uclamp ABI bug, clean up and
>                     robustify sched_read_attr() ABI logic and code")
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  man2/sched_setattr.2 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/man2/sched_setattr.2 b/man2/sched_setattr.2
> index 76ffa14eba85..fbb67b8eb98b 100644
> --- a/man2/sched_setattr.2
> +++ b/man2/sched_setattr.2
> @@ -284,10 +284,8 @@ structure,
>  the additional bytes in the user-space structure are not touched.
>  If the caller-provided structure is smaller than the kernel
>  .I sched_attr
> -structure and the kernel needs to return values outside the provided space,
> -.BR sched_getattr ()
> -fails with the error
> -.BR E2BIG .
> +structure, the kernel will silently not return any values which would be stored
> +outside the provided space.
>  As with
>  .BR sched_setattr (),
>  these semantics allow for future extensibility of the interface.
> -- 
> 2.24.0
> 

I was thinking about documenting the difference in behavior of older kernels,
before uclamp support.

However, in practice, for sched_getattr, the kernel never returned E2BIG (the
code uses EFBIG incorrectly, in fact). It does, however, return EINVAL for
sizes smaller than SCHED_ATTR_SIZE_VER0.

The EINVAL return is already well documented in the manpage.

However, E2BIG is still mentioned below as a possible return value for
sched_getattr. Can you remove that too?

Thanks.
Cascardo.
