Return-Path: <linux-api+bounces-6397-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OQCOYLfE2qdGwcAu9opvQ
	(envelope-from <linux-api+bounces-6397-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 07:34:58 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A69B5C5F05
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 07:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E53D93008E31
	for <lists+linux-api@lfdr.de>; Mon, 25 May 2026 05:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2642933F383;
	Mon, 25 May 2026 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PoRi9mLv"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B01340283;
	Mon, 25 May 2026 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687296; cv=none; b=uhtydVNsfMjaMMm1LfPsXvT2wdNVM6AEOqncqay7vdx7mCEnhS2O0Af9FPhsNTKZiOtbceYi5+c3B7nXhn1w0/1j1vlSnNlAGOL0PV/aC74cmp7J2O/3L+zwvfarv9nSvGeYsRAJopvKzfP33r5xqn26a2eCmMiGp81oMqEV6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687296; c=relaxed/simple;
	bh=WTouQ4vdpCA67XjVbhDQadzpEfvj31sT5rtydL2DOmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lCh7VXziRlEXB6u81QyGvPB855b8cb1WDnKccYGA1mdnT1AGAllK6xChBCNFkiC4WhqdP2kfQoKckywvZbxAWIld3f0RfFa/M5beKZjGPL04K3aNlj/k/L16CwyxXeQSFGEh8a0/yJ/gPqvaQ5erf2g+rEDJ3axvRiI14ydCxmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PoRi9mLv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SjOlFOCBBZ2U5TlW9/X+d8/c+UE/9CSqg4DdbFuTHrA=; b=PoRi9mLv+pykgcHYmVN+LtRYwG
	o84cO0GmTfh7sTw5dKv4OPvIhTi4W1vIUduN4gLw3pMAOJl+0eBfGzQOdC8FL55Bc297/BjTtk8Ud
	LI6mJV81v6Rjcnf6Zn0gIuovjWt/YscFFyxZRC1x8zzsXTzUN/VEHmfPFaV3YlKVzL2+hi99YOOQm
	CvD8I9B83nWnR/LHHeuCkU5k4qu8bq0/EbcDn8wddjuk6dxsIDDegfy+OIUOZ1gxosuGGFfXGBDKW
	HHj1G/KwbB3CTTeke2TqJG3zO7g5P3tGR9zSruJKvZTKBnmlzYu4LtTtGsnvzdgOhgU91M7/R92hi
	VyvvcuaQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRNxm-0000000GKdP-08i4;
	Mon, 25 May 2026 05:34:54 +0000
Date: Sun, 24 May 2026 22:34:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Tso <tytso@mit.edu>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahPffhaOi2CBtWof@infradead.org>
References: <adhPZxtbZxgU-37v@google.com>
 <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag9D6_7dttbDGHZ6@casper.infradead.org>
 <ag_UsW_OrlXD9dWX@google.com>
 <ahBSXyOi9b1jxNkX@casper.infradead.org>
 <ahBii6bk0KbK_NHV@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahBii6bk0KbK_NHV@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6397-lists,linux-api=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 7A69B5C5F05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 02:04:59PM +0000, Jaegeuk Kim wrote:
> This was a quick buddyinfo right after booting the device.
> 
> Before:
> Node 0, zone   Normal  22684  42284  28704  16901   9515   4566   1854    673    181     36    758
> 
> After disabling EROFS large folio:
> Node 0, zone   Normal   8486   4732   2175   1161    697    272     82     19      3      1    856

And what are you trying to say us with that?


