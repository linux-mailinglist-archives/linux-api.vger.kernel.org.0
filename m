Return-Path: <linux-api+bounces-6241-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEm7HOxr82lf2gEAu9opvQ
	(envelope-from <linux-api+bounces-6241-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 16:49:16 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A594A43C7
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 16:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7649B305B291
	for <lists+linux-api@lfdr.de>; Thu, 30 Apr 2026 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C2B43634B;
	Thu, 30 Apr 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPerCAOR"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BFA42EEC1;
	Thu, 30 Apr 2026 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560441; cv=none; b=OXh5x8ncAGrk7nG5MpvuciWXD3uIU3+CBJcHpZPuLl1rR6oMG4lAPDqEMmglOmqvaD1JRE4v+EshiVWRHsr1JdS/Yr1AxG0tYryvQac28s07GiYU59KCNqnRVB1HjDeWyyiOl3kV/S5SJ8hlBHo9XX16+q0N3ZbMaFSgnZG3APk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560441; c=relaxed/simple;
	bh=LvG3HOqNu0UzCHGfZ2qRDYFj/RVGrSdjMfxq3VZg+zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkv3CeksplCuxx3VXgSPsNHr+vQU0rzCE5UfnCFIcq6ZYXf97iA1PmiSvuqqLi9TDwJH5mLq8ZhG/e1GyVO+cYfSblcRjHCHCVtDU6oJYILW9tM8le2DFrz4+MgDfuI7lyFNJ4wKADhxUhttwizr2fzBk7QLynMUUOOzpPoTIYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPerCAOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682F3C2BCB3;
	Thu, 30 Apr 2026 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560441;
	bh=LvG3HOqNu0UzCHGfZ2qRDYFj/RVGrSdjMfxq3VZg+zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oPerCAORWZza9j0WOgJpGrUSp1UOirezpHM6qOt17YPK78AD+O5TN8VUnAI7m6ewN
	 wQuwh+su+PsXqhOlLvQf1c9yrsNSLW0uPoTpXVedUXKvWsiGdFNhz634mtZb4G+xTz
	 IqDqrF7Mx10o9Ehrkcl6jj1tm4p4cAQ/P56+OnEHmX2nSLT/Mvo63K4rzcTnkfY6dj
	 yYzfdG+h9C0jx1iXEe54RPJHd9jUF0tS1bcoHJm5fQuzoEOOOhmcTgDWDkzILIgVF6
	 jehXnZhzCxERFO89myv2cw6DyKiT0+Tcicv7CSPXsR8i3CW3dTv6zn3h7cyYnqE+4L
	 njBniwEYc+gyg==
Date: Wed, 29 Apr 2026 18:43:24 +0200
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
Subject: Re: [PATCH v3 1/9] kernel/api: introduce kernel API specification
 framework
Message-ID: <afI1LMB_vNMWYU7o@levanger>
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
 <20260424165130.2306833-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424165130.2306833-2-sashal@kernel.org>
X-Rspamd-Queue-Id: D0A594A43C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6241-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Fri, Apr 24, 2026 at 12:51:21PM -0400, Sasha Levin wrote:
...
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 6785982013dce..5643151536439 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -59,6 +59,9 @@ obj-y += dma/
>  obj-y += entry/
>  obj-y += unwind/
>  obj-$(CONFIG_MODULES) += module/
> +obj-$(CONFIG_KAPI_SPEC) += api/
> +# Ensure api/ is always cleaned even when CONFIG_KAPI_SPEC is not set
> +obj- += api/
>  
>  obj-$(CONFIG_KCMP) += kcmp.o
...
> diff --git a/kernel/api/Makefile b/kernel/api/Makefile
> new file mode 100644
> index 0000000000000..c0a13fc590e4a
> --- /dev/null
> +++ b/kernel/api/Makefile
> @@ -0,0 +1,14 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for the Kernel API Specification Framework
> +#
> +
> +# Core API specification framework
> +obj-$(CONFIG_KAPI_SPEC)		+= kernel_api_spec.o

Bike-shedding: I'd use 'obj-y' here, to state clearly that
kernel_api_spec.c is the core part in the kernel/api/ subdir.  If
CONFIG_KAPI_SPEC is unset, the subfir will not be entered at all.

-- 
Nicolas

