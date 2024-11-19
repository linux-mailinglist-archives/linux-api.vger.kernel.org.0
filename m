Return-Path: <linux-api+bounces-2764-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644399D2CA2
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 18:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2272B2811A9
	for <lists+linux-api@lfdr.de>; Tue, 19 Nov 2024 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5D71D515F;
	Tue, 19 Nov 2024 17:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1lbeCtMl"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673641D417B;
	Tue, 19 Nov 2024 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037271; cv=none; b=YP+YBIHNVnzJszKs5CZ2hJvm3Y3Qw3lL6ml6sP+cPhT6ZohZ3oJOL3Y6imJ6fl4/SzMEZ/sTG+KOoOPoNhvgLiWGDtuiOWGNGhKrYGD7tvo/tr55dO0bJeLkN9OOvmd1vK9ejAMt3qdK+H7IhOF+ESfuS1GmbOobPKoqVif+PLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037271; c=relaxed/simple;
	bh=0Ua1U+0mkSGBw1rjVXE82HHLs/omPUwMVGtC0fSMRaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T111LvGr92QVC0Sj/6P4/lRv1mNZ6riKI4GI/XEpyCyQPhKpS+28rX6CTID2ut2j8lP3qE55XOo1QpCwZ8Wacm6Np8+ONW+eg0Lp194sj6KLGn/0skAPvf7vodD/m5+u4NBgVQ2SUzbc5pvX4jGG7+N+iukUnXvi5Tts/OEizw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1lbeCtMl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CFZrYTXphcS3wMV/SPN5+lHC5syvqQD1NtobLQyDd1Q=; b=1lbeCtMlVttCXvtfL8ukHS251g
	5ij0mBhhTWV3LmPOvFWCQWgNNPvqAsLYc5APaXCiJYU16rHv6HoDmy0NcYVLqVcWR3cQHpvREpY65
	+Hg8EmcNSMtZnjLzfWSYkoPsAQDX9sc0eFUZPWJBLYb6Z4cl+pzd9CrsfXueuB/phxzeKGPDVqr99
	VTqeyFdvLFj4ppCkIrLqm1wmp8o4ynh2BApyKR1eT22MU5z2QFnKtzvL7nVtofkj3nEQKOVIXMjct
	OMBSyrV113MLJCoWAkSTrgt5GIlClkd19FBKRS9/ckDgCWe5xaVDUp0q8vJtiBgN8YfcDYcniNeTO
	2ajDS29w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tDS0z-0000000DDD7-0Ah8;
	Tue, 19 Nov 2024 17:27:49 +0000
Date: Tue, 19 Nov 2024 09:27:49 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH] uapi: add EROBLK
Message-ID: <ZzzKlex5MhE1YD3E@infradead.org>
References: <9184b5e8-7070-4395-b179-4975b2e3fbc3@p183>
 <Zzy7MGyTp9yw1ntQ@infradead.org>
 <dee8868f-45fa-40d7-bcaf-a46bf768e400@p183>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee8868f-45fa-40d7-bcaf-a46bf768e400@p183>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 19, 2024 at 08:20:33PM +0300, Alexey Dobriyan wrote:
> > And where would you return this value without breaking existing
> > userspace?
> 
> New code may start returning it right away.
> 
> Old code may start checking for both and in ~100 years delete EROFS
> clause.

In other word it's all hypothetical, you have no actual users in mind
and no ral problem to solve?

