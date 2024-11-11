Return-Path: <linux-api+bounces-2709-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F42E9C4A4D
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 01:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E51D8B320C9
	for <lists+linux-api@lfdr.de>; Mon, 11 Nov 2024 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640BA1C32FD;
	Mon, 11 Nov 2024 23:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YvNu/gRt"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28321586CB;
	Mon, 11 Nov 2024 23:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369171; cv=none; b=T990Cy742/R50sKCZDVaRhzIZaubPV201qYCKlh6+U5+1AMEbVZt1x566UTvAe89MOls2c483IIffcVYYjKCI+ezsWtMvJls7Klj7oAy9K2gMrbS6SjRxpggUGSK17yYEWtFlgYpOcycbxUtVz2mzKa53cFo3elyprzu6XVZ1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369171; c=relaxed/simple;
	bh=jlAmQRZrJ2ZxcDYDXp3ea4ffAwt67+Lvb9k02TzY9ZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cOUuz0aUfNGLD3kMVrxtZZkXOnWWoAob+Dc9hAYEmS72pFdJHsBvCAdSx0n3PL/c2jet7qT0RAYIsYIMIyXgCo2rcE0mIMyRyQOpDJFmsj+A3lYgTNPt9EHs7Obfi5qp17/Swn7oefkKNxAMe6nVcXJVZs5jzzcdkRgHA2HtQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YvNu/gRt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description;
	bh=jX484nqoDiY+8og5lcWFPnkxz2lRqxD21umrzFzFsPY=; b=YvNu/gRte/AYvNsl0rEVHUBHV+
	bn7B+KonplxN9lOStu3de41szebkiWjpD/ObqKscNTIC6uWufO2qdgvID2Nuvn9EjHhDgdi+kcAxU
	qdNc3VKl5DOuBpMQ9IzIiaf3UNKudl0HQfSENo6d53YDjlIm5FIbTuIBz9nR0sJazPJc4h4kSqbfv
	EjiKnzqgmv/ZC3umNnGFGOPHRxyRKdhCRFsUcK2qVW2G0lo4vtvpSqNWhoDvQoSysNu3Csx5mSuya
	0Jj20l/1FALg2SCZ2VQkUA4mUK2CxQyP0D+ckNEx9E5H9m3JiQQJRP/G9IuRo1C9+WqGng4nj2Yj9
	XZ+AjdsA==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tAeD8-0000000DVrk-0Q9a;
	Mon, 11 Nov 2024 23:52:46 +0000
Message-ID: <a405a8e6-7420-468d-be16-2bf1d73b7cbd@infradead.org>
Date: Mon, 11 Nov 2024 15:52:34 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
 linux-api@vger.kernel.org
References: <20241111234006.5942-1-ouster@cs.stanford.edu>
 <20241111234006.5942-13-ouster@cs.stanford.edu>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20241111234006.5942-13-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi John,

On 11/11/24 3:40 PM, John Ousterhout wrote:
> diff --git a/net/homa/Kconfig b/net/homa/Kconfig
> new file mode 100644
> index 000000000000..8ba81b00d35f
> --- /dev/null
> +++ b/net/homa/Kconfig
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +#
> +# Homa transport protocol
> +#
> +
> +menuconfig HOMA
> +	tristate "The Homa transport protocol"
> +	depends on INET
> +	depends on IPV6
> +
> +	help
> +	Homa is a network transport protocol for communication within
> +	a datacenter. It provides significantly lower latency than TCP,
> +	particularly for workloads containing a mixture of large and small
> +	messages operating at high network utilization. For more information
> +	see the homa(7) man page or checkout the Homa Wiki at
> +	https://homa-transport.atlassian.net/wiki/spaces/HOMA/overview.
> +
> +	If unsure, say N.

Kconfig help text should be indented with one tab + 2 spaces, please. (Everything
below the "help" line.) This is in Documentation/process/coding-style.rst.

-- 
~Randy


