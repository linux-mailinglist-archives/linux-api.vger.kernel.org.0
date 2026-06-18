Return-Path: <linux-api+bounces-6637-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6CcSL/r5M2oGKAYAu9opvQ
	(envelope-from <linux-api+bounces-6637-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 16:00:26 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2E06A0C1E
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 16:00:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=FIiBOsu+;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6637-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6637-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B76130075E9
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520B3ECBDA;
	Thu, 18 Jun 2026 13:58:23 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAF38D686;
	Thu, 18 Jun 2026 13:58:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781791103; cv=none; b=pFUr6pVhHZZFpeqOBs06qvbxcbrgg+gits818+jhlB2k1kBfPesmF5KTYAR5yh29l9HR9YB9OHCyFi46ch6pj+t4j+u/jIRQwCyRAgaKBpZEKupjtfE5tFWrT/v9a+qBtANtGnUof27ORfw8Fyv4iM5U+LPOzhgw9LPBRVW9Obo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781791103; c=relaxed/simple;
	bh=qA92zUOb3slrFKRM0dFudlh/bOkhEeVA8iMHOn638BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlN2dv++REJlrGXvjczlHwFFtJXCVpeO+yuXzxiMKlFfzOxEqJhcNw/f5QbEWfG8fyXcevx+oMjXm6iB6uZlByX09WxokfV4JIa/kHi7U/INcnmatiq/QXmkI+SlY5sEIdREaqFK38jN76zkwoYel1eV1zQAcc8NT53QIeErqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FIiBOsu+; arc=none smtp.client-ip=91.218.175.188
Date: Thu, 18 Jun 2026 15:57:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781791099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mr4LWNB/ttP0Z1Y1ct7LRrIF6oUiEjnkIFtWHFqubw0=;
	b=FIiBOsu+NhxRkAO5TyuJhoRWyLPV6Uy4tDdS1cUk7122raGGdgQ8NX333QM7uHlalgQfi/
	ryTKG/U/GKCFjjpunm4Jqn6qwmqCJ7JGwLWtv+YyeVj7NswhuzTvlYLZPRU7W4RXqkIYJ2
	nTs/YnnJwThzxSQLDy4Mk9OWzFLfiaM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org, 
	bfoster@redhat.com, lukas@herbolt.com, "Darrick J . Wong" <djwong@kernel.org>, 
	dgc@kernel.org, gost.dev@samsung.com, andres@anarazel.de, 
	kundan.kumar@samsung.com, cem@kernel.org, Zhang Yi <yi.zhang@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <4qxthszoqxeccbor7je2vdrgzsyz6omj32v6kiypl5ogrmbjpc@qsynowbvvaz3>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <ajOzoBt_peOCtNUm@infradead.org>
 <au3yznolpebvd5vphmzv73fzosdy7bxrb45kv56n734jnwwj3l@43d7sqlef27k>
 <ajO8AHsMFolUQLra@infradead.org>
 <xklmkbxoh7yfm5mkxxpp72wfifngzr2v4nfrn3lgzc57ep7nkj@louxc6z3gfmk>
 <ajP0sno47hihsCCo@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajP0sno47hihsCCo@infradead.org>
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
	TAGGED_FROM(0.00)[bounces-6637-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,linux.dev:from_mime,qsynowbvvaz3:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE2E06A0C1E

On Thu, Jun 18, 2026 at 06:37:54AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 18, 2026 at 03:26:14PM +0200, Pankaj Raghav (Samsung) wrote:
> > existing code **does not** overwrite any user data. Here is why:
> > 
> > - xfs_free_file_space (punch hole) punches inward (offset_ru -> end_rd)
> >   and zeroes out from (offset -> offset_ru) and (end_rd -> end) with
> >   xfs_zero_range
> 
> Ah, right.
> 
> > - Luckily, even though we consider offset_rd to end_ru in
> >   alloc_file_space, XFS_BMAPI_ZERO will skip zeroing already written
> >   edge blocks and only offset_ru -> end_rd are zeroed using unmap zero range.
> >   ( (offset -> offset_ru) -> EXT_NORM, (offset_ru -> end_rd) -> HOLE,
> >   (end_rd -> end) -> EXT_NORM)
> 
> Oh.  So this was lucky because of the corner cases.  I still think doing
> the proper alignment in the higher level code and only calling down for
> the area that we really want to zero would be benefitial here, if only
> to make the code easier to follow.

I agree. I will do the changes and document some of the nuances in the
code.

Thanks!

--
Pankaj

