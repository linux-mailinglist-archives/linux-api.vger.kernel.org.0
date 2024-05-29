Return-Path: <linux-api+bounces-1650-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064D8D2EB4
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2024 09:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00F82816FC
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2024 07:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449F5167D9F;
	Wed, 29 May 2024 07:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuFc0cXg"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1221E167D82;
	Wed, 29 May 2024 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968668; cv=none; b=gFhNPInb1Z9vCxDiF5SMUUvof204Rrg9mqWttxc+J+tXJDlVqmQu2cD8plgxDlwEOjuKPMX2UQMFSz6wbmGY/j3enBEV8XFf+M8h4JGo+q/D+Biw3WxQoTMTDAfAXR0flpR7EfJfcI9UYsg+JavDNfzU/ryosjc+bleUrr7plkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968668; c=relaxed/simple;
	bh=AzzDMJdA28GXgKKNDPed4G6wzS0vsyy1cTbdGo0qXx4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SQYB5ZuJrbdLDzkWoZiGB8xmKHFsNCGYRoRwVpbsH1NSkZLBa9WolELGvsmaumbp3ISFQWeDAj0Xs92qQQqrGt54CLkxt1DkaAmlmjgcap6WpW+6mxcWVDjNbu1UAvQ9CvHqB2DOoNQh0sxpCJjFmlUoB6q1FhqxSj2+afyKdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuFc0cXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07FEC32786;
	Wed, 29 May 2024 07:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716968667;
	bh=AzzDMJdA28GXgKKNDPed4G6wzS0vsyy1cTbdGo0qXx4=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=IuFc0cXg7QZcBM/e78aPfrhBLd64oyBQbj++bPzquLHjN1El6N7G2cxjH1GnojcRA
	 UAKgr8AanpQgN8kkqaHAe8P0V7JngaFfbCjhgzUImu22Xgy+mGBaWrA9phVcoHfHqO
	 UPXcvCCmHqylLRul5mz4vw/TWykgIHybn23Iry3+RSb0wmoETVk5GDR59Vy9XVXEoj
	 qi2YbSTTRB2zolkkfCW3W6YbxsKuatjmKdN6zpVfi0iYx38TvZehfY2onAdGON1EVG
	 bx0Iddop5HCFibaQ+9aiEJq4H/zC3vZMNTddS9VtdcCgX5afQqorzRtPF97+YQCRGM
	 RpgA1b5BXBrsA==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id BCF861200032;
	Wed, 29 May 2024 03:44:25 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 29 May 2024 03:44:25 -0400
X-ME-Sender: <xms:2dxWZp09F_zgveTjUahiJYfxfKwtcrUDlCKk32Euwgn0mJ4j1L61iw>
    <xme:2dxWZgFm8nF-9Ui0ZZ7M9s3S74-EbNno_ppR7o3eiP9PBwU4VVX9Mwf5E3EFr1T6e
    b3zKIoYXPnRMYtlWtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:2dxWZp6sJipIZmP3vYTZHtAJI65-auL8_Lbf2Jz0zwZDFGgV9xRydw>
    <xmx:2dxWZm3fGByL6p01B6SN1ErYS7B7tw5cia8zk88c15tNPpxLkoY03Q>
    <xmx:2dxWZsHTEgrpqSJk7YbP9EskBR6ulP_ZET3rojqM-BTs7H52ghit3w>
    <xmx:2dxWZn8rFkl481g5QNQpWGJcK2hD297RINDbNuaqutcHZ77_zknmiA>
    <xmx:2dxWZpkwNrdA9PO5hp2wfEY6MB5IcP2qaLlJdlASDuJ4HazGG-WRRemt>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7935EB6008D; Wed, 29 May 2024 03:44:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b779241d-36d8-4728-a126-9340bc569a2d@app.fastmail.com>
In-Reply-To: <0da9785e-ba44-4718-9d08-4e96c1ba7ab2@kernel.org>
References: <cover.1712080158.git.legion@kernel.org>
 <cover.1713375378.git.legion@kernel.org>
 <e4229fe2933a003341e338b558ab1ea8b63a51f6.1713375378.git.legion@kernel.org>
 <2024041836-most-ablaze-f417@gregkh>
 <0da9785e-ba44-4718-9d08-4e96c1ba7ab2@kernel.org>
Date: Wed, 29 May 2024 09:44:04 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Jiri Slaby" <jirislaby@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alexey Gladkov" <legion@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kbd@lists.linux.dev,
 linux-api@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-serial@vger.kernel.org, "Alexander Viro" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 1/3] VT: Use macros to define ioctls
Content-Type: text/plain

On Wed, May 29, 2024, at 09:29, Jiri Slaby wrote:
> On 18. 04. 24, 8:18, Greg Kroah-Hartman wrote:
>> 
>> This is a nice cleanup, thanks for doing it, I'll just take this one
>> change now if you don't object.
>
> Unfortunately, _IOC_NONE is 1 on some archs as noted by Arnd, and this 
> commit changed the kd ioctl values in there which broke stuff as noted 
> by Al.
>
> We either:
> * use _IOC(0, X, Y) in here, instead of _IO(X, Y), or
> * define KDIOC(X) as _IOC(0, KD_IOCTL_BASE, X), or
> * revert the commit which landed to -rc1 already.

I would prefer a simple revert, as the other options may
end up more confusing. Another option might be a new
global macro, if we then go an convert all plain ioctl
command numbers to that.

      Arnd

