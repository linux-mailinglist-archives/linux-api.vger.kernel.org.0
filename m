Return-Path: <linux-api+bounces-6008-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8AdYMvu2umlWawIAu9opvQ
	(envelope-from <linux-api+bounces-6008-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:30:19 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0C52BD271
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 15:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10E9D300B46B
	for <lists+linux-api@lfdr.de>; Wed, 18 Mar 2026 14:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C413DA5D5;
	Wed, 18 Mar 2026 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsJE6zz/"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F143DA5CC;
	Wed, 18 Mar 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773844214; cv=none; b=tQ66Ha2Gn/wnProt+0IJzV2KjOKFsAvwIIPbgwnzTjYvsgz9bfgsuerfF4NzG6pB3jmDNDceFXtqvbxM8KoUJ+VeP4T1qZAiSQBlF+R7trUvh05WTaqyZA7poRITFLWh5TDiKOiy8QUC/Ffrc0qU0q8HDeNFovxva0WfCqk8PKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773844214; c=relaxed/simple;
	bh=dI7KeCr81zxDIIpby5KUGoKhn74IYeTV9jPqj5maCUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzSzRffzNYdJIW8BQA1YtWqqCHiLYFf4OOrKIQk1wSJNxnYPO5Jv+mwV3n/RfAOOBMg9AoAt2woYXat5UZBLEQKjd+6fl6+8lrRfGnSay2jYr/TppNCygPj25aIEwX/PhB/O/cgZvEhF/UVgtuLTb9Qx9h452vf5PzUjv4QSVSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsJE6zz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A869C19421;
	Wed, 18 Mar 2026 14:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773844213;
	bh=dI7KeCr81zxDIIpby5KUGoKhn74IYeTV9jPqj5maCUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HsJE6zz/2lf8DPOcAOq0kqaGQXEanfNpeMschN9d3SeQvg7+8n7pOQiO8Gse+J9bA
	 4O7ZYfZv4dHQq18VGnCvy7bC+1Ky41pMsxkI488I1o+Q2eiNJJC36XTYBiS7JcqQof
	 IIGogBAvccHbkV9su6Rc8O9kZEtvGO4VOTeL8YggWWUfmR2koFBX7ZN70Xp2W7KDWT
	 rlviCSZZwoTR3HiW9wPdNBy5sUL04iGC+Z9sJ7STChBPg+UcANnC0Bke2WthDYT7ro
	 XAs11fi8zxc+Q1pzixVB5Ht3o/EN260ZVHAz6eAFCa50N8lKvghR7pfKGYDgOjrnoQ
	 SXAUq1DU3C1Nw==
Date: Wed, 18 Mar 2026 10:30:12 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>, Kees Cook <kees@kernel.org>,
	Jake Edge <jake@lwn.net>,
	David Laight <david.laight.linux@gmail.com>,
	Askar Safin <safinaskar@zohomail.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/9] kernel/api: introduce kernel API specification
 framework
Message-ID: <abq29NMpyXJrqv_7@laps>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-2-sashal@kernel.org>
 <87h5qe9wig.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87h5qe9wig.fsf@trenco.lwn.net>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6008-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,google.com,infradead.org,suse.cz,lwn.net,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.932];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5E0C52BD271
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 11:49:27AM -0600, Jonathan Corbet wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
>> Add a framework for formally documenting kernel APIs with inline
>> specifications. This framework provides:
>>
>> - Structured API documentation with parameter specifications, return
>>   values, error conditions, and execution context requirements
>> - Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
>> - Export of specifications via debugfs for tooling integration
>> - Support for both internal kernel APIs and system calls
>
>So I'll confess I have only scanned over the implementation, but I have
>some thoughts on the earlier stuff.
>
>[...]
>
>> diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
>> new file mode 100644
>> index 0000000000000..7c0c1694f1f4a
>> --- /dev/null
>> +++ b/Documentation/dev-tools/kernel-api-spec.rst
>> @@ -0,0 +1,482 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======================================
>> +Kernel API Specification Framework
>> +======================================
>> +
>> +:Author: Sasha Levin <sashal@kernel.org>
>> +:Date: June 2025
>
>Has it not changed since then?
>
>> +.. contents:: Table of Contents
>> +   :depth: 3
>> +   :local:
>> +
>> +Introduction
>> +============
>
>[...]
>
>> +Usage Guide
>> +===========
>> +
>> +Basic API Specification
>> +-----------------------
>> +
>> +API specifications are written as KAPI-annotated kerneldoc comments directly in
>> +the source file, immediately preceding the function implementation. The ``kapi``
>> +tool extracts these annotations to produce structured specifications.
>> +
>> +.. code-block:: c
>> +
>> +    /**
>> +     * kmalloc - allocate kernel memory
>> +     * @size: Number of bytes to allocate
>> +     * @flags: Allocation flags (GFP_*)
>
>Given that the text thus far has talked about user-space API validation,
>it's a bit surprising to see an internal function used as an example.

Indeed :)

I was playing with adding specs to lower level functions as a way to both
simplify the higher level spec blocks, but also to help validate the
correctness of those upper level specs ("you said that this syscall doesn't
allocate memory, but it's calling kmalloc()!").

>Also, maybe it should be kmalloc_obj()?  <runs away>
>
>> +     * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SOFTIRQ | KAPI_CTX_HARDIRQ
>> +     * param-count: 2
>
>param-count is two, but you only document one of them?
>
>> +     * param: size
>> +     *   type: KAPI_TYPE_UINT
>> +     *   flags: KAPI_PARAM_IN
>> +     *   constraint-type: KAPI_CONSTRAINT_RANGE
>> +     *   range: 0, KMALLOC_MAX_SIZE
>> +     *
>> +     * error: ENOMEM, Out of memory
>> +     *   desc: Insufficient memory available for the requested allocation.
>> +     */
>
>Honest question: can this be made a bit easier for people to create,
>with less shift-key wear?  My biggest worry with a system like this is
>that people won't take the time to create and maintain the entries, so
>anything that would ease the task would help.  Is there an impediment to
>something like:

