Return-Path: <linux-api+bounces-6003-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC31HKM/umlqTQIAu9opvQ
	(envelope-from <linux-api+bounces-6003-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 07:01:07 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D4EB02B6186
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 07:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2FA8302B830
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 06:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF6729C33F;
	Wed, 18 Mar 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8v+oRE3"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A760B27456;
	Wed, 18 Mar 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773813664; cv=none; b=YtJ7oRzpnfW5REsz1vESjqrgYVWcmb5Sj85lJKgJhQiGQnyylEJa8Urr8Opw9JbLpwczITO95Ad15+nM7RIrNuCn6msP2ptQwgzccVXIyv4SSy/H+HSSPi9otvs13VSDTeO8XZQdhZWWc2mUz/rEwbRUImQ4Yb8TiGvXFVvslJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773813664; c=relaxed/simple;
	bh=rMROIzV9bRqUzrcYakjh5WuCieIdwd/xKsodgkFDVNI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYBiK3ddZ84xLpjbIpHoqVkceWzvxq7hLJoKNlYbroDsR+/bWvmhT8RzCWXZ8pBWYLvvCbe+fk0HfIwfYj1fHad7zl5PuTxOLE/Uu/YfrQ40+t+B+hQd3431ATw8YORuPCYSUz4iheFsLL6sYUUmPIZMMpg7U5bv+zPevP8/Jjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8v+oRE3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69A3C19421;
	Wed, 18 Mar 2026 06:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773813664;
	bh=rMROIzV9bRqUzrcYakjh5WuCieIdwd/xKsodgkFDVNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8v+oRE3pAOSEuTZjHr3Oh2Z90dWfnHsJQFNulFAQ7hMIthNoAunZdyZRb5sZKniy
	 ngr35Qzru8Zw228d/5ms2ZOTo/LOEvhUZeyp+dSJycdHqdCW/Sa77oJPO5geAs81vs
	 EfRIhPsBzneWimQ5B3/iCgflUbUgW2eLJlTTE+odf0kly6dVlRdUF7wQIdsLiGWSJl
	 QoqCMBaYVBMENWG/+wnRZZXCx3IkGynxtsV8sCiC28Zjau3gQjWUz4/yRNcEsfy7Lu
	 4Cm8GfYHzT0DBh9bG3TcCcjDLflUKriHcrKma2+9xwoGNxtMG+Z+NyJltTuZkGtV1U
	 V5pI5HHyzW1iw==
Date: Wed, 18 Mar 2026 07:00:55 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
 tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Vyukov <dvyukov@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, Cyril Hrubis <chrubis@suse.cz>, Kees Cook
 <kees@kernel.org>, Jake Edge <jake@lwn.net>, David Laight
 <david.laight.linux@gmail.com>, Askar Safin <safinaskar@zohomail.com>,
 Gabriele Paoloni <gpaoloni@redhat.com>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Christian Brauner <brauner@kernel.org>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann
 <arnd@arndb.de>
Subject: Re: [PATCH 1/9] kernel/api: introduce kernel API specification
 framework
Message-ID: <20260318070055.39f1af80@foz.lan>
In-Reply-To: <87h5qe9wig.fsf@trenco.lwn.net>
References: <20260313150928.2637368-1-sashal@kernel.org>
	<20260313150928.2637368-2-sashal@kernel.org>
	<87h5qe9wig.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6003-lists,linux-api=lfdr.de,huawei];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,google.com,infradead.org,suse.cz,lwn.net,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lwn.net:email]
X-Rspamd-Queue-Id: D4EB02B6186
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 11:49:27 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Sasha Levin <sashal@kernel.org> writes:
> 
> > Add a framework for formally documenting kernel APIs with inline
> > specifications. This framework provides:
> >
> > - Structured API documentation with parameter specifications, return
> >   values, error conditions, and execution context requirements
> > - Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
> > - Export of specifications via debugfs for tooling integration
> > - Support for both internal kernel APIs and system calls  
> 
> So I'll confess I have only scanned over the implementation, but I have
> some thoughts on the earlier stuff.
> 
> [...]
> 
> > diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
> > new file mode 100644
> > index 0000000000000..7c0c1694f1f4a
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kernel-api-spec.rst
> > @@ -0,0 +1,482 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +======================================
> > +Kernel API Specification Framework
> > +======================================
> > +
> > +:Author: Sasha Levin <sashal@kernel.org>
> > +:Date: June 2025  
> 
> Has it not changed since then?
> 
> > +.. contents:: Table of Contents
> > +   :depth: 3
> > +   :local:
> > +
> > +Introduction
> > +============  
> 
> [...]
> 
> > +Usage Guide
> > +===========
> > +
> > +Basic API Specification
> > +-----------------------
> > +
> > +API specifications are written as KAPI-annotated kerneldoc comments directly in
> > +the source file, immediately preceding the function implementation. The ``kapi``
> > +tool extracts these annotations to produce structured specifications.
> > +
> > +.. code-block:: c
> > +
> > +    /**
> > +     * kmalloc - allocate kernel memory
> > +     * @size: Number of bytes to allocate
> > +     * @flags: Allocation flags (GFP_*)  
> 
> Given that the text thus far has talked about user-space API validation,
> it's a bit surprising to see an internal function used as an example.
> 
> Also, maybe it should be kmalloc_obj()?  <runs away>
> 
> > +     * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SOFTIRQ | KAPI_CTX_HARDIRQ
> > +     * param-count: 2  
> 
> param-count is two, but you only document one of them?
> 
> > +     * param: size
> > +     *   type: KAPI_TYPE_UINT
> > +     *   flags: KAPI_PARAM_IN
> > +     *   constraint-type: KAPI_CONSTRAINT_RANGE
> > +     *   range: 0, KMALLOC_MAX_SIZE
> > +     *
> > +     * error: ENOMEM, Out of memory
> > +     *   desc: Insufficient memory available for the requested allocation.
> > +     */  
> 
> Honest question: can this be made a bit easier for people to create,
> with less shift-key wear?  My biggest worry with a system like this is
> that people won't take the time to create and maintain the entries, so
> anything that would ease the task would help.  Is there an impediment to
> something like:
> 
>   contexts: process, softirq, hardirq
> 
>   param: size
>     type: uint, input
>     constraint: range(0, KMALLOC_MAX_SIZE)
> 
> See what I'm getting at?  ISTM that your DSL could be made a bit less
> verbose and shouty while being just as well defined, but perhaps I'm
> missing something?
> 
> Even better, of course, would be to add a "description" field for each
> parameter, and allow that rather than the @param description that
> kerneldoc currently uses.  That would keep all the information together,
> at the minor cost of adding another significant complication to the
> kernel-doc script.  Mauro won't mind :)

