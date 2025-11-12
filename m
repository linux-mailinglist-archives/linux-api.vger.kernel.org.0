Return-Path: <linux-api+bounces-5237-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 820C7C51FD6
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5804E501F25
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 11:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BDF32F361C;
	Wed, 12 Nov 2025 11:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MIhBGJIM"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0780E2C15BE;
	Wed, 12 Nov 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762946578; cv=none; b=adoxFo5GloITWfVTQ4Jd+Te0IPCr3yS0RpSRHkS5p5504cERscBdNAltLuD6e7cbjcffhLv+TQD3nRJVq6+d9dHDPIPjmyEEcvYmFA7ncN6Li/RwA1JpHMFI8CGoeLoPg8YSMh9aeufES9LAPprXT4ZzwZgXHVp5lBgUPsbt650=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762946578; c=relaxed/simple;
	bh=hjXB8IW77oxvUB9X1HvFeAFgisSOfgJqp9S36dCalM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZhZaWUJBO9eMVmG4eC98DchtFt1zdRZfVWwL4UCmVgK/HR/57v3yDE1JnmPWvL9nekmzzlpxN7E0ags48GEKHIe+WLecvf2zsHPXIaec3FYSjyEMtMAVWtdogWWkJ2nJ0q7MADX2trSBKGTsH6QyX/GXNf9KvduKpX6IrRuFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MIhBGJIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF2FC4CEF5;
	Wed, 12 Nov 2025 11:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762946577;
	bh=hjXB8IW77oxvUB9X1HvFeAFgisSOfgJqp9S36dCalM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIhBGJIM2U45fn4oiaiLg6XOt+xA9as4EGD3E4pm2UXNIw/neuqegu9zwE7KGDtg3
	 d/DOg4MDqHIJuerXZnzxxUVFZh6E3FgwAKRFHnS3rCdq9fGKWlXHe+ygUWAGJsehlR
	 DHc3EgzAtD2+FW6tEdtJDzqrq6bdhp6p6LVAlYyw=
Date: Wed, 12 Nov 2025 06:22:56 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Maarten Brock <Maarten.Brock@sttls.nl>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <2025111214-doily-anyway-b24b@gregkh>
References: <bb44f856-10a2-40c7-a3f7-be50c8e4b0a9@zytor.com>
 <20251107173743.GA3131573@mit.edu>
 <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
 <20251110033556.GC2988753@mit.edu>
 <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
 <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>

On Mon, Nov 10, 2025 at 07:57:22PM -0800, H. Peter Anvin wrote:
> Honestly, though, I'm far less interested in what 8250-based hardware does than e.g. USB.

hahahahahahaha {snort}

Hah.  that's a good one.

Oh, you aren't kidding.

Wow, good luck with this.  USB-serial adaptors are all over the place,
some have real uarts in them (and so do buffering in the device, and
line handling in odd ways when powered up), and some are almost just a
straight pipe through to the USB host with control line handling ideas
tacked on to the side as an afterthought, if at all.

There is no standard here, they all work differently, and even work
differently across the same device type with just barely enough hints
for us to determine what is going on.

So don't worry about USB, if you throw that into the mix, all bets are
off and you should NEVER rely on that.

Remeber USB->serial was explicitly rejected by the USB standard group,
only to have it come back in the "side door" through the spec process
when it turned out that Microsoft hated having to write a zillion
different vendor-specific drivers because the vendor provided ones kept
crashing user's machines.  So what we ended up with was "just enough" to
make it through the spec process, and even then line signals are
probably never tested so you can't rely on them.

good luck!

greg "this brought up too many bad memories" k-h

