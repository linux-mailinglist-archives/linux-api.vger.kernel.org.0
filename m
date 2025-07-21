Return-Path: <linux-api+bounces-4179-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB79B0BB52
	for <lists+linux-api@lfdr.de>; Mon, 21 Jul 2025 05:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6318B175A64
	for <lists+linux-api@lfdr.de>; Mon, 21 Jul 2025 03:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCECD1D9324;
	Mon, 21 Jul 2025 03:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gPO30vjv"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4010C1EB3D;
	Mon, 21 Jul 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067870; cv=none; b=FwYYLdFUKS2MfT99T/f6hMOPjDL2tWsBn3o/pXJiqbpgY+FImIJYZVr59hUHzhmFlPZbVapYJ0xm8/zleuErDAvLSdN7XzaUIrCQiZUE6oJEqRajeBIp8w0s69UXfrBJss3PZDUW0OFRg3wb4IZ8u67wquYuqYbr9IGIi14Ksgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067870; c=relaxed/simple;
	bh=wpAdoRWYOK8RLceMDgpibClmIJceDZvfzE56j2kutEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHo3emXrA7f9Z7GLBEs2FTnf5/kcV73ENz1kTC3MYEzvkB/gAw2evxHgrOhV3+GwIOzU2hMPaG0qoBeZaLqLksYMKFoWukQ/JLoux4bfVkTT0XZQEnccYZ5zyuR51vt9fRCrYXKV/Jz5qcA2yhOagrVYFNhnnQtO5BWD6gkB9Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gPO30vjv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YUQtc+jeUFA1Sjc8QeVJ2qxxTnEDp9lcdumo1CrlvHY=; b=gPO30vjvhAnDRdKnYIGKdso8Ag
	LMDXwPee2moTibXtgQ5dIWMlV3ixOkcv+WNH6KmuuiFMsdr0SV5oL5hAIKfOOZ5uDmdkjZtubhp5T
	TG1IZXKBFwHhcnOjIbHtnUC2hv5K3gYuNdTBYUSzAUDAmlIH6MKJPrfJ655B6tPr2Cu9aj0ALCoSz
	W/0zMOGz18Q2gfV8uiOHF0/vdaiHpT5+JsOFq6GscupHiU6wWLK/B7IUWfAXm4wSlc6EfeXD4Ckmu
	wopr0JtcpHoBQSwg7Qe0hDrZ0XVfOsiATbzm/HObFoJYClHtilXNQmeFCumcMntSUCACN6rMpDBvn
	2VleO7Fg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udh2C-0000000G4rQ-319a;
	Mon, 21 Jul 2025 03:17:48 +0000
Message-ID: <4cb78517-6d24-4239-9a6c-2b58439e199e@infradead.org>
Date: Sun, 20 Jul 2025 20:17:48 -0700
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 2/4] kernel/api: enable kerneldoc-based API
 specifications
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-api@vger.kernel.org, tools@kernel.org
References: <20250711114248.2288591-1-sashal@kernel.org>
 <20250711114248.2288591-3-sashal@kernel.org>
 <4777f4d7-f1c6-4345-92b2-0ba5d6563ee2@infradead.org> <aH2r55bjqqtKxOEQ@lappy>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aH2r55bjqqtKxOEQ@lappy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/20/25 7:54 PM, Sasha Levin wrote:
>> 2. It looks like it only checks .c files, omitting header files. (?)
>> Some APIs are only present in header files (e.g., all of <linux/list.h> is
>> either macros or inline functions).
> 
> I was trying to focus on the userspace side of things, so I didn't think
> we'll have anything in header files, but I also don't have an objection
> to extending it to scan headers too.

That's probably sufficient, at least for now.

Thanks.
-- 
~Randy


