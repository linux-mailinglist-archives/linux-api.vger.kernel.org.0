Return-Path: <linux-api+bounces-536-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DCE831D0D
	for <lists+linux-api@lfdr.de>; Thu, 18 Jan 2024 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCF9C1C23085
	for <lists+linux-api@lfdr.de>; Thu, 18 Jan 2024 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FF928DB6;
	Thu, 18 Jan 2024 15:57:31 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35528DB0
	for <linux-api@vger.kernel.org>; Thu, 18 Jan 2024 15:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705593451; cv=none; b=PWt09v9Jc1dtvRk5+ecLrqLf80/sTAzdsaafI0tDpwTv4WGBpYvljHGUYeRYoOy1DvHBNzRIEt+0HyBw6CGwHY1vRFOF5uxifrWjffbLLbRJj/Gz+da8j9TMWZCGLQCl/gEJ7Nj7hgN06NnRTi3DdfiMCQaMObavc6IRcHoclUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705593451; c=relaxed/simple;
	bh=IRyQeRsTU4B2bpwbcSVi8B83C3AiwhoAZyPmEFIonTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:User-Agent; b=lUyzv5wdhKE92YSx5sTp+2Vy0/Vn3wI7WNXsqT2lgBNf8b97JsEBYXEmpP1oHMXwbrTeS9ZAVGCeg5lbDmBNNXsH5VJwYEYAUo3943E+JpeO2AIfrugAl8n/u69OQ5Flg/0Eexfer7+8rdVMAdyQxggqzcI+/rDTDp7NBPgWitQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=libc.org; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libc.org
Date: Thu, 18 Jan 2024 10:57:37 -0500
From: Rich Felker <dalias@libc.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Linux API <linux-api@vger.kernel.org>,
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
Message-ID: <20240118155735.GS22081@brightrain.aerifal.cx>
References: <20200831153207.GO3265@brightrain.aerifal.cx>
 <CAG48ez39WNuoxYO=RaW5OeVGSOy=uEAZ+xW_++TP7yjkUKGqkg@mail.gmail.com>
 <a9d26744-ba7a-2223-7284-c0d1a5ddab8a@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9d26744-ba7a-2223-7284-c0d1a5ddab8a@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Aug 31, 2020 at 11:05:34AM -0600, Jens Axboe wrote:
> On 8/31/20 9:46 AM, Jann Horn wrote:
> > On Mon, Aug 31, 2020 at 5:32 PM Rich Felker <dalias@libc.org> wrote:
> >> The pwrite function, originally defined by POSIX (thus the "p"), is
> >> defined to ignore O_APPEND and write at the offset passed as its
> >> argument. However, historically Linux honored O_APPEND if set and
> >> ignored the offset. This cannot be changed due to stability policy,
> >> but is documented in the man page as a bug.
> >>
> >> Now that there's a pwritev2 syscall providing a superset of the pwrite
> >> functionality that has a flags argument, the conforming behavior can
> >> be offered to userspace via a new flag. Since pwritev2 checks flag
> >> validity (in kiocb_set_rw_flags) and reports unknown ones with
> >> EOPNOTSUPP, callers will not get wrong behavior on old kernels that
> >> don't support the new flag; the error is reported and the caller can
> >> decide how to handle it.
> >>
> >> Signed-off-by: Rich Felker <dalias@libc.org>
> > 
> > Reviewed-by: Jann Horn <jannh@google.com>
> > 
> > Note that if this lands, Michael Kerrisk will probably be happy if you
> > send a corresponding patch for the manpage man2/readv.2.
> > 
> > Btw, I'm not really sure whose tree this should go through - VFS is
> > normally Al Viro's turf, but it looks like the most recent
> > modifications to this function have gone through Jens Axboe's tree?
> 
> Should probably go through Al's tree, I've only carried them when
> they've been associated with io_uring in some shape or form.

This appears to have slipped through the cracks. Do I need to send an
updated rebase of it? Were there any objections to it I missed?

Rich

