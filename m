Return-Path: <linux-api+bounces-1719-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD7D9053DD
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 15:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DC81C20C22
	for <lists+linux-api@lfdr.de>; Wed, 12 Jun 2024 13:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE16B16E864;
	Wed, 12 Jun 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PO+JyPgg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8BE1EF1A;
	Wed, 12 Jun 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199323; cv=none; b=kR8sqUUQ30YnBajugaeqeeLKrdfsVc6kHqfkneqwOJpm/Uqq00yo27hckbaPLKPzo9SyyESS1AV/jMgca+98XE4Yk+kUtpUngyCO6XMz23tk0VgIMIHHKsv1djtipBFKJKY0PLxXWt8Q434g2GzEKjLsCf++jkfvQff21BqvuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199323; c=relaxed/simple;
	bh=DDyAuRMEpOZEcFJVA28TtdtmiZKgs7631IL3D9rxfWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aR/v1/cW9Gbb6zhGwy60QVB2SC5ZeS4pBX0Yl4OdRaDajZvR+N0x5oivkOdk1dR269P5YwUCztYJEubeg94Efdq9HQMjun1W5DoyInknxOWKquP04VCMYAJfiagAiYvM9+A+0tQwUxqWpxsknVlQ7IN/tVuUWhnNT29MeAcN9uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PO+JyPgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5238C3277B;
	Wed, 12 Jun 2024 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718199323;
	bh=DDyAuRMEpOZEcFJVA28TtdtmiZKgs7631IL3D9rxfWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PO+JyPgg/tokN2ijZnhpP3RjSijyUbmtuJhFN/KbBlUlDpdYpTzoGcKbFHsm76wM5
	 Srj8T5uw+TSWt6OXIk/ZmgI7QfarDQZYG9DFHtoS907v8j6ceG2E5ob9ZrTI67cinG
	 L++zq08Zqexoy4yNDEa53bcSiruf77ra3jz7SbKc=
Date: Wed, 12 Jun 2024 15:35:20 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-api@vger.kernel.org, linux-man@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Palmer Dabbelt <palmer@rivosinc.com>, libc-alpha@sourceware.org
Subject: Re: [PATCH] uapi/asm/termbits: Use the U integer suffix for bit
 fields
Message-ID: <2024061214-absolute-deranged-14bf@gregkh>
References: <2024061222-scuttle-expanse-6438@gregkh>
 <20240612131633.449937-2-alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612131633.449937-2-alx@kernel.org>

On Wed, Jun 12, 2024 at 03:16:58PM +0200, Alejandro Colomar wrote:
> Constants that are to be used in bitwise operations should be unsigned,
> or a user could easily trigger Undefined Behavior.

Wait, do we really have such broken compilers out there?  If so, how has
no one hit this before?

> Also, the types where these constants are to be assigned are unsigned,
> so this makes it more consistent.

Fair enough.

> alx@debian:/usr/include$ grepc -tt termios asm-generic/
> asm-generic/termbits.h:struct termios {
> 	tcflag_t c_iflag;		/* input mode flags */
> 	tcflag_t c_oflag;		/* output mode flags */
> 	tcflag_t c_cflag;		/* control mode flags */
> 	tcflag_t c_lflag;		/* local mode flags */
> 	cc_t c_line;			/* line discipline */
> 	cc_t c_cc[NCCS];		/* control characters */
> };
> alx@debian:/usr/include$ grepc -tt tcflag_t asm-generic/
> asm-generic/termbits.h:typedef unsigned int	tcflag_t;
> alx@debian:/usr/include$ grepc -tt cc_t asm-generic/
> asm-generic/termbits-common.h:typedef unsigned char	cc_t;
> alx@debian:/usr/include$ grepc -tt speed_t asm-generic/
> asm-generic/termbits-common.h:typedef unsigned int	speed_t;
> 
> Link: <https://lore.kernel.org/linux-api/2024061222-scuttle-expanse-6438@gregkh/T/>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Cc: <linux-api@vger.kernel.org>
> Cc: <libc-alpha@sourceware.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> 
> Hi Greg,
> 
> On Wed, Jun 12, 2024 at 02:22:37PM GMT, Greg KH wrote:
> > Have a proposed patch that you feel would resolve this?
> >
> > thanks,
> >
> > greg k-h
> 
> Here it is.  :)
> 
> For reviewing it, I suggest using '--word-diff-regex=.'.
> 
> I compiled the kernel, and it seems ok; didn't test more than that.

With this change, can the glibc versions then be dropped to just rely on
these instead?

thanks,

greg k-h

