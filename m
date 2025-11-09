Return-Path: <linux-api+bounces-5184-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAF6C446F5
	for <lists+linux-api@lfdr.de>; Sun, 09 Nov 2025 21:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430D6188B7B5
	for <lists+linux-api@lfdr.de>; Sun,  9 Nov 2025 20:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CBD266584;
	Sun,  9 Nov 2025 20:43:56 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FCF1FDA;
	Sun,  9 Nov 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762721036; cv=none; b=fJcgIcrKWtTF2nHnbMr+Y+jTQEJF7eqGLqQ0om+U5yqe5f1+V3QXTTCvcYLhKdwXN3cbHzNw+ZS/p/iftzQnYw7BgeefeRKWSW1wuuEXnuWDDZeNUPzJ7mKh7PSt1ZSk3vRH86gGRxa4NM6lX1OrZKLYcvVF61zTv/IAPHo1dzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762721036; c=relaxed/simple;
	bh=rKwOVfN6qIycYLMqowDkjIl0qamT7Mcp5kLtx86YsP8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nl1fQ/nws0w2k5pefwcm7ZVlA9ia89fSeAzXAz3tDVQ0xDjn6QWJ6Xy2QAS3KJEDnAY5FITGXsVZ4y95J+PtDPf8MWtUR2ZH2KoUWiugnEsasyDmqXtvz7MfExihRpJekxMOiDuSVKJhRKDZ8zYHqj9OYo9AFWxe2GcQmIxgNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8FA8192009C; Sun,  9 Nov 2025 21:43:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 82C5892009B;
	Sun,  9 Nov 2025 20:43:52 +0000 (GMT)
Date: Sun, 9 Nov 2025 20:43:52 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-serial@vger.kernel.org, linux-api@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
In-Reply-To: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
Message-ID: <alpine.DEB.2.21.2511090454370.25436@angie.orcam.me.uk>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 6 Nov 2025, H. Peter Anvin wrote:

> It seems to me that this may very well be a problem beyond ttys, in which case
> a new open flag to request to a driver that the configuration and (observable)
> state of the underlying hardware device -- whatever it may be -- should not be
> disturbed by calling open(). This is of course already the case for many
> devices, not to mention block and non-devices, in which case this flag is a
> don't care.

 FWIW I find using an open flag the most natural way to solve this problem 
and I disagree with a view that a 50+ year old standard has to prevent us 
from handling new use cases found as the world has changed.  We do need to 
comply with the standard for the devices that use it, but I think a flag 
to opt out is a perfectly sane approach.

 Yes, some hardware has limitations and may have to conclude we can't do 
anything about it.  Just as, say, we can't choose an arbitrary baud rate 
with the dz.c driver, because the hardware handled has a 4-bit selector 
for a set of predefined rates (to stay remotely on topic).  That does not 
prevent us from handling more flexible hardware in a way that makes full 
use of its features.

> The best name I came up with was O_NRESETDEV, but it's not something I'm
> particularly attached to.

 I'd suggest a generic name such as O_RAW for an agnostic way to express a 
request not to fiddle with the device in any way regardless of its kind, 
i.e. for possible reuse with anything.

> If the opinion is that this *doesn't* have a scope beyond ttys, then perhaps
> abusing the O_DIRECT flag for this purpose would be an alternative.

 It seems like a hack to me, but if carefully evaluated we could reuse the 
bit encoding.  Either way I'd encourage defining a new meaningful name for 
the new application of the flag, such as one proposed above.

  Maciej

