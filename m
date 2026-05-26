Return-Path: <linux-api+bounces-6405-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMfSMCoHFWokSQcAu9opvQ
	(envelope-from <linux-api+bounces-6405-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 04:36:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B0D5CFFBA
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 04:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E114030075CA
	for <lists+linux-api@lfdr.de>; Tue, 26 May 2026 02:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9331D2F3C22;
	Tue, 26 May 2026 02:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KBdxftb+"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B66B2773CA;
	Tue, 26 May 2026 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779762681; cv=none; b=GPkl4iX4YMHHz+9RLIsznak8HB8vZI694nqYGWz1loS6FaY6efnEMIkYBFlMeVBcOVEJGN4J7qoelM93HiKvDT4yJ7EguEP7IVZJfh5tTnni00QlHnNCBCBJyedhKFly0SZ2ofoEAob3ITkcTu5sgwapCV1rvIIc08kbP0KDo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779762681; c=relaxed/simple;
	bh=R6sxRuIuRceAwwC/x+ybkOPbvLytTks6kPSwd8+3v7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8GDnteDNhH7P/98GqtYSd5kklHUo+C16GmLmMIWArtx/1ojV2aZuFXYtRcwpFDMBo/iG3X4oasZx4CVE7r0cYB6U/08beLsCHSIJsJzG0llyCVMgFLtYEZL2z/MwSoDfsex8AWQKZ7IjyUM122uN91XVrvuUQ71AR/NcTbm2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KBdxftb+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7WoZ2cyGDEh4C+rPTk20iaEyGOoLnozfqobsmxrDxEA=; b=KBdxftb+8CA/+k7KI5B/ScG2FL
	8ZvUhLI8xh1fqvDOdwK7pqbj7GlR8B0Epltbqi/c8aHTTUdjjYvFO1IjvIz6lMv7ZuED+UYQINCDu
	0MQdSnPS1GR3HJoJKoEAqGsxqXAGvYPovq9sV775oqHUxcE3U2bvfpC0ji6vcJeZvD0XvkjpXLilN
	yhVAgOzUf2dBZiAXSZSqzgjzyS+G4b1UXYiJys28F80FUehltLcRfxN7xUwVwPlNY0BIkaFppmKjs
	dEiVT6To83P6+jogDRT/MRw47QYIngN/6Fvc2IfBzCc+jHJD8doYNZFYylfiMHC/js3Iu60jiFQX2
	aCNpCStg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRhZU-00000000WP9-2Sjw;
	Tue, 26 May 2026 02:31:08 +0000
Date: Tue, 26 May 2026 03:31:08 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Theodore Tso <tytso@mit.edu>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahUF7HqSKFJ422bU@casper.infradead.org>
References: <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com>
 <ahPffhaOi2CBtWof@infradead.org>
 <ahT1nT3xsMGkyJab@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahT1nT3xsMGkyJab@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6405-lists,linux-api=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[casper.infradead.org:mid,infradead.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 30B0D5CFFBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:21:33AM +0000, Jaegeuk Kim wrote:
> On 05/24, Christoph Hellwig wrote:
> > On Fri, May 22, 2026 at 02:04:59PM +0000, Jaegeuk Kim wrote:
> > > This was a quick buddyinfo right after booting the device.
> > > 
> > > Before:
> > > Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758
> > > 
> > > After disabling EROFS large folio:
> > > Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856
> > 
> > And what are you trying to say us with that?
> 
> This means, high-order pages were used up by EROFS which sets large folio by
> default. So, I wanted to say the concern was based on actual data which was what
> Mattew asked.

This isn't that though.  What you actually need is to show that high order
allocations are _failing_.  The MM is far more complicated than you seem
to understand.  There isn't a fixed number of large folios available;
when we try to allocate memory, we do reclaim.  And if there's large
folios on the LRU list, you'll get them.

If what you want is large folios readily available, then what you want
is large folios used _everywhere_ because then they're easy to get!
If there's small folios in use, you need to reclaim a lot of memory in
order to reassemble large folios (it's the birthday paradox, similar to
the hash collision problem).

