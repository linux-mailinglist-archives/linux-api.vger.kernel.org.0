Return-Path: <linux-api+bounces-6383-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PjbIClUEGodWQYAu9opvQ
	(envelope-from <linux-api+bounces-6383-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 15:03:37 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 001BB5B4B9A
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 15:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 901193032767
	for <lists+linux-api@lfdr.de>; Fri, 22 May 2026 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A55C37AA8B;
	Fri, 22 May 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XvONFtj/"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4421FF21;
	Fri, 22 May 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454567; cv=none; b=F1kzdv9fPYIS5dCsUa3FBGUsl3AJLGu0gNbBVp8YnsaOwyR+q16mPcbUHNgqnZDHUM7e0CiZTWkH78kVucI3dwo4LTaLHgbCRL6h8ZA7Yc4xJAHVL+jLTfMzuOHAelDdVd0vtwXaSj1RNUy4/A5eZG3iSy9odv6euotFvTc8mEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454567; c=relaxed/simple;
	bh=ZSlCvPZVKNxqzgWvJnxr4N8aDQHNCqnKL5aCO++lLA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYkTkWfmtaP5kr/DfmQUUO7wQu5miPzKhJt82FvfMPsLn5dFqUVh1FMIa9LkMskDpXDKBlrMpRrljWjF5+ANjx8QYMCiqTf7YdYXmUnL4ORSNIW/MZGasJDcT8kdxX5G98YS7+uljYeC+0vhLK6SzrZ03U0mHAepnYRopv3ARiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XvONFtj/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=GJRt9Lpuwesly2s9mn+jBQgZQVuZWSioljyp5VarGsg=; b=XvONFtj/OYXrdj+0CGgw20dTEG
	RY2jeN/WZcKK38rmHxiRjUt+SntpeA8EPhwp2eWQWftIp/acL8AUxIddJ+0Qpiy+TLiwpATROeCSo
	Fs8dFNF5pwkTnR8BnpYnT1ogZ2D4SQiq/XJ/cQlURwpKK+ui/LLoaO9oOVEQE/K2K3XuLXS3K9dTC
	Zw4aVVXiNdo4g11gW8T3dKmIDul5g8DUK/ZAhtr+ArwedNMhdliuq3YawrBCctxlDVIeoH478fdCF
	3c5teZhzX197GPxz/qNKg4LapdHnk4Ok9Nta/gHolWI0GTNkbg16dMhpolPgBSuplVd/zsQQPhcqZ
	hutvFDhg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQPPz-0000000A6hF-37gM;
	Fri, 22 May 2026 12:55:59 +0000
Date: Fri, 22 May 2026 13:55:59 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org, Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <ahBSXyOi9b1jxNkX@casper.infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag_UsW_OrlXD9dWX@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6383-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,casper.infradead.org:mid]
X-Rspamd-Queue-Id: 001BB5B4B9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 03:59:45AM +0000, Jaegeuk Kim wrote:
> On 05/21, Matthew Wilcox wrote:
> > On Thu, May 21, 2026 at 11:57:48AM -0400, Theodore Tso wrote:
> > > So let me get this straight.  This is a magic xattr interface which is
> > > not even persisted in the file system, but instead sets a 32-bit
> > > bitmask in the struct inode which disappears once the inode gets
> > > flushed from the inode stack.  And it uses a generic xattr name,
> > > "user.fadvise".
> > > 
> > > There's no way in *hell* any other file system is likely to adopt such
> > > a broken interface, so why didn't you just use an ioctl to set this
> > > magic f2fs-specific flag?
> > 
> > I mean, yes, this API is horrendous.  But it's just another example of
> > f2fs thinking it's somehow special and not just enabling large folios
> > like other filesystems do.  This hurts everyone, not just people who use
> > f2fs.
> 
> >From the production viewpoint, I raised a concern on setting large folio by
> default, since that exhausts lots of high-order pages, which were needed for
> essential system services and critical apps.

Random fears or actual data?

