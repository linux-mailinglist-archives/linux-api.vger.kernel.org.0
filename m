Return-Path: <linux-api+bounces-6193-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIkKOrHa7mkPygAAu9opvQ
	(envelope-from <linux-api+bounces-6193-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 05:40:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82846C831
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 05:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25B7B3037454
	for <lists+linux-api@lfdr.de>; Mon, 27 Apr 2026 03:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6810435F60B;
	Mon, 27 Apr 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ueDIdW2Q"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69A35E92B;
	Mon, 27 Apr 2026 03:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261080; cv=none; b=f89MNaetJRwwFmN7SnJOmRFb+xGeheb77Qu7mk3lYmABCeGj+sIJhFeQgJ5KIDDdmOFBaWJyejX0yfZ3pyZHOYjwTOqqEaMC2AyjEw006IVhOCYk/u5aPWf58L1ugVQiWiHepdBYs18DOoxH00Lv7CcV+gYaG4ru1rySAbaA3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261080; c=relaxed/simple;
	bh=3lD5uG9ZXrIgOwKv6Um8sK6s94l7Kup9XM0KiGIDbKk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=JM9WRBd4lay/DMsA2S74RCLPaCyq+mGzAS9Jog94uuZjSLM0cxErLw2sgm3d7on6Cs0Ek0kLp3yU7L/VCIvqmSNM9bNSdjfuTPC/dP23a47kDvpxOHHx/wOKkllDTWlos1UG5notr/0DvWsrb0gyhOj30J8CxD4E45PB04ylEag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ueDIdW2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26B3C19425;
	Mon, 27 Apr 2026 03:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777261080;
	bh=3lD5uG9ZXrIgOwKv6Um8sK6s94l7Kup9XM0KiGIDbKk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:From;
	b=ueDIdW2QNALDTJ/C2+Pao0DLtIk/kUmxy2nFeMoFOMQSyhS2o72k/23L9IoqrjhQ+
	 eqhnZW+rv6AklFPQbXcCcP+Ra2rzb5EXUrhSUHOn7/4GzJ/n5EjPxiQCPFX4XmJIgl
	 YxVt1FGwO9KkqD0oEOIyDwqi6ShV5ZPOupOyJ0wnZ3ALzdo2D+8n2rA8d8Kkcgy8Zf
	 Ceu6H4sb3xZmrZGWLAEND5rlnksFEL/BNJOcHA7m+V8EpsGjqrRXR4/NrasNa7QIs3
	 IgBVuUGTdkaOD93o8vk5UvMfD5xZ/nJVd7hlni3sZCBTECxNdEiRlPuFBnuin+Upvm
	 QeVDF4WHotxzA==
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/9] kernel/api: introduce kernel API specification
 framework
From: Nathan Chancellor <nathan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 workflows@vger.kernel.org, tools@kernel.org, x86@kernel.org, 
 Thomas Gleixner <tglx@kernel.org>, "Paul E . McKenney" <paulmck@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Dmitry Vyukov <dvyukov@google.com>, 
 Randy Dunlap <rdunlap@infradead.org>, Cyril Hrubis <chrubis@suse.cz>, 
 Kees Cook <kees@kernel.org>, Jake Edge <jake@lwn.net>, 
 David Laight <david.laight.linux@gmail.com>, 
 Askar Safin <safinaskar@zohomail.com>, 
 Gabriele Paoloni <gpaoloni@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20260424165130.2306833-2-sashal@kernel.org>
References: <20260424165130.2306833-1-sashal@kernel.org>
 <20260424165130.2306833-2-sashal@kernel.org>
Date: Sun, 26 Apr 2026 23:37:45 -0400
Message-Id: <177726106581.2478607.12645653803520391071.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1542; i=nathan@kernel.org;
 h=from:subject:message-id; bh=3lD5uG9ZXrIgOwKv6Um8sK6s94l7Kup9XM0KiGIDbKk=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDJnvbgm1r5pyv/K7x/Tv7+cZzqk2VsnvUDl6munyJTXvs
 Koa+1qfjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCR/UYMf0U11lj1XX7AtCjO
 fXF2kv/PvgNKjmblB63e8+xfICtkfImRYVLPkjsTOQI7GiX0LqTO2iJ2suHBWkY15dq1Ir8eHhY
 8wA4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Rspamd-Queue-Id: 7E82846C831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6193-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-api@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linuxfoundation.org,lwn.net,google.com,infradead.org,suse.cz,gmail.com,zohomail.com,redhat.com,zeniv.linux.org.uk,linux-foundation.org,arndb.de];
	TAGGED_RCPT(0.00)[linux-api];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 12:51:21 -0400, Sasha Levin <sashal@kernel.org> wrote:
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 6785982013dc..564315153643 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -59,6 +59,9 @@ obj-y += dma/
>  obj-y += entry/
>  obj-y += unwind/
>  obj-$(CONFIG_MODULES) += module/
> +obj-$(CONFIG_KAPI_SPEC) += api/
> +# Ensure api/ is always cleaned even when CONFIG_KAPI_SPEC is not set
> +obj- += api/

If $(CONFIG_KAPI_SPEC) is not set, shouldn't

  obj-$(CONFIG_KAPI_SPEC) += api/

evaluate to

  obj- += api/

anyways? Why the duplication? This is the only place in the kernel where
this would be needed?

>
> diff --git a/kernel/api/.gitignore b/kernel/api/.gitignore
> new file mode 100644
> index 000000000000..ca2f632621cf
> --- /dev/null
> +++ b/kernel/api/.gitignore
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +/generated_api_specs.c

This appears unused?

>
> diff --git a/kernel/api/Kconfig b/kernel/api/Kconfig
> new file mode 100644
> index 000000000000..d1072728742a
> --- /dev/null
> +++ b/kernel/api/Kconfig
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Kernel API Specification Framework Configuration
> +#
> +
> +config KAPI_SPEC
> +	bool "Kernel API Specification Framework"
> +	default n

I think 'default n' is tautological since 'n' is the default for all
bool symbols. Consider dropping it on all symbols throughtout this file.

-- 
Nathan Chancellor <nathan@kernel.org>

