Return-Path: <linux-api+bounces-6678-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TBjXDxkcPWqaxAgAu9opvQ
	(envelope-from <linux-api+bounces-6678-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 14:16:25 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 947066C5790
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 14:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=1CyM3fA6;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6678-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6678-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C69030AB4E6
	for <lists+linux-api@lfdr.de>; Thu, 25 Jun 2026 12:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521A63E00B4;
	Thu, 25 Jun 2026 12:12:41 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C373E009F;
	Thu, 25 Jun 2026 12:12:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389561; cv=none; b=E2DvzvIEpRiFUUkR3J/B4rbeNumagkp1R/nM93d1ivX00i358cK9MMsufGsMm6oCAuZ01wMd1NNCkVOO5Qzjl1WL2Q/h5S3WwAhXjhJ4uB+TL3uDwD2IWCN4M0hMUDiZpAIH73qzjIdtXK/jHYd+F4kN07EE+823We70yyopnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389561; c=relaxed/simple;
	bh=uFEp+qIlUPtG9+DByvkEOZubewNDhx7zt0VqPDAv8gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgl10Pg6XKX+Vyu8d0BKMWwHBpMcKJtprV1hXNKfDN7FXxVdvppQLsbLweQOR+vkm4vFg6WGuoa97GOyR6OnEgJut7BJRrq/81PcF2XTwufdrwSWqmPFETqIG9fYU8o119TZ8wgpqV0MMEHaUh45mV3OXzCxz6SYS5rVxQTGKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1CyM3fA6; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=svkW/aRLfGG744Tq4U8nr/u6yrPBiucq7dNM63t5Tmk=; b=1CyM3fA6L9AiK9520VvlMAjAbK
	A/PE8z+2ZQH0STTPOdEyxUtRFKhnivNX5wlY84XZpsPLfRN8gl4oG1hVSGPuvwqlsRP/HBYQTITcU
	ULykzx7o1/ORMS9SCKk3q90PaqBo48bS34jkiBiPEzsCZq7j+j5V7O6ah14/RZHT5GmMYDdw02qDp
	6Y+5KrtlMDLkY47GM8zHIWFrS1XnVfse5sSZfhkbUkaSRNk7mL5mH65XMBOKx8cl7Ry054mO652UC
	NW5Cfjir8XoHouknc86pHuU4wF32wpScpRQcURk9950tXXZ96/KjiTRkYhQtPNacg/qvXYRQcfKIs
	jtKQmwbA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wciwg-00000009AMQ-2E9H;
	Thu, 25 Jun 2026 12:12:38 +0000
Date: Thu, 25 Jun 2026 05:12:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org,
	bfoster@redhat.com, lukas@herbolt.com,
	"Darrick J . Wong" <djwong@kernel.org>, dgc@kernel.org,
	gost.dev@samsung.com, andres@anarazel.de, kundan.kumar@samsung.com,
	cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <aj0bNstaTvy3HOkh@infradead.org>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <557b2e5c-7c65-48de-87a9-6fba21eca99f@huaweicloud.com>
 <0b7f1a4f-da1c-4297-8099-98d738070ab7@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7f1a4f-da1c-4297-8099-98d738070ab7@huaweicloud.com>
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
	FORGED_RECIPIENTS(0.00)[m:yi.zhang@huaweicloud.com,m:pankaj.raghav@linux.dev,m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-6678-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 947066C5790

On Thu, Jun 25, 2026 at 07:16:47PM +0800, Zhang Yi wrote:
> I've thought about this more and feel that we need to add one more
> scenario here:
> 
> 3) If the blocks at the boundaries are in dirty unwritten or in delay
>    allocated state, it should be handled the same way as scenario 2.
>    Additionally, before returning, we need to flush these two boundary
>    blocks that have been partially zeroed, to ensure that after
>    FALLOC_FL_WRITE_ZEROES, all ranges are in the written state.
> 
> What do you think?

Yes.  Can you send an xfstest addition the exercises these corner
cases?


