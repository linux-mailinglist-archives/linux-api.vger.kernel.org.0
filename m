Return-Path: <linux-api+bounces-6629-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XsXFJya0M2oTFQYAu9opvQ
	(envelope-from <linux-api+bounces-6629-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:02:30 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC93369EAE5
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:02:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=psl6gWoZ;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6629-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6629-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D43FD3072F6C
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 08:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9B73E075C;
	Thu, 18 Jun 2026 08:58:11 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128AA3DEAD3;
	Thu, 18 Jun 2026 08:58:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773091; cv=none; b=TmO7Ca7Gi1O+Sf5/dqufAsa8SGtj2hhmVSnnDZtMdIRTx9xr9Nb/enrOvsOMaIuhBso07xkb24vfXf/uKYPgYiLmyK18V9Dj9/yxskdvl4TO3sMcYYIRDAl8hUZqqXc2BY44F+coVTX/Q2gI/k3bRJQYPCNGyUnInt8cN9pblRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773091; c=relaxed/simple;
	bh=DRS/FIfLaujjZj+AsiPwk4bvPyKbGEHdXqHDoQoFnb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nwe842gwDE9BMpFJ8ZspGKOMfOVRVaBQXAgspjvmq/8B4+DEVceo+/7J6lPoTeDR2p41Rtj6NZpCtddVVuaf8ZSNZLs/y0TbVQvXEtxiYg7WAWlrIGBmkIzvgqG/gsC5ITCmJB3xi8gubbe+9oEx969y6suSAX6qxYj34Nbb7HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=psl6gWoZ; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Di6uLJ59HEcO8cD37aP1XkFmRVYxWa5zWHj0HviWVp8=; b=psl6gWoZQ+MLUwF1vxNInomZnE
	onuVwGSzwPWKt+Gx95D4Vp6prqrShTHXp4XERuYckjkUUGVsOxVsXvw5jOYeR6a16/Xyj5mJ8YFNS
	iurh4EZlDUhO3fCz3ujCxj8WXcuIWcNV2+fPioqn5oMR9uNdgu3Q/HlvAp7k0r3FTP6lxcwHpBP1O
	rBY84QG+WO84qAGfcr8tR43wkj7EAxS1PpVc7C2pSqkyvnL/NRobGtYGLoek07ujkCCXWdgeyTLbl
	QnPKzRt4hKTMbB5AE3Dsoai3WQq77r7whQRImM9JbtU8lqSVYWb25Mpd5Ndftnz9wfwO0gokN7K1f
	s9AUNm8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa8ZQ-00000000t3e-1ByC;
	Thu, 18 Jun 2026 08:57:56 +0000
Date: Thu, 18 Jun 2026 01:57:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org,
	bfoster@redhat.com, lukas@herbolt.com,
	"Darrick J . Wong" <djwong@kernel.org>, dgc@kernel.org,
	gost.dev@samsung.com, andres@anarazel.de, kundan.kumar@samsung.com,
	cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <ajOzFP66T-DLsnNy@infradead.org>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <557b2e5c-7c65-48de-87a9-6fba21eca99f@huaweicloud.com>
 <6l3n2w2b7qoz2g3kfu3xsdjhlzq6m4ocs6ptq2esq27wxrb5ve@5gqv4ei4gi4b>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6l3n2w2b7qoz2g3kfu3xsdjhlzq6m4ocs6ptq2esq27wxrb5ve@5gqv4ei4gi4b>
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
	FORGED_RECIPIENTS(0.00)[m:pankaj.raghav@linux.dev,m:yi.zhang@huaweicloud.com,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-6629-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EC93369EAE5

On Thu, Jun 18, 2026 at 10:18:49AM +0200, Pankaj Raghav (Samsung) wrote:
> So, I could do xfs_zero_range(offset, offset_ru)[1] and xfs_zero_range(end_rd, end).
> (offset_ru, end_rd) will be using the accelerated XFS_BMAPI_ZERO to 
> zero out the extents. 

Yeah.

> I also need to add pagecache_isize_extended and filemap_write_and_wait_range
> to persist the xfs_zero_range calls before we call setfilesize.

Yeah,  Or we need to find a way to use xfs_falloc_setsize after all
which would share all that code, although I'm not really sure how
that would work best.

