Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC9DCA9A3
	for <lists+linux-api@lfdr.de>; Thu,  3 Oct 2019 19:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387711AbfJCQpp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Oct 2019 12:45:45 -0400
Received: from ms.lwn.net ([45.79.88.28]:33128 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730740AbfJCQpo (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 3 Oct 2019 12:45:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 979E2300
        for <linux-api@vger.kernel.org>; Thu,  3 Oct 2019 16:45:43 +0000 (UTC)
Date:   Thu, 3 Oct 2019 10:39:31 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
        Christian Brauner <christian@brauner.io>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alessia Mantegazza <amantegazza@vaga.pv.it>,
        Guillaume Dore <corwin@poussif.eu>, linux-doc@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>, linux-abi@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>
Message-ID: <20191003103931.52683cb6@lwn.net>
In-Reply-To: <20191002151437.5367-1-christian.brauner@ubuntu.com>
References: <20191002151437.5367-1-christian.brauner@ubuntu.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Documentation: update about adding syscalls
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[Expanding CC a bit; this is the sort of change I'm reluctant to take
without being sure it reflects what the community thinks.]

On Wed,  2 Oct 2019 17:14:37 +0200
Christian Brauner <christian.brauner@ubuntu.com> wrote:

> Add additional information on how to ensure that syscalls with structure
> arguments are extensible and add a section about naming conventions to
> follow when adding revised versions of already existing syscalls.
> 
> Co-Developed-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  Documentation/process/adding-syscalls.rst | 82 +++++++++++++++++++----
>  1 file changed, 70 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
> index 1c3a840d06b9..93e0221fbb9a 100644
> --- a/Documentation/process/adding-syscalls.rst
> +++ b/Documentation/process/adding-syscalls.rst
> @@ -79,7 +79,7 @@ flags, and reject the system call (with ``EINVAL``) if it does::
>  For more sophisticated system calls that involve a larger number of arguments,
>  it's preferred to encapsulate the majority of the arguments into a structure
>  that is passed in by pointer.  Such a structure can cope with future extension
> -by including a size argument in the structure::
> +by either including a size argument in the structure::
>  
>      struct xyzzy_params {
>          u32 size; /* userspace sets p->size = sizeof(struct xyzzy_params) */
> @@ -87,20 +87,56 @@ by including a size argument in the structure::
>          u64 param_2;
>          u64 param_3;
>      };
> +    int sys_xyzzy(struct xyzzy_params __user *uarg);
> +    /* in case of -E2BIG, p->size is set to the in-kernel size and thus all
> +       extensions after that offset are unsupported. */

That comment kind of threw me for a loop - this is the first mention of
E2BIG and readers may not just know what's being talked about.  Especially
since the comment suggests *not* actually returning an error.

> -As long as any subsequently added field, say ``param_4``, is designed so that a
> -zero value gives the previous behaviour, then this allows both directions of
> -version mismatch:
> +or by including a separate argument that specifies the size::
>  
> - - To cope with a later userspace program calling an older kernel, the kernel
> -   code should check that any memory beyond the size of the structure that it
> -   expects is zero (effectively checking that ``param_4 == 0``).
> - - To cope with an older userspace program calling a newer kernel, the kernel
> -   code can zero-extend a smaller instance of the structure (effectively
> -   setting ``param_4 = 0``).
> +    struct xyzzy_params {
> +        u32 param_1;
> +        u64 param_2;
> +        u64 param_3;
> +    };
> +    /* userspace sets @usize = sizeof(struct xyzzy_params) */
> +    int sys_xyzzy(struct xyzzy_params __user *uarg, size_t usize);
> +    /* in case of -E2BIG, userspace has to attempt smaller @usize values
> +       to figure out which extensions are unsupported. */

Here too.  But what I'm really wondering about now is: you're describing
different behavior for what are essentially two cases of the same thing.
Why should the kernel simply accept the smaller size if the size is
embedded in the structure itself, but return an error and force user space
to retry if it's a separate argument?

I guess maybe because in the latter case the kernel can't easily return
the size it's actually using?  I think that should be explicit if so.

Thanks,

jon

[Rest left untrimmed for context]

> +Which model you choose to use is down to personal taste. However, please only
> +pick one (for a counter-example, see :manpage:`sched_getattr(2)`).
> +
> +Then, any extensions can be implemented by appending fields to the structure.
> +However, all new fields must be designed such that their zero value results in
> +identical behaviour to the pre-extension syscall. This allows for compatibility
> +between different-vintage kernels and userspace, no matter which is newer:
> +
> + - If the userspace is newer, then the older kernel can check whether the
> +   fields it doesn't understand are zero-valued. If they are, then it can
> +   safely ignore them (since any future extensions will be backwards-compatible
> +   as described above). If they aren't, then the kernel doesn't support the
> +   feature and can give an error (``-E2BIG`` is traditional).
> +
> + - If the userspace is older, then the kernel can treat all extensions that
> +   userspace is unaware of as having their zero-value (and effectively
> +   zero-extend the userspace structure when copying it for in-kernel usage).
>  
> -See :manpage:`perf_event_open(2)` and the ``perf_copy_attr()`` function (in
> -``kernel/events/core.c``) for an example of this approach.
> + - If they're the same version, just use the structure as-is.
> +
> +As with the simpler flag-only syscalls, you must always check that any unknown
> +values for flag-like parameters in the passed structure are zeroed.
> +
> +It is also critical to ensure your syscall handles larger-sized arguments from
> +the outset, otherwise userspace will have to do additional (fairly pointless)
> +fallbacks for some old kernels. An example where this mistake was made is
> +:manpage:`rt_sigprocmask(2)` (where any unknown-sized arguments are
> +unconditionally rejected).
> +
> +To help implement this correctly, there is a helper function
> +``copy_struct_from_user()`` which handles the compatibility requirements for
> +you. For examples using this helper, see :manpage:`perf_event_open(2)` (which
> +uses the embedded-size model) and :manpage:`clone3(2)` (which uses the
> +separate-argument model).
>  
>  
>  Designing the API: Other Considerations
> @@ -173,6 +209,28 @@ registers.  (This concern does not apply if the arguments are part of a
>  structure that's passed in by pointer.)
>  
>  
> +Designing the API: Revisions of syscalls
> +-----------------------------------------------
> +
> +Syscalls that were not designed to be extensible or syscalls that use a flag
> +argument for extensions running out of bits (e.g. :manpage:`clone(2)`)
> +sometimes need to be replaced.
> +
> +If the revised syscall provides a superset (or a reasonably large subset, such
> +as when a feature that turned out to be a design mistake is dropped) of the
> +features of the old syscall it is common practice to give it the same name with
> +a number appended. Examples for this include ``dup2``/``dup3``,
> +``epoll_create``/``epoll_create1`` and others.
> +
> +For some syscalls the appended number indicates the number of arguments
> +(``accept``/``accept4``) for others the number of the revision
> +(``clone``/``clone3``, ``epoll_create``/``epoll_create1``). Recent discussions
> +around new syscalls (such as ``clone3``) have pointed to a consensus around
> +naming syscalls revisions by appending the number of the revision to the
> +syscall name. That means, if you were to post a revised version of the
> +``openat`` syscall it should be named ``openat2``.
> +
> +
>  Proposing the API
>  -----------------
>  
