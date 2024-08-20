Return-Path: <linux-api+bounces-2213-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E709958A0A
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 16:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 031351F23C10
	for <lists+linux-api@lfdr.de>; Tue, 20 Aug 2024 14:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3914BF4E7;
	Tue, 20 Aug 2024 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="IlZbiYki"
X-Original-To: linux-api@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FE192B95
	for <linux-api@vger.kernel.org>; Tue, 20 Aug 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724165106; cv=none; b=uSH22q1G42GjQSk027kTKy2wuOd0vH26m454SJ8I2zns4VqC5zGoj/O4ZnxAuUpCBgUbAu5e0i7ujDLvg4x2lXw5XvvPOzuWa0aiLoW0qIIpK/XY/Z5SfEbOMsAnLZNPWc/W9mYuC/yESRuTLtHOroC7VsxpdoZTFA7N7ICLZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724165106; c=relaxed/simple;
	bh=VxMwLwnUAs3AECMBojlW02DRtgKsc7Q3XRI79OMkMsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwLr8ycFDQYdiYkD0YroxkeAmFYMBGIQttk3ihrE6lKjlabfMz7sICcSP+TcAPHz8H2UpRSUtZcVPDhK/Hgc38q7pGvuT1iwMPMZmnGDnTiVrtrX5cCd2smgpyfLxnrxskMX643pirZtSO5IoGmufMBUNh2BCK4jY7RvtbzUL8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=IlZbiYki; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-67.bstnma.fios.verizon.net [173.48.112.67])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47KEiYx0007623
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724165078; bh=PlANzkRxs6a6M2Z1PfSxu5aEfwB8iKyP3ycQHsRcY1o=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=IlZbiYkiA2DDIKR2KdXWGwmcEia/7De9SkwGLeR/OZT0w70JGgngljGanNWrTQDuC
	 6rBfZ5HVD/p61g5dhJNeAhh21YZXsrBwx51rx4JW4r5S/qtkAl6PHvU9gnsWnDqC2L
	 jZt8dJ35TPlrfYmroMFoytLZ4nIvDFBC8P5j+lwjfQUVkolUldHXrQnBgit41HagEk
	 35iWQ+O/N7XyLH2Aq9hzVENes3lGI4E3BMvZADWZPymqA1eVNC3FlQZa7AF8h5mJJS
	 WtwAL8UKzbQmdqH1Bqqy14incd91ee3YrrmxlTc4lSRkMQE/H4MRqFolFPE2mSujA9
	 /+IRihppkxRBw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 90AE115C6438; Tue, 20 Aug 2024 10:44:34 -0400 (EDT)
Date: Tue, 20 Aug 2024 10:44:34 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xi Ruoyao <xry111@xry111.site>, Huacai Chen <chenhuacai@kernel.org>,
        loongarch@lists.linux.dev, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        linux-api@vger.kernel.org
Subject: Re: It is correct to introduce new sys calls to stable versions?
Message-ID: <20240820144434.GA184464@mit.edu>
References: <DF762B6F-360A-4C0C-8C85-55686417209B@gmail.com>
 <2024082057-coherence-lethargy-3513@gregkh>
 <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D19DB99F-B5D9-49A6-BCF8-A5980A9BC1A0@gmail.com>

On Tue, Aug 20, 2024 at 09:49:59PM +0800, Miao Wang wrote:
> 
> I agree with you and Cyril on the version numbers, recalling that kernels
> on RHEL numbered on 3.10 contains various new features.

Some enterprise kernel versions have also been known to completely
take code whole from some subsystem (like, for example, a file system
like ext4 or xfs) from much newer upstream kernel version and backport
it into a very old "enterprise" kernel, with massive work to deal with
the dependencies that might be needed by the newer code, and
additional massive work so that structures and function signatures
stay the same so that binary out-of-tree kernel modules can continue
to load on that "stable" enterprise kernel.

That might take huge amounts of effort from a quality assurance
perspective, but that's might some enterprise customers are willing to
pay $$$$ for that frankenkernel and support for that frankenkernel....

This is also why when I get a bug report relating a distro kernel, I
tell bug reporters to go back to the distro for support.  Basically,
you can't really take anything for granted when you're dealing with a
non-upstream kernel, and that includes the version number.
Personally, I think this is a really bad idea, but distros and their
customers have the freedom to do what they want.  And this is why
those customers pay the distro the big bucks.  :-)

    	      	    	    	- Ted

