Return-Path: <linux-api+bounces-1721-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFAF905500
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 16:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8700E1C20DB8
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27FA17DE1E;
	Wed, 12 Jun 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cLHLQhsI"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C317C221;
	Wed, 12 Jun 2024 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718202088; cv=none; b=PefhtRTOigyrlA68FrPh/F8/VR6Cl7faEFXFeJhZwnsTVQLc2lZr59xcm0l4t45TUDyJrz1Fgtem0oCiTdlmcGsFIQfhQUGw7RJDZw/GItN3CnZv1Ctr2quG9rNNRzE1MDSot8dmG0oBbDycIuSXiDu8Tqm5DEfa95uDZTuiK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718202088; c=relaxed/simple;
	bh=0Rh03G4Y6lBvmvLXJRZmSDvOQWdYXpWtPP+ssLY0Ogw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omYw1tOmrMhrq89XE2vFtvh0gKSmwdYF37TCM84FBn8IZyt7vhAqxkciylTU+YmF7vOIA67+SaooORz+W5BVXawfXZrpOPIChVhVgkkUbb2GOPZcd8tGV2LRm/xbyOeHU19kM6XSAv0QGYixHcyGBDsLBT5xSHOcuwJvRt65bGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cLHLQhsI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A227FC116B1;
	Wed, 12 Jun 2024 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718202088;
	bh=0Rh03G4Y6lBvmvLXJRZmSDvOQWdYXpWtPP+ssLY0Ogw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cLHLQhsIRvmYQstODPWTHkB/eOFhdzKrsI1hfGKT4CG6n+H6IvBR8oW1OMR7pRLHs
	 3hY7J+FGJq8OLF/oLhfd6YECooKm8Yr7Ne8go4MrDt4jf6MoIUAjclGdIQAicfOHtH
	 TpUEFhwFg41exaOx1OTTupmMK1wxE45kI+28pAas=
Date: Wed, 12 Jun 2024 16:21:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-api@vger.kernel.org, linux-man@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Palmer Dabbelt <palmer@rivosinc.com>, libc-alpha@sourceware.org
Subject: Re: [PATCH] uapi/asm/termbits: Use the U integer suffix for bit
 fields
Message-ID: <2024061223-saddlebag-gallantly-c35f@gregkh>
References: <2024061222-scuttle-expanse-6438@gregkh>
 <20240612131633.449937-2-alx@kernel.org>
 <2024061214-absolute-deranged-14bf@gregkh>
 <tkfp53faunf5jlszu5k6jwwxgsl72faffiux7c3pykmnowapy6@wap3bvtvoebi>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkfp53faunf5jlszu5k6jwwxgsl72faffiux7c3pykmnowapy6@wap3bvtvoebi>

On Wed, Jun 12, 2024 at 04:00:18PM +0200, Alejandro Colomar wrote:
> Hi Greg,
> 
> On Wed, Jun 12, 2024 at 03:35:20PM GMT, Greg KH wrote:
> > On Wed, Jun 12, 2024 at 03:16:58PM +0200, Alejandro Colomar wrote:
> > > Constants that are to be used in bitwise operations should be unsigned,
> > > or a user could easily trigger Undefined Behavior.
> > 
> > Wait, do we really have such broken compilers out there?
> 
> I meant this as a generic statement that signed integers on bitwise ops
> are bad, not as a specific statement that these values would trigger UB.
> 
> I expect that these specific values and the operations done on them
> probably don't trigger UB, since the shifts are done by a controlled
> amount, and there are justa few operations done on them.

These, for the most part, are NOT used as shifts.

> For example, a left shift where a set bit overflows the type (e.g.,
> 1<<32), causes UB.

Sure, but that's not in play here.

> The reason why it's better to avoid this at all even if we know these
> values work fine, is that programs using <asm/termbits.h> would need to
> disable those compiler warnings, which could silence warnings on other
> code which might be broken.

But again, you aren't using these as bit shifts, they are bit masks, or
values, only.

> TL;DR: The kernel isn't broken, but improving this would allow users to
> enable stricter warnings, which is a good thing.

Enable it where?

thanks,

greg k-h

