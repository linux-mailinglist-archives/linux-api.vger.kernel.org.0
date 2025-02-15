Return-Path: <linux-api+bounces-3212-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E118A36C43
	for <lists+linux-api@lfdr.de>; Sat, 15 Feb 2025 07:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5223B1F6A
	for <lists+linux-api@lfdr.de>; Sat, 15 Feb 2025 06:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144251624F4;
	Sat, 15 Feb 2025 06:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N93v0u5H"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AAE623;
	Sat, 15 Feb 2025 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739599233; cv=none; b=g1luIDCkuB3xgHbsbH66jxnSfvI2Jte/jtkjaBRLKORv4m/20J1eFHbVKRXDjTvhAYd92GBnk2jIaxIbveORMcOyURImVWeM8Kcc87IbmJ0iSnxwiFaHmagAu9lqNWi8e0QPrYdoU43vBFHTl5fMD2hidZ5VzAmRlyLRa15zj3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739599233; c=relaxed/simple;
	bh=983y9FjFDbY+7fyxmKkbqhfjwND3j2gQYU8auIlMhEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUKDME3QOMRLJz4GlZfdgvQ3ftZkJxKrZcylsTnW0Tx/Csoh1rAZdPfgtfjOeGbvwzXg6S20cysNV0aUJt4Q8DXgxuFVkvPIxNU6uWhxWw+0+Rb2t8LxuAndtlarLrCJXl969C85E/SukyGkCNEnUO1xCE1wWzJ9ZQoyB7m23C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N93v0u5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15B1C4CEDF;
	Sat, 15 Feb 2025 06:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739599232;
	bh=983y9FjFDbY+7fyxmKkbqhfjwND3j2gQYU8auIlMhEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N93v0u5HqnCPdfmoV8BiN2Qvozrh0ZNnaZouSqHAQsD7wdckojdfNG/xcMrEaDO5Y
	 9o/dOi9FF8GB06tQW9lwJ0kavc4QepI/fcLOdBxWui2npiS1Tzo3K0OzKlGmS8+4Ti
	 Vqagvs7UNfvSKYTDfinlB8gN+9+4Zp1InyJDt++A=
Date: Sat, 15 Feb 2025 06:59:26 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Mike Lothian <mike@fireburn.co.uk>, dri-devel@lists.freedesktop.org,
	Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ntsync: Set the permissions to be 0666
Message-ID: <2025021505-sultry-encrypt-a4c8@gregkh>
References: <20250214122759.2629-2-mike@fireburn.co.uk>
 <2025021456-easiness-facebook-636e@gregkh>
 <1911589.tdWV9SEqCh@camazotz>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1911589.tdWV9SEqCh@camazotz>

On Fri, Feb 14, 2025 at 12:13:03PM -0600, Elizabeth Figura wrote:
> On Friday, 14 February 2025 07:06:20 CST Greg Kroah-Hartman wrote:
> > On Fri, Feb 14, 2025 at 12:28:00PM +0000, Mike Lothian wrote:
> > > This allows ntsync to be usuable by non-root processes out of the box
> > 
> > Are you sure you need/want that?  If so, why?  How did existing testing
> > not ever catch this?
> 
> Hi, sorry, this is of course my fault.
> 
> We do need /dev/ntsync to be openable from user space for it to be useful. I'm not sure what the most "correct" permissions are to have in this case (when we don't specifically need read or write), but I don't think I see a reason not to just set to 666 or 444.
> 
> I originally assumed that the right way to do this was not to set the mode on the kernel file but rather through udev; I believe I was using the code for /dev/loop-control or /dev/fuse as an example, which both do that. So I (and others who tested) had just manually set up udev rules for this, with the eventual intent of adding a default rule to systemd like the others. I only recently realized that doing something like this patch is possible and precedented.
> 
> I don't know what the best way to address this is, but this is certainly the simplest.
> 
> 

Ok, makes sense, can you give an acked-by or reviewed-by and I'll be
glad to queue it up and get it merged.

thanks,

greg k-h

