Return-Path: <linux-api+bounces-3206-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868BAA365DD
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 19:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A693B1604
	for <lists+linux-api@lfdr.de>; Fri, 14 Feb 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5201917D0;
	Fri, 14 Feb 2025 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if2GuvBo"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7020118CC15;
	Fri, 14 Feb 2025 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558741; cv=none; b=kjQL3F28WddwyR1rXsa0vZ/hPVdMn7qufqmN/8Riv4+bzeMCLL0CBvcW3Vga18IW0THYcHDCGbI22RCXO6W+fzy6+4oKD+npHT7/X7l4+n92r9Ov64W+0GTx5ZW7ft+bLDYGsKn9yysM/qg1DSYwu1ZjBIXxl/eruOdx3YX0BTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558741; c=relaxed/simple;
	bh=N6BYoVzWmfitLDdv/9MkK+uxLUWYXiRZDwnKdTX7GwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtsv+vzkylGrbQ+GWMWboS1am27RbZwx9gzQnR+8a8gqwH95c3yQM2MnqqVdp6EzkOqPpGJe1j750dU0SIqHUFQ0Gf0EcgbaPLv1BS8Z99FFWfVXZqr1OkpaGcty4vxtdlz9DhNFKYp8ip71qthdWpL1oNVWKAT12hnqQ9TfbJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if2GuvBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E461EC4CED1;
	Fri, 14 Feb 2025 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739558740;
	bh=N6BYoVzWmfitLDdv/9MkK+uxLUWYXiRZDwnKdTX7GwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=if2GuvBoku00rK9l2JHbWkuloit1To2vi72c+9WHFbIV1RWBY4lhJM4W5nwCpvJ7Z
	 yzR45jzbJINrLmiQ79+C6BnRrZ097Bn1tJChat7QtEsZfYju7q5RDHITLikzRv32dl
	 52MexRmGKPRtyVXvLN5l92pakfgBkPFbxOayKBgrOcn5TxWidmHSDsLwdUVvbwO067
	 5S47S5vrcQrwYM+0lxwgJvHezKoQR6zSiROJlbqxYxn1hENldXueU461J6aXUgFxth
	 Ox7bKD9J3DwmGJPC8axgnC5JrwnvEIlxBQLriUjhMe9eUtaawNlfLlObvJ1UMMvF3F
	 SKQUNToypbgLg==
Date: Fri, 14 Feb 2025 10:45:39 -0800
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
Message-ID: <20250214184539.GC21799@frogsfrogsfrogs>
References: <20250214122759.2629-2-mike@fireburn.co.uk>
 <2025021456-easiness-facebook-636e@gregkh>
 <1911589.tdWV9SEqCh@camazotz>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1911589.tdWV9SEqCh@camazotz>

On Fri, Feb 14, 2025 at 12:13:03PM -0600, Elizabeth Figura wrote:
> On Friday, 14 February 2025 07:06:20 CST Greg Kroah-Hartman wrote:
> > On Fri, Feb 14, 2025 at 12:28:00PM +0000, Mike Lothian wrote:
> > > This allows ntsync to be usuable by non-root processes out of the box
> > 
> > Are you sure you need/want that?  If so, why?  How did existing testing
> > not ever catch this?
> 
> Hi, sorry, this is of course my fault.
> 
> We do need /dev/ntsync to be openable from user space for it to be
> useful. I'm not sure what the most "correct" permissions are to have
> in this case (when we don't specifically need read or write), but I
> don't think I see a reason not to just set to 666 or 444.
> 
> I originally assumed that the right way to do this was not to set the
> mode on the kernel file but rather through udev; I believe I was using
> the code for /dev/loop-control or /dev/fuse as an example, which both
> do that. So I (and others who tested) had just manually set up udev
> rules for this, with the eventual intent of adding a default rule to
> systemd like the others. I only recently realized that doing something
> like this patch is possible and precedented.
> 
> I don't know what the best way to address this is, but this is
> certainly the simplest.

Paranoid defaults in the kernel, and then a udev rule to relax the mode
at runtime.  You could also have logind scripts to add add per-user
allow acls to the device file at user session set up time... or however
it is that /dev/sr0 has me on the allow list.  I'm not sure how that
happens exactly, but it works smoothly.

I get far less complaining about relaxing posture than tightening it
(==breaking things) after the fact.

--D

