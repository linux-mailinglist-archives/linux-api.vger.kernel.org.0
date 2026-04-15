Return-Path: <linux-api+bounces-6090-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FBVFtzH32kmYwAAu9opvQ
	(envelope-from <linux-api+bounces-6090-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 19:16:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1176C406B65
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 19:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D4AA3031AE1
	for <lists+linux-api@lfdr.de>; Wed, 15 Apr 2026 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B783E867D;
	Wed, 15 Apr 2026 17:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y/qzKwPC"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854E373C04;
	Wed, 15 Apr 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273353; cv=none; b=mgrvCMwrF9s0uniy6SHMvnMTVv4Yto0QskQ1N7MgngHv6Kf6zkJFu6XqSrbNuUuc8EJ+X20BwG1bH04cssz2Q2BnEwNborkyLK5U0cbdbzc8kuNyT4G2H6v/Ig+r1MSTlbbqPpuKZUS1G/WYvmdgaa31tGEepHdUG+elXYZyvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273353; c=relaxed/simple;
	bh=7I7JlqSjbv5jsbL4I06PiKwYdnHw0Y0zTbU0r8ESmCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IlfXaiV6ZTMNcUgk2aCbBWoIVjnVtQx6lNYKcDZ1Y8pk6fnlR8LJoZ7DCTWt6KCXErK4uRaYplTtADaFFnehD1GjwHEfzwui5GCkpauWknazLDdfBXTsgYbN7rEFCvA5WuSxYkbfMAbTrU//8AfsKWWV/0EFUdn7pHgiKt4OSI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y/qzKwPC; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ISsLIKP4bjUxgr4BYttgZs8l+uxApeegxanE10R4kzc=; b=Y/qzKwPC6h8YPlkBZrqWGNfOS9
	5WTrl/NWtmNx2pAqg9rGoNGsdTZbyEoa/UdSYzqUEldGyhWm8V4whdF3OLQUdwLt1eP0fAqmfrL65
	l7Q9dYGb5zIuRdxB3tfwHPxFpEPav9jk3SBFyrVHZsZThn+Lqx9KMem0N9hpLf2rGAPTEH0wvPUNi
	ZqKitex3Q//ilsBhw/U9xr7IxjJotzWolQkSg5uCdBphNeGYZqWaegBkJggGzOJsoSMz0hnvCY4wB
	6cxYIv8YOCP6BT8rt/FLq2pRni5qxu/xDz8E6P7NMiDThQbpryw/4ujK93ThvoueCSWF0CapbVOu5
	49KLzwaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD3q6-00000000CP7-1hCw;
	Wed, 15 Apr 2026 17:15:46 +0000
Date: Wed, 15 Apr 2026 18:15:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: another way to set large folio by remembering
 inode number
Message-ID: <ad_HwhzlNPUEKQi6@casper.infradead.org>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad_AVHe7RMnGrGTb@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6090-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: 1176C406B65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> On 04/14, Christoph Hellwig wrote:
> > Please add the relevant mailing lists when adding new user interfaces.
> > 
> > And I'm not sure hacks working around the proper large folio
> > implementation are something that should be merged upstream.
> 
> Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> I'm not sure it's acceptable or not. 

You haven't sent a proposal.  This is a reply to a reply to a reply of a
patch.  There's no justification for why f2fs is so special that it
needs this.  What the hell is going on?  You know this is not the way to
get code merged into Linux.

