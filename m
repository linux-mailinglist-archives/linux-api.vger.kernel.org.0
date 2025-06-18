Return-Path: <linux-api+bounces-3942-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005F5ADF8BD
	for <lists+linux-api@lfdr.de>; Wed, 18 Jun 2025 23:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A252516990E
	for <lists+linux-api@lfdr.de>; Wed, 18 Jun 2025 21:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157CF27BF7C;
	Wed, 18 Jun 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2WXLjQh"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD171B78F3;
	Wed, 18 Jun 2025 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282178; cv=none; b=VUVEKVkr9LjksL8hzEmhuMaa+UIg5fC4gYi5hw4CM9nqLrCE8f0qyHKqBH9k6BvIqjAQC04iVeNi3PmkiGFZS5kDHvwCSGthbyzGt6hsadChhkDYytLr/EfFLybEclBgUo+STpW4xO8/MX1vnjCuCldCPqd9+A88kVQuJuNVEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282178; c=relaxed/simple;
	bh=kWtZsjCnLnaUDpRLL9iX4OQ4gVYX0SYJ72y/3tn1/Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fO0XlT/T5YkdL3YJdHmwdDWVqIA2F+lFyJI91lWS43x69a1YSwXPUk3J+okGN0kAQ3oZnfW9LuTvvKYY1EuExECr2vaz+NIhAoQagJx8TH0PvnPD0reABbD+ozP5fdg4couk2yHrdR64bd7j8I2gCErNKN87XkLc0iTBJaJX1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2WXLjQh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A595C4CEEF;
	Wed, 18 Jun 2025 21:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750282177;
	bh=kWtZsjCnLnaUDpRLL9iX4OQ4gVYX0SYJ72y/3tn1/Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K2WXLjQhw222zqK4ROk0UaGGcQNpEmWmV+eTa73ysBYSwFeBx7Drxnnw6tKsd8DHu
	 isETSjNa/uKuDOlFnaqxCEEDYUUpjA+z64bLFevRdJ+WxGKiOlvdLon3SWqPxEnAGA
	 rhrZsx+Qb5Z20SXCNEu8UPe+WNIYq5RrD8tCPTTQy7VYlkRxI+5lN6ndnduu0XqcYP
	 pgdsVQS2cw2YA5yuDm+NsgBf1NV1/DIlt/kcFWQYHNqnRSDbSrSYpYDOO7bs+X2Mdc
	 iK1ulfXQR12zPLsAMGMqpV6GbWr1p5SGi0RxLxYcWDV+trRhLj9us+AzWhPBNNRH1I
	 F5g5O58vMGW9w==
Date: Wed, 18 Jun 2025 14:29:37 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC 00/19] Kernel API Specification Framework
Message-ID: <202506181428.3D086D2@keescook>
References: <20250614134858.790460-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614134858.790460-1-sashal@kernel.org>

On Sat, Jun 14, 2025 at 09:48:39AM -0400, Sasha Levin wrote:
> This patch series introduces a framework for formally specifying kernel
> APIs, addressing the long-standing challenge of maintaining stable
> interfaces between the kernel and user-space programs. As outlined in
> previous discussions about kernel ABI stability, the lack of
> machine-readable API specifications has led to inadvertent breakages and
> inconsistent validation across system calls and IOCTLs.

I'd much prefer this be more attached to the code in question, otherwise
we've go two things to update when changes happen. (Well, 3, since
kern-doc already needs updating too.)

Can't we collect error codes programmatically through control flow
analysis? Argument mapping is already present in the SYSCALL macros,
etc. Let's not repeat this info.

-Kees

-- 
Kees Cook

