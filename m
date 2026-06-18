Return-Path: <linux-api+bounces-6628-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fGUYJEGqM2peEwYAu9opvQ
	(envelope-from <linux-api+bounces-6628-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 10:20:17 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB9569E677
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 10:20:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="v//W7HzY";
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6628-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6628-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFE7030283C7
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 08:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247AC379C45;
	Thu, 18 Jun 2026 08:19:25 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C98F38E124
	for <linux-api@vger.kernel.org>; Thu, 18 Jun 2026 08:19:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770764; cv=none; b=f5yhd03+/JptiZy0+UfHHv24MYUmUeR6WdVwdLIsSXjYC8MSMjU29WdDI0vpPFV/dFTsdNVSMESUavc/7FH9zwt4IcQNABqHnYzcRAJbcIuXRVS18YDJr3tWlSynqJU6yVpYNJcC7HOYnjmDJ4DeO2nVV7AnlIHkxOSE350ryJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770764; c=relaxed/simple;
	bh=NM0M/Ov11BuLYFvgAhPIa8H0+J7ylb7vIuaBlSeCAQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwYMqS1vEVTL6e4ArPVe7LxpiN6Bn48Pgkc2T2b3/YFrTkhNDzXA8zd5Quyrn/QlDaqA8Hf4b2ohcNVHvgS/8slplawR1yCFSHKdLjm8Ekazynu1W+RGneLvKIgvtxnDX3/+sA7ErTGEAuKYL/iSL9QL8VVGZ8wIxSExQi8n8/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v//W7HzY; arc=none smtp.client-ip=91.218.175.179
Date: Thu, 18 Jun 2026 10:18:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781770749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTxrs3IohyTqrlr69ZClYgsVznrNRnmnSJTLpRksUoY=;
	b=v//W7HzYxKV8IZYOyMHblstMWE51VJhcxH+QCG+vqEhEJOcaWFzcji+RFSIML9X4qc2rG6
	A91KGoCgdjojVRvPtwIl8g6sShryLKb8HVxkLm2fdXyJ7xHZ78HoDFpE6LCx0RESXbL26P
	NQRMsTnc2i3CBzFBJzZN20fK+JMj7UM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Zhang Yi <yi.zhang@huaweicloud.com>, hch@lst.de
Cc: Christoph Hellwig <hch@infradead.org>, 
	Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org, bfoster@redhat.com, lukas@herbolt.com, 
	"Darrick J . Wong" <djwong@kernel.org>, dgc@kernel.org, gost.dev@samsung.com, andres@anarazel.de, 
	kundan.kumar@samsung.com, cem@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <6l3n2w2b7qoz2g3kfu3xsdjhlzq6m4ocs6ptq2esq27wxrb5ve@5gqv4ei4gi4b>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <557b2e5c-7c65-48de-87a9-6fba21eca99f@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <557b2e5c-7c65-48de-87a9-6fba21eca99f@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:yi.zhang@huaweicloud.com,m:hch@lst.de,m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pankaj.raghav@linux.dev,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6628-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,5gqv4ei4gi4b:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BB9569E677

On Thu, Jun 18, 2026 at 11:22:45AM +0800, Zhang Yi wrote:
> On 6/17/2026 5:44 PM, Pankaj Raghav (Samsung) wrote:
> > On Tue, Jun 16, 2026 at 06:31:40AM -0700, Christoph Hellwig wrote:
> >> [API questions for Zhang and -fsdevel/ -api below)
> >>
> >>> +	unsigned int		blksize = i_blocksize(inode);
> >>> +	loff_t			offset_aligned = round_down(offset, blksize);
> >>
> >> I think this actually needs to found up instead of rounding down.
> >>
> >>> +	/*
> >>> +	 * Zero the tail of the old EOF block and any space up to the new
> >>> +	 * offset.
> >>> +	 * In the usual truncate path, xfs_falloc_setsize takes care of
> >>> +	 * zeroing those blocks.
> >>> +	 */
> >>> +	if (offset_aligned > old_size) {
> >>> +		trace_xfs_zero_eof(ip, old_size, offset_aligned - old_size);
> >>> +		error = xfs_zero_range(ip, old_size, offset_aligned - old_size,
> >>> +				NULL, &did_zero);
> >>> +		if (error)
> >>> +			return error;
> >>> +	}
> >>
> >> ... then this will properly zero from the old i_size to the first block
> >> boundary after the old size.
> > 
> > Hmm, right now we do this:
> > 
> > |----------|----------|----------|
> >     ^      ^     ^    ^
> >     |      |     |    |
> >  old_size  |   offset |
> >            |          |
> > 	off_rd       off_ru
> > 
> > At the moment, we zero out old_size to off_rd and pass offset to
> > xfs_alloc_file_space. xfs_alloc_file_space rounds down the offset to off_rd.
> > 
> > What you are proposing is to zero out old_size to off_ru, and pass
> > off_ru to xfs_alloc_file_space. I don't exactly understand the
> > difference.
> 
> IMO, FALLOC_FL_WRITE_ZEROES should handle the unaligned cases, if the
> 'offset' and 'end' are not block-size aligned, then:
> 
> 1) if the two blocks straddling the boundaries have not yet been allocated,
>    or allocated as unwritten, we should round outward the allocation range
>    and zero out all allocated blocks, including those two boundary blocks.
> 2) if the blocks at the boundaries are already in the written state — which
>    can occur when we call FALLOC_FL_WRITE_ZEROES within the file size. We
>    should be careful here: we should only zero the ranges [offset, offset_ru)
>    and [end_rd, end) for the boundary blocks, leaving the already-written
>    portions of the boundary blocks intact.
> 
> Thoughs?

Ok, this makes sense to me.

@Christoph, now I understood your reply about rounding up and rounding
down.

So, I could do xfs_zero_range(offset, offset_ru)[1] and xfs_zero_range(end_rd, end).
(offset_ru, end_rd) will be using the accelerated XFS_BMAPI_ZERO to 
zero out the extents. 

I also need to add pagecache_isize_extended and filemap_write_and_wait_range
to persist the xfs_zero_range calls before we call setfilesize.

xfs_zero_range should take care of the boundary blocks so that we don't
overwrite any data or zeroing out the unallocated or unwritten blocks as
pointed out in 1 and 2.

Let me know what you think. I am also wondering how fsx did not trigger
the boundary block edge case where the current impl might zero out user
data in the boundary blocks.

[1] if old_size < offset, then xfs_zero_range(old_size, offset_ru)) 
--
Pankaj

