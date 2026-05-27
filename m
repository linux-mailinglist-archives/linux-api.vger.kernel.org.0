Return-Path: <linux-api+bounces-6421-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMawG+OQFmrqnQcAu9opvQ
	(envelope-from <linux-api+bounces-6421-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 08:36:19 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E515DFE9E
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 08:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15A143115A40
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 06:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D11C36D9E7;
	Wed, 27 May 2026 06:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oOdaSz4J"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F0C3672AC;
	Wed, 27 May 2026 06:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863216; cv=none; b=qW0MWrra2YGkpg/Kget9CsztjGCr+F7I9hAdErHwTHQ9hGT92IPdjZ8uZnDp9ksGZ1upqvvHKco2lIyQAmvPd71zsxy0va3189uaoCgoPrT5NO1r8Pmk181HmBbOUORwuQFN2knefDSeBm57R7RnFiHiYiqyL1f8rdwqf1bIvlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863216; c=relaxed/simple;
	bh=f0ttClqIel5idqWSO+8gDmJpHUO9qjXPHrABk/PhM5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDJNTOp8/FCyrnD3LhSDM3wHbqY/E+3vRrPKohYJ9gouXNxWVCr0dwCkUw1AISw/VeY9kV5T2yuU+wYCS/hxtuzQ6pggjWV7doyr6yj/2tHp9FkNqKMx+CZ1CctMAtoqadxhHkt3aDRNaGfebIbMACKjw6fQ2CE5s1FBbBxx1gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oOdaSz4J; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8+XkHO39t4awUaNWWRttBXc0bFBVogyz9MOEaNzq0Ko=; b=oOdaSz4JzDOg+7gC5jF16HQGsX
	1mI1RwNcWbxdl0dt2+SrNDJko7kj/Xbtcn8RJd4xY8eNH5wiUNuZ5Af5Sn/UyQ5g5nNtD+1fgtXjk
	MrQ8HPP/p3A9eQnX7NzYbj68sfw171zIrY/jvQrXtTnm+ubXHYLLOOGAW/jp7q4RbrRxH0CMB0E4U
	ClthjAiJa7Do7xJpP8q3A2d/KQXxqRw/pbj+Y9kXsseteWmYh2uMIxNpxjjlnXVBgbUkUt6PgSQwK
	MoxMIsyFlNFIuIn2VHeoQJUANSe+aI+kPbznEt/2Hb5iudZSxKnuLFdpZsyQGkuFmadEMHFUO40dz
	PeNAEIxw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7j3-00000003Opo-11Tj;
	Wed, 27 May 2026 06:26:45 +0000
Date: Tue, 26 May 2026 23:26:45 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahaOpdw7NgsWe8J4@infradead.org>
References: <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com>
 <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
 <ahUF7HqSKFJ422bU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahUF7HqSKFJ422bU@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6421-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: B9E515DFE9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 03:31:08AM +0100, Matthew Wilcox wrote:
> > > And what are you trying to say us with that?
> > 
> > This means, high-order pages were used up by EROFS which sets large folio by
> > default. So, I wanted to say the concern was based on actual data which was what
> > Mattew asked.
> 
> This isn't that though.  What you actually need is to show that high order
> allocations are _failing_.

Exactly.

> If what you want is large folios readily available, then what you want
> is large folios used _everywhere_ because then they're easy to get!

Yes.

> If there's small folios in use, you need to reclaim a lot of memory in
> order to reassemble large folios (it's the birthday paradox, similar to
> the hash collision problem).

Yeah.  Although it seems we have an issue with > order costly folios
at the moment, but we should fix this.

And f2fs really needs to up the game and support large folios fully
so that we can run that kind of analysis there as well, without this
all this is just piling hacks on top of other hacks.