No, I won't ;-) 

It sounds a lot better to use kernel-doc also for kAPI than to have an
independent tool.

It is also very confusing if we end with a kernel-doc-like format
that it is not parsed by kernel-doc.

> 
> > +    void *kmalloc(size_t size, gfp_t flags)
> > +    {
> > +        /* Implementation */
> > +    }
> > +
> > +Alternatively, specifications can be defined using the ``DEFINE_KERNEL_API_SPEC``
> > +macro for compiled-in specs that are stored in the ``.kapi_specs`` ELF section:
> > +
> > +.. code-block:: c
> > +
> > +    #include <linux/kernel_api_spec.h>
> > +
> > +    DEFINE_KERNEL_API_SPEC(sys_open)
> > +    KAPI_DESCRIPTION("Open or create a file")
> > +    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
> > +    /* ... parameter, error, constraint definitions ... */
> > +    KAPI_END_SPEC  
> 
> So the reason for two completely separate mechanisms is not entirely
> clear to me.  The kerneldoc variant is essentially documentation, while
> the macro stuff is to be built into the executable?  What if you want
> both?

You can easily add support at kernel-doc to output such macros.

All you need is to create a new class derived from OutputFormat and
make it produce any different output format, including:

    #include <linux/kernel_api_spec.h>

    DEFINE_KERNEL_API_SPEC(sys_open)
    KAPI_DESCRIPTION("Open or create a file")
    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
    /* ... parameter, error, constraint definitions ... */
    KAPI_END_SPEC  

I'd say that converting from such output to `.kapi_specs`` ELF section
itself and/or to sysfs/debugfs - e.g. something that would require to
compile or be linked with Kernel's compiled binaries should be done by a
separate tool, but we should aim to have a singe tool to process 
kernel documentation markups.

It is hard enough to maintain just one tool - and to have people actually
writing documentation. Having a second one to handle it, with a different
format will likely increase a lot the documentation burden.

> It would be nice to only have one way if at all possible; I'm sure that
> crossed your mind at some point :)  If there have to be two, having both
> examples describe the same function would make the parallels more clear.
> 
> > +System Call Specification
> > +-------------------------
> > +
> > +System calls are documented inline in the implementation file (e.g., ``fs/open.c``)
> > +using KAPI-annotated kerneldoc comments. When ``CONFIG_KAPI_RUNTIME_CHECKS`` is
> > +enabled, the ``SYSCALL_DEFINEx`` macros automatically look up the specification
> > +and validate parameters before and after the syscall executes.
> > +
> > +IOCTL Specification
> > +-------------------
> > +
> > +IOCTLs use the same annotation approach with additional structure field
> > +specifications  
> 
> This might be a really good place for an example
> 
> [...]
> 
> > +Usage Examples
> > +--------------
> > +
> > +Query specific API::
> > +
> > +    $ cat /sys/kernel/debug/kapi/apis/kmalloc/specification
> > +    API: kmalloc
> > +    Version: 3.0
> > +    Description: Allocate kernel memory
> > +
> > +    Parameters:
> > +      [0] size (size_t, in): Number of bytes to allocate
> > +          Range: 0 - 4194304
> > +      [1] flags (flags, in): Allocation flags (GFP_*)
> > +          Mask: 0x1ffffff  
> 
> Ah, you do document that second parameter somewhere :)
> 
> > +    Returns: pointer - Pointer to allocated memory or NULL
> > +
> > +    Errors:
> > +      ENOMEM: Out of memory
> > +
> > +    Context: process, softirq, hardirq
> > +
> > +    Side Effects:
> > +      - Allocates memory from kernel heap  
> 
> That part wasn't in your example
> 
> > +Export all specifications::
> > +
> > +    $ cat /sys/kernel/debug/kapi/export/all.json > kernel-apis.json
> > +
> > +Enable validation for specific API::
> > +
> > +    $ echo 1 > /sys/kernel/debug/kapi/apis/kmalloc/validate
> > +
> > +Performance Considerations
> > +==========================
> > +
> > +Memory Overhead
> > +---------------
> > +
> > +Each API specification consumes approximately 400-450KB of memory due to the
> > +fixed-size arrays in ``struct kernel_api_spec``. With the current 4 syscall
> > +specifications, total memory usage is approximately 1.7MB. Consider:  
> 
> Ouch.
> 
> > +Documentation Generation
> > +------------------------
> > +
> > +The framework exports specifications via debugfs that can be used
> > +to generate documentation. Tools for automatic documentation generation
> > +from specifications are planned for future development.  
> 
> Documentation always comes last :)
> 
> Interesting stuff.
> 
> jon



Thanks,
Mauro

