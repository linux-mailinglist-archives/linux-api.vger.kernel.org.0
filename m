Return-Path: <linux-api+bounces-1581-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B398F8CCF47
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 11:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD293B219A4
	for <lists+linux-api@lfdr.de>; Thu, 23 May 2024 09:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8613D243;
	Thu, 23 May 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSxGarIu"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C067E574;
	Thu, 23 May 2024 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716456565; cv=none; b=WTq/RblvU0YKZcmcO+H3iRBCCVBhIP8Rml7XrQn+ThCBSa5TImGJKBbgxZ5P9KgjI9MGuQ0OjSeYcy1hgUYEwaUn90WyAuzwwTksp4LtL1NNWhOzWCGUljrpDxU3WweF136weZ4X4SXPaRUWnVddX8TwTRmrGdeymQUIRj/8wxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716456565; c=relaxed/simple;
	bh=NBBL5XBTVaUwnuRPH2nURfseFPd5SUWepkfKnqcbEIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iq2qTivG2fV0/IE7Stu6X1wlTPfyJOxB5Qouzh2Jk/pqtnI9Q3Yel2Oma6EtXDRDbs60kkrnQ6b8beBtrkV/Hs2lO+oZVIeP3ol7+BWijXM96sX3Hg3YdMNMY48bZ5WxJ7N/PT9UO1NYW5Fb14UILk8SgZf4sH5GE+MJSaDUWkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSxGarIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DEFCC3277B;
	Thu, 23 May 2024 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716456565;
	bh=NBBL5XBTVaUwnuRPH2nURfseFPd5SUWepkfKnqcbEIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nSxGarIuanJFxjGG8dz4TmH2fag2/jgM+Ou9sp+kE1CgrfwzHGEavKVmRs8H8j2ID
	 uTtvdEwJ/lmwoh821zsaPF4HCG9uMunndQaC/rprgkVePYWwiXSkdD3LVfow0JYFfp
	 dRuG2H/Sx8kvekjYEcVD5Hntzo9ltPIRTpUmRQw//x3pd2PwlbE3POiKfxicGMqrBO
	 ovQ4HUwpd5uThxRkevXnzh6crnnMMr8ZxCEX5G0BghrK4N3CihMA/BheXWnsYP2BxL
	 2JWMxwtOr/b9DhRwfwdqM/L4BWAFeuFUIc1/0umJ3jqLPFGBRQcbEgGwwJV3YBWuNt
	 m0aXXAsJ1D3lg==
Date: Thu, 23 May 2024 11:29:20 +0200
From: Alexey Gladkov <legion@kernel.org>
To: "Dmitry V. Levin" <ldv@strace.io>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] uapi: linux/kd.h: include missing header
Message-ID: <Zk8McCtAhKtMTt2n@example.org>
References: <20240523092310.GA31777@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523092310.GA31777@altlinux.org>

On Thu, May 23, 2024 at 12:23:10PM +0300, Dmitry V. Levin wrote:
> Given that linux/kd.h now uses macros defined in linux/ioctl.h,
> do not rely on that header being already included by linux/kd.h users
> and include linux/ioctl.h explicitly.
> 
> This bug was found by strace CI.
> 
> Fixes: 8c467f330059 ("VT: Use macros to define ioctls")
> Signed-off-by: Dmitry V. Levin <ldv@strace.io>

Acked-by: Alexey Gladkov <legion@kernel.org>

> ---
>  include/uapi/linux/kd.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/uapi/linux/kd.h b/include/uapi/linux/kd.h
> index 8ddb2219a84b..8fcce939ba25 100644
> --- a/include/uapi/linux/kd.h
> +++ b/include/uapi/linux/kd.h
> @@ -3,6 +3,7 @@
>  #define _UAPI_LINUX_KD_H
>  #include <linux/types.h>
>  #include <linux/compiler.h>
> +#include <linux/ioctl.h>
>  
>  /* 0x4B is 'K', to avoid collision with termios and vt */
>  #define KD_IOCTL_BASE	'K'
> -- 
> ldv
> 

-- 
Rgrds, legion


