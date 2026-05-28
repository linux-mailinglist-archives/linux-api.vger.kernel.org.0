Return-Path: <linux-api+bounces-6449-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GB4WLBKaGGr+lQgAu9opvQ
	(envelope-from <linux-api+bounces-6449-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 21:40:02 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1795F73B8
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D632E300D865
	for <lists+linux-api@lfdr.de>; Thu, 28 May 2026 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C632B128;
	Thu, 28 May 2026 19:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRYMFMMU"
X-Original-To: linux-api@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BFD2E7376;
	Thu, 28 May 2026 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779997003; cv=none; b=QyrA8Kl3FeenFqQN6bSpN72hKrm7eDL/neWrWyue/G8POPP3pbg8cpxOaV9w6wptPmHDrqx7fEmwUe7qWzF9X2iWy09UQTODyIUznqFhGYtslMCjs0cjHyhRvijswU9n82UofauLVA+rM8jrk5Yg07FTmASc+UGip6OYld/1VZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779997003; c=relaxed/simple;
	bh=uYi1cIkltyYzOWijhyEqtEDkhi3PAqid2t/90eHgCCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k6nKi7pGk7J/K0EEvgD50f0D3Z7qgITWOSOQK3C1AZ2wsXgAAUfMWXIrQUieAhLNN2NOK+nJk/SIJq7uCtpV0RLoxi1b4/alh4cc02E1Gnm98utipxstg+4VovBwCy2WYt4gIsBV9+mkkGV/ZRObuvUXmk2S6pewqdOSHG38SqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JRYMFMMU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8F0pWvXpBQ9tDTtRSJ6URm6g4dHDcnjjGX6VQLGXPyU=; b=JRYMFMMUmIt+Ltyl9sQbvX97s0
	VD5j57l9FIq6bZcWQ1EA8YYtzEb8jUOSu/8fH/b3sQlj1QaB0x44GaBPtu54kC9Av3dPePcxl3D4A
	43FDUmdVszYklFreqEVlN0De8B1nujQTrH5y2ar8ZqhIAvN2glKhvMyMprIAhMZARkir6P/qjsSzQ
	kaolzBR1PT40+KzPSjEVD/X9dbuyi+JafqY19ukDe1QGkC4hrzlV9jG3iwc5T+1dn+z853w+1JN+o
	/5pkqxjkyy7sTDODIoKT/ekB1z/gUnyq3u1QWM2ZulCTjl3jenUMU9GTVLV/xfn5shjyAsEQBBx4l
	iwYCMWxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSgX0-00000004mIh-1Q3T;
	Thu, 28 May 2026 19:36:38 +0000
Date: Thu, 28 May 2026 20:36:38 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahiZRpE593n4blxn@casper.infradead.org>
References: <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahTzHyHBL8t0iNBR@google.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-6449-lists,linux-api=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-api@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-api];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0B1795F73B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> Background
> ----------
> The primary use case is accelerating AI model loading, which demands
> exceptionally high sequential read speeds. In our benchmarks on embedded
> systems:
>  - Using high-order page allocations allows the system to saturate the
>    Universal Flash Storage (UFS) bandwidth, reaching 4 GB/s even at
>    medium-to-low CPU frequencies.
>  - In contrast, standard small folios cap performance at 2 GB/s.
> 
> The performance doubling stems directly from reducing CPU cycle overhead during
> memory allocation.

When you say "AI model loading", are you mmap()ing the file of weights,
or are you calling read() to load the file into anonymous memory?

This matters because for the first operation, you need to allocate folios
of PMD size in order to make best use of TLB entries.  For the second
operation, it's more important to iterate through the file quickly,
freeing folios behind you after you access them so they're available
for the next batch.

