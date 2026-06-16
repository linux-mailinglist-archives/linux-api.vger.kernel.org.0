Return-Path: <linux-api+bounces-6618-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7eg2IOlQMWpUggUAu9opvQ
	(envelope-from <linux-api+bounces-6618-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 15:34:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD54868FF7B
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 15:34:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=SHQrRDJf;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6618-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6618-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29AF3303661E
	for <lists+linux-api@lfdr.de>; Tue, 16 Jun 2026 13:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B5E2BE641;
	Tue, 16 Jun 2026 13:31:42 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6B72BE026;
	Tue, 16 Jun 2026 13:31:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616701; cv=none; b=QYbckgngqoMfq06UrU/awt20DW4RTPOzSkUqPx/UY1jTkhzCJOMrXZ8m/lIPujSH+K+83s0iCqWMygQqTdFe9DhUbCgvKK4ICXs6TqjdWCi5jRb5qUL63eQ9xpb26RjdUq2xxGCy6Kmz2il8sYE9pdCgWXB6/Jna0RhggIm0Wjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616701; c=relaxed/simple;
	bh=BTsFxLJimawtoe7HwSUkU6BfYRMpE+5vTHPsq/M0BwI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=GHuhLZATe+g4fCRa8w93m78FW0RVIwB46qYFNyO8vJKlqrs+pmo+oV1TfPsFrudmeJa0eTwp5sOrBrt2CZ+7wWSLzeRdnHa0VEF1yw8mJWaliEOsUAQzP+RfMD0gISlIWaE2nagJHwIjpnA6DMkPmhsr4UA26uXnCtHb3VBFes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SHQrRDJf; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:References;
	bh=li/q7nG5OrUyFHVdKJCEGvzSB4i/lEH7jxizLG5hQkc=; b=SHQrRDJfcDwVYGoZNoTaXlHlkh
	M+D+ZAY1tWe2WQKByW66Ag86ZaP9wcu3/YD1NgP1M0HM8PKV/89xThVV5TdP7Xim1so+FS0hBfcUQ
	ixDzNh4aUg6zjJPWxenOzYPeXnf0EFgl3R3EmTk+bLPQH6m9p1VSKCqZZmCALZk2q3QAPazfUf6P6
	cxKNNcq6QHZ+iWr9nkFLDA4HhyyZW3uGNf2Vycng3Ki/93fAfkbDGsJbYpK/9d1S706dBuOm4brf/
	t65K4XnoSfzDRPhENXdYrv4jDgnEoNlYziZb3ByR3SuR4MM9iHNAgrkDVPrUv8mXt+xGXm2Dz5+AY
	lbA/Te8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZTtE-0000000FqUR-1WKL;
	Tue, 16 Jun 2026 13:31:40 +0000
Date: Tue, 16 Jun 2026 06:31:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: linux-xfs@vger.kernel.org, bfoster@redhat.com, lukas@herbolt.com,
	"Darrick J . Wong" <djwong@kernel.org>, dgc@kernel.org,
	gost.dev@samsung.com, pankaj.raghav@linux.dev, andres@anarazel.de,
	kundan.kumar@samsung.com, cem@kernel.org,
	Zhang Yi <yi.zhang@huawei.com>, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <ajFQPANpajmFuKpi@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611114029.176200-4-p.raghav@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:pankaj.raghav@linux.dev,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:yi.zhang@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-6618-lists,linux-api=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD54868FF7B

[API questions for Zhang and -fsdevel/ -api below)

> +	unsigned int		blksize = i_blocksize(inode);
> +	loff_t			offset_aligned = round_down(offset, blksize);

I think this actually needs to found up instead of rounding down.

> +	/*
> +	 * Zero the tail of the old EOF block and any space up to the new
> +	 * offset.
> +	 * In the usual truncate path, xfs_falloc_setsize takes care of
> +	 * zeroing those blocks.
> +	 */
> +	if (offset_aligned > old_size) {
> +		trace_xfs_zero_eof(ip, old_size, offset_aligned - old_size);
> +		error = xfs_zero_range(ip, old_size, offset_aligned - old_size,
> +				NULL, &did_zero);
> +		if (error)
> +			return error;
> +	}

... then this will properly zero from the old i_size to the first block
boundary after the old size.

> +	error = xfs_alloc_file_space(ip, offset, len,
> +			XFS_ALLOC_FILE_SPACE_WRITE_ZEROES);

... and here we need to pass offset_aligned instead of offset and
a new calculated len based on the last block boundary, and then
zero again after that.  That is assuming FALLOC_FL_WRITE_ZEROES
allows unaligned ranges for file systems.  The block code doesn't,
but I can't quite follow the ext4 code if it does or not, and there
is no mention of FALLOC_FL_WRITE_ZEROES even in the latest man-pages
tree.

Maybe we also want xfstests that try unaligned FALLOC_FL_WRITE_ZEROES
and make sure no existing data before the range is lost and the
entire range is zeroed?


> +	if (error)
> +		return error;
> +
> +	/*
> +	 * xfs_falloc_setsize() would re-zero the written extents via
> +	 * iomap_zero_range(). Use xfs_setfilesize() instead.
> +	 * Update in-core i_size first as xfs_setfilesize() clamps the on-disk
> +	 * size to it.
> +	 */
> +	if (new_size > i_size_read(inode))
> +		i_size_write(inode, new_size);

I think Sashiko is right that we need a pagecache_isize_extended and
filemap_write_and_wait_range calls here.


