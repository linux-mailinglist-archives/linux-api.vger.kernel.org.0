Return-Path: <linux-api+bounces-4102-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4D4AF0343
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 21:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867D07ABB2C
	for <lists+linux-api@lfdr.de>; Tue,  1 Jul 2025 19:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76BF27EFF8;
	Tue,  1 Jul 2025 19:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iTIHb/n0"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF5192D83;
	Tue,  1 Jul 2025 19:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751396490; cv=none; b=u5eqMoO5dcrRe8IER1O8I9H3Sgrkkuu1fqtmQuBUtUA/dvRPo/Vp7YpRKet5Rnvrru6TV/FnSVVHCsvhCblfp/WzpBNMMjpT/b/zA5bhuj7LxqgkO6Hq9Kh/3coyA+LxFjCpMOPBhkn2YwlnMAcZ/7ioERxCklzKrWwGNGKbS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751396490; c=relaxed/simple;
	bh=RJaVPtGb3C3lD2/oNj9Z+/nGEwvMchUXnR403nuVrDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bQ4+7l3HAfP0GxdBI9+vnaYyJBpZCSQ37V8D0H4V5XNn98VOmpXkcjCowqHDw7iX2n2n73T5Hj2jATNTLm7LC/2g58ZDm+aKurifzZnQC014fe22NSGIWqGVmIFb9MOYuUKzsU5BR79KHvtxIZl2fKEp9cpeHehzLJwafq7Y2FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iTIHb/n0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3313A406FC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751396488; bh=AKQMQgwVK0BBJcKy+Wwq7VmMjNSf6AqvL851J0rFTV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iTIHb/n0YM9EyHbvYBXHGYEsxHvqtJEmFF8WE3+PCYcGwdNAPtYmR+X1V31fGLCtO
	 BEPQtK+bSzI2yfNs31QrghhzokrGDjzTCiEM9l5J/UXCPGgCSymW0tN3vZADa0Xvxn
	 E5XdJA/vao9W0QB8NUjgnsQP/267slptelxaMPRGxquMw+1je5GlYxSejVeFII7s95
	 lHSNFQuA0uIyuakn3gYRva/XyLvYzW8g0WkyxgzAryL8qaARhkPfE1iGvOlr03I/QR
	 jbxzLEcpi9S0BykP8lEj+E75yubRMHewCnk9ByFGonSwAw43jy6qntjc7N13drLdxn
	 WrIVZATyDhHPA==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3313A406FC;
	Tue,  1 Jul 2025 19:01:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org, workflows@vger.kernel.org, tools@kernel.org,
 Kate Stewart <kstewart@linuxfoundation.org>, Gabriele Paoloni
 <gpaoloni@redhat.com>, Chuck Wolber <chuckwolber@gmail.com>
Subject: Re: [RFC v2 01/22] kernel/api: introduce kernel API specification
 framework
In-Reply-To: <aGPvR-Mj6aR4Y8B5@lappy>
References: <20250624180742.5795-1-sashal@kernel.org>
 <20250624180742.5795-2-sashal@kernel.org> <874ivxuht8.fsf@trenco.lwn.net>
 <20250701002058.1cae5a7e@foz.lan> <aGPvR-Mj6aR4Y8B5@lappy>
Date: Tue, 01 Jul 2025 13:01:27 -0600
Message-ID: <8734bfspko.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[Adding some of the ELISA folks, who are working in a related area and
might have thoughts on this.  You can find the patch series under
discussion at:

  https://lore.kernel.org/all/20250624180742.5795-1-sashal@kernel.org

]

Sasha Levin <sashal@kernel.org> writes:

> 1. Add new section patterns to doc_sect regex in to include API
> specification sections: api-type, api-version, param-type, param-flags,
> param-constraint, error-code, capability, signal, lock-req, since...

Easily enough done - you can never have too many regexes :)

> 2. Create new output module (scripts/lib/kdoc/kdoc_apispec.py?) to
> generate C macro invocations from parsed data.
>
> Which will generate output like:
>
>     DEFINE_KERNEL_API_SPEC(function_name)
>         KAPI_DESCRIPTION("...") 
>         KAPI_PARAM(0, "name", "type", "desc")
>             KAPI_PARAM_TYPE(KAPI_TYPE_INT)
>             KAPI_PARAM_FLAGS(KAPI_PARAM_IN)
>         KAPI_PARAM_END
>     KAPI_END_SPEC 

Also shouldn't be all that hard.

> 3. And then via makefile we can: 
>     - Generate API specs from kerneldoc comments
>     - Include generated specs conditionally based on CONFIG_KERNEL_API_SPEC
>
> Allowing us to just have these in the relevant source files:
>     #ifdef CONFIG_KERNEL_API_SPEC
>     #include "socket.apispec.h"
>     #endif

...seems like it should work.

> In theory, all of that will let us have something like the following in
> kerneldoc:
>
> - @api-type: syscall
> - @api-version: 1
> - @context-flags: KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE
> - @param-type: family, KAPI_TYPE_INT
> - @param-flags: family, KAPI_PARAM_IN
> - @param-range: family, 0, 45
> - @param-mask: type, SOCK_TYPE_MASK | SOCK_CLOEXEC | SOCK_NONBLOCK
> - @error-code: -EAFNOSUPPORT, "Address family not supported"
> - @error-condition: -EAFNOSUPPORT, "family < 0 || family >= NPROTO"
> - @capability: CAP_NET_RAW, KAPI_CAP_GRANT_PERMISSION
> - @capability-allows: CAP_NET_RAW, "Create SOCK_RAW sockets"
> - @since: 2.0
> - @return-type: KAPI_TYPE_FD
> - @return-check: KAPI_RETURN_ERROR_CHECK
>
> How does it sound? I'm pretty excited about the possiblity to align this
> with kerneldoc. Please poke holes in the plan :)

I think we could do it without all the @signs.  We'd also want to see
how well we could integrate that information with the minimal structure
we already have: getting the return-value information into the Returns:
section, for example, and tying the parameter constraints to the
parameter descriptions we already have.

The other thing I would really like to see, to the extent we can, is
that a bunch of patches adding all this data to the source will actually
be accepted by the relevant maintainers.  It would be a shame to get all
this infrastructure into place, then have things stall out due to
maintainer pushback.  Maybe you should start by annotating the
scheduler-related system calls; if that works the rest should be a piece
of cake :)

Thanks,

jon

