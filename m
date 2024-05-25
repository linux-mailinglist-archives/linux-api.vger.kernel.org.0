Return-Path: <linux-api+bounces-1601-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB2B8CEEA6
	for <lists+linux-api@lfdr.de>; Sat, 25 May 2024 13:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3351C20A8A
	for <lists+linux-api@lfdr.de>; Sat, 25 May 2024 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AF131A83;
	Sat, 25 May 2024 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="K8OssRaN"
X-Original-To: linux-api@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22040208CA;
	Sat, 25 May 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716636324; cv=none; b=B2jyME4JtvPipdiXampFliE750DHPZsXGzbEJOp2VMLvYXv0mvKbccPD4TD1RS4ZnmhUSAO/tF08F4kgZxJHuzkGvOa3fIDPyI5Zg+PNsXrvCTjuRig45oPl7r9jrCNeCGH6v653156ktjgKe8ubtqeCeB3j5UyHea82t78YQyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716636324; c=relaxed/simple;
	bh=lyAM/tBraUaivTSqVpDtdzYQDwPph0gQ4F1yGKtmYvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAs8uaP4LinHhdgEHocjlq8F91lFITyiXHYJgyTgwOMW5bQNc5gVA+ksknU8t2tKE01oCu5muGNYXpUSU+6Y/aN7ccIlIjHKo1YokrB4beUoWfjDyak7TWvCvybiEodBo0TajAF3cQip8KdIwWEJgG4gqkA/Vmn9Vxjqnfu6jrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=K8OssRaN; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Reply-To:Content-ID:Content-Description;
	bh=zCkqzdYte65um3TtRP0XYZF8yZbFnXz5HUvdaLbNJr4=; b=K8OssRaNgSBfwKviWP02A2CM7+
	ZCubjH/HFYfnl65AOFifLwmuvZtNbfBOGOKfN8NIH5F4qZCDYOSRt+kCeum8hY3zqyst8+knLZwb+
	a6uBCPYhJaVlCychknk9PUd9OJ6bL1ZihKHzJVskD+VuyqueGoA3G1by/Q3RSLEt3XNapqaXJrNhg
	6PRfKndPICr+4Mo2NXIBIw5QiCNvZPsq52OjKZ48FhmeTWfkGmKCjTvPSvBCLb7VkHLFL1UTab6/8
	bqLQYeNzYqrgsHaWLuOjb5ouQpSIsa0/c3qAD4Ut7ynFZzeneCvbgXLjW2sd1iqdoZTyfWQAwiLHd
	ZQ6Ono0w==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <bage@debian.org>)
	id 1sApWK-00GNrA-Tx; Sat, 25 May 2024 11:25:05 +0000
Message-ID: <57f845bb-9b67-4c09-9e21-701872c936e3@debian.org>
Date: Sat, 25 May 2024 13:25:01 +0200
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xfs_io: make MADV_SOFT_OFFLINE conditional
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20240522223748.9986-1-bage@debian.org>
 <ZlBNPDomQpTfAmt2@infradead.org>
Content-Language: de-DE
From: Bastian Germann <bage@debian.org>
In-Reply-To: <ZlBNPDomQpTfAmt2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Debian-User: bage

Am 24.05.24 um 10:18 schrieb Christoph Hellwig:
>> +#ifdef MADV_SOFT_OFFLINE
> 
> Can you add a comment here that this is missing on mips as of Linux
> 6.9?

Sure.

> Also adding the mips maintainer so he can add it, as missing a madvise
> random feature on a random architecture looks like a bug that should be
> fixed.

There are more of this class of bugs which f82b77462b ("tools include:
Add mman macros needed by perf for all arch") presents.


