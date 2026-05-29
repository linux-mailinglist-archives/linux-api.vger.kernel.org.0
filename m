Return-Path: <linux-api+bounces-6450-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id o7F5AfAlGWq5rAgAu9opvQ
	(envelope-from <linux-api+bounces-6450-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 07:36:48 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 882EF5FD624
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 07:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C57C302AD32
	for <lists+linux-api@lfdr.de>; Fri, 29 May 2026 05:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78E7369D5B;
	Fri, 29 May 2026 05:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vZ6FwFY/"
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7B82AF00;
	Fri, 29 May 2026 05:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033002; cv=none; b=YaRVj+oPhfuNyGSX3bPSo7hpgr32jpMTFvxUiLD1jBIiz7+FpQ1zD6q+NmOi128OKbLLK33eF1OQM3GpKA+SMijIESrCjY1zEZUWmJesgHO6QVsp1MNMIuVyUyaY399JerhexOMX5AtIJwWsH1ndIbq8r3234JizyBzIX5OhZpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033002; c=relaxed/simple;
	bh=MuWcljyp7OOdH9o85PvmckiMkDkWaaHun8MLuCLlIr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2/0bMUpRGMPCW0RbjwWQXRnqCJLBROxhRHb//jkhojwyeSkuBjZAQuK3Z+kaboEK6oh1YLFxk7aq4OzXfNmuy31c1iRWZ2bB1G5U5C90eO9TQTxX3snJSAqH+qg6i+PeFnfL+DLetlnz17ayVk2B5dnxvRI4mNhLFBVaY2uRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vZ6FwFY/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aWo/gTZ+lk7qCswHD1K4xHit8Q7TVDZZNoyS6wwTu8Y=; b=vZ6FwFY/6VqF6WzikjGIZxuBlC
	FLMmpJLHB1p5hx2CsiBI/QUAU2dEbJULNxIZqhYJcJWSj4LkthqJ3RzSqurUj8ga5p7zkk+DGxIbb
	l0CrRbsr9CTjvx51lSw1qc0faVXR5JH0vmj6Ikbyfh23v42jgWYoZ6v2AbGP/kjGmb2GZAjzcPI6z
	IluxeI7aHavbJ3PLPUbgjtngBQyObKDGlnQbakChVVkOGCAP4EJy/6Umqu93cGXoPGws54kMp3tED
	U+OMb9FtkrQnZhUtkvZlDtU4ulHdOD05FgUGQCY0ug52p0Bk0z6/rwsAHUr9uOCWNjjK+d9jeTFmX
	Q1Ew1VRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSptf-00000006laY-1dEg;
	Fri, 29 May 2026 05:36:39 +0000
Date: Thu, 28 May 2026 22:36:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>, Theodore Tso <tytso@mit.edu>,
	linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
	Akilesh Kailash <akailash@google.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahkl52N3RDcusCNd@infradead.org>
References: <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <f4e521ac-2381-49ca-8dcc-3cb3cf3ffaea@acm.org>
 <ahaPDHiXcJoVShPv@infradead.org>
 <ahcU5xbVy7xjps02@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahcU5xbVy7xjps02@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6450-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:mid,infradead.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 882EF5FD624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 03:59:35PM +0000, Jaegeuk Kim wrote:
> F2FS merges bios before submit_bio, regardless of small or large folios,
> since the block addresses are consecutive. So, I think IO subsystem was
> working in full speed.

As does every other remotely modern file system.  But that merging is
surprisingly expensive, which is why using folios gets really major
performance improvements.

For one doing these checks to merge touch quite a few cache lines.
Second, devices are often a lot more efficient if they see fewer SGL
entries.  I.e. having a 1MB bio a single SGL tends to work better than
having 256 of them.
The same is true in the kernel code itself, both in the submission path
(dma mapping and co), and even more so in the page cache handling
both before submitting and in the completion path.

See Bart's patch about how long the walk of the bio_vecs in the f2fs
completion path can take.  We had similar issues in XFS even in the
workqueue completion path due to lack of rescheduling, and these simply
go away when you do the folio manipulation in larger chunks (LAZY_PREEMPT
would avoid the need to explicit rescheduling these days, but that just
papers over the symptoms in this case).


