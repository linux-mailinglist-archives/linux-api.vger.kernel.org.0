Return-Path: <linux-api+bounces-3943-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 720B8ADFA13
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 02:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3E63B62D8
	for <lists+linux-api@lfdr.de>; Thu, 19 Jun 2025 00:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A243BBC9;
	Thu, 19 Jun 2025 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5ajh52L"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575BD29A0;
	Thu, 19 Jun 2025 00:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292548; cv=none; b=f+v8NhHyKyNur4z4zkLjLAtvLleXepEbxaWLinCoP1hhfvTGCtODhb7yJ2kmxKXto0wB1rDTihxuEI71w8OIKnI5+eOko9Jz87uPeYmaxvPQQqszPYIaB2XGjxasK+u3L7bsldB7csGwUQgn6RxUICP9NIxemUWF2OnX0WjXquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292548; c=relaxed/simple;
	bh=ELKdNLqP5T0nWWzqSxWQiZDhJ2ioVhlaFehp8S7/p8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fpLkm1xD73CDHVmmPOAMLni4+NloNLjlDi17R6FQVIAeqXaWJZZfUXEB5ipUuwRxEGe3q+KAPnyH103eUM/JXHOcuNaaZcu3FFyCaLpeYo7hNoY5Lp1PS3E3a9uOyRdUNCFg7kJJp6MldHnTqZ8RYDaMmRICsNYH+QCL6NRK2fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5ajh52L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26D5C4CEE7;
	Thu, 19 Jun 2025 00:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750292548;
	bh=ELKdNLqP5T0nWWzqSxWQiZDhJ2ioVhlaFehp8S7/p8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O5ajh52LgszoU0XGehCmLBnR4V2q7h6YFM5VOSic4qbNhZ0Dsv0g6eao27YdlYEfE
	 R8EI6jk4U+GScmSiKl/knaK27CGUicJaolYCgwIn7G+lWMrQ5TiZhLgbZrSMQWaW4d
	 7QKKHJa/tJ2PHzSw7g5z7m56adZkX/ntRkO6OfpJwAre30heT04MSJV1xR40sYMzgL
	 FTkfAkW3Hjt8ypeHpYiWQsHlFbrQPKcUt3u2zg47N20yKgjc3TjfI/2k8ht4SyZIn/
	 q/XHckXX+aza68N0CYVPUZVToZrLpN3nctbZcL7K3ABn9gKXvQNMabXR/02Skx+EWL
	 hOD8BH+RCSZ7Q==
Date: Wed, 18 Jun 2025 20:22:26 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <aFNYQkbEctT6N0Hb@lappy>
References: <20250614134858.790460-1-sashal@kernel.org>
 <202506181428.3D086D2@keescook>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202506181428.3D086D2@keescook>

On Wed, Jun 18, 2025 at 02:29:37PM -0700, Kees Cook wrote:
>On Sat, Jun 14, 2025 at 09:48:39AM -0400, Sasha Levin wrote:
>> This patch series introduces a framework for formally specifying kernel
>> APIs, addressing the long-standing challenge of maintaining stable
>> interfaces between the kernel and user-space programs. As outlined in
>> previous discussions about kernel ABI stability, the lack of
>> machine-readable API specifications has led to inadvertent breakages and
>> inconsistent validation across system calls and IOCTLs.
>
>I'd much prefer this be more attached to the code in question, otherwise
>we've go two things to update when changes happen. (Well, 3, since
>kern-doc already needs updating too.)
>
>Can't we collect error codes programmatically through control flow
>analysis? Argument mapping is already present in the SYSCALL macros,

I'm not sure what you meant with in the control flow analysis part: we
have code to verify that the return value from the macro matches one of
the ones defined in the spec.

>etc. Let's not repeat this info.

I tried to come up with a way to get rid of the SYSCALL_DEFINEx() macro
right after the spec. I agree that it's duplication, but my macro-foo is
too weak to get rid of that SYSCALL_DEFINE() call.

Suggestions more than welcome here: I suspect that this might require a
bigger change in the code, but I'm still trying to figure it out.

-- 
Thanks,
Sasha

