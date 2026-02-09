Return-Path: <linux-api+bounces-5815-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNJQFA07iWlD4wQAu9opvQ
	(envelope-from <linux-api+bounces-5815-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 02:40:29 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EA510AE52
	for <lists+linux-api@lfdr.de>; Mon, 09 Feb 2026 02:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79A463005E98
	for <lists+linux-api@lfdr.de>; Mon,  9 Feb 2026 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E0E2550AF;
	Mon,  9 Feb 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MVEk/q+i"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24461EFF9B;
	Mon,  9 Feb 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770601215; cv=none; b=OXSfO4Hd6PkHgMqvLEOYaGhgyv7zg0j3Q0V0sYb0JopAfBwwJU4DASmvjLDegZNxN9s47iM1drO6Q4LYFa5SN94kW6vVtvBtm+Kzp0HernKrXlCPE/jWviq8qbjWhtrM9Oz5x4hTOAh2I9jGwqURQ+dPwcUY9MsTzF5DgJ31x3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770601215; c=relaxed/simple;
	bh=ZCDCn8SzGXnz4OAk97MRsEwi/XQXxsYu3zaHCrd7caU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NAtwXzlNg0CgCMnJ/xRXUslj81X6G/x1qMtwxYZbzGpmSm1esVJgvoBuTjeVeN+zjE/EqTgooaq8U0HvXFlMx79DJbwF+kCictWD/HHvl1Ptk35Px6HpfVsYDp6AsJszDnilQ9AZ+zRFf1U0p8dowxlY+KFbrOztLu5BL99jnrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MVEk/q+i; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
	bh=gv1/kHk9MVQnaU6hiwI8xePfzAgEcUWDCs7ofJqfB58=; b=MVEk/q+i1pUUw/xuXfDf72HalD
	q3EPXCrxxuU93hS8W4rOYYpxCI28qud6KWYlgVBkOIrnsUp3p7MLUJF9iVB6YnDax1vvxPLAAUK78
	la/0ndM/q4NoGss3MqQDVpQQ9NlSWTImJfHh8YxYz3Y+qFsvzXWmLdmGaGTKV6wFzPm6ldIGEG9V9
	78QPh0AjbAthZRFSkuOE4bnX2EfRQKy+1qOARNUePUws/0EbxxixXOJntGDiX3VHwZJXFwFmuefdA
	bPzpsVXkpE4Qx3ZJIDMHJzCNeFLPFmgMyW7MMMpbqAoJWMvXJ/1daGxPnlIV2EqSkmEJlGaBgPJvy
	uqJzeVGQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpGFw-0000000EewZ-3flq;
	Mon, 09 Feb 2026 01:40:04 +0000
Message-ID: <017a28fe-6c0e-48ec-8b1b-10e0d3b0a04e@infradead.org>
Date: Sun, 8 Feb 2026 17:40:03 -0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: m68k: remove incomplete, unusable Apollo hardware
 support
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-api@vger.kernel.org,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
References: <20260209013041.37536-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260209013041.37536-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5815-lists,linux-api=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,linux-m68k.org,lists.linux-m68k.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 70EA510AE52
X-Rspamd-Action: no action

Hi--

On 2/8/26 5:30 PM, Ethan Nelson-Moore wrote:
> The m68k architecture contains very incomplete support for running on
> Apollo Domain hardware. There are only timer, console, and framebuffer
> drivers, and no storage or network drivers, so there is no way to
> practically use it. It is not even capable of rebooting by itself (see
> dn_dummy_reset() in arch/m68k/apollo/config.c).
> 
> arch/m68k/apollo has only received tree-wide changes and fixes by
> inspection in the entire Git history (since Linux 2.6.12-rc2), so there
> is clearly no interest in completing support for Apollo hardware.
> Remove it to reduce future maintenance workload.
> 
> There are no uses of the removed <asm/bootinfo-apollo.h> UAPI header or
> the constants removed from the <asm/bootinfo.h> UAPI header on GitHub
> or Debian Code Search.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  arch/m68k/Kbuild                             |   1 -
>  arch/m68k/Kconfig.devices                    |   4 +-
>  arch/m68k/Kconfig.machine                    |   8 -
>  arch/m68k/apollo/Makefile                    |   6 -
>  arch/m68k/apollo/apollo.h                    |   4 -
>  arch/m68k/apollo/config.c                    | 240 --------
>  arch/m68k/apollo/dn_ints.c                   |  50 --
>  arch/m68k/configs/apollo_defconfig           | 595 -------------------
>  arch/m68k/configs/multi_defconfig            |   1 -
>  arch/m68k/include/asm/apollohw.h             |  90 ---
>  arch/m68k/include/asm/config.h               |   2 -
>  arch/m68k/include/asm/irq.h                  |   2 -
>  arch/m68k/include/asm/setup.h                |  32 +-
>  arch/m68k/include/uapi/asm/bootinfo-apollo.h |  29 -
>  arch/m68k/include/uapi/asm/bootinfo.h        |   5 +-
>  arch/m68k/kernel/head.S                      |  70 +--
>  arch/m68k/kernel/setup_mm.c                  |   9 -
>  drivers/video/fbdev/Kconfig                  |   8 -
>  drivers/video/fbdev/Makefile                 |   1 -
>  drivers/video/fbdev/dnfb.c                   | 307 ----------
>  20 files changed, 19 insertions(+), 1445 deletions(-)
>  delete mode 100644 arch/m68k/apollo/Makefile
>  delete mode 100644 arch/m68k/apollo/apollo.h
>  delete mode 100644 arch/m68k/apollo/config.c
>  delete mode 100644 arch/m68k/apollo/dn_ints.c
>  delete mode 100644 arch/m68k/configs/apollo_defconfig
>  delete mode 100644 arch/m68k/include/asm/apollohw.h
>  delete mode 100644 arch/m68k/include/uapi/asm/bootinfo-apollo.h
>  delete mode 100644 drivers/video/fbdev/dnfb.c

There is an M68K maintainer who should be Cc-ed on this patch.
(now done)

-- 
~Randy


