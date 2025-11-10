Return-Path: <linux-api+bounces-5185-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AF1C44D8C
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 04:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90192188C8A3
	for <lists+linux-api@lfdr.de>; Mon, 10 Nov 2025 03:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DA828469E;
	Mon, 10 Nov 2025 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bWrjA4Tp"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF9520C023
	for <linux-api@vger.kernel.org>; Mon, 10 Nov 2025 03:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762745772; cv=none; b=JXmoaAY/5h2AmVCOWmiDatfdXUzWGlCmTp4ukbotJOTEENmdlBCOhCjDmjkqHu9PScImjBo5gKCqN648fHct0h+oraWsjdAQvdBZyjWnvEE//kg60WKQ/LpH6hauAMgYbvOOL+JEKcTlh2gJG9OCcPrYhslNBtOcqWmI+hxrc0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762745772; c=relaxed/simple;
	bh=w5hxsI6oanhxO0+XMiIZkdXYx7KzwE7njW4MO7wJ+38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTOwNgkMh7b5ob2pUYMCdrDt1QxxPrIwXY13gkszDXMtwKD2BpPsC7h9+HOLJXMnUZWHCb9Dh4v/JnaieHc8FRgYk7AcwpX21dhW9aP+yBVR/rxeHrIR9vlGxaOewPCb9DSSJD2FwPhxyAKRLUhQawvXkSe1Zxq2xBf+Cwgg8aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bWrjA4Tp; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AA3ZuAJ010971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Nov 2025 22:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762745758; bh=eFGyXJBSDrcCbUcWJuMkH/5zBN7fzQB6YRYE8ZTXe28=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=bWrjA4TpRkSi7/ll5gKvgEqd2IcLy7rTAWR14hDRFviXy9XIg0YvD/l/kiUUvFXOb
	 ECDD/euRtQrPo+j+0ecfGfH3lhn9/Hk3Lv+b4KBghap+DlMOkyQ8zR1JV3bKLeSHy8
	 oQ2lumsVVvzXOdLte7/2WCRreNVPW+3Mgt5ztqOP75llDHzkBVTBP8z/HdK4xkyXak
	 2oIha7QtByy47LA8/GocwNFTxqmI0qbXKYtH2ThXTicH4ZsWINvmC5YpnmD2blJ9ii
	 uyeWLOMvKHJZjYU8ijezC67xlVaoiFzCS2mcpKZ8HJ9bT6ANv22V2LxHeo9yMsDpJt
	 XcZHjw8FmtUHw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 461672E00D9; Sun, 09 Nov 2025 22:35:56 -0500 (EST)
Date: Sun, 9 Nov 2025 22:35:56 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-serial@vger.kernel.org, linux-api@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <20251110033556.GC2988753@mit.edu>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
 <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>

On Sat, Nov 08, 2025 at 06:25:20PM -0800, H. Peter Anvin wrote:
> 
> The standard ESP32 configuration for its serial port is that asserting RTS#
> even for a moment will cause a device reset, and asserting DTR# during reset
> forces the device into boot mode. So even if you execute TIOCMSET immediately
> after opening the device, you will have glitched the output, and only the
> capacitance of the output will save you, in the best case.

IMHO, these more esoteric use cases should involve a custom kernel
driver which replaces the generic serial driver.  In practice, these
things aren't really a tty, but somethiung else weird, and trying to
do this in userspace seems really awkward.

> setserial (TIOCSSERIAL) and termios (TCSETS*) both require file descriptors,
> so that is not suitable. The 8250 driver, but *not* other serial drivers,
> allows the setserial information to be accessed via sysfs; however, this
> functionality is local to the 8250 driver.

My suggestion of using setserial to turn on some "not really a tty;
but some weird networking / cheap debugging hack" flag should work,
because you would do this at boot up.  Note that the 8250
autoconfiguration code (see drivers/tty/serial/8250/8250_port.c) is
going to mess with DTR / RTS.  This is why I asserted that trying to
claim that you can preserve "state" across reboots is Just Not
Possible.

If you have some weird setup where DTR or RTS is wierd to the
"detonate the TNT" line, might I suggest that maybe we shouldn't be
using the tty / 8250 serial driver, but it should ***really*** be a
dedicated kernel driver?

					- Ted

