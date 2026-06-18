Return-Path: <linux-api+bounces-6636-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wRarMRX1M2oLJwYAu9opvQ
	(envelope-from <linux-api+bounces-6636-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 15:39:33 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AB46A0A2A
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 15:39:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=zZAxIleu;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6636-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6636-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 292A3302351A
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CA939FCC4;
	Thu, 18 Jun 2026 13:37:59 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6057235AC0E;
	Thu, 18 Jun 2026 13:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789879; cv=none; b=KR2hnC5m+qssfMSfO5O2OMKcABlB8vAnokzOkuujbTKk2yorJfpFkVXJiwYnclYI3iAqaR2GKCXGDoRBf1yIIF8kFT1CHB+g2VxJxen3e4Nd4vAJ4EXGxJP0qoJcK8mLDsH/VVZXteUMt3h+b+hWt3Ad0RG+POazZmEQy2DL3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789879; c=relaxed/simple;
	bh=UkvLba/yQOEQk/SDAaG+MSWSjZyeNGYNhBPM649RQKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3WJhFA6UrlGUwO80ULrPobgQdQOw4PTFdcvbtw0nlZgQoT3lLop5tDrAnjqsViGCtqoLw/tbmnJfQOt7rlmk7pTdF0+9b2v1h2ZV9iMDA/Ervbxg/cS3rU0GIFoO50FOh/Yr661vMahQ/JX2MEgNszfJA2qh86S7wzsWEYmqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zZAxIleu; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wB2xhgFp3sV+5nZLtB21rmhDHo5MBvFjgbseRuTDodY=; b=zZAxIleutLFLTzsj6vomq6P7oO
	WZZNAwLlo2C3jG5xcttdqV3sJD7fv4nyEP7Fw/BrldCsdHv+l8yCx56Tt2jxsWIpJGcKnHpasEtG/
	U4qy/xlpSkGHmFUENO/YwrRplBhRlMxL4kIoJx4XAPVBHk9mP0ouf4D73ovEDOyRxVzZhm2VYQqD5
	lKGRxNNPNfcfbyoRci877motPrl28k/sYFykAiqvkfHG4rXd1NXFPAL3zYXLyWSaie+k5RUQSUho6
	t5xhMBf2hYyJSwMlV4mz8JeQ5lQppdTsfsG0+lo+lgRX+eysy8ATgStx/3EU1Wkrm33yHJ6+GzmFp
	yiEJYrHA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1waCwM-00000001NH6-2VIe;
	Thu, 18 Jun 2026 13:37:54 +0000
Date: Thu, 18 Jun 2026 06:37:54 -0700
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
Message-ID: <ajP0sno47hihsCCo@infradead.org>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <ajOzoBt_peOCtNUm@infradead.org>
 <au3yznolpebvd5vphmzv73fzosdy7bxrb45kv56n734jnwwj3l@43d7sqlef27k>
 <ajO8AHsMFolUQLra@infradead.org>
 <xklmkbxoh7yfm5mkxxpp72wfifngzr2v4nfrn3lgzc57ep7nkj@louxc6z3gfmk>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xklmkbxoh7yfm5mkxxpp72wfifngzr2v4nfrn3lgzc57ep7nkj@louxc6z3gfmk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pankaj.raghav@linux.dev,m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:yi.zhang@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-6636-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18AB46A0A2A

On Thu, Jun 18, 2026 at 03:26:14PM +0200, Pankaj Raghav (Samsung) wrote:
> existing code **does not** overwrite any user data. Here is why:
> 
> - xfs_free_file_space (punch hole) punches inward (offset_ru -> end_rd)
>   and zeroes out from (offset -> offset_ru) and (end_rd -> end) with
>   xfs_zero_range

Ah, right.

> - Luckily, even though we consider offset_rd to end_ru in
>   alloc_file_space, XFS_BMAPI_ZERO will skip zeroing already written
>   edge blocks and only offset_ru -> end_rd are zeroed using unmap zero range.
>   ( (offset -> offset_ru) -> EXT_NORM, (offset_ru -> end_rd) -> HOLE,
>   (end_rd -> end) -> EXT_NORM)

Oh.  So this was lucky because of the corner cases.  I still think doing
the proper alignment in the higher level code and only calling down for
the area that we really want to zero would be benefitial here, if only
to make the code easier to follow.


