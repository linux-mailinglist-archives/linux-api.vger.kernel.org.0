Return-Path: <linux-api+bounces-6372-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFOHNNPNDmqdCQYAu9opvQ
	(envelope-from <linux-api+bounces-6372-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 11:18:11 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C75A21F8
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 11:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B512230A6E79
	for <lists+linux-api@lfdr.de>; Thu, 21 May 2026 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CDA3314B9;
	Thu, 21 May 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iTWlcAFV"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF53261B91;
	Thu, 21 May 2026 08:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353481; cv=none; b=aG3/gbyLsdDQFgcgBkfQtJKbxgpJdg6COkquZi7S/qmt6Ccn5kscG9v7qsIOtS1Ct1q5WJZtzNz1LAVJ7Npj9EHt34p+qCn3Z0RbzIIXY0aHDc9isi7tqlU78A6cH1/5DLJU4NO14Iaux4EkC6eF6v4u1q53uFGNoHccuWGnZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353481; c=relaxed/simple;
	bh=Tc9PGD5XFn2kAyJE/qKa2WP+oXivg3aOLOuSEdX41kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chMkPJUlqY3OGWkLvHTtKsW3gMSrEse8KcL37zu2QBhj3LGhmjiit4+6ElSRC54N5xuR6RbA4q6IuUmh1N4v1iCA/dNUggFmIl3fPyiIB4DRSisekMbvad0Dx2CMkb3mob9lkzo4ZHWU+U5ufBreIfAaSAMi0lk7vEr4T+R6GDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iTWlcAFV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=adkD1i4uWAA/O/XCvNqvQRIx38qTQ9cyPCt8+vT2S5o=; b=iTWlcAFV0bGroYj100cYzExpuz
	rsveboyudTm6JgzWG1IVCmUuLa8zzLxpbanYD8qxdzQYq8YiIeY2EruMxenhS8o1y4SfVtSpiGm6n
	XeSobI/z+GxYgJibYVSNh+LgT8nXyz2pe/NPNc62zXD7/tOAyWssVVQ2VUuwo96KR9jxicA3j1zE1
	6pPN4zVjPNKcXi+0GGucZo34eSB2hLyo53j4PKeNPV/FS6FHUbY6SH3ALTtS0KJtJaZCAb9HYgI6C
	eYOoMQNzCszV/wK+x2FRtUvCP4CA1j6cH6KjxIQZqYY9WNvnHgXL0K9rbYpRJxuBGRaIbOjIrpStg
	HiphiGQw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPz7V-00000007D7o-04Ty;
	Thu, 21 May 2026 08:51:09 +0000
Date: Thu, 21 May 2026 01:51:08 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <ag7HfNryTmQ-bVIS@infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_HwhzlNPUEKQi6@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6372-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2D9C75A21F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 06:15:46PM +0100, Matthew Wilcox wrote:
> On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> > On 04/14, Christoph Hellwig wrote:
> > > Please add the relevant mailing lists when adding new user interfaces.
> > > 
> > > And I'm not sure hacks working around the proper large folio
> > > implementation are something that should be merged upstream.
> > 
> > Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> > I'm not sure it's acceptable or not. 
> 
> You haven't sent a proposal.  This is a reply to a reply to a reply of a
> patch.  There's no justification for why f2fs is so special that it
> needs this.  What the hell is going on?  You know this is not the way to
> get code merged into Linux.

None of this got properly answers, and this broken interface now landed
in linux-next. IT is offloading a user.* xattr which is free-form
user data with semantics that are weird to say it very nicely.

All this was done against the advice in the mailing list discussion.

I think at some point we just need to stop taking f2fs updates likes
this.

