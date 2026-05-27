Return-Path: <linux-api+bounces-6428-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JUjBAkSF2o12wcAu9opvQ
	(envelope-from <linux-api+bounces-6428-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 17:47:21 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7B75E7230
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 17:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFE4731970C5
	for <lists+linux-api@lfdr.de>; Wed, 27 May 2026 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CC342DFE6;
	Wed, 27 May 2026 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2y8R2Hx"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF563BBA0F;
	Wed, 27 May 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896354; cv=none; b=V+46A4eb8G1/TA9XRHEAyGtuTCAZ/p+BCAvm6aYboKEVpdte0PVMOK0QIy3bIkRE/Dz1cvuPz5eEP60wlpzjHbHPPGLKt9ZVCkZGkge21JYdZ1Qzg5GtGNDtWfvseBSxm9+wPMLqDgBfm3SviSKSqfM3T+VWAjXICed4+Kg4e3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896354; c=relaxed/simple;
	bh=JzGOKATj689Qz+Wq7aMY5bfR6An6qGKSqpNZvFGg96k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rx86UsDYPHlbXOpR/ToLpitLykt6M0E3zFCXuZf8EJBrRxY/r7yEGlJDCNZp4O25rpftJWdiYFeejcYiqGlGXMOyrm7McdhkiJaDo26XC8yfBvOjaDYubzdjlUxnyYq9OjOWXHdMUaApgRdW1Ng7gMqu5OxTtxHltuyfsY6hvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2y8R2Hx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F2C1F000E9;
	Wed, 27 May 2026 15:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779896353;
	bh=8tkayxaFR4WgUW5KlUVQBv4QvmTLYma6soAnDSL6BSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E2y8R2Hxn+xhvIjIcnHlTfkDkts7bsT+888M6AM9G1ambnFnv5F78FJW9QyRGRGyP
	 +aRJbaNxmsBPyVau+poW6nye8T7/U+loHiVz5VLG0NH4eQqPZIVTpQ6MnJ1nmjSCWj
	 REKXR2KOVHvb+ByZMnVAoWwowF6BgkNVf1mi6MbU6kSzNmdLk/YmtmMC3CRSUdEHBa
	 nHMONcPUwmFcN6IGk5LJmqKzzuAntrUhs2W2KFTt4tyMGx1pcLaoVfm8bCs67yMBHr
	 vilgqZaylNQsNnN73f7k0Z9EdAh0x0eeghvPX2zls+ciDqu/sdJd1KO1MDHLsw/DV4
	 ugSTcps09ILXQ==
Date: Wed, 27 May 2026 15:39:11 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Theodore Tso <tytso@mit.edu>, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Akilesh Kailash <akailash@google.com>,
	Christian Brauner <christian@brauner.io>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
Message-ID: <ahcQHziLARSzFtar@google.com>
References: <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ybmbjekuvzmaw4hmlxd7nxs546dqtwmxqxwyali74d6m3u7tat@b4q3japqnhrl>
 <ahYWKH9-ybDlZuJd@google.com>
 <psj3kr2gcze2yll5xdbvyyzxwcwhds5gh55poobpkfxrkpbgr7@ljdindismzd4>
 <ahZaScMpx19ZLQi4@google.com>
 <ahZlbQPzTUecMKGU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahZlbQPzTUecMKGU@casper.infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6428-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4F7B75E7230
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/27, Matthew Wilcox wrote:
> On Wed, May 27, 2026 at 02:43:21AM +0000, Jaegeuk Kim wrote:
> > Thanks for the context. To clarify a piece I missed earlier: the model pages
> > are also utilized for inference. Our data shows that larger chunks yield
> > higher inference speeds. Consequently, I required high-order pages to optimize
> > both read throughput and inference latency. I will halt my current efforts
> > and wait for alternative suggestions.
> 
> I think your efforts would be best directed towards general support for
> large folios in f2fs.  There's still 40+ places in f2fs that use a
> struct page, and converting them all to folios would be a great help.

Ok, I'll dive into it in priority, but it'll take some time since I think we'd
better to refactor some major data structures.

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

