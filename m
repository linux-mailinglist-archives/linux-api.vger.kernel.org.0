Return-Path: <linux-api+bounces-1683-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A292C900934
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 17:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23130B27566
	for <lists+linux-api@lfdr.de>; Fri,  7 Jun 2024 15:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CDD199E86;
	Fri,  7 Jun 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="huKnBm7a"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B955726288;
	Fri,  7 Jun 2024 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717774258; cv=none; b=AirzxLXUc+jlNaT/WdsfO0ECwUi6HdYYPjXTNCwvBl70jfG6ZsbCJ2ZlorpShEN2P0HpZ6Nn4/fVXMz87JzUQAXMy1hs8mIRc4rfVrPf7BDC4o2wBLqOGU9+3wyG680tzGgSZ5r/3/Oqn3kHx0UKUSr/q2J6Vy7CCSY1CS6R+/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717774258; c=relaxed/simple;
	bh=oxk07G9AQ9wIGZL8jSRqzpGk63H2eoRRZA7xDUZYFhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERw5d/6iQP4P0qybOMmsGUQLUMRhDh1QskNKis93Bb7WMlNNBFP/O5ubwUUADzFlsTIyOKBYM1ZxjnDuF34GTpVbVUaN6P/fYJ8Mf8ILCqfXm95L5W5szg+NDGjDnkgTqYnZ1vYBj0IAP03Hj7rZKd7d9QRuVN3BTRMNCAjiDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=huKnBm7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BEDC2BBFC;
	Fri,  7 Jun 2024 15:30:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="huKnBm7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1717774255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RSBtpjtlrpc2CzImC2n5E7dUQ7Q/WiGuFREctaE417I=;
	b=huKnBm7aYhH8j0n32mH5A9SyaxUr7UHpAkOXiJ4qxQu2anGBN7G+dfu5QrdTO2AjcLIaUO
	gvKbTVTjJCLceohjM5oyg4O2XQvchcMcBDX1u+SAR4Mcu60GZM0QXU5SEuoZWePpnkjZwH
	bezoig8o670EXklveZszu4UG3MQde4Y=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f2c6e6f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 15:30:55 +0000 (UTC)
Date: Fri, 7 Jun 2024 17:30:49 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	tglx@linutronix.de, linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org, x86@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>,
	Samuel Neves <sneves@dei.uc.pt>
Subject: Re: [PATCH v16 5/5] x86: vdso: Wire up getrandom() vDSO
 implementation
Message-ID: <ZmMnqUZw0Lol64kT@zx2c4.com>
References: <20240528122352.2485958-1-Jason@zx2c4.com>
 <20240528122352.2485958-6-Jason@zx2c4.com>
 <2b21f479-cf4f-49a3-b7c8-33f87a1998ac@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b21f479-cf4f-49a3-b7c8-33f87a1998ac@infradead.org>

On Fri, May 31, 2024 at 12:16:03PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/28/24 5:19 AM, Jason A. Donenfeld wrote:
> > +/**
> > + * getrandom_syscall - Invoke the getrandom() syscall.
> > + * @buffer:	Destination buffer to fill with random bytes.
> > + * @len:	Size of @buffer in bytes.
> > + * @flags:	Zero or more GRND_* flags.
> > + * Returns the number of random bytes written to @buffer, or a negative value indicating an error.
> 
>     * Returns:

Ack. Thanks.

Jason

