Return-Path: <linux-api+bounces-6242-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNfBOSFs82lf2gEAu9opvQ
	(envelope-from <linux-api+bounces-6242-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 16:50:09 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B334A440F
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 16:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D485D306A83E
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BAE42B75B;
	Thu, 30 Apr 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiNgLKTI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B602641CA;
	Thu, 30 Apr 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560445; cv=none; b=eUwNi+HT4055Dro8+Vcbv91g7+hDhgmnWXgTgjSu0iXjQp7k+2xGI84XgVuPPcV8tFZfKNVdWbbViUF+lp3bo5tI4cvHiODjWi/gDY98xrB4+9J8OAWHUHNA6+TjV4bpHbz5irV3RWlUunmNBKzRDvUcwMxIxZC72MY6VFr7/00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560445; c=relaxed/simple;
	bh=264aTQoULBVWcUvPni2hxBum6EiIcWK0YAfHGvmCE2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Es2bJycCbVUDzwaXbASocqzaiIkJUSHECsOa7mWfvQM6qI34knTNJeI/Zl012xiffAEsHbWi5FEa2PASqNneCpeMAskogGMd1nwQvEcYUXftyDiRgolmeVZ5MYrREydcivtRTICyRrM5qrSyKzcmmYyaUTJ9NufNUvNjjqdwjjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiNgLKTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309DBC2BCB3;
	Thu, 30 Apr 2026 14:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560443;
	bh=264aTQoULBVWcUvPni2hxBum6EiIcWK0YAfHGvmCE2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YiNgLKTI0NC9lXL371WXRwAC3EKdkT/2mTAe3elDeEIcpos1O9ZYXg1ot3GHyxsIC
	 1yFFlP2evF/7bdTL6EqkLDBecTePyowRBmZ7Hrf90yBaoN90bvLIyqVfB66wM1MvEf
	 gjd6VeK79ytB2O4nxu5mUZ4g8FaO0wbVWP0DZasS60AU2avdPSBXA4fIWwlN27vzuT
	 r6FXO4YRXHse8QNs4+MKzGldjLn/GSaOdCziJzeEujuibO4qwQne8mWoB1ohGn5SYM
	 j1hYboR5eW/Nigs+HuJk6bOosot98kQl+0pOA53k9x9MYDad5vbEGCQxzIOgNdMsgu
	 4zLQipgi6ol3g==
Date: Thu, 30 Apr 2026 16:47:10 +0200
From: Nicolas Schier <nsc@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
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
Subject: Re: [PATCH v3 2/9] kernel/api: enable kerneldoc-based API
 specifications
Message-ID: <afNrbm8URHlClZ-8@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org, workflows@vger.kernel.org,
	tools@kernel.org, x86@kernel.org, Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
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
References: <20260424165130.2306833-1-sashal@kernel.org>
 <20260424165130.2306833-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424165130.2306833-3-sashal@kernel.org>
X-Rspamd-Queue-Id: 97B334A440F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6242-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nsc@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kdoc_apispec.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,makefile.build:url]

On Fri, Apr 24, 2026 at 12:51:22PM -0400, Sasha Levin wrote:
> This patch adds support for extracting API specifications from
> kernel-doc comments and generating C macro invocations for the
> kernel API specification framework.
> 
> Changes include:
> - New kdoc_apispec.py module for generating API spec macros
> - Updates to kernel-doc.py to support -apispec output format
> - Build system integration in Makefile.build
> - Generator script for collecting all API specifications
> - Support for API-specific sections in kernel-doc comments
> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/dev-tools/kernel-api-spec.rst |   11 +
>  scripts/Makefile.build                      |   31 +
>  scripts/Makefile.clean                      |    3 +
>  tools/docs/kernel-doc                       |    5 +
>  tools/lib/python/kdoc/kdoc_apispec.py       | 1249 +++++++++++++++++++
>  tools/lib/python/kdoc/kdoc_output.py        |    9 +-
>  tools/lib/python/kdoc/kdoc_parser.py        |   86 +-
>  7 files changed, 1389 insertions(+), 5 deletions(-)
>  create mode 100644 tools/lib/python/kdoc/kdoc_apispec.py
> 
> diff --git a/Documentation/dev-tools/kernel-api-spec.rst b/Documentation/dev-tools/kernel-api-spec.rst
> index 395c2294d5209..479bc78797ba8 100644
> --- a/Documentation/dev-tools/kernel-api-spec.rst
> +++ b/Documentation/dev-tools/kernel-api-spec.rst
> @@ -239,6 +239,17 @@ execution context, and return values. Parameter violations are reported via
>  ``pr_warn_ratelimited`` and return value violations via ``WARN_ONCE`` to avoid
>  flooding the kernel log.
>  
> +.. warning::
> +
> +   Userspace errno is affected when this option is on. For syscalls that
> +   violate their parameter specification, KAPI short-circuits the call and
> +   returns ``-EINVAL`` from the validator **before** the real handler runs.
> +   That errno can differ from what the real handler would have produced for
> +   the same condition (for example, ``-ENOMEM`` from an allocation path or
> +   ``-EFAULT`` from a deeper copy-in). ``CONFIG_KAPI_RUNTIME_CHECKS`` is a
> +   debug-only option; do not enable it on production kernels or in
> +   userspace-visible test environments where error-code fidelity matters.
> +
>  Custom Validators
>  -----------------
>  
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3652b85be5459..ef203e490c797 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -174,6 +174,37 @@ ifneq ($(KBUILD_EXTRA_WARN),)
>  endif
>  endif
>  
> +# Generate API spec headers from kernel-doc comments
> +ifeq ($(CONFIG_KAPI_SPEC),y)
> +# Function to check if a file has API specifications
> +has-apispec = $(shell grep -qE '^\s*\*\s*context-flags:' $(src)/$(1) 2>/dev/null && echo $(1))
> +
> +# Get base names without directory prefix
> +c-objs-base := $(notdir $(real-obj-y) $(real-obj-m))
> +# Filter to only .o files with corresponding .c source files
> +c-files := $(foreach o,$(c-objs-base),$(if $(wildcard $(src)/$(o:.o=.c)),$(o:.o=.c)))

