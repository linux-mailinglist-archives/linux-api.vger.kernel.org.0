Return-Path: <linux-api+bounces-6635-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zVnEE2TyM2pEJgYAu9opvQ
	(envelope-from <linux-api+bounces-6635-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 15:28:04 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27A6A0808
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 15:28:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=X9ehMrBC;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6635-lists+linux-api=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-api+bounces-6635-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B66B130680EB
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 13:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBAB3DA5AF;
	Thu, 18 Jun 2026 13:26:40 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA39F3C345C
	for <linux-api@vger.kernel.org>; Thu, 18 Jun 2026 13:26:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781789200; cv=none; b=abiuO27ce7piNlFqGSnmg7/TrBMYSJ8JEZojBdsmfeidW6i4KBbnt86IGFRWDxENpJBHbxsJo8ZtEK4q/0dP2YPyMRAluC6vPfI/UPJ1krGRL1ZsyXhZ+v+A13EkMYkIQOau7ATWETv7wLtJXM9h2/zV+4qy2jAYhtZ7FV2N+2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781789200; c=relaxed/simple;
	bh=85FVe5eMXL0RXQE7ZBuauYhsUfQACOXhAjbKsfHTVm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeHObBqvTpgwRmmYvQ9H1YhB7QVziM1WFerLuSn+oDi79pue6gFaqgrbv/WtxOv2YOECme+oiZghFahaxX8Vo5HJWFbqk8hFS4tTNqkXciRVF5cSu/y1qVS4Kd1ksPHCobKC2ZgNhx6FltHGdJeYicHJ48Nn8djwv8MdiLLrnOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X9ehMrBC; arc=none smtp.client-ip=91.218.175.171
Date: Thu, 18 Jun 2026 15:26:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781789187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ykkxA0qJEUzQ0tfsBRheC21s+kMLf1SZIiy0Lrd0cQk=;
	b=X9ehMrBCC1ncXh+jowJQAjmQYteyVkHRoh4eFKUfvyV+3CVRPVVg42dMh+/pvn7FMUHYJT
	pq78jxwUC5SD4fTpbn2bEGljPQPzjliggUJl8Qa8D+LqwAf0QI9cq55xre86ReMrHDyEYx
	DgC2lsb13rfZtAUwLx0q+tyuaKoB4CE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org, 
	bfoster@redhat.com, lukas@herbolt.com, "Darrick J . Wong" <djwong@kernel.org>, 
	dgc@kernel.org, gost.dev@samsung.com, andres@anarazel.de, 
	kundan.kumar@samsung.com, cem@kernel.org, Zhang Yi <yi.zhang@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <xklmkbxoh7yfm5mkxxpp72wfifngzr2v4nfrn3lgzc57ep7nkj@louxc6z3gfmk>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <ajOzoBt_peOCtNUm@infradead.org>
 <au3yznolpebvd5vphmzv73fzosdy7bxrb45kv56n734jnwwj3l@43d7sqlef27k>
 <ajO8AHsMFolUQLra@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajO8AHsMFolUQLra@infradead.org>
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
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pankaj.raghav@linux.dev,linux-api@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:hch@infradead.org,m:p.raghav@samsung.com,m:linux-xfs@vger.kernel.org,m:bfoster@redhat.com,m:lukas@herbolt.com,m:djwong@kernel.org,m:dgc@kernel.org,m:gost.dev@samsung.com,m:andres@anarazel.de,m:kundan.kumar@samsung.com,m:cem@kernel.org,m:yi.zhang@huawei.com,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-6635-lists,linux-api=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:from_mime,louxc6z3gfmk:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E27A6A0808

On Thu, Jun 18, 2026 at 02:36:00AM -0700, Christoph Hellwig wrote:
> On Thu, Jun 18, 2026 at 11:28:15AM +0200, Pankaj Raghav (Samsung) wrote:
> > > But I guess not unaligned FALLOC_FL_WRITE_ZEROES?
> > 
> >         -r readbdy: 4096 would make reads page aligned (default 1)
> >         -t truncbdy: 4096 would make truncates page aligned (default 1)
> >         -w writebdy: 4096 would make writes page aligned (default 1)
> > 
> > FALLOC_FL_WRITE_ZEROES comes under truncate. So I would assume we also
> > do that. That is how I also found the issue with offset > EOF. I will
> > take a look or else, I will add a test case to test this condition!
> 
> A targeted test using xfs_io that does FALLOC_FL_WRITE_ZEROES on an
> unaligned range and then checks that the data around it is preserved
> while the unaligned data in the range is zeroed would also be useful.
> 


|----------|----------|----------|----------|----------|
           ^     ^    ^                     ^     ^    ^
           |     |    |                     |     |    |
           |   offset |                     |    end   |
           |          |                     |          |
	off_rd       off_ru              end_rd       end_ru


I wrote a simple test case for unaligned FALLOC_FL_WRITE_ZEROES. The
existing code **does not** overwrite any user data. Here is why:

- xfs_free_file_space (punch hole) punches inward (offset_ru -> end_rd)
  and zeroes out from (offset -> offset_ru) and (end_rd -> end) with
  xfs_zero_range

- Luckily, even though we consider offset_rd to end_ru in
  alloc_file_space, XFS_BMAPI_ZERO will skip zeroing already written
  edge blocks and only offset_ru -> end_rd are zeroed using unmap zero range.
  ( (offset -> offset_ru) -> EXT_NORM, (offset_ru -> end_rd) -> HOLE,
  (end_rd -> end) -> EXT_NORM)

I didn't think it through but the code still holds for these cases. This
might be the reason why fsx did not complain? I will also document this
in the patch.

But as you said, we need a xfstest for this boundary block checks in case
some behaviour changes in the future.

I guess apart from this, the only change is to address persisting data
when offset > old_size as sashiko reported.

Let me know what you think.
--
Pankaj

