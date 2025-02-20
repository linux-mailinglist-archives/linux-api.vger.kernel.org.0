Return-Path: <linux-api+bounces-3269-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FE3A3E507
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2025 20:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1205D3BF98E
	for <lists+linux-api@lfdr.de>; Thu, 20 Feb 2025 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2553F2638B4;
	Thu, 20 Feb 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="E815/36/"
X-Original-To: linux-api@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD2426388C;
	Thu, 20 Feb 2025 19:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740079769; cv=none; b=seidXEejb8FytOK6jZvG3V9StxTMAis7xablIWog7CSR7EKrKgCL78d9LwmCFk/KZML/lwS0uXCpAID2+bokuqiflY7FT9xIMMehtUxwZQq1/vJCnCZihYE5JD9R1imfQB4wvO/knlHXthEFdwWRZL3EEqke2osLqyhzZk2k4kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740079769; c=relaxed/simple;
	bh=2OLR5LHWyfmHwZ1Vh7BLD55+Q46mjJOcqW+SdQM5dYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpItogeNrDGweugIKNoqZzENE+yGFO1sgQUQyX1hNLEYw2X4EQBrkvwe//E3nz5KPJ/VtxROG+sM41DggDXxEa6QeaE218bp+B8RJWpxl+Nf5xM+yg3HRfNGyoDKSlqskl3qC+kYyPhGdErZeaTn7a7E0Z7fTVJTyhYIQyu7EgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=E815/36/; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=X4J+MsSifXleGra567XIbeb8lejkOmCkNkZc9pAgrKM=; b=E815/36/EkIG7Pi9AzWtjSs2Im
	tkqjPeisqonys7wZslR8mNBEnK9qHNvVENvwm2rlrWQDLMNn7oIvPuNrxXveJ+U47UYvGl777MLjC
	w4shVtOFLJCx3rgeDfx88rL+u41oxaseQF/lHp8eAAmSfrSDA61buqDyP+0k2OgAhdCvi7bg2KLQ8
	zKWnnKdbOxkYLJ5gVgyfp96Mj8FB/sWZDlAFi7w0H20006E4rywsxdaGB3QdBXZ6MFJZFl55BSLWf
	Z3Y1A2xfCR58g2wdG85naCI6hQhk/sUt3G/HyCSjbxlW4rE2pewPVQeP+Cbgtoqe+2+OZNq4MJu6R
	KqSofAKA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tlCEg-00HTbZ-0A;
	Thu, 20 Feb 2025 13:29:26 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] ntsync: Check wait count based on byte size.
Date: Thu, 20 Feb 2025 13:29:25 -0600
Message-ID: <3342044.44csPzL39Z@camazotz>
In-Reply-To: <20250220192334.549167-1-zfigura@codeweavers.com>
References: <20250220192334.549167-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 20 February 2025 13:23:34 CST Elizabeth Figura wrote:
> GCC versions below 13 incorrectly detect the copy size as being static and too
> small to fit in the "fds" array. Work around this by explicitly calculating the
> size and returning EINVAL based on that, instead of based on the object count.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202502072019.LYoCR9bF-lkp@intel.com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
> 

Oops, I forgot to include a reference to v1:

https://lore.kernel.org/all/20250219001920.210847-1-zfigura@codeweavers.com/