Before answering your actual question, I honestly think that most of these will
be LLM generated, so at least the skeleton of the kernel-doc will be there and
humans will only end up modifying the proposed spec.

>  contexts: process, softirq, hardirq
>
>  param: size
>    type: uint, input
>    constraint: range(0, KMALLOC_MAX_SIZE)
>
>See what I'm getting at?  ISTM that your DSL could be made a bit less
>verbose and shouty while being just as well defined, but perhaps I'm
>missing something?

Yup, let me look into that.

>Even better, of course, would be to add a "description" field for each
>parameter, and allow that rather than the @param description that
>kerneldoc currently uses.  That would keep all the information together,
>at the minor cost of adding another significant complication to the
>kernel-doc script.  Mauro won't mind :)
>
>> +    void *kmalloc(size_t size, gfp_t flags)
>> +    {
>> +        /* Implementation */
>> +    }
>> +
>> +Alternatively, specifications can be defined using the ``DEFINE_KERNEL_API_SPEC``
>> +macro for compiled-in specs that are stored in the ``.kapi_specs`` ELF section:
>> +
>> +.. code-block:: c
>> +
>> +    #include <linux/kernel_api_spec.h>
>> +
>> +    DEFINE_KERNEL_API_SPEC(sys_open)
>> +    KAPI_DESCRIPTION("Open or create a file")
>> +    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
>> +    /* ... parameter, error, constraint definitions ... */
>> +    KAPI_END_SPEC
>
>So the reason for two completely separate mechanisms is not entirely
>clear to me.  The kerneldoc variant is essentially documentation, while
>the macro stuff is to be built into the executable?  What if you want
>both?
>
>It would be nice to only have one way if at all possible; I'm sure that
>crossed your mind at some point :)  If there have to be two, having both
>examples describe the same function would make the parallels more clear.

Under the hood, the 

>> +System Call Specification
>> +-------------------------
>> +
>> +System calls are documented inline in the implementation file (e.g., ``fs/open.c``)
>> +using KAPI-annotated kerneldoc comments. When ``CONFIG_KAPI_RUNTIME_CHECKS`` is
>> +enabled, the ``SYSCALL_DEFINEx`` macros automatically look up the specification
>> +and validate parameters before and after the syscall executes.
>> +
>> +IOCTL Specification
>> +-------------------
>> +
>> +IOCTLs use the same annotation approach with additional structure field
>> +specifications
>
>This might be a really good place for an example

I think I'll just drop the IOCTL code for now. I used it in the RFCs to
demonstrate how a similar mechanism could be used throughout different
userspace API, but since I'm not using it in this series it probably makes
sense not to even talk about it.

>[...]
>
>> +Usage Examples
>> +--------------
>> +
>> +Query specific API::
>> +
>> +    $ cat /sys/kernel/debug/kapi/apis/kmalloc/specification
>> +    API: kmalloc
>> +    Version: 3.0
>> +    Description: Allocate kernel memory
>> +
>> +    Parameters:
>> +      [0] size (size_t, in): Number of bytes to allocate
>> +          Range: 0 - 4194304
>> +      [1] flags (flags, in): Allocation flags (GFP_*)
>> +          Mask: 0x1ffffff
>
>Ah, you do document that second parameter somewhere :)

Apparently. I'll update the prior example. Not sure why it's missing :)

>> +    Returns: pointer - Pointer to allocated memory or NULL
>> +
>> +    Errors:
>> +      ENOMEM: Out of memory
>> +
>> +    Context: process, softirq, hardirq
>> +
>> +    Side Effects:
>> +      - Allocates memory from kernel heap
>
>That part wasn't in your example
>
>> +Export all specifications::
>> +
>> +    $ cat /sys/kernel/debug/kapi/export/all.json > kernel-apis.json
>> +
>> +Enable validation for specific API::
>> +
>> +    $ echo 1 > /sys/kernel/debug/kapi/apis/kmalloc/validate
>> +
>> +Performance Considerations
>> +==========================
>> +
>> +Memory Overhead
>> +---------------
>> +
>> +Each API specification consumes approximately 400-450KB of memory due to the
>> +fixed-size arrays in ``struct kernel_api_spec``. With the current 4 syscall
>> +specifications, total memory usage is approximately 1.7MB. Consider:
>
>Ouch.

It's pretty "dumb" at this point: large static arrays and such, mostly to keep
the code simple to read. If this is a concern for accepting this series, I'm
happy to shrink it down (by a lot).

>> +Documentation Generation
>> +------------------------
>> +
>> +The framework exports specifications via debugfs that can be used
>> +to generate documentation. Tools for automatic documentation generation
>> +from specifications are planned for future development.
>
>Documentation always comes last :)

So this is one thing I wanted to run by the doc maintainers: the kapi tool
already has the capability to export these specs in .rst format. Would it be
interesting to have a manual for kenrel APIs in Documentation/? It can be
automatically generated and updated and would always match the kernel code at
that point.

>Interesting stuff.

Thanks!

-- 
Thanks,
Sasha

