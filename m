Return-Path: <linux-api+bounces-6632-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u4Z/F/26M2pBFgYAu9opvQ
	(envelope-from <linux-api+bounces-6632-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:31:41 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB4A69EE45
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 11:31:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=A2Rkn0JF;
	spf=pass (mail.lfdr.de: domain of "linux-api+bounces-6632-lists+linux-api=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-api+bounces-6632-lists+linux-api=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4093530EFEEB
	for <lists+linux-api@lfdr.de>; Thu, 18 Jun 2026 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7273CEB9A;
	Thu, 18 Jun 2026 09:28:38 +0000 (UTC)
X-Original-To: linux-api@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664213CBE96
	for <linux-api@vger.kernel.org>; Thu, 18 Jun 2026 09:28:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781774918; cv=none; b=lrno7Y7dsEoBxbk88Z6mCRZNcVFKcb7OAqLcTxebxNm8yjdHmUO6L5irIv6o6bq+09Qe89brH69D3wvKYswQIYIp+8BTvnsDs6Rfn90J0awOPuou8IhwucozIr878dizpc518sTX/psTGHqBKlbejv0PtUELIe4KZ3o9uMec5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781774918; c=relaxed/simple;
	bh=Imqd3PMwxob70q733lh+Zcw/+83hIq+TAuSRfoyvU2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nIXKY9v4jqCGG/jbyPkZW6M6W3CoqyHdgCskFsssYCNAfjopiJKhykg19wxLiS0njHloPgdtIJbRvrHdRl/4HTozjHC467iMuua634sz/3AZKDCV/y7drZe9w9z+EmNQQVS6NcFHcdZuEH+K88XzU1qmakHFEHs+fkOrDZTdJSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A2Rkn0JF; arc=none smtp.client-ip=95.215.58.176
Date: Thu, 18 Jun 2026 11:28:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781774905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4shRaP6IA88GTRNtOJcUJssU4CN4YUqzVDciqr0Xkg=;
	b=A2Rkn0JFU7ADX30BhVsjhDn7N+Qrd2IDoutoi3fKDjqki/2rKC5IVOjmEMGK9pxjMkscvP
	a1JEkd/g1OBjLB1RM3yPD95foCpDI7dmpLAvqQk/I2E/Rp3y+69M4fYlCh2Ygx7/AobLMS
	0e5YRCk2NSynwVy3XFMtZnNPqKiOCZU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Pankaj Raghav (Samsung)" <pankaj.raghav@linux.dev>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pankaj Raghav <p.raghav@samsung.com>, linux-xfs@vger.kernel.org, 
	bfoster@redhat.com, lukas@herbolt.com, "Darrick J . Wong" <djwong@kernel.org>, 
	dgc@kernel.org, gost.dev@samsung.com, andres@anarazel.de, 
	kundan.kumar@samsung.com, cem@kernel.org, Zhang Yi <yi.zhang@huawei.com>, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v6 3/3] xfs: add support for FALLOC_FL_WRITE_ZEROES
Message-ID: <au3yznolpebvd5vphmzv73fzosdy7bxrb45kv56n734jnwwj3l@43d7sqlef27k>
References: <20260611114029.176200-4-p.raghav@samsung.com>
 <ajFQPANpajmFuKpi@infradead.org>
 <kn5dyqdxmsydibpfcurgpom5vwqtwinrz27oenh4pekks6ybdj@wyi4zkh7mogy>
 <ajOzoBt_peOCtNUm@infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajOzoBt_peOCtNUm@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
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
	TAGGED_FROM(0.00)[bounces-6632-lists,linux-api=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,43d7sqlef27k:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAB4A69EE45

On Thu, Jun 18, 2026 at 02:00:16AM -0700, Christoph Hellwig wrote:
> On Wed, Jun 17, 2026 at 11:44:47AM +0200, Pankaj Raghav (Samsung) wrote:
> > > Maybe we also want xfstests that try unaligned FALLOC_FL_WRITE_ZEROES
> > > and make sure no existing data before the range is lost and the
> > > entire range is zeroed?
> > > 
> > 
> > I added FALLOC_FL_WRITE_ZEROES support to ltp (both fsx and fsstress).
> > For example, generic/363 tests for unaligned writes and checks for any
> > stale data. By default, I think we do unaligned reads, writes and
> > truncate in fsx.
> 
> But I guess not unaligned FALLOC_FL_WRITE_ZEROES?

        -r readbdy: 4096 would make reads page aligned (default 1)
        -t truncbdy: 4096 would make truncates page aligned (default 1)
        -w writebdy: 4096 would make writes page aligned (default 1)

FALLOC_FL_WRITE_ZEROES comes under truncate. So I would assume we also
do that. That is how I also found the issue with offset > EOF. I will
take a look or else, I will add a test case to test this condition!

Thanks.
--
Pankaj

