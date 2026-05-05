Return-Path: <linux-api+bounces-6269-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O28Isig+WnR+QIAu9opvQ
	(envelope-from <linux-api+bounces-6269-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 05 May 2026 09:48:24 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 040FB4C83A1
	for <lists+linux-api@lfdr.de>; Tue, 05 May 2026 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A589E3056362
	for <lists+linux-api@lfdr.de>; Tue,  5 May 2026 07:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07FC3ECBF3;
	Tue,  5 May 2026 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLqBXYQf"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C943EAC90;
	Tue,  5 May 2026 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967194; cv=none; b=crHWEX21T8cUjXkcFy+JbL/R6UjPgb7GSs2DP2iA/7bFRpA7NHyygKCfSDGuTgYn0XCJ99KDSCT8JefRRmguMRmDzEDaPsTlJhw6KfkI+FK07WWUnoWt3ExARfD/rleD+iWWz06Es7FFcjWWmJ37XuqPpCBhb4IPbpusPiMbSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967194; c=relaxed/simple;
	bh=Rl3qzGbfwLjg5DijAFUn8oGFe8lDakZsz8523J5ndLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=lMhq5Ayxw/w8d7kYk77+4uSoajzWBnJqHwr3wy4CKjg6zUkbLNVvbfFlqdq0szxeQWFUhgH75k2DWSV004AvmeaztsvgonbPWCw8umJRQzW53H3J/LsuMnuhUOtz9xwjj5pWp36Kum5YmRR4/vZNpWTsFWWt5GUwFHJdfxC/R2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLqBXYQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5301C2BCF4;
	Tue,  5 May 2026 07:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777967192;
	bh=Rl3qzGbfwLjg5DijAFUn8oGFe8lDakZsz8523J5ndLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iLqBXYQfGtYCekmIFmeZDd+1eQpY90M+okEBoT/QJts07U7n9oLOel6m6aQ6SK57r
	 /gf6LaaTXwWQUMtM1APShNgQbnrxykDBKsIst4UWqXrmP0VRDPe5ukCJztAtBUWmxu
	 lEE0kSm8Fe46YboVgTf6eYQVLfrKOnAFFj3TE9+vC74Cy011B77JPYDVwt5l9oD8Fu
	 Hk9OKWIwqxUNP3NWr6lT0SERqqRievXUDKK/OEGWasq+j3wetyKVtjwj+mPLzYEmD3
	 NO6mMi7QbkQlfnnZoKR3Kgqy6nka44CFmRwMKJ4Tz+++hNzIxuMXyTOuixmyxmuH+N
	 nkBEplOzqTTCg==
From: Sasha Levin <sashal@kernel.org>
To: Nicolas Schier <nsc@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	workflows@vger.kernel.org,
	tools@kernel.org,
	x86@kernel.org,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Cyril Hrubis <chrubis@suse.cz>,
	Kees Cook <kees@kernel.org>,
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
	Ingo Molnar <mingo@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 2/9] kernel/api: enable kerneldoc-based API specifications
Date: Tue,  5 May 2026 03:45:43 -0400
Message-ID: <20260505074545.430334-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <afNrbm8URHlClZ-8@levanger>
References: <20260424165130.2306833-1-sashal@kernel.org> <20260424165130.2306833-3-sashal@kernel.org> <afNrbm8URHlClZ-8@levanger>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 040FB4C83A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6269-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[]

On Thu, Apr 30, 2026 at 04:47:10PM +0200, Nicolas Schier wrote:
> On Fri, Apr 24, 2026 at 12:51:22PM -0400, Sasha Levin wrote:
> > +# Generate API spec headers from kernel-doc comments
> > +ifeq ($(CONFIG_KAPI_SPEC),y)
> > +# Function to check if a file has API specifications
> > +has-apispec = $(shell grep -qE '^\s*\*\s*context-flags:' $(src)/$(1) 2>/dev/null && echo $(1))
> > +
> > +# Get base names without directory prefix
> > +c-objs-base := $(notdir $(real-obj-y) $(real-obj-m))
> > +# Filter to only .o files with corresponding .c source files
> > +c-files := $(foreach o,$(c-objs-base),$(if $(wildcard $(src)/$(o:.o=.c)),$(o:.o=.c)))
>
> Looks to me as if the two lines above are redundant, since 'find'
> (below) will find all files gathered in $(c-files).

Right, those two lines are dropped in v4. The replacement uses the
kbuild-derived file list described below, so neither set survives.

