Return-Path: <linux-api+bounces-3778-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E9EAB9D22
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 15:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B36AA16A34B
	for <lists+linux-api@lfdr.de>; Fri, 16 May 2025 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED8E171C9;
	Fri, 16 May 2025 13:21:02 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C408314F90
	for <linux-api@vger.kernel.org>; Fri, 16 May 2025 13:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747401662; cv=none; b=RcfMozv/2H6L8+DGwydmqBkmI0GrANPInEHxt1O/avQXtxPfxAQVpqeqARuGWZOtppvO8b6tdSvZz7T1d7JxPNssnvubzr0xQjFvF3iYja4NmOMR+km4bgknnhQPqB2+WsH9079dz6H0iXNOuvEPROvc1Mo/w4rhRi24POPaCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747401662; c=relaxed/simple;
	bh=ZcNFTz1rLTZNKpe46827scpjzNrDvZjwTAsLcHZnmAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNOLfw+J5TyFZw+0+6JVVoompDch4kglyYaTrhhIQN5i8qz3KGrqxP5YDDMqc6+Citu7lBViz7Exfe2hs9xEkVdKwin+I1cesV+XiRNyTrWVZOHbXrsmyrEg6R2Du4h1j0MgaJHl6NmKEa3yZWeU9ydrudMdEHAuFLCq5hN679k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Fri, 16 May 2025 09:05:47 -0400
From: Rich Felker <dalias@libc.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
	libc-alpha@sourceware.org
Subject: Re: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <20250516130547.GV1509@brightrain.aerifal.cx>
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
 <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)

On Fri, May 16, 2025 at 02:52:05PM +0200, Alejandro Colomar wrote:
> POSIX.1-2024 now mandates a behavior different from what Linux (and many
> other implementations) does.  It requires that we report EINPROGRESS for
> what now is EINTR.
> 
> There are no plans to conform to POSIX.1-2024 within the Linux kernel,
> so document this divergence.  Keep POSIX.1-2008 as the standard to
> which we conform in STANDARDS.
> 
> Link: <https://sourceware.org/bugzilla/show_bug.cgi?id=14627>
> Link: <https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: <linux-fsdevel@vger.kernel.org>
> Cc: <linux-api@vger.kernel.org>
> Cc: <libc-alpha@sourceware.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
> 
> Hi,
> 
> I've prepared this draft for discussion.  While doing so, I've noticed
> the glibc bug ticket, which sounds possibly reasonable: returning 0
> instead of reporting an error on EINTR.  That would be an option that
> would make us conforming to POSIX.1-2024.  And given that a user can
> (and must) do nothing after seeing EINTR, returning 0 wouldn't change
> things.
> 
> So, I'll leave this patch open for discussion.

FWIW musl adopted the EINPROGRESS as soon as we were made aware of the
issue, and later changed it to returning 0 since applications
(particularly, any written prior to this interpretation) are prone to
interpret EINPROGRESS as an error condition rather than success and
possibly misinterpret it as meaning the fd is still open and valid to
pass to close again.

In general, raw kernel interfaces do not conform to any version of
POSIX; they're just a low-impedance-mismatch set of inferfaces that
facilitate implementing POSIX at the userspace libc layer. So I don't
think this should be documented as "Linux doesn't conform" but
(hopefully, once glibc fixes this) "old versions of glibc did not
conform".

Rich

