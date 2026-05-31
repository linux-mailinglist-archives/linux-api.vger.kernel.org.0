Return-Path: <linux-api+bounces-6467-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF0cAFeCG2r7DgkAu9opvQ
	(envelope-from <linux-api+bounces-6467-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 02:35:35 +0200
X-Original-To: lists+linux-api@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 50370614056
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 02:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C876303131A
	for <lists+linux-api@lfdr.de>; Sun, 31 May 2026 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9F123ABB9;
	Sun, 31 May 2026 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d53H0TLH"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818A922ACEB;
	Sun, 31 May 2026 00:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780187730; cv=none; b=SftGt3APDiEVXbTLWn3aHs7hAQWBgNIldG+2bJbS6wEaY0GHwipmWRNJiDYXhGvudqyRVK0O9dS7611zC1SKKARN6+m0ZH4tLoDIPe7aXTOd7QyOzIoZzXmwzTdsM1/ufeIFRZVxUjDv6cM2l2dogRYMZwO7H1hRnj8clCGherg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780187730; c=relaxed/simple;
	bh=ua6nfT0obm5wkaI0I0ksba9L04jpDgP1XQxgrhPSutY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQbBqcYQjPKmdOYJTvPw8MT5JRqm7xUbKYqm2tiauERwK+6fZoxs8Ty4Bih4kalUqOLYSWPFqALq1B3EA08Gqf8518R7hiYmhBHf7VASziLNEebV58/uSE66m4jNL1vSVgZ/TDWnFxkcJATilIRCbNjN7lLqiNHhioyp/8SmqsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d53H0TLH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0179E1F00893;
	Sun, 31 May 2026 00:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780187729;
	bh=c8RBaPvCP6ZMekNwxeunAIbpIE5CulD2vhb0civMEuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d53H0TLHSiX4+p2qwlrpbYNSkQr89x9B3WOu78Q9gI0I8WEUkK4/F0Zh3HERksKXa
	 hg3haxL1FnZcxondubwZwSNMfqkYHFUlb1pVtumAOLYPxzg9iYQ0pDorDrMaBgKOD/
	 19SMFIXoJdy9v1FI3zZfF9v/cgA9sSj7H7cQk2XdS8zrPotiR+MuiE0Uv2MC7VN0Oj
	 D9qPYvBnffngDkemA2x1OvI+zzU9n1afjMGdGZN9X7wZzeaN3mSqLcp9+AZOQIZICx
	 RomPOo2yIKZt95Ctpt1mPpJrInk8xy5K7p3NidJmIZRd+riM76W06RmR+UlHx97mfR
	 4qsbhgJyW6jMA==
Date: Sun, 31 May 2026 00:35:27 +0000
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
Message-ID: <ahuCTzdbvhCBJzcl@google.com>
References: <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
 <ag7HfNryTmQ-bVIS@infradead.org>
 <20260521155748.GA79343@macsyma-wired.lan>
 <ag_OVwPF49LSZ7rz@google.com>
 <20260522141115.GA8258@macsyma-wired.lan>
 <ahCNmWbcd_2lAJyk@google.com>
 <20260522224108.GA18663@macsyma-wired.lan>
 <ahTzHyHBL8t0iNBR@google.com>
 <ahiZRpE593n4blxn@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahiZRpE593n4blxn@casper.infradead.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6467-lists,linux-api=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaegeuk@kernel.org,linux-api@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-api];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 50370614056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 05/28, Matthew Wilcox wrote:
> On Tue, May 26, 2026 at 01:10:55AM +0000, Jaegeuk Kim wrote:
> > Background
> > ----------
> > The primary use case is accelerating AI model loading, which demands
> > exceptionally high sequential read speeds. In our benchmarks on embedded
> > systems:
> >  - Using high-order page allocations allows the system to saturate the
> >    Universal Flash Storage (UFS) bandwidth, reaching 4 GB/s even at
> >    medium-to-low CPU frequencies.
> >  - In contrast, standard small folios cap performance at 2 GB/s.
> > 
> > The performance doubling stems directly from reducing CPU cycle overhead during
> > memory allocation.
> 
> When you say "AI model loading", are you mmap()ing the file of weights,
> or are you calling read() to load the file into anonymous memory?
> 
> This matters because for the first operation, you need to allocate folios
> of PMD size in order to make best use of TLB entries.  For the second
> operation, it's more important to iterate through the file quickly,
> freeing folios behind you after you access them so they're available
> for the next batch.

We deal with multiple options tho, what I'm looking at is mostly a preloading
models by mmap(MAP_POPULATE) which takes the readahead path bumping up the order
by 2. Previously I also looked at fadvise(WILLNEED), but gave up due to the
broken interface. OTOH, we use RWF_DONTCACHE for read() case, but I don't
think it's ideal for the best loading performance.

> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

