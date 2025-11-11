Return-Path: <linux-api+bounces-5201-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1D5C4B786
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 05:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A4933A7F07
	for <lists+linux-api@lfdr.de>; Tue, 11 Nov 2025 04:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECB9274FEB;
	Tue, 11 Nov 2025 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="eehdZMur"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E42275AF5
	for <linux-api@vger.kernel.org>; Tue, 11 Nov 2025 04:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762835892; cv=none; b=Yi0B6WtjD/jlf47dV+68ZhTzrXPIiSX//zs86SNMy0Z5A/pnM97UiXTT8gY7DfIpzv9J2M1i6qrvXfHaypq/Q1VDb28LH4bNMQLTqk6inVTpbet9dP9/bGRVgehHqkeWxTZGPA6gHP3FYK3RzYr3SJMUt/YXqY+FeT1ebucF0fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762835892; c=relaxed/simple;
	bh=JwD+WfOXVSJGzZ8waVpo6l9WuxaN4TeD3oBx/bSxw9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fH53oRcH+3+t5oGjPYFRhPBe8/AvfZcy3/vS/jMUtNMgIKTzF1JE3lDS1hW8VcS/xg8+0P/g+UKcMWTwdngJl5OH2tgXn+yaFJY1MDZB3N8c9UjDCgA8jDd5x+vFrK+AcxMDwAA/b6O6bbzGnB/pfQ1IFP3Ybi51e74rK2DJ5ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=eehdZMur; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AB4c3EB024917
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 23:38:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762835885; bh=7f9nskz50US5otTMA56btf4ZARhkZmFuBPp3q+iG5ok=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=eehdZMur31zN5Wddqp0swc/sc6oyq2We5uCcxSJJDU8i2RcIrmb+Ex81Ma2pDX8+6
	 RhxhzsLaKJhKqoCX5gAg8H3nfyQOua/XHBTcFJOjJoNkOfVQGcrSaDHLQrK/ZJrikO
	 MuAn1VJTH77w1vKa6qDIzQ4WfBXme6mq9JM760ej0QW2Wdrgxa7c9K5oEp/3X8URuI
	 tVKtIJHuOnnWXmFm3D/qRfLM7cTkJNptdJtTFSIYyBOwOemxRtjSM+dZ+LCPIfGqTp
	 E4urQcNeyC6FGo1v5erx/eAEgWNyKjTRrGjJ4eP+kC5Z2aL+sI4S+R8deR1nXfLqtf
	 P4BNQDVtWW2UA==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id A9A7B2E00D9; Mon, 10 Nov 2025 23:38:03 -0500 (EST)
Date: Mon, 10 Nov 2025 23:38:03 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Maarten Brock <Maarten.Brock@sttls.nl>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <20251111043803.GK2988753@mit.edu>
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
> I really think you are looking at this from a very odd point of
> view, and you seem to be very inconsistent. Boot time setup? Isn't
> that what setserial is for? We have the ability to feed this
> configuration already, but you need a file descriptor.

I'm not really fond of adding some new open flag that to me seems
**very** serial / RS-485 specific, and so I'm trying to find some
way to avoid it.

I also think that that the GPIO style timing requirements of RTS
**really** should be done as a line discpline, and not in userspace.

> Honestly, though, I'm far less interested in what 8250-based hardware does than e.g. USB.

I'm quite confident that USB won't have "state" that will be preserved
across a reboot, because the device won't even get powered up until
the USB device is attached.  And part of the problem was that the
requirements weren't particularly clear, and given the insistence that
the "state" be preserved even across reboot, despite the serial port
autoconfiguration, I had assumed you were posting uing the COM 1/2/3/4
ports where autoconfiguration isn't stricty speaking necessary.

In some ways, USB ports might be easier, since it should be possible
to specify udev rules which get passed to the driver when the USB
serial device is inserted, and so *that* can easily be done without
needing a file descriptor.

And for this sort of thing, it seems perfectly fair to hard code some
specific behavior using either a boot command line or a udev rule,
since you seem to be positing that the serial port will be dedicated
to some kind of weird-shit RS-485 bus device, where any time RTS/DTR
gets raised, the bus will malfunction in weird and wondrous ways....

     	     	     	  	      	 - Ted

