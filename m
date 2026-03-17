Return-Path: <linux-api+bounces-6001-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMQ7CleUuWkJKwIAu9opvQ
	(envelope-from <linux-api+bounces-6001-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2026 18:50:15 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 793912B0335
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2026 18:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E51D3019167
	for <lists+linux-api@lfdr.de>; Tue, 17 Mar 2026 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5537D124;
	Tue, 17 Mar 2026 17:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="JeYqVH2P"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D309137CD5E;
	Tue, 17 Mar 2026 17:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769773; cv=none; b=Po36rIXyFJHOyd78SWTrL0m9SmwtJzBryfZnchj3BqqJgIgUzTvcJYfN5AgX/aAu0tmUzTF806IxUZwqYxN//YbhPz734PKL8SL1dDjAWGq1s+i6iJppnJlE0BP4W9uOAqHLghyaUNBohOr3aIFmEZVZityla30Z+FSQZ+Rj2eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769773; c=relaxed/simple;
	bh=kVd7WqqIEuqnSnuvqyAQZDi/iz4O/JT2V16GHRpYCQY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D5cjqsc5T517tut9q6Vm5V8UqiXGbJ0/AZPAUb5i8NX6MQ4pX8/ktOVacPvxLr6FB+u+O4Z2CH+UNh894g3QjPWPhS6k6Fv9ZiHS2xHVgvEAxgWHLwQ/8TQRYTkGRKnTZup2MnXum62niDvGW1vT1gWKVuGHmhCJIWC0DGHQOcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=JeYqVH2P; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C5C9940C7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1773769768; bh=7Otd/TzkbZeVgZIL1Yn9LdpW6FPuE2AtPeVB8L4xye4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JeYqVH2PyAkJTP9Ld5bMzQC8/28cz/40eb75rNFqPh8LI1+nxbYf5B96gwfWTA8p2
	 IyFIrgVdBBfJL7u573qdLnPnz1PzG/2iRipw7nSlSb3eVzcMpn/Xnou62T4wECCeLP
	 gPulEfT6Q3yxbbJ3HtXSV1pSFSlD/bqDiWANfk8rpeJITniK26zxsmU1NDmN5hzUZV
	 uVO6IR23N56d8FgBZYhzQuSzXOZ30D9x2K1RiJhCbnaL/QWN4EG6Oq1uxLxbetfXAU
	 1Cqe42RqkcTmRilKspV7MVWRickhe9lSFqloPVwSy8sfEKyve6l6I96bDT5KrRKdFF
	 jEk/T2NSeqUCQ==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C5C9940C7C;
	Tue, 17 Mar 2026 17:49:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org, Thomas
 Gleixner <tglx@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Vyukov
 <dvyukov@google.com>, Randy Dunlap <rdunlap@infradead.org>, Cyril Hrubis
 <chrubis@suse.cz>, Kees Cook <kees@kernel.org>, Jake Edge <jake@lwn.net>,
 David Laight <david.laight.linux@gmail.com>, Askar Safin
 <safinaskar@zohomail.com>, Gabriele Paoloni <gpaoloni@redhat.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Christian Brauner
 <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew
 Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo
 Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [PATCH 1/9] kernel/api: introduce kernel API specification
 framework
In-Reply-To: <20260313150928.2637368-2-sashal@kernel.org>
References: <20260313150928.2637368-1-sashal@kernel.org>
 <20260313150928.2637368-2-sashal@kernel.org>
Date: Tue, 17 Mar 2026 11:49:27 -0600
Message-ID: <87h5qe9wig.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[lwn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lwn.net:s=20201203];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6001-lists,linux-api=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,google.com,infradead.org,suse.cz,lwn.net,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[corbet@lwn.net,linux-api@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[lwn.net:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lwn.net:dkim,trenco.lwn.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793912B0335
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sasha Levin <sashal@kernel.org> writes:

> Add a framework for formally documenting kernel APIs with inline
> specifications. This framework provides:
>
> - Structured API documentation with parameter specifications, return
>   values, error conditions, and execution context requirements
> - Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
> - Export of specifications via debugfs for tooling integration
> - Support for both internal kernel APIs and system calls

So I'll confess I have only scanned over the implementation, but I have
some thoughts on the earlier stuff.

[...]

> diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
> new file mode 100644
> index 0000000000000..7c0c1694f1f4a
> --- /dev/null
> +++ b/Documentation/dev-tools/kernel-api-spec.rst
> @@ -0,0 +1,482 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======================================
> +Kernel API Specification Framework
> +======================================
> +
> +:Author: Sasha Levin <sashal@kernel.org>
> +:Date: June 2025

Has it not changed since then?

> +.. contents:: Table of Contents
> +   :depth: 3
> +   :local:
> +
> +Introduction
> +============

[...]

> +Usage Guide
> +===========
> +
> +Basic API Specification
> +-----------------------
> +
> +API specifications are written as KAPI-annotated kerneldoc comments directly in
> +the source file, immediately preceding the function implementation. The ``kapi``
> +tool extracts these annotations to produce structured specifications.
> +
> +.. code-block:: c
> +
> +    /**
> +     * kmalloc - allocate kernel memory
> +     * @size: Number of bytes to allocate
> +     * @flags: Allocation flags (GFP_*)

Given that the text thus far has talked about user-space API validation,
it's a bit surprising to see an internal function used as an example.

Also, maybe it should be kmalloc_obj()?  <runs away>

> +     * context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SOFTIRQ | KAPI_CTX_HARDIRQ
> +     * param-count: 2

param-count is two, but you only document one of them?

> +     * param: size
> +     *   type: KAPI_TYPE_UINT
> +     *   flags: KAPI_PARAM_IN
> +     *   constraint-type: KAPI_CONSTRAINT_RANGE
> +     *   range: 0, KMALLOC_MAX_SIZE
> +     *
> +     * error: ENOMEM, Out of memory
> +     *   desc: Insufficient memory available for the requested allocation.
> +     */

Honest question: can this be made a bit easier for people to create,
with less shift-key wear?  My biggest worry with a system like this is
that people won't take the time to create and maintain the entries, so
anything that would ease the task would help.  Is there an impediment to
something like:

  contexts: process, softirq, hardirq

  param: size
    type: uint, input
    constraint: range(0, KMALLOC_MAX_SIZE)

See what I'm getting at?  ISTM that your DSL could be made a bit less
verbose and shouty while being just as well defined, but perhaps I'm
missing something?

Even better, of course, would be to add a "description" field for each
parameter, and allow that rather than the @param description that
kerneldoc currently uses.  That would keep all the information together,
at the minor cost of adding another significant complication to the
kernel-doc script.  Mauro won't mind :)

> +    void *kmalloc(size_t size, gfp_t flags)
> +    {
> +        /* Implementation */
> +    }
> +
> +Alternatively, specifications can be defined using the ``DEFINE_KERNEL_API_SPEC``
> +macro for compiled-in specs that are stored in the ``.kapi_specs`` ELF section:
> +
> +.. code-block:: c
> +
> +    #include <linux/kernel_api_spec.h>
> +
> +    DEFINE_KERNEL_API_SPEC(sys_open)
> +    KAPI_DESCRIPTION("Open or create a file")
> +    KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
> +    /* ... parameter, error, constraint definitions ... */
> +    KAPI_END_SPEC

So the reason for two completely separate mechanisms is not entirely
clear to me.  The kerneldoc variant is essentially documentation, while
the macro stuff is to be built into the executable?  What if you want
both?

It would be nice to only have one way if at all possible; I'm sure that
crossed your mind at some point :)  If there have to be two, having both
examples describe the same function would make the parallels more clear.

> +System Call Specification
> +-------------------------
> +
> +System calls are documented inline in the implementation file (e.g., ``fs/open.c``)
> +using KAPI-annotated kerneldoc comments. When ``CONFIG_KAPI_RUNTIME_CHECKS`` is
> +enabled, the ``SYSCALL_DEFINEx`` macros automatically look up the specification
> +and validate parameters before and after the syscall executes.
> +
> +IOCTL Specification
> +-------------------
> +
> +IOCTLs use the same annotation approach with additional structure field
> +specifications

This might be a really good place for an example

[...]

> +Usage Examples
> +--------------
> +
> +Query specific API::
> +
> +    $ cat /sys/kernel/debug/kapi/apis/kmalloc/specification
> +    API: kmalloc
> +    Version: 3.0
> +    Description: Allocate kernel memory
> +
> +    Parameters:
> +      [0] size (size_t, in): Number of bytes to allocate
> +          Range: 0 - 4194304
> +      [1] flags (flags, in): Allocation flags (GFP_*)
> +          Mask: 0x1ffffff

Ah, you do document that second parameter somewhere :)

> +    Returns: pointer - Pointer to allocated memory or NULL
> +
> +    Errors:
> +      ENOMEM: Out of memory
> +
> +    Context: process, softirq, hardirq
> +
> +    Side Effects:
> +      - Allocates memory from kernel heap

That part wasn't in your example

> +Export all specifications::
> +
> +    $ cat /sys/kernel/debug/kapi/export/all.json > kernel-apis.json
> +
> +Enable validation for specific API::
> +
> +    $ echo 1 > /sys/kernel/debug/kapi/apis/kmalloc/validate
> +
> +Performance Considerations
> +==========================
> +
> +Memory Overhead
> +---------------
> +
> +Each API specification consumes approximately 400-450KB of memory due to the
> +fixed-size arrays in ``struct kernel_api_spec``. With the current 4 syscall
> +specifications, total memory usage is approximately 1.7MB. Consider:

Ouch.

> +Documentation Generation
> +------------------------
> +
> +The framework exports specifications via debugfs that can be used
> +to generate documentation. Tools for automatic documentation generation
> +from specifications are planned for future development.

Documentation always comes last :)

Interesting stuff.

jon

