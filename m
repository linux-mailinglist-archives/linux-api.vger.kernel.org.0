Return-Path: <linux-api+bounces-5249-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 22565C53A74
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 18:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B09444FC07C
	for <lists+linux-api@lfdr.de>; Wed, 12 Nov 2025 17:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F27345729;
	Wed, 12 Nov 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KTYxyHGT"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774ED3451CA;
	Wed, 12 Nov 2025 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762967535; cv=none; b=NQ7oUA3eh78tDJHy9E9Fe/YCQPr2UTLnwpoIub1RpGSLwsVa0l+zL7vBsEKnLcCwJHdrvqBa+iINY97/qQvacGkOhTAO3YBX+4WVehEmhwYudG+cYnZ2MsC228HB/Ie9nz857Uu2h71mNDqD0Hs+8/8tgffp9DuTBtlFcEhYcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762967535; c=relaxed/simple;
	bh=LfwDw5nDHN9mjQ61ppHmMZFw8Tz8l0KhDqOCjnLSsZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9vHbF18bmmneTHi6wc8HNZXGMzJ97E1fgekDIrmapSSQB7q4zy1ggivBNqlsmehdPWPp5OMMN7EPw3Aw3on/P4UdNJTsfc7HJ+/tWHlErZBLdaVzRa7wsub8lMkYhljgwq8wRvsAcuFnbLp3z0OyiqYsMlzR/AyFsabino30fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KTYxyHGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0021C113D0;
	Wed, 12 Nov 2025 17:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762967533;
	bh=LfwDw5nDHN9mjQ61ppHmMZFw8Tz8l0KhDqOCjnLSsZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KTYxyHGTfO4RZ7Qp+aEhY9+SN67VWZDd2oFFjjTfeAaciwJQIETuyG3VBpSKtwpeE
	 MPDhM71JtUblUCmp8YZVjUEVNwdCsrJ9CCW9xAme1tvzqI1vdSMVDqCcoZlu7cR83o
	 7OYGS2MbE1Df5kVTccsRCPaZegHiw6nKxsc83dd0=
Date: Wed, 12 Nov 2025 11:46:50 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Maarten Brock <Maarten.Brock@sttls.nl>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Serial port DTR/RTS - O_NRESETDEV
Message-ID: <2025111241-domestic-moonstone-f75f@gregkh>
References: <dc42f5d4-a707-4442-bda6-1c1990666f54@zytor.com>
 <20251110033556.GC2988753@mit.edu>
 <ADB50E23-DC8B-43D0-A345-E10396A3DFD4@zytor.com>
 <AMBPR05MB11925DA076098B05E418BF64283CEA@AMBPR05MB11925.eurprd05.prod.outlook.com>
 <20251110201933.GH2988753@mit.edu>
 <0F8021E8-F288-4669-8195-9948844E36FD@zytor.com>
 <20251111035143.GJ2988753@mit.edu>
 <D4AF3E24-8698-4EEC-9D52-655D69897111@zytor.com>
 <2025111214-doily-anyway-b24b@gregkh>
 <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6DBB5931-ACD4-4174-9FCE-96C45FFC4603@zytor.com>

On Wed, Nov 12, 2025 at 08:09:45AM -0800, H. Peter Anvin wrote:
> On November 12, 2025 3:22:56 AM PST, Greg KH <gregkh@linuxfoundation.org> wrote:
> >On Mon, Nov 10, 2025 at 07:57:22PM -0800, H. Peter Anvin wrote:
> >> Honestly, though, I'm far less interested in what 8250-based hardware does than e.g. USB.
> >
> >hahahahahahaha {snort}
> >
> >Hah.  that's a good one.
> >
> >Oh, you aren't kidding.
> >
> >Wow, good luck with this.  USB-serial adaptors are all over the place,
> >some have real uarts in them (and so do buffering in the device, and
> >line handling in odd ways when powered up), and some are almost just a
> >straight pipe through to the USB host with control line handling ideas
> >tacked on to the side as an afterthought, if at all.
> >
> >There is no standard here, they all work differently, and even work
> >differently across the same device type with just barely enough hints
> >for us to determine what is going on.
> >
> >So don't worry about USB, if you throw that into the mix, all bets are
> >off and you should NEVER rely on that.
> >
> >Remeber USB->serial was explicitly rejected by the USB standard group,
> >only to have it come back in the "side door" through the spec process
> >when it turned out that Microsoft hated having to write a zillion
> >different vendor-specific drivers because the vendor provided ones kept
> >crashing user's machines.  So what we ended up with was "just enough" to
> >make it through the spec process, and even then line signals are
> >probably never tested so you can't rely on them.
> >
> >good luck!
> >
> >greg "this brought up too many bad memories" k-h
> 
> Ugh.
> 
> I have made it very clear that I am very aware that there is broken hardware. 

I would posit that there is NO "non-broken" usb->serial devices out
there.  The closest I have seen was the old IO-Edgeport devices, but
they were expensive and got bought out by some other company and in the
end didn't succeed due to all of the "cheap" devices/chips out there
that just did dumb tx/rx transfers over a fake serial connection.

> What I'm trying to do is to deal with the (occasional) case of
> *non*-broken hardware. Right now Linux breaks the non-broken hardware
> for it, and I don't think the existence of broken hardware is a good
> justification for that.

No, but we have to handle both somehow.

And given that we still get brand-new UART drivers sent to use every few
months, there is just more and more "broken" hardware out there overall.

Anyway, good luck coming up with a scheme to handle your crazy
connections, I would push back and say "any device that treats a serial
control line as a power signal is broken to start with" :)

greg k-h

