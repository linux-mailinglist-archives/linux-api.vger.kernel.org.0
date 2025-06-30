Return-Path: <linux-api+bounces-4069-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8FEAEE7C8
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA43AA292
	for <lists+linux-api@lfdr.de>; Mon, 30 Jun 2025 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C002E7F1D;
	Mon, 30 Jun 2025 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="XM1ypRQA"
X-Original-To: linux-api@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D02E62A8;
	Mon, 30 Jun 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751313244; cv=none; b=ZpkiJff8d0BghtPPTKUF1xKtpTHUSzi/QO/lxWTSyq+JgHFtaWP+AnPImYBKgXApgwQg453RlMcAnROq9vXujpk6RmSKl8EuE/9QwDJrA8MdXQRLsvcVXA3TsKd0Aj3dBbI0TObEzlTuMWrTou2869hM7s7bZ4aLxgwXxoIfx/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751313244; c=relaxed/simple;
	bh=uwD4EB7qeLbNQseoCWLzTOg8p8VXSbBg87IayVw7GZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oAhc/VJj2YTEEeNmrGHbRBrBN8qudVmv3WDt9tmAJNKH/YaLfn33oYFf/YTepIXOBkDB/estAkBpIy/AmCy76L/SaUY1aJGF2M/401TdzCArTp5WypIfQpRihNWrb5vMz6z47hqd/UUBuLsndC+B2ayCtxfP6atKT9S3PyVks/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=XM1ypRQA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F38E840AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1751313236; bh=GMvN0AXDkYgDCFr8PgBdrQXd3tKnGTsHMEO1Qblze+s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XM1ypRQAgYusaeH3a8VPd5JgRYaKI2j5aRCJ4ouDYpn283Sbj844CuZzL0zVShkSq
	 UH/BLbjwL1depkV7WJrbq5y73QIVz5ZlYww+ynyAzTyJPhMdF2K4/keCehVnvmoE/n
	 7l3LXU7A/gccuzallOIPE+7xzJvQZRvSUICAAjG2pMm0xBGvtuuqsM/6rSknyJ43wH
	 RVO9XumqTJKQ1Idc1DA5OhtFrAZcE8WiaZ4oA3y0GxANjUmv+BftBwR3D2NZJ+2be0
	 hxn1Q8KV2es9GM8bH5fZLrQvW9gw3s3U7QNx+l+nyAi4o2Iy2UiLnx7tKozUKh21tU
	 kHrpDBXuZ0oGQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id F38E840AB5;
	Mon, 30 Jun 2025 19:53:55 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org
Cc: linux-doc@vger.kernel.org, linux-api@vger.kernel.org,
 workflows@vger.kernel.org, tools@kernel.org, Sasha Levin
 <sashal@kernel.org>
Subject: Re: [RFC v2 01/22] kernel/api: introduce kernel API specification
 framework
In-Reply-To: <20250624180742.5795-2-sashal@kernel.org>
References: <20250624180742.5795-1-sashal@kernel.org>
 <20250624180742.5795-2-sashal@kernel.org>
Date: Mon, 30 Jun 2025 13:53:55 -0600
Message-ID: <874ivxuht8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sasha Levin <sashal@kernel.org> writes:

> Add a comprehensive framework for formally documenting kernel APIs with
> inline specifications. This framework provides:
>
> - Structured API documentation with parameter specifications, return
>   values, error conditions, and execution context requirements
> - Runtime validation capabilities for debugging (CONFIG_KAPI_RUNTIME_CHECKS)
> - Export of specifications via debugfs for tooling integration
> - Support for both internal kernel APIs and system calls
>
> The framework stores specifications in a dedicated ELF section and
> provides infrastructure for:
> - Compile-time validation of specifications
> - Runtime querying of API documentation
> - Machine-readable export formats
> - Integration with existing SYSCALL_DEFINE macros
>
> This commit introduces the core infrastructure without modifying any
> existing APIs. Subsequent patches will add specifications to individual
> subsystems.
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  Documentation/admin-guide/kernel-api-spec.rst |  507 ++++++

You need to add that file to index.rst in that directory or it won't be
pulled into the docs build.

Wouldn't it be nice to integrate all this stuff with out existing
kerneldoc mechanism...? :)

Thanks,

jon

