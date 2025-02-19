Return-Path: <linux-api+bounces-3250-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B724A3C204
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2025 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151A616E04C
	for <lists+linux-api@lfdr.de>; Wed, 19 Feb 2025 14:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2167A1EE7BE;
	Wed, 19 Feb 2025 14:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KvjMdccX"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EE31E5B65;
	Wed, 19 Feb 2025 14:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739974970; cv=none; b=KwfyKuuLDnQmyQw4pijbdqhHr8t8npFeDY2MLnHQxorSRl2y3XSBESOeQfCITcHj2XvgGekwmd7HfiuKYGR2L/LKEGqS9stFmRJvHBZQV/4E86NW5XRUYXYsaJl3wbHJ6/QYZXLGsdS1xEVmY3CbSL4x+Y7OpsQDn7ZCOHHkjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739974970; c=relaxed/simple;
	bh=GTM0nMqLEseQqbskm/xMfNFu229ExtSbl6yk5KrJ6gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2e2FtALiyU0ALkGVkXGK5Ip6IZsG7k3ypPeaBpZr2op4kskxDJEpk1C55Kibky0ZhDBIwrg97/9Xhw6SmbJyvXd7C5H6diknRBnVrDKJ7BiB82//JX2gxOldfLZ/T+3U472NM2nPDc9T/8HFD6HsQJ4ookr+uyJwgGK3s5kybM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KvjMdccX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ECCC4CED1;
	Wed, 19 Feb 2025 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739974969;
	bh=GTM0nMqLEseQqbskm/xMfNFu229ExtSbl6yk5KrJ6gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KvjMdccXWY0mGNivdlQdAsrJ0unYr0odpSg0DzGNRRdmxH0mYIK43hTxK/ic0SumD
	 9hX2L8wNafdx57zHXjzMpsYnuuhDXJgdL9Vuz+hNDGrAXRMViLbpoy+KsZvWqol9wo
	 OCk8TmnkV1n2KQUYRWf0Up+60IanHkiyQKaRJ02Q=
Date: Wed, 19 Feb 2025 15:22:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	Mike Lothian <mike@fireburn.co.uk>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] ntsync: Set the permissions to be 0666
Message-ID: <2025021933-sureness-tipped-ff2b@gregkh>
References: <20250214122759.2629-2-mike@fireburn.co.uk>
 <2768333.mvXUDI8C0e@camazotz>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2768333.mvXUDI8C0e@camazotz>

On Tue, Feb 18, 2025 at 05:57:31PM -0600, Elizabeth Figura wrote:
> On Friday, 14 February 2025 06:28:00 CST Mike Lothian wrote:
> > This allows ntsync to be usuable by non-root processes out of the box
> > 
> > Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
> > ---
> >  drivers/misc/ntsync.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
> > index 055395cde42b..586b86243e1d 100644
> > --- a/drivers/misc/ntsync.c
> > +++ b/drivers/misc/ntsync.c
> > @@ -1208,6 +1208,7 @@ static struct miscdevice ntsync_misc = {
> >  	.minor		= MISC_DYNAMIC_MINOR,
> >  	.name		= NTSYNC_NAME,
> >  	.fops		= &ntsync_fops,
> > +	.mode		= 0666, // Setting file permissions to 0666
> >  };
> >  
> >  module_misc_device(ntsync_misc);
> > 
> 
> Reviewed-by: Elizabeth Figura <zfigura@codeweavers.com>
> 
> --
> 
> The comment seems rather redundant, but otherwise this is correct and prudent.

I agree, I'll drop the comment when I apply it, thanks.

greg k-h

