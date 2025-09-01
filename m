Return-Path: <linux-api+bounces-4665-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21149B3ED57
	for <lists+linux-api@lfdr.de>; Mon,  1 Sep 2025 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A644118906F6
	for <lists+linux-api@lfdr.de>; Mon,  1 Sep 2025 17:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545D31AF21;
	Mon,  1 Sep 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ee3+eShP"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0943923D7E0;
	Mon,  1 Sep 2025 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756747408; cv=none; b=CGkV3hWCuiQFb2ZT40rE9D4Dzi+BroMZZIaoCH0fiTExL0Idw1F1tM09OEVvBH5o8zv3ntsb2kzY7NhWuIkYbbelKmXFbQHN6CAf1TaX9SY8m4n3/UKWb9zmx2725KLjCgTMzI5bYDMsT2ugyIbaZBwsvo2TT/dYwuiA1jGGZh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756747408; c=relaxed/simple;
	bh=eZMY51Z9juhLN4ZzmeceGECGhx75v3KLJ5uEsIpdcy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lMMSjXxfcAFwqPQq/ljet0s8L99CCqnXAc9YEo2BSj09oWMaPEltuDwqbjKI0LlieuHb+ejot3nIhUcnwdjw+hCaDQyuBxqArh8coghhUkk5nBcdsuB9DBq0f+yIfe9HSjMxpCzV+/PZkkla3NqctS808pxQQTT481tx9sxF0UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ee3+eShP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=Gn3wPdX1s5I7kPmdGt5b0zk8t+F65wuEyKTsLsUvYSI=; b=ee3+eShP5E6IgTejJNXPjV5Oa4
	jU2hsCDwNdtzcObW2oo27AEgEe2Wob1V7csKJc0SUQ8X5VK0VbIwZRv/IqXoFzJri5yVDZ6Lvwppy
	ULFCukyEM9Atw9WkmMvLa7YkXZQCsI0cCprZ1Yw/RB89GmN0x7KWwnxZcxpUXyEkRZjpSW//gJvG9
	n8qI3odcNU3T6ZgAegSYGY8HVfn1yvSTsdQgC05QyWEhZtFYkoDXHShPbhT26gloqWEizN94mStSb
	TtplscEyNkwqNMuM3Slwu8x4lHU9zkZ2I4XbZgDFsvXbq+TcVLhLF0mNCRxsvsyPJQCBNoaHaLhRx
	iWeJXrDA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut8Fa-0000000DRvI-2k2W;
	Mon, 01 Sep 2025 17:23:26 +0000
Message-ID: <8d8b9cac-695c-469e-a831-c226b796430b@infradead.org>
Date: Mon, 1 Sep 2025 10:23:26 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/7] kernel/api: introduce kernel API specification
 framework
To: Sasha Levin <sashal@kernel.org>, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, tools@kernel.org
References: <20250825181434.3340805-1-sashal@kernel.org>
 <20250825181434.3340805-2-sashal@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250825181434.3340805-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,


On 8/25/25 11:14 AM, Sasha Levin wrote:
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
>  .gitignore                                    |    1 +
>  Documentation/admin-guide/kernel-api-spec.rst |  507 ++++++

To me, none of this feels like Documentation/admin-guide/ material.
I don't think that many sysadmins will be using it.

Maybe Documentation/dev-tools/ ?
Closer to developer material that admin?


>  MAINTAINERS                                   |    9 +
>  arch/um/kernel/dyn.lds.S                      |    3 +
>  arch/um/kernel/uml.lds.S                      |    3 +
>  arch/x86/kernel/vmlinux.lds.S                 |    3 +
>  include/asm-generic/vmlinux.lds.h             |   20 +
>  include/linux/kernel_api_spec.h               | 1559 +++++++++++++++++
>  include/linux/syscall_api_spec.h              |  125 ++
>  include/linux/syscalls.h                      |   38 +
>  init/Kconfig                                  |    2 +
>  kernel/Makefile                               |    1 +
>  kernel/api/Kconfig                            |   35 +
>  kernel/api/Makefile                           |    7 +
>  kernel/api/kernel_api_spec.c                  | 1155 ++++++++++++
>  15 files changed, 3468 insertions(+)
>  create mode 100644 Documentation/admin-guide/kernel-api-spec.rst
>  create mode 100644 include/linux/kernel_api_spec.h
>  create mode 100644 include/linux/syscall_api_spec.h
>  create mode 100644 kernel/api/Kconfig
>  create mode 100644 kernel/api/Makefile
>  create mode 100644 kernel/api/kernel_api_spec.c
thanks.
-- 
~Randy


