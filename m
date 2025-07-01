Return-Path: <linux-api+bounces-4093-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B1DAEFC22
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 16:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D292B18892B7
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 14:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A4239E82;
	Tue,  1 Jul 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvrmez41"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E70DF49;
	Tue,  1 Jul 2025 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751379785; cv=none; b=EDUniGrPUmX/f6u/CCX2Qa/VV2nT4W8G62+wDo8YXVGB7ekr4v8Ek3obfIpedb2Fw0dLzMB/FlmTaEeLCiRLAulem5Hy8oHN4BtRW6nmcEy/Yo/U3/3StpeUo/PBoN8sZd9sBv0GINjW6fX1YamS6MALXIyZSdlWDaxx6hUTx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751379785; c=relaxed/simple;
	bh=19HqR+S7DS9HWEs5GXmKKrr14rS+lQ2AvqDBzeElGvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTlBZX6fBmdsGAIpCY7yMfy72jSRoBLl3ez130dIAWscSbRTidWRSTG1Rfp99/ceXWKdbZugVKvFuGwwU0vJExTOBh4hPbI7Zt8NvwA1PbklVK8utawsfsBJlXin0oASpgFg7pbwdDGXk3w9aakxA0XYUY3SQIK3ddMupKSL4d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvrmez41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D87C4CEEB;
	Tue,  1 Jul 2025 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751379785;
	bh=19HqR+S7DS9HWEs5GXmKKrr14rS+lQ2AvqDBzeElGvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cvrmez41qnkAH4K2wnjByJW22VMfh7vqEHdljJD1cnJpJfew8eYrvMAgzrBGpSvpH
	 cM9Ydck+E//ShuSKBu9pruEb9+H7QhUtBsB+dBl00FOjh8bbASF60fmybGfWR7FxBj
	 HQYxQCSgCK6YaYZd6w1Vol4LS2EUfzHuwC4tSXYrc51/SFur1rKPW33Z4cHVNWEj7q
	 e+jAKAZueqk9uhdMRJnwBD5kTHxPyl4mZMCWExP1F1zfKNTcrZTy7GGwZ/d2+FERwD
	 yw8slrHclpblB1giCbUxLFGXiIGFxFV3gFAlraKiWIlPAsonBtEjIalBykzv7RYDo6
	 uaN25wCemp11Q==
Date: Tue, 1 Jul 2025 10:23:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC v2 01/22] kernel/api: introduce kernel API specification
 framework
Message-ID: <aGPvR-Mj6aR4Y8B5@lappy>
References: <20250624180742.5795-1-sashal@kernel.org>
 <20250624180742.5795-2-sashal@kernel.org>
 <874ivxuht8.fsf@trenco.lwn.net>
 <20250701002058.1cae5a7e@foz.lan>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250701002058.1cae5a7e@foz.lan>

On Tue, Jul 01, 2025 at 12:20:58AM +0200, Mauro Carvalho Chehab wrote:
>Em Mon, 30 Jun 2025 13:53:55 -0600
>Jonathan Corbet <corbet@lwn.net> escreveu:
>
>> Sasha Levin <sashal@kernel.org> writes:
>>
>> > Add a comprehensive framework for formally documenting kernel APIs with
>> > inline specifications. This framework provides:
>> >
>> > - Structured API documentation with parameter specifications, return
>> >   values, error conditions, and execution context requirements
>> > - Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
>> > - Export of specifications via debugfs for tooling integration
>> > - Support for both internal kernel APIs and system calls
>> >
>> > The framework stores specifications in a dedicated ELF section and
>> > provides infrastructure for:
>> > - Compile-time validation of specifications
>> > - Runtime querying of API documentation
>> > - Machine-readable export formats
>> > - Integration with existing SYSCALL_DEFINE macros
>> >
>> > This commit introduces the core infrastructure without modifying any
>> > existing APIs. Subsequent patches will add specifications to individual
>> > subsystems.
>> >
>> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>> > ---
>> >  Documentation/admin-guide/kernel-api-spec.rst |  507 ++++++
>>
>> You need to add that file to index.rst in that directory or it won't be
>> pulled into the docs build.
>>
>> Wouldn't it be nice to integrate all this stuff with out existing
>> kerneldoc mechanism...? :)
>
>+1
>
>Having two different mechanisms (kapi and kerneldoc) makes a lot harder
>to maintain kAPI.

I hated the idea of not reusing kerneldoc.

My concern with kerneldoc was that I can't manipulate the
information it stores in the context of a kernel build. So for example,
I wasn't sure how I can expose information stored within kerneldoc via
debugfs on a running system (or how I can store it within the vmlinux
for later extraction from the binary built kernel).

I did some research based on your proposal, and I think I was incorrect
with the assumption above. I suppose we could do something like the
following:

1. Add new section patterns to doc_sect regex in to include API
specification sections: api-type, api-version, param-type, param-flags,
param-constraint, error-code, capability, signal, lock-req, since...
  
2. Create new output module (scripts/lib/kdoc/kdoc_apispec.py?) to
generate C macro invocations from parsed data.

Which will generate output like:

    DEFINE_KERNEL_API_SPEC(function_name)
        KAPI_DESCRIPTION("...") 
        KAPI_PARAM(0, "name", "type", "desc")
            KAPI_PARAM_TYPE(KAPI_TYPE_INT)
            KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
        KAPI_PARAM_END
    KAPI_END_SPEC 

3. And then via makefile we can: 
    - Generate API specs from kerneldoc comments
    - Include generated specs conditionally based on CONFIG_KERNEL_API_SPEC

Allowing us to just have these in the relevant source files:
    #ifdef CONFIG_KERNEL_API_SPEC
    #include "socket.apispec.h"
    #endif


In theory, all of that will let us have something like the following in
kerneldoc:

- @api-type: syscall
- @api-version: 1
- @context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
- @param-type: family, KAPI_TYPE_INT
- @param-flags: family, KAPI_PARAM_IN
- @param-range: family, 0, 45
- @param-mask: type, SOCK_TYPE_MASK | SOCK_CLOEXEC | SOCK_NONBLOCK
- @error-code: -EAFNOSUPPORT, "Address family not supported"
- @error-condition: -EAFNOSUPPORT, "family < 0 || family >= NPROTO"
- @capability: CAP_NET_RAW, KAPI_CAP_GRANT_PERMISSION
- @capability-allows: CAP_NET_RAW, "Create SOCK_RAW sockets"
- @since: 2.0
- @return-type: KAPI_TYPE_FD
- @return-check: KAPI_RETURN_ERROR_CHECK

How does it sound? I'm pretty excited about the possiblity to align this
with kerneldoc. Please poke holes in the plan :)

-- 
Thanks,
Sasha

