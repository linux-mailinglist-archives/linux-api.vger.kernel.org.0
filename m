Return-Path: <linux-api+bounces-3580-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 605DEA9CC1A
	for <lists+linux-api@lfdr.de>; Fri, 25 Apr 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D40A7B1557
	for <lists+linux-api@lfdr.de>; Fri, 25 Apr 2025 14:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BE92580EA;
	Fri, 25 Apr 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oqloO3x5"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE54C6E;
	Fri, 25 Apr 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592884; cv=none; b=svHp1T8XezSyqIjDKP5B4NOmw2XgBtBrXJqEenhtxKaiYooyMotEf/apdHiF7AFoymvEpVsn0dRNbZY/fylPZOe8X7SSEJ5dzkH9mjfpZRhI92FzNVGTRYRRiiVN3VUJ7zJaRMIyNND3zvUT5SyyxD4/GdOExzOWZ2neLM934NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592884; c=relaxed/simple;
	bh=RvPz9P/xWFbjN4R/44F2CD5ntYfESh0QayO1nYK55/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chFBPZe3uiM2mbmaOMWx6sx8Th4nKyZ8Zz8E+5h7Wx+LAKd07VeKjdELoUM8VRp7kvvUjqJv+oaw3XwO5loFn+g33Fbl1Q7BdIiRk5Eqr2Sgde48KluVDxUEHNqz3gjbEZKqjNeyzhbg025D1rX51UpNT/qJbwnC5yGx0h77uAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oqloO3x5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=xDAcHLmzqgw7fTCKYdHAySGHJ9PTRatNCyZPLqDB0bs=; b=oqloO3x5xqYlVPjq9Bc6WJVcHB
	R9ahThx0dVeOJ0LbbhE9RD9HmaT5DEZGBPK0A9sgEk+pc1D5SjFVQqupR6u2gd9/DxqIOzOJBxCLT
	smSj8DsTGTIYhPdBdulHAyMMjRxb1ci7/bjhObh/JqyAwYkbVNNeWfnyBDDxoaajzl4xhJuvSV8G6
	Wq08yCEtmw1Tq+acnTe+hv/Y3QbcbfNZ2ge9VkviiOANeDLGJZxWAAF/AErWT9BKi+/+oiV5CKnRg
	sn3CdSbFwIPaOXztK2OI8AxUuZs2qWRbLSwDjnk1cd2HS3rmPEvJ9+rYxI1dHAhReAU/ba2ZNUkm4
	JvKqFeyA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8KRu-0000000HUvj-13BS;
	Fri, 25 Apr 2025 14:54:42 +0000
Date: Fri, 25 Apr 2025 07:54:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Alejandro Colomar <alx@kernel.org>, linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: newlines in filenames; POSIX.1-2024
Message-ID: <aAuiMqkjVbW3c8nx@infradead.org>
References: <iezzxq25mqdcapusb32euu3fgvz7djtrn5n66emb72jb3bqltx@lr2545vnc55k>
 <20250422222131.GE569616@mit.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250422222131.GE569616@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Apr 22, 2025 at 05:21:31PM -0500, Theodore Ts'o wrote:
> Do we have any information of which implementations (if any) might
> decide to disallow new-line characters?

AFAIK: none.  At least none that matters.

> Personally, I'm not convinced a newline is any different from any
> number of weird-sh*t characters, such as zero-width space Unicode
> characters, ASCII ETX or EOF characters, etc.

It isn't any different in a substantial way.

> I suppose we could add a new mount option which disallows the
> weird-sh*t characters, but I bet it will break some userspace
> programs, and it also begs the question of *which* weird-sh*t
> characters should be disallowed by the kernel.

Don't go there.  The only limitations that does make some limited
sense in some limited environment is limiting to valid utf8.  We've
already done that for CI, and that's causing enough problems despite
having a use case.  Adding random mount options to limit random
characters has a lot of downside but absolutely no actual upside.

> 
> > I guess there's no intention to change that behavior.  But I should
> > ask.  I thought of adding this paragraph to all pages that create
> > file names:
> > 
> > 	+.SH CAVEATS
> > 	+POSIX.1-2024 encourages implementations to
> > 	+disallow creation of filenames containing new-line characters.
> > 	+Linux doesn't follow this,
> > 	+and allows using new-line characters.
> > 
> > Are there any comments?
> 
> I think this is giving the Austin Group way more attention/respect
> than they deserve, especially when it's an optional "encourage", but
> whatever...

Yeah.  Don't even mention these idiotic recommendations, any attention
spent on this is too much.


