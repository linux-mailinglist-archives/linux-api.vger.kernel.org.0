Return-Path: <linux-api+bounces-6623-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8EKMBmNvMmq1zwUAu9opvQ
	(envelope-from <linux-api+bounces-6623-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2026 11:56:51 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B86982A4
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2026 11:56:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Ojt4Em5S;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6623-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6623-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E86C13216BF6
	for <lists+linux-api@lfdr.de>; Wed, 17 Jun 2026 09:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7945D3CB918;
	Wed, 17 Jun 2026 09:45:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45043382CD
	for <linux-api@vger.kernel.org>; Wed, 17 Jun 2026 09:45:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689540; cv=none; b=Rpn7I9oj0KVbIiqlEGt8g8bkE6BjVXHoRopcHti7zYgU3KkBNgR+2e30YW97nyjUkNWIYJDPN50+1rvYQImsaqA9kwH+meSe+c4uEbAXYWD1l0JLjrKyk+3IyyobXrS2DEStlXI9c5EkGa7Q6KaBosn21JSnhNnSaH0kkP27eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689540; c=relaxed/simple;
	bh=twlOvb2CoVN4w6Fqz+WMhzH21a+mb1zXpVSvI9ZJFIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZphvQ2yd53+7vT939ohynmns4ofaX0icNdqcxPMDZJnw9MhGxJkjWIrKb/DSdwiMcFzIhH7mx+7NhV8kTjven6rhIBNIGm5iBlRw07tnFNiY0cfqSyUOgp7kbbrHPN9o9QpEIf6+fuU6IArIXd97/4t1n5AeRFZ5aTXisZ8DPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ojt4Em5S; arc=none smtp.client-ip=91.218.175.177
Date: Wed, 17 Jun 2026 11:44:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781689525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iL7gXwiArhbYanz54F/a7E15TsUWqUH8XIrYW1qiax8=;
	b=Ojt4Em5SHuyFXs9QY6b73RwCDIQDbvdtVcKgdMlW3LgG+n2ZVYHXHKBK7u+PCH+rrDEl0o
	yiObqmlx3BFsj7v3nqctpQsRycOh20V87BQ8ZGnugasoIfzkR0qbMUXwNyn3QKm6NleG3y
	FcVcCbB2ccO0b5SqQ82iSBp/yd0Hl/Q=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org, 
	bfoster@redhat.com, lukas@herbolt.com, "Darrick J . Wong" <djwong@kernel.org>, 
	dgc@kernel.org, gost.dev@samsung.com, andres@anarazel.de, 
	kundan.kumar@samsung.com, cem@kernel.org, Zhang Yi <yi.zhang@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajFQPANpajmFuKpi@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:yi.zhang@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pankaj.raghav@linux.dev,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6623-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.raghav@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B16B86982A4

On Tue, Jun 16, 2026 at 06:31:40AM -0700, Christoph Hellwig wrote:
> [API questions for Zhang and -fsdevel/ -api below)
> 
> > +	unsigned int		blksize = i_blocksize(inode);
> > +	loff_t			offset_aligned = round_down(offset, blksize);
> 
> I think this actually needs to found up instead of rounding down.
> 
> > +	/*
> > +	 * Zero the tail of the old EOF block and any space up to the new
> > +	 * offset.
> > +	 * In the usual truncate path, xfs_falloc_setsize takes care of
> > +	 * zeroing those blocks.
> > +	 */
> > +	if (offset_aligned > old_size) {
> > +		trace_xfs_zero_eof(ip, old_size, offset_aligned - old_size);
> > +		error = xfs_zero_range(ip, old_size, offset_aligned - old_size,
> > +				NULL, &did_zero);
> > +		if (error)
> > +			return error;
> > +	}
> 
> ... then this will properly zero from the old i_size to the first block
> boundary after the old size.

Hmm, right now we do this:

|----------|----------|----------|
    ^      ^     ^    ^
    |      |     |    |
 old_size  |   offset |
           |          |
	off_rd       off_ru

At the moment, we zero out old_size to off_rd and pass offset to
xfs_alloc_file_space. xfs_alloc_file_space rounds down the offset to off_rd.

What you are proposing is to zero out old_size to off_ru, and pass
off_ru to xfs_alloc_file_space. I don't exactly understand the
difference.

> 
> > +	error = xfs_alloc_file_space(ip, offset, len,
> > +			XFS_ALLOC_FILE_SPACE_WRITE_ZEROES);
> 
> ... and here we need to pass offset_aligned instead of offset and
> a new calculated len based on the last block boundary, and then
> zero again after that.  That is assuming FALLOC_FL_WRITE_ZEROES
> allows unaligned ranges for file systems.  The block code doesn't,
> but I can't quite follow the ext4 code if it does or not, and there
> is no mention of FALLOC_FL_WRITE_ZEROES even in the latest man-pages
> tree.


I can't find any references to FALLOC_FL_WRITE_ZEROES in the man pages
master branch. Maybe we missed it. I can send a separate patch for that
once we have some clarity on the API.
> 
> Maybe we also want xfstests that try unaligned FALLOC_FL_WRITE_ZEROES
> and make sure no existing data before the range is lost and the
> entire range is zeroed?
> 

I added FALLOC_FL_WRITE_ZEROES support to ltp (both fsx and fsstress).
For example, generic/363 tests for unaligned writes and checks for any
stale data. By default, I think we do unaligned reads, writes and
truncate in fsx.

> 
> > +	if (error)
> > +		return error;
> > +
> > +	/*
> > +	 * xfs_falloc_setsize() would re-zero the written extents via
> > +	 * iomap_zero_range(). Use xfs_setfilesize() instead.
> > +	 * Update in-core i_size first as xfs_setfilesize() clamps the on-disk
> > +	 * size to it.
> > +	 */
> > +	if (new_size > i_size_read(inode))
> > +		i_size_write(inode, new_size);
> 
> I think Sashiko is right that we need a pagecache_isize_extended and
> filemap_write_and_wait_range calls here.
> 

Ok. Current fsx or fsstress did not expose this
problem. I will look into this. Thanks Christoph.

--
Pankaj