Looks to me as if the two lines above are redundant, since 'find'
(below) will find all files gathered in $(c-files).


> +# Also check for any additional .c files that contain API specs but are included
> +extra-c-files := $(shell find $(src) -maxdepth 1 -name "*.c" -exec grep -l '^\s*\*\s*\(long-desc\|context-flags\|state-trans\):' {} \; 2>/dev/null | xargs -r basename -a)
> +# Combine both lists and remove duplicates
> +all-c-files := $(sort $(c-files) $(extra-c-files))
> +# Only include files that actually have API specifications
> +apispec-files := $(foreach f,$(all-c-files),$(call has-apispec,$(f)))
> +# Generate apispec targets with proper directory prefix
> +apispec-y := $(addprefix $(obj)/,$(apispec-files:.c=.apispec.h))

To goal is to find any relevant C file in $(src)/ (but not deeper below)
that holds KAPI documentation, right?

I do not like the find call, as it picks up anything.  Might it make
sense to evaluate $(obj-) along with $(obj-y) and $(obj-m) to pick up
all C files that are references in kbuild?



# in top definition block -- before 'include $(kbuild-file)' et al.
obj- :=

# below the definitions of real-obj-{y,m}
real-obj-any := $(call real-search, $(obj-y) $(obj-m) $(obj-), .o, -objs -y -m -)

has-apispec = $(shell grep -lE '^\s*\*\s*context-flags:' $(1) 2>/dev/null)
apispec-y := $(patsubst $(src)/%.c, $(obj)/%.apispec.h, $(call has-apispec,
		    $(patsubst $(obj)/%.o, $(src)/%.c, $(real-obj-any))))

#...

# Source files that include their own apispec.h need to depend on it
$(apispec-y:.apispec.h=.o): $(obj)/%.o: $(obj)/%.apispec.h

(untested)

> +always-y += $(apispec-y)
> +targets += $(apispec-y)
> +
> +quiet_cmd_apispec = APISPEC $@
> +      cmd_apispec = PYTHONDONTWRITEBYTECODE=1 $(KERNELDOC) -apispec \
> +                    $(KDOCFLAGS) $< > $@ || rm -f $@
> +
> +$(obj)/%.apispec.h: $(src)/%.c $(KERNELDOC) FORCE
> +	$(call if_changed,apispec)
> +
> +# Source files that include their own apispec.h need to depend on it
> +$(foreach f,$(apispec-files),$(eval $(obj)/$(f:.c=.o): $(obj)/$(f:.c=.apispec.h)))
> +endif
> +
>  # Compile C sources (.c)
>  # ---------------------------------------------------------------------------
>  
> diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> index 6ead00ec7313b..f78dbbe637f27 100644
> --- a/scripts/Makefile.clean
> +++ b/scripts/Makefile.clean
> @@ -35,6 +35,9 @@ __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))
>  
>  __clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
>  
> +# Also clean generated apispec headers (computed dynamically in Makefile.build)
> +__clean-files   += $(wildcard $(obj)/*.apispec.h)

We have a list of wildcard clean patterns in top-level Makefile
(line 2114 ff.); please add '*.apispec.h' there instead.



When I apply the series on top of v7.1, compilation fails with

../fs/open.c:2148:10: fatal error: open.apispec.h: No such file or directory
../fs/read_write.c:2519:10: fatal error: read_write.apispec.h: No such file or directory

Kind regards,
Nicolas

