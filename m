Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8162C25A9
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 13:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbgKXM0n (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 07:26:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:52243 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgKXM0n (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 07:26:43 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1khXP6-0004Kf-77; Tue, 24 Nov 2020 12:26:40 +0000
Date:   Tue, 24 Nov 2020 13:26:39 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dev@opencontainers.org,
        corbet@lwn.net, Carlos O'Donell <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
Message-ID: <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 24, 2020 at 01:08:20PM +0100, Florian Weimer wrote:
> This documents a way to safely use new security-related system calls
> while preserving compatibility with container runtimes that require
> insecure emulation (because they filter the system call by default).
> Admittedly, it is somewhat hackish, but it can be implemented by
> userspace today, for existing system calls such as faccessat2,
> without kernel or container runtime changes.
> 
> Signed-off-by: Florian Weimer <fweimer@redhat.com>
> 
> ---
>  Documentation/process/adding-syscalls.rst | 37 +++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> index a3ecb236576c..7d1e578a1df1 100644
> --- a/Documentation/process/adding-syscalls.rst
> +++ b/Documentation/process/adding-syscalls.rst
> @@ -436,6 +436,40 @@ simulates registers etc).  Fixing this is as simple as adding a #define to
>  
>      #define stub_xyzzy sys_xyzzy
>  
> +Container Compatibility and seccomp
> +-----------------------------------
> +
> +The Linux Foundation Open Container Initiative Runtime Specification
> +requires that by default, implementations install seccomp system call
> +filters which cause system calls to fail with ``EPERM``.  As a result,
> +all new system calls in such containers fail with ``EPERM`` instead of
> +``ENOSYS``.  This design is problematic because ``EPERM`` is a
> +legitimate system call result which should not trigger fallback to a
> +userspace emulation, particularly for security-related system calls.
> +(With ``ENOSYS``, it is clear that a fallback implementation has to be
> +used to maintain compatibility with older kernels or container
> +runtimes.)
> +
> +New system calls should therefore provide a way to reliably trigger an
> +error distinct from ``EPERM``, without any side effects.  Some ways to
> +achieve that are:
> +
> + - ``EBADFD`` for the invalid file descriptor -1
> + - ``EFAULT`` for a null pointer
> + - ``EINVAL`` for a contradictory set of flags that will remain invalid
> +   in the future

I'm sorry but I have some doubts about this new "rule". The idea of
being able to reliably trigger an error for a system call other then
EPERM might have merrit in some scenarios but justifying it via a bug in
a userspace standard is not enough in my opinion.

The solution is to fix the standard to mandate ENOSYS. This is the
correct error for this exact scenario and standards can be changed.
I don't think it is the kernel's job to work around a deliberate
userspace decision to use EPERM and not ENOSYS. The kernel's system call
design should not be informed by this especially since this is clearly
not a kernel bug.

Apart from that I have doubts that this is in any shape or form
enforceable. Not just because in principle there might be system calls
that only return EPERM on error but also because this requirement feels
arbitrary and I doubt developers will feel bound by it or people will
check for it.

> +
> +If a system call has such error behavior, upon encountering an
> +``EPERM`` error, userspace applications can perform further
> +invocations of the same system call to check if the ``EPERM`` error
> +persists for those known error conditions.  If those also fail with
> +``EPERM``, that likely means that the original ``EPERM`` error was the
> +result of a seccomp filter, and should be treated like ``ENOSYS``

I think that this "approach" alone should illustrate that this is the
wrong way to approach this. It's hacky and requires excercising a system
call multiple times just to find out whether or not it is supported.
The only application that would possibly do this is probably glibc.
This seems to be the complete wrong way of solving this problem.

> +(e.g., trigger an alternative fallback implementation).  If those
> +probing system calls do not fail with ``EPERM``, the error likely came
> +from a real implementation, and should be reported to the caller
> +directly, without resorting to ``ENOSYS``-style fallback.
> +
>  
>  Other Details
>  -------------
> @@ -575,3 +609,6 @@ References and Sources
>   - Recommendation from Linus Torvalds that x32 system calls should prefer
>     compatibility with 64-bit versions rather than 32-bit versions:
>     https://lkml.org/lkml/2011/8/31/244
> + - Linux Configuration section of the Open Container Initiative
> +   Runtime Specification:
> +   https://github.com/opencontainers/runtime-spec/blob/master/config-linux.md
> 
> -- 
> Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
> Commercial register: Amtsgericht Muenchen, HRB 153243,
> Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'Neill
> 
