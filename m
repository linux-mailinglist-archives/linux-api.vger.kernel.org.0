Return-Path: <linux-api+bounces-3242-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A817A3ACE9
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2025 00:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44F89188C6E5
	for <lists+linux-api@lfdr.de>; Tue, 18 Feb 2025 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E3131DC184;
	Tue, 18 Feb 2025 23:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="beFRfKIp"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26671A8F6D;
	Tue, 18 Feb 2025 23:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923068; cv=none; b=VDEqFzcfKYpuRypPbbkq18WgCyM2PFS3FS+yKUrLPwDDkx7mc3D0oN4M6dBars3PZLL60KbfTotMU0o6QTIuz2EGlh1ajUCKizYKy9XoIwJOWKr51PnvDOLPeF/4wVIJ8rPhZ5BoYHwDyccuKuns/GvDfbtdWDBGQTtF8fYFk2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923068; c=relaxed/simple;
	bh=e9Scv+eAu9ME6/BW8di5Qlh9xBT/ZlYHOwKeekqAKEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZTVWvqJt166/ou8BdUOYQoycT5XVmmdkSs3GxdqurnPz/L0cfcuc5/y1lT3fKZe91Z3zNfokIOsXA8nGL0Xq9dy/xHAepbwJGpnZnMmAWqqrpMSDeGAqrjpannPrAFUS8xhwx2xNDtmUqvfiVdoBdZuuK7QElvS5/juqCn5TfIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=beFRfKIp; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=f8V96M1dNZ/nDV9/9O0iW1J6fywepGaauBM99maMCPQ=; b=beFRfKIpyWei/AqaxjdVB1+t7R
	myVQ+O8u5GMBnjskUEmNlLfY2k+BjDYJ7w99yJukhUdZfNzVclUJYwTLt5ozKiqSyOnHHHUVnuATY
	s1PkyXMVtxNW1TaPbjkZ7DWF4CxFIQbBMieRn4zalDn8sDu321MTv6bk3r3O1ywLLMeFLEpXnYKrG
	g0KSQUirG3qstUAAXwr96d6E0RHjQojV8gp5Q58FIJ8fmjeY7HPsF+jufg2LFkgsHb/eMw1QZGMZm
	cObsCE9Uhe9+0UvFvVbB4PY8Y951NMvQIwx7/K41+Nd03w3YYn1vWo0cWFSBd0wgUwS7s1L3i7MLO
	wgotkd9g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tkXT1-00Agzb-2A;
	Tue, 18 Feb 2025 17:57:31 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Mike Lothian <mike@fireburn.co.uk>
Cc: Mike Lothian <mike@fireburn.co.uk>, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, wine-devel@winehq.org,
 =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ntsync: Set the permissions to be 0666
Date: Tue, 18 Feb 2025 17:57:31 -0600
Message-ID: <2768333.mvXUDI8C0e@camazotz>
In-Reply-To: <20250214122759.2629-2-mike@fireburn.co.uk>
References: <20250214122759.2629-2-mike@fireburn.co.uk>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Friday, 14 February 2025 06:28:00 CST Mike Lothian wrote:
> This allows ntsync to be usuable by non-root processes out of the box
> 
> Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> ---
>  drivers/misc/ntsync.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> index 055395cde42b..586b86243e1d 100644
> --- a/drivers/misc/ntsync.c
> +++ b/drivers/misc/ntsync.c
> @@ -1208,6 +1208,7 @@ static struct miscdevice ntsync_misc = {
>  	.minor		= MISC_DYNAMIC_MINOR,
>  	.name		= NTSYNC_NAME,
>  	.fops		= &ntsync_fops,
> +	.mode		= 0666, // Setting file permissions to 0666
>  };
>  
>  module_misc_device(ntsync_misc);
> 

Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>

--

The comment seems rather redundant, but otherwise this is correct and prudent.



