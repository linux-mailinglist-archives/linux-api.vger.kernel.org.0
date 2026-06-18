Return-Path: <linux-api+bounces-6630-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rA2bERS0M2oRFQYAu9opvQ
	(envelope-from <linux-api+bounces-6630-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:02:12 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C25169EADE
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:02:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=PWIYxgl3;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6630-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6630-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D24583009E24
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 08:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0213B777F;
	Thu, 18 Jun 2026 08:59:21 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1A35AC18;
	Thu, 18 Jun 2026 08:59:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773161; cv=none; b=CJ+33Pt9Nevu4yoH//jdgabrMyVRFKQTqRrJYiZspX/+nJeUKzI08HcWl2ydo/LLtNZOZoOwIpEGy1yIwUlKfdgnM9Uum6AmLQ3cDKgMR6VDfRtCzDb/4avjEsDpis+m5Y3sLwnS3mxSE1BVJrU5vUOKThgPEFIJ1vMRdU+q2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773161; c=relaxed/simple;
	bh=v6pQZXAs9UpEBlJYlQQsCzG5T2POmZpYbsOZVCT4vOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCDW3Ug5AYJeXLtI8aDtNwABHOlqPi6BoGhpOSy0H/8YewGVCEQy7eYkb/YMMGalo1MzTvfkYtqxK2kmSV7Izdg+nwysR9HDRzF6WLngsNTcvvJAjESDgYk49jcGNJWRjH76MyPRIQTE8J6gasHwvtvmNJ+RFAZdwQKT/3Fveag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PWIYxgl3; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=TMdTlnQWOCQk+DM25bXY+39Q+J1e9amcG79qXlD1w2g=; b=PWIYxgl3oX8Fea0U/ybb/Lasxv
	x5Ki1YCwu95oMnKbBFNEeBaFORdVbm4XkH0Jv1ltXFDJI1OnJQQ0NdCDc47JfgxniHf4g4HfJvMKS
	sa+eEqRBiKMv0J6IXF0oYwaNdh9Z5GF6rHRKn/mMLaqclY57luEfiD0ITTI1Ik7XVp7t5g12Z3jVL
	E05jQtUX++xJd461e0uaTR7h6QxGsCSA3+2lIO3jasOZRU7HGYoI8JG0n954bxKKCudsw1eTm0Xut
	iop2ti6d510sCpENdiZbOcBHKKari5hKuCqGlhj4gzfDMgC0CekgBOpxhmexgv+rTn+3BHd2Uy4Te
	kxDfusvw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wa8ak-00000000t5e-3Jmi;
	Thu, 18 Jun 2026 08:59:18 +0000
Date: Thu, 18 Jun 2026 01:59:18 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org,
	bfoster@redhat.com, lukas@herbolt.com,
	"Darrick J . Wong" <djwong@kernel.org>, dgc@kernel.org,
	gost.dev@samsung.com, andres@anarazel.de, kundan.kumar@samsung.com,
	cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <ajOzZv7407w_hodk@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:yi.zhang@huaweicloud.com,m:pankaj.raghav@linux.dev,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@infradead.org,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-6630-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1C25169EADE

On Thu, Jun 18, 2026 at 11:22:45AM +0800, Zhang Yi wrote:
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

Yes.

> Regarding the second point, the current ext4 implementation has an issue —
> it zeroes out the entire boundary blocks. I overlooked this previously, and
> I appreciate you pointing it out.

Which means we're missing test coverage for this as well..