> > +# Also check for any additional .c files that contain API specs but are included
> > +extra-c-files := $(shell find $(src) -maxdepth 1 -name "*.c" -exec grep -l '^\s*\*\s*\(long-desc\|context-flags\|state-trans\):' {} \; 2>/dev/null | xargs -r basename -a)
> > +# Combine both lists and remove duplicates
> > +all-c-files := $(sort $(c-files) $(extra-c-files))
> > +# Only include files that actually have API specifications
> > +apispec-files := $(foreach f,$(all-c-files),$(call has-apispec,$(f)))
> > +# Generate apispec targets with proper directory prefix
> > +apispec-y := $(addprefix $(obj)/,$(apispec-files:.c=.apispec.h))
>
> To goal is to find any relevant C file in $(src)/ (but not deeper below)
> that holds KAPI documentation, right?
>
> I do not like the find call, as it picks up anything.  Might it make
> sense to evaluate $(obj-) along with $(obj-y) and $(obj-m) to pick up
> all C files that are references in kbuild?
>
>
>
> # in top definition block -- before 'include $(kbuild-file)' et al.
> obj- :=
>
> # below the definitions of real-obj-{y,m}
> real-obj-any := $(call real-search, $(obj-y) $(obj-m) $(obj-), .o, -objs -y -m -)
>
> has-apispec = $(shell grep -lE '^\s*\*\s*context-flags:' $(1) 2>/dev/null)
> apispec-y := $(patsubst $(src)/%.c, $(obj)/%.apispec.h, $(call has-apispec,
> 		    $(patsubst $(obj)/%.o, $(src)/%.c, $(real-obj-any))))
>
> #...
>
> # Source files that include their own apispec.h need to depend on it
> $(apispec-y:.apispec.h=.o): $(obj)/%.o: $(obj)/%.apispec.h
>
> (untested)

Thanks, the kbuild-driven approach is much cleaner. v4 takes your sketch
with two adjustments:

1. obj-m is already addprefix'd with $(obj)/ by line 116 of
   Makefile.build at the point where this block runs, so calling
   real-search again on the mixed list double-prefixes the module
   entries (giving $(src)/$(obj)/foo.c). v4 uses the existing
   $(real-obj-y)/$(real-obj-m) and strips the prefix in patsubst
   instead:

       apispec-c-files := $(call has-apispec, \
           $(patsubst $(obj)/%.o,$(src)/%.c, \
               $(filter-out %/built-in.a,$(real-obj-y) $(real-obj-m))))
       apispec-y := $(patsubst $(src)/%.c,$(obj)/%.apispec.h,$(apispec-c-files))

2. The has-apispec grep needs to match the same set of keys that
   tools/lib/python/kdoc/kdoc_apispec.py actually parses, which is
   "contexts:", "context-flags:" and "context:" interchangeably (see
   _get_section calls around line 866 of kdoc_apispec.py). The original
   grep for "context-flags:" matched zero files in the tree (every
   instrumented file uses "contexts:"), which is the latent bug behind
   the build failure you saw. v4 widens the regex:

       has-apispec = $(shell grep -lE \
           '^[[:space:]]*\*[[:space:]]*(contexts|context-flags|context):' \
           $(1) 2>/dev/null)

> > diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
> > index 6ead00ec7313b..f78dbbe637f27 100644
> > --- a/scripts/Makefile.clean
> > +++ b/scripts/Makefile.clean
> > @@ -35,6 +35,9 @@ __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))
> >
> >  __clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
> >
> > +# Also clean generated apispec headers (computed dynamically in Makefile.build)
> > +__clean-files   += $(wildcard $(obj)/*.apispec.h)
>
> We have a list of wildcard clean patterns in top-level Makefile
> (line 2114 ff.); please add '*.apispec.h' there instead.

Will fix.

> When I apply the series on top of v7.1, compilation fails with
>
> ../fs/open.c:2148:10: fatal error: open.apispec.h: No such file or directory
> ../fs/read_write.c:2519:10: fatal error: read_write.apispec.h: No such file or directory

This is the symptom of (2) above. fs/open.c and fs/read_write.c only
declare "contexts: process, sleepable" (no "context-flags:" anywhere in
the tree, confirmed via grep), so apispec-files was always empty and no
*.apispec.h ever got generated. With CONFIG_KAPI_SPEC=y the
"#if IS_ENABLED(CONFIG_KAPI_SPEC)" guarded include then fails. Also
reproducible on v7.0; thanks for catching it.

Thanks for the review and the kbuild sketch!

--
Thanks,
Sasha

