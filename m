Return-Path: <linux-api+bounces-4178-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1A9B0BB06
	for <lists+linux-api@lfdr.de>; Mon, 21 Jul 2025 04:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B9D1896610
	for <lists+linux-api@lfdr.de>; Mon, 21 Jul 2025 02:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8655E1E261F;
	Mon, 21 Jul 2025 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNHYPzy3"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC276025;
	Mon, 21 Jul 2025 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753066474; cv=none; b=RbKUq8C4CTTCLIaJGPY6fn2tN18Nqp5W+i7oB5XfR02fCzvxMQMQO9wQjlppQOrND6wIqzGoEXU6kuHRmRA11WdAMbc+3ZA0SlbDGAEwmUhXJnFhQnp4tNEYratd/CGUjM3Kn6pch/d3ErJTNkI+R8wzJ35feF7zrCvNyhi9gBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753066474; c=relaxed/simple;
	bh=wKE5SaYzf5homo07X6Qe308+C8vsY5yk7XZ3LonHq60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYze4nD3MdUpsYWxWpc9m4p4jVgUlqKg0N8fcZouQZe712g1Uc+aSNKjRRXQEURcRHW9gtClMPLT7tn8pVH3lCXnxCSDsyZwFCT19WG4ZRJ6oN/L7DOTvpp0iKmZauZPbc7BIJR+TA80I/sO3367plxShAkqcFnwcRxbox2VJsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNHYPzy3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E07BC4CEE7;
	Mon, 21 Jul 2025 02:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753066473;
	bh=wKE5SaYzf5homo07X6Qe308+C8vsY5yk7XZ3LonHq60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNHYPzy3FFEzDBaYhDsJGlPgfWOwcxjNZkp4OyhD5KVsd/H19tqYnpm/OZ18H1HoQ
	 PKgmCEmau8d7wAqez0OKfAcFPsRoKPimvUP87dmdJ1IgjC4SHCUgGyeXy+ZQzZHToU
	 BeJgQBVU9BzoWyIbNi4nsro4nGBiFYbgIH8MBh46BbJP7FqwtAovgHCQBgNk93wfxm
	 2vS40xh/ngOTs2TXaLn94ezKlVNRWiOLjHoY8L2XyGPHHZ3raME05FXxsT9CJFMlNw
	 EtRQmD3pOprspkz2klxbhyINDeBH/Nhy/Kcfv85rJzSOZISy9zZNaDpi6tVWbeAT7V
	 QjVy6uNhBrhYA==
Date: Sun, 20 Jul 2025 22:54:31 -0400
From: Sasha Levin <sashal@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-api@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC v3 2/4] kernel/api: enable kerneldoc-based API
 specifications
Message-ID: <aH2r55bjqqtKxOEQ@lappy>
References: <20250711114248.2288591-1-sashal@kernel.org>
 <20250711114248.2288591-3-sashal@kernel.org>
 <4777f4d7-f1c6-4345-92b2-0ba5d6563ee2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <4777f4d7-f1c6-4345-92b2-0ba5d6563ee2@infradead.org>

On Sun, Jul 20, 2025 at 05:55:05PM -0700, Randy Dunlap wrote:
>Hi Sasha,
>
>I would like to ask a few questions to try to clarify/understand, please.
>
>On 7/11/25 4:42 AM, Sasha Levin wrote:
>> Allow kernel developers to write API specifications directly in
>> kerneldoc comments, which are automatically converted to machine-readable
>> C macros during build.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  kernel/api/Makefile              |  21 +-
>>  scripts/Makefile.build           |  28 ++
>>  scripts/generate_api_specs.sh    |  59 +++
>>  scripts/kernel-doc.py            |   5 +
>>  scripts/lib/kdoc/kdoc_apispec.py | 623 +++++++++++++++++++++++++++++++
>>  scripts/lib/kdoc/kdoc_output.py  |   5 +-
>>  scripts/lib/kdoc/kdoc_parser.py  |  54 ++-
>>  7 files changed, 791 insertions(+), 4 deletions(-)
>>  create mode 100755 scripts/generate_api_specs.sh
>>  create mode 100644 scripts/lib/kdoc/kdoc_apispec.py
>>
>
>[snip]
>
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index a6461ea411f7a..5c0e44d1b6dbc 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -172,6 +172,34 @@ ifneq ($(KBUILD_EXTRA_WARN),)
>>          $<
>>  endif
>>
>> +# Generate API spec headers from kernel-doc comments
>> +ifeq ($(CONFIG_KAPI_SPEC),y)
>> +# Function to check if a file has API specifications
>> +has-apispec = $(shell grep -qE '^\s*\*\s*(api-type|long-desc|context-flags|param-type|error-code|capability|signal|lock|side-effect|state-trans):' $(src)/$(1) 2>/dev/null && echo $(1))
>> +
>> +# Get base names without directory prefix
>> +c-objs-base := $(notdir $(real-obj-y) $(real-obj-m))
>> +# Filter to only .o files with corresponding .c source files
>> +c-files := $(foreach o,$(c-objs-base),$(if $(wildcard $(src)/$(o:.o=.c)),$(o:.o=.c)))
>
>1. One must build a kernel (with some desired .config file) to use/test this,
>correct?

Mostly yes, but another option is to use the kapi tool (which I haven't
updated and sent out as part of v3, but you can see it in v2:
https://lore.kernel.org/tools/20250624180742.5795-23-sashal@kernel.org/T/#u).

With the kapi tool, you can also run it on a source tree to extract the
same information that you'd have in a built vmlinux.

>2. It looks like it only checks .c files, omitting header files. (?)
>Some APIs are only present in header files (e.g., all of <linux/list.h> is
>either macros or inline functions).

I was trying to focus on the userspace side of things, so I didn't think
we'll have anything in header files, but I also don't have an objection
to extending it to scan headers too.

>> +# Also check for any additional .c files that contain API specs but are included
>> +extra-c-files := $(shell find $(src) -maxdepth 1 -name "*.c" -exec grep -l '^\s*\*\s*\(api-type\|long-desc\|context-flags\|param-type\|error-code\|capability\|signal\|lock\|side-effect\|state-trans\):' {} \; 2>/dev/null | xargs -r basename -a)
>
>3a. included files: does this catch the (rare) use of a C file doing
>#include <path to some other C file> ?

Yes!

Jon suggested I apply this to a kernel/sched/ syscall to see how it
handles complex syscalls, but it also added another complexity because
sched does exactly what you described (kernel/sched/build_policy.c
includes a bunch of other .c files including syscalls.c). See the 4th
patch in the series.

>3b. Quite a few makefiles generate final .o files with a different name
>from the source files. It looks like that is handled above by looking
>for the first (or intermediate) .o file for each .c file, so the final
>.o file with a different name is ignored (or at least doesn't come into
>play here). Yes?

Yes, exactly. The code looks for .o files that have directly
corresponding .c files with the same base name. When makefiles generate
final .o files with different names (like when multiple .c files are
combined into a single .o, or when the output name is changed), those
renamed .o files won't have a matching .c file and will be filtered out
by the $(if $(wildcard $(src)/$(o:.o=.c)),$(o:.o=.c)) check.

>Thanks.

Thanks for looking into it!

-- 
Thanks,
Sasha

