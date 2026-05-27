Return-Path: <linux-api+bounces-6422-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CoVOxmPFmrHnQcAu9opvQ
	(envelope-from <linux-api+bounces-6422-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 08:28:41 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9D25DFD40
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 08:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E90613014421
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 06:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77500379C24;
	Wed, 27 May 2026 06:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nS7j8vx2"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C97F3655E8;
	Wed, 27 May 2026 06:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779863316; cv=none; b=UTdHQZ4XfxnJIW8DnB4OkCR7on9CxoZg9skwt+0UEZnYtyPpvkMOP0jun7cES8D4X2czMIGXrTsh/Qyfspik6ua7qNbgpHHQI/tDth1YMYA61FAB2ZJx50W5PI1bjmwrYqxDynmqE/Jg1YBxiZkpB8E/JLknK/msLJW6QYcOI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779863316; c=relaxed/simple;
	bh=RLrZ6IfmbbJO06SvlF07nmPcHuhdw0xUgD0X1837g48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2ebtxCsS3u7U51DsyCPw8VkUJMQ3n897SHrQOQlDT925YoGl6+7bN+XjXDsI67AdxaW+gz1FPfeE7j3jUuYKj+7TQAeHyzkK6G9nIYkFb/mq2oIpy7AewdmaYbjyXrANXclFgNJx/XkN+93YJuhiWFqOiL5vxFnB4Q2IfbayIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nS7j8vx2; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ka/9L3mGRr/AbgLqT0X1N/LKODg56XkQXKLxkU0UHzU=; b=nS7j8vx2eymE0ZSZoDXuT2yyfB
	/S4PFwuANnKUoJp7Giy3+PPZL2gSAx1o/0tYaYdwpEB5m5NxnKmi0la7rA+Kdjp8Tg0DTzC3wbrdb
	p0SdCWxYoxDL4R+uCloO+ntIkscwqjOUheJxRyg6k3URoBMbJg02NwWXHUDRHOhOsoUcznSjqCr7R
	nzTIsYlAv+FvrDCQTadRi0C0ba3pnNgQPJvhBxUeWgi03KEwJcO3vfxYgKtesqiYn6VhwjAlat7Im
	ccYCea5H39rArdAXYTH8KgLSGMAdaGm9wmifOC0WrWvLVA7yRspaKDM4ho8hHu1TqWsRqsxOjMKHA
	XhyVjWPw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS7ki-00000003Ozf-3Lht;
	Wed, 27 May 2026 06:28:28 +0000
Date: Tue, 26 May 2026 23:28:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Theodore Tso <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahaPDHiXcJoVShPv@infradead.org>
References: <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6422-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5C9D25DFD40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 09:14:52AM -0700, Bart Van Assche wrote:
> On 5/26/26 6:42 AM, Theodore Tso wrote:
> > It seems... surprising that the additional I/O operations are actually
> > throttloing UFS device bandwidth by 2x (4GB/s vs 2GB/s).  Have you dug
> > into why this is happening, and whether there is anything that can be
> > optimized below the file system?
> The layers below the filesystem (block, SCSI, UFS) is what I'm
> responsible for in the Pixel team and I can assure you that these are
> highly optimized.
> 
> Since the transfer size used in Jaegeuk's tests is much larger than 4
> KiB, how many CPU cycles are used per IO by the layers below the
> filesystem is not limiting the transfer bandwidth.

I'm honestly not sure what discussion we have here.  Larger I/O is
pretty much always more efficient.  If you submit smaller I/O you
need more merging to build it back up larger, and more I/Os.

Which is exaxtly why we need large folio support everywhere, as it
makes a huge difference in I/O performance.


