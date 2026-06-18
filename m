Return-Path: <linux-api+bounces-6633-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7RkBM068M2p1FgYAu9opvQ
	(envelope-from <linux-api+bounces-6633-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:37:18 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AA069EEC5
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:37:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=i88N8zVY;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6633-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6633-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FF12301C100
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6383DB97A;
	Thu, 18 Jun 2026 09:36:03 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324930CD95;
	Thu, 18 Jun 2026 09:36:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775363; cv=none; b=PyyfcSaKk8uA0Ujy0wj1vbu2ITndZz1g50pt74zeH9vB/F8UnDoFOJhfLw9vUtmKn9oi8FDvkLA+AtmvhqY/X/AjTFpfbeFEnTifYzOFnUyBvRHaaA5uWiYMj1JuaIihub2POkO24rcP+YXIiJmJ2LRySxusA1yoca9Lycff0UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775363; c=relaxed/simple;
	bh=P9n7eGdqJOGmvD0c5Mp5cgGCsG75MKCfe6lEc0Wxq+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWPyy5O7ZkQh7bmg2Aa8SrYpE9s44jzvDDlFAJGymiU3PVgTVhyyW0X60hTlSIU5tr4hiC7KFcyBEjsUyp4qdUYqlpM7aJlIOGfxVffhLGn9c7WC2zLIgj/jviGVqJghRL5GFwRF/tgxVi+VIc43fMbiw687MXsexQyMRXk+x1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i88N8zVY; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bryYsgJLmpz/0bnPfKrtP5aBJZ/WQo8rb2E54KYZps0=; b=i88N8zVYADwE59FedHNDy5uC0O
	4cMq23kzqVs96Zct9+Yz2V3RRVifFyDy+kLQnz6bh8JxgpZ5bGL3qlsYtfet6Q3KN4koc+/tMHByd
	SGJMe+3IMxOoSYWcIV+28FNjafjwXe9hPAttBBeFg5YcE6k9+Szkcy0n9DpuHLt/w6KSSHL9mBxKn
	3iV923d151DcM0+UrfmW55piDk7dAcrR5sr2/RRF8pW6PSrhR6K6K08RAY4kVx62Ho1sPmbS9bKqq
	7pPTY9FIfn/xEmVGPKYLbLQIprtenaXYzkHzeCi/KL6o/35k9vJAHZYAW30csKOHZHGRGivGUqUAw
	VX5n3NJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa9AG-00000000yiu-2lnE;
	Thu, 18 Jun 2026 09:36:00 +0000
Date: Thu, 18 Jun 2026 02:36:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org,
	bfoster@redhat.com, lukas@herbolt.com,
	"Darrick J . Wong" <djwong@kernel.org>, dgc@kernel.org,
	gost.dev@samsung.com, andres@anarazel.de, kundan.kumar@samsung.com,
	cem@kernel.org, Zhang Yi <yi.zhang@huawei.com>,
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <ajO8AHsMFolUQLra@infradead.org>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <ajOzoBt_peOCtNUm@infradead.org>
 <au3yznolpebvd5vphmzv73fzosdy7bxrb45kv56n734jnwwj3l@43d7sqlef27k>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <au3yznolpebvd5vphmzv73fzosdy7bxrb45kv56n734jnwwj3l@43d7sqlef27k>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pankaj.raghav@linux.dev,m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:yi.zhang@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-6633-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58AA069EEC5

On Thu, Jun 18, 2026 at 11:28:15AM +0200, Pankaj Raghav (Samsung) wrote:
> > But I guess not unaligned FALLOC_FL_WRITE_ZEROES?
> 
>         -r readbdy: 4096 would make reads page aligned (default 1)
>         -t truncbdy: 4096 would make truncates page aligned (default 1)
>         -w writebdy: 4096 would make writes page aligned (default 1)
> 
> FALLOC_FL_WRITE_ZEROES comes under truncate. So I would assume we also
> do that. That is how I also found the issue with offset > EOF. I will
> take a look or else, I will add a test case to test this condition!

A targeted test using xfs_io that does FALLOC_FL_WRITE_ZEROES on an
unaligned range and then checks that the data around it is preserved
while the unaligned data in the range is zeroed would also be useful.


