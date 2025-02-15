Return-Path: <linux-api+bounces-3210-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE93AA36A99
	for <lists+linux-api@lfdr.de>; Sat, 15 Feb 2025 02:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A631F16CA01
	for <lists+linux-api@lfdr.de>; Sat, 15 Feb 2025 01:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653B23B1A4;
	Sat, 15 Feb 2025 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECmTK2nA"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACA11187;
	Sat, 15 Feb 2025 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739581414; cv=none; b=eLcFTPzqtsn7ivQ4W/VeZi9C9y+iDSwZyUyZu3Qz0Ne7ueV8Hzllsuo3neutIZUJ28Gg8RvSBFZiZEMpBPejvR8NiZbAl5epowvYdh30xjg/ISDHLSBGfPO6/DbVi9UFS46eRgoYHlKiUOvd5r0w6A0R7P69I6SHrmanJn7KV/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739581414; c=relaxed/simple;
	bh=1jWwksNfcXOTbsI5skvdkT/hHXIEc071tYG5CLbIBtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qdu/1W/LC6CJjQXzsNhG0/t/v7Bud/lGyWaJTJjP6yRYoohtlLbLamekrxOCYGOuSyR21uo7L3mNQSK6Me8yMoX29BPzL3/v3GvMeMbZHH2NSVH1sKUGjyYnBU5vAkA7WTgHvHtK4JJ1VMDREaMEwKsUPlmRrnEsU5lo3ZmNVIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECmTK2nA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74B7C4CED1;
	Sat, 15 Feb 2025 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739581413;
	bh=1jWwksNfcXOTbsI5skvdkT/hHXIEc071tYG5CLbIBtw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECmTK2nAMK7Kk2OVfwgOZdKLnU3lPIs+tPrJ5fa6ZhQ86dfjK8A/OTTJyFmyg7H1u
	 4ouJeWzjNd9iKQeRaCGmSktD9FXv6zmhzxCPkVivsKpehr9bbRVgDIidTSnIK2/Lor
	 Lg7fnt8yWQOFreYKdEIvXvVktfViPuOWtS1/0iuRZTn/5TtZywQxGmwyTkAgAvuNrx
	 iuAyHIAn8zrEzYFG7bNqvKh4LM+kdWfzZS50RT4x6l4JbO+dt+ymxoua5X662iEYYT
	 OtZlbUie1SriiRaFtbrXbXZTmqTT0eXqVf1b+hjJ7ywBJ2rWcJjgewLfnsLEEfbFi4
	 Xb8YL4rbG6gTA==
Date: Fri, 14 Feb 2025 17:03:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Mike Lothian <mike@fireburn.co.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ntsync: Set the permissions to be 0666
Message-ID: <20250215010333.GO3028674@frogsfrogsfrogs>
References: <20250214122759.2629-2-mike@fireburn.co.uk>
 <1911589.tdWV9SEqCh@camazotz>
 <20250214184539.GC21799@frogsfrogsfrogs>
 <8487800.T7Z3S40VBb@camazotz>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8487800.T7Z3S40VBb@camazotz>

On Fri, Feb 14, 2025 at 04:15:25PM -0600, Elizabeth Figura wrote:
> On Friday, 14 February 2025 12:45:39 CST Darrick J. Wong wrote:
> > On Fri, Feb 14, 2025 at 12:13:03PM -0600, Elizabeth Figura wrote:
> > > On Friday, 14 February 2025 07:06:20 CST Greg Kroah-Hartman wrote:
> > > > On Fri, Feb 14, 2025 at 12:28:00PM +0000, Mike Lothian wrote:
> > > > > This allows ntsync to be usuable by non-root processes out of the box
> > > > 
> > > > Are you sure you need/want that?  If so, why?  How did existing testing
> > > > not ever catch this?
> > > 
> > > Hi, sorry, this is of course my fault.
> > > 
> > > We do need /dev/ntsync to be openable from user space for it to be
> > > useful. I'm not sure what the most "correct" permissions are to have
> > > in this case (when we don't specifically need read or write), but I
> > > don't think I see a reason not to just set to 666 or 444.
> > > 
> > > I originally assumed that the right way to do this was not to set the
> > > mode on the kernel file but rather through udev; I believe I was using
> > > the code for /dev/loop-control or /dev/fuse as an example, which both
> > > do that. So I (and others who tested) had just manually set up udev
> > > rules for this, with the eventual intent of adding a default rule to
> > > systemd like the others. I only recently realized that doing something
> > > like this patch is possible and precedented.
> > > 
> > > I don't know what the best way to address this is, but this is
> > > certainly the simplest.
> > 
> > Paranoid defaults in the kernel, and then a udev rule to relax the mode
> > at runtime.  You could also have logind scripts to add add per-user
> > allow acls to the device file at user session set up time... or however
> > it is that /dev/sr0 has me on the allow list.  I'm not sure how that
> > happens exactly, but it works smoothly.
> > 
> > I get far less complaining about relaxing posture than tightening it
> > (==breaking things) after the fact.
> 
> FWIW, it may be worth stressing that this is not a hardware device in
> any sense, it's a software driver that only lives in a char device
> (and dedicated module) for the sake of isolating the code. I can't
> imagine any reason to control access per-user, although my experience
> may not be enough to grant such imagination.

Oh, I'm aware that ntsync is a driver for a software "device" that
implements various Windows APIs and isn't real hardware. :)

But, you might want prevent non-root systemd services (e.g. avahi) from
being able to access /dev/ntsync if, say, someone breaches that, while
at the same time allowing access to (say) logged-in users who can run
Wine.

> The only actual risk is a bug in the code itself—which is always
> possible—but at that point you'd presumably just want to disable it at
> build time or something similar.

<shrug> Well yes, I could turn it off in my bespoke kernels, but most
distributors turn on a lot of modules to minimize friction for users.
Chances are that'll be most of them if this enables better Steam gaming.

--D

