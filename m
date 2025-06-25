Return-Path: <linux-api+bounces-3993-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973C3AE89A3
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8908A3B2605
	for <lists+linux-api@lfdr.de>; Wed, 25 Jun 2025 16:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6583D2BE7D6;
	Wed, 25 Jun 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWgUjIe0"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3859D25C6EF;
	Wed, 25 Jun 2025 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750868602; cv=none; b=b6NocsqaSw5wKWpRzrWmZ9DvBYsmZePEyy4dkymajZuT8/NCfLBelh2CIKBW7NqAlg+1MMjePUdhdHS8EwgSHRcqwrvXBPJfzkln5V3TtG8CHI5mKqsmVA05uDAnh9JhfmE4QvUVE4lCkAceo7vGYYWGDj74KN7O8ujuEExBebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750868602; c=relaxed/simple;
	bh=5NEw5Y4/fL/U+B2YQeTnXJ4pW5OuGA13BjtZEU3aPwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOZ2i1v6U9ctLVTEU6wRaw3PFb4gHGOtZYUXpBDtn/24yrekxhLmh8DrGe4bjyNedSvVM3PArhPIi5b/DS37UGub3cCN8yrrF958c/AEoqAxXWTFZrTdhovCaUVV8iDMqLNOybJ6szo10oms6wGHD/ipQFREUYCwXmlUaCaLnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWgUjIe0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD81C4CEEA;
	Wed, 25 Jun 2025 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750868601;
	bh=5NEw5Y4/fL/U+B2YQeTnXJ4pW5OuGA13BjtZEU3aPwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HWgUjIe0i59ri+N4z4OA1Dc3OsR6hq2+pIFS65hgsHrWKfbOktC87/VQ0fIujf7xJ
	 5SdKmvSq0HQgQtlLcwsRnNXSdohLVxfalPKqPPnSsQ2IOZzJMDyG6OV8bEcYOTtOXj
	 6wfNZC8mqLTJJCuzpxJvr4zE4faOnlUHq3W4JulnASPVcb0pvMCEqMDgIMnRQS+yQ7
	 7lSW/WsssS23dtBrVy+esBMCoEEjB3TjCoXiWzdo0GUrbgJKCFQCRmI46j20cXr9LI
	 adHE0KLpyUpgMgOIrm+fLe2NFQ0dDNjjUHkaXtGgRYHH9hmSZBUSbKvMIdDDORtOch
	 QpXLigoRtzlQw==
Date: Wed, 25 Jun 2025 12:23:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kees@kernel.org, elver@google.com, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org, tools@kernel.org,
	workflows@vger.kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aFwid-sUdAbp9gmQ@lappy>
References: <aFNYQkbEctT6N0Hb@lappy>
 <20250623132803.26760-1-dvyukov@google.com>
 <aFsE0ogdbKupvt7o@lappy>
 <CACT4Y+bV-3HgNOAd+f7W0RBU2-qoocpMCepKhLEb+BcyiJM5Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACT4Y+bV-3HgNOAd+f7W0RBU2-qoocpMCepKhLEb+BcyiJM5Mg@mail.gmail.com>

On Wed, Jun 25, 2025 at 10:56:04AM +0200, Dmitry Vyukov wrote:
>On Tue, 24 Jun 2025 at 22:04, Sasha Levin <sashal@kernel.org> wrote:
>> >9. I see that syscalls and ioctls say:
>> >KAPI_CONTEXT(KAPI_CTX_PROCESS | KAPI_CTX_SLEEPABLE)
>> >Can't we make this implicit? Are there any other options?
>>
>> Maybe? I wasn't sure how we'd describe somthing like getpid() which
>> isn't supposed to sleep.
>>
>> >Similarly an ioctl description says it releases a mutex (.released = true,),
>> >all ioctls/syscalls must release all acquired mutexes, no?
>> >Generally, the less verbose the descriptions are, the higher chances of their survival.
>> >+Marco also works static compiler-enforced lock checking annotations,
>> >I wonder if they can be used to describe this in a more useful way.
>>
>> I was thinking about stuff like futex or flock which can return with a
>> lock back to userspace.
>
>I see, this makes sense. Then I would go with explicitly specifying
>rare uncommon cases instead, and require 99% of common cases be the
>default that does not require saying anything.
>
>E.g. KAPI_CTX_NON_SLEEPABLE, .not_released = true.
>
>KAPI_CTX_NON_SLEEPABLE looks useful, since it allows easy validation:
>set current flag, and BUG on any attempt to sleep when the flag is set
>(lockdep probably already has required pieces for this).

Yup, that makes sense. One of the reason I wrapped all the field
assignments with macros is that we can easily customize them based on
usage, so instead of:

	#define KAPI_LOCK_ACQUIRED \
         	        .acquired = true,

	#define KAPI_LOCK_RELEASED \
         	        .released = true,

We can add:

	#define KAPI_LOCK_USED \
			.acquired = true, \
			.released = true,

-- 
Thanks,
Sasha

